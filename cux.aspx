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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;

			q_tables = 's';
			var q_name = "cux";
			var q_readonly = ['txtNoa','txtStation','txtStationg','txtDatea','txtStationgno','txtStationg','txtWorker','txtWorker2'];
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
				['txtStationno', 'lblStationno', 'station', 'noa,station,stationgno,stationg', 'txtStationno,txtStation,txtStationgno,txtStationg', 'station_b.aspx']
				//['txtStationgno', 'lblStationgno', 'stationg', 'noa,namea', 'txtStationgno,txtStationg', 'stationg_b.aspx']
			);
			var WorkTimeArray = new Array();
			var WorkTimeList ='@';
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('cuwa', '', 0, 0, 0, "");
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea',r_picd],['txtBdate',r_picd],['txtEdate',r_picd]];
				bbsMask = [['txtWorktime','9999-9999']];
				q_mask(bbmMask);
				q_gt('part', '', 0, 0, 0, "");
				
				$('#btnCopy').click(function() {
					$('#textCopybdate').val(q_cdn(q_date(),1));
					$('#textCopyedate').val(q_cdn(q_date(),16));
					if(q_getPara('sys.saturday').toString()=='1')
						$('#checkSaturday').prop('checked','true')
					else
						$('#checkSaturday').prop('checked','')
					$('#checkSunday').prop('checked','')
					$('#div_copy').css('top', $('#btnCopy').offset().top+25);
					$('#div_copy').css('left', $('#btnCopy').offset().left-$('#div_copy').width()+$('#btnCopy').width()+10);
					$('#div_copy').toggle();
				});
				//DIV事件---------------------------------------------------
				$('#textCopybdate').mask('999/99/99');
				$('#textCopybdate').datepicker();
				$('#textCopyedate').mask('999/99/99');
				$('#textCopyedate').datepicker();
				
				$('#btn_div_copy').click(function() {
					if(emp($('#textCopybdate').val()) || emp($('#textCopyedate').val())){
						alert('請填寫日期區間!!');
						return;
					}

					var t_week='';
					if(!$('#div_copyweek').is(':hidden')){
						$('#div_copyweek input[type="checkbox"]').each(function(){
							if($(this).prop('checked'))
								t_week+=$(this).val()+'^';
						});
					}
					
					if(t_week=='')
						t_week='#non';
					
					var t_copy_noa=trim($('#txtNoa').val());
					if(t_copy_noa.length<=0)
						return;
					var t_copy_bdate=!emp($('#textCopybdate').val())?trim($('#textCopybdate').val()):'#non';
					var t_copy_edate=!emp($('#textCopyedate').val())?trim($('#textCopyedate').val()):'#non';
					var t_copy_saturday=$('#checkSaturday').prop('checked')?'1':'#non';
					var t_copy_sunday=$('#checkSunday').prop('checked')?'1':'#non';
										
					$('#btn_div_copy').attr('disabled', 'disabled');
					$('#btn_div_copy').val('更新中....');
					q_func('qtxt.query.cuxcopy', 'cux.txt,cuxcopy,'+t_copy_noa+';'+t_copy_bdate+';'+t_copy_edate+';'+t_copy_saturday+';'+t_copy_sunday+';'+t_week+';'+r_name);
					$('#div_copyweek').hide();
				});
				
				$('#btnClose_div_copy').click(function() {
					$('#div_copy').hide();
					$('#div_copyweek').hide();
				});
				
				$('#btn_div_copyweek').click(function() {
					//產生勾選日期
					var week_bdate=$('#textCopybdate').val();
					var week_edate=$('#textCopyedate').val();
					if(week_bdate=='' || week_edate=='')
						return;
					$('#div_copyweek').show();
					if(week_bdate=='' && week_edate==''){
						week_bdate=q_date();
						week_edate=q_cdn(q_date(),13);
					}else if(week_bdate!='' && week_edate==''){
						week_edate=q_cdn(week_bdate,13);
					}else if(week_bdate=='' && week_edate!=''){
						week_bdate=q_cdn(week_edate,-13);
					}
					
					var tmp_checkbox='',t_week=1;
					if(q_holiday==undefined)
						q_holiday=[];
					while(week_bdate<=week_edate){
						if(q_holiday.indexOf(week_bdate)>-1 || getweek(week_bdate)=='日' || (getweek(week_bdate)=='六' && q_getPara('sys.saturday').toString()=='0'))
							tmp_checkbox += "<div style='float:left;text-align: center;'>&nbsp;<a class='lbl' id='week_" + t_week + "' style='color:red;'>" + week_bdate +"("+getweek(week_bdate)+")</a>&nbsp;<BR>"
							+"<input id='checkweek" + t_week + "' type='checkbox' value='" + week_bdate +"'/></div>";
						else{
							tmp_checkbox += "<div style='float:left;text-align: center;'>&nbsp;<a class='lbl' id='week_" + t_week + "' >" + week_bdate +"("+getweek(week_bdate)+")</a>&nbsp;<BR>"
							+"<input id='checkweek" + t_week + "' type='checkbox' value='" + week_bdate +"'/></div>";
						}
						week_bdate=q_cdn(week_bdate,1);
						t_week++;
					}
					$('#div_copyweek').html(tmp_checkbox);
					$('#div_copyweek').css('top', $('#div_copy').offset().top+$('#div_copy').height()+5);
					$('#div_copyweek').css('left', $('#div_copy').offset().left);
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
					case 'qtxt.query.cuxcopy':
                		alert("更新完成!!");
                		$('#btn_div_copy').removeAttr('disabled');
                		$('#btn_div_copy').val('更新');
                		$('#div_copy').hide();
                	break;
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
						//q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'sssall':
						var as = _q_appendData("sssall", "", true);
						var now_txtObject;
						var now_mountObject;
						if($('#combPartno3_'+thisSeq).val() != ''){
							now_txtObject = $('#txtManager_'+thisSeq);
							now_mountObject = $('#txtManagermans_'+thisSeq);
							$('#combPartno3_'+thisSeq).val('');
						}
						var AllName = $.trim($('#txtManager_'+thisSeq).val());
						for(var i = 0;i < as.length;i++){
							var AllName = $.trim($('#txtManager_'+thisSeq).val());
							str = now_txtObject.val();
							name = as[i].namea;
							if(AllName.match(name) == null){
								newstr = str + name + ';';
								now_txtObject.val(newstr);
							}
						}
						now_mountObject.val(now_txtObject.val().split(';').length-1);
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
						var now_txtObject;
						var now_mountObject;
						if($('#combPartno3_'+thisSeq).val() != ''){
							now_txtObject = $('#txtManager_'+thisSeq);
							now_mountObject = $('#txtManagermans_'+thisSeq);
							$('#combPartno3_'+thisSeq).val('');
						}
						b_ret = getb_ret();
						if (!b_ret || b_ret.length == 0)
							return;
						for(var i = 0;i < b_ret.length;i++){
							var AllName = $.trim($('#txtManager_'+thisSeq).val());
							str = now_txtObject.val();
							name = b_ret[i].namea;
							if(AllName.match(name) == null){
								newstr = str + name + ';';
								now_txtObject.val(newstr);
							}
						}
						now_mountObject.val(now_txtObject.val().split(';').length-1);
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('cuw_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtBdate').val(q_date());
				$('#txtEdate').val(q_date());
				$('#txtBdate').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box('z_cuxp.aspx' + "?;;;;" + r_accy + ";", '', "95%", "95%", m_print);
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtBdate', q_getMsg('lblBdate')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				//103/12/16 為配合產能編制cugt 讓其人員編制也用一天來編制 提供複製功能
				//edate 隱藏 寫入bdate
				$('#txtEdate').val($('#txtBdate').val());
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cux') + q_date(), '/', ''));
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
				as['datea'] = abbm2['datea'];
				as['stationno'] = abbm2['stationno'];
				return true;
			}
			
			function refresh(recno) {
				_refresh(recno);
				comb_disabled();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				comb_disabled();
			}
			
			function comb_disabled() {
				if(q_cur == 1 || q_cur == 2){
					$('#btnCopy').attr('disabled','disabled');
					for(var k=0;k<q_bbsCount;k++){
						$('#combPartno3_'+k).removeAttr('disabled');
						$('#combPartno3_'+k).css('background-color', 'rgb(255, 255, 255)');
					}
				}else{
					$('#btnCopy').removeAttr('disabled');
					for(var k=0;k<q_bbsCount;k++){
						$('#combPartno3_'+k).attr('disabled','disabled');
						$('#combPartno3_'+k).css('background-color', 'rgb(237, 237, 238)');
					}
				}
			}

			function btnMinus(id) {
				_btnMinus(id);

			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
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
						$("#combPartno3_"+i).change(function() {
							combtodo($(this));
						});
						$("#txtManager_"+i).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var thisVal = $.trim($(this).val());
							$('#txtManagermans_'+n).val(thisVal.split(';').length-1);
						});
						$('#txtWorktime_' + i).focusout(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var thisVal = $.trim($(this).val());
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

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			function q_popPost(id) {
				switch (id) {
					default:
						break;
				}
			}
			
			function getweek(t_date) {
            	switch (new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()) {
            		case 0:
            			return '日'; 
            			break;
            		case 1:
            			return '一';
            			break;
            		case 2:
            			return '二';
            			break;
            		case 3:
            			return '三';
            			break;
            		case 4:
            			return '四';
            			break;
            		case 5:
            			return '五';
            			break;
            		case 6:
            			return '六';
            			break;
            		default:
            			return '';
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
			.dbbs {
				width: 850px;
			}
			.dbbs .tbbs {
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
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
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
		<div id="div_copy" style="position:absolute; top:0px; left:0px; display:none; width:650px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_copy" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">日期區間</td>
					<td style="background-color: #f8d463;">
						<input id='textCopybdate' type='text' style='text-align:left;width:100px;'/>	~
						<input id='textCopyedate' type='text' style='text-align:left;width: 100px;'/>	
						包含	<input id="checkSaturday" type="checkbox">	六 		<input id="checkSunday" type="checkbox">	日
						<input id="btn_div_copyweek" type="button" style="float: right;margin-right: 75px;" value="挑選日期">
					</td>
				</tr>
				<tr id='copy_close'>
					<td align="center" colspan='2'>
						<input id="btn_div_copy" type="button" value="複製">
						<input id="btnClose_div_copy" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="div_copyweek" style="position:absolute; top:0px; left:0px; display:none; width:600px; background-color: rgb(255, 240, 237); border: 5px solid gray;">	</div>
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:120px; color:black;"><a id='vewBdate'> </a></td>
						<td style="width:120px; color:black;"><a id='vewStationg'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='bdate' style="text-align: center;">~bdate</td>
						<td id='stationg' style="text-align: center;">~stationg</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td><input id="txtCheckno" type="text" style="display:none;"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBdate" class="lbl"> </a></td>
						<td>
							<input id="txtBdate" type="text" class="txt c1"/>
							<!--<span style="width:10%;text-align:center;float:left;">～</span>-->
							<input id="txtEdate" type="text" class="txt" style="display: none;"/>						
						</td>
						<td> </td>
						<td> </td>
						<td><input type="button" class="" id="btnCopy"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStationno" class="lbl btn"> </a></td>
						<td><input id="txtStationno" type="text" class="txt c1"/></td>
						<td><input id="txtStation" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStationgno" class="lbl"> </a></td>
						<td><input id="txtStationgno" type="text" class="txt c1"/></td>
						<td><input id="txtStationg" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:120px; text-align: center;"><a id='lblWorktime_s'> </a></td>
						<td style="width:80px; text-align: center;"><a id='lblManagermans_s'> </a></td>
						<td style="width:360px; text-align: center;"><a id='lblManager_s'> </a></td>
						<td style="width:80px; text-align: center;"><a id='lblHours_s'> </a></td>
						<td style="width:80px; text-align: center;"><a id='lblAddhours_s'> </a></td>
						<td style="width:40px;"><a id='lblIsovertime_s'> </a></td>
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
						<td><input id="chkIsovertime.*" type="checkbox" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>