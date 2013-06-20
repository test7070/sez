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
            if(location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;100";
            }
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_vcc');
                $('#btnSvg').hide();
                $('#q_report').click(function(){
					for(var i =0 ;i<$('#q_report').data().info.reportData.length;i++){
						var rePortData = $('#q_report').data().info.reportData[i];
						if($('.radio.select').next().text()==rePortData.reportName){
							txtreport=rePortData.report;
							if(txtreport=='z_vcc5'){
								txtreport='z_vcc1';
								$('#btnSvg').val(rePortData.reportName+'長條圖顯示');
								$('#btnSvg').show();
							}else{
								$('#btnSvg').hide();
								$('#dataSearch').show();
							}
						}
					}
                });
                $('#btnSvg').click(function(){
                	$('#dataSearch').hide();
                	var t_bdate='#non',t_edate='#non';
					if(!emp($('#txtDate1').val()))
						t_bdate=$('#txtDate1').val();
					if(!emp($('#txtDate2').val()))
						t_edate=$('#txtDate2').val();
					txtreport='z_vcc1';
					q_func('qtxt.query','z_anavcc.txt,'+txtreport+','+encodeURI(r_accy) + ';' + encodeURI(t_bdate) + ';' + encodeURI(t_edate));
                });
            });
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
							for (i = 0; i < as.length; i++) {      
								bar.push({
									custno:as[i].custno,
									comp:as[i].comp,
									datea:as[i].datea,
									mount:as[i].mount,
									total:as[i].total
								});
							}
							$('#barChart2').barChart2({
								data : bar
							});
							$('#txtCurPage').val(1).change(function(e) {
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
                        custData : value.data,
                        maxPage : 1,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            obj.data('info').curIndex = 0;
                            obj.data('info').refresh(obj);
                        },
                        page : function(obj, n) {
                            if (n > 0 && n <= obj.data('info').maxPage) {
                                obj.data('info').curIndex = n - 1;
                                obj.data('info').refresh(obj);
                            } else
                                alert('頁數錯誤。');
                        },
                        next : function(obj) {
                            if (obj.data('info').curIndex == obj.data('info').maxPage - 1)
                                alert('已到最後頁。');
                            else {
                                obj.data('info').curIndex++;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj);
                            }
                        },
                        previous : function(obj) {
                            if (obj.data('info').curIndex == 0)
                                alert('已到最前頁。');
                            else {
                                obj.data('info').curIndex--;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj);
                            }
                        },
                        refresh : function(obj) {
                            var objWidth = 950;
                            var objHeight = obj.data('info').custData.length * 40 + 100;
                            //背景
                            var tmpPath = '<rect x="0" y="0" width="' + objWidth + '" height="' + objHeight + '" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
                            //圖表背景顏色
                            var bkColor1 = ['rgb(210,233,255)', 'rgb(255,238,221)'];
                            //圖表分幾個區塊
                            var bkN = 10;
                            var strX = 100, strY = 50;                      
                            var t_width = 700;
                            var t_height = obj.data('info').custData.length * 40;

                            for (var i = 0; i < bkN; i++) {
                                x = Math.round(t_width / bkN, 0) * i;
                                y = 0;
                                tmpPath += '<rect x="' + (strX + x) + '" y="' + (strY + y) + '" width="' + Math.round(t_width / bkN, 0) + '" height="' + (t_height) + '" style="fill:' + bkColor1[i % bkColor1.length] + ';"/>';
                            }
							
							var t_maxMoney = 99999;
                            var t_minMoney = 0;
                            var t_X = strX + round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_width, 0);                                
							
							var t_detail = obj.data('info').custData;
							tmpPath += '<defs>' + '<linearGradient id="chart2_color3" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart2_color2" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';					
                            tmpPath += '<defs>' + '<linearGradient id="chart2_color4" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(206,255,206);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,255,147);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart2_color1" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(255,185,220);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,96,175);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
							for (var i = 0; i < t_detail.length; i++) {    
								tmpPath +='<g id="chart2_item'+i+'">';
								//客戶名稱      
                                x = strX - 5;
 								y = strY + i*40 + 24;
                                tmpPath += '<text class="chart2_item" id="chart2_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+t_detail[i].comp+'</text>';	
                            	//收入
                            	t_output = dec(t_detail[i].total);
                                W = Math.abs(round(t_output / (t_maxMoney - t_minMoney) * t_width, 0));
                                if(t_output>0){
                                	x = t_X;
                                }else{
                                	x = t_X - W;
                                } 
 								y = strY + i*40 + 5;
                                tmpPath += '<rect class="chart2_item" id="chart2_inmoney' + i + '" x="' + x + '" y="' + y + '" width="' + W + '" height="' + 15 + '" fill="url(#chart2_color1)"/>';
                            	tmpPath += '<text class="chart2_item" id="chart2_cinmoney'+i+'" x="'+(x+W+5)+'" y="'+(y+15)+'" fill="#000000" >'+FormatNumber(t_output)+'</text>';	
                            }
                            //X軸
                            tmpPath += '<line x1="'+strX+'" y1="'+strY+'" x2="'+(strX+t_width)+'" y2="'+strY+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
							tmpPath += '<text x="'+strX+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';
							tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
							//Y軸
                            tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+obj.data('info').custData.length * 40)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            
                            //符號說明
                            tmpPath += '<rect x="'+(strX+t_width+50)+'" y="5" width="20" height="20" fill="url(#chart2_color1)"/>';
                            tmpPath += '<text x="'+(strX+t_width+70)+'" y="20" fill="black">收入</text>';
							
                            obj.width(objWidth).height(objHeight).html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                        	
                        	//事件
                        	obj.children('svg').find('.chart2_item').hover(function(e) {
                        		var n = $(this).parent().attr('id').replace('chart2_item','');
                        		
                                $('#chart2_nick'+n).attr('fill', 'rgb(255,0,0)');
                                $('#chart2_inmoney'+n).attr('fill', 'url(#chart2_color2)');
                                $('#chart2_cinmoney'+n).attr('fill', 'rgb(255,0,0)');
                                $('#chart2_profit'+n).attr('fill', 'url(#chart2_color4)');
                                $('#chart2_cprofit'+n).attr('fill', 'rgb(255,0,0)');
                               
                            }, function(e) {
                                var n = $(this).parent().attr('id').replace('chart2_item','');
                        		
                                $('#chart2_nick'+n).attr('fill', 'rgb(0,0,0)');
                                $('#chart2_inmoney'+n).attr('fill', 'url(#chart2_color1)');
                                $('#chart2_cinmoney'+n).attr('fill', 'rgb(0,0,0)');
                                $('#chart2_profit'+n).attr('fill', 'url(#chart2_color3)');
                                $('#chart2_cprofit'+n).attr('fill', 'rgb(0,0,0)');
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
            })($);
            function FormatNumber(n) {
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
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
				<input id="btnSvg" type="button" />
			</div>
			<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			<div id='barChart2'></div>
			<div id="dataSearch" class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>