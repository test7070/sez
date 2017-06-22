<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>a</title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript">
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
		<style type="text/css">
            .barChart .left {
                position: absolute;
                top: 0;
                left: 0;
                height: 90%;
                width: 10%;
                background-color: #F6FAE4;
                border-right: 1px solid #000000;
                z-index: 3;
            }
            .barChart .left .text {
                display: block;
                float: left;
                width: 100%;
                text-align: right;
            }
            .barChart .bottom {
                position: absolute;
                top: 90%;
                left: 10%;
                height: 10%;
                width: 90%;
                background-color: #F6FAE4;
                border-top: 1px solid #000000;
                z-index: 3;
            }
            .barChart .bottom .text {
                display: block;
                float: left;
                height: 100%;
                text-align: center;
            }
            .barChart .graph {
                position: absolute;
                top: 0;
                left: 10%;
                height: 90%;
                width: 90%;
            }
            .barChart .graph .bg {
                position: relative;
                width: 100%;
                z-index: 1;
            }
            .barChart .graph .bg.bgColor1 {
                background-color: #CCD9F2;
            }
            .barChart .graph .bg.bgColor2 {
                background-color: #EEEEEE;
            }
            .barChart .graph .bar {
                position: relative;
                display: block;
                z-index: 2;
            }
            .barChart .graph .bar span {
                width: 80%;
                display: block;
                margin-left: 5px;
                border-top-left-radius: 3px;
                border-top-right-radius: 3px;
            }
            .barChart .graph .bar span.select {
                background-color: #FAD42E;
            }
            .barChart .graph .bar span.nonselect {
                background-color: #FF8F19;
            }
            .barChart .graph .bar span b {
                display: block;
                text-align: center;
            }

            .pieChart .graph {
                position: relative;
            }
		</style>
	</head>
	<body style="background-color: gray;">
		<div id='pieChart'> </div>
		<div id='barChart'> </div>
		
		<script type="text/javascript">
			$(document).ready(function() {  
				$('#barChart').barChart({
					width: 800,
					height: 500,
					xAxis: ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],
					yAxis: ['100','200','300','400','500'],
					data: [{rate:0.5,value:500},{rate:0.7},{rate:0.21},{rate:0.1},{rate:0.55}]
				});
				
				$('#pieChart').pieChart({
					data : [{text:'A',value:200},{text:'B',value:300},{text:'C',value:550},{text:'S',value:800}],
					x: 250,
					y: 250,
					radius: 200
				});
				
			});
		</script>
	</body>
</html>