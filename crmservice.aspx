<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">

            var q_name = "crmservice";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var bbmNum = [['txtMoney',15,0,1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //brwCount2 = 15;
            
            aPop = new Array(
            	['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            	,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
            	,['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']
	,['txtQnoa', 'lblFaq', 'crmFaq', 'noa,question', 'txtQnoa,txtQuestion', 'crmFaq_b.aspx']
	,['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx']
            );
       
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }
			
            function mainPost() {
                bbmMask = [['txtDatea', r_picd],['txtTimea', '99:99'],['txtDaten', r_picd],['txtTimen', '99:99']
                ,['txtRepdate', r_picd],['txtReptime', '99:99']];
                q_mask(bbmMask);
				q_cmbParse("combReason", ",拜訪,客訴,咨詢,售後服務,其他");
                				q_cmbParse("cmbSource", ",電話,電子郵件,Web,Facebook,Twitter,其他");
				q_cmbParse("cmbEffort", ",低,中,高");
				q_cmbParse("cmbPriority", ",低,高,一般,重大");
				$('#combReason').change(function() {
					$('#txtReason').val($(this).val());
					$(this).val('');
				});
				
				$('#lblRepdate').click(function() {
					if(q_cur==1 || q_cur==2){
						$('#txtRepdate').val(q_date());
			            			            
			            var timeDate= new Date();
						var tHours = timeDate.getHours();
						var tMinutes = timeDate.getMinutes();
			            $('#txtReptime').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
					}
				});
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }   
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
                	case 'acomp':
                		var as = _q_appendData("acomp", "", true);
                		if(as[0]!=undefined){
                			$('#txtCno').val(as[0].noa);
	            			$('#txtAcomp').val(as[0].acomp);
                		}
                		break;
                } 
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('crmservice_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                q_gt('acomp', '', 0, 0, 0, "");
                $('#txtNoa').val('AUTO');
	            $('#txtDatea').val(q_date());
	            var timeDate= new Date();
				var tHours = timeDate.getHours();
				var tMinutes = timeDate.getMinutes();
	            $('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
	            $('#txtSssno').val(r_userno);
	            $('#txtNamea').val(r_name);
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
				//q_box('z_crmservicep.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }
            
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            function btnOk() {
               $('#txtDatea').val($.trim($('#txtDatea').val()));
               
               var t_err = '';
            	t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')] ]);
            	
	            if( t_err.length > 0) {
	                alert(t_err);
	                return;
	            }
	            
	            if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_crmservice') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);	
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }
			
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$('#combReason').attr('disabled','disabled');
                	$('#txtDatea').datepicker('destroy');
                	$('#txtRepdate').datepicker('destroy');
                }else{
                	$('#combReason').removeAttr('disabled','disabled');
                	$('#txtDatea').datepicker();
                	$('#txtRepdate').datepicker();
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
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
                width: 400px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 620px;
                /*margin: -1px;        
                border: 1px black solid;*/
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
                width: 9%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:180px; color:black;"><a id='vewCust'> </a></td>
						<td align="center" style="width:180px; color:black;"><a id='vewReason'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='nick' style="text-align: left;">~nick</td>
						<td id='reason' style="text-align: left;">~reason</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td></td>
						<td><input id="chkEnda" type="checkbox"/><span> </span><a id='lblEnda'> </a></td>
					</tr>
					<tr>
					    	<td><span> </span><a id='lblSource' class="lbl"> </a></td>
						<td><select id="cmbSource" class="txt c1"> </select></td>
               					</tr>
					<tr>
					    	<td><span> </span><a id='lblEffort' class="lbl"> </a></td>
						<td><select id="cmbEffort" class="txt c1"> </select></td>
					    	<td><span> </span><a id='lblPriority' class="lbl"> </a></td>
						<td><select id="cmbPriority" class="txt c1"> </select></td>
               					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblTimea' class="lbl"> </a></td>
						<td><input id="txtTimea"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td ><input id="txtCno" type="text" class="txt c1" /></td>
						<td colspan="2"><input id="txtAcomp" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td ><input id="txtCustno" type="text" class="txt c1" /></td>
						<td colspan="2">
							<input id="txtComp" type="text" class="txt c1" />
							<input id="txtNick" type="text" style="display:none;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblReason' class="lbl"> </a></td>
						<td>
							<input id="txtReason" type="text" class="txt" style="float:left;width:80%;"\>
							<select id="combReason" style="float:left;width:20%;"> </select>
						</td>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSss' class="lbl btn"> </a></td>
						<td ><input id="txtSssno" type="text" class="txt c1" /></td>
						<td><input id="txtNamea" type="text" class="txt c1" /></td>
					</tr>
 					<tr>
						<td><span> </span><a id='lblProductno' class="lbl btn"> </a></td>
						<td ><input id="txtProductno" type="text" class="txt c1" /></td>
						<td colspan="2"><input id="txtProduct" type="text" class="txt c1" /></td>
					</tr>
 					<tr>
						<td><span> </span><a id='lblFaq' class="lbl btn"> </a></td>
						<td ><input id="txtQnoa" type="text" class="txt c1" /></td>
						<td colspan="2"><input id="txtQuestion" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtMemo" cols="10" rows="10" style="width: 100%;height: 100px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblRepdate' class="lbl btn"> </a></td>
						<td><input id="txtRepdate"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblReptime' class="lbl"> </a></td>
						<td><input id="txtReptime"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">重點備註</a></td>
						<td colspan="3"><textarea id="txtMemo2" cols="10" rows="5" style="width: 100%;height: 50px;"> </textarea></td>
					</tr>
					<!--<tr>
						<td><span> </span><a id='lblDaten' class="lbl"> </a></td>
						<td><input id="txtDaten"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblTimen' class="lbl"> </a></td>
						<td><input id="txtTimen"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemon" class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtMemon" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					</tr>--!>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
