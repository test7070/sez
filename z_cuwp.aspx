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
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			var isSaturday = '0';
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_cuwp');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_cuwp',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : r_accy
					}, {
						type : '1', //[2][3]
						name : 'xdate'
					}, {
						type : '2', //[4][5]
						name : 'xstationno',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					}, {
					}]
				});
				$('#q_report').click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					if((t_index==0 || t_index==1)){
						$('.prt').hide();
						$('#chart,#chartCtrl').show();
					}else{
						$('.prt').show();
						$('#chart,#chartCtrl').hide();
					}
				});
				q_popAssign();
				q_langShow();
				isSaturday = (q_getPara('sys.saturday').toString()=='1'?'1':'0');
				$('#btnXXX').click(function(e) {
					btnAuthority(q_name);
				});
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate2').mask('999/99/99');
				/* 終止日預設為起始日之月份最後一日*/
				$('#txtXdate1').focusout(function() {
					var Xdate1 = $('#txtXdate1').val();
					var lastDays = '', w_year = '', w_mon = '';
					if (Xdate1.length == 9) {
						w_year = Xdate1.substring(0, 3);
						w_mon = padL(Xdate1.substring(4, 6), '0', 2);
						lastDays = $.datepicker._getDaysInMonth(w_year, w_mon - 1);
						$('#txtXdate2').val(w_year + '/' + w_mon + '/' + lastDays);
					}
				});
				var t_date, t_year, t_month, t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
				$("#btnRun").click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					var txtreport = $('#q_report').data('info').reportData[t_index].report;
					if(emp($('#txtXdate1').val()))
						$('#txtXdate1').val(q_date());
					if(emp($('#txtXdate2').val()))
						$('#txtXdate2').val(q_date());
					var t_xbdate='#non',t_xedate='#non',t_xbstationno='#non',t_xestationno='#non';
					if(!emp($('#txtXdate1').val()))
						t_xbdate=encodeURI($('#txtXdate1').val());
					if(!emp($('#txtXdate2').val()))
						t_xedate=encodeURI($('#txtXdate2').val());
					if(!emp($('#txtXstationno1a').val()))
						t_xbstationno=encodeURI($('#txtXstationno1a').val());
					if(!emp($('#txtXstationno2a').val()))
						t_xestationno=encodeURI($('#txtXstationno2a').val());
					Lock();
					q_func('qtxt.query.'+txtreport,'z_cuwp.txt,'+txtreport+','+ t_xbdate + ';' + t_xedate + ';'+ t_xbstationno + ';'+ t_xestationno+ ';' + isSaturday + ';');
				});
			}
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.z_cuwp2':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var OutHtm= '<table id="tTable" border="1px" cellpadding="0" cellspacing="0">';
							var Html01='<tr><td class="tMain tTitle" colspan="2">　　工作中心→<br>項目↓</td>';
							var Html02='<tr><td class="tMain tLeft" colspan="2">基本產能</td>';
							var Html03='<tr><td class="tMain tLeft" colspan="2">工時</td>';
							var Html04='<tr><td class="tMain tLeft" colspan="2">製令工時</td>';
							var Html05='<tr><td class="tMain tLeft tSum" colspan="2">製令工時累計</td>';
							var Html06='<tr><td class="tMain tLeft" colspan="2">製令數</td>';
							var Html07='<tr><td class="tMain tLeft tSum" colspan="2">製令數累計</td>';
							var Html08='<tr><td class="tMain tLeft" colspan="2">完工數量</td>';
							var Html09='<tr><td class="tMain tLeft tSum" colspan="2">完工數量累計</td>';
							var Html10='<tr><td class="tMain tLeft" colspan="2">加班製令數</td>';
							var Html11='<tr><td class="tMain tLeft tSum" colspan="2">加班製令數累計</td>';
							var Html12='<tr><td class="tMain tLeft" colspan="2">加班產量</td>';
							var Html13='<tr><td class="tMain tLeft tSum" colspan="2">加班產量累計</td>';
							var Html14='<tr><td class="tMain tLeft" colspan="2">加班時數</td>';
							var Html15='<tr><td class="tMain tLeft tSum" colspan="2">加班累計</td>';
							var Html16='<tr><td class="tMain tRow" rowspan="12" valign="middle">停<br>機<br>原<br>因<br>及<br>時<br>數</td><td class="tMain tRowItem">換膜</td>';
							var Html17='<tr><td class="tMain tRowItem tSum">累計</td>';
							var Html18='<tr><td class="tMain tRowItem">故障</td>';
							var Html19='<tr><td class="tMain tRowItem tSum">累計</td>';
							var Html20='<tr><td class="tMain tRowItem">延遲</td>';
							var Html21='<tr><td class="tMain tRowItem tSum">累計</td>';
							var Html22='<tr><td class="tMain tRowItem">待單</td>';
							var Html23='<tr><td class="tMain tRowItem tSum">累計</td>';
							var Html24='<tr><td class="tMain tRowItem">待料</td>';
							var Html25='<tr><td class="tMain tRowItem tSum">累計</td>';
							var Html26='<tr><td class="tMain tRowItem">缺員</td>';
							var Html27='<tr><td class="tMain tRowItem tSum">累計</td>';
							var Html28='<tr><td class="tMain tRow" rowspan="3" valign="middle">人<br>員</td><td>編制</td>';
							var Html29='<tr><td class="tMain tRowItem">支援</td>';
							var Html30='<tr><td class="tMain tRowItem">間接</td>';
							var t_workhours=0,t_workmount=0,t_mount=0,t_addwork=0,t_addmount=0;
							var t_addhours=0,t_chgtime=0,t_faulttime=0,t_delaytime=0,t_waittime=0;
							var t_waitfedtime=0,t_lacksss=0;
							for(var k=0;k<as.length;k++){
								t_workhours = q_add(t_workhours,dec(as[k].workhours));
								t_workmount = q_add(t_workmount,dec(as[k].workmount));
								t_mount = q_add(t_mount,dec(as[k].mount));
								t_addwork = q_add(t_addwork,dec(as[k].addwork));
								t_addmount = q_add(t_addmount,dec(as[k].addmount));
								t_addhours = q_add(t_addhours,dec(as[k].addhours));
								t_chgtime = q_add(t_chgtime,dec(as[k].chgtime));
								t_faulttime = q_add(t_faulttime,dec(as[k].faulttime));
								t_delaytime = q_add(t_delaytime,dec(as[k].delaytime));
								t_waittime = q_add(t_waittime,dec(as[k].waittime));
								t_waitfedtime = q_add(t_waitfedtime,dec(as[k].waitfedtime));
								t_lacksss = q_add(t_lacksss,dec(as[k].lacksss));
								Html01 += '<td class="tMain tTitle" valign="middle">'+as[k].stationno+ '<br>' + as[k].station +'</td>';
								Html02 += '<td class="tNum">'+as[k].gen+'</td>';
								Html03 += '<td class="tNum">'+as[k].hours+'</td>';
								Html04 += '<td class="tNum">'+as[k].workhours+'</td>';
								Html05 += '<td class="tNum tSum">'+t_workhours+'</td>';
								Html06 += '<td class="tNum">'+as[k].workmount+'</td>';
								Html07 += '<td class="tNum tSum">'+t_workmount+'</td>';
								Html08 += '<td class="tNum">'+as[k].mount+'</td>';
								Html09 += '<td class="tNum tSum">'+t_mount+'</td>';
								Html10 += '<td class="tNum">'+as[k].addwork+'</td>';
								Html11 += '<td class="tNum tSum">'+t_addwork+'</td>';
								Html12 += '<td class="tNum">'+as[k].addmount+'</td>';
								Html13 += '<td class="tNum tSum">'+t_addmount+'</td>';
								Html14 += '<td class="tNum">'+as[k].addhours+'</td>';
								Html15 += '<td class="tNum tSum">'+t_addhours+'</td>';
								Html16 += '<td class="tNum">'+as[k].chgtime+'</td>';
								Html17 += '<td class="tNum tSum">'+t_chgtime+'</td>';
								Html18 += '<td class="tNum">'+as[k].faulttime+'</td>';
								Html19 += '<td class="tNum tSum">'+t_faulttime+'</td>';
								Html20 += '<td class="tNum">'+as[k].delaytime+'</td>';
								Html21 += '<td class="tNum tSum">'+t_delaytime+'</td>';
								Html22 += '<td class="tNum">'+as[k].waittime+'</td>';
								Html23 += '<td class="tNum tSum">'+t_waittime+'</td>';
								Html24 += '<td class="tNum">'+as[k].waitfedtime+'</td>';
								Html25 += '<td class="tNum tSum">'+t_waitfedtime+'</td>';
								Html26 += '<td class="tNum">'+as[k].lacksss+'</td>';
								Html27 += '<td class="tNum tSum">'+t_lacksss+'</td>';
								Html28 += '<td class="tNum">'+as[k].mans+'</td>';
								Html29 += '<td class="tNum">'+as[k].supmans+'</td>';
								Html30 += '<td class="tNum">'+as[k].managermans+'</td>';
							}
							OutHtm += Html01+'</tr>'+Html02+'</tr>'+Html03+'</tr>'+Html04+'</tr>'+
									 Html05+'</tr>'+Html06+'</tr>'+Html07+'</tr>'+Html08+'</tr>'+
									 Html09+'</tr>'+Html10+'</tr>'+Html11+'</tr>'+Html12+'</tr>'+
									 Html13+'</tr>'+Html14+'</tr>'+Html15+'</tr>'+Html16+'</tr>'+
									 Html17+'</tr>'+Html18+'</tr>'+Html19+'</tr>'+Html20+'</tr>'+
									 Html21+'</tr>'+Html22+'</tr>'+Html23+'</tr>'+Html24+'</tr>'+
									 Html25+'</tr>'+Html26+'</tr>'+Html27+'</tr>'+Html28+'</tr>'+
									 Html29+'</tr>'+Html30+'</tr>' + '</table>';
							$('#chart').html(OutHtm);
						}
						break;
					case 'qtxt.query.z_cuwp3':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var t_color = ['goldenrod','beige','darksalmon','seashell','pink'];
							var t_colors = ['bisque','aquamarine','lightblue'];
							var t_date=$('#txtXdate1').val();
							var t_count=1,tt_count=1;
							var OutHtm= '';
							OutHtm+= '<tr><td colspan="2">　　　　　日期→<br>機台↓　　　　　</td>';
							while(t_date<=$('#txtXdate2').val() &&t_count<32){
								OutHtm+='<td>'+t_date+'</td>';
								t_date=q_cdn(t_date,1);
								t_count++;
							}
							OutHtm+= '</tr>';
							OutHtm= '<table id="cTable" border="1px" cellpadding="0" cellspacing="0" width="'+((t_count*80)+200)+'px">'+OutHtm;
							
							for(var i=0;i<as.length;i=i+5){
								OutHtm+='<tr style="width: 100px;">'
								OutHtm+='<td rowspan="5">'+((i+5)==as.length?'總計':(as[i].station))+'</td>';
								OutHtm+='<td style="width: 90px;text-align: left;">排產機時</td>';
								tt_count=1;
								while(tt_count<t_count){
									OutHtm+='<td style="width: 80px;">'+round(dec(eval('as[i].days'+('00'+tt_count).substr(-2))),2)+'</td>';
									tt_count++;
								}
								OutHtm+= '</tr><tr>';
								OutHtm+='<td style="text-align: left;">編制機時</td>';
								tt_count=1;
								while(tt_count<t_count){
									OutHtm+='<td>'+round(dec(eval('as[i+1].days'+('00'+tt_count).substr(-2))),2)+'</td>';
									tt_count++;
								}
								OutHtm+= '</tr><tr>';
								OutHtm+='<td style="text-align: left;">標準日機時</td>';
								tt_count=1;
								while(tt_count<t_count){
									OutHtm+='<td>'+round(dec(eval('as[i+2].days'+('00'+tt_count).substr(-2))),2)+'</td>';
									tt_count++;
								}
								OutHtm+= '</tr><tr>';
								OutHtm+='<td style="text-align: left;">出勤人數</td>';
								tt_count=1;
								while(tt_count<t_count){
									OutHtm+='<td>'+round(dec(eval('as[i+3].days'+('00'+tt_count).substr(-2))),0)+'</td>';
									tt_count++;
								}
								OutHtm+= '</tr><tr>';
								OutHtm+='<td style="text-align: left;">編制人時</td>';
								tt_count=1;
								while(tt_count<t_count){
									OutHtm+='<td>'+round(eval('as[i+4].days'+('00'+tt_count).substr(-2)),2)+'</td>';
									tt_count++;
								}
								OutHtm+= '</tr>';
							}
							OutHtm+= '</table>';
							$('#chart').html(OutHtm);
						}
						break;
				}
				Unlock();
			}
		</script>
		<style>
			#chart td{
				text-align:center;
			}
			.tMain{
				width:60px;
				height:25px;
			}
			#chart .tTitle{
				width:120px;
				background-color:rgb(255,255,153);
			}
			#chart .tNum{
				text-align:right;
				padding-right:3px;
			}
			#chart .tSum{
				background-color:rgb(205,255,255);
			}
			#chart .tRow{
				width:40px;
			}
			#chart .tRowItem{
				width:80px;
			}
			#chart .tLeft{
				text-align:left;
				padding-left:3px;
			}

		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container" style="width:2000px;">
				<div id="q_report"> </div>
			</div>
			<div id="chartCtrl" style="display:inline-block;width:2000px;">
				<input type="button" id="btnRun" style="float:left; width:80px;font-size: medium;" value="執行"/>
				<input type="button" id="btnXXX" style="float:left; width:80px;font-size: medium;" value="權限"/>
				<!--
				<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
				-->
			</div>
			<div id="chart">
			</div>
			<div class="prt" style="margin-left: -40px;display:none;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
		<div id="q_acDiv" style="display: none;"><div> </div></div>
	</body>
</html>