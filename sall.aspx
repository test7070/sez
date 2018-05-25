<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			q_tables = 't';
			var toIns = true;
			var q_name = "sall";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var q_readonlys = ['txtNoq','txtMakeno'];
			var q_readonlyt = ['txtNoq','txtProductno','txtProduct'];
			var bbmNum = [];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [['txtBtime','99:99'],['txtEtime','99:99']];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			brwCount2 = 5;
			
			aPop = new Array(
				['txtLicenceno', 'lblLicence', 'licence', 'noa,licence', 'txtLicenceno,txtLicence', 'licence_b.aspx']
				,['txtSssno_', 'btnSssno_', 'sss', 'noa,namea', 'txtSssno_,txtNamea_', 'sss_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}
			
			function mainPost() {
				q_getFormat();
				bbmMask = [];
				bbsMask = [['txtFirstdate', r_picd]];
				bbtMask = [['txtBackdate', r_picd]];
				q_mask(bbmMask);
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
						q_Seek_gtPost();
						break;
					default:
						break;
				}
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
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
			
			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#licenceno').focus();
			}
			
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#licenceno').focus();
			}
			
			function btnPrint() {
				q_box('z_sall.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			
			}
			
			function btnOk() {
				var t_err = q_chkEmpField([['txtLicenceno', q_getMsg('lblLicenceno')]]);  // 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
			
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				
				refreshBbt();
				var t_noa = trim($('#txtNoa').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll($('#txtLicenceno').val() + q_date(), '/', ''));
				else
					wrServer(t_noa);
			}
			
			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			
			function bbsSave(as) {
				if (!as['sssno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}
			
			function bbtSave(as) {
				if (!as['backdate'] && !as['backhour']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			
			function refresh(recno) {
				_refresh(recno);
			}
			
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
				
				} else {
				
				}
			}
			
			function refreshBbt(){
				if($('input:radio:checked[name="bbtNum"]').length>0){
					var n = $('input:radio:checked[name="bbtNum"]').attr('id').replace(/^(.*)_(\d+)$/,'$2');
					var t_noq = $('#txtNoq_'+n).val();
					var t_sssno = $('#txtSssno_'+n).val();
					for(var i=0;i<q_bbtCount;i++){
						if($('#txtSssno__'+i).val()==t_sssno
						&& $('#txtSssno__'+i).val().length==0){
							$('#bbttr__'+i).show();
						}
					}
				}
			}
			var changenoq='',changesssno='';
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#bbtNum_'+i).click(function(e){
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if(emp($('#txtSssno_'+b_seq).val()) && (q_cur==1 || q_cur==2)){
								alert('請先輸入員工編號!!');
								$('[name=bbtNum]').prop('checked',false);
							}
							refreshBbt();
							bbtAssign();
						});
						$('#txtSssno_'+i).focusin(function(e){
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							changenoq=b_seq;
							changesssno=$('#txtSssno_'+b_seq).val();
						});
					}
				}
				_bbsAssign();
				refreshBbt();
			}
			
			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
						$('#txtBackdate__'+i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var n = $('input:radio:checked[name="bbtNum"]').attr('id').replace(/^(.*)_(\d+)$/,'$2');
							
							if(!emp($('#txtBackdate__'+b_seq).val())){
								$('#txtSssno__'+b_seq).val($('#txtSssno_'+n).val())
							}
						});
						
						$('#txtBackhour__'+i).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var n = $('input:radio:checked[name="bbtNum"]').attr('id').replace(/^(.*)_(\d+)$/,'$2');
							
							if(!emp($('#txtBackhour__'+b_seq).val())){
								$('#txtSssno__'+b_seq).val($('#txtSssno_'+n).val())
							}
						});
					}
				}
				_bbtAssign();
				
				if($('input:radio:checked[name="bbtNum"]').length>0){
					var n = $('input:radio:checked[name="bbtNum"]').attr('id').replace(/^(.*)_(\d+)$/,'$2');
					var t_noq = $('#txtNoq_'+n).val();
					var t_sssno = $('#txtSssno_'+n).val();
					
					$('#dbbt').find('tr').hide();
					$('#dbbt').find('tr').eq(0).show();
					var m = 0;
					for(var i=0;i<q_bbtCount;i++){
						if($('#txtSssno__'+i).val() == t_sssno || $('#txtSssno__'+i).val().length==0){
							$('#lblNo__' + i).text(m++ + 1);
							$('#bbttr__'+i).show();
						}
					}
				}
			}
			
			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}
			
			function btnSeek() {
				_btnSeek();
			}
			
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
				return;
				q_box('sall_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
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
			
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			
			function btnMinus(id) {
				_btnMinus(id);
			}
			
			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}
			
			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}
			
			function q_popPost(id) {
				switch (id) {
					case 'txtSssno_':
						if(changenoq.length>0 && changesssno.length>0){
							for (var i = 0; i < q_bbtCount; i++) {
								if($('#txtSssno__'+i).val()==changesssno){
									$('#txtSssno__'+i).val($('#txtSssno_'+b_seq).val());
								}
							}
							changenoq='';
							changesssno='';
						}
						break;
				}
			}
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 35px;
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
                width: 600px;
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
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: black;
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
                width: 95%;
                float: left;
            }
            .num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm select {
                font-size: medium;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 600px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 300px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div class="dview" id="dview" >
			<table class="tview" id="tview" >
				<tr>
					<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
					<td style="width:80px; color:black;"><a id='vewLicenceno'> </a></td>
					<td style="width:100px; color:black;"><a id='vewLicence'> </a></td>
				</tr>
				<tr>
					<td><input id="chkBrow.*" type="checkbox" style=''/></td>
					<td id='licenceno' style="text-align: center;">~licenceno</td>
					<td id='licence' style="text-align: center;">~licence</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm" id="tbbm">
				<tr style="height:1px;">
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td class="tdZ"> </td>
				</tr>
				<tr>
					<td><span> </span><a id="lblLicenceno" class="lbl"> </a></td>
					<td>
						<input id="txtLicenceno" type="text" class="txt c1"/>
						<input id="txtNoa" type="hidden" class="txt c1"/>
					</td>
					<td colspan="2"><input id="txtLicence" type="text" class="txt c1"/></td>
				</tr>
				<tr>
					<td><span> </span><a id="lblodate" class="lbl">回訓週期</a></td>
					<td><input id="txtOdate" type="text" class="txt c1"/></td>
				</tr>
				<tr>
					<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
					<td><input id="txtWorker" type="text" class="txt c1"/></td>
					<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
					<td><input id="txtWorker2" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<div style="width: 1260px;float: left;">
			<div class='dbbs' style="float:left;">
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:40px;"> </td>
						<td style="width:130px;" align="center"><a id='lblSssno_s'> </a></td>
						<td style="width:150px;" align="center"><a id='lblNamea_s'> </a></td>
						<td style="width:150px;" align="center"><a id='lblFirstdate_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center"><input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/></td>
						<td>
							<input type="radio" id="bbtNum.*" name="bbtNum"/>
							<input id="txtNoq.*" type="text" style="display:none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtSssno.*" type="text" class="txt c1"/></td>
						<td><input id="txtNamea.*" type="text" class="txt c1"/></td>
						<td><input id="txtFirstdate.*" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div id="dbbt" style="float:left;">
				<table id="tbbt">
					<tbody>
						<tr class="head" style="color:white; background:#003366;">
							<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
							<td style="width:20px;"> </td>
							<td style="width:150px; text-align: center;"><a id='lblBackdate_t'> </a></td>
							<td style="width:100px; text-align: center;"><a id='lblBackhour_t'> </a></td>
						</tr>
						<tr id="bbttr..*" style="display: none;">
							<td>
								<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
								<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
								<input class="txt" id="txtSssno..*" type="text" style="display: none;"/>
							</td>
							<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
							<td><input class="txt c1" id="txtBackdate..*" type="text"  /></td>
							<td><input class="txt num c1" id="txtBackhour..*" type="text"  /></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
