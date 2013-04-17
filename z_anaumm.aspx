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
			var txtreport='';
			aPop = new Array(['txtXpart', '', 'part', 'part,noa', 'txtXpart', "part_b.aspx"]);
			
            if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_umm');
                
                //圖型設定
                $('#btnSvg').val('圖形顯示');
                $('#btnSvg').hide();
                $('#barChart').hide();
                $(".control").hide();
                
                $('#q_report').click(function(e) {
					$('#btnSvg').hide();
					$('#barChart').hide();
					$('#dataSearch').show();
					$(".control").hide();
					
					for(var i =0 ;i<$('#q_report').data().info.reportData.length;i++){
						if($(".select")[0].nextSibling.innerText==$('#q_report').data().info.reportData[i].reportName){
							//下面註解取得q_lang的z_xxxxx
							txtreport=$('#q_report').data().info.reportData[i].report;
							if(txtreport=='z_umm4')
								$('#btnSvg').val($('#q_report').data().info.reportData[i].reportName+'長條圖顯示');
						}
					}
					if(txtreport=='z_umm4')
						$('#btnSvg').show();
				});
				
				$('#btnSvg').click(function(e) {
					$('#dataSearch').hide();
					
					//帶入參數
					var xdate2='#non';
					if(!emp($('#txtXdate2').val()))
						xdate2=$('#txtXdate2').val();
					q_func('qtxt.query','z_umm.txt,'+txtreport+','+encodeURI(r_accy) + ';' + encodeURI($('#txtXdate1').val()) + ';' + encodeURI(xdate2));
					$('#Loading').Loading();
				});
				$("#btnNext").click(function(e) {
                    $('#barChart').data('info').next($('#barChart'));
                });
                $("#btnPrevious").click(function(e) {
                    $('#barChart').data('info').previous($('#barChart'));
                });
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_umm',
                        options : [{
                        type : '6',
                        name : 'xcno'
                    },{
                        type : '6',
                        name : 'xpart'
                    }, {
                        type : '1',
                        name : 'date'
                    }, {
                        type : '2',
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    },{
                        type : '1',
                        name : 'xdate'
                    },{
						type : '0',
						name : 'accy',
						value : r_accy+"_"+r_cno
					},{
						type : '0',
						name : 'xaccy',
						value : r_accy
					}, {
                        type : '2',
                        name : 'scno',
                        dbf : 'acomp',
                        index : 'noa,acomp',
                        src : 'acomp_b.aspx'
                    },{
                        type : '6',
                        name : 'xmon'
                    }]
                    });
                q_popAssign();
                 $('#txtDate1').mask('999/99/99');
	             $('#txtDate1').datepicker();
	             $('#txtDate2').mask('999/99/99');
	             $('#txtDate2').datepicker(); 
	             $('#txtXdate1').mask('99/99');
	             $('#txtXdate2').mask('99/99'); 
                
                
                 var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate1').val(t_year+'/'+t_month+'/'+t_day);
	                $('#txtXmon').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
	                var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXdate1').val(t_month+'/'+t_day);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXdate2').val(t_month+'/'+t_day);
	                }
            function q_boxClose(s2) {
            }
            function q_gtPost(s2) {
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query':
                    var bar=new Array();
                    //長條圖(橫)
                     if( txtreport=='z_umm4'){
                     	if (as[0] == undefined) {
                           	$('#Loading').hide();
                           	alert('沒有資料!!');
                        }else{
                        	var n = -1;
							var x_maxmoney=0,x_minmoney=0;
	                        for (i = 0; i < as.length; i++) {
	                        	
	                        }
                        }
						$('#barChart').barChart({
							data : bar,
							maxMoney : x_maxmoney,
                            minMoney : x_minmoney
						});
						$('#txtCurPage').val(1).change(function(e) {
		                    $(this).val(parseInt($(this).val()));
	                       	$('#barChart').data('info').page($('#barChart'), $(this).val());
	                    });
	                    $('#txtTotPage').val(bar.length);
	                    $('#Loading').hide();
	                    $('#barChart').show();
						$(".control").show();
                    }
                    break;
                }
            }
            
            ;(function($, undefined) {
				$.fn.Loading = function() {
                    $(this).data('info', {
                        init : function(obj) {
                            obj.html('').width(250).height(100).show();
                            var tmpPath = '<defs>' + '<filter id="f1" x="0" y="0">' + '<feGaussianBlur in="SourceGraphic" stdDeviation="5" />' + '</filter>' + '<filter id="f2" x="0" y="0">' + '<feGaussianBlur in="SourceGraphic" stdDeviation="5" />' + '</filter>' + '</defs>' + '<rect width="200" height="10" fill="yellow" filter="url(#f1)"/>' + '<rect x="0" y="0" width="20" height="10" fill="RGB(223,116,1)" stroke="yellow" stroke-width="2" filter="url(#f2)">' + '<animate attributeName="x" attributeType="XML" begin="0s" dur="6s" fill="freeze" from="0" to="200" repeatCount="indefinite"/>' + '</rect>';
                            tmpPath += '<text x="40" y="35" fill="black">資料讀取中...</text>';
                            obj.append('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                        }
                    });
                    $(this).data('info').init($(this));
                }
                $.fn.barChart = function(value) {
                    $(this).data('info', {
                        curIndex : -1,
                        custData : value.data,
                        maxMoney : value.maxMoney,
                        minMoney : value.minMoney,
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
							
							var t_maxMoney = obj.data('info').maxMoney;
                            var t_minMoney = obj.data('info').minMoney;
                            var t_X = strX + round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_width, 0);                                
							
							var t_detail = obj.data('info').custData;
							/*t_detail.sort(function(a,b){
								return b.inmoney-a.inmoney;
							});*/
							tmpPath += '<defs>' + '<linearGradient id="chart_color3" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart_color2" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';					
                            tmpPath += '<defs>' + '<linearGradient id="chart_color4" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(206,255,206);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,255,147);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart_color1" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(255,185,220);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,96,175);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
							for (var i = 0; i < t_detail.length; i++) {    
								tmpPath +='<g id="chart_item'+i+'">';
								//客戶名稱      
                                x = strX - 5;
 								y = strY + i*40 + 24;
                                tmpPath += '<text class="chart_item" id="chart_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+t_detail[i].comp+'</text>';	
                            	//收入
                            	t_output = dec(t_detail[i].total);
                                W = Math.abs(round(t_output / (t_maxMoney - t_minMoney) * t_width, 0));
                                if(t_output>0){
                                	x = t_X;
                                }else{
                                	x = t_X - W;
                                } 
 								y = strY + i*40 + 5;
                                tmpPath += '<rect class="chart_item" id="chart_inmoney' + i + '" x="' + x + '" y="' + y + '" width="' + W + '" height="' + 15 + '" fill="url(#chart_color1)"/>';
                            	tmpPath += '<text class="chart_item" id="chart_cinmoney'+i+'" x="'+(x+W+5)+'" y="'+(y+15)+'" fill="#000000" >'+FormatNumber(t_output)+'</text>';	
                            	//毛利
                            	/*t_output = t_detail[i].profit;
                                W = Math.abs(round(t_output / (t_maxMoney - t_minMoney) * t_width, 0));
                                if(t_output>0){
                                	x = t_X;
                                }else{
                                	x = t_X - W;
                                }                          
 								y = strY + i*40 + 20;
                                tmpPath += '<rect class="chart_item" id="chart_profit' + i + '" x="' + x + '" y="' + y + '" width="' + W + '" height="' + 15 + '" fill="url(#chart_color3)"/>';
                           		tmpPath += '<text class="chart_item" id="chart_cprofit'+i+'" x="'+(x+W + 5)+'" y="'+(y+15)+'" fill="#000000" >'+FormatNumber(t_output)+'</text>';	
                            	
                            	tmpPath +='</g>';*/
                            }
                            //X軸
                            tmpPath += '<line x1="'+strX+'" y1="'+strY+'" x2="'+(strX+t_width)+'" y2="'+strY+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
							//tmpPath += '<text text-anchor="end"  x="'+t_X+'" y="'+(strY-5)+'" fill="#000000" >0</text>';
							tmpPath += '<text x="'+strX+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';
							tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
							//Y軸
                            tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+obj.data('info').custData.length * 40)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            
                            //符號說明
                            tmpPath += '<rect x="'+(strX+t_width+50)+'" y="5" width="20" height="20" fill="url(#chart_color1)"/>';
                            tmpPath += '<text x="'+(strX+t_width+70)+'" y="20" fill="black">收入</text>';
							/*tmpPath += '<rect x="'+(strX+t_width+50)+'" y="30" width="20" height="20" fill="url(#chart_color3)"/>';
                            tmpPath += '<text x="'+(strX+t_width+70)+'" y="45" fill="black">毛利</text>';*/
							
                            obj.width(objWidth).height(objHeight).html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                        	
                        	//事件
                        	obj.children('svg').find('.chart_item').hover(function(e) {
                        		var n = $(this).parent().attr('id').replace('chart_item','');
                        		
                                $('#chart_nick'+n).attr('fill', 'rgb(255,0,0)');
                                $('#chart_inmoney'+n).attr('fill', 'url(#chart_color2)');
                                $('#chart_cinmoney'+n).attr('fill', 'rgb(255,0,0)');
                                $('#chart_profit'+n).attr('fill', 'url(#chart_color4)');
                                $('#chart_cprofit'+n).attr('fill', 'rgb(255,0,0)');
                               
                            }, function(e) {
                                var n = $(this).parent().attr('id').replace('chart_item','');
                        		
                                $('#chart_nick'+n).attr('fill', 'rgb(0,0,0)');
                                $('#chart_inmoney'+n).attr('fill', 'url(#chart_color1)');
                                $('#chart_cinmoney'+n).attr('fill', 'rgb(0,0,0)');
                                $('#chart_profit'+n).attr('fill', 'url(#chart_color3)');
                                $('#chart_cprofit'+n).attr('fill', 'rgb(0,0,0)');
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
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div id="svgbet">
				<input id="btnSvg" type="button" />
			</div>
			<div id='Loading'> </div>
			<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
			<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
			<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
			<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
			<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			<div id='barChart'></div>
			<div id='dataSearch' class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          