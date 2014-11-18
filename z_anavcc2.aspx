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
			var txtreport = '';
			if(location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;100";
			}
			
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_anavcc2');
			});
			
			var pieshow=false;//判斷是否顯示圓餅圖
			function printWith(){
				var t_index = $('#q_report').data('info').radioIndex;
				txtreport = $('#q_report').data('info').reportData[t_index].report;
				var obj=$('#printWith');
				if(obj.attr('name')=='chart'){
					if(txtreport == 'z_anavcc2_Compare1' || txtreport=='z_anavcc2_Compare2'){
						obj.attr('disabled','disabled');
					}else{
						obj.removeAttr('disabled');
					}
					if(txtreport=='z_anavcc2_1' ||txtreport=='z_anavcc2_4'){
						$('#showpieChart').val('轉換至圓餅圖');
						$('#showpieChart').show();
					}else{
						$('#showpieChart').hide();
					}
					obj.val('轉換至列表');
					$('.prt').hide();
					$('#chartCtrl').show();
					$('#chart').show();
					$('#pieChart').hide();
					pieshow=false;
					obj.attr('name','list');
					$('#btnRun').click();
				}else{
					if(txtreport == 'z_anavcc2_Compare1'|| txtreport=='z_anavcc2_Compare2'){
						return;
					}
					obj.val('轉換至圖表');
					$('#showpieChart').hide();
					$('#showpieChart').val('轉換至圓餅圖');
					$('.prt').show();
					$('#chartCtrl').hide();
					$('#chart').hide();
					$('#pieChart').hide();
					pieshow=false;
					obj.attr('name','chart');
					$('#btnOk').click();
				}
			}
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_anavcc2xls',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1', //[2][3]
						name : 'date'
					}, {
						type : '1', //[4][5]
						name : 'xmon'
					}, {
						type : '2', //[6][7]
						name : 'cust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[8][9]
						name : 'sales',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '2', //[10][11]
						name : 'product',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '1', //[12][13]
						name : 'xbmon'
					}, {
						type : '1', //[14][15]
						name : 'xemon'
					}, {
						type : '1', //[16][17]
						name : 'xyear'
					}]
				});
				q_langShow();
				q_popAssign();
				q_getFormat();
				
				printWith();
				$('#printWith').click(function(){
					printWith();
				});
				
				$('#showpieChart').click(function(){
					if($('#showpieChart').val()=='轉換至圓餅圖'){
						$('.prt').hide();
						$('#chartCtrl').hide();
						$('#chart').show();
						$('#barChart2').hide();
						$('#pieChart').show();
						$('#btnRun').click();
						pieshow=true;
						$('#showpieChart').val('轉換至長條圖');
					}else{
						var obj=$('#printWith');
						obj.val('轉換至列表');
						$('.prt').hide();
						$('#chartCtrl').show();
						$('#chart').show();
						$('#pieChart').hide();
						pieshow=false;
						obj.attr('name','list');
						$('#btnRun').click();
						$('#showpieChart').val('轉換至圓餅圖');
					}
				});
				
				var lastClick = -1;
				$('.report').click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					if(t_index != lastClick){
						$('#barChart2').html('').removeAttr('style');
						lastClick=t_index;
						$('#printWith').attr('name','chart');
						printWith();
					}
				});
				$('#txtDate1').mask('999/99/99');
				$('#txtDate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();
				$('#txtXmon1').mask('999/99');
				$('#txtXmon2').mask('999/99');
				$('#txtXyear1').mask('999');
				$('#txtXyear2').mask('999');
				$('#txtXyear1').val(r_accy-1);
				$('#txtXyear2').val(r_accy);
				$('#txtXbmon1').val((r_accy-1)+'/01').mask('999/99');
				$('#txtXbmon2').val((r_accy-1)+'/12').mask('999/99');
				$('#txtXemon1').val(r_accy+'/01').mask('999/99');
				$('#txtXemon2').val(r_accy+'/12').mask('999/99');
				$('#btnXXX').click(function(e) {
					btnAuthority(q_name);
				});
				$("#btnRun").click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					txtreport = $('#q_report').data('info').reportData[t_index].report;
					if(emp($('#txtXbmon1').val()))
						$('#txtXbmon1').val(r_accy+'/01');
					if(emp($('#txtXbmon2').val()))
						$('#txtXbmon2').val(r_accy+'/12');
					if(emp($('#txtXemon1').val()))
						$('#txtXemon1').val(r_accy+'/01');
					if(emp($('#txtXemon2').val()))
						$('#txtXemon2').val(r_accy+'/12');
					var t_bdate='#non',t_edate='#non',t_bmon='#non',t_emon='#non',t_bcustno='#non',t_ecustno='#non';
					var t_bsalesno='#non',t_esalesno='#non',t_bproductno='#non',t_eproductno='#non';
					var t_xbbmon='#non',t_xbemon='#non',t_xebmon='#non',t_xeemon='#non';
					var t_xbyear='#non',t_xeyear='#non';
					if(!emp($('#txtCust1a').val()))
						t_bcustno=encodeURI($('#txtCust1a').val());
					if(!emp($('#txtCust2a').val()))
						t_ecustno=encodeURI($('#txtCust2a').val());
					if(!emp($('#txtSales1a').val()))
						t_bsalesno=encodeURI($('#txtSales1a').val());
					if(!emp($('#txtSales2a').val()))
						t_esalesno=encodeURI($('#txtSales2a').val());
					if(!emp($('#txtProduct1a').val()))
						t_bproductno=encodeURI($('#txtProduct1a').val());
					if(!emp($('#txtProduct2a').val()))
						t_eproductno=encodeURI($('#txtProduct2a').val());
					if(txtreport=='z_anavcc2_1' ||txtreport=='z_anavcc2_2' ||txtreport=='z_anavcc2_3' ||txtreport=='z_anavcc2_4'){
						if(!emp($('#txtDate1').val()))
							t_bdate=encodeURI($('#txtDate1').val());
						if(!emp($('#txtDate2').val()))
							t_edate=encodeURI($('#txtDate2').val());
						if(!emp($('#txtXmon1').val()))
							t_bmon=encodeURI($('#txtXmon1').val());
						if(!emp($('#txtXmon2').val()))
							t_emon=encodeURI($('#txtXmon2').val());
							
						q_func('qtxt.query','z_anavcc2.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_bdate + ';' + t_edate + ';' +
						t_bmon + ';' + t_emon + ';' + t_bcustno + ';' + t_ecustno + ';' + t_bsalesno + ';' + t_esalesno + ';' +
						t_bproductno + ';' + t_eproductno + ';'
						);
					}else if(txtreport=='z_anavcc2_Compare1' ||txtreport=='z_anavcc2_Compare2'){
						if(!emp($('#txtXbmon1').val()))
							t_xbbmon=encodeURI($('#txtXbmon1').val());
						if(!emp($('#txtXbmon2').val()))
							t_xbemon=encodeURI($('#txtXbmon2').val());
						if(!emp($('#txtXemon1').val()))
							t_xebmon=encodeURI($('#txtXemon1').val());
						if(!emp($('#txtXemon2').val()))
							t_xeemon=encodeURI($('#txtXemon2').val());
						q_func('qtxt.query','z_anavcc2.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_xbbmon + ';' + t_xbemon + ';' +
						t_xebmon + ';' + t_xeemon + ';' + t_bcustno + ';' + t_ecustno + ';' + t_bsalesno + ';' + t_esalesno + ';' +
						t_bproductno + ';' + t_eproductno + ';'
						);
					}else if(txtreport=='z_anavcc2_Custyear'||txtreport=='z_anavcc2_Productyear'){
						if(!emp($('#txtXyear1').val()))
							t_xbyear=encodeURI($('#txtXyear1').val());
						if(!emp($('#txtXyear2').val()))
							t_xeyear=encodeURI($('#txtXyear2').val());
							if(txtreport=='z_anavcc2_Custyear')
								q_func('qtxt.query','z_anavcc2.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_xbyear + ';' + t_xeyear + ';' + t_bcustno + ';' + t_ecustno + ';');
							else
								q_func('qtxt.query','z_anavcc2.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_xbyear + ';' + t_xeyear + ';' + t_bproductno + ';' + t_eproductno + ';');
					}
				});
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
			
			var color=new Array();
            function getRndColor(s){
				var getColor = function(){
					var r = Math.ceil((Math.random()*85)+170).toString(16);//亮色
					r = r.length==1?'0'+r:r;
					return r;
				}
				var color = (s==undefined)?'#':'';
				return(color + getColor() + getColor() + getColor());
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							var bar=new Array();
							var oldGno = '',rec = 0;
							bar[rec] = new Array();
							for (i = 0; i < as.length; i++) {   
								if(as[i].gno == '1'){
									rec++;
									continue;
								}
								if(!bar[rec])
									bar[rec] = new Array();
								if(txtreport == 'z_anavcc2_1'){
									bar[rec].push(
										{
											custno:as[i].custno,
											comp:as[i].comp,
											mount:as[i].mount,
											total:as[i].total,
											price:dec(as[i].total)-dec(as[i].price)
										}
									);
								}else if(txtreport == 'z_anavcc2_2'){
									bar[rec].push(
										{
											productno:as[i].productno,
											product:as[i].product,
											mount:as[i].mount,
											total:as[i].total,
											price:dec(as[i].total)-dec(as[i].price)
										}
									);
								}else if(txtreport == 'z_anavcc2_3'){
									bar[rec].push(
										{
											custno:as[i].custno,
											comp:as[i].comp,
											productno:as[i].productno,
											product:as[i].product,
											mount:as[i].mount,
											total:as[i].total,
											price:dec(as[i].total)-dec(as[i].price)
										}
									);
								}else if(txtreport == 'z_anavcc2_4'){
									bar[rec].push(
										{
											groupano:as[i].groupano,
											namea:as[i].namea,
											mount:as[i].mount,
											total:as[i].total,
											price:dec(as[i].total)-dec(as[i].price)
										}
									);
								}else if(txtreport == 'z_anavcc2_Compare1'){
									if((i>1 && as[i].mon=='E' && as[i-1].mon != 'B') || (i==0 && as[i].mon=='E')){
										bar[rec].push(
											{
												mon:'B',
												custno:as[i].custno,
												comp:as[i].comp,
												mount:0,
												total:0,
												price:0
											}
										);
									}
									bar[rec].push(
										{
											mon:as[i].mon,
											custno:as[i].custno,
											comp:as[i].comp,
											mount:as[i].mount,
											total:as[i].total,
											price:dec(as[i].total)-dec(as[i].price)
										}
									);
									if(as[i].mon=='B' && as[i+1].mon != 'E'){
										bar[rec].push(
											{
												mon:'E',
												custno:as[i].custno,
												comp:as[i].comp,
												mount:0,
												total:0,
												price:0
											}
										);
									}
								}else if(txtreport == 'z_anavcc2_Compare2'){
									if((i>1 && as[i].mon=='E' && as[i-1].mon != 'B') || (i==0 && as[i].mon=='E')){
										bar[rec].push(
											{
												mon:'B',
												productno:as[i].productno,
												product:as[i].product,
												mount:0,
												total:0,
												price:0
											}
										);
									}
									bar[rec].push(
										{
											mon:as[i].mon,
											productno:as[i].productno,
											product:as[i].product,
											mount:as[i].mount,
											total:as[i].total,
											price:dec(as[i].total)-dec(as[i].price)
										}
									);
									if(as[i].mon=='B' && as[i+1].mon != 'E'){
										bar[rec].push(
											{
												mon:'E',
												productno:as[i].productno,
												product:as[i].product,
												mount:0,
												total:0,
												price:0
											}
										);
									}
								}else if(txtreport == 'z_anavcc2_Custyear'||txtreport == 'z_anavcc2_Productyear'){
									if($('#txtXyear1').val() == $('#txtXyear2').val()){
										alert('年度相同無法比較!!');
										$('#txtXyear1').focus();
										return;
									}else{
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'01',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m01
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'02',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m02
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'03',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m03
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'04',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m04
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'05',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m05
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'06',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m06
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'07',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m07
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'08',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m08
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'09',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m09
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'10',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m10
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'11',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m11
											}
										);
										bar[rec].push(
											{
												tyear:as[i].tyear,
												mon:'12',
												custno:(as[i].custno!=undefined?as[i].custno:as[i].productno),
												comp:(as[i].comp!=undefined?as[i].comp:as[i].product),
												total:as[i].m12
											}
										);
									}
								}
								color[i]=getRndColor();
							}
							
							if(pieshow){
								$('#pieChart').pieChart({
									data : bar[0],
									x: 250,
									y: 250,
									radius: 200
								});
								return;
							}
							
							if(txtreport=='z_anavcc2_Custyear'||txtreport=='z_anavcc2_Productyear'){
								$('#barChart2').barChart({
									data : bar
								});
							}else{
								$('#barChart2').barChart2({
									data : bar
								});
							}
							
							$('#btnPrevious').unbind('click').click(function(){
								$('#barChart2').data('info').previous($('#barChart2'));
							});
							$('#btnNext').unbind('click').click(function(){
								$('#barChart2').data('info').next($('#barChart2'));
							});
							
							$('#txtCurPage').unbind('change').change(function(e) {
								$(this).val(parseInt($(this).val()));
								$('#barChart2').data('info').page($('#barChart2'), $(this).val());
							});
							$('#txtTotPage').val(bar.length);
							$('#barChart2').show();
						}
					break;
				}
			}
			(function($, undefined) {
				$.fn.barChart2 = function(value) {
					$(this).data('info', {
						curIndex : -1,
						postData : value.data,
						maxPage : value.data.length,
						init : function(obj) {
							if (value.length == 0) {
								alert('無資料。');
								return;
							}
							obj.data('info').curIndex = 0;
							$('#txtCurPage').val(1);
							obj.data('info').refresh(obj,1);
						},
						page : function(obj, n) {
							if (n > 0 && n <= obj.data('info').maxPage) {
								obj.data('info').curIndex = n - 1;
								obj.data('info').refresh(obj,n);
							} else
								alert('頁數錯誤。');
						},
						next : function(obj) {
							if (obj.data('info').curIndex == obj.data('info').maxPage - 1)
								return;
							else {
								obj.data('info').curIndex++;
								$('#txtCurPage').val(obj.data('info').curIndex + 1);
								obj.data('info').refresh(obj,$('#txtCurPage').val());
							}
						},
						previous : function(obj) {
							if (obj.data('info').curIndex == 0)
								return;
							else {
								obj.data('info').curIndex--;
								$('#txtCurPage').val(obj.data('info').curIndex + 1);
								obj.data('info').refresh(obj,$('#txtCurPage').val());
							}
						},
						refresh : function(obj,n) {
							n=dec(n)-1;
							var objpostData = obj.data('info').postData[n];
							var objWidth = 1050;
							var objHeight = objpostData.length * 50 + 160;
							//背景
							var tmpPath = '<rect x="0" y="0" width="' + objWidth + '" height="' + objHeight + '" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
							//圖表背景顏色
							var bkColor1 = ['rgb(210,233,255)', 'rgb(255,238,221)'];
							//圖表分幾個區塊
							var bkN = 12;
							var strX = 110, strY = 70;					  
							var t_width = objWidth-255;
							var t_height = objpostData.length * 50+15;
							for (var i = 0; i < bkN; i++) {
								x = Math.round(t_width / bkN, 0) * i;
								y = 0;
								tmpPath += '<rect x="' + (strX + x) + '" y="' + (strY + y) + '" width="' + Math.round(t_width / bkN, 0) + '" height="' + (t_height) + '" style="fill:' + bkColor1[i % bkColor1.length] + ';"/>';
							}
							var t_minMoney = 0; //Y軸最小值
							//var t_maxMoney = GetBigInteger((Math.max(dec(objpostData[0].total),dec(objpostData[0].total))/10000)); //X軸最大值
							var t_maxMoney = 0; //X軸最大值
							var w_maxMount = 0;
							var w_maxMoney = 0;
							for(var j=0;j<objpostData.length;j++){
								w_maxMount = Math.max(w_maxMount,dec(objpostData[j].mount));
								w_maxMoney = Math.max(w_maxMoney,dec(dec(objpostData[j].total)/10000));
							}
							//t_maxMoney = GetBigInteger(Math.max(w_maxMount,w_maxMoney));
							t_maxMoney = GetBigInteger(w_maxMoney);
							
							/*
							if(dec(objpostData[0].total)/10000 > dec(objpostData[0].mount))
								t_maxMoney = GetBigInteger(dec(objpostData[0].total)/10000); //X軸最大值
							else
								t_maxMoney = GetBigInteger(dec(objpostData[0].mount)); //X軸最大值
							*/
							var t_X = strX + round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_width, 0);								
							var linearGradientColor = [
													   ['rgb(206,206,255)','rgb(147,147,255)'],['rgb(255,220,185)','rgb(225,175,96)'],
													   ['rgb(206,255,206)','rgb(147,255,147)'],['rgb(255,185,220)','rgb(225,96,175)'],
													   ['rgb(255,255,206)','rgb(255,255,147)'],['rgb(200,255,200)','rgb(200,255,130)']
													  ];//漸層色組
							for(var i = 0;i < linearGradientColor.length;i++){
								tmpPath += '<defs>' +
												'<linearGradient id="chart2_color' + (i+1) + '" x1="0%" y1="0%" x2="0%" y2="100%">' + 
													'<stop offset="0%" style="stop-color:'+linearGradientColor[i][0]+';stop-opacity:1" />' +
													'<stop offset="100%" style="stop-color:'+linearGradientColor[i][1]+';stop-opacity:1" />' +
												'</linearGradient>' +
											'</defs>';
							}
							if(txtreport == 'z_anavcc2_1' || txtreport == 'z_anavcc2_2' || txtreport == 'z_anavcc2_4'){
								for (var i = 0; i < objpostData.length; i++) {	
									tmpPath +='<g id="chart2_item'+i+'">';
									//客戶名稱	  
									x = strX - 5;
	 								y = strY + i*40 + 35+(i*10);
	 								if(objpostData[i].comp != undefined)
										tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+(objpostData[i].comp==''?objpostData[i].custno:objpostData[i].comp)+'</text>';	
									else if(objpostData[i].product != undefined)
										tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+objpostData[i].product+'</text>';	
									else if (objpostData[i].namea != undefined)
										tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+(objpostData[i].namea==''?objpostData[i].groupano:objpostData[i].namea)+'</text>';
									//銷貨金額
									t_total = (dec(objpostData[i].total)/10000);
									//t_mount = dec(objpostData[i].mount);
									t_price = (dec(objpostData[i].price)/10000);
									W_total = Math.abs(round(t_total / (t_maxMoney - t_minMoney) * t_width, 0));
									//W_mount = Math.abs(round(t_mount / (t_maxMoney - t_minMoney) * t_width, 0));
									W_price = Math.abs(round(t_price / (t_maxMoney - t_minMoney) * t_width, 0));
									W_total = (W_total == Infinity?0:W_total);
									//W_mount = (W_mount == Infinity?0:W_mount);
									W_price = (W_price == Infinity?0:W_price);
									(t_total>0?x_total = t_X:x_total = (t_X - W_total));
									//(t_mount>0?x_mount = t_X:x_mount = (t_X - W_mount));
									(t_price>0?x_price = t_X:x_price = (t_X - W_price));
	 								y = strY + i*40 +25+(i*10);
	 								//數值線產生
	 								tmpPath += ValueLineCreate('chart2_item','chart2_total' + i,x_total,(y-10),W_total,15,'url(#chart2_color1)','chart2_ctotal',FormatNumber(t_total),'#000000');
	 								//tmpPath += ValueLineCreate('chart2_item','chart2_mount' + i,x_mount,(y),W_mount,15,'url(#chart2_color3)','chart2_cmount',FormatNumber(t_mount),'#000000');
	 								tmpPath += ValueLineCreate('chart2_item','chart2_price' + i,x_price,(y+10),W_price,15,'url(#chart2_color5)','chart2_cprice',FormatNumber(t_price),'#000000');
									tmpPath += '</g>';
								}
								//X軸
								tmpPath += '<line x1="'+strX+'" y1="'+strY+'" x2="'+(strX+t_width+5)+'" y2="'+strY+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								tmpPath += '<text x="'+strX+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';
								tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
								//Y軸
								tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+obj.data('info').postData[n].length * 51.6)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								//符號說明
								tmpPath += MarkHelp((strX+t_width+10),(objHeight-70),'url(#chart2_color1)','銷貨金額(萬元)','black');
								//tmpPath += MarkHelp((strX+t_width+10),(objHeight-90)+30,'url(#chart2_color3)','數量','black');
								tmpPath += MarkHelp((strX+t_width+10),(objHeight-70)+30,'url(#chart2_color5)','毛利(萬元)','black');
							}else if(txtreport == 'z_anavcc2_3'){
								//客戶名稱(標題)
								tmpPath += '<text x="30" y="30" fill="#000000" >'+(objpostData[0].custno+' '+objpostData[0].comp)+'</text>';
								for (var i = 0; i < objpostData.length; i++) {	
									tmpPath +='<g id="chart2_item'+i+'">';
									x = strX - 5;
	 								y = strY + i*40 + 35+(i*10);
									tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+objpostData[i].product+'</text>';	
									//銷貨金額
									t_total = (dec(objpostData[i].total)/10000);
									//t_mount = dec(objpostData[i].mount);
									t_price = (dec(objpostData[i].price)/10000);
									W_total = Math.abs(round(t_total / (t_maxMoney - t_minMoney) * t_width, 0));
									//W_mount = Math.abs(round(t_mount / (t_maxMoney - t_minMoney) * t_width, 0));
									W_price = Math.abs(round(t_price / (t_maxMoney - t_minMoney) * t_width, 0));
									W_total = (W_total == Infinity?0:W_total);
									//W_mount = (W_mount == Infinity?0:W_mount);
									W_price = (W_price == Infinity?0:W_price);
									(t_total>0?x_total = t_X:x_total = (t_X - W_total));
									//(t_mount>0?x_mount = t_X:x_mount = (t_X - W_mount));
									(t_price>0?x_price = t_X:x_price = (t_X - W_price));
	 								y = strY + i*40 +25+(i*10);
	 								//數值線產生
	 								tmpPath += ValueLineCreate('chart2_item','chart2_total' + i,x_total,(y-10),W_total,15,'url(#chart2_color1)','chart2_ctotal',FormatNumber(t_total),'#000000');
	 								//tmpPath += ValueLineCreate('chart2_item','chart2_mount' + i,x_mount,(y),W_mount,15,'url(#chart2_color3)','chart2_cmount',FormatNumber(t_mount),'#000000');
	 								tmpPath += ValueLineCreate('chart2_item','chart2_price' + i,x_price,(y+10),W_price,15,'url(#chart2_color5)','chart2_cprice',FormatNumber(t_price),'#000000');
									tmpPath += '</g>';
									//X軸
									tmpPath += '<line x1="'+strX+'" y1="'+strY+'" x2="'+(strX+t_width+5)+'" y2="'+strY+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
									tmpPath += '<text x="'+strX+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';
									tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
									//Y軸
									tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+obj.data('info').postData[n].length * 40+25)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
									//符號說明
									tmpPath += MarkHelp((strX+t_width+10),(objHeight-70),'url(#chart2_color1)','銷貨金額(萬元)','black');
									//tmpPath += MarkHelp((strX+t_width+10),(objHeight-90)+30,'url(#chart2_color3)','數量','black');
									tmpPath += MarkHelp((strX+t_width+10),(objHeight-70)+30,'url(#chart2_color5)','毛利(萬元)','black');
								}
							}else if(txtreport == 'z_anavcc2_Compare1' || txtreport == 'z_anavcc2_Compare2'){
								//客戶名稱(標題)
								if(txtreport == 'z_anavcc2_Compare1')
									tmpPath += '<text x="30" y="30" fill="#000000" >'+(objpostData[0].custno+' '+objpostData[0].comp)+'</text>';
								else if(txtreport == 'z_anavcc2_Compare2')
									tmpPath += '<text x="30" y="30" fill="#000000" >'+(objpostData[0].productno+' '+objpostData[0].product)+'</text>';
								for (var i = 0; i < objpostData.length; i++) {	
									tmpPath +='<g id="chart2_item'+i+'">';
									x = strX - 5;
	 								y = strY + i*40 + 35+(i*10);
	 								var s_bdate = trim($('#txtXbmon1').val()) + '~' + trim($('#txtXbmon2').val());
	 								var s_edate = trim($('#txtXemon1').val()) + '~' + trim($('#txtXemon2').val());
	 								if(objpostData[i].mon =='B')
										tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+s_bdate+'</text>';	
	 								else if(objpostData[i].mon =='E')
										tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+s_edate+'</text>';	
									//銷貨金額
									t_total = (dec(objpostData[i].total)/10000);
									//t_mount = dec(objpostData[i].mount);
									t_price = (dec(objpostData[i].price)/10000);
									W_total = Math.abs(round(t_total / (t_maxMoney - t_minMoney) * t_width, 0));
									//W_mount = Math.abs(round(t_mount / (t_maxMoney - t_minMoney) * t_width, 0));
									W_price = Math.abs(round(t_price / (t_maxMoney - t_minMoney) * t_width, 0));
									W_total = (W_total == Infinity?0:W_total);
									//W_mount = (W_mount == Infinity?0:W_mount);
									W_price = (W_price == Infinity?0:W_price);
									(t_total>0?x_total = t_X:x_total = (t_X - W_total));
									//(t_mount>0?x_mount = t_X:x_mount = (t_X - W_mount));
									(t_price>0?x_price = t_X:x_price = (t_X - W_price));
	 								y = strY + i*40 +25+(i*10);
	 								//數值線產生
	 								tmpPath += ValueLineCreate('chart2_item','chart2_total' + i,x_total,(y-10),W_total,15,'url(#chart2_color1)','chart2_ctotal',FormatNumber(t_total),'#000000');
	 								//tmpPath += ValueLineCreate('chart2_item','chart2_mount' + i,x_mount,(y),W_mount,15,'url(#chart2_color3)','chart2_cmount',FormatNumber(t_mount),'#000000');
	 								tmpPath += ValueLineCreate('chart2_item','chart2_price' + i,x_price,(y+10),W_price,15,'url(#chart2_color5)','chart2_cprice',FormatNumber(t_price),'#000000');
									tmpPath += '</g>';
								}
								//X軸
								tmpPath += '<line x1="'+strX+'" y1="'+strY+'" x2="'+(strX+t_width+5)+'" y2="'+strY+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								tmpPath += '<text x="'+strX+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';
								tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
								//Y軸
								tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+obj.data('info').postData[n].length * 51.6)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								//符號說明
								tmpPath += MarkHelp((strX+t_width+10),(objHeight-70),'url(#chart2_color1)','銷貨金額(萬元)','black');
								//tmpPath += MarkHelp((strX+t_width+10),(objHeight-90)+30,'url(#chart2_color3)','數量','black');
								tmpPath += MarkHelp((strX+t_width+10),(objHeight-70)+30,'url(#chart2_color5)','毛利(萬元)','black');
							}
							obj.width(objWidth).height(objHeight).html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph" width="100%" height="100%">' + tmpPath + '</svg> ');
							//事件
							obj.children('svg').find('.chart2_item').hover(function(e) {
								var n = $(this).parent().attr('id').replace('chart2_item','');
								$('#chart2_nick'+n).attr('fill', 'rgb(255,0,0)');
								$('#chart2_total'+n).attr('fill', 'url(#chart2_color2)');
								$('#chart2_mount'+n).attr('fill', 'url(#chart2_color4)');
								$('#chart2_price'+n).attr('fill', 'url(#chart2_color6)');
								$('rect[fill="url(#chart2_color1)"][id="Mark"]').attr('fill', 'url(#chart2_color2)');
								$('rect[fill="url(#chart2_color3)"][id="Mark"]').attr('fill', 'url(#chart2_color4)');
								$('rect[fill="url(#chart2_color5)"][id="Mark"]').attr('fill', 'url(#chart2_color6)');
							}, function(e) {
								var n = $(this).parent().attr('id').replace('chart2_item','');
								$('#chart2_nick'+n).attr('fill', 'rgb(0,0,0)');
								$('#chart2_total'+n).attr('fill', 'url(#chart2_color1)');
								$('#chart2_mount'+n).attr('fill', 'url(#chart2_color3)');
								$('#chart2_price'+n).attr('fill', 'url(#chart2_color5)');
								$('rect[fill="url(#chart2_color2)"][id="Mark"]').attr('fill', 'url(#chart2_color1)');
								$('rect[fill="url(#chart2_color4)"][id="Mark"]').attr('fill', 'url(#chart2_color3)');
								$('rect[fill="url(#chart2_color6)"][id="Mark"]').attr('fill', 'url(#chart2_color5)');
							});
						}
					});
					$(this).data('info').init($(this));
				};
				$.fn.barChart = function(value) {
					$(this).data('info', {
						curIndex : -1,
						postData : value.data,
						maxPage : value.data.length,
						init : function(obj) {
							if (value.length == 0) {
								alert('無資料。');
								return;
							}
							obj.data('info').curIndex = 0;
							$('#txtCurPage').val(1);
							obj.data('info').refresh(obj,1);
						},
						page : function(obj, n) {
							if (n > 0 && n <= obj.data('info').maxPage) {
								obj.data('info').curIndex = n - 1;
								obj.data('info').refresh(obj,n);
							} else
								alert('頁數錯誤。');
						},
						next : function(obj) {
							if (obj.data('info').curIndex == obj.data('info').maxPage - 1)
								return;
							else {
								obj.data('info').curIndex++;
								$('#txtCurPage').val(obj.data('info').curIndex + 1);
								obj.data('info').refresh(obj,$('#txtCurPage').val());
							}
						},
						previous : function(obj) {
							if (obj.data('info').curIndex == 0)
								return;
							else {
								obj.data('info').curIndex--;
								$('#txtCurPage').val(obj.data('info').curIndex + 1);
								obj.data('info').refresh(obj,$('#txtCurPage').val());
							}
						},
						refresh : function(obj,n) {
							n=dec(n)-1;
							var objpostData = obj.data('info').postData[n];
							var t_byear = objpostData[0].tyear;
							var t_eyear = objpostData[13].tyear;
							var objWidth = 950;
							var objHeight = 450;
							//背景
							var tmpPath = '<rect x="0" y="0" width="' + objWidth + '" height="' + objHeight + '" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
							//圖表背景顏色
							var bkColor1 = ['rgb(210,233,255)', 'rgb(255,238,221)'];
							//圖表分幾個區塊
							var bkN = 10;
							var strX = 100, strY = 70;					  
							var t_width = 720;
							var t_height = 330;
							for (var i = 0; i < bkN; i++) {
								x = Math.round(t_width / bkN, 0) * i;
								y = 0;
							   	tmpPath += '<rect x="' + strX + '" y="' + (strY+(Math.round(t_height / bkN, 0)*i)) + '" width="' + t_width + '" height="'+Math.round(t_height / bkN, 0)+'" style="fill:' + bkColor1[i % bkColor1.length] + ';"/>';
							}
							var t_minMoney = 0; //Y軸最小值
							var t_maxMoney = 0; //X軸最大值
							for(var i=0;i < objpostData.length;i++){
								if(dec(objpostData[i].total) > dec(t_maxMoney)){
									t_maxMoney = dec(objpostData[i].total);
								}
							}
 							var t_X = strX + round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_width, 0);								
							var t_Y = strY + t_height - round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_height, 0);
							var linearGradientColor = [
													   ['rgb(206,206,255)','rgb(147,147,255)'],['rgb(255,220,185)','rgb(225,175,96)'],
													   ['rgb(206,255,206)','rgb(147,255,147)'],['rgb(255,185,220)','rgb(225,96,175)'],
													  ];//漸層色組
							for(var i = 0;i < linearGradientColor.length;i++){
								tmpPath += '<defs>' +
												'<linearGradient id="chart2_color' + (i+1) + '" x1="0%" y1="0%" x2="0%" y2="100%">' + 
													'<stop offset="0%" style="stop-color:'+linearGradientColor[i][0]+';stop-opacity:1" />' +
													'<stop offset="100%" style="stop-color:'+linearGradientColor[i][1]+';stop-opacity:1" />' +
												'</linearGradient>' +
											'</defs>';
							}
							if(txtreport == 'z_anavcc2_Custyear' || txtreport == 'z_anavcc2_Productyear'){
								tmpPath += '<text x="30" y="30" fill="#000000" >'+(objpostData[0].custno+' '+objpostData[0].comp)+'</text>';
								wStrX = strX;
								var t_range = round((t_maxMoney - t_minMoney)/5,0);
								var i = Math.pow(10,(t_range+'').length-1);
								var t_range = Math.floor(t_range/i)*i;
								t_money = t_range;
								while (t_money < t_maxMoney) {
									if((t_maxMoney-t_money)/(t_maxMoney - t_minMoney)>0.05){
										y = t_Y - round(t_money / (t_maxMoney - t_minMoney) * t_height, 0);
										tmpPath += '<line x1="'+(strX-5)+'" y1="' + y + '" x2="'+strX+'" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
										tmpPath += '<text text-anchor="end" x="90" y="' + y + '" fill="black">' + FormatNumber(t_money)+ '</text>';
									}
									t_money += t_range;
								}
								for (var i = 0; i < (objpostData.length/2); i++) {	
									tmpPath +='<g id="chart2_item'+i+'">';
									x = strX - 5;
	 								y = strY + i*40 + 30;
	 								t_m01A = dec(objpostData[i].total);
									w_m01A = Math.abs(round(t_m01A / (t_maxMoney - t_minMoney) * t_height, 0));
									x_m01A = 70+(t_height-w_m01A);
	 								t_m01B = dec(objpostData[i+12].total);
									w_m01B = Math.abs(round(t_m01B / (t_maxMoney - t_minMoney) * t_height, 0));
									x_m01B = 70+(t_height-w_m01B);

	 								//數值線產生
	 								tmpPath += ValueLineCreate('chart2_item','chart2_btotal' + i,wStrX,x_m01A,30,w_m01A,'url(#chart2_color1)','chart2_cbtotal','','#000000');
									wStrX += 30;
	 								tmpPath += ValueLineCreate('chart2_item','chart2_etotal' + i,wStrX,x_m01B,30,w_m01B,'url(#chart2_color3)','chart2_cetotal','','#000000');
									wStrX += 30;
									tmpPath += '</g>';
									tmpPath += '<text id="mon'+i+'" x="'+(wStrX-45)+'" y="420" fill="#000000" >'+dec(objpostData[i].mon)+'月'+'</text>';
								}
								//X軸
								tmpPath += '<line x1="'+strX+'" y1="400" x2="'+(strX+t_width)+'" y2="400" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								//tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
								tmpPath += '<line x1="'+(strX-5)+'" y1="70" x2="'+strX+'" y2="70" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								tmpPath += '<text text-anchor="end"  x="'+(strX-10)+'" y="75" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						

								tmpPath += '<line x1="'+(strX-5)+'" y1="400" x2="'+strX+'" y2="400" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								tmpPath += '<text text-anchor="end"  x="'+(strX-10)+'" y="405" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';						
								
								//Y軸
								tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+t_height)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								//符號說明
								tmpPath += MarkHelp((strX+t_width+10),(objHeight-60),'url(#chart2_color1)',t_byear+'年度','black');
								tmpPath += MarkHelp((strX+t_width+10),(objHeight-60)+30,'url(#chart2_color3)',t_eyear+'年度','black');
								
							}
							obj.width(objWidth).height(objHeight).html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph" width="100%" height="100%">' + tmpPath + '</svg> ');
							$('g[id*="chart2_item"]').click(function(){
								var thisId = $(this).attr('id').replace('chart2_item','');
								var alertStr = '';
								alertStr += t_byear+'年度 '+dec(dec(thisId)+1)+' 月 : ' + FormatNumber(objpostData[thisId].total) + '\n';
								alertStr += t_eyear+'年度 '+dec(dec(thisId)+1)+' 月 : ' + FormatNumber(objpostData[(dec(thisId)+12)].total) + '\n';
								alert(alertStr);
							}).hover(function(){
								var thisId = $(this).attr('id').replace('chart2_item','');
								$('#mon'+thisId).attr('fill', '#FF0000');
							},function(){
								var thisId = $(this).attr('id').replace('chart2_item','');
								$('#mon'+thisId).attr('fill', '#000000');
							});
							$('[id*="mon"]').click(function(){
								var thisId = $(this).attr('id').replace('mon','');
								$('#chart2_item'+thisId).click();
							}).hover(function(){
								var thisId = $(this).attr('id').replace('mon','');
								$('#mon'+thisId).attr('fill', '#FF0000');
							},function(){
								var thisId = $(this).attr('id').replace('mon','');
								$('#mon'+thisId).attr('fill', '#000000');
							});
						}
					});
					$(this).data('info').init($(this));
				};
				
				//圓餅圖
				$.fn.pieChart = function(value) {
                    $(this).data('info', {
                        value : value,
                        fillColor : color,
                        strokeColor : ["#000000"],
                        focusfillColor : "#FFEEFE",
                        focusIndex : -1,
                        init : function(obj) {
                            obj.addClass('pieChart');
                            var tmp = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                tmp += dec(obj.data('info').value.data[i].total);
                            }
                            var tmpDegree = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                obj.data('info').value.data[i].rate = dec(obj.data('info').value.data[i].total) / tmp;
                                obj.data('info').value.data[i].degree = 2 * Math.PI * obj.data('info').value.data[i].rate;
                                obj.data('info').value.data[i].bDegree = tmpDegree;
                                tmpDegree += obj.data('info').value.data[i].degree;
                                obj.data('info').value.data[i].eDegree = tmpDegree;
                                obj.data('info').value.data[i].fillColor = obj.data('info').fillColor[i % obj.data('info').fillColor.length];
                                obj.data('info').value.data[i].strokeColor = obj.data('info').strokeColor[i % obj.data('info').strokeColor.length];
                            }
                            obj.data('info').refresh(obj);
                        },
                        refresh : function(obj) {
                            obj.html('');
                            var tmpPath = '', shiftX, shiftY, degree, fillColor, strokeColor;
                            var x = obj.data('info').value.x;
                            var y = obj.data('info').value.y;
                            var radius = obj.data('info').value.radius;
                            var xbranch=0,ybranch=0;//分行
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                if (i == obj.data('info').focusIndex) {
                                    shiftX = Math.round(10 * Math.cos(obj.data('info').value.data[i].bDegree + obj.data('info').value.data[i].degree / 2), 0);
                                    shiftY = Math.round(10 * Math.sin(obj.data('info').value.data[i].bDegree + obj.data('info').value.data[i].degree / 2), 0);
                                    fillColor = '"' + obj.data('info').focusfillColor + '"';
                                    strokeColor = '"' + obj.data('info').value.data[i].strokeColor + '"';
                                } else {
                                    shiftX = 0;
                                    shiftY = 0;
                                    fillColor = '"' + obj.data('info').value.data[i].fillColor + '"';
                                    strokeColor = '"' + obj.data('info').value.data[i].strokeColor + '"';
                                }
                                degree = Math.round(obj.data('info').value.data[i].degree * 360 / (2 * Math.PI), 0);
                                obj.data('info').value.data[i].currentFillColor = fillColor;
                                obj.data('info').value.data[i].currentStrokeColor = strokeColor;
                                obj.data('info').value.data[i].point1 = [x + shiftX, y + shiftY];
                                obj.data('info').value.data[i].point2 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].bDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].bDegree), 0)];
                                obj.data('info').value.data[i].point3 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].eDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].eDegree), 0)];
                                
                                if(i>14&&i%35==0){//分行
                                	xbranch+=120;
                                	ybranch=i;
                                }
                                
                                var pointLogo = [x + radius + 20+xbranch, (i-ybranch)* 20 + 30];
                                var pointText = [x + radius + 35+xbranch, (i-ybranch) * 20 + 40];
                                tmpPath += '<rect class="blockLogo" id="blockLogo_'+i+'" width="10" height="10" x="' + pointLogo[0] + '" y="' + pointLogo[1] + '" fill=' + fillColor + ' stroke=' + strokeColor + '/>';
                                tmpPath += '<text class="blockText" id="blockText_'+i+'" x="' + pointText[0] + '" y="' + pointText[1] + '" fill="#000000">' + (obj.data('info').value.data[i].comp!=undefined?(obj.data('info').value.data[i].comp==''?obj.data('info').value.data[i].custno:obj.data('info').value.data[i].comp):obj.data('info').value.data[i].namea )+ '</text>';
                                if (degree != 360)
                                    tmpPath += '<path class="block" id="block_' + i + '" d="M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + (degree > 180 ? ' 1 1 ' : ' 0 1 ') + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
                                else
                                    tmpPath += '<circle class="block" id="block_' + i + '" cx="' + x + '" cy="' + y + '" r="' + radius + '" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
                            }
                            obj.append('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                obj.children('svg').find('.block').eq(i).data('info', {
                                    index : i
                                });
                                obj.children('svg').find('.blockLogo').eq(i).data('info', {
                                    index : i
                                });
                                obj.children('svg').find('.blockText').eq(i).data('info', {
                                    index : i
                                });
                            }

                            obj.children('svg').find('.block,.blockLogo,.blockText').hover(function(e) {
                                var obj = $(this).parent().parent();
                                $('#block_'+$(this).data('info').index).attr('fill',obj.data('info').focusfillColor);
                                $('#blockLogo_'+$(this).data('info').index).attr('fill',obj.data('info').focusfillColor);
                            }, function(e) {
                                var obj = $(this).parent().parent();
                                $('#block_'+$(this).data('info').index).attr('fill',obj.data('info').fillColor[$(this).data('info').index]);
                                $('#blockLogo_'+$(this).data('info').index).attr('fill',obj.data('info').fillColor[$(this).data('info').index]);
                            }).click(function(e){
                            	var obj = $(this).parent().parent();
                            	if(txtreport=='z_anavcc2_1'){
                            		var txttmp='';
                            		txttmp='客戶：'+obj.data('info').value.data[$(this).data('info').index].custno+' '+obj.data('info').value.data[$(this).data('info').index].comp+'\n';
                            		txttmp+='銷貨金額：'+obj.data('info').value.data[$(this).data('info').index].total+'\n'
                            		txttmp+='毛利：'+round(dec(obj.data('info').value.data[$(this).data('info').index].rate)*100,2)+'%'
                            		alert(txttmp);
                            	}else if(txtreport=='z_anavcc2_4'){
                            		var txttmp='';
                            		txttmp='類別：'+obj.data('info').value.data[$(this).data('info').index].groupano+' '+obj.data('info').value.data[$(this).data('info').index].namea+'\n';
                            		txttmp+='銷貨金額：'+obj.data('info').value.data[$(this).data('info').index].total+'\n'
                            		txttmp+='毛利：'+round(dec(obj.data('info').value.data[$(this).data('info').index].rate)*100,2)+'%'
                            		alert(txttmp);
                            	}
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
				
			})($);
			function MarkHelp(MarkXpos,MarkYpos,MarkColor,Title,TitleColor){
				var str = '';
				str = '<rect id="Mark" x="'+MarkXpos+'" y="'+MarkYpos+'" width="20" height="20" fill="'+MarkColor+'"/>';
				str += '<text x="'+(MarkXpos+25)+'" y="'+(MarkYpos+15)+'" fill="'+TitleColor+'">'+Title+'</text>';
				return str;
			}
			function ValueLineCreate(Class,rectId,rectX,rectY,rectWidth,rectHeight,rectColor,textId,textTitle,textColor){
				var str = '';
				str = '<rect class="'+Class+'" id="'+rectId +'" x="' + rectX + '" y="' + rectY + '" width="' + rectWidth +
					  '" height="' + rectHeight + '" fill="'+rectColor+'"/>';
				str += '<text class="'+Class+'" id="'+textId +'" x="'+ (rectX+rectWidth+5) +'" y="'+(rectY+13)+
					  '" fill="'+textColor+'" >'+textTitle+'</text>';	
				return str;
			}
			function FormatNumber(n) {
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}
			function GetBigInteger(value){
				var n = dec('1' + padL('','0',(value.toString().split('.')[0].length-1)));
				n = Math.ceil(value/n)*n;
				return n;
			}
			
			
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container" style="width:2000px;">
				<div id="q_report"> </div>
				<input type="button" id="btnXXX" style="float:left; width:80px;font-size: medium;" value="權限"/>
			</div>
			<div style="display:inline-block;width:2000px;">
				<input type="button" id="printWith" name="chart">
				<input type="button" id="showpieChart" name="chart" value="轉換至圓餅圖">
			</div>
			<div id="chartCtrl" style="display:inline-block;width:2000px;">
				<input type="button" id="btnRun" style="float:left; width:80px;font-size: medium;" value="執行"/>
				<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			</div>
			<div id="chart">
				<div id='barChart2'> </div>
				<div id='pieChart' style="height: 500px"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;display:none;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
		<div id="q_acDiv" style="display: none;"><div> </div></div>
	</body>
</html>