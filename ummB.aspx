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
        var q_name = "ummb";
        var decbbs = ['tax', 'total', 'money'];
        var decbbm = ['tax', 'total', 'money'];
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [['txtPrice', 10, 3]];  
        var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],['txtCustno', 'btnCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],['txtPartno2', 'btnPart2', 'part', 'noa,part', 'txtPartno2,txtPart2', 'part_b.aspx'],['txtSalesno2', 'btnSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx']);

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

      /*  aPop = [['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtStoreno2', 'btnStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx', "60%", "650px", q_getMsg('popStore')],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];*/

        function mainPost() { 
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
            if (!as['kind'] ) {  
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
        .tview
        {
            FONT-SIZE: 12pt;
            COLOR:  Blue ;
            background:#FFCC00;
            padding: 3px;
            TEXT-ALIGN:  center;
        }    
        .tbbm
        {
            FONT-SIZE: 12pt;
            COLOR: blue;
            TEXT-ALIGN: left;
            border-color: white; 
            width:100%; border-collapse: collapse; background:#cad3ff;
        } 
        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:100% ;  
        } 
        
       
        .column1
        {
            width: 5%;
        }
        .column1a
        {
            width: 10%;
        }
        .column2
        {
            width: 15%;
        }      
        .column3
        {
            width: 15%;
        }   
        .column4
        {
            width: 15%;
        }           
         .label1
        {
            width: 10%;text-align:right;
        }       
        .label2
        {
            width: 8%;text-align:right;
        }
        .label3
        {
            width: 8%;text-align:right;
        }
       .txt.c1
       {
           width: 95%;
       }
       .td1
       {
           width: 6%;
       }
       .td2
       {
           width: 8%;
       }
       .td3
       {
           width: 10%;
       }
       .txt.num {
                text-align: right;
            }
       .tbbm tr {
                height: 35px;
            }
        .tbbm tr td span {
                float: right;
                display: block;
                width: 8px;
                height: 10px;
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
            }
            select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
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
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
               <td class="label1" ><a id='lblNoa'></a></td>
               <td class="column1" colspan="2"><input id="txtNoa"   type="text" class="txt c1"/></td> 
               <td class="label2" ><a id='lblDatea' ></a></td>
               <td class="column2"><input id="txtDatea"  type="text" class="txt c1"/></td>
               <td class="label3" ><a id='lblMon'></a></td>
               <td class="column3"><input id="txtMon"  type="text"  class="txt c1"/></td> 
            </tr>   
            <tr>
               <td class="label1" ><input id="btnAcomp" type="button" value='.' /></td>
               <td class="column1" ><input id="txtCno"  type="text"  class="txt c1"/></td>
               <td class="column1a" ><input id="txtAcomp"    type="text"  class="txt c1"/></td>               
               <td class="label2"><a id='lblWorker'></a></td>
               <td class="column2"><input id="txtWorker"  type="text"  class="txt c1"/></td> 
            </tr>

           <tr>
                <td class="label1"><input id="btnCust" type="button" value='.' /></td>
                <td class="column1"><input id="txtCustno" type="text" class="txt c1"/></td>
                <td class="column1a"><input id="txtComp"  type="text" class="txt c1"/></td>
                <td class="label2"><a id='lblPayc'></a></td>
                <td class="column2"><input id="txtPayc" type="text" class="txt c1"/></td> 
                <td class="label3"><a id='lblInvono'></a></td>
                <td class="column3"><input id="txtInvono" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
                <td class="label1"><a id='lblVdate'></a></td>
                <td class="column1"><input id="txtVbdate" type="text" class="txt c1" /></td> 
                <td class="column1a"><input id="txtVedate" type="text" class="txt c1"/></td> 
                <td class="label2"><a id='lblCno2'></a></td>
                <td class="column2"><input id="txtCno2"    type="text" style="width: 45%;"/>
                <input id="txtAccno2" type="text" style="width: 45%;"/></td>
                <td class="label3"><a id='lblTax'></a></td>
                <td class="column3"><input id="txtTax" type="text" class="txt num c1"/></td> 
             </tr>
            <tr>
                <td class="label1"><input id="btnPart2" type="button" value='.' /></td>
                <td class="column1"><input id="txtPartno2" type="text" class="txt c1"/></td> 
                <td class="column1a"><input id="txtPart2" type="text" class="txt c1"/></td> 
                <td class="label2"><input id="btnSales2" type="button" value='.'/></td>
                <td class="column2"><input id="txtSalesno2" type="text"  style="width: 30%;"/>
                <input id="txtSales2" type="text"  style="width: 59%;"/></td>
                <td class="label3"><a id='lblTotal'></a></td>
                <td class="column3"><input id="txtTotal"  type="text" class="txt num c1"/></td> 
            </tr>
            <tr><td align="right"><a id='lblMemo'></a></td>
                <td  colspan='7' ><input id="txtMemo"  type="text"  style="width: 98%;"/></td></tr>
        </table>
        </div>        
        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
              <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td1"><a id='lblKind'></a></td>
                <td align="center" class="td1"><a id='lblType'></a></td>
                <td align="center" class="td2"><a id='lblNoq'></a></td>
                <td align="center" class="td2"><a id='lblInvonos'></a></td>
                <td align="center" class="td3"><a id='lblPart'></a></td>
                <td align="center" class="td1"><a id='lblMoney'></a></td>
                <td align="center" class="td3"><a id='lblTaxs'></a></td>
                <td align="center" class="td3"><a id='lblTotals'></a></td>
                <td align="center" class="td2"><a id='lblProduct'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input  id="txtKind.*" type="text" class="txt c1" /></td>                
                <td ><input  id="txtTypea.*" type="text"  class="txt c1"/></td>
                <td ><input  id="txtNoq.*" type="text"   class="txt c1"/>
                <td ><input  id="txtInvono.*" type="text" class="txt c1"/>
                <td ><input  id="txtPartno.*" type="text" style="width: 25%;"/><input class="txt" id="txtPart.*" type="text" style="width: 58%;"/></td>
                <td ><input  id="txtMoney.*" type="text" class="txt num c1"/></td>
                <td ><input id="txtTax.*" type="text" class="txt num c1"/></td>
                <td ><input id="txtTotal.*" type="text" class="txt num c1"/></td>
                <td ><input id="txtProduct.*" type="text"  class="txt c1"/></td>
                <td ><input id="txtMemo.*" type="text"  class="txt c1"/>
                <input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
