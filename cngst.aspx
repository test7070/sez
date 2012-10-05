?<%@ Page Language="C#" AutoEventWireup="true" %>
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
        var q_name = "cng";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
        ['txtStorinno', 'lblStorein', 'store', 'noa,store', 'txtStorinno,txtStorin', 'store_b.aspx'],
        ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
        ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
        ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy )

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
            q_cmbParse("cmbTypea", q_getPara('cng.typea'));
            q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
            q_cmbParse("cmbKind", q_getPara('cng.kind')); 
             //�ܰʤؤo���
            $('#cmbKind').change(function () {
            	size_change();
		     });

        }
		function size_change () {
		  if( $('#cmbKind').val()=='1' || $('#cmbKind').val()=='3')
            	{
            		$('#lblSize_help').text("厚度x寬度x長度");
	            	for (var j = 0; j < q_bbsCount; j++) {
			           $('#txtSize4_'+j).attr('hidden', 'true');
			           $('#x3_'+j).attr('hidden', 'true');
			           $('#txtSize1_'+j).css('width','30%');
			         	$('#txtSize2_'+j).css('width','30%');
			         	$('#txtSize3_'+j).css('width','30%');
			         	$('#Memo').css('width','20%');
			           $('#txtSize1_'+j).val($('#txtDime_'+j).val());
			         	$('#txtSize2_'+j).val($('#txtWidth_'+j).val());
			         	$('#txtSize3_'+j).val($('#txtLengthb_'+j).val());
			         	$('#txtSize4_'+j).val(0);
			         	$('#txtRadius_'+j).val(0)
			         }
			     }
		         else
		         {
		         	$('#lblSize_help').text("短徑x長徑x厚度x長度");
			         for (var j = 0; j < q_bbsCount; j++) {
			         	$('#txtSize4_'+j).removeAttr('hidden');
			         	$('#x3_'+j).removeAttr('hidden');
			         	$('#txtSize1_'+j).css('width','22%');
			         	$('#txtSize2_'+j).css('width','22%');
			         	$('#txtSize3_'+j).css('width','22%');
			         	$('#Memo').css('width','16%');
			         	$('#txtSize1_'+j).val($('#txtRadius_'+j).val());
			         	$('#txtSize2_'+j).val($('#txtWidth_'+j).val());
			         	$('#txtSize3_'+j).val($('#txtDime_'+j).val());
			         	$('#txtSize4_'+j).val($('#txtLengthb_'+j).val());
			         }
			     }
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

            q_box('cng_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
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
		q_box('z_cng.aspx', '', "800px", "600px", q_getMsg("popPrint"));
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['productno'] ) {  
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
                width: 98%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 98%;
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
            .tbbm tr td {
                width: 10%;
            }
            .tbbm .tdZ {
                width: 2%;
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
            .tbbm select{
            	font-size: medium;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 49%;
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }

      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:20%"><a id='vewStore'> </a></td>
                <td align="center" style="width:20%"><a id='vewStorin'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='store'>~store</td>
                   <td align="center" id='storin'>~storin</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
        	<td class='td1'><span> </span><a id="lblType" class="lbl" > </a></td>
        	<td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
            <td class='td3'><span> </span><a id="lblDatea" class="lbl" > </a></td>
            <td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblNoa" class="lbl" > </a></td>
            <td class="td6"><input id="txtNoa"   type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr2">
        	<td class='td1'><span> </span><a id="lblKind" class="lbl" > </a></td>
        	<td class="td2"><select id="cmbKind" class="txt c1"> </select></td>
            <td class='td3'><span> </span><a id="lblStore" class="lbl btn"> </a></td>
            <td class="td4"><input id="txtStoreno" type="text"  class="txt c6"/><input id="txtStore" type="text" class="txt c6"/></td>       
            <td class="td5"><span> </span><a id="lblStorein" class="lbl btn"> </a></td>
            <td class="td6"><input id="txtStorinno" type="text" class="txt c6"/>
            	<input id="txtStorin" type="text" class="txt c6"/></td> 
        </tr>
        <tr class="tr3">
            <td class='td1'><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
            <td class="td2" colspan="3"><input id="txtTggno" type="text"  class="txt c4"/>       
            <input id="txtTgg" type="text"  class="txt c5"/></td>
            <td class='td5'><span> </span><a id="lblTrantype" class="lbl" > </a></td>
            <td class="td6"><select id="cmbTrantype" class="txt c1"> </select></td>
        </tr>
        <tr class="tr4">
        	<td class='td1'><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
            <td class="td2" colspan="3"><input id="txtCardealno" type="text"  class="txt c4"/>      
            <input id="txtCardeal" type="text"  class="txt c5"/></td>
        	<td class='td5'><span> </span><a id="lblCarno" class="lbl" > </a></td>
        	<td class="td6"><input id="txtCarno" type="text" class="txt c1"/></td> 
        </tr>
        <tr class="tr5">
        	<td class='td1'><span> </span><a id="lblTax" class="lbl" > </a></td>
        	<td class="td2"><input id="txtTax" type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblMoney" class="lbl" > </a></td>
            <td class="td4"><input id="txtMoney" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblPrice" class="lbl" > </a></td>
            <td class="td6"><input id="txtPrice"   type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr6">
            <td class='td1'><span> </span><a id="lblWeight" class="lbl" > </a></td>
            <td class="td2"><input id="txtWeight"   type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblTotal" class="lbl" > </a></td>
            <td class="td4"><input id="txtTotal"   type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr7">
        <td class='td1'><span> </span><a id="lblMemo" class="lbl"> </a></td>
        <td class="td2" colspan='3'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
        <td class='td3'><span> </span><a id="lblWorker" class="lbl"> </a></td>
            <td class="td4"><input id="txtWorker" type="text" class="txt c1"/></td>
        </tr>
        </table>
        </div>
        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:10%;"><a id='lblUno_st'> </a></td>
                <td align="center"><a id='lblProductno_st'> </a></td>
                <td align="center"><a id='lblProduct_st'> </a></td>
                <td align="center"><a id='lblUnit_st'> </a></td>
                <td align="center" style="width:10%;"><a id='lblSpec_st'> </a></td>
                <td align="center"><a id='lblSize_st'> </a><BR><a id='lblSize_help'> </a></td>
                <td align="center"><a id='lblMount_st'> </a></td>
                <td align="center" style="width:6%;"><a id='lblWeight_st'> </a></td>
                <td align="center"><a id='lblStoreno_st'> </a></td>
                <td align="center"><a id='lblMemo_st'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='��' style=" font-weight: bold;" /></td>
                <td><input id="txtUno.*" type="text" style="width:75%;"/><input class="btn"  id="btnUno.*" type="button" value='...' style="width:15%;"  /></td>
                <td ><input id="txtProductno.*" type="text" style="width:80%;" />
                	<input class="btn"  id="btnProductno.*" type="button" value='...' style="width:15%;"  /></td>
                <td ><input class="txt c1" id="txtProduct.*" type="text"/></td>
                <td><input class="txt c1" id="txtUnit.*" type="text" /></td>
                <td><input class="txt c1" id="txtSpec.*" type="text"/></td>
                <td><input class="txt num c7" id="txtSize1.*" type="text"/><div id="x1" style="float: left"> x</div>
                		<input class="txt num c7" id="txtSize2.*" type="text"/><div id="x2" style="float: left"> x</div>
                        <input class="txt num c7" id="txtSize3.*" type="text"/><div id="x3.*" style="float: left"> x</div>
                         <input class="txt num c7" id="txtSize4.*" type="text"/>
                         <!--上為虛擬下為實際-->
                         <input id="txtRadius.*" type="hidden"/>
                		<input  id="txtWidth.*" type="hidden"/>
                        <input  id="txtDime.*" type="hidden"/>
                         <input id="txtLengthb.*" type="hidden"/>
                </td>
                <td><input class="txt num c1" id="txtMount.*" type="text"/></td>
                <td><input class="txt num c1" id="txtWeight.*" type="text" /></td>
                <td><input class="txt c1" id="txtStoreno.*" type="text" /></td>
                <td><input class="txt c1" id="txtMemo.*" type="text"/>
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
