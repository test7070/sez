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
        q_desc = 1;
        q_tables = 's';
        var q_name = "rc2e";
        var q_readonly = ['txtNoa'];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
         aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
        ['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
        ['txtUno_', 'btnUno_', 'uccc', 'noa', 'txtUno_', 'uccc_seek_b.aspx','95%','60%'],
        ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx']);

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
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            /* 若非本會計年度則無法存檔 */
			$('#txtDatea').focusout(function () {
				if($(this).val().substr( 0,3)!= r_accy){
			        	$('#btnOk').attr('disabled','disabled');
			        	alert(q_getMsg('lblDatea') + '非本會計年度。');
				}else{
			       		$('#btnOk').removeAttr('disabled');
				}
			});
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

            q_box('rc2e_s.aspx', q_name + '_s', "500px", "360px", q_getMsg("popSeek"));
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
            if (!as['product'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];
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
            .tbbm tr td{
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
                width: 25%;
                float: left;
            }
            .txt.c5 {
                width: 60%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 98%;
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
                width: 1500px;
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
             width:100% ;
             height:98% ;  
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
                <td align="center" style="width:20%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:25%"><a id='vewTgg'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='tgg,4'>~tgg,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
            <td class='td1'><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
            <td class="td4"><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td5"><input id="txtNoa"  type="text" class="txt c1"/> </td>
            <td class='td6'> </td>
            <td class="td7"> </td>
            <td class="td8"> </td>
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblTggno" class="lbl btn"> </a></td>
            <td class="td2" colspan="4"><input id="txtTggno"  type="text" class="txt c2"/>
            <input id="txtTgg"  type="text" class="txt c3"/></td>
        </tr>
        <tr class="tr3">
        	<td class="td1"><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
            <td class="td2" colspan="4"><input id="txtCustno"  type="text" class="txt c2"/>
            				<input id="txtComp"  type="text" class="txt c3"/> </td>
        </tr>
        <tr class="tr4">
        	<td class='td1'><span> </span><a id="lblTel" class="lbl"> </a></td>
            <td class="td2" colspan="4"><input id="txtTel"  type="text" class="txt c7"/></td>
            <td class="td6"> </td>
            <td class="td7"> </td>
        </tr>
        <tr class="tr5">
            <td class='td1'><span> </span><a id="lblAddr_post" class="lbl"> </a></td>
            <td class="td2" colspan="4"><input id="txtAddr_post"  type="text" class="txt c7"/> </td>
            <td class='td6'><span> </span><a id="lblEnda" class="lbl"> </a> </td>
            <td class="td7"><input id="txtEnda" type="checkbox"/> </td>
        </tr>
        <tr class="tr6">
            <td class='td1'><span> </span><a id="lblDeivery_addr" class="lbl"> </a></td>
            <td class="td2" colspan="4"><input id="txtDeivery_addr"  type="text" class="txt c7"/> </td>
            <td class='td6'><span> </span><a id="lblOrdeno" class="lbl"> </a> </td>
            <td class="td7"><input id="txtOrdeno"  type="text" class="txt c1"/> </td>
        </tr>   
        <tr class="tr7">
            <td class='td1'><span> </span><a id="lblWeight" class="lbl"> </a></td>
            <td class="td2"><input id="txtWeight"  type="text" class="txt c1 num"/></td>
            <td class="td3"><span> </span><a id="lblTotal" class="lbl"> </a></td>
            <td class="td4"><input id="txtTotal"  type="text" class="txt c1 num"/> </td>
        </tr> 
        <tr class="tr8">
        	<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
        	<td class="td2" colspan="8"><textarea id="txtMemo" cols="5" rows="10" style="width: 99%;height: 50px;"> </textarea></td>
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
                <td align="center" class="td1"><a id='lblRadius_s'> </a></td>
                <td align="center" class="td1"><a id='lblMount_s'> </a></td>
                <td align="center" class="td2"><a id='lblWeight_s'> </a></td>
                <td align="center" class="td2"><a id='lblPrice_s'> </a></td>
                <td align="center" class="td2"><a id='lblClass_s'> </a></td>
                <td align="center" class="td2"><a id='lblHand_s'> </a></td>
                <td align="center" class="td2"><a id='lblEnds_s'> </a></td>
                <td align="center" class="td2"><a id='lblMemo_s'> </a></td>
                <td align="center" class="td2"><a id='lblDescr_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtStoreno.*" type="text" /></td>
                <td style="width:10%;"><input class="txt c1" id="txtUno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnUno.*" type="button" value='.' style="width:1%;"/></td>
                <td style="width:15%;"><input class="txt c4" id="txtProductno.*" type="text" />
                	 <input class="txt c5" id="txtProduct.*" type="text" /><input id="btnProduct.*" type="button" value="." /></td>
                <td style="width:15%;"><input class="txt num c6" id="txtDime.*" type="text"/>x
                                    <input class="txt num c6" id="txtWidth.*" type="text"  />x
                                    <input class="txt num c6" id="txtLengthb.*" type="text" />
                                    <input class="txt num c1" id="txtSpec.*" type="text" /> </td>
                <td ><input class="txt num c1" id="txtRadius.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtMount.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtWeight.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtPrice.*" type="text" /></td>
                <td ><input class="txt c1" id="txtClass.*" type="text" /></td>
                <td ><input class="txt c1" id="txtHand.*" type="text" /></td>
                <td ><input class="txt c1" id="txtEnds.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
                <td ><input class="txt c1" id="txtDescr.*" type="text" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
 