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
			var isSaturday = '0';
			if(location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;100";
			}
			$(document).ready(function() {
				q_getId();
				q_gt('uccga', '', 0, 0, 0, "");
			});
			var xgroupanoStr = '';
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
					}, {
						type : '2', //[4][5]
						name : 'xstationno',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					}, {
						type : '8', //[6]
						name : 'xshowdiff',
						value : ('1@僅顯示差異>+-0.5').split(',')
					}, {
						type : '5', //[7]
						name : 'xgroupano',
						value : xgroupanoStr.split(',')
					}, {
						type : '2', //[8][9]
						name : 'xproductno',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}]
				});
				$('#q_report').click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					if((t_index==0) || (t_index==1) || (t_index==5)){
						$('.prt').hide();
						$('#chart,#chartCtrl').show();
					}else{
						$('.prt').show();
						$('#chart,#chartCtrl').hide();
					}
				});
				q_langShow();
				q_popAssign();
				q_getFormat();
				isSaturday = (q_getPara('sys.saturday').toString()=='1'?'1':'0');
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate1').val(q_date());
				$('#txtXdate2').val(q_cdn(q_date(),15));
				$('#btnXXX').click(function(e) {
					btnAuthority(q_name);
				});
				$('#Xgroupano select').css('width','200px');
				$("#btnRun").click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					var txtreport = $('#q_report').data('info').reportData[t_index].report;
					if(emp($('#txtXdate1').val()))
						$('#txtXdate1').val(q_date());
					if(emp($('#txtXdate2').val()))
						$('#txtXdate2').val(q_date());
					var t_xbdate='#non',t_xedate='#non',t_xbstationno='#non',t_xestationno='#non',t_xbproductno='#non',t_xeproductno='#non',t_xgroupano='#non';
					if(!emp($('#txtXdate1').val()))
						t_xbdate=encodeURI($('#txtXdate1').val());
					if(!emp($('#txtXdate2').val()))
						t_xedate=encodeURI($('#txtXdate2').val());
					if(!emp($('#txtXstationno1a').val()))
						t_xbstationno=encodeURI($('#txtXstationno1a').val());
					if(!emp($('#txtXstationno2a').val()))
						t_xestationno=encodeURI($('#txtXstationno2a').val());
					if(!emp($('#txtXproductno1a').val()))
						t_xbproductno=encodeURI($('#txtXproductno1a').val());
					if(!emp($('#txtXproductno2a').val()))
						t_xeproductno=encodeURI($('#txtXproductno2a').val());
					if(!emp($('#Xgroupano select').val()))
						t_xgroupano=encodeURI($('#Xgroupano select').val());
					Lock();
					q_func('qtxt.query.'+txtreport,'z_workgg.txt,'+txtreport+','+ t_xbdate + ';' + t_xedate + ';' + isSaturday + ';'+ t_xbstationno + ';'+ t_xestationno + ';'+ t_xgroupano + ';'+ t_xbproductno + ';'+ t_xeproductno + ';');
				});
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						var t_item = "#non@全部";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
						}
						xgroupanoStr = t_item;
						q_gf('', 'z_workgg');
						break;
				}
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.z_workgg1':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var maxCount = dec(as[0].maxCount);
							var t_TableStr = '<table id="tTable" border="1px" cellpadding="0" cellspacing="0">';
							//產生標題<<Start>>
							t_TableStr = t_TableStr + '<tr>';
							t_TableStr = t_TableStr + '<td class="tTitle" colspan="2" rowspan="2">工作中心</td>';
							t_TableStr = t_TableStr + '<td class="tTitle tWidth" rowspan="2">日產能</td>';
							t_TableStr = t_TableStr + '<td class="tTitle tWidth" rowspan="2">稼動率</td>';
							var tmpTd = '';
							var dateCount = 0;
							var DayName = ['週日','週一','週二','週三','週四','週五','週六'];
							for(var j=1;j<=maxCount;j++){
								dateCount++;
								while(1==1){
									var t_date = q_cdn($('#txtXdate1').val(),(dateCount-1));
									var t_Addate = (parseInt(t_date.substring(0,3))+1911)+t_date.substring(3);
									var thisDate = new Date(t_Addate);
									var thisDate_day = thisDate.getDay();
									if(((isSaturday=='1') || (isSaturday!='1' && thisDate_day!=6)) && (thisDate_day != 0)){
										t_TableStr = t_TableStr + '<td class="tTitle tWidth">' + t_date.substr(4) + '</td>';
										tmpTd = tmpTd + '<td class="tTitle tWidth">' + DayName[thisDate_day] + '</td>';
										break;
									}else{
										dateCount++;
									}
								}
							}
							t_TableStr = t_TableStr + '<td class="tTitle tWidth" rowspan="2">合計</td>';
							t_TableStr = t_TableStr + '</tr>';
							t_TableStr = t_TableStr + '<tr>';
							t_TableStr = t_TableStr + tmpTd;
							t_TableStr = t_TableStr + '</tr>';
							//產生標題<<End>>
							//產生值<<Start>>
							for(var k=0;k<as.length;k++){
								var t_gno = as[k].gno;
								t_TableStr = t_TableStr + '<tr>';
								var t_stationno = $.trim(as[k]['stationno']);
								var t_stations = $.trim(as[k]['stations']);
								if(((t_stationno.length>0) && (t_stations.length>0)) || (t_gno=='1')){
									if(t_gno=='0'){
										t_TableStr = t_TableStr + '<td class="tWidth_Station">' + as[k]['stationno'] + '</td>';//列出工作站
										t_TableStr = t_TableStr + '<td class="tWidth_Station">' + as[k]['stations'] + '</td>';//列出工作站
										t_TableStr = t_TableStr + '<td class="num">' + dec(as[k]['hours']) + '</td>';//列出工作站
										t_TableStr = t_TableStr + '<td class="num">' + round(dec(as[k]['rate']),3) + '%</td>';//列出工作站
										for(var j=1;j<=maxCount;j++){
											var thisVal = dec(as[k]['v'+padL(j,'0',2)]);
											t_TableStr = t_TableStr + '<td class="num">' + round(thisVal,3) + '</td>';
										}
									}else if(t_gno=='1'){
										t_TableStr = t_TableStr + '<td class="tTotal" colspan="2">總計：</td>';
										t_TableStr = t_TableStr + '<td class="tTotal num">'+dec(as[k]['hours'])+'</td>';
										t_TableStr = t_TableStr + '<td class="tTotal num">'+dec(as[k]['rate'])+'%</td>';
										for(var j=1;j<=maxCount;j++){
											var thisVal = dec(as[k]['v'+padL(j,'0',2)]);
											t_TableStr = t_TableStr + '<td class="tTotal num">' + round(thisVal,3) + '</td>';
										}
									}
									t_TableStr = t_TableStr + '<td class="'+(t_gno=='1'?'tTotal ':'')+'num">' + round(dec(as[k]['v'+padL((maxCount+1),'0',2)]),3) +'</td>';
									t_TableStr = t_TableStr + '</tr>';
								}
							}
							//產生值<<END>>
							t_TableStr = t_TableStr + "</table>";
							var t_totalWidth = 0;
							t_totalWidth = ((100+2)*(2))+((70+2)*(maxCount+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(t_TableStr);
						}
						break;
					case 'qtxt.query.z_workgg5':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var t_bdate = $.trim($('#txtXdate1').val());
							var t_edate = $.trim($('#txtXdate2').val());
							t_bdate = (t_bdate.length==9?t_bdate:q_date());
							var t_bADdate = dec(t_bdate.substring(0,3))+1911+t_bdate.substr(3);
							var t_edate = $.trim($('#txtXdate2').val());
							t_edate = (t_edate.length==9?t_edate:q_date());
							var t_eADdate = dec(t_edate.substring(0,3))+1911+t_edate.substr(3);
							var myStartDate = new Date(t_bADdate);
							var myEndDate = new Date(t_eADdate);
							var DiffDays = ((myEndDate - myStartDate)/ 86400000);
							var DateList = [];
							var DateObj = [];
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = dec(thisDay.substring(0,3))+1911+thisDay.substr(3);
								if((new Date(thisADday).getDay())!=0){
									DateList.push(thisDay);
									DateObj.push({
										datea:thisDay,
										value:0
									});
								}
							}
							var TL = [];
							var OutHtml= '<table id="tTable" border="1px" cellpadding="0" cellspacing="0">';
							for(var i=0;i<as.length;i++){
								var isFind = false;
								for(var j=0;j<TL.length;j++){
									if((as[i].stationno==TL[j].stationno) && (as[i].productno==TL[j].productno)){
										isFind = true;
									}
								}
								if(!isFind){
									TL.push({
										stationno : as[i].stationno,
										station : as[i].station,
										productno : as[i].productno,
										product : as[i].product,
										gen : as[i].gen,
										datea : []
									});
								}
							}
							for(var k=0;k<TL.length;k++){
								for(var j=0;j<DateList.length;j++){
									TL[k].datea.push([DateList[j],0]);
								}
							}
							for(var k=0;k<as.length;k++){
								isFind = false;
								for(var j=0;j<TL.length;j++){
									if(isFind) break;
									if((as[k].stationno==TL[j].stationno) && (as[k].productno==TL[j].productno)){
										var TLDatea = TL[j].datea;
										for(var h=0;h<TLDatea.length;h++){
											if(as[k].datea==TLDatea[h][0]){
												TLDatea[h][1] = dec(TLDatea[h][1])+dec(as[k].value);
												isFind = true;
												break;
											}
										}
									}
								}
							}
							OutHtml += '<tr>';
							OutHtml += "<td class='tTitle' style='width:370px;' colspan='2' rowspan='2'>物品</td>" + 
									   "<td class='tTitle' style='width:210px;' colspan='2' rowspan='2'>工作中心</td>" +
									   "<td class='tTitle' style='width:80px;' rowspan='2'>需工時</td>";
							var tmpTd = '<tr>';
							var DayName = ['週日','週一','週二','週三','週四','週五','週六'];
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								var thisADday = dec(thisDay.substring(0,3))+1911+thisDay.substr(3);
								OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(4) + "</td>";
								tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
							}
							OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
							tmpTd += "</tr>"
							OutHtml += '</tr>' + tmpTd;
							var ATotal = 0;
							var GenTotal = 0;
							for(var k=0;k<TL.length;k++){
								OutHtml += '<tr>';
								OutHtml += "<td class='center' style='width:150px;'>" + TL[k].productno + "</td><td class='center' style='width:220px;'>" + TL[k].product + "</td>" + 
										   "<td class='center' style='width:110px;'>" + TL[k].stationno + "</td><td class='center' style='width:100px;'>" + TL[k].station + "</td>" +
										   "<td class='num'>" + TL[k].gen + "</td>";
								GenTotal = q_add(GenTotal,TL[k].gen);
								var TTD = TL[k].datea;
								var tTotal = 0;
								for(var j=0;j<TTD.length;j++){
									tTotal = q_add(tTotal,round(TTD[j][1],3));
									DateObj[j].value = q_add(dec(DateObj[j].value),round(TTD[j][1],3));
									OutHtml += "<td class='num'>" + round(TTD[j][1],3) + "</td>";
								}
								ATotal = q_add(ATotal,tTotal);
								OutHtml += "<td class='num'>" + tTotal + "</td>";
								OutHtml += '</tr>';
							}
							OutHtml += "<tr><td colspan='5' class='tTotal num'>總計：</td>";
							for(var k=0;k<DateObj.length;k++){
								OutHtml += "<td class='tTotal num'>" + round(DateObj[k].value,3) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + round(ATotal,3) + "</td>";
							OutHtml += "</table>"
							var t_totalWidth = 0;
							t_totalWidth = 660+((70+2)*(DateObj.length+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
						break;
					case 'qtxt.query.z_workgg6':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var t_bdate = $.trim($('#txtXdate1').val());
							var t_edate = $.trim($('#txtXdate2').val());
							t_bdate = (t_bdate.length==9?t_bdate:q_date());
							var t_bADdate = dec(t_bdate.substring(0,3))+1911+t_bdate.substr(3);
							var t_edate = $.trim($('#txtXdate2').val());
							t_edate = (t_edate.length==9?t_edate:q_date());
							var t_eADdate = dec(t_edate.substring(0,3))+1911+t_edate.substr(3);
							var myStartDate = new Date(t_bADdate);
							var myEndDate = new Date(t_eADdate);
							var DiffDays = ((myEndDate - myStartDate)/ 86400000);
							var DateList = [];
							var DateObj = [];
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = dec(thisDay.substring(0,3))+1911+thisDay.substr(3);
								if((new Date(thisADday).getDay())!=0){
									DateList.push(thisDay);
									DateObj.push({
										datea:thisDay,
										value:0,
										workmount:0
									});
								}
							}
							var TL = [];
							var OutHtml= '<table id="tTable" border="1px" cellpadding="0" cellspacing="0">';
							for(var i=0;i<as.length;i++){
								var isFind = false;
								for(var j=0;j<TL.length;j++){
									if((as[i].productno==TL[j].productno)){
										isFind = true;
									}
								}
								if(!isFind){
									TL.push({
										productno : as[i].productno,
										product : as[i].product,
										datea : []
									});
								}
							}
							for(var k=0;k<TL.length;k++){
								for(var j=0;j<DateList.length;j++){
									TL[k].datea.push([DateList[j],0/*mount*/,0/*workmount*/]);
								}
							}
							for(var k=0;k<as.length;k++){
								isFind = false;
								for(var j=0;j<TL.length;j++){
									if(isFind) break;
									if((as[k].productno==TL[j].productno)){
										var TLDatea = TL[j].datea;
										for(var h=0;h<TLDatea.length;h++){
											if(as[k].datea==TLDatea[h][0]){
												TLDatea[h][1] = dec(TLDatea[h][1])+dec(as[k].value);
												TLDatea[h][2] = dec(TLDatea[h][2])+dec(as[k].workmount);
												isFind = true;
												break;
											}
										}
									}
								}
							}
							OutHtml += '<tr>';
							OutHtml += "<td class='tTitle' style='width:370px;' colspan='2' rowspan='2'>物品</td>";
							var tmpTd = '<tr>';
							var DayName = ['週日','週一','週二','週三','週四','週五','週六'];
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								var thisADday = dec(thisDay.substring(0,3))+1911+thisDay.substr(3);
								OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(4) + "</td>";
								tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
							}
							OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
							tmpTd += "</tr>"
							OutHtml += '</tr>' + tmpTd;
							var ATotal = 0;
							for(var k=0;k<TL.length;k++){
								OutHtml += '<tr>';
								OutHtml += "<td class='center' style='width:150px;'>" + TL[k].productno + "</td><td class='center' style='width:220px;'>" + TL[k].product + "</td>";
								var TTD = TL[k].datea;
								var tTotal = 0;
								for(var j=0;j<TTD.length;j++){
									tTotal = q_add(tTotal,round(TTD[j][1],3));
									DateObj[j].value = q_add(dec(DateObj[j].value),round(TTD[j][1],3));
									DateObj[j].workmount = q_add(dec(DateObj[j].workmount),round(TTD[j][2],3));
									OutHtml += "<td class='num'>" + round(TTD[j][1],3) + "<br>" + round(TTD[j][2],3) + "</td>";
								}
								ATotal = q_add(ATotal,tTotal);
								OutHtml += "<td class='num'>" + tTotal + "</td>";
								OutHtml += '</tr>';
							}
							OutHtml += "<tr><td colspan='2' class='tTotal num'>總計：</td>";
							for(var k=0;k<DateObj.length;k++){
								OutHtml += "<td class='tTotal num'>" + round(DateObj[k].value,3) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + round(ATotal,3) + "</td>";
							OutHtml += "</table>"
							var t_totalWidth = 0;
							t_totalWidth = 660+((70+2)*(DateObj.length+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
						break;
				}
				Unlock();
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
			.center{
				text-align:center;
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
			.q_report .report {
				position: relative;
				width: 460px;
				margin-right: 2px;
				border: 1px solid #76a2fe;
				background: #EEEEEE;
				float: left;
				border-radius: 5px;
			}
			.q_report .report div {
				display: block;
				float: left;
				width: 230px;
				height: 30px;
				font-size: 14px;
				font-weight: normal;
				cursor: pointer;
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