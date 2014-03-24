<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			if(location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;100";
			}
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_workgg');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_workgg',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1', //[2][3]
						name : 'xdate'
					}]
				});
				q_langShow();
				q_popAssign();
				q_getFormat();
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate1').val(q_date());
				$('#txtXdate2').val(q_cdn(q_date(),15));
				$('#btnXXX').click(function(e) {
					btnAuthority(q_name);
				});
				$("#btnRun").click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					var txtreport = $('#q_report').data('info').reportData[t_index].report;
					if(emp($('#txtXdate1').val()))
						$('#txtXdate1').val(q_date());
					if(emp($('#txtXdate2').val()))
						$('#txtXdate2').val(q_date());
					var t_xbdate='#non',t_xedate='#non';
					if(!emp($('#txtXdate1').val()))
						t_xbdate=encodeURI($('#txtXdate1').val());
					if(!emp($('#txtXdate2').val()))
						t_xedate=encodeURI($('#txtXdate2').val());
					q_func('qtxt.query','z_workgg.txt,'+txtreport+','+ t_xbdate + ';' + t_xedate + ';');
				});
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var maxCount = dec(as[0].maxCount);
							var t_TableStr = '<table id="tTable" border="1px" cellpadding="0" cellspacing="0">';
							//產生標題<<Start>>
							t_TableStr = t_TableStr + '<tr>';
							t_TableStr = t_TableStr + '<td class="tTitle" colspan="2">工作中心</td>';
							for(var j=1;j<=maxCount;j++){
								t_TableStr = t_TableStr + '<td class="tTitle tWidth">' + q_cdn($('#txtXdate1').val(),(j-1)) + '</td>';
							}
							t_TableStr = t_TableStr + '<td class="tTitle tWidth">合計</td>';
							t_TableStr = t_TableStr + '</tr>';
							//產生標題<<End>>
							for(var k=0;k<as.length;k++){
								var t_gno = as[k].gno;
								t_TableStr = t_TableStr + '<tr>';
								var t_stationno = $.trim(as[k]['stationno']);
								var t_stations = $.trim(as[k]['stations']);
								if(((t_stationno.length>0) && (t_stations.length>0)) || (t_gno=='1')){
									if(t_gno=='0'){
										t_TableStr = t_TableStr + '<td class="tWidth_Station">' + as[k]['stationno'] + '</td>';//列出工作站
										t_TableStr = t_TableStr + '<td class="tWidth_Station">' + as[k]['stations'] + '</td>';//列出工作站
										for(var j=1;j<=maxCount;j++){
											var thisVal = dec(as[k]['v'+padL(j,'0',2)]);
											t_TableStr = t_TableStr + '<td class="num">' + round(thisVal,3) + '</td>';
										}
									}else if(t_gno=='1'){
										t_TableStr = t_TableStr + '<td class="tTotal" colspan="2">總計：</td>';
										for(var j=1;j<=maxCount;j++){
											var thisVal = dec(as[k]['v'+padL(j,'0',2)]);
											t_TableStr = t_TableStr + '<td class="tTotal num">' + round(thisVal,3) + '</td>';
										}
									}
									t_TableStr = t_TableStr + '<td class="'+(t_gno=='1'?'tTotal ':'')+'num">' + round(dec(as[k]['v'+padL((maxCount+1),'0',2)]),3) +'</td>';
									t_TableStr = t_TableStr + '</tr>';
								}
							}
							t_TableStr = t_TableStr + "</table>";
							var t_totalWidth = 0;
							t_totalWidth = ((100+2)*(2))+((70+2)*(maxCount+1))+10;
							$('#chart').css('width',t_totalWidth+'px').html(t_TableStr);
						}
						break;
				}
			}
		</script>
		<style type="text/css">
			#tTable{
				table-layout: fixed;
			}
			.tTitle{
				text-align:center;
				background: #FF9;
			}
			.tTotal{
				text-align:right;
				background: #CFF;
			}
			.num{
				text-align:right;
				padding-right:2px;
			}
			.tWidth_Station{
				padding-left:2px;
				width:100px;
			}
			.tWidth{
				width:70px;
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