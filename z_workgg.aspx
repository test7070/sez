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
		<script src='../script/clipboard.min.js' type="text/javascript"> </script>
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
					if($('#q_report').data().info.reportData[n].report=='z_workgg6'
					|| $('#q_report').data().info.reportData[n].report=='z_workgg13'
					){
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
					},{
						type : '0', //[19]
						name : 'rlen',
						value : r_len
					},{
						type : '0', //[20]
						name : 'rsaturday',
						value : q_getPara('sys.saturday')
					},{
						type : '0', //[21]
						name : 'sproject',
						value : q_getPara('sys.project').toUpperCase()
					},{
						type : '6', //[22]
						name : 'xmaxgen'
					},{
						type : '6', //[23]
						name : 'xdayclass'
					},{
						type : '6', //[24]
						name : 'xordeno'
					},{
						type : '6', //[25]
						name : 'xno2'
					}, {
						type : '8', //[26]
						name : 'xshownowork',
						value : ('1@未完工').split(',')
					}, {
						type : '2', //[27][28]
						name : 'xmodelno',
						dbf : 'model',
						index : 'noa,model',
						src : 'model_b.aspx'
					}, {
						type : '8', //[29]
						name : 'xshowatotal',
						value : ('1@顯示小計').split(',')
					}, {
						type : '2', //[30][31]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[32][33]
						name : 'xcust2',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}]
				});
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
				$('#q_report').click(function(){
					var ChartShowIndex = [0,1,4,5,9];
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
				$('#btnAuth').click(function(e) {
					btnAuthority(q_name);
				});
				
				$('#btnCopy').click(function(e) {
					var clipboard = new Clipboard('#btnCopy');
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
				
				$('#txtXmaxgen').css('text-align','right');
				$('#txtXmaxgen').css('width','150px');
				$('#Xmaxgen div').css('width','125px');
				$('#txtXmaxgen').val(24000);
				
				$('#txtXdayclass').css('text-align','right');
				$('#txtXdayclass').val(120);
				
				$('#Xshownowork').css('width','300px');
				$('#chkXshownowork').css('width','250px');
				$('#chkXshownowork span').css('width','200px');
				$('#Xshownowork .label').css('width','5px');
				
				$('#Xshowatotal').css('width','300px');
				$('#chkXshowatotal').css('width','250px');
				$('#chkXshowatotal span').css('width','200px');
				$('#Xshowatotal .label').css('width','5px');
				
				//106/12/19 預設未完工
				$('#chkXshownowork input[type="checkbox"]').prop('checked',true);
				
				$('#txtXmaxgen').change(function() {
					var t_mount=dec($('#txtXmaxgen').val());
					if(isNaN(t_mount))
						t_mount=0;
					$('#txtXmaxgen').val(t_mount);
				});
				
				$('#txtXdayclass').change(function() {
					var t_mount=dec($('#txtXdayclass').val());
					if(isNaN(t_mount))
						t_mount=0;
					$('#txtXdayclass').val(t_mount);
				});
				
				//if(q_getPara('sys.project').toUpperCase()=='AD' || q_getPara('sys.project').toUpperCase()=='JO'){
					$('#txtXenddate').val(q_cdn(q_date(),31));
					$('#chkXworkh [type=checkbox]').prop('checked',true)
				//}
				
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
						
					if(!emp($('#txtXmaxgen').val()))
						t_xmaxgen=encodeURI($('#txtXmaxgen').val());
					else
						t_xmaxgen='#non';
						
					if(!emp($('#txtXdayclass').val()))
						t_xdayclass=encodeURI($('#txtXdayclass').val());
					else
						t_xdayclass='#non';
					
					if(!emp($('#txtXordeno').val()))
						t_xordeno=encodeURI($('#txtXordeno').val());
					else
						t_xordeno='#non';
						
					if(!emp($('#txtXno2').val()))
						t_xordeno2=encodeURI($('#txtXno2').val());
					else
						t_xordeno2='#non';
					
					//106/12/18 不使用 為了讓排程數量顯示全部的數量 --只有z_workgg5 在用
					if($('#chkXshownowork input[type="checkbox"]').prop('checked'))
						t_xshownowork='#non';//encodeURI('1');
					else{
						t_xshownowork='#non'
					}
						
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
							t_xcuanoa+';'+t_xcuanoq+';'+q_getPara('sys.project').toUpperCase()+';'+
							t_xmaxgen+';'+t_xdayclass+';'+t_xordeno+';'+t_xordeno2+';'+t_xshownowork
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
				
				if(window.parent.q_name=='z_workgg'){
					var tpara=q_getId()[3].split('&&');
					var txaction='';
					for(var i=0;i<tpara.length;i++){
						if(tpara[i].indexOf('cuadate')>-1){
							var tmp=replaceAll(tpara[i].split('=')[1],"'",'');
							$('#txtXdate1').val(tmp);
							$('#txtXdate2').val(tmp);
						}else if(tpara[i].indexOf('stationno')>-1){
							var tmp=replaceAll(tpara[i].split('=')[1],"'",'');
							$('#txtXstationno1a').val(tmp).change();
							$('#txtXstationno2a').val(tmp).change();
						}else if(tpara[i].indexOf('modelno')>-1){
							var tmp=replaceAll(tpara[i].split('=')[1],"'",'');
							$('#txtXmodelno1a').val(tmp).change();
							$('#txtXmodelno2a').val(tmp).change();
						}else if(tpara[i].indexOf('productno')>-1){
							var tmp=replaceAll(tpara[i].split('=')[1],"'",'');
							$('#txtXproductno1a').val(tmp).change();
							$('#txtXproductno2a').val(tmp).change();
						}else if(tpara[i].indexOf('onlyrealwork')>-1){
							var tmp=replaceAll(tpara[i].split('=')[1],"'",'');
							if(tmp=="true")
								$("#chkXonlyrealwork input[type='checkbox']").prop('checked',true).change();
							else
								$("#chkXonlyrealwork input[type='checkbox']").prop('checked',false).change();
						}else if(tpara[i].indexOf('xaction')>-1){
							var tmp=replaceAll(tpara[i].split('=')[1],"'",'');
							txaction=tmp;
						}
					}
					
					if(txaction.length>0){
						var t_index=-1;
						for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
							if($('#q_report').data('info').reportData[i].report==txaction){
								t_index=i;
								break;	
							}
						}
						if(t_index>-1){
							var wParent = window.parent.document;
							var tcuano=wParent.getElementById("txtXcuanoa").value;
		                	var tcuanoq=wParent.getElementById("txtXcuanoq").value;
		                	var tordeno=wParent.getElementById("txtXordeno").value;
		                	var tno2=wParent.getElementById("txtXno2").value;
							$('#txtXcuanoa').val(tcuano);
							$('#txtXcuanoq').val(tcuanoq);
							$('#txtXordeno').val(tordeno);
							$('#txtXno2').val(tno2);
							
							$('#q_report').find('span.radio').eq(t_index).parent().click();	
							$("#btnOk").click();
						}
					}
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
										break;
									}
								}
								if(!isFind){
									TL.push({
										stationno : as[i].stationno,
										station : as[i].station,
										gen : (dec(as[i].gen)==0?8:dec(as[i].gen)),
										rate : dec(as[i].mount),
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
										   "<td class='num'>" + TL[k].gen + "</td>" 
										   //+"<td class='num'>" + (dec(TL[k].gen)==0?0:round(q_mul(q_div(TL[k].rate,q_mul(TL[k].gen,TL[k].days)),100),3)) + "</td>";
										   +"<td class='num'>" + (dec(TL[k].gen)==0?0:round(q_mul(q_div(TL[k].rate,q_mul(TL[k].gen,DateList.length)),100),3)) + "</td>";
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
									//OutHtml += "<td class='num'"+(thisValue>thisGen?' style="color:red;"':'')+"><font title='日產能:"+thisGen+"'>" + round(thisValue,0) + "</font></td>";
									OutHtml += "<td class='num'"+(thisValue>(thisGen+1)?' style="color:red;"':'')+"><font title='日產能:"+thisGen+"'>"
									//+(thisValue>thisGen?"<a style='color:red;' href=JavaScript:q_box('work.aspx',\";cuadate='"+DateObj[j].datea+"'&&stationno='"+TL[k].stationno+"';106\",'95%','95%','106')>":'') + Zerospaec(round(thisValue,0)) +(thisValue>thisGen?'</a>':'')+ "</font></td>";
									//+(thisValue>thisGen?"<a style='color:red;' href=JavaScript:q_box('z_workgg.aspx',\";cuadate='"+DateObj[j].datea+"'&&stationno='"+TL[k].stationno+"'&&xaction='z_workgg4';106\",'95%','95%','106')>":'') + Zerospaec(round(thisValue,0)) +(thisValue>thisGen?'</a>':'')+ "</font></td>";
									+"<a "+(thisValue>(thisGen+1)?"style='color:red;'":"")+" href=JavaScript:q_box('z_workgg.aspx',\";cuadate='"+DateObj[j].datea+"'&&stationno='"+TL[k].stationno+"'&&xaction='z_workgg4';106\",'95%','95%','106')>" 
									+(round(thisValue,0)==0 && thisValue>0?round(thisValue,2):Zerospaec(round(thisValue,0))) + "</font></td>";
									//106/07/05 負荷大於1才顯示紅色
								}
								ATotal = q_add(ATotal,tTotal);
								//OutHtml += "<td class='num'>" + Zerospaec(round(tTotal,0)) + "</td>";
								OutHtml += "<td class='num'>" + (round(tTotal,0)==0 && tTotal>0?round(tTotal,2):Zerospaec(round(tTotal,0))) + "</td>";
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
								//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(DateObj[k].mount,0)) + "</td>";
								OutHtml += "<td class='tTotal num'>" + (round(DateObj[k].mount,0)==0 && DateObj[k].mount>0?round(DateObj[k].mount,2):Zerospaec(round(DateObj[k].mount,0))) + "</td>";
							}
							//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(ATotal,0)) + "</td>";
							OutHtml += "<td class='tTotal num'>" + (round(ATotal,0)==0 && ATotal>0?round(ATotal,2):Zerospaec(round(ATotal,0))) + "</td>";
							OutHtml += "</table>"
							var t_totalWidth = 0;
							t_totalWidth = 670+((70+2)*(DateObj.length+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
						break;
					case 'qtxt.query.z_workgg5':
						var as = _q_appendData('tmp0','',true,true);
						if($('#chkXshownowork input[type="checkbox"]').prop('checked')){
							for ( i = 0; i < as.length; i++) {
								if(as[i].ivalue<=0){
									//106/12/18 不使用 為了讓排程數量顯示全部的數量 但當全部入庫時不顯示
									as.splice(i, 1);
									i--;
								}	
							}
						}
						
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							//106/08/25 顯示週小計
							var showatotal=$("#chkXshowatotal [type=checkbox]").prop('checked');
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
							
							var t_xshownowork='0';
							if($('#chkXshownowork input[type="checkbox"]').prop('checked'))
								t_xshownowork='1';
							
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								if((new Date(thisADday).getDay())!=0){
									DateList.push(thisDay);
									DateObj.push({
										datea:thisDay,
										value:0,
										ivalue:0,
										stotal:0,
										itotal:0
									});
								}else{
									//禮拜日 當成周小計欄
									if(j!=0 && showatotal){
										DateList.push('週小計');
										DateObj.push({
											datea:'週小計',
											value:0,
											ivalue:0,
											stotal:0,
											itotal:0
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
									TL[k].datea.push([DateList[j],0,0]);
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
												TLDatea[h][2] = dec(TLDatea[h][2])+dec(as[k].ivalue);
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
							if(t_xshownowork=='1')
								OutHtml += "<td class='tTitle' style='width:100px;' rowspan='2'> </td>";
								
							var tmpTd = '<tr>';
							for(var j=0;j<DateList.length;j++){
								var thisDay = DateList[j];
								if(thisDay=='週小計'){
									OutHtml += "<td class='tTitle' style='width:80px;' rowspan='2'>"+thisDay+"</td>";
									if(t_xshownowork=='1')
										OutHtml += "<td class='tTitle' style='width:100px;' rowspan='2'> </td>";
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
							var iATotal = 0,iwtotal=0;
							var t_stationno='#non';
							var t_station='#non';
							var rowline=0;
							for(var k=0;k<TL.length;k++){
								//插入工作線別小計
								if(t_stationno!='#non' && t_stationno!=TL[k].stationno && showatotal){
									OutHtml += "<tr><td colspan='2' class='sTotal num'></td>";
									OutHtml += "<td class='sTotal stationno'>" + t_stationno + "</td><td class='sTotal station'>" + t_station + "</td>" ;
									OutHtml += "<td class='sTotal num'>小計：</td>";
									if(t_xshownowork=='1')
										OutHtml += "<td class='sTotal num'>排程數量<br><a style='color:red;'>未完工數</a></td>"
									var stotla=0,itotla=0;
									for(var c=0;c<DateObj.length;c++){
										if(t_xshownowork=='1')
											OutHtml += "<td class='sTotal num'>" + Zerospaec(round(DateObj[c].stotal,3)) +"<BR><a style='color:red;'>"+Zerospaec(round(DateObj[c].itotal,3)) + "</a></td>";
										else
											OutHtml += "<td class='sTotal num'>" + Zerospaec(round(DateObj[c].stotal,3)) + "</td>";
										
										if(DateObj[c].datea!='週小計'){
											stotla=q_add(stotla,round(DateObj[c].stotal,3));
											itotla=q_add(itotla,round(DateObj[c].itotal,3));
										}else{
											if(t_xshownowork=='1')
												OutHtml += "<td class='sTotal num'>排程數量<br><a style='color:red;'>未完工數</a></td>"
										}
										DateObj[c].stotal=0;
										DateObj[c].itotal=0;
									}
									if(t_xshownowork=='1'){
										//OutHtml += "<td class='sTotal num'>" + Zerospaec(round(stotla,0))+"<BR><a style='color:red;'>"+Zerospaec(round(itotla,0)) + "</a></td></tr>";
										OutHtml += "<td class='sTotal num'>" + (round(stotla,0)==0 && stotla>0?round(stotla,2):Zerospaec(round(stotla,0)))+"<BR><a style='color:red;'>"+(round(itotla,0)==0 && itotla>0?round(itotla,2):Zerospaec(round(itotla,0))) + "</a></td></tr>";
									}else{
										//OutHtml += "<td class='sTotal num'>" + Zerospaec(round(stotla,0)) + "</td></tr>";
										OutHtml += "<td class='sTotal num'>" + (round(stotla,0)==0 && stotla>0?round(stotla,2):Zerospaec(round(stotla,0))) + "</td></tr>";
									}
									rowline++;
								}
								
								if(rowline/20>1){
									OutHtml += '<tr>';
									OutHtml += "<td class='tTitle' style='width:370px;' colspan='2' rowspan='2'>物品</td>" +
											   "<td class='tTitle' style='width:210px;' colspan='2' rowspan='2'>工作線別</td>" +
											   "<td class='tTitle' style='width:100px;' rowspan='2'>需工時</td>";
									if(t_xshownowork=='1')
										OutHtml += "<td class='tTitle' style='width:100px;' rowspan='2'> </td>";
									
									tmpTd = '<tr>';
									for(var j=0;j<DateList.length;j++){
										var thisDay = DateList[j];
										if(thisDay=='週小計'){
											OutHtml += "<td class='tTitle' style='width:80px;' rowspan='2'>"+thisDay+"</td>";
											if(t_xshownowork=='1')
												OutHtml += "<td class='tTitle' style='width:100px;' rowspan='2'> </td>";
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
								if(t_xshownowork=='1')
									OutHtml += "<td class='num'>排程數量<br><a style='color:red;'>未完工數</a></td>";
									
								var TTD = TL[k].datea;
								var tTotal = 0,itTotal = 0;
								wtotal=0,iwtotal=0;
								for(var j=0;j<TTD.length;j++){
									if(TTD[j][0]=='週小計'){
										if(t_xshownowork=='1'){
											//OutHtml += "<td class='num'>" + Zerospaec(round(wtotal,0)) +"<br><a style='color:red;'>"+Zerospaec(round(iwtotal,0)) + "</a></td>";
											OutHtml += "<td class='num'>" + (round(wtotal,0)==0 && wtotal>0?round(wtotal,2):Zerospaec(round(wtotal,0))) +"<br><a style='color:red;'>"+(round(iwtotal,0)==0 && iwtotal>0?round(iwtotal,2):Zerospaec(round(iwtotal,0))) + "</a></td>";
										}else{
											//OutHtml += "<td class='num'>" + Zerospaec(round(wtotal,0)) + "</td>";
											OutHtml += "<td class='num'>" + (round(wtotal,0)==0 && wtotal>0?round(wtotal,2):Zerospaec(round(wtotal,0))) + "</td>";
										}
										if(t_xshownowork=='1')
											OutHtml += "<td class='num'>排程數量<br><a style='color:red;'>未完工數</a></td>";
											
										DateObj[j].value = q_add(dec(DateObj[j].value),wtotal);
										DateObj[j].stotal = q_add(dec(DateObj[j].stotal),wtotal);
										
										DateObj[j].ivalue = q_add(dec(DateObj[j].ivalue),iwtotal);
										DateObj[j].itotal = q_add(dec(DateObj[j].itotal),iwtotal);
										
									}else{
										wtotal= q_add(wtotal,round(TTD[j][1],3));
										tTotal = q_add(tTotal,round(TTD[j][1],3));
										DateObj[j].value = q_add(dec(DateObj[j].value),round(TTD[j][1],3));
										DateObj[j].stotal = q_add(dec(DateObj[j].stotal),round(TTD[j][1],3));
										
										iwtotal= q_add(iwtotal,round(TTD[j][2],3));
										itTotal = q_add(itTotal,round(TTD[j][2],3));
										DateObj[j].ivalue = q_add(dec(DateObj[j].ivalue),round(TTD[j][2],3));
										DateObj[j].itotal = q_add(dec(DateObj[j].itotal),round(TTD[j][2],3));
										
										if(t_xshownowork=='1'){
											//OutHtml += "<td class='num'>" + Zerospaec(round(TTD[j][1],0)) +"<BR><a style='color:red;'>"+Zerospaec(round(TTD[j][2],0)) + "</a></td>";
											OutHtml += "<td class='num'><a href=JavaScript:q_box('z_workgg.aspx',\";cuadate='"+DateObj[j].datea+"'&&stationno='"+TL[k].stationno+"'&&productno='"+TL[k].productno+"'&&onlyrealwork='"+$("#chkXonlyrealwork input[type='checkbox']").prop('checked').toString()+"'&&xaction='z_workgg4';106\",'95%','95%','106')>" + (round(TTD[j][1],0)==0 && TTD[j][1]>0?round(TTD[j][1],2):Zerospaec(round(TTD[j][1],0))) +"</a><BR><a style='color:red;'>"+(round(TTD[j][2],0)==0 && TTD[j][2]>0?round(TTD[j][2],2):Zerospaec(round(TTD[j][2],0))) + "</a></td>";
										}else{
											//OutHtml += "<td class='num'>" + Zerospaec(round(TTD[j][1],0)) + "</td>";
											OutHtml += "<td class='num'><a href=JavaScript:q_box('z_workgg.aspx',\";cuadate='"+DateObj[j].datea+"'&&stationno='"+TL[k].stationno+"'&&productno='"+TL[k].productno+"'&&onlyrealwork='"+$("#chkXonlyrealwork input[type='checkbox']").prop('checked').toString()+"'&&xaction='z_workgg4';106\",'95%','95%','106')>" + (round(TTD[j][1],0)==0 && TTD[j][1]>0?round(TTD[j][1],2):Zerospaec(round(TTD[j][1],0))) + "</a></td>";
										}
									}
								}
								ATotal = q_add(ATotal,tTotal);
								iATotal = q_add(iATotal,itTotal);
								if(t_xshownowork=='1'){
									//OutHtml += "<td class='num'>" + Zerospaec(round(tTotal,0)) +"<BR><a style='color:red;'>"+Zerospaec(round(itTotal,0)) + "</a></td>";
									OutHtml += "<td class='num'>" + (round(tTotal,0)==0 && tTotal>0?round(tTotal,2):Zerospaec(round(tTotal,0))) +"<BR><a style='color:red;'>"+(round(itTotal,0)==0 && itTotal>0?round(itTotal,2):Zerospaec(round(itTotal,0))) + "</a></td>";
								}else{
									//OutHtml += "<td class='num'>" + Zerospaec(round(tTotal,0)) + "</td>";
									OutHtml += "<td class='num'>" + (round(tTotal,0)==0 && tTotal>0?round(tTotal,2):Zerospaec(round(tTotal,0))) + "</td>";
								}
								OutHtml += '</tr>';
								
								t_stationno=TL[k].stationno;
								t_station=TL[k].station;
								rowline++;
							}
							//插入最後一筆工作線別小計
							if(t_stationno!='#non' && showatotal){
								OutHtml += "<tr><td colspan='2' class='sTotal num'></td>";
								OutHtml += "<td class='sTotal stationno'>" + t_stationno + "</td><td class='sTotal station'>" + t_station + "</td>" ;
								OutHtml += "<td class='sTotal num'>小計：</td>";
								if(t_xshownowork=='1')
									OutHtml += "<td class='sTotal num'>排程數量<br><a style='color:red;'>未完工數</a></td>"
								var stotla=0,itotla=0;
								for(var c=0;c<DateObj.length;c++){
									if(t_xshownowork=='1'){
										//OutHtml += "<td class='sTotal num'>" + Zerospaec(round(DateObj[c].stotal,0)) +"<BR><a style='color:red;'>" +Zerospaec(round(DateObj[c].itotal,0)) + "</a></td>";
										OutHtml += "<td class='sTotal num'>" + (round(DateObj[c].stotal,0)==0 && DateObj[c].stotal>0?round(DateObj[c].stotal,2):Zerospaec(round(DateObj[c].stotal,0))) +"<BR><a style='color:red;'>" +(round(DateObj[c].itotal,0)==0 && DateObj[c].itotal>0?round(DateObj[c].itotal,2):Zerospaec(round(DateObj[c].itotal,0))) + "</a></td>";
									}else{
										//OutHtml += "<td class='sTotal num'>" + Zerospaec(round(DateObj[c].stotal,0)) + "</td>";
										OutHtml += "<td class='sTotal num'>" + (round(DateObj[c].stotal,0)==0 && DateObj[c].stotal>0?round(DateObj[c].stotal,2):Zerospaec(round(DateObj[c].stotal,0))) + "</td>";
									}
									if(DateObj[c].datea!='週小計'){
											itotla=q_add(itotla,round(DateObj[c].itotal,3));
											stotla=q_add(stotla,round(DateObj[c].stotal,3));
									}else{
										if(t_xshownowork=='1')
											OutHtml += "<td class='sTotal num'>排程數量<br><a style='color:red;'>未完工數</a></td>"
									}
									DateObj[c].stotal=0;
									DateObj[c].itotal=0;
								}
								if(t_xshownowork=='1'){
									//OutHtml += "<td class='sTotal num'>" + Zerospaec(round(stotla,0))+"<BR><a style='color:red;'>"+Zerospaec(round(itotla,0)) + "</a></td></tr>";
									OutHtml += "<td class='sTotal num'>" + (round(stotla,0)==0 && stotla>0?round(stotla,2):Zerospaec(round(stotla,0)))+"<BR><a style='color:red;'>"+(round(itotla,0)==0 && itotla>0?round(itotla,2):Zerospaec(round(itotla,0))) + "</a></td></tr>";
								}else{
									//OutHtml += "<td class='sTotal num'>" + Zerospaec(round(stotla,0)) + "</td></tr>";
									OutHtml += "<td class='sTotal num'>" + (round(stotla,0)==0 && stotla>0?round(stotla,2):Zerospaec(round(stotla,0))) + "</td></tr>";
								}
							}
							
							OutHtml += "<tr><td colspan='5' class='tTotal num'>總計：</td>";
							if(t_xshownowork=='1')
								OutHtml += "<td class='tTotal num'>排程數量<br><a style='color:red;'>未完工數</a></td>"
							for(var k=0;k<DateObj.length;k++){
								if(t_xshownowork=='1'){
									//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(DateObj[k].value,0))+"<BR><a style='color:red;'>"+Zerospaec(round(DateObj[k].ivalue,0)) + "</a></td>";
									OutHtml += "<td class='tTotal num'>" + (round(DateObj[k].value,0)==0 && DateObj[k].value>0?round(DateObj[k].value,2):Zerospaec(round(DateObj[k].value,0)))+"<BR><a style='color:red;'>"+(round(DateObj[k].ivalue,0)==0 && DateObj[k].ivalue>0?round(DateObj[k].ivalue,2):Zerospaec(round(DateObj[k].ivalue,0))) + "</a></td>";
								}else{
									//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(DateObj[k].value,0)) + "</td>";
									OutHtml += "<td class='tTotal num'>" + (round(DateObj[k].value,0)==0 && DateObj[k].value>0?round(DateObj[k].value,2):Zerospaec(round(DateObj[k].value,0))) + "</td>";
								}
								if(DateObj[k].datea=='週小計'){
									if(t_xshownowork=='1')
										OutHtml += "<td class='tTotal num'>排程數量<br><a style='color:red;'>未完工數</a></td>"
								}
							}
							if(t_xshownowork=='1'){
								//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(ATotal,0))+"<BR><a style='color:red;'>" +Zerospaec(round(iATotal,0))+ "</a></td>";
								OutHtml += "<td class='tTotal num'>" + (round(ATotal,0)==0 && ATotal>0?round(ATotal,2):Zerospaec(round(ATotal,0)))+"<BR><a style='color:red;'>" +(round(iATotal,0)==0 && iATotal>0?round(iATotal,2):Zerospaec(round(iATotal,0)))+ "</a></td>";
							}else{
								//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(ATotal,0)) + "</td>";
								OutHtml += "<td class='tTotal num'>" + (round(ATotal,0)==0 && ATotal>0?round(ATotal,2):Zerospaec(round(ATotal,0))) + "</td>";
							}
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
									//OutHtml += "<td class='num'>" + Zerospaec(round(TTD[j][1],0)) + "</td>";
									OutHtml += "<td class='num'>" + (round(TTD[j][1],0)==0 && TTD[j][1]>0?round(TTD[j][1],2):Zerospaec(round(TTD[j][1],0))) + "</td>";
								}
								ATotal = q_add(ATotal,tTotal);
								OutHtml += "<td class='num'>" + Zerospaec(tTotal) + "</td>";
								OutHtml += '</tr>';
								OutHtml += '<tr id="chgTitle">';
								OutHtml += "<td class='center subTitle' style='width:80px;'>排程數量</td>";
								for(var j=0;j<TTD.length;j++){
									wTotal = q_add(wTotal,round(TTD[j][2],3));
									DateObj[j].workmount = q_add(dec(DateObj[j].workmount),round(TTD[j][2],3));
									//OutHtml += "<td class='num'>" + Zerospaec(round(TTD[j][2],0)) + "</td>";
									OutHtml += "<td class='num'>" + (round(TTD[j][2],0)==0 && TTD[j][2]>0?round(TTD[j][2],2):Zerospaec(round(TTD[j][2],0))) + "</td>";
								}
								wATotal = q_add(wATotal,wTotal);
								//OutHtml += "<td class='num'>" + Zerospaec(round(wTotal,0)) + "</td>";
								OutHtml += "<td class='num'>" + (round(wTotal,0)==0 && wTotal>0?round(wTotal,2):Zerospaec(round(wTotal,0))) + "</td>";
								OutHtml += '</tr>';
								
								if(k%20==0 && k!=0){
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
								}

							}
							OutHtml += "<tr><td colspan='2' rowspan='2' class='tTotal num'>總計：</td>";
							OutHtml += "<td class='center tTotal' style='width:80px;'>訂單數量</td>";
							for(var k=0;k<DateObj.length;k++){
								//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(DateObj[k].value,0)) + "</td>";
								OutHtml += "<td class='tTotal num'>" + (round(DateObj[k].value,0)==0 && DateObj[k].value>0?round(DateObj[k].value,2):Zerospaec(round(DateObj[k].value,0))) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + Zerospaec(round(ATotal,3)) + "</td></tr>";
							OutHtml += "<tr>";
							OutHtml += "<td class='center tTotal' style='width:80px;'>排程數量</td>";
							for(var k=0;k<DateObj.length;k++){
								//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(DateObj[k].workmount,0)) + "</td>";
								OutHtml += "<td class='tTotal num'>" + (round(DateObj[k].workmount,0)==0 && DateObj[k].workmount>0?round(DateObj[k].workmount,2):Zerospaec(round(DateObj[k].workmount,0))) + "</td>";
							}
							//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(wATotal,0)) + "</td>";
							OutHtml += "<td class='tTotal num'>" + (round(wATotal,0)==0 && wATotal>0?round(wATotal,2):Zerospaec(round(wATotal,0))) + "</td>";
							
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
									//OutHtml += "<td class='num'>" + Zerospaec(round(TTD[j][1],0)) + "</td>";
									OutHtml += "<td class='num'>" + (round(TTD[j][1],0)==0 && TTD[j][1]>0?round(TTD[j][1],2):Zerospaec(round(TTD[j][1],0))) + "</td>";
								}
								ATotal = q_add(ATotal,tTotal);
								//OutHtml += "<td class='num'>" + Zerospaec(round(tTotal,0)) + "</td>";
								OutHtml += "<td class='num'>" + (round(tTotal,0)==0 && tTotal>0?round(tTotal,2):Zerospaec(round(tTotal,0))) + "</td>";
								OutHtml += '</tr>';
								
								if(k%20==0 && k!=0){
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
								}
							}
							OutHtml += "<tr><td colspan='2' class='tTotal num'>總計：</td>";
							for(var k=0;k<DateObj.length;k++){
								//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(DateObj[k].value,0)) + "</td>";
								OutHtml += "<td class='tTotal num'>" + (round(DateObj[k].value,0)==0 && DateObj[k].value>0?round(DateObj[k].value,2):Zerospaec(round(DateObj[k].value,0))) + "</td>";
							}
							//OutHtml += "<td class='tTotal num'>" + Zerospaec(round(ATotal,0)) + "</td>";
							OutHtml += "<td class='tTotal num'>" + (round(ATotal,0)==0 && ATotal>0?round(ATotal,2):Zerospaec(round(ATotal,0))) + "</td>";
							OutHtml += "</table>"
							var t_totalWidth = 0;
							t_totalWidth = 660+((70+2)*(DateObj.length+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
						break;
					case 'qtxt.query.z_workgg11':
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
							var SdateObj = []; //工作線別小計
							var MdateObj = []; //模具小計
							for(var j=0;j<=DiffDays;j++){
								var thisDay = q_cdn(t_bdate,j);
								var thisADday = r_len==3?dec(thisDay.substring(0,3))+1911+thisDay.substr(3):thisDay;
								if((new Date(thisADday).getDay())!=0){
									DateList.push(thisDay);
									DateObj.push({
										datea:thisDay,
										mount:0
									});
									SdateObj.push({
										datea:thisDay,
										mount:0
									});
									MdateObj.push({
										datea:thisDay,
										mount:0
									});
								}else{
									//小計欄
									if(j!=0){
										DateList.push('週小計');
										DateObj.push({
											datea:'週小計',
											mount:0,
										});
										SdateObj.push({
											datea:'週小計',
											mount:0,
										});
										MdateObj.push({
											datea:'週小計',
											mount:0,
										});
									}
								}
							}
							var TL = [];
							var OutHtml= '<table id="tTable" border="1px" cellpadding="0" cellspacing="0">';
							for(var i=0;i<as.length;i++){
								var isFind = false;
								for(var j=0;j<TL.length;j++){
									if((as[i].modelno==TL[j].modelno) && (as[i].stationno==TL[j].stationno)){
										TL[j].days = q_add(dec(TL[j].days),1);
										isFind = true;
									}
								}
								if(!isFind){
									TL.push({
										stationno : as[i].stationno,
										station : as[i].station,
										modelno : as[i].modelno,
										model : as[i].model,
										gen : (dec(as[i].gen)==0?dec($('#txtXdayclass').val()):dec(as[i].gen)), //最大日產能
										mmount : dec(as[i].mmount), //模具數
										modmounts : dec(as[i].modmounts),//模具穴數
										smaxop : dec(as[i].smaxop),//最大圈數
										smaxmod : dec(as[i].smaxmod),//最大模數
										smount : q_mul(dec(as[i].smaxop),dec(as[i].smaxmod)),//最大生產模數/日
										smodmounts : dec(as[i].smodmounts),//機器模數
										maxmodmount : dec(as[i].maxmodmount),//模具每圈可生產最大數量
										maxgen : dec(as[i].maxgen),
										days : 1,
										datea : []
									});
								}
							}
							for(var k=0;k<TL.length;k++){
								for(var j=0;j<DateList.length;j++){
									var thisDateGen = TL[k].gen;
									for(var i=0;i<as.length;i++){
										if((as[i].modelno==TL[k].modelno) && (as[i].stationno==TL[k].stationno) && (as[i].datea==DateList[j])){
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
									if((as[k].modelno==TL[j].modelno) && (as[k].stationno==TL[j].stationno)){
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
									   "<td class='tTitle' style='width:240px;background: #FDB;' colspan='2' rowspan='2'>模具</td>" +
									   "<td class='tTitle' style='width:60px;background: #FDB;' rowspan='2'>模具數</td>" +
									   "<td class='tTitle' style='width:60px;background: #FDB;' rowspan='2'>穴數</td>" +
									   "<td class='tTitle' style='width:120px;background: #FDB;' rowspan='2'>最大生產模數/日</td>";
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
							var ATotal = 0,STotal = 0,t_stationno='#non';
							for(var k=0;k<TL.length;k++){
								if(t_stationno!=TL[k].stationno){
									if(t_stationno!='#non'){
										OutHtml += "<tr><td class='Lproduct' style='width:120px;background:antiquewhite;'>" + TL[k-1].stationno + "</td><td class='Lproduct' style='width:120px;background:antiquewhite;'>" + TL[k-1].station + "</td>" 
													+"<td colspan='3' class='tTotal num' style='background:antiquewhite;'>小計：</td>"
													+"<td colspan='2' class='Lproduct' style='background:antiquewhite;text-align: center;'>最大生產"+TL[k-1].smount+"模/日</td>";
										//106/08/15 超荷變紅字
										for(var s=0;s<SdateObj.length;s++){
											if(TL[k-1].modmounts>1 && SdateObj[s].mount!=0 && SdateObj[s].datea!='週小計'){
												if((dec(TL[k-1].smount)==0?0:MdateObj[s].mount/dec(TL[k-1].smount))>1 && SdateObj[s].datea!='週小計'){
													OutHtml += "<td class='tTotal num'style='background:antiquewhite;color:red;'>"+ (round(SdateObj[s].mount,0)==0 && SdateObj[s].mount>0?round(SdateObj[s].mount,2):Zerospaec(FormatNumber(round(SdateObj[s].mount,0))))+'/'+MdateObj[s].mount + "</td>";
												}else{
													OutHtml += "<td class='tTotal num'style='background:antiquewhite;'>"+ (round(SdateObj[s].mount,0)==0 && SdateObj[s].mount>0?round(SdateObj[s].mount,2):Zerospaec(FormatNumber(round(SdateObj[s].mount,0))))+'/'+MdateObj[s].mount + "</td>";
												}
											}else{
												if((dec(TL[k-1].smount)==0?0:MdateObj[s].mount/dec(TL[k-1].smount))>1  && SdateObj[s].datea!='週小計'){
													OutHtml += "<td class='tTotal num'style='background:antiquewhite;color:red;'>"+ (round(SdateObj[s].mount,0)==0 && SdateObj[s].mount>0?round(SdateObj[s].mount,2):Zerospaec(FormatNumber(round(SdateObj[s].mount,0)))) + "</td>";
												}else{
													OutHtml += "<td class='tTotal num'style='background:antiquewhite;'>"+ (round(SdateObj[s].mount,0)==0 && SdateObj[s].mount>0?round(SdateObj[s].mount,2):Zerospaec(FormatNumber(round(SdateObj[s].mount,0)))) + "</td>";
												}
											}
										}
										OutHtml += "<td class='tTotal num' style='background:antiquewhite;'>" + (round(STotal,0)==0 && STotal>0?round(STotal,2):Zerospaec(FormatNumber(round(STotal,0)))) + "</td></tr>";
										
										//106/08/10 使用率
										OutHtml += "<tr><td class='Lproduct' style='width:120px;background:antiquewhite;'>" + TL[k-1].stationno + "</td><td class='Lproduct' style='width:120px;background:antiquewhite;'>" + TL[k-1].station + "</td>" 
													+"<td colspan='5' class='tTotal num' style='background:antiquewhite;'>使用率：</td>";
										for(var s=0;s<MdateObj.length;s++){
											if(MdateObj[s].datea=="週小計" || MdateObj[s].mount==0){
												OutHtml += "<td class='tTotal num' style='background:antiquewhite;'> </td>";
											}else{
												if((dec(TL[k-1].smount)==0?0:MdateObj[s].mount/dec(TL[k-1].smount))>1){
													OutHtml += "<td class='tTotal num' style='background:antiquewhite;color:red;'>"+ (dec(TL[k-1].smount)==0?0:FormatNumber((round(q_div(MdateObj[s].mount,dec(TL[k-1].smount))*100,2)))+'%') + "</td>";
												}else{
													OutHtml += "<td class='tTotal num' style='background:antiquewhite;'>"+ (dec(TL[k-1].smount)==0?0:FormatNumber((round(q_div(MdateObj[s].mount,dec(TL[k-1].smount))*100,2)))+'%') + "</td>";
												}
											}
										}
										OutHtml += "<td class='tTotal num' style='background:antiquewhite;'> </td></tr>";
										
										OutHtml += '<tr>';
										OutHtml += "<td class='tTitle' style='width:240px;' colspan='2' rowspan='2'>工作線別</td>" +
												   "<td class='tTitle' style='width:240px;background: #FDB;' colspan='2' rowspan='2'>模具</td>" +
												   "<td class='tTitle' style='width:60px;background: #FDB;' rowspan='2'>模具數</td>" +
												   "<td class='tTitle' style='width:60px;background: #FDB;' rowspan='2'>穴數</td>" +
												   "<td class='tTitle' style='width:120px;background: #FDB;' rowspan='2'>最大生產模數/日</td>";
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
									}
									
									for(var s=0;s<SdateObj.length;s++){
										SdateObj[s].mount=0;
									}
									for(var s=0;s<MdateObj.length;s++){
										MdateObj[s].mount=0;
									}
									t_stationno=TL[k].stationno;
									STotal=0;
								}
								
								OutHtml += '<tr>';
								OutHtml += "<td class='Lproduct' style='width:120px;'>" + TL[k].stationno + "</td><td class='Lproduct' style='width:120px;'>" + TL[k].station + "</td>" +
										   "<td class='Lproduct' style='width:120px;'>" + TL[k].modelno + "</td><td class='Lproduct' style='width:120px;'>" + TL[k].model + "</td>" +
										   "<td class='num'>" + FormatNumber(TL[k].mmount) + "</td>" +
										   "<td class='num'>" + FormatNumber(TL[k].modmounts) + "</td>" +
										   "<td class='num'>" + FormatNumber(TL[k].mmount*TL[k].smaxop)+ "</td>";
								var TTD = TL[k].datea;
								var tTotal = 0,wtotal=0;
								var t_modmounts=TL[k].modmounts;
								var t_msmaxgen=TL[k].mmount*TL[k].smaxop;
								
								for(var j=0;j<TTD.length;j++){
									var thisValue = round(TTD[j][1],3);
									if(t_xshowover=='1'){
										thisValue = (thisValue==0?'':thisValue);
									}
									var thisGen = dec(TTD[j][2]);
									tTotal = q_add(tTotal,thisValue);
									DateObj[j].mount = q_add(dec(DateObj[j].mount),thisValue);
									SdateObj[j].mount = q_add(dec(SdateObj[j].mount),thisValue);
									
									if(t_modmounts>1 && thisValue!=0){
										MdateObj[j].mount = q_add(dec(MdateObj[j].mount),Math.ceil(thisValue/t_modmounts));
									}else{
										MdateObj[j].mount = q_add(dec(MdateObj[j].mount),thisValue);
									}
									
									wtotal= q_add(wtotal,round(TTD[j][1],3));
									if(TTD[j][0]=='週小計'){
										OutHtml += "<td class='num'><font title='週小計:"+wtotal+"'>"+ Zerospaec(FormatNumber(round(wtotal,0)))+"</font></td>";
										DateObj[j].mount = q_add(dec(DateObj[j].mount),wtotal);
										SdateObj[j].mount = q_add(dec(SdateObj[j].mount),wtotal);
										MdateObj[j].mount = q_add(dec(MdateObj[j].mount),wtotal);
										wtotal=0;
									}else{
										//106/07/05 負荷大於1才顯示紅色
										if(t_modmounts>1 && thisValue!=0){
											OutHtml += "<td class='num'"+(Math.ceil(thisValue/t_modmounts)>(t_msmaxgen+1)?' style="color:red;"':'')+"><font title='日產能:"+t_msmaxgen+"'>"
											+"<a "+(Math.ceil(thisValue/t_modmounts)>(t_msmaxgen+1)?"style='color:red;'":"")+" href=JavaScript:q_box('z_workgg.aspx',\";cuadate='"+DateObj[j].datea+"'&&modelno='"+TL[k].modelno+"'&&xaction='z_workgg4';106\",'95%','95%','106')>" 
											+(round(thisValue,0)==0 && thisValue>0?round(thisValue,2):Zerospaec(round(thisValue,0)))+'/'+Math.ceil(thisValue/t_modmounts) + "</font></td>";
										}else{
											OutHtml += "<td class='num'"+(thisValue>(t_msmaxgen+1)?' style="color:red;"':'')+"><font title='日產能:"+t_msmaxgen+"'>"
											+"<a "+(thisValue>(t_msmaxgen+1)?"style='color:red;'":"")+" href=JavaScript:q_box('z_workgg.aspx',\";cuadate='"+DateObj[j].datea+"'&&modelno='"+TL[k].modelno+"'&&xaction='z_workgg4';106\",'95%','95%','106')>" 
											+(round(thisValue,0)==0 && thisValue>0?round(thisValue,2):Zerospaec(round(thisValue,0))) + "</font></td>";
										}
									}
								}
								ATotal = q_add(ATotal,tTotal);
								STotal = q_add(STotal,tTotal);
								OutHtml += "<td class='num'>" + (round(tTotal,0)==0 && tTotal>0?round(tTotal,2):Zerospaec(round(tTotal,0))) + "</td>";
								OutHtml += '</tr>';
								
								
							}
							
							//最後一個工作線別小計
							OutHtml += "<tr><td class='Lproduct' style='width:120px;background:antiquewhite;'>" + TL[TL.length-1].stationno + "</td><td class='Lproduct' style='width:120px;background:antiquewhite;'>" + TL[TL.length-1].station + "</td>"
										+"<td colspan='3' class='tTotal num' style='background:antiquewhite;'>小計：</td>"
										+"<td colspan='2' class='Lproduct' style='background:antiquewhite;text-align: center;'>最大生產"+TL[TL.length-1].smount+"模/日</td>";
							//106/08/15 超荷變紅字
							for(var s=0;s<SdateObj.length;s++){
								if(TL[TL.length-1].modmounts>1 && SdateObj[s].mount!=0 && SdateObj[s].datea!='週小計'){
									if((dec(TL[TL.length-1].smount)==0?0:MdateObj[s].mount/dec(TL[TL.length-1].smount))>1 && SdateObj[s].datea!='週小計'){
										OutHtml += "<td class='tTotal num'style='background:antiquewhite;color:red;'>"+ (round(SdateObj[s].mount,0)==0 && SdateObj[s].mount>0?round(SdateObj[s].mount,2):Zerospaec(FormatNumber(round(SdateObj[s].mount,0))))+'/'+MdateObj[s].mount + "</td>";
									}else{
										OutHtml += "<td class='tTotal num'style='background:antiquewhite;'>"+ (round(SdateObj[s].mount,0)==0 && SdateObj[s].mount>0?round(SdateObj[s].mount,2):Zerospaec(FormatNumber(round(SdateObj[s].mount,0))))+'/'+MdateObj[s].mount + "</td>";
									}
								}else{
									if((dec(TL[TL.length-1].smount)==0?0:MdateObj[s].mount/dec(TL[TL.length-1].smount))>1  && SdateObj[s].datea!='週小計'){
										OutHtml += "<td class='tTotal num'style='background:antiquewhite;color:red;'>"+ (round(SdateObj[s].mount,0)==0 && SdateObj[s].mount>0?round(SdateObj[s].mount,2):Zerospaec(FormatNumber(round(SdateObj[s].mount,0)))) + "</td>";
									}else{
										OutHtml += "<td class='tTotal num'style='background:antiquewhite;'>"+ (round(SdateObj[s].mount,0)==0 && SdateObj[s].mount>0?round(SdateObj[s].mount,2):Zerospaec(FormatNumber(round(SdateObj[s].mount,0)))) + "</td>";
									}
								}
							}
							OutHtml += "<td class='tTotal num' style='background:antiquewhite;'>" + (round(STotal,0)==0 && STotal>0?round(STotal,2):Zerospaec(FormatNumber(round(STotal,0)))) + "</td></tr>";
							
							//106/08/10 使用率
							
							OutHtml += "<tr><td class='Lproduct' style='width:120px;background:antiquewhite;'>" + TL[TL.length-1].stationno + "</td><td class='Lproduct' style='width:120px;background:antiquewhite;'>" + TL[TL.length-1].station + "</td>" 
										+"<td colspan='5' class='tTotal num' style='background:antiquewhite;'>使用率：</td>";
							for(var s=0;s<MdateObj.length;s++){
								if(MdateObj[s].datea=="週小計" || MdateObj[s].mount==0){
									OutHtml += "<td class='tTotal num' style='background:antiquewhite;'> </td>";
								}else{
									if((dec(TL[TL.length-1].smount)==0?0:MdateObj[s].mount/dec(TL[TL.length-1].smount))>1){
										OutHtml += "<td class='tTotal num' style='background:antiquewhite;color:red;'>"+ (dec(TL[TL.length-1].smount)==0?0:FormatNumber((round((MdateObj[s].mount/dec(TL[k-1].smount))*100,2)))+'%') + "</td>";
									}else{
										OutHtml += "<td class='tTotal num' style='background:antiquewhite;'>"+ (dec(TL[TL.length-1].smount)==0?0:FormatNumber((round((MdateObj[s].mount/dec(TL[k-1].smount))*100,2)))+'%') + "</td>";
									}
								}
							}
							OutHtml += "<td class='tTotal num' style='background:antiquewhite;'> </td></tr>";
							
							//總計 106/08/10 拿掉總計
							/*
							OutHtml += "<tr><td colspan='6' class='tTotal num'>總計：</td>";
							for(var k=0;k<DateObj.length;k++){
								OutHtml += "<td class='tTotal num'>"
								+ (round(DateObj[k].mount,0)==0 && DateObj[k].mount>0?round(DateObj[k].mount,2):Zerospaec(FormatNumber(round(DateObj[k].mount,0)))) + "</td>";
							}
							OutHtml += "<td class='tTotal num'>" + (round(ATotal,0)==0 && ATotal>0?round(ATotal,2):Zerospaec(FormatNumber(round(ATotal,0)))) + "</td>";
							*/
							
							OutHtml += "</table>"
							var t_totalWidth = 0;
							t_totalWidth = 770+((70+2)*(DateObj.length+1+2))+10;
							$('#chart').css('width',t_totalWidth+'px').html(OutHtml);
						}
					
						break;
				}
				Unlock();
			}
			
			function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
            
            function Zerospaec(n) {
            	if(dec(n)==0){
            		return '';
            	}else{
            		return n;
            	}
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
				<input type="button" id="btnAuth" style="float:left; width:80px;font-size: medium;" value="權限"/>
				<input type="button" id="btnCopy" style="float:left; width:120px;font-size: medium;" value="複製到剪貼簿" data-clipboard-target="#chart"/>
				
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
		<div id="q_acDiv" style="display: none;"> </div>
	</body>
</html>