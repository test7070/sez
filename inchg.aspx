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
        var q_name = "inchg";
        var decbbs = ['usprice', 'float', 'container', 'weight', 'worker', 'docn', 'arrange', 'insurance', 'import', 'checkn', 'trans', 'hang', 'erele', 'docn2', 'tax', 'total'];
        var decbbm = [];
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
		aPop = new Array(['txtCustno', 'btnCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'],['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']);        

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

    /*    aPop = [['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
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
            if (!as['date2'] ) {  
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
                bbsAssign();  
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
 #dmain {overflow: hidden;}
            .dview {float: left;width: 25%;}
            .tview {margin: 0;padding: 2px;border: 1px black double;border-spacing: 0;font-size: 16px;background-color: #FFFF66;color: blue;}
            .tview td {padding: 2px;text-align: center;border: 1px black solid;}
            .dbbm {float: left;width: 73%;margin: -1px;border: 1px black solid;border-radius: 5px;}
            .tbbm {
                padding: 0px;
                /*border: 1px white double;
                 border-spacing: 0;
                 border-collapse: collapse;*/
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr .td1, .tbbm tr .td3, .tbbm tr .td5, .tbbm tr .td7 {
                width: 10%;
            }
            .tbbm tr .td2, .tbbm tr .td4, .tbbm tr .td6, .tbbm tr .td8 {
                width: 10%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: 16px;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .tbbm tr td .txt.c1 {
                width: 100%;
                float: left;
            }
            .tbbm tr td .txt.c2 {
                width: 45%;
                float: left;
            }
            .tbbm tr td .txt.c3 {
                width: 55%;
                float: left;
            }
            .tbbm tr td .txt.c4 {
                width: 60%;
                float: left;
            }
            .tbbm tr td .txt.c5 {
                width: 40%;
                float: left;
            }
            .tbbm tr td .txt.num {
                text-align: right;
            }
            .txt.num {
                text-align: right;
            }
            td {
                margin: 0px -1px;
                padding: 0;
            }
            td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            td input[type="button"] {
                width: auto;
                font-size:medium;
                float: right;
            }
            select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }  
            .th1{width: 4%;}
            .th2{width: 9%;}    
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>  
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                <td align="center" style="width:20%"><a id='vewCust'></a></td>           
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='cust'>~cust</td>                 
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
       <tr class="tr1">
            <td class='td1'><span> </span><a id="lblDatea" ></a></td>
            <td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblNoa" ></a></td>
            <td class="td4"><input id="txtNoa" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><input id="btnDate" type="button" /></td>
            <td class="td6"><input id="txtBdate" type="text" style='width:40%;'/><a style="font-size:25px; "> &#126;</a><input id="txtEdate" type="text" style='width:40%;'/></td> 
        </tr>
        <tr class="tr2">            
            <td class='td1'><span> </span><input id="btnCust" type="button" /></td>
            <td class="td2"><input id="txtCustno"  type="text" class="txt c5"/><input  id="txtCust"  type="text"  class="txt c4"/></td>
            <td class='td3'><span> </span><a id="lblPay" ></a></td>
            <td class="td4"><input id="txtPay"  type="text"  class="txt c1"/></td>
            <td class="td5"><span> </span><input id="btnIndata" type="button" /></td>
        </tr>        
        <tr class="tr3">            
            <td class='td1'><span> </span><a id="lblBcomp" ></a></td>
            <td class="td2"><input id="txtBcomp" type="text"  class="txt c1"/></td>
            <td class='td3'><span> </span><input id="btnBoat" type="button" /></td>
            <td class="td4"><input id="txtBoatno" type="text" class="txt c5" /><input id="txtBoat" type="text" class="txt c4" /></td>
            <td class="td5"><span> </span><input id="btnDelet" type="button" /></td>
         </tr>   
         <tr class="tr4">
             <td class="td1"><span> </span><a id="lblMemo"></a></td>
             <td class="td2" colspan="5"><textarea id="txtMemo" cols="10" rows="5" style="width: 95%;height: 127px;"></textarea></td>
         </tr>           
        </table>
        </div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="th2"><a id='lblDate2'></a></td>
                <td align="center" class="th2"><a id='lblUsprice'></a></td>
                <td align="center" class="th1"><a id='lblFloat'></a></td>
                <td align="center" class="th1"><a id='lblContainer'></a></td>
                <td align="center" class="th1"><a id='lblWeight'></a></td>
                <td align="center" class="th1"><a id='lblWorker'></a></td>
                <td align="center" class="th1"><a id='lblDocn'></a></td>
                <td align="center" class="th1"><a id='lblArrange'></a></td>
                <td align="center" class="th1"><a id='lblInsurance'></a></td>
                <td align="center" class="th1"><a id='lblImport'></a></td>
                <td align="center" class="th2"><a id='lblCheckn'></a></td>
                <td align="center" class="th1"><a id='lblTrans'></a></td>
                <td align="center" class="th1"><a id='lblHang'></a></td>
                <td align="center" class="th1"><a id='lblErele'></a></td>
                <td align="center" class="th1"><a id='lblDocn2'></a></td>
                <td align="center" class="th1"><a id='lblTax'></a></td>
                <td align="center" class="th2"><a id='lblTotal'></a></td>
                <td align="center" class="th2"><a id='lblInvono'></a></td>
                
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtDate2.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtUsprice.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtFloat.*"type="text"  /></td>
                <td ><input class="txt num c1" id="txtContainer.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtWeight.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtWorker.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtDocn.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtArrange.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtInsurance.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtImport.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtCheckn.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTrans.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtHang.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtErele.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtDocn2.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTax.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal.*" type="text" /></td>
                <td ><input class="txt c1" id="txtInvono.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
