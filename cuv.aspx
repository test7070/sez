<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;

			q_sables = 's';
			var q_name = "cuv";
			var q_readonly = ['txtNoa','txtStation'];
			var q_readonlys = ['txtHours','txtAddhours'];
			var bbmNum = [];
			var bbsNum = [
				['txtHours',10,2,1],['txtAddhours',10,2,1],['txtManagermans',10,0,1]
			];
			var bbmMask = [];
			var bbsMask = [['txtWorktime','9999-9999']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			brwCount2 = 10;
			aPop = new Array(
				['txtStationgno', 'lblStationgno', 'stationg', 'noa,namea', 'txtStationgno,txtStationg', 'stationg_b.aspx']
			);
			var WorkTimeArray = new Array();
			var WorkTimeList ='@';
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('cuwa', '', 0, 0, 0, "");
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
				bbmMask = [['txtDatea',r_picd]];
				bbsMask = [['txtWorktime','9999-9999']];
				q_mask(bbmMask);
				q_gt('part', '', 0, 0, 0, "");
				$('#btnCuximport').click(function(){
					toGetCux();
				});
				$('#btnWorkmount').click(function(){
					if(q_cur==1 || q_cur==2){
						for(var k=0;k<q_bbsCount;k++){
							$('#txtWorktime_' + k).focusout();
						}
					}
				});
			}
			var thisSeq = -1;
			function combtodo(do_object){
				if((q_cur == 1 || q_cur == 2) && do_object.val() != ''){
					t_where = '';
					choice_check = do_object.val();
					choice_check = choice_check.split('-');
					if(choice_check[0] != 'All'){
						t_where = "partno='"+choice_check[0]+"'";
					}
					thisSeq = $(do_object).attr('id').split('_')[$(do_object).attr('id').split('_').length-1];
					if(choice_check[1] == 'All'){
						if(choice_check[0] != 'All'){
							t_where = "where=^^ " + t_where + " ^^";
						}
						q_gt('sssall', t_where , 0, 0, 0, "", r_accy);	
					}else{
						q_box("sssall_check_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where , 'sssall', "50%", "650px", q_getMsg('popSssallcheck'));
					}
				}
			}
			function q_funcPost(t_func, result) {
				switch(t_func) {
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'cuwa':
						var as = _q_appendData("cuwa", "", true);
						if(as[0] != undefined){
							for(var k=0;k<as.length;k++){
								var t_timea=$.trim(as[k].btime)+'-'+$.trim(as[k].etime);
								WorkTimeArray.push({
									timea:t_timea,
									minutes:dec(as[k].minutes)
								});
								WorkTimeList += ','+t_timea+'@'+t_timea;
							}
							WorkTimeList = WorkTimeList.substring(1);
						}
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'GetCux':
						var as = _q_appendData("cuxs", "", true);
						if(as[0] != undefined){
							ret = q_gridAddRow(bbsHtm, 'tbbs',
								'txtWorktime,txtManagermans,txtManager,txtHours,txtAddhours,chkIsovertime',
								as.length, as,
								'worktime,managermans,manager,hours,addhours,isovertime',
								'txtWorktime','_'
							);
						}
						break;
					case 'sssall':
						var as = _q_appendData("sssall", "", true);
						var now_sxtObject;
						var now_mountObject;
						if($('#combPartno3__'+thisSeq).val() != ''){
							now_sxtObject = $('#txtManager_'+thisSeq);
							now_mountObject = $('#txtManagermans_'+thisSeq);
							$('#combPartno3_'+thisSeq).val('');
						}
						var AllName = $.trim($('#txtManager_'+thisSeq).val());
						for(var i = 0;i < as.length;i++){
							var AllName = $.trim($('#txtManager_'+thisSeq).val());
							str = now_sxtObject.val();
							name = as[i].namea;
							if(AllName.match(name) == null){
								newstr = str + name + ';';
								now_sxtObject.val(newstr);
							}
						}
						now_mountObject.val(now_sxtObject.val().split(';').length-1);
						break;
					case 'part':
						var as = _q_appendData("part", "", true);
						if (as[0] != undefined) {
							var t_item = "@,All@全部";
							var t_item2 = ",All-All@全部(全選)";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
								t_item2 = t_item2 + (t_item2.length > 0 ? ',' : '') + as[i].noa + '-All@' + as[i].part + '(全選)';
							}
							for(var k=0;k<q_bbsCount;k++){
								q_cmbParse("combPartno3_"+k, t_item + t_item2);
							}
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						if(t_name.substring(0,14)=='GetWorkbCount_'){
							var n = t_name.replace('GetWorkbCount_','');
							var as = _q_appendData("cuv_workb", "", true);
							var t_count = as.length;
							$('#txtWorkmount_'+n).val(t_count);
							var t_mount = 0;
							for(var k=0;k<as.length;k++){
								t_mount = q_add(t_mount,as[k].mount);
							}
							$('#txtMount_'+n).val(t_mount);
						}
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'sssall':
						var now_sxtObject;
						var now_mountObject;
						if($('#combPartno3_'+thisSeq).val() != ''){
							now_sxtObject = $('#txtManager_'+thisSeq);
							now_mountObject = $('#txtManagermans_'+thisSeq);
							$('#combPartno3_'+thisSeq).val('');
						}
						b_ret = getb_ret();
						if (!b_ret || b_ret.length == 0)
							return;
						for(var i = 0;i < b_ret.length;i++){
							var AllName = $.trim($('#txtManager_'+thisSeq).val());
							str = now_sxtObject.val();
							name = b_ret[i].namea;
							if(AllName.match(name) == null){
								newstr = str + name + ';';
								now_sxtObject.val(newstr);
							}
						}
						now_mountObject.val(now_sxtObject.val().split(';').length-1);
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cuv') + q_date(), '/', ''));
				else
					wrServer(s1);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			
			function bbsSave(as) {
				if (!as['worktime']) {
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
				if(q_cur == 1 || q_cur == 2){
					for(var k=0;k<q_bbsCount;k++){
						$('#combPartno3_'+k).removeAttr('disabled');
						$('#combPartno3_'+k).css('background-color', 'rgb(255, 255, 255)');
					}
					$('#btnWorkmount').removeAttr('disabled');
				}else{
					for(var k=0;k<q_bbsCount;k++){
						$('#combPartno3_'+k).attr('disabled','disabled');
						$('#combPartno3_'+k).css('background-color', 'rgb(237, 237, 238)');
					}
					$('#btnWorkmount').attr('disabled','disabled');
				}
			}

			function btnMinus(id) {
				_btnMinus(id);

			}

			function btnPlus(org_htm, dest_sag, afield) {
				_btnPlus(org_htm, dest_sag, afield);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if(WorkTimeList.length > 0){
						q_cmbParse("combWorktime_"+i, WorkTimeList);
					}
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#combWorktime_'+i).change(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if(q_cur==1 || q_cur==2){
								$('#txtWorktime_'+n).val($(this).val());
							}
							$('#txtWorktime_' + n).focusout();
						});
						$("#txtManager_"+i).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var thisVal = $.trim($(this).val());
							$('#txtManagermans_'+n).val(thisVal.split(';').length-1);
						});
						$("#combPartno3_"+i).change(function() {
							combtodo($(this));
						});
						$('#txtWorktime_' + i).focusout(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var thisVal = $.trim($(this).val());
							if(thisVal.length==0){
								$('#btnMinus_'+n).click();
								return;
							}
							var usetime = -1;
							for(var h=0;h<WorkTimeArray.length;h++){
								if(WorkTimeArray[h].timea==thisVal){
									usetime = round(dec(WorkTimeArray[h].minutes),2);
								}
							}
							if((thisVal.indexOf('-') > -1) && (usetime==-1)){
								var btime = dec(thisVal.split('-')[0]);
								var etime = dec(thisVal.split('-')[1]);
								btime = (Math.floor(btime/100)*60)+(btime%100);
								etime = (Math.floor(etime/100)*60)+(etime%100);
								usetime = round(((etime-btime)),2);
							}
							if($('#chkIsovertime_'+n).prop('checked')){
								$('#txtAddhours_'+n).val(usetime);
								$('#txtHours_'+n).val(0);
							}else{
								$('#txtAddhours_'+n).val(0);
								$('#txtHours_'+n).val(usetime);
							}
						});
						$('#chkIsovertime_'+i).click(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							$('#txtWorktime_' + n).focusout();
						});
					}
				}
				q_gt('part', '', 0, 0, 0, "");
				_bbsAssign();
			}

			function q_appendData(t_sable) {
				return _q_appendData(t_sable);
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

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			function toGetCux(){
				if(q_cur == 1 || q_cur == 2){
					var thisDatea = $.trim($('#txtDatea').val());
					var thisStationgno = $.trim($('#txtStationgno').val());
					if((thisDatea.length > 0) && (thisStationgno.length > 0)){
						var t_where = "where=^^ (N'" + thisDatea + "' between bdate and edate) and stationgno=N'" + thisStationgno + "' ^^ sorder=^^ noa asc ^^";
						q_gt('cux', t_where , 0, 0, 0, "GetCux", r_accy);
					}
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				float:left;
			}
			.dview {
				float: left;
				width: 300px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				width: 100%;
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
				width: 650px;
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
				width: 100%;
				float: left;
			}
			.txt.c3 {
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
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			#dbbs {
				width: 830px;
				float: left;
			}
			#dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				/*background: #cad3ff;*/
				background: lightgrey;
				width: 100%;
			}
			#dbbs .tbbs tr {
				height: 35px;
			}
			#dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
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
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:120px; color:black;"><a id='vewStationg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='stationg' style="text-align: center;">~stationg</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td><input id="txtCheckno" type="text" style="display:none;"/></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStationgno" class="lbl btn"> </a></td>
						<td><input id="txtStationgno" type="text" class="txt c1"/></td>
						<td><input id="txtStationg" type="text" class="txt c1"/></td>
						<td colspan="2" style="text-align:left;">
							<input type="button" class="" id="btnCuximport"/>
							<input type="button" class="" id="btnWorkmount"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="dbbs" >
			<table id="tbbs">
				<tbody>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:120px; text-align: center;"><a id='lblWorktime_s'> </a></td>
						<td style="width:80px; text-align: center;"><a id='lblManagermans_s'> </a></td>
						<td style="width:360px; text-align: center;"><a id='lblManager_s'> </a></td>
						<td style="width:80px; text-align: center;"><a id='lblHours_s'> </a></td>
						<td style="width:80px; text-align: center;"><a id='lblAddhours_s'> </a></td>
						<td style="width:40px;text-align:center;"><a id='lblIsovertime_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td>
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td>
							<input type="text" id="txtWorktime.*" style="float:left; width:90px;" />
							<select id="combWorktime.*" class="txt" style="float:left;margin-left:3px;margin-top:2px;width:19px;"> </select>
						</td>
						<td><input id="txtManagermans.*" type="text" class="txt num c3"/></td>
						<td>
							<select id="combPartno3.*" class="txt" style="width:100px;"> </select>
							<input id="txtManager.*" type="text" class="txt" style="width: 230px;"/>
						</td>
						<td><input id="txtHours.*" type="text" class="txt num c3"/></td>
						<td><input id="txtAddhours.*" type="text" class="txt num c3"/></td>
						<td style="text-align:center;"><input id="chkIsovertime.*" type="checkbox" /></td>
					</tr>
				</tbody>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>