?<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src="../script/qbox.js" type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "vcca";
        var decbbs = ['mount', 'price', 'total', 'tax'];
        var decbbm = ['money', 'tax', 'total'];
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [['txtPrice', 10, 3]];  // ���\ key �p��
        var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        //ajaxPath = ""; // �u�b�ڥؿ�����A�~�ݳ]�w
		aPop = new Array(['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtComp2', 'acomp_b.aspx'],['txtCustno', 'btnCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  // �p�� �X�A  brwCount 
            q_gt(q_name, q_content, q_sqlCount, 1)  /// q_sqlCount=�̫e�� top=���ơA q_init �����J q_sys.xml �P q_LIST
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  /// ���J��ƿ��~
            {
                dataErr = false;
                return;
            }

            mainForm(1); // 1=�̫�@��  0=�Ĥ@��
        }  

       /* aPop = [['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtStoreno2', 'btnStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx', "60%", "650px", q_getMsg('popStore')],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];*/

        function mainPost() { // ���J��Ƨ��A�� refresh �e
            fbbm[fbbm.length] = 'txtMemo'; 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
             // �ݦb main_form() �����A�~�|���J �t�ΰѼ�
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 /// �d�ߵ����B�Ȥ�����B��������  �����ɰ���
            var ret;
            switch (b_pop) {   /// ���n�G���i�H���� return �A�̫�ݰ��� originalClose();
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  /// ��ƤU���� ...
            switch (t_name) {
                case q_name: if (q_cur == 4)   // �d��
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // �ˬd�ť� 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// �۰ʲ��ͽs��
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('cng_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// �u�� comb �}�Y�A�~�ݭn�g onChange()   �A��l cmb �s����Ʈw
        }

        function bbsAssign() {  /// ���B�⦡
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   /// �� �g�J��Ʈw�e�A�g�J�ݭn���
            if (!as['productno'] && !as['product']) {  //���s�ɱ���
                as[bbsKey[1]] = '';   /// no2 ���šA���s��
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];

            //            t_err ='';
            //            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
            //                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

            //            
            //            if (t_err) {
            //                alert(t_err)
            //                return false;
            //            }
            //            
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j

        }
        function refresh(recno) {
            _refresh(recno);

        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            if (q_tables == 's')
                bbsAssign();  /// ���B�⦡ 
        }

        function q_appendData(t_Table) {
            return _q_appendData(t_Table);
        }

        function btnSeek() {
            _btnSeek();
        }

        function btnTop() {
            _btnTop();
        }
        function btnPrev() {
            _btnPrev();
        }
        function btnPrevPage() {
            _btnPrevPage();
        }

        function btnNext() {
            _btnNext();
        }
        function btnNextPage() {
            _btnNextPage();
        }

        function btnBott() {
            _btnBott();
        }
        function q_brwAssign(s1) {
            _q_brwAssign(s1);
        }

        function btnDele() {
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
    </script>
    <style type="text/css">
        #dmain{overflow:hidden;}
		 .dview{float:left;width:25%;}
		 .tview{margin:0;padding:2px;border:1px black double;border-spacing:0;font-size:16px;background-color:#FFFF66;color:blue;}
		 .tview td{padding:2px;text-align:center;border:1px black solid;}
		 .dbbm{float:left;width:73%;margin:-1px;border:1px black solid;border-radius:5px;}
		 .tbbm{padding:0px;border:1px white double;border-spacing:0;border-collapse:collapse;font-size:16px;color:blue;background:#cad3ff;width:100%;}
		 .tbbm tr{height:35px;}
		 
		 .td1, .td3, .td5{width: 11%; text-align: right;}
		 .td2, .td4, .td6{width: 14%;}
		 .tbbm tr td span{float:right;display:block;width:8px;height:10px;}
		 .tbbm tr td .lbl{float:right;color:blue;font-size:16px;}
		 .tbbm tr td .lbl.btn{color:#4297D7;font-weight:bolder;}
		 .tbbm tr td .lbl.btn:hover{color:#FF8F19;}
		 .tbbm tr td .txt.c1{width:100%;float:left;}
		 .tbbm tr td .txt.c5{width:35%;float:left;}
		 .tbbm tr td .txt.c6{width:64%;float:left;}
		 .txt.num{text-align:right;}
		 .txt.c7{width:96%;text-align: right;}
		 .txt.c8{width:98%;}
		 .ch1{width: 8%;}
		 .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:16px;color:blue;background:#cad3ff;width:100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
		
		 .dbbm input[type="button"]{float:right;width:auto;font-size: medium;}
		 .tbbm tr td{margin:0px -1px;padding:0;}
		 .tbbm tr td input[type="text"]{border-width:1px;padding:0px;margin:-1px;}
		 .tbbm tr td select{border-width:1px;padding:0px;margin:-1px;width: 98%;}
       
      
    </style>
    </head>
<body>
<!--#include file="../inc/toolbar.inc"-->
 <div id='dmain'>
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='datea'>~datea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
               <td class="td1"><span> </span><a id='lblDatea'></a></td>
               <td class="td2"><input id="txtDatea"  type="text"  class="txt c1"/></td>
               <td class="td3"><span> </span><input id="btnCust" type="button" ></td>
               <td class="td4" colspan="3"><input id="txtCustno"  type="text"  class="txt c5"/>             
             <input id="txtComp" type="text"  class="txt c6"/></td>
        </tr>
        <tr class="tr2">
            <td class="td1"><span> </span><a id='lblNoa'></a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id='lblAddress'> </a></td>
            <td class="td4" colspan="3"><input id="txtAddress"  type="text" class="txt c8"/></td>  
        </tr>
        <tr class="tr3">
            <td class="td1"><span> </span><a id='lblSeria'></a></td>
            <td class="td2"><input id="txtSeria" type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id='lblMon'> </a></td>
            <td class="td4"><input id="txtMon"  type="text" class="txt c1"/></td>                                
        </tr>
        <tr class="tr4">
            <td class="td1"><span> </span><input id="btnAcomp" type="button" /></td>
            <td class="td2" colspan="3"><input id="txtCno" class="txt c5"/>
            <input id="txtComp2" type="text"  class="txt c6"/></td> 
        </tr>
        <tr class="tr5">
            <td class="td1"><span> </span><a id='lblChkno'></a></td>
            <td class="td2"><input id="txtChkno"  type="text" class="txt c1" /></td>
            <td class="td3"><span> </span><a id='lblMoney'></a></td>
            <td class="td4"><input id="txtMoney"  type="text"  class="txt num c1"/></td>            
            <td class="td5"><span> </span><a id='lblTax'></a></td>
            <td class="td6"><input id="txtTax"  type="text"  class="txt num c8"/></td>                                   
        </tr>
        <tr class="tr6">
            <td class="td1"><span> </span><a id='lblTaxtype'></a></td>
            <td class="td2"><input id="txtTaxtype"  type="text"  class="txt c1"/></td>
             <td class="td3"><span> </span><a id='lblTotal'> </a></td>
            <td class="td4"><input id="txtTotal"  type="text"  class="txt num c1"/></td>      
        </tr>
        <tr class="tr7">
            <td class="td1"><span> </span><a id="lblMemo" ></a></td>
            <td class="td2" colspan='5'><textarea id="txtMemo" rows="5" cols="10" style="width: 98%;height: 127px;"></textarea></td>
        </tr>
         <tr class="tr8">
            <td class="td1"><span> </span><a id='lblAccno'></a></td>
            <td class="td2"><input id="txtAccno"  type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id='lblBuyer'> </a></td>
            <td class="td4"><input id="txtBuyer"  type="text"  class="txt c1"/></td>
        </tr>
        <tr class="tr9">
            <td class="td1"></td>
            <td class="td2"></td>
            <td class="td3"></td>
            <td class="td4"></td>
            <td class="td5"><span> </span><a id='lblWorker'></a></td>
            <td class="td6"><input id="txtWorker"  type="text"  class="txt c8"/></td>
        </tr>
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="ch1"><a id='lblProductno'></a></td>
                <td align="center" style="width: 20%;"><a id='lblProduct'></a></td>
                <td align="center" class="ch1"><a id='lblUnit'></a></td>
                <td align="center" class="ch1"><a id='lblMount'></a></td>
                <td align="center" class="ch1"><a id='lblPrice'></a></td>
                <td align="center" class="ch1"><a id='lblTotals'></a></td>
                <td align="center" class="ch1"><a id='lblTaxs'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input style="width: 80%;" id="txtProductno.*" type="text" /><input id="btnProductno.*" type="button" value=".." style="width: 15%;" /></td>
                <td ><input class="txt c8" id="txtProduct.*" type="text" /></td>
                <td ><input class="txt c8" id="txtUnit.*" type="text" /></td>
                <td ><input class="txt c7" id="txtMount.*" type="text" /></td>
                <td ><input class="txt c7" id="txtPrice.*" type="text" /></td>
                <td ><input class="txt c7" id="txtTotal.*"type="text" /></td>
                <td ><input class="txt c7" id="txtTax.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
