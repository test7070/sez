<%@ Page Language="C#" AutoEventWireup="true" %>
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
        var q_name = "umm";
        var decbbs = ['money', 'paysale', 'chgs','moneyus', 'paysaleus', 'chgsus'];
        var decbbm = ['sale', 'paysale', 'nextsale','total', 'floata', 'opay', 'unopay', 'totalus', 'paysaleus', 'nextsaleus', 'outsource'];
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [['txtPrice', 10, 3]];  
        var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],['txtCustno', 'btnCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
           q_gt(q_name, q_content, q_sqlCount, 1)  
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  
            {
                dataErr = false;
                return;
            }

            mainForm(1); 
        }  

     /*   aPop = [['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtStoreno2', 'btnStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx', "60%", "650px", q_getMsg('popStore')],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];*/

        function mainPost() {
            
            fbbm[fbbm.length] = 'txtMemo';  
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
             
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('cng_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
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

        function bbsSave(as) {
            if (!as['type'] ) {  
                as[bbsKey[1]] = '';   
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

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
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
                bbsAssign();  /// 表身運算式 
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
		 
		 .td1, .td3, .td5{width: 10%; text-align: right;}
		 .td2, .td4, .td6{width: 15%;}
		 .tbbm tr td span{float:right;display:block;width:8px;height:10px;}
		 .tbbm tr td .lbl{float:right;color:blue;font-size:16px;}
		 .tbbm tr td .lbl.btn{color:#4297D7;font-weight:bolder;}
		 .tbbm tr td .lbl.btn:hover{color:#FF8F19;}
		 .tbbm tr td .txt.c1{width:98%;float:left;}
		 .tbbm tr td .txt.c2{width:50%;float:left;}
		 .tbbm tr td .txt.c3{width:47%;float:left;}
		 .tbbm tr td .txt.c4{width:53%;float:left;}
		 .tbbm tr td .txt.c5{width:35%;float:left;}
		 .txt.c6{width:64%;float:left;}
		 .tbbm tr td .txt.num{text-align:right;}
		 .txt.c7{width:96%;text-align: right;}
		 .txt.c8{width:98%;}
		
		 .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:16px;color:blue;background:#cad3ff;width:100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
		
		 .dbbm input[type="button"]{float:right;width:auto;font-size: medium;}
		 .tbbm tr td{margin:0px -1px;padding:0;}
		 .tbbm tr td input[type="text"]{border-width:1px;padding:0px;margin:-1px;}
		 .tbbm tr td select{border-width:1px;padding:0px;margin:-1px;width: 98%;}
      	 .tbbs .td1{width: 4%;}
      	 .tbbs .td2{width: 6%;}
      	 .tbbs .td3{width: 8%;}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='cno acomp'>~cno ~acomp</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
               <td class="td1" ><span> </span><a id='lblNoa' ></a></td>
               <td class="td2" ><input id="txtNoa" type="text" class="txt c1"/></td> 
               <td class="td3" ><span> </span><a id='lblDatea'></a></td>
               <td class="td4" ><input id="txtDatea" type="text" class="txt c1"/></td>
               <td class="td5" ><span> </span><a id='lblMon' ></a></td>
               <td class="td6"><input id="txtMon" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
               <td class="td1" ><span> </span><input id="btnAcomp" type="button" /></td>
               <td class="td2" ><input id="txtCno"  type="text" class="txt c5"/>
               <input id="txtAcomp"    type="text" class="txt c6"/></td>                
               <td class="td3"><span> </span><a id='lblWorker'></a></td>
               <td class="td4" ><input id="txtWorker"  type="text" class="txt c1"/></td> 
            </tr>
           <tr>
                <td class="td1"><span> </span><input id="btnCust" type="button" /></td>
                <td class="td2"><input id="txtCustno" type="text" class="txt c5"/>
                <input id="txtComp"  type="text" class="txt c6"/></td>
                <td class="td3"><span> </span><a id='lblPayc'></a></td>
                <td class="td4"><input id="txtPayc" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
                <td class="td1"><span> </span><a id='lblVdate'></a></td>
                <td class="td2"><input id="txtVbdate" type="text" class="txt c2"/> 
                <input id="txtVedate" type="text" class="txt c2" /></td> 
                <td class="td3"><span> </span><a id='lblCno2'></a></td>
                <td class="td4"><input id="txtCno2" type="text" class="txt c2"/>
                <input id="txtAccno2"  type="text" class="txt c2"/></td>
                <td class="td5"><span> </span><a id='lblAccno'></a></td>
                <td class="td6"><input id="txtAccno"  type="text" class="txt c1"/></td> 
             </tr>
            <tr>
                <td class="td1"><span> </span><a id='lblTotal'></a></td>
                <td class="td2"><input id="txtTotal" type="text" class="txt num c1"/></td> 
                <td class="td3"><span> </span><a id='lblPaysale'></a></td>
                <td class="td4"><input id="txtPaysale"  type="text" class="txt num c1"/></td> 
                <td class="td5"><span> </span><a id='lblNextsale'></a></td>
                <td class="td6"><input id="txtNextsale"  type="text" class="txt num c1"/></td> 
            </tr>
            <tr>
                <td class="td1"><span> </span><a id='lblOutsource'></a></td>
                <td class="td2"><input id="txtOutsource"  type="text" class="txt num c1"/></td> 
            </tr>
            <tr><td class="td1"><span> </span><a id='lblMemo'></a></td>
                <td class="td2" colspan='7' ><textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height: 127px;" ></textarea></td>
                </tr>
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 100%;" >
             <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td3"><a id='lblTypea'></a></td>
                <td align="center" class="td2"><a id='lblMoney'></a></td>
                <td align="center" class="td2"><a id='lblChgs'></a></td>
                <td align="center" class="td2"><a id='lblPaysales'></a></td>
                <td align="center" class="td1"><a id='lblMons'></a></td>
                <td align="center" class="td3"><a id='lblPart'></a></td>
                <td align="center" class="td2"><a id='lblUmmbno'></a></td>
                <td align="center" class="td3"><a id='lblUmmb'></a></td>
                <td align="center" class="td3"><a id='lblCheckno'></a></td>
                <td align="center" class="td3"><a id='lblAccount'></a></td>
                <td align="center" class="td3"><a id='lblBankno'></a></td>
                <td align="center" style="width: 12%;"><a id='lblBank'></a></td>
                <td align="center" class="td2"><a id='lblIndate'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td><input class="txt c8"  id="txtTypea.*" type="text" /></td>
                <td><input class="txt c7" id="txtMoney.*" type="text" /></td>
                <td><input class="txt c7" id="txtChgs.*" type="text" /></td>
                <td><input class="txt c7" id="txtPaysale.*" type="text" /></td>
                <td><input class="txt c8" id="txtMon.*" type="text" /></td>
                <td><input  id="txtPartno.*" type="text"  style="width: 30%;"/><input id="txtPart.*" type="text" style="width: 55%;"/></td>
                <td><input class="txt c8" id="txtUmmbno.*" type="text" /></td>
                <td><input class="txt c8" id="txtUmmb.*" type="text"  /></td>
                <td><input class="txt c8" id="txtCheckno.*" type="text" /></td>
                <td><input class="txt c8" id="txtAccount.*" type="text" /></td>
                <td><input class="txt c6" id="txtBankno.*" type="text" /><input id="btnBankno.*" type="button" value="." /></td>
                <td><input class="txt c8" id="txtBank.*" type="text"  /></td>
                <td><input class="txt c8" id="txtIndate.*" type="text"  /></td>
                <td><input class="txt c8" id="txtMemo.*" type="text"  />
                <input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
