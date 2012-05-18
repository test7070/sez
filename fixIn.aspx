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
        var q_name = "fixin";
        var decbbs = ['mount', 'price', 'money'];
        var decbbm = ['tax', 'total', 'money'];
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = []; 
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
         aPop = new Array(['txtTggno', 'btnTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],['txtProductno_', 'btnProductno_', 'fixucc', 'noa,product', 'txtProductno_,txtProduct_', 'fixucc_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];      
            q_brwCount(); 
            q_gt(q_name, q_content, q_sqlCount, 1)  

        });

     
        function main() {
            if (dataErr)  
            {
                dataErr = false;
                return;
            }

            mainForm(1);
        }  

     
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            fbbm[fbbm.length] = 'txtMemo';
            q_cmbParse("cmbTypea", q_getPara('fixin.typea'));
        }

        function q_boxClose(s2) { 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); 
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
            if (!as['productno']) {  
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
            width:98%; border-collapse: collapse; background:#cad3ff;
        } 
        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:98% ; height:98% ;  
        } 
        
       
        .column1
        {
            width: 15%;
        }
        .column2
        {
            width: 8%;
        }      
        .column3
        {
            width: 8%;
        }   
        .column4
        {
            width: 15%;
        }           
         .label1
        {
            width: 8%; text-align:right;
        }       
        .label2
        {
            width: 8%; text-align:right;
        }
        .label3
        {
            width: 8%; text-align:right;
        }
       .label4
        {
            width: 8%; text-align:right;
        }
        .txt.c1
        {
            width: 95%;
        }
        .txt.c2
        {
            width: 30%;
            float: left;
        }
        .txt.c3
        {
            width: 60%;
            float: left;
        }
        .td1
        {
            width: 5%;
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
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>                
                <td align="center" style="width:20%"><a id='vewTgg'></a></td>                
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='tgg'>~tgg</td>
                  
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='label1'><a id="lblTypea" ></a></td>
            <td class="column1"><select id="cmbTypea" class="txt c1"/></td>
            <td class='label2'><a id="lblDatea" ></a></td>
            <td class="column2"><input id="txtDatea"type="text" class="txt c1"/></td>
            <td class='label3'><a id="lblNoa" ></a></td>
            <td class="column3"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class='label4'><input id="btnTgg"  type="button" style="width: auto;font-size: medium;"/></td>
            <td class="column4"><input id="txtTggno" type="text" class="txt c2"/><input id="txtTgg" type="text" class="txt c3"/></td>
        </tr> 
        <tr>
            <td class='label1'><input id="btnAcomp" type="button" style="width: auto;font-size: medium;"/></td>
            <td class="column1"><input id="txtCno" type="text" class="txt c2"/><input id="txtAcomp" type="text" class="txt c3"/></td>
            <td class='label2'><a id="lblTax" ></a></td>
            <td class="column2"><input id="txtTax"type="text" class="txt c1" style="text-align: right;"/></td>
            <td class='label3'><a id="lblTotal" ></a></td>
            <td class="column3"><input id="txtTotal" type="text" class="txt c1" style="text-align: right;"/></td>
            <td class='label4'><a id="lblMoney"></a></td>
            <td class="column4"><input id="txtMoney" type="text" class="txt c1" style="text-align: right;" /></td>
        </tr> 
        <tr>
            <td class="label1"><a id="lblMemo"></a></td>
            <td class="column1" colspan="7"><textarea id="txtMemo" rows="5" cols="10" style="width:98%; height: 127px;"></textarea></td>
        </tr>     
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td1"><a id='lblProductno'></a></td>
                <td align="center" style="width: 15%;"><a id='lblProduct'></a></td>
                <td align="center" style="width: 3%;"><a id='lblUnit'></a></td>
                <td align="center" class="td1"><a id='lblMount'></a></td>
                <td align="center" class="td1"><a id='lblPrice'></a></td>
                <td align="center" class="td1"><a id='lblMoneys'></a></td>
                <td align="center" class="td1"><a id='lblUno'></a></td>
                <td align="center" class="td1"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input id="txtProductno.*" type="text" style="width: 80%;" /><input id="btnProductno.*" type="button" value="..." style="width: 15%;font-size: medium;"/></td>
                <td ><input class="txt c1" id="txtProduct.*" type="text" /></td>
                <td ><input class="txt c1" id="txtUnit.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMount.*" type="text" style="text-align: right;"/></td>
                <td ><input class="txt c1" id="txtPrice.*" type="text" style="text-align: right;" /></td>
                <td ><input class="txt c1" id="txtMoney.*" type="text" style="text-align: right;" /></td>
                <td ><input class="txt c1" id="txtUno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
