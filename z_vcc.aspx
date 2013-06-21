<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="/../script/jquery.min.js" type="text/javascript"> </script>
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
            var txtreport='';
            var UseReport1 = [['長條圖依客戶','z_anavcc1'],['長條圖依產品','z_anavcc2'],['長條圖依客戶、產品','z_anavcc3']];
            var UseReport2 = [['客戶比較圖','z_anavccCompare1'],['產品比較圖','z_anavccCompare2']];
            if(location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;100";
            }
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_vcc');
                $('input[id="btnSvg"]').hide();
                $('#q_report').click(function(){
                	CreatButton();
					for(var i =0 ;i<$('#q_report').data().info.reportData.length;i++){
						var rePortData = $('#q_report').data().info.reportData[i];
						if($('.radio.select').next().text()==rePortData.reportName){
							if(rePortData.report == 'z_anavcc' || rePortData.report == 'z_anavccCompare'){
                				$('#dataSearch').hide();
								$('#ChartCtrl').show();
								$('#svgbet').show();
							}else{
                				$('#dataSearch').show();
								$('#ChartCtrl').hide();
								$('#svgbet').hide();
							}
							$('#barChart2').html('').hide();
						}
					}
                });
            });
			
			function CreatButton(){
				$('#svgbet').html('');
				var ButtonStr = '';
				if($('.radio.select').next().text() == '統計圖表'){
					for(var i = 0;i < UseReport1.length;i++){
						ButtonStr += '<input id="btnSvg" type="button" use="'+UseReport1[i][1]+'" value="'+UseReport1[i][0]+'" />';
						if(i%2 == 1)
							ButtonStr += '<br>';
					}
				}else if($('.radio.select').next().text() == '比較圖表'){
					for(var i = 0;i < UseReport2.length;i++){
						ButtonStr += '<input id="btnSvg" type="button" use="'+UseReport2[i][1]+'" value="'+UseReport2[i][0]+'" />';
						if(i%2 == 1)
							ButtonStr += '<br>';
					}
				}
				$(ButtonStr).appendTo($('#svgbet')).click(function(){
					if(emp($('#txtXbmon1').val()))
						$('#txtXbmon1').val(r_accy+'/01');
					if(emp($('#txtXbmon2').val()))
						$('#txtXbmon2').val(r_accy+'/12');
					if(emp($('#txtXemon1').val()))
						$('#txtXemon1').val(r_accy+'/01');
					if(emp($('#txtXemon2').val()))
						$('#txtXemon2').val(r_accy+'/12');
                	txtreport = $(this).attr('use');
                	$('#dataSearch').hide();
                	var t_bdate='#non',t_edate='#non',t_bmon='#non',t_emon='#non',t_bcustno='#non',t_ecustno='#non';
                	var t_bsalesno='#non',t_esalesno='#non',t_bproductno='#non',t_eproductno='#non';
                	var t_xbbmon='#non',t_xbemon='#non',t_xebmon='#non',t_xeemon='#non';
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
                	if($('.radio.select').next().text() == '統計圖表'){
						if(!emp($('#txtDate1').val()))
							t_bdate=encodeURI($('#txtDate1').val());
						if(!emp($('#txtDate2').val()))
							t_edate=encodeURI($('#txtDate2').val());
						if(!emp($('#txtMon1').val()))
							t_bmon=encodeURI($('#txtMon1').val());
						if(!emp($('#txtMon2').val()))
							t_emon=encodeURI($('#txtMon2').val());
						q_func('qtxt.query','z_anavcc.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_bdate + ';' + t_edate + ';' +
						t_bmon + ';' + t_emon + ';' + t_bcustno + ';' + t_ecustno + ';' + t_bsalesno + ';' + t_esalesno + ';' +
						t_bproductno + ';' + t_eproductno + ';'
						);
					}else{
						if(!emp($('#txtXbmon1').val()))
							t_xbbmon=encodeURI($('#txtXbmon1').val());
						if(!emp($('#txtXbmon2').val()))
							t_xbemon=encodeURI($('#txtXbmon2').val());
						if(!emp($('#txtXemon1').val()))
							t_xebmon=encodeURI($('#txtXemon1').val());
						if(!emp($('#txtXemon2').val()))
							t_xeemon=encodeURI($('#txtXemon2').val());
						q_func('qtxt.query','z_anavcc.txt,'+txtreport+','+encodeURI(r_accy) + ';' + t_xbbmon + ';' + t_xbemon + ';' +
						t_xebmon + ';' + t_xeemon + ';' + t_bcustno + ';' + t_ecustno + ';' + t_bsalesno + ';' + t_esalesno + ';' +
						t_bproductno + ';' + t_eproductno + ';'
						);
					}
				});
			}
			
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_vcc',
                    options : [{
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '1',
                        name : 'date'
                    }, {
                        type : '1',
                        name : 'mon'
                    }, {
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2',
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2',
                        name : 'product',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {
                        type : '1',
                        name : 'xbmon'
                    }, {
                        type : '1',
                        name : 'xemon'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtMon1').mask('999/99');
                $('#txtMon2').mask('999/99');
				$('#txtXbmon1').val(r_accy+'/01').mask('999/99');
                $('#txtXbmon2').val(r_accy+'/12').mask('999/99');
                $('#txtXemon1').val(r_accy+'/01').mask('999/99');
                $('#txtXemon2').val(r_accy+'/12').mask('999/99');
                
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
								if(txtreport == 'z_anavcc1'){
									bar[rec].push(
										{
											custno:as[i].custno,
											comp:as[i].comp,
											mount:as[i].mount,
											total:as[i].total
										}
									);
								}else if(txtreport == 'z_anavcc2'){
									bar[rec].push(
										{
											productno:as[i].productno,
											product:as[i].product,
											mount:as[i].mount,
											total:as[i].total
										}
									);
								}else if(txtreport == 'z_anavcc3'){
									bar[rec].push(
										{
											custno:as[i].custno,
											comp:as[i].comp,
											productno:as[i].productno,
											product:as[i].product,
											mount:as[i].mount,
											total:as[i].total
										}
									);
								}else if(txtreport == 'z_anavccCompare1'){
									if((i>1 && as[i].mon=='E' && as[i-1].mon != 'B') || (i==0 && as[i].mon=='E')){
										bar[rec].push(
											{
												mon:'B',
												custno:as[i].custno,
												comp:as[i].comp,
												mount:0,
												total:0
											}
										);
									}
									bar[rec].push(
										{
											mon:as[i].mon,
											custno:as[i].custno,
											comp:as[i].comp,
											mount:as[i].mount,
											total:as[i].total
										}
									);
									if(as[i].mon=='B' && as[i+1].mon != 'E'){
										bar[rec].push(
											{
												mon:'E',
												custno:as[i].custno,
												comp:as[i].comp,
												mount:0,
												total:0
											}
										);
									}
								}else if(txtreport == 'z_anavccCompare2'){
									if((i>1 && as[i].mon=='E' && as[i-1].mon != 'B') || (i==0 && as[i].mon=='E')){
										bar[rec].push(
											{
												mon:'B',
												productno:as[i].productno,
												product:as[i].product,
												mount:0,
												total:0
											}
										);
									}
									bar[rec].push(
										{
											mon:as[i].mon,
											productno:as[i].productno,
											product:as[i].product,
											mount:as[i].mount,
											total:as[i].total
										}
									);
									if(as[i].mon=='B' && as[i+1].mon != 'E'){
										bar[rec].push(
											{
												mon:'E',
												productno:as[i].productno,
												product:as[i].product,
												mount:0,
												total:0
											}
										);
									}
								}
							}
							$('#barChart2').barChart2({
								data : bar
							});
							$('#btnXPrevious').unbind('click').click(function(){
								$('#barChart2').data('info').previous($('#barChart2'));
							});
							$('#btnXNext').unbind('click').click(function(){
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
                                alert('已到最後頁。');
                            else {
                                obj.data('info').curIndex++;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj,$('#txtCurPage').val());
                            }
                        },
                        previous : function(obj) {
                            if (obj.data('info').curIndex == 0)
                                alert('已到最前頁。');
                            else {
                                obj.data('info').curIndex--;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj,$('#txtCurPage').val());
                            }
                        },
                        refresh : function(obj,n) {
                        	n=dec(n)-1;
                        	var objpostData = obj.data('info').postData[n];
                            var objWidth = 950;
                            var objHeight = objpostData.length * 40 + 120;
                            //背景
                            var tmpPath = '<rect x="0" y="0" width="' + objWidth + '" height="' + objHeight + '" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
                            //圖表背景顏色
                            var bkColor1 = ['rgb(210,233,255)', 'rgb(255,238,221)'];
                            //圖表分幾個區塊
                            var bkN = 10;
                            var strX = 100, strY = 70;                      
                            var t_width = 700;
                            var t_height = objpostData.length * 40;
                            for (var i = 0; i < bkN; i++) {
                                x = Math.round(t_width / bkN, 0) * i;
                                y = 0;
                                tmpPath += '<rect x="' + (strX + x) + '" y="' + (strY + y) + '" width="' + Math.round(t_width / bkN, 0) + '" height="' + (t_height) + '" style="fill:' + bkColor1[i % bkColor1.length] + ';"/>';
                            }
                            var t_minMoney = 0; //Y軸最小值
							var t_maxMoney = GetBigInteger((Math.max(dec(objpostData[0].total),dec(objpostData[1].total))/10000)); //X軸最大值
							
                            var t_X = strX + round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_width, 0);                                
							var linearGradientColor = [
													   ['rgb(206,206,255)','rgb(147,147,255)'],['rgb(255,220,185)','rgb(225,175,96)'],
													   ['rgb(206,255,206)','rgb(147,255,147)'],['rgb(255,185,220)','rgb(225,96,175)']
													  ];//漸層色組
							for(var i = 0;i < linearGradientColor.length;i++){
	                            tmpPath += '<defs>' +
	                            				'<linearGradient id="chart2_color' + (i+1) + '" x1="0%" y1="0%" x2="0%" y2="100%">' + 
	                            					'<stop offset="0%" style="stop-color:'+linearGradientColor[i][0]+';stop-opacity:1" />' +
													'<stop offset="100%" style="stop-color:'+linearGradientColor[i][1]+';stop-opacity:1" />' +
												'</linearGradient>' +
											'</defs>';
							}
							if(txtreport == 'z_anavcc1' || txtreport == 'z_anavcc2'){
								for (var i = 0; i < objpostData.length; i++) {    
									tmpPath +='<g id="chart2_item'+i+'">';
									//客戶名稱      
	                                x = strX - 5;
	 								y = strY + i*40 + 30;
	 								if(objpostData[i].comp != undefined)
		                                tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+objpostData[i].comp+'</text>';	
									else if(objpostData[i].product != undefined)
		                                tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+objpostData[i].product+'</text>';	
	                            	//收入
	                            	t_total = (dec(objpostData[i].total)/10000);
	                            	t_mount = dec(objpostData[i].mount);
	                                W_total = Math.abs(round(t_total / (t_maxMoney - t_minMoney) * t_width, 0));
	                                W_mount = Math.abs(round(t_mount / (t_maxMoney - t_minMoney) * t_width, 0));
	                                (t_total>0?x_total = t_X:x_total = (t_X - W_total));
	                                (t_mount>0?x_mount = t_X:x_mount = (t_X - W_mount));
	 								y = strY + i*40 +25;
	 								//數值線產生
	 								tmpPath += ValueLineCreate('chart2_item','chart2_total' + i,x_total,(y-15),W_total,15,'url(#chart2_color1)','chart2_ctotal',FormatNumber(t_total),'#000000');
	 								tmpPath += ValueLineCreate('chart2_item','chart2_mount' + i,x_mount,(y),W_mount,15,'url(#chart2_color3)','chart2_cmount',FormatNumber(t_mount),'#000000');
	                            	tmpPath += '</g>'
	                            }
	                            //X軸
	                            tmpPath += '<line x1="'+strX+'" y1="'+strY+'" x2="'+(strX+t_width)+'" y2="'+strY+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								tmpPath += '<text x="'+strX+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';
								tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
								//Y軸
	                            tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+obj.data('info').postData[n].length * 40)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
	                            //符號說明
	                            tmpPath += MarkHelp((strX+t_width+40),(objHeight-60),'url(#chart2_color1)','收入(萬元)','black');
	                            tmpPath += MarkHelp((strX+t_width+40),(objHeight-60)+30,'url(#chart2_color3)','數量','black');
							}else if(txtreport == 'z_anavcc3'){
								//客戶名稱(標題)
								tmpPath += '<text x="30" y="30" fill="#000000" >'+objpostData[0].comp+'</text>';
								for (var i = 0; i < objpostData.length; i++) {    
									tmpPath +='<g id="chart2_item'+i+'">';
	                                x = strX - 5;
	 								y = strY + i*40 + 30;
		                            tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+objpostData[i].product+'</text>';	
	                            	//收入
	                            	t_total = (dec(objpostData[i].total)/10000);
	                            	t_mount = dec(objpostData[i].mount);
	                                W_total = Math.abs(round(t_total / (t_maxMoney - t_minMoney) * t_width, 0));
	                                W_mount = Math.abs(round(t_mount / (t_maxMoney - t_minMoney) * t_width, 0));
	                                (t_total>0?x_total = t_X:x_total = (t_X - W_total));
	                                (t_mount>0?x_mount = t_X:x_mount = (t_X - W_mount));
	 								y = strY + i*40 +25;
	 								//數值線產生
	 								tmpPath += ValueLineCreate('chart2_item','chart2_total' + i,x_total,(y-15),W_total,15,'url(#chart2_color1)','chart2_ctotal',FormatNumber(t_total),'#000000');
	 								tmpPath += ValueLineCreate('chart2_item','chart2_mount' + i,x_mount,(y),W_mount,15,'url(#chart2_color3)','chart2_cmount',FormatNumber(t_mount),'#000000');
	                            	tmpPath += '</g>'
	                            //X軸
	                            tmpPath += '<line x1="'+strX+'" y1="'+strY+'" x2="'+(strX+t_width)+'" y2="'+strY+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								tmpPath += '<text x="'+strX+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';
								tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
								//Y軸
	                            tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+obj.data('info').postData[n].length * 40)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
	                            //符號說明
	                            tmpPath += MarkHelp((strX+t_width+40),(objHeight-60),'url(#chart2_color1)','收入(萬元)','black');
	                            tmpPath += MarkHelp((strX+t_width+40),(objHeight-60)+30,'url(#chart2_color3)','數量','black');
	                            }
							}else if(txtreport == 'z_anavccCompare1' || txtreport == 'z_anavccCompare2'){
								//客戶名稱(標題)
								if(txtreport == 'z_anavccCompare1')
									tmpPath += '<text x="30" y="30" fill="#000000" >'+objpostData[0].comp+'</text>';
								else if(txtreport == 'z_anavccCompare2')
									tmpPath += '<text x="30" y="30" fill="#000000" >'+objpostData[0].product+'</text>';
								for (var i = 0; i < objpostData.length; i++) {    
									tmpPath +='<g id="chart2_item'+i+'">';
	                                x = strX - 5;
	 								y = strY + i*40 + 30;
	 								if(objpostData[i].mon =='B')
		                            	tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >起始月份</text>';	
	 								else if(objpostData[i].mon =='E')
		                            	tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >終止月份</text>';	
	                            	//收入
	                            	t_total = (dec(objpostData[i].total)/10000);
	                            	t_mount = dec(objpostData[i].mount);
	                                W_total = Math.abs(round(t_total / (t_maxMoney - t_minMoney) * t_width, 0));
	                                W_mount = Math.abs(round(t_mount / (t_maxMoney - t_minMoney) * t_width, 0));
	                                (t_total>0?x_total = t_X:x_total = (t_X - W_total));
	                                (t_mount>0?x_mount = t_X:x_mount = (t_X - W_mount));
	 								y = strY + i*40 +25;
	 								//數值線產生
	 								tmpPath += ValueLineCreate('chart2_item','chart2_total' + i,x_total,(y-15),W_total,15,'url(#chart2_color1)','chart2_ctotal',FormatNumber(t_total),'#000000');
	 								tmpPath += ValueLineCreate('chart2_item','chart2_mount' + i,x_mount,(y),W_mount,15,'url(#chart2_color3)','chart2_cmount',FormatNumber(t_mount),'#000000');
	                            	tmpPath += '</g>'
	                            }
	                            //X軸
	                            tmpPath += '<line x1="'+strX+'" y1="'+strY+'" x2="'+(strX+t_width)+'" y2="'+strY+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
								tmpPath += '<text x="'+strX+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';
								tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
								//Y軸
	                            tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+obj.data('info').postData[n].length * 40)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
	                            //符號說明
	                            tmpPath += MarkHelp((strX+t_width+40),(objHeight-60),'url(#chart2_color1)','收入(萬元)','black');
	                            tmpPath += MarkHelp((strX+t_width+40),(objHeight-60)+30,'url(#chart2_color3)','數量','black');
							}
							obj.width(objWidth).height(objHeight).html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph" width="100%" height="100%">' + tmpPath + '</svg> ');
	                        //事件
							obj.children('svg').find('.chart2_item').hover(function(e) {
	                        	var n = $(this).parent().attr('id').replace('chart2_item','');
								$('#chart2_nick'+n).attr('fill', 'rgb(255,0,0)');
								$('#chart2_total'+n).attr('fill', 'url(#chart2_color2)');
								$('#chart2_mount'+n).attr('fill', 'url(#chart2_color4)');
								$('rect[fill="url(#chart2_color1)"][id="Mark"]').attr('fill', 'url(#chart2_color2)');
								$('rect[fill="url(#chart2_color3)"][id="Mark"]').attr('fill', 'url(#chart2_color4)');
							}, function(e) {
								var n = $(this).parent().attr('id').replace('chart2_item','');
								$('#chart2_nick'+n).attr('fill', 'rgb(0,0,0)');
								$('#chart2_total'+n).attr('fill', 'url(#chart2_color1)');
								$('#chart2_mount'+n).attr('fill', 'url(#chart2_color3)');
								$('rect[fill="url(#chart2_color2)"][id="Mark"]').attr('fill', 'url(#chart2_color1)');
								$('rect[fill="url(#chart2_color4)"][id="Mark"]').attr('fill', 'url(#chart2_color3)');
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
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div id="svgbet">
			</div>
			<div id="ChartCtrl">
				<input type="button" id="btnXPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnXNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			</div>
			<div id='barChart2'></div>
			<div id="dataSearch" class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>