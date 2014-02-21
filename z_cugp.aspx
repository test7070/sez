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
						$('#chart').show();
					}else{
						$('#dataSearch').show();
						$('#svg_search').hide();
						$('#chart').hide();
					}
				});
				
				$("#btnNext").click(function(e) {
                    $('#' + $(this).data('chart')).data('info').next($('#' + $(this).data('chart')));
                });
                $("#btnPrevious").click(function(e) {
                    $('#' + $(this).data('chart')).data('info').previous($('#' + $(this).data('chart')));
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
                            s_data = new Array();
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
                                			shours: as[i].shours,
                                			gen: as[i].gen,
                                			process : new Array({
                                				processno : as[i].processno,
                                				process : as[i].process,
	                                			detail : new Array({
	                                				productno : as[i].productno,
	                                				product : as[i].product,
	                                				noq : as[i].noq,
	                                				mount : as[i].mount,
		                                			hours : as[i].hours,
		                                			days : as[i].days,
		                                			cuadate : as[i].cuadate,
		                                			uindate : as[i].uindate,
		                                			workno : as[i].workno,
		                                			memo : as[i].memo,
		                                			custno : as[i].custno,
		                                			comp : as[i].comp
	                                			})
                                			})
                                		});
                                		s_data.push({
                                			stationno : as[i].stationno,
                                			station : as[i].station,
                                			shours: as[i].shours,
                                			gen: as[i].gen,
	                                		detail : new Array({
	                                			processno : as[i].processno,
                                				process : as[i].process,
	                                			productno : as[i].productno,
	                                			product : as[i].product,
	                                			noq : as[i].noq,
	                                			mount : as[i].mount,
		                                		hours : as[i].hours,
		                                		days : as[i].days,
		                                		cuadate : as[i].cuadate,
		                                		uindate : as[i].uindate,
		                                		workno : as[i].workno,
		                                		memo : as[i].memo,
		                                		custno : as[i].custno,
		                                		comp : as[i].comp
	                                		})
                                		});
                                	}else if(m==-1){
                                		t_data[n].process.push({
                                			processno : as[i].processno,
                                			process : as[i].process,
	                                		detail : new Array({
	                                			noq : as[i].noq,
	                                			productno : as[i].productno,
	                                			product : as[i].product,
	                                			mount : as[i].mount,
		                                		hours : as[i].hours,
		                                		days : as[i].days,
		                                		cuadate : as[i].cuadate,
		                                		uindate : as[i].uindate,
		                                		workno : as[i].workno,
		                                		memo : as[i].memo,
		                                		custno : as[i].custno,
		                                		comp : as[i].comp
	                                		})
                                		});
                                		s_data[n].detail.push({
                                			processno : as[i].processno,
                                			process : as[i].process,
	                                		productno : as[i].productno,
	                                		product : as[i].product,
	                                		noq : as[i].noq,
	                                		mount : as[i].mount,
		                                	hours : as[i].hours,
		                                	days : as[i].days,
		                                	cuadate : as[i].cuadate,
		                                	uindate : as[i].uindate,
		                                	workno : as[i].workno,
		                                	memo : as[i].memo,
		                                	custno : as[i].custno,
		                                	comp : as[i].comp
                                		});
                                	}else{
                                		t_data[n].process[m].detail.push({
                                			noq : as[i].noq,
                                			productno : as[i].productno,
	                                		product : as[i].product,
                            				mount : as[i].mount,
		                                	hours : as[i].hours,
		                                	days : as[i].days,
		                                	cuadate : as[i].cuadate,
		                                	uindate : as[i].uindate,
		                                	workno : as[i].workno,
		                                	memo : as[i].memo,
		                                	custno : as[i].custno,
		                                	comp : as[i].comp
                                		});
                                		s_data[n].detail.push({
                                			processno : as[i].processno,
                                			process : as[i].process,
	                                		productno : as[i].productno,
	                                		product : as[i].product,
	                                		noq : as[i].noq,
	                                		mount : as[i].mount,
		                                	hours : as[i].hours,
		                                	days : as[i].days,
		                                	cuadate : as[i].cuadate,
		                                	uindate : as[i].uindate,
		                                	workno : as[i].workno,
		                                	memo : as[i].memo,
		                                	custno : as[i].custno,
		                                	comp : as[i].comp
                                		});
                                	}
                                }
                            }
                            $('#Loading').hide();
                            Unlock();
                            $('#chart01').barChart01({
                                data : t_data,
                                data2 : s_data
                            });
                            
                            $('#txtTotPage').val(t_data.length);
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
                        cugData : value.data,
                        cugData2 : value.data2,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            obj.data('info').curIndex = 0;
                            obj.data('info').refresh(obj);
                        },
                        page : function(obj, n) {
                            if (n > 0 && n <= obj.data('info').cugData.length) {
                                obj.data('info').curIndex = n - 1;
                                obj.data('info').refresh(obj);
                            } else
                                alert('頁數錯誤。');
                        },
                        next : function(obj) {
                            if (obj.data('info').curIndex == obj.data('info').cugData.length - 1)
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
                            if(obj.data('info').cugData.length==0)
								return
							var t_data = obj.data('info').cugData[obj.data('info').curIndex];
							var s_data = obj.data('info').cugData2[obj.data('info').curIndex];
                            var tmpPath = "";
							var bkColor = ['rgb(210,233,255)', 'rgb(255,238,221)'];//背景色
							var bkN = t_data.process.length;//分幾個製程
							var p_height=90//固定背景製程高度
							var s_process=3;//每個製程要區分段落
							var s_height=p_height/s_process;//固定製程高度
							var start_date='';//起始
                        	var end_date='';//終止
                        	for(var i=0;i<t_data.process.length;i++){
                        		for(var j=0;j<t_data.process[i].detail.length;j++){
                        			if(start_date=='' || start_date>t_data.process[i].detail[j].cuadate)
                        				start_date=t_data.process[i].detail[j].cuadate;
                        			if(end_date=='' || end_date<t_data.process[i].detail[j].uindate)
                        				end_date=t_data.process[i].detail[j].uindate;
                        		}
                        	}
                        	if(emp(end_date)){
								for(var i=0;i<t_data.process.length;i++){
	                        		for(var j=0;j<t_data.process[i].detail.length;j++){
	                        			if(end_date<t_data.process[i].detail[j].cuadate)
	                        				end_date=t_data.process[i].detail[j].cuadate;
	                        		}
	                        	}
							}
							//寄算天數差
							var t1=new Date((dec(start_date.substr(0,3))+1911)+'/'+start_date.substr(4,2)+'/'+start_date.substr(7,2));
							var t2=new Date((dec(end_date.substr(0,3))+1911)+'/'+end_date.substr(4,2)+'/'+end_date.substr(7,2));
							var days=t2.getTime()-t1.getTime();
							days= Math.floor(days / (24 * 3600 * 1000))+1
							var day_width=70;//估定天數大小
							var bkOrigin = [130,50];//邊界
							//div大小
							obj.width(bkOrigin[0]+day_width*days+100).height((bkOrigin[1]+p_height*bkN+100)).html(''); 
							//底色
							for (var i = 0; i < bkN; i++)
                                tmpPath += '<rect x="'+(bkOrigin[0])+'" y="'+(bkOrigin[1]+p_height*i)+'" width="' + (day_width*days) + '" height="' + (p_height) + '" style="fill:' + bkColor[i % bkColor.length] + ';"/>';
							
                            //X軸
                            tmpPath += '<line x1="'+bkOrigin[0]+'" y1="'+(bkOrigin[1]+p_height*bkN)+'" x2="' + (bkOrigin[0]+day_width*days) + '" y2="' + (bkOrigin[1]+p_height*bkN)+ '" style="stroke:rgb(0,0,0);stroke-width:1"/>';
                            //Y軸
                            tmpPath += '<line x1="'+bkOrigin[0]+'" y1="'+bkOrigin[1]+'" x2="'+bkOrigin[0]+'" y2="' + (bkOrigin[1]+p_height*bkN) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';                       	
                        	
                        	//時間差距
                        	var t3=new Date(t1);
                        	for(var i=0;i<=days;i++){
                        		var t_date=(t3.getMonth()+1)+'/'+t3.getDate();
                        		tmpPath += '<line x1="'+(bkOrigin[0]+day_width*i)+'" y1="'+(bkOrigin[1]+p_height*bkN-5)+'" x2="'+(bkOrigin[0]+day_width*i)+'" y2="' + (bkOrigin[1]+p_height*bkN+5) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                        		tmpPath += '<text text-anchor="middle" x="'+(bkOrigin[0]+day_width*i)+'" y="' +(bkOrigin[1]+p_height*bkN+20+(i%2)*20) + '" fill="black">' +t_date + '</text>';
                        		t3.setDate(t3.getDate()+1);
                        	}
                        	//製程名稱
                        	for(var i=0; i<t_data.process.length;i++){
                        		var process_name=emp(t_data.process[i].process)?'無製程名稱':t_data.process[i].process;
                        		tmpPath += '<text text-anchor="end" x="'+(bkOrigin[0]-10)+'" y="' + (bkOrigin[1]+p_height*(i+1)-((p_height+10)/2)) + '" fill="black">' + process_name + '</text>';
                        	}
                        	//工作中心
                        	tmpPath += '<text font-size="26" text-anchor="middle" x="'+(bkOrigin[0])+'" y="' + 30 + '" fill="black">'+t_data.station+'</text>';
                        	
                        	//製程甘特圖
                        	var itemColor = ['rgb(180,200,180)', 'rgb(200,180,180)', 'rgb(180,180,200)'];
                        	var x=bkOrigin[0];
                        	var y=(bkOrigin[1]+5);
	                        var end_width=0;
	                        var pre_date='999/99/99';
                        	for(var i=0;i<s_data.detail.length;i++){
                        		var total=0,tmptotal=0;
                        		var t_date=s_data.detail[i].cuadate;
                        		pre_date=pre_date=='999/99/99'?s_data.detail[i].cuadate:pre_date;
                        		var tmpdate=s_data.detail[i].uindate;
                        		
	                        	//計算製程的起始Y
	                        	for(var j=0;j<t_data.process.length;j++){
	                        		if(s_data.detail[i].processno==t_data.process[j].processno)
	                        			y=bkOrigin[1]+(p_height*j)+((i%s_process)*s_height);
	                        	}
	                        	
	                        	//計算製程的長度
	                        	//一天總時數
	                        	var totalgen=dec(s_data.gen);
	                        	//-------平均
	                        	//計算該製程開工日包含其他同一天開工的製程數量(含該製程)
                        		/*for(var j=0;j<s_data.detail.length;j++){
                        			if(t_date==s_data.detail[j].cuadate){ total++;}
                        			if(t_date==s_data.detail[j].uindate&&t_date!=s_data.detail[j].cuadate){ total++;}
                        		}*/
                        		//計算該製程完工日包含其他同一天開工或完工的製程數量(含該製程)
                        		/*if(t_date!=tmpdate){
                        			for(var j=0;j<s_data.detail.length;j++){
	                        			if(tmpdate==s_data.detail[j].cuadate || tmpdate==s_data.detail[j].uindate){tmptotal++;}
		                        	}
	                        	}*/
	                        	//end_width=(day_width/total);
	                        	/*if(tmptotal!=0){
	                        		var t3=new Date((dec(t_date.substr(0,3))+1911)+'/'+t_date.substr(4,2)+'/'+t_date.substr(7,2));
									var t4=new Date((dec(tmpdate.substr(0,3))+1911)+'/'+tmpdate.substr(4,2)+'/'+tmpdate.substr(7,2));
									var tdays=t4.getTime()-t3.getTime();
									tdays= Math.floor(tdays / (24 * 3600 * 1000))-1
	                        		end_width+=(day_width/tmptotal)+(day_width*tdays);
	                        	}*/
	                        	//如果製程沒有連續
	                        	/*if(t_date!=pre_date){
	                        		var t3=new Date((dec(pre_date.substr(0,3))+1911)+'/'+pre_date.substr(4,2)+'/'+pre_date.substr(7,2));
									var t4=new Date((dec(t_date.substr(0,3))+1911)+'/'+t_date.substr(4,2)+'/'+t_date.substr(7,2));
									var tdays=t4.getTime()-t3.getTime();
									tdays= Math.floor(tdays / (24 * 3600 * 1000))-1
	                        		x+=(day_width*tdays);
	                        	}*/
	                        	//--------時數
	                        	end_width=(day_width/totalgen*dec(s_data.detail[i].hours));
	                        	
	                        	//如果製程沒有連續
	                        	if(t_date!=pre_date){
									var t4=new Date((dec(t_date.substr(0,3))+1911)+'/'+t_date.substr(4,2)+'/'+t_date.substr(7,2));
									var tdays=t4.getTime()-t1.getTime();
									tdays= Math.floor(tdays / (24 * 3600 * 1000))
	                        		x=bkOrigin[0]+(day_width*tdays);
	                        	}
	                        	
	                        	tmpPath += '<rect id="'+s_data.detail[i].workno+'" class="workno" x="'+x+'" y="'+y+'" width="' + end_width + '" height="'+s_height+'" style="fill:' + itemColor[i % itemColor.length] + ';"/>';
	                        	tmpPath += '<text id="'+s_data.detail[i].workno+'" class="workno" text-anchor="start" x="'+(x+end_width)+'" y="' + (y+s_height/2) + '" fill="black">' + (s_data.detail[i].comp==''?'生計':s_data.detail[i].comp) + '</text>';
                        		//設定下個製程的起始X
                        		x+=end_width;
                        		pre_date=tmpdate;
                        	}
                        	obj.html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                        	
                        	//事件
                        	obj.children('svg').find('.workno').hover(function(e) {
								$(this).attr('fill', 'red');
	                        }, function(e) {
								$(this).attr('fill', 'black');
							}).click(function(e){
	                            var workno = $(this).attr('id')
	                            t_where = "noa='"+workno+"'";
								q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
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
           
          