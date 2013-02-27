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
			var txtreport='';
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_anadc');
				$('#btnSvg').val('圓餅圖');
				$('#pieChart').hide();
				$('#btnSvg').hide();
				
				$('#q_report').click(function(e) {
					$('#pieChart').hide();
					$('#dataSearch').show();
					if(txtreport!='')
						$('#btnSvg').show();
					for(var i =0 ;i<$('#q_report').data().info.reportData.length;i++){
						if($(".select")[0].nextElementSibling.innerText==$('#q_report').data().info.reportData[i].reportName){
							$('#btnSvg').val($('#q_report').data().info.reportData[i].reportName+'圓餅圖顯示');
							//下面註解取得z_xxxxx
							txtreport=$('#q_report').data().info.reportData[i].report;
						}
					}
				});
				$('#btnSvg').click(function(e) {
					$('#pieChart').show();
					$('#dataSearch').hide();
					q_func('qtxt.query','z_anadc.txt,'+txtreport+','+encodeURI(r_accy) + ';' + encodeURI($('#txtDate1').val()) + ';' + encodeURI($('#txtDate2').val()) + ';' + encodeURI($('#txtXmon').val()) + ';' + encodeURI($('#txtCust1a').val())+ ';' + encodeURI($('#txtCust2a').val())+ ';' + encodeURI($('#txtPart1a').val())+ ';' + encodeURI($('#txtPart1b').val())+ ';' + encodeURI($('#txtSss1a').val())+ ';' + encodeURI($('#txtSss1b').val()));
				});
				
				$('#pieChart').pieChart({
					data : [{text:'威致鋼鐵',value:2764670},{text:'誼林交通',value:919544},{text:'華新麗華',value:749478},{text:'中鋼德山',value:314566}],
					x: 250,
					y: 250,
					radius: 200
				}); 
			});
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_anadc',
					options : [ {
                            type : '0',
                            name : 'accy',
                            value : q_getId()[4]
                        },{/*1*/
	                        type : '1',
	                        name : 'date'
						},{
	                        type : '6',
	                        name : 'xmon'
						},{
	                        type : '2',
	                        name : 'cust',
	                        dbf : 'cust',
	                        index : 'noa,comp',
	                        src : 'cust_b.aspx'
                        },{
	                        type : '2',
	                        name : 'part',
	                        dbf : 'part',
	                        index : 'noa,part',
	                        src : 'part_b.aspx'
                        },{
	                        type : '2',
	                        name : 'sss',
	                        dbf : 'sss',
	                        index : 'noa,namea',
	                        src : 'sss_b.aspx'
                        }]
				});
				q_popAssign();
				$('#txtDate1').mask('999/99/99');
	             $('#txtDate1').datepicker();
	             $('#txtDate2').mask('999/99/99');
	             $('#txtDate2').datepicker();  
	             $('#txtXmon').mask('999/99');
                
                
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

			}

			function q_boxClose(s2) {
			}
			
			function q_gtPost(s2) {
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query':
                        var as = _q_appendData("tmp0", "", true, true);
                         break;
                        
                        //if (as[0] != undefined) {
                        //}
                        //break;
                }

            }
            
			;(function($, undefined) {
                $.fn.barChart = function(value) {
                    $(this).addClass('barChart');
                    $(this).width(value.width);
                    $(this).height(value.height);
                    $(this).offset({
                        top : $(this).offset().top,
                        left : $(this).offset().left
                    });
                    $(this).data('info', {
                        width : value.width,
                        height : value.height,
                        xAxis : value.xAxis,
                        yAxis : value.yAxis,
                        data : value.data,
                        init : function(obj) {
                            var tmp, tmpStr, tmpGraph;
                            /*left*/
                            tmpStr = '<div class="left"><';
                            tmpStr += '/div>';
                            obj.append(tmpStr);
                            /*bottom*/
                            tmpStr = '<div class="bottom"><';
                            tmpStr += '/div>';
                            obj.append(tmpStr);
                            /*graph*/
                            tmpStr = '<div class="graph"><';
                            tmpStr += '/div>';
                            obj.append(tmpStr);
                            tmpGraph = obj.find('.graph');
                            /*left text*/
                            tmp = obj.find('.left');
                            for ( i = obj.data('info').yAxis.length - 1; i >= 0; i--) {
                                tmpStr = '<div class="text">' + obj.data('info').yAxis[i] + '<';
                                tmpStr += '/div>';
                                tmp.append(tmpStr);
                            }
                            tmp.find('div').height(Math.floor(tmpGraph.height() / obj.data('info').yAxis.length));
                            /*bottom text*/
                            tmp = obj.find('.bottom');
                            for ( i = 0; i < obj.data('info').xAxis.length; i++) {
                                tmpStr = '<div class="text">' + obj.data('info').xAxis[i] + '<';
                                tmpStr += '/div>';
                                tmp.append(tmpStr);
                            }
                            tmp.find('div').width(Math.floor(tmpGraph.width() / obj.data('info').xAxis.length));
                            /*graph background*/
                            for ( i = 0; i < obj.data('info').yAxis.length; i++) {
                                tmpStr = '<div class="bg"><';
                                tmpStr = tmpStr + '/div>';
                                tmpGraph.append(tmpStr);
                                tmp = tmpGraph.find('.bg').eq(i);
                                tmp.addClass('bgColor' + ((i % 2) + 1).toString());
                                tmp.height(Math.floor(tmpGraph.height() / obj.data('info').yAxis.length));
                                tmp.offset({
                                    top : tmpGraph.offset().top + tmp.height() * i,
                                    left : tmpGraph.offset().left
                                });
                            }
                            /*graph bar*/
                            for ( i = 0; i < obj.data('info').xAxis.length && i < obj.data('info').data.length; i++) {
                                tmpStr = '<div class="bar"><span class="nonselect"><b><';
                                tmpStr += '/b><';
                                tmpStr += '/span><';
                                tmpStr += '/div>';
                                tmpGraph.append(tmpStr);
                                tmp = tmpGraph.find('.bar').eq(i);
                                tmp.width(Math.floor(tmpGraph.width() / obj.data('info').xAxis.length));
                                tmp.height(tmpGraph.height());
                                tmp.offset({
                                    top : tmpGraph.offset().top,
                                    left : tmpGraph.offset().left + tmp.width() * i
                                });
                                tmp.find('span').height(Math.floor(tmpGraph.height() * obj.data('info').data[i].rate));
                                tmp.find('span').offset({
                                    top : tmpGraph.offset().top + tmpGraph.height() - tmp.find('span').height(),
                                    left : tmp.offset().left + Math.floor((tmp.width() - tmp.find('span').width()) / 2)
                                });
                                tmp.find('b').text(obj.data('info').data[i].text);
                            }
                            obj.find('.graph').eq(0).find('.bar > span').hover(function(e) {
                                $(this).removeClass('nonselect').addClass('select');
                            }, function(e) {
                                $(this).removeClass('select').addClass('nonselect');
                            });
                        },
                        refresh : function(obj) {

                        }
                    });
                    $(this).data('info').init($(this));
                }
                $.fn.pieChart = function(value) {
                    $(this).data('info', {
                        value : value,
                        fillColor : ["#E76E6D", "#E7AB6D", "#E6E76D", "#A9E76D", "6DA9E7", "#AB6DE7", "#E76DE6"],
                        strokeColor : ["#000000"],
                        focusfillColor : "#FFEEFE",
                        focusIndex : -1,
                        init : function(obj) {
                            obj.addClass('pieChart');
                            var tmp = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                tmp += obj.data('info').value.data[i].value;
                            }
                            var tmpDegree = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                obj.data('info').value.data[i].rate = obj.data('info').value.data[i].value / tmp;
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
                                var pointLogo = [x + radius + 20, i * 20 + 30];
                                var pointText = [x + radius + 35, i * 20 + 40];
                                tmpPath += '<rect class="blockLogo" id="blockLogo_'+i+'" width="10" height="10" x="' + pointLogo[0] + '" y="' + pointLogo[1] + '" fill=' + fillColor + ' stroke=' + strokeColor + '/>';
                                tmpPath += '<text class="blockText" id="blockText_'+i+'" x="' + pointText[0] + '" y="' + pointText[1] + '" fill="#000000">' + obj.data('info').value.data[i].text + '</text>';
                                tmpPath += '<path class="block" id="block_'+i+'" d="M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + ' 0 1 ' + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
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
                            /*obj.children('svg').find('.block,.blockLogo,.blockText').hover(function(e) {
                                $(this).attr('fill','white');
                                var obj = $(this).parent().parent();
                                obj.data('info').focusIndex = $(this).data('info').index;
                                obj.data('info').refresh(obj);
                            }, function(e) {
                                $(this).attr('fill',obj.data('info').fillColor[$(this).data('info').index]);
                                obj.data('info').focusIndex = -1;
                                obj.data('info').refresh(obj);
                            });*/
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
                            	alert(obj.data('info').value.data[$(this).data('info').index].text);
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
            })($);
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
			<div id='pieChart'> </div>
			<div id='dataSearch' class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

