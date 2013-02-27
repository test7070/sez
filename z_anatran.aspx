<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>

		<script src='//59.125.143.170/jquery/js/qset.js' type="text/javascript"></script>

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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            var isInit = false;
            var t_carkind = null;
            var t_carno = null;
			
			Array.prototype.indexOfField = function (propertyName, value) {
		        for (var i = 0; i < this.length; i++)
		            if (this[i][propertyName] === value)
		                return i;
		        return -1;
		    }
    			
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_anatran');
            });
            function q_gfPost() {
                q_gt('carteam', '', 0, 0, 0, "");
                q_gt('calctype2', '', 0, 0, 0, "calctypes");
                q_gt('carkind', '', 0, 0, 0, "");
                q_gt('acomp', '', 0, 0, 0);
                q_gt('calctype', '', 0, 0, 0);

                $("#btnRun").click(function(e) {
                    var t_val = '';
                    var t_elements = $("#chkXcarkind").children('input:checked');
                    for (var x = 0; x < t_elements.length; x++) {
                        t_val += (t_val.length > 0 ? '@' : '') + t_elements.eq(x).val();
                    }
                    var t_index = $('#q_report').data('info').radioIndex;
                    var t_report = $('#q_report').data('info').reportData[t_index].report;
                    q_func('z_anatran.'+t_report, encodeURI(r_accy) + ';' + encodeURI($('#txtTrandate1').val()) + ';' + encodeURI($('#txtTrandate2').val()) + ';' + encodeURI(t_val) + ';' + encodeURI($.trim($('#txtXcarno').val())));
                });
                $("#btnNext").click(function(e) {
                	$('#chart01').data('info').next($('#chart01'));
                });
                $("#btnPrevious").click(function(e) {
                	$('#chart01').data('info').previous($('#chart01'));
                });
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'z_anatran.chart01':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	var n = -1;
                        	var t_maxInmoney = 0;
                            t_carno = new Array();
                            for (var i in as) {
                            	n = t_carno.indexOfField("carno", as[i].carno);
                            	if(t_maxInmoney<parseFloat('0'+as[i].inmoney))
                            		t_maxInmoney = parseFloat('0'+as[i].inmoney);
                            	t_detail = {
                            		datea : as[i].datea,
                            		inmoney : parseFloat('0'+as[i].inmoney),
                            		outmoney : parseFloat('0'+as[i].outmoney),
                            		tranmiles : parseFloat('0'+as[i].tranmiles),
                            		oilmoney : parseFloat('0'+as[i].oilmoney),
                            		oilmount : parseFloat('0'+as[i].oilmount),
                            		oilmiles : parseFloat('0'+as[i].oilmiles),
                            		tolls : parseFloat('0'+as[i].tolls),
                            		tickets : parseFloat('0'+as[i].tickets),
                            		reserve : parseFloat('0'+as[i].reserve),
                            		profit : parseFloat('0'+as[i].profit)
                            	};
                            	
                            	if( n == -1){
                            		t_carno.push({
	                                    carkindno : as[i].carkindno,
	                                    carkind : as[i].carkind,
	                                    carno : as[i].carno,
	                                    caryear : as[i].caryear,
	                                    detail : [t_detail]
	                                });
                            	}else{
                            		t_carno[n].detail.push(t_detail);
                            	}
                            }
                            $('#chart01').barChart01({
                            	data:t_carno,
                            	maxInmoney : t_maxInmoney
                            });
                            $('#txtCurPage').val(1).change(function(e){
                            	$(this).val(parseInt($(this).val()));
                            	$('#chart01').data('info').page($('#chart01'),$(this).val());
                            });
                            $('#txtTotPage').val(t_carno.length);
                            $(".control").show();
                        }

                        /*$('#pieChart').pieChart({
                         data : [{text:'A',value:200},{text:'B',value:300},{text:'C',value:550},{text:'S',value:800}],
                         x: 250,
                         y: 250,
                         radius: 200
                         });*/
                        break;
                }

            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'carkind':
                        t_carkind = '';
                        var as = _q_appendData("carkind", "", true);
                        if (as[0] != undefined) {
                            for ( i = 0; i < as.length; i++) {
                                t_carkind += (t_carkind.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
                            }
                        }
                        break;
                    default:
                        break;
                }

                if (t_carkind != null && !isInit) {
                    isInit = true;
                    $('#q_report').q_report({
                        fileName : 'z_anatran',
                        options : [{
                            type : '0',
                            name : 'accy',
                            value : q_getId()[4]
                        }, {/*1*/
                            type : '1',
                            name : 'date'
                        }, {/*2*/
                            type : '1',
                            name : 'trandate'
                        }, {/*3*/
                            type : '6',
                            name : 'xcarno'
                        }, {/*4*/
                            type : '8',
                            name : 'xcarkind',
                            value : t_carkind.split(',')
                        }]
                    });
                    q_popAssign();
                    q_langShow();

                    $('#txtDate1').mask('999/99/99');
                    $('#txtDate1').datepicker();
                    $('#txtDate2').mask('999/99/99');
                    $('#txtDate2').datepicker();
                    $('#txtTrandate1').mask('999/99/99');
                    $('#txtTrandate1').datepicker();
                    $('#txtTrandate2').mask('999/99/99');
                    $('#txtTrandate2').datepicker();

                    $('#chkXcarkind').children('input').attr('checked', 'checked');

                    var t_date, t_year, t_month, t_day;
                    t_date = new Date();
                    t_date.setDate(1);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);
                    $('#txtTrandate1').val(t_year + '/' + t_month + '/' + t_day);
                    t_date = new Date();
                    t_date.setDate(35);
                    t_date.setDate(0);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
                    $('#txtTrandate2').val(t_year + '/' + t_month + '/' + t_day);
                }
            }

            function q_boxClose(t_name) {
            }
			function FormatNumber(n) {
			    n += "";
			    var arr = n.split(".");
			    var re = /(\d{1,3})(?=(\d{3})+$)/g;
			    return arr[0].replace(re,"$1,") + (arr.length == 2 ? "."+arr[1] : "");
			}

            ;(function($, undefined) {
            	$.fn.barChart01 = function(value) {
            		$(this).data('info',{
            			curIndex : -1,
            			carData : value.data,
            			maxInmoney : value.maxInmoney,
            			init : function(obj){
            				if(value.length==0){
            					alert('無資料。');
            					return;
            				}
            				obj.data('info').curIndex = 0;	
            				obj.data('info').refresh(obj);
            			},
            			page : function(obj,n){
            				if(n>0 && n<=obj.data('info').carData.length){
            					obj.data('info').curIndex=n-1;
            					obj.data('info').refresh(obj);	
            				}else
            					alert('頁數錯誤。');
            			},
            			next : function(obj){
            				if(obj.data('info').curIndex == obj.data('info').carData.length-1)
            					alert('已到最後頁。');
            				else{
            					obj.data('info').curIndex++;
            					obj.data('info').refresh(obj);
            				}
            			},
            			previous : function(obj){
            				if(obj.data('info').curIndex == 0)
            					alert('已到最前頁。');
            				else{
            					obj.data('info').curIndex--;
            					obj.data('info').refresh(obj);
            				}
            			},
            			refresh : function(obj){
            				obj.html('');
            				obj.width(950).height(500);
            				var t_color1 = ['rgb(210,233,255)','rgb(255,238,221)'];
            				var t_n = 10;//分幾個區塊
            				var t_height = 350, t_width = 600;
            				var tmpPath='<rect x="0" y="0" width="950" height="500" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
            				for(var i=0;i<t_n;i++)
            					tmpPath += '<rect x="100" y="'+(50+(t_height/t_n)*i)+'" width="'+t_width+'" height="'+(t_height/t_n)+'" style="fill:'+t_color1[i%t_color1.length]+';"/>';
            				tmpPath +='<line x1="100" y1="'+(50+t_height)+'" x2="'+(100+t_width)+'" y2="'+(50+t_height)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';//X軸
            				tmpPath +='<line x1="100" y1="50" x2="100" y2="'+(50+t_height)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';//Y軸
            				
            				var t_detail = obj.data('info').carData[obj.data('info').curIndex].detail;
            				var t_maxInmoney = obj.data('info').maxInmoney;
            				var t_n = round((t_width-20)/t_detail.length,0);   			
            				var x,y,bx,by,t_output;
  							var t_cmaxInmoney = FormatNumber(t_maxInmoney);
  							t_cmaxInmoney = ('      '+t_cmaxInmoney).substring(t_cmaxInmoney.length,7+t_cmaxInmoney.length)
  							
  							tmpPath +='<text x="'+(500)+'" y="'+(20)+'" fill="black">【'+obj.data('info').carData[obj.data('info').curIndex].carkind+'】'+obj.data('info').carData[obj.data('info').curIndex].carno+'</text>';
  							tmpPath +='<text x="'+(70)+'" y="'+(20)+'" fill="black">金額</text>';
  							tmpPath +='<text x="'+(50+t_width +50)+'" y="'+(50+t_height+30)+'" fill="black">日期</text>';
  							tmpPath +='<text x="'+(50)+'" y="'+(50)+'" fill="black">'+t_cmaxInmoney+'</text>';
            				
            				//支出的顏色
            				tmpPath += '<defs>'+
							'<linearGradient id="chart01_outColor1" x1="0%" y1="0%" x2="100%" y2="0%">'+
								'<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />'+
								'<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />'+
							'</linearGradient>'+
							'</defs>';
            				tmpPath += '<defs>'+
							'<linearGradient id="chart01_outColor2" x1="0%" y1="0%" x2="100%" y2="0%">'+
								'<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />'+
								'<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />'+
							'</linearGradient>'+
							'</defs>';
							
            				//支出
            				for(var i=0;i<t_detail.length;i++){
            					t_output = t_detail[i].outmoney + t_detail[i].oilmoney + t_detail[i].tolls + t_detail[i].tickets + t_detail[i].reserve ;
            					x = 100 + 10+t_n*i -(i==0?9:10);
            					if(t_output<0)
            						y = 50 + t_height;
            					else if(t_output>=t_maxInmoney)    
            						y = 50;
            					else   	   				
            						y = 50 + t_height - round(t_output/t_maxInmoney*t_height,0);
								
								tmpPath+='<rect class="chart01_out" x="'+x+'" y="'+y+'" width="'+t_n+'" height="'+(50 + t_height-y)+'" fill="url(#chart01_outColor1)"/>';
            				}
            				//收入
            				for(var i=0;i<t_detail.length;i++){//連接線
            					x = 100 + 10+t_n*i;
            					y = (t_maxInmoney>0?50 + t_height - round(t_detail[i].inmoney/t_maxInmoney*t_height,0):50 + t_height);
            					if(i>0)
            						tmpPath +='<line x1="'+bx+'" y1="'+by+'" x2="'+x+'" y2="'+y+'" style="stroke:rgb(0,0,0);stroke-width:1"/>';
            					bx = x;
            					by = y;
            				}
            				for(var i=0;i<t_detail.length;i++){
            					x = 100 + 10+t_n*i;
            					y = (t_maxInmoney>0?50 + t_height - round(t_detail[i].inmoney/t_maxInmoney*t_height,0):50 + t_height);
            					tmpPath +='<circle class="chart01_in" class="" cx="'+x+'" cy="'+y+'" r="5" stroke="black" stroke-width="2" fill="red"/>';        					
            					tmpPath +='<text x="'+(x-10)+'" y="'+(50+t_height+30)+'" fill="black">'+t_detail[i].datea.substring(7,9)+'</text>';
            				}
            				//符號說明
            				tmpPath+='<rect x="800" y="50" width="20" height="20" fill="url(#chart01_outColor1)"/>';
            				tmpPath +='<text x="830" y="65" fill="black">支出</text>';
            				
            				tmpPath +='<line x1="800" y1="85" x2="820" y2="85" style="stroke:rgb(0,0,0);stroke-width:1"/>';
            				tmpPath +='<circle class="" cx="810" cy="85" r="5" stroke="black" stroke-width="2" fill="red"/>';        					
            				tmpPath +='<text x="830" y="90" fill="black">收入</text>';
            				          				
            				obj.append('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
            				//事件
            				obj.children('svg').find('.chart01_in').hover(
            					function(e){$(this).attr('fill','rgb(255,151,151)');}
            					,function(e){$(this).attr('fill','red');});
            				obj.children('svg').find('.chart01_out').hover(
            					function(e){$(this).attr('fill','url(#chart01_outColor2)');}
            					,function(e){$(this).attr('fill','url(#chart01_outColor1)');});
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
                                tmpPath += '<rect class="blockLogo" id="blockLogo_' + i + '" width="10" height="10" x="' + pointLogo[0] + '" y="' + pointLogo[1] + '" fill=' + fillColor + ' stroke=' + strokeColor + '/>';
                                tmpPath += '<text class="blockText" id="blockText_' + i + '" x="' + pointText[0] + '" y="' + pointText[1] + '" fill="#000000">' + obj.data('info').value.data[i].text + '</text>';
                                tmpPath += '<path class="block" id="block_' + i + '" d="M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + ' 0 1 ' + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
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
                                $('#block_' + $(this).data('info').index).attr('fill', obj.data('info').focusfillColor);
                                $('#blockLogo_' + $(this).data('info').index).attr('fill', obj.data('info').focusfillColor);
                            }, function(e) {
                                var obj = $(this).parent().parent();
                                $('#block_' + $(this).data('info').index).attr('fill', obj.data('info').fillColor[$(this).data('info').index]);
                                $('#blockLogo_' + $(this).data('info').index).attr('fill', obj.data('info').fillColor[$(this).data('info').index]);
                            }).click(function(e) {
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
            .pieChart .graph {
                position: relative;              
            }
            .control{
            	display:none;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container" style="width:2000px;">
				<div id="q_report"> </div>
			</div>
			<div style="display:inline-block;width:2000px;">
				<input type="button" id="btnRun" style="float:left; width:80px;font-size: medium;" value="執行"/>
				<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			</div>
			<div id="chart">
				<div id='chart01'> </div>
				<div id='pieChart'> </div>
			</div>
		</div>
		<div class="prt" style="display:none;">
			<!--#include file="../inc/print_ctrl.inc"-->
		</div>
	</body>
</html>