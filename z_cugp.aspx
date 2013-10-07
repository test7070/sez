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
           if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			var txtreport='';
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_cugp');
                
                $('#q_report').click(function(e) {

					var t_index = $('#q_report').data('info').radioIndex;
                    txtreport = $('#q_report').data('info').reportData[t_index].report;
					
					if(txtreport=='z_cugp_svg1'){
						$('#dataSearch').hide();
						$('#svg_search').show();
					}else{
						$('#dataSearch').show();
						$('#svg_search').hide();
					}
				});
				
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_cugp',
                        options : [{
						type : '0',
						name : 'accy',
                        value : r_accy
                    }, {
						type : '0',
						name : 'nosix',
                        value : q_getPara('sys.saturday')
                    },{
						type : '2',
						name : 'station',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
                    },{
						type : '2',
						name : 'process',
						dbf : 'process',
						index : 'noa,process',
						src : 'process_b.aspx'
                    },{
                        type : '6',
                        name : 'xenddate' //[8]
                    }, {
						type : '5', //select
						name : 'xorder',
						value : ('1@製程,2@開工日').split(',')
					}]
				});
                q_popAssign();
				$('#txtXenddate').datepicker();
				$('#txtXenddate').mask('999/99/99');
				//$('#txtXenddate').val(q_date());
				
				//SVG
				$("#btnRun").click(function(e) {
                	var t_bstation = emp($('#txtStation1a').val())?'#non':$('#txtStation1a').val();
                	var t_estation = emp($('#txtStation2a').val())?'#non':$('#txtStation2a').val();
                	var t_bprocess = emp($('#txtProcess1a').val())?'#non':$('#txtProcess1a').val();
                	var t_eprocess = emp($('#txtProcess2a').val())?'#non':$('#txtProcess2a').val();
                    var t_index = $('#q_report').data('info').radioIndex;
                    var t_report = $('#q_report').data('info').reportData[t_index].report;

                    $(".z_cugp.chart").html('').height(0);
                    $("#txtCurPage").val(0);
                    $("#txtTotPage").val(0);
                    switch(txtreport) {
                        case 'z_cugp_svg1':
                            $('#Loading').Loading();
                            Lock();
                            q_func('qtxt.query', 'z_cugp_svg.txt,' + txtreport + ',' + encodeURI(r_accy) + ';' + t_bstation+ ';' + t_estation+ ';' + t_bprocess+ ';' + t_eprocess );
                            break;
                        default:
                            alert('錯誤：未定義報表');
                    }

                });
                $("#btnNext").click(function(e) {
                    $('#' + $(this).data('chart')).data('info').next($('#' + $(this).data('chart')));
                });
                $("#btnPrevious").click(function(e) {
                    $('#' + $(this).data('chart')).data('info').previous($('#' + $(this).data('chart')));
                });
				
			}

            function q_boxClose(s2) {
            }
            
            function q_gtPost(s2) {
            }
            
            function q_funcPost(t_func, result) {
            	
                switch(t_func) {
                    case 'qtxt.query':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] == undefined){
                        	$('#Loading').hide();
                            Unlock();
                        }
                        else {
                            var n = -1;
                            t_data = new Array();
                            for (var i in as) {
                                if (as[i].stationno != undefined) {
                                	n = -1;
                                	m = -1;
                                	for (var j = 0; j < t_data.length; j++)
					                    if (t_data[j].stationno == as[i].stationno){
					                    	n = j;
					                    	for (var k = 0; k < t_data[j].process.length; k++)
							                    if (t_data[j].process[k].processno == as[i].processno)
							                        m = k;
					                    }
					                        
                                	if(n==-1){
                                		t_data.push({
                                			stationno : as[i].stationno,
                                			station : as[i].station,
                                			process : new Array({
                                				processno : as[i].processno,
                                				process : as[i].process,
                                				productno : as[i].productno,
	                                			product : as[i].product,
	                                			mount : as[i].mount,
	                                			hours : as[i].hours,
	                                			days : as[i].days,
	                                			cuadate : as[i].cuadate,
	                                			uindate : as[i].uindate,
	                                			workno : as[i].workno,
	                                			memo : as[i].memo
                                			})
                                		});
                                	}else if(m==-1){
                                		t_data[n].inbs.push({
                                			inbnoq : as[i].inbnoq,
	                                			product : as[i].product,
	                                			bweight : parseFloat(as[i].bweight.length == 0 ? '0' : as[i].bweight),
	                                			weight : parseFloat(as[i].weight.length == 0 ? '0' : as[i].weight),
	                                			ordeno : as[i].ordeno,
	                                			ordenoq : as[i].ordenoq,
	                                			ucctno : as[i].ucctno,
	                                			detail : new Array({
	                                				ucctnoq : as[i].uccnoq,
	                                				processno : as[i].processno,
	                                				process : as[i].process,
	                                				datea : as[i].datea,
	                                				timea : as[i].timea
	                                			})  
                                		});
                                	}else{
                                		t_data[n].inbs[m].detail.push({
                            				ucctnoq : as[i].uccnoq,
                            				processno : as[i].processno,
                            				process : as[i].process,
                            				datea : as[i].datea,
                            				timea : as[i].timea
                                		});
                                	}
                                }
                            }
                            $('#Loading').hide();
                            Unlock();
                            $('#chart01').barChart01({
                                data : t_data
                            });
                            
                            $('#txtTotPage').val(1);
                            $('#txtCurPage').data('chart', 'chart01').val(1).change(function(e) {
                                $(this).val(parseInt($(this).val()));
                                $('#' + $(this).data('chart')).data('info').page($('#' + $(this).data('chart')), $(this).val());
                            });
                            $("#btnNext").data('chart', 'chart01');
                            $("#btnPrevious").data('chart', 'chart01');
                            $(".control").show();
                        }
                        break;
                    default:
                        alert(t_func+':q_funcPost undefined');
                        break;
                }
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
                $.fn.barChart01 = function(value) {
                    $(this).data('info', {
                        curIndex : -1,
                        inbData : value.data,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            obj.data('info').curIndex = 0;
                            obj.data('info').refresh(obj);
                        },
                        page : function(obj, n) {
                            if (n > 0 && n <= 1) {
                                obj.data('info').curIndex = n - 1;
                                obj.data('info').refresh(obj);
                            } else
                                alert('頁數錯誤。');
                        },
                        next : function(obj) {
                            if (obj.data('info').curIndex == 1 - 1)
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
                            obj.width(1200).height(500).html(''); 
                            if(obj.data('info').inbData.length==0)
								return
                            var tmpPath = "";
							var bkColor = ['rgb(210,233,255)', 'rgb(255,238,221)'];//背景色
							var bkN = 10;//分幾個區塊
							var bkWidth = 900, bkHeight = 350;
							var bkOrigin = [130,50];
							var t_data = obj.data('info').inbData;
							bkHeight = Math.max(bkHeight,t_data.length*40);
							if(bkHeight+bkOrigin[1]+10>500){
								obj.height(bkHeight+bkOrigin[1]+10);
							}
							n = Math.max(bkHeight/bkN,40);
							for (var i = 0; i < bkN; i++)
                                tmpPath += '<rect x="'+(bkOrigin[0])+'" y="'+(bkOrigin[1]+n*i)+'" width="' + (bkWidth+200) + '" height="' + (n) + '" style="fill:' + bkColor[i % bkColor.length] + ';"/>';
                            //X軸
                            tmpPath += '<line x1="'+bkOrigin[0]+'" y1="'+bkOrigin[1]+'" x2="' + (bkOrigin[0]+bkWidth) + '" y2="' + bkOrigin[1]+ '" style="stroke:rgb(0,0,0);stroke-width:1"/>';
                            //Y軸
                            tmpPath += '<line x1="'+bkOrigin[0]+'" y1="'+bkOrigin[1]+'" x2="'+bkOrigin[0]+'" y2="' + (bkOrigin[1]+n*bkN) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';                       	
                        	var t_process = new Array();
                        	var chk ;
                        	for(var i=0; i<t_data.length;i++){
                        		for(var j=0; j<t_data[i].inbs.length;j++){
                        			for(var k=0; k<t_data[i].inbs[j].detail.length;k++){
                        				if(t_data[i].inbs[j].detail[k].processno.length>0){
                        					chk = false;
                        					for(var m=0;m<t_process.length;m++){
                        					if(t_data[i].inbs[j].detail[k].processno==t_process[m].processno)
	                        					chk = true;
	                        				}
	                        				if(!chk){
	                        					t_process.push({
	                        						processno:t_data[i].inbs[j].detail[k].processno,
	                        						process:t_data[i].inbs[j].detail[k].process,
	                        						isexist:false
	                        					});
	                        				}
                        				}
                        			}
                        		}
                        	}
                        	var curX = bkOrigin[0],curY;
                        	var t_width = Math.round(bkWidth/t_process.length);
                        	var itemColor = ['rgb(180,200,180)', 'rgb(200,180,180)', 'rgb(180,180,200)'];
                        	for(var i=0; i<t_process.length;i++){
                        		tmpPath += '<text text-anchor="middle" x="'+(curX+t_width/2)+'" y="' + (bkOrigin[1]-5) + '" fill="black">' + t_process[i].process + '</text>';
                        		tmpPath += '<line x1="'+curX+'" y1="'+bkOrigin[1]+'" x2="'+curX+'" y2="' + (bkOrigin[1]+Math.max(bkHeight/bkN,40)*bkN) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';               
                        		curX += t_width;
                        	}
                        	tmpPath += '<text text-anchor="middle" x="'+(curX+150/2)+'" y="' + (bkOrigin[1]-5) + '" fill="black">預計產量/實際產量</text>';
                        	tmpPath += '<line x1="'+curX+'" y1="'+bkOrigin[1]+'" x2="'+curX+'" y2="' + (bkOrigin[1]+Math.max(bkHeight/bkN,40)*bkN) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';               
                        	
                        	for(var i=0;i<t_data.length;i++){
                        		for(var m=0;m<t_process.length;m++){
            						t_process[m].isexist = false;
                				}
                        		t_bweight = 0;
                        		t_weight = 0;
                        		for(var j=0; j<t_data[i].inbs.length;j++){
                        			t_bweight += t_data[i].inbs[j].bweight;
                        			t_weight += t_data[i].inbs[j].weight;
                        			for(var k=0; k<t_data[i].inbs[j].detail.length;k++){
                        				for(var m=0;m<t_process.length;m++){                 					
                    						if(t_data[i].inbs[j].detail[k].processno==t_process[m].processno && t_data[i].inbs[j].detail[k].datea.length>0)
                        						t_process[m].isexist = true;
                        				}
                        			}
                        		}
                        		tmpPath += '<text text-anchor="end" x="'+(bkOrigin[0]-5)+'" y="' + (bkOrigin[1]+(i+1)*40-15) + '" fill="black" font-size="14px">' + t_data[i].inbno+ '</text>';
                        		tmpPath += '<text text-anchor="end" x="'+(bkOrigin[0]+bkWidth+80)+'" y="' + (bkOrigin[1]+(i+1)*40-15) + '" fill="black" font-size="14px">' + FormatNumber(t_bweight)+ ' / </text>';
                        		tmpPath += '<text text-anchor="end" x="'+(bkOrigin[0]+bkWidth+145)+'" y="' + (bkOrigin[1]+(i+1)*40-15) + '" fill="black" font-size="14px">' + FormatNumber(t_weight)+ '</text>';
                        		curY = (bkOrigin[1]+i*40+5);
                        		for(var m=0;m<t_process.length;m++){
                        			if(t_process[m].isexist){
                        				curX = bkOrigin[0] + t_width * m;
                        				tmpPath += '<rect x="'+(curX+5)+'" y="'+curY+'" width="' + (t_width-10) + '" height="30" style="fill:' + itemColor[m % itemColor.length] + ';"/>';
                        			}
                				}
                        	}
                        	obj.html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
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
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div id="svg_search" style="display:inline-block;width:2000px;">
				<input type="button" id="btnRun" style="float:left; width:80px;font-size: medium;" value="執行"/>
				<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			</div>
			<div id="chart">
				<div id='Loading' class="z_cugp chart"> </div>
				<div id='chart01' class="z_cugp chart"> </div>
			</div>
			<div id='dataSearch' class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          