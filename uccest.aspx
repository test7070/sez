<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src="../script/qbox.js" type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "ucce";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
        ['txtStoreno2', 'lblStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            brwCount2=5
            q_brwCount();   
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)

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

            q_box('ucce_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
            if (!as['namea'] ) {  
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

        ///////////////////////////////////////////////////  
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
                #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr .td1, .td2, .td3, .td4, .td5, .td6{
                width: 9%;
            }
            .tbbm .tdZ {
                width: 3%;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 90%;
                float: left;
            }
            .txt.c2 {
                width: 14%;
                float: left;
            }
            .txt.c3 {
                width: 26%;
                float: left;
            }
            .txt.c4 {
                width: 28%;
                float: left;
            }
            .txt.c5 {
                width: 70%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:98% ;  
        }  
      
       .tbbs .td1
        {
            width: 4%;
        }
        .tbbs .td2
        {
            width: 6%;
        }
        .tbbs .td3
        {
            width: 8%;
        }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
    <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewNoa'> </a></td>
                <td align="center" style="width:25%"><a id='vewDatea'> </a></td>
                
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
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class='td3'> </td>
            <td class="td4"> </td>
            <td class="td5"> </td>
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblTypea" class="lbl"> </a></td>
            <td class="td4"><select id="cmbTypea" class="txt c1"> </select></td>
            <td class="td5"> </td>
        </tr>
        <tr class="tr3">            
            <td class='td1'><span> </span><a id="lblStore" class="lbl btn"> </a></td>
            <td class="td2" colspan="3"><input id="txtStoreno" type="text" class="txt c2"/><input id="txtStore" type="text" class="txt c3"/>
            <a id="lblSymbol" class="lbl" style="font-weight: bold;font-size: 24px;width: 6%;float: left;"> </a>
           	<a id="lblStore2" class="lbl btn" style="width: 8%;float: left;"> </a>
            <input id="txtStoreno2" type="text" class="txt c2"/><input id="txtStore2" type="text" class="txt c3"/></td>
        	<td class="td5"> </td>
        </tr>
        <tr class="tr4">
            <td class='td1'><span> </span><a id="lblWaste" class="lbl"> </a></td>
            <td class="td2"><input id="txtWaste"  type="text" class="txt c1"/> </td>
            <td class='td3'> </td>
            <td class="td4"> </td>
            <td class="td5"> </td>
        </tr>                        
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td1"><a id='lblStoreno_s'> </a></td>
                <td align="center" class="td1"><a id='lblUno_s'> </a></td>
                <td align="center" class="td1"><a id='lblProductno_s'> </a></td>
                <td align="center" class="td1"><a id='lblSpec_s'> </a></td>
                <td align="center" class="td1"><a id='lblDime_s'> </a></td>
                <td align="center" class="td1"><a id='lblWidth_s'> </a></td>
                <td align="center" class="td1"><a id='lblLength_s'> </a></td>
                <td align="center" class="td1"><a id='lblMount_s'> </a></td>
                <td align="center" class="td2"><a id='lblEweight_s'> </a></td>
                <td align="center" class="td2"><a id='lblMemo_s'> </a></td>
                <td align="center" class="td2"><a id='lblAdjweight_s'> </a></td>
                <td align="center" class="td2"><a id='lblPrice_s'> </a></td>
                <td align="center" class="td2"><a id='lblEweight2_s'> </a></td>
                <td align="center" class="td2"><a id='lblTotal_s'> </a></td>
                <td align="center" class="td2"><a id='lblStore_s'> </a></td>
                <td align="center" class="td1"><a id='lblRadiu_s'> </a></td>
                <td align="center" class="td3"><a id='lblProduct_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtStoreno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtUno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtProductno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtSpec.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtDime.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtWidth.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtLength.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtMount.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtEweight.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*"type="text" /><input id="txtNoq.*" type="hidden" /></td>
                <td ><input class="txt num c1" id="txtAdjweight.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtPrice.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtEweight2.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal.*" type="text" /></td>
                <td ><input class="txt c1" id="txtStore.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtRadiu.*" type="text" /></td>
                <td ><input class="txt c1" id="txtProduct.*" type="text" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
 