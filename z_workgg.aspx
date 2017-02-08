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
			var DayName = ['週日','週一','週二','週三','週四','週五','週六'];
			if(location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;100";
			}
			$(document).ready(function() {
				q_getId();
				q_gt('uccga', '', 0, 0, 0, "");
				
				$('#q_report').click(function(e) {
					var n=$('#q_report').data().info.radioIndex;
					if($('#q_report').data().info.reportData[n].report=='z_workgg6'){
						$('#lblXdate').text('預交日');
					}else{
						$('#lblXdate').text(q_getMsg('lblXdate'));
					}
				});
				
			});
			var xgroupanoStr = '';
			var clickIndex = -1;
			var t_xbdate='#non',t_xedate='#non',t_xbstationno='#non',
				t_xestationno='#non',t_xbproductno='#non',t_xeproductno='#non',
				t_xgroupano='#non',t_xshowover='#non',t_xshowfinished='#non',t_xonlyrealwork='#non',
				t_xbstationgno='#non',t_xestationgno='#non'	,t_xcuanoa='#non',t_xcuanoq='#non';

			function q_gfPost() {
				$('#q_report').q_report({//0511
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
					}, {
						type : '8', //[10]
						name : 'xshowover',
						value : ('1@只顯示超負荷').split(',')
					}, {
						type : '8', //[11]
						name : 'xshowfinished',
						value : ('1@只顯示製成品').split(',')
					}, {
						type : '8', //[12]
						name : 'xonlyrealwork',
						value : ('1@排除模擬製令').split(',')
					}, {
						type : '2', //[13][14]
						name : 'xstationgno',
						dbf : 'stationg',
						index : 'noa,namea',
						src : 'stationg_b.aspx'
					},{
						type : '6', //[15]
						name : 'xcuanoa'
					},{
						type : '6', //[16]
						name : 'xcuanoq'
					}, {
						type : '8', //[17]
						name : 'xworkh',
						value : ('1@包含預測、訂單未轉製令').split(',')
					},{
						type : '6', //[18]
						name : 'xenddate'
					}]
				});
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
				$('#q_report').click(function(){
					var ChartShowIndex = [0,1,4,5];
					var parent=document.getElementById("chart");
					if($('#q_report').data('info').radioIndex != clickIndex){
						$('#frameReport').html('');
						$('#chart').html('');
						var t_index = $('#q_report').data('info').radioIndex;
						if($.inArray(t_index,ChartShowIndex) !== -1){
							$('.prt').hide();
							$('#chart,#chartCtrl').show();
							if(parent.innerHTML.indexOf('q_acDiv')==-1){
								var newDiv = document.createElement("Div");
								newDiv.id="q_acDiv";
								parent.appendChild(newDiv);
							}
						}else{
							$('.prt').show();
							$('#chart,#chartCtrl').hide();
							if(parent.innerHTML.indexOf('q_acDiv')>-1){
								var child=document.getElementById("q_acDiv");
								parent.removeChild(child);
							}
						}
						clickIndex = $('#q_report').data('info').radioIndex;
					}
				});
				q_langShow();
				q_popAssign();
				q_getFormat();
				isSaturday = (q_getPara('sys.saturday').toString()=='1'?'1':'0');
				$('#txtXdate1').datepicker().mask(r_picd);
				$('#txtXdate2').datepicker().mask(r_picd);
				$('#txtXenddate').datepicker().mask(r_picd);
				$('#txtXdate1').val(q_date());
				$('#txtXdate2').val(q_cdn(q_date(),15));
				$('#txtXenddate').val(q_date());
				$('#btnXXX').click(function(e) {
					btnAuthority(q_name);
				});
				$('#Xgroupano select').css('width','200px');
				
				$('#Xshowdiff').css('width','300px');
				$('#chkXshowdiff').css('width','250px');
				$('#chkXshowdiff span').css('width','200px');
				$('#Xshowdiff .label').css('width','5px');
				
				$('#Xshowover').css('width','300px');
				$('#chkXshowover').css('width','250px');
				$('#chkXshowover span').css('width','200px');
				$('#Xshowover .label').css('width','5px');
				
				$('#Xshowfinished').css('width','300px');
				$('#chkXshowfinished').css('width','250px');
				$('#chkXshowfinished span').css('width','200px');
				$('#Xshowfinished .label').css('width','5px');
				
				$('#Xonlyrealwork').css('width','300px');
				$('#chkXonlyrealwork').css('width','250px');
				$('#chkXonlyrealwork span').css('width','200px');
				$('#Xonlyrealwork .label').css('width','5px');
				
				$('#Xworkh').css('width','300px');
				$('#chkXworkh').css('width','250px');
				$('#chkXworkh span').css('width','200px');
				$('#Xworkh .label').css('width','5px');
				
				if(q_getPara('sys.project').toUpperCase()=='AD' || q_getPara('sys.project').toUpperCase()=='JO'){
					$('#txtXenddate').val(q_cdn(q_date(),31));
					$('#chkXworkh [type=checkbox]').prop('checked',true)
				}
				
				$("#btnRun").click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					var txtreport = $('#q_report').data('info').reportData[t_index].report;
					if(emp($('#txtXdate1').val()))
						$('#txtXdate1').val(q_date());

					if(emp($('#txtXdate2').val()))
						$('#txtXdate2').val(q_date());

					if(!emp($('#txtXdate1').val()))
						t_xbdate=encodeURI($('#txtXdate1').val());
					if(!emp($('#txtXdate2').val()))
						t_xedate=encodeURI($('#txtXdate2').val());

					if(!emp($('#txtXstationno1a').val()))
						t_xbstationno=encodeURI($('#txtXstationno1a').val());
					else
						t_xbstationno='#non';

					if(!emp($('#txtXstationno2a').val()))
						t_xestationno=encodeURI($('#txtXstationno2a').val());
					else
						t_xestationno='#non';

					if(!emp($('#txtXstationgno1a').val()))
						t_xbstationgno=encodeURI($('#txtXstationgno1a').val());
					else
						t_xbstationgno='#non';

					if(!emp($('#txtXstationgno2a').val()))
						t_xestationgno=encodeURI($('#txtXstationgno2a').val());
					else
						t_xestationgno='#non';

					if(!emp($('#txtXproductno1a').val()))
						t_xbproductno=encodeURI($('#txtXproductno1a').val());
					else
						t_xbproductno='#non';

					if(!emp($('#txtXproductno2a').val()))
						t_xeproductno=encodeURI($('#txtXproductno2a').val());
					else
						t_xbproductno='#non';

					if(!emp($('#Xgroupano select').val()))
						t_xgroupano=encodeURI($('#Xgroupano select').val());

					if($('#chkXshowover input[type="checkbox"]').prop('checked'))
						t_xshowover=encodeURI('1');
					else{
						t_xshowover='#non'
					}
					if($('#chkXshowfinished input[type="checkbox"]').prop('checked'))
						t_xshowfinished=encodeURI('1');
					else{
						t_xshowfinished='#non'
					}
					if($('#chkXonlyrealwork input[type="checkbox"]').prop('checked'))
						t_xonlyrealwork=encodeURI('1');
					else{
						t_xonlyrealwork='#non'
					}
					if(!emp($('#txtXcuanoa').val()))
						t_xcuanoa=encodeURI($('#txtXcuanoa').val());
					else
						t_xcuanoa='#non';
						
					if(!emp($('#txtXcuanoq').val()))
						t_xcuanoq=encodeURI($('#txtXcuanoq').val());
					else
						t_xcuanoq='#non';
						
					Lock();
					q_func('qtxt.query.'+txtreport,'z_workgg.txt,'+txtreport+','+
							t_xbdate + ';' +
							t_xedate + ';' +
							isSaturday + ';' +
							t_xbstationno + ';' +
							t_xestationno + ';' +
							t_xgroupano + ';' +
							t_xbproductno + ';' +
							t_xeproductno + ';' +
							t_xshowover + ';' +
							t_xshowfinished + ';'+
							t_xonlyrealwork + ';'+
							t_xbstationgno+';'+t_xestationgno+';'+
							t_xcuanoa+';'+t_xcuanoq
					);
				});

				if(window.parent.q_name=='cug'){
                	var wParent = window.parent.document;
                	var bdate=wParent.getElementById("txtBdate").value;
                	var edate=wParent.getElementById("txtEdate").value;
                	var stationno=wParent.getElementById("txtStationno").value;
                	var station=wParent.getElementById("txtStation").value;

                	$('#txtXdate1').val(bdate);
                	$('#txtXdate2').val(edate);
                	$('#txtXstationno1a').val(stationno);
                	$('#txtXstationno1b').val(station);
                	$('#txtXstationno2a').val(stationno);
                	$('#txtXstationno2b').val(station);

                	$("#btnRun").click();
				}
				if(window.parent.q_name=='workg'){
					var wParent = window.parent.document;
                	var wadate=wParent.getElementById("txtWadate").value;
                	var wbdate=wParent.getElementById("txtWbdate").value;
                	var wedate=wParent.getElementById("txtWedate").value;
                	var bdate=wParent.getElementById("txtBdate").value;
                	var edate=wParent.getElementById("txtEdate").value;
                	var sfbdate=wParent.getElementById("txtSfbdate").value;
                	var sfedate=wParent.getElementById("txtSfedate").value;

                	if(wadate!=''){
                		$('#txtXdate1').val(wadate);
                		$('#txtXdate2').val(wedate);
                	}else if (wbdate!=''){
                		$('#txtXdate1').val(wbdate);
                		$('#txtXdate2').val(wedate);
                	}else if (bdate!=''){
                		$('#txtXdate1').val(bdate);
                		$('#txtXdate2').val(edate);
                	}else if (sfbdate!=''){
                		$('#txtXdate1').val(sfbdate);
                		$('#txtXdate2').val(sfedate);
                	}
                	$("#btnRun").click();
				}
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
							var t_bdate = $.trim($('#txtXdate1').val());
							var t_edate = $.trim($('#txtXdate2').val());
							t_bdate = (t_bdate.length>=9?t_bdate:q_date());
							var t_bADdate = r_len==3?(dec(t_bdate.substring(0,3))+1911)+t_bdate.substr(3):t_bdate;
							var t_edate = $.trim($('#txtXdate2').val());
							t_edate = (t_edate.length>=9?t_edate:q_date());
							var t_eADdate = r_len==3?(dec(t_edate.substring(0,3))+1911)+t_edate.substr(3):t_edate;
							var myStartDate = new Date(t_bADdate);
							var myEndDate = new Date(t_eADdate);
							var DiffDays = ((myEndDate - myStartDate)/ 86400000);
							var DateList = [];
							var DateObj = [];
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								if((new Date(thisADday).getDay())!=0){
									DateList.push(thisDay);
									DateObj.push({
										datea:thisDay,
										mount:0
									});
								}
							}
							var TL = [];
							var OutHtml= '<table id="tTable" border="1px" cellpadding="0" cellspacing="0">';
							for(var i=0;i<as.length;i++){
								var isFind = false;
								for(var j=0;j<TL.length;j++){
									if((as[i].stationno==TL[j].stationno)){
										TL[j].rate = q_add(dec(TL[j].rate),dec(as[i].mount));
										TL[j].days = q_add(dec(TL[j].days),1);
										isFind = true;
									}
								}
								if(!isFind){
									TL.push({
										stationno : as[i].stationno,
										station : as[i].station,
										gen : (dec(as[i].gen)==0?8:dec(as[i].gen)),
										rate : 0,
										days : 1,
										datea : []
									});
								}
							}
							for(var k=0;k<TL.length;k++){
								for(var j=0;j<DateList.length;j++){
									var thisDateGen = TL[k].gen;
									for(var i=0;i<as.length;i++){
										if((as[i].stationno==TL[k].stationno) && (as[i].datea==DateList[j])){
											thisDateGen = as[i].gen;
											break;
										}
									}
									TL[k].datea.push([DateList[j],0,thisDateGen]);
								}
							}
							for(var k=0;k<as.length;k++){
								isFind = false;
								for(var j=0;j<TL.length;j++){
									if(isFind) break;
									if((as[k].stationno==TL[j].stationno)){
										var TLDatea = TL[j].datea;
										for(var h=0;h<TLDatea.length;h++){
											if(as[k].datea==TLDatea[h][0]){
												TLDatea[h][1] = dec(TLDatea[h][1])+dec(as[k].mount);
												isFind = true;
												break;
											}
										}
									}
								}
							}
							
							OutHtml += '<tr>';
							OutHtml += "<td class='tTitle' style='width:240px;' colspan='2' rowspan='2'>工作線別</td>" +
									   "<td class='tTitle' style='width:60px;' rowspan='2'>日產能</td>" +
									   "<td class='tTitle' style='width:80px;' rowspan='2'>稼動率</td>";
							var tmpTd = '<tr>';
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
								tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
							}
							OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
							tmpTd += "</tr>"
							OutHtml += '</tr>' + tmpTd;
							var ATotal = 0;
							for(var k=0;k<TL.length;k++){
								OutHtml += '<tr>';
								OutHtml += "<td class='Lproduct' style='width:120px;'>" + TL[k].stationno + "</td><td class='Lproduct' style='width:120px;'>" + TL[k].station + "</td>" +
										   "<td class='num'>" + TL[k].gen + "</td>" +
										   "<td class='num'>" + (dec(TL[k].gen)==0?0:round(q_mul(q_div(TL[k].rate,q_mul(TL[k].gen,TL[k].days)),100),3)) + "</td>";
								var TTD = TL[k].datea;
								var tTotal = 0;
								for(var j=0;j<TTD.length;j++){
									var thisValue = round(TTD[j][1],3);
									if(t_xshowover=='1'){
										thisValue = (thisValue==0?'':thisValue);
									}
									var thisGen = dec(TTD[j][2]);
									tTotal = q_add(tTotal,round(TTD[j][1],3));
									DateObj[j].mount = q_add(dec(DateObj[j].mount),round(TTD[j][1],3));
									OutHtml += "<td class='num'"+(thisValue>thisGen?' style="color:red;"':'')+"><font title='日產能:"+thisGen+"'>" + thisValue + "</font></td>";
								}
								ATotal = q_add(ATotal,tTotal);
								OutHtml += "<td class='num'>" + tTotal + "</td>";
								OutHtml += '</tr>';
								
								if(k%20==0 && k!=0){
									OutHtml += '<tr>';
									OutHtml += "<td class='tTitle' style='width:240px;' colspan='2' rowspan='2'>工作線別</td>" +
											   "<td class='tTitle' style='width:60px;' rowspan='2'>日產能</td>" +
											   "<td class='tTitle' style='width:80px;' rowspan='2'>稼動率</td>";
									tmpTd = '<tr>';
									for(var j=0;j<DateList.length;j++){
										var thisDay = DateList[j];
										var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
										OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
										tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
									}
									OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
									tmpTd += "</tr>"
									OutHtml += '</tr>' + tmpTd;
								}
							}
							OutHtml += "<tr><td colspan='4' class='tTotal num'>總計：</td>";
							for(var k=0;k<DateObj.length;k++){
								OutHtml += "<td class='tTotal num'>" + round(DateObj[k].mount,3) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + round(ATotal,3) + "</td>";
							OutHtml += "</table>"
							var t_totalWidth = 0;
							t_totalWidth = 670+((70+2)*(DateObj.length+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
						break;
					case 'qtxt.query.z_workgg5':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var t_bdate = $.trim($('#txtXdate1').val());
							var t_edate = $.trim($('#txtXdate2').val());
							t_bdate = (t_bdate.length>=9?t_bdate:q_date());
							var t_bADdate = r_len==3?(dec(t_bdate.substring(0,3))+1911)+t_bdate.substr(3):t_bdate;
							var t_edate = $.trim($('#txtXdate2').val());
							t_edate = (t_edate.length>=9?t_edate:q_date());
							var t_eADdate = r_len==3?(dec(t_edate.substring(0,3))+1911)+t_edate.substr(3):t_edate;
							var myStartDate = new Date(t_bADdate);
							var myEndDate = new Date(t_eADdate);
							var DiffDays = ((myEndDate - myStartDate)/ 86400000);
							var DateList = [];
							var DateObj = [];
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								if((new Date(thisADday).getDay())!=0){
									DateList.push(thisDay);
									DateObj.push({
										datea:thisDay,
										value:0,
										stotal:0
									});
								}else{
									//小計欄
									if(j!=0){
										DateList.push('週小計');
										DateObj.push({
											datea:'週小計',
											value:0,
											stotal:0
										});
									}
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
									   "<td class='tTitle' style='width:210px;' colspan='2' rowspan='2'>工作線別</td>" +
									   "<td class='tTitle' style='width:100px;' rowspan='2'>需工時</td>";
							var tmpTd = '<tr>';
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								if(thisDay=='週小計'){
									OutHtml += "<td class='tTitle' style='width:80px;' rowspan='2'>"+thisDay+"</td>";
								}else{
									var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
									OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
									tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
								}
							}
							OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
							tmpTd += "</tr>"
							OutHtml += '</tr>' + tmpTd;
							var ATotal = 0,wtotal=0;
							var t_stationno='#non';
							var t_station='#non';
							var rowline=0;
							for(var k=0;k<TL.length;k++){
								//插入工作線別小計
								if(t_stationno!='#non' && t_stationno!=TL[k].stationno){
									OutHtml += "<tr><td colspan='2' class='sTotal num'></td>";
									OutHtml += "<td class='sTotal stationno'>" + t_stationno + "</td><td class='sTotal station'>" + t_station + "</td>" ;
									OutHtml += "<td class='sTotal num'>小計：</td>";
									var stotla=0
									for(var c=0;c<DateObj.length;c++){
										OutHtml += "<td class='sTotal num'>" + round(DateObj[c].stotal,3) + "</td>";
										if(DateObj[c].datea!='週小計'){
											stotla=q_add(stotla,round(DateObj[c].stotal,3));
										}
										DateObj[c].stotal=0;
									}
									OutHtml += "<td class='sTotal num'>" + round(stotla,3) + "</td></tr>";
									rowline++;
								}
								
								if(rowline/20>1){
									OutHtml += '<tr>';
									OutHtml += "<td class='tTitle' style='width:370px;' colspan='2' rowspan='2'>物品</td>" +
											   "<td class='tTitle' style='width:210px;' colspan='2' rowspan='2'>工作線別</td>" +
											   "<td class='tTitle' style='width:100px;' rowspan='2'>需工時</td>";
									tmpTd = '<tr>';
									for(var j=0;j<DateList.length;j++){
										var thisDay = DateList[j];
										if(thisDay=='週小計'){
											OutHtml += "<td class='tTitle' style='width:80px;' rowspan='2'>"+thisDay+"</td>";
										}else{
											var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
											OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
											tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
										}
									}
									OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
									tmpTd += "</tr>"
									OutHtml += '</tr>' + tmpTd;
									rowline=0;
								}
								
								OutHtml += '<tr>';
								OutHtml += "<td class='Lproduct' style='width:150px;'>" + TL[k].productno + "</td><td class='Lproduct' style='width:220px;'>" + TL[k].product + "</td>" +
										   "<td class='Lproduct' style='width:120px;'>" + TL[k].stationno + "</td><td class='Lproduct' style='width:120px;'>" + TL[k].station + "</td>" +
										   "<td class='num'>" + TL[k].gen + "</td>";
								var TTD = TL[k].datea;
								var tTotal = 0;
								for(var j=0;j<TTD.length;j++){
									if(TTD[j][0]=='週小計'){
										OutHtml += "<td class='num'>" + round(wtotal,3) + "</td>";
										DateObj[j].value = q_add(dec(DateObj[j].value),wtotal);
										DateObj[j].stotal = q_add(dec(DateObj[j].stotal),wtotal);
										wtotal=0;
									}else{
										wtotal= q_add(wtotal,round(TTD[j][1],3));
										tTotal = q_add(tTotal,round(TTD[j][1],3));
										DateObj[j].value = q_add(dec(DateObj[j].value),round(TTD[j][1],3));
										DateObj[j].stotal = q_add(dec(DateObj[j].stotal),round(TTD[j][1],3));
										OutHtml += "<td class='num'>" + round(TTD[j][1],3) + "</td>";
									}
								}
								ATotal = q_add(ATotal,tTotal);
								OutHtml += "<td class='num'>" + tTotal + "</td>";
								OutHtml += '</tr>';
								
								t_stationno=TL[k].stationno;
								t_station=TL[k].station;
								rowline++;
							}
							//插入最後一筆工作線別小計
							if(t_stationno!='#non'){
								OutHtml += "<tr><td colspan='2' class='sTotal num'></td>";
								OutHtml += "<td class='sTotal stationno'>" + t_stationno + "</td><td class='sTotal station'>" + t_station + "</td>" ;
								OutHtml += "<td class='sTotal num'>小計：</td>";
								var stotla=0
								for(var c=0;c<DateObj.length;c++){
									OutHtml += "<td class='sTotal num'>" + round(DateObj[c].stotal,3) + "</td>";
									if(DateObj[c].datea!='週小計'){
										stotla=q_add(stotla,round(DateObj[c].stotal,3));
									}
									DateObj[c].stotal=0;
								}
								OutHtml += "<td class='sTotal num'>" + round(stotla,3) + "</td></tr>";
							}
							
							OutHtml += "<tr><td colspan='5' class='tTotal num'>總計：</td>";
							for(var k=0;k<DateObj.length;k++){
								OutHtml += "<td class='tTotal num'>" + round(DateObj[k].value,3) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + round(ATotal,3) + "</td>";
							OutHtml += "</table>"
							var t_totalWidth = 0;
							t_totalWidth = 690+((70+2)*(DateObj.length+1+2))+10;
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
							t_bdate = (t_bdate.length>=9?t_bdate:q_date());
							var t_bADdate = r_len==3?(dec(t_bdate.substring(0,3))+1911)+t_bdate.substr(3):t_bdate;
							var t_edate = $.trim($('#txtXdate2').val());
							t_edate = (t_edate.length>=9?t_edate:q_date());
							var t_eADdate = r_len==3?(dec(t_edate.substring(0,3))+1911)+t_edate.substr(3):t_edate;
							var myStartDate = new Date(t_bADdate);
							var myEndDate = new Date(t_eADdate);
							var DiffDays = ((myEndDate - myStartDate)/ 86400000);
							var DateList = [];
							var DateObj = [];
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
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
							OutHtml += "<td class='tTitle' style='width:80px;' rowspan='2'></td>";
							var tmpTd = '<tr>';
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
								tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
							}
							OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
							tmpTd += "</tr>"
							OutHtml += '</tr>' + tmpTd;
							var ATotal = 0,wATotal = 0;
							for(var k=0;k<TL.length;k++){
								OutHtml += '<tr>';
								OutHtml += "<td class='Lproduct' style='width:150px;' rowspan='2'>" + TL[k].productno + "</td><td class='Lproduct' style='width:220px;' rowspan='2'>" + TL[k].product + "</td>";
								var TTD = TL[k].datea;
								var tTotal = 0;
								var wTotal = 0;
								OutHtml += "<td class='center subTitle' style='width:80px;'>訂單數量</td>";
								for(var j=0;j<TTD.length;j++){
									tTotal = q_add(tTotal,round(TTD[j][1],3));
									DateObj[j].value = q_add(dec(DateObj[j].value),round(TTD[j][1],3));
									OutHtml += "<td class='num'>" + round(TTD[j][1],3) + "</td>";
								}
								ATotal = q_add(ATotal,tTotal);
								OutHtml += "<td class='num'>" + tTotal + "</td>";
								OutHtml += '</tr>';
								OutHtml += '<tr id="chgTitle">';
								OutHtml += "<td class='center subTitle' style='width:80px;'>排程數量</td>";
								for(var j=0;j<TTD.length;j++){
									wTotal = q_add(wTotal,round(TTD[j][2],3));
									DateObj[j].workmount = q_add(dec(DateObj[j].workmount),round(TTD[j][2],3));
									OutHtml += "<td class='num'>" + round(TTD[j][2],3) + "</td>";
								}
								wATotal = q_add(wATotal,wTotal);
								OutHtml += "<td class='num'>" + wTotal + "</td>";
								OutHtml += '</tr>';

							}
							OutHtml += "<tr><td colspan='2' rowspan='2' class='tTotal num'>總計：</td>";
							OutHtml += "<td class='center tTotal' style='width:80px;'>訂單數量</td>";
							for(var k=0;k<DateObj.length;k++){
								OutHtml += "<td class='tTotal num'>" + round(DateObj[k].value,3) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + round(ATotal,3) + "</td></tr>";
							OutHtml += "<tr>";
							OutHtml += "<td class='center tTotal' style='width:80px;'>排程數量</td>";
							for(var k=0;k<DateObj.length;k++){
								OutHtml += "<td class='tTotal num'>" + round(DateObj[k].workmount,3) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + round(wATotal,3) + "</td>";
							OutHtml += "</tr></table>"
							var t_totalWidth = 0;
							t_totalWidth = 660+((70+2)*(DateObj.length+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
						break;
					case 'qtxt.query.z_workgg7':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var t_bdate = $.trim($('#txtXdate1').val());
							var t_edate = $.trim($('#txtXdate2').val());
							t_bdate = (t_bdate.length>=9?t_bdate:q_date());
							var t_bADdate = r_len==3?(dec(t_bdate.substring(0,3))+1911)+t_bdate.substr(3):t_bdate;
							var t_edate = $.trim($('#txtXdate2').val());
							t_edate = (t_edate.length>=9?t_edate:q_date());
							var t_eADdate = r_len==3?(dec(t_edate.substring(0,3))+1911)+t_edate.substr(3):t_edate;
							var myStartDate = new Date(t_bADdate);
							var myEndDate = new Date(t_eADdate);
							var DiffDays = ((myEndDate - myStartDate)/ 86400000);
							var DateList = [];
							var DateObj = [];
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
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
									TL[k].datea.push([DateList[j],0/*mount*/
									]);
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
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								OutHtml += "<td class='tTitle tWidth'>" + thisDay.substr(r_len+1) + "</td>";
								tmpTd += "<td class='tTitle tWidth'>" + DayName[(new Date(thisADday).getDay())] + "</td>";
							}
							OutHtml += "<td class='tTitle tWidth' rowspan='2'>小計</td>";
							tmpTd += "</tr>"
							OutHtml += '</tr>' + tmpTd;
							var ATotal = 0,wATotal = 0;
							for(var k=0;k<TL.length;k++){
								OutHtml += '<tr>';
								OutHtml += "<td class='Lproduct' style='width:150px;'>" + TL[k].productno + "</td><td class='Lproduct' style='width:220px;'>" + TL[k].product + "</td>";
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
			#chgTitle:nth-child(even){
				background-color:#CEFFC6;
			}
			.tTitle{
				text-align:center;
				background: #FF9;
			}
			.tTotal{
				text-align:right;
				background: #CFF;
			}
			.sTotal{
				background: #DFD;
			}
			.center{
				text-align:center;
			}
			.Lproduct{
				text-align:left;
				padding-left:3px;
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
		<div id="q_acDiv" style="display: none;"><div>
	</body>
</html>