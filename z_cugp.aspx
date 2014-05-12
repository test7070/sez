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
					
					if(txtreport.indexOf('z_cugp_svg')>-1){
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
                        name : 'xenddate' 
                    }, {
						type : '5', //select
						name : 'xorder',
						value : ('1@製程,2@開工日').split(',')
					},{
                        type : '1',
                        name : 'xdate'
                    },{
                        type : '6',
                        name : 'xordeno' 
                    },{
                        type : '6',
                        name : 'xno2' 
                    },{
                        type : '6',
                        name : 'xworkgno' 
                    },{
                        type : '6',
                        name : 'xworkgnoq' 
                    }]
				});
                q_popAssign();
				$('#txtXenddate').datepicker();
				$('#txtXenddate').mask('999/99/99');
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate2').mask('999/99/99');
				
				var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXdate1').val(t_year+'/'+t_month+'/'+t_day);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXdate2').val(t_year+'/'+t_month+'/'+t_day);
				
				//$('#txtXenddate').val(q_date());
				
				//SVG
				$("#btnRun").click(function(e) {
                	var t_bstation = emp($('#txtStation1a').val())?'#non':$('#txtStation1a').val();
                	var t_estation = emp($('#txtStation2a').val())?'#non':$('#txtStation2a').val();
                	var t_bprocess = emp($('#txtProcess1a').val())?'#non':$('#txtProcess1a').val();
                	var t_eprocess = emp($('#txtProcess2a').val())?'#non':$('#txtProcess2a').val();
                	var t_bdate = emp($('#txtXdate1').val())?'#non':$('#txtXdate1').val();
                	var t_edate = emp($('#txtXdate2').val())?'#non':$('#txtXdate2').val();
                    var t_index = $('#q_report').data('info').radioIndex;
                    var t_report = $('#q_report').data('info').reportData[t_index].report;

                    $(".z_cugp.chart").html('').height(0);
                    $("#txtCurPage").val(0);
                    $("#txtTotPage").val(0);
                    
                    var t_ordeno = emp($('#txtXordeno').val())?'#non':$('#txtXordeno').val();
                	var t_no2 = emp($('#txtXno2').val())?'#non':$('#txtXno2').val();
                	var t_workgno = emp($('#txtXworkgno').val())?'#non':$('#txtXworkgno').val();
                	var t_workgnoq = emp($('#txtXworkgnoq').val())?'#non':$('#txtXworkgnoq').val();
                    
                    switch(txtreport) {
                        case 'z_cugp_svg1':
                            $('#Loading').Loading();
                            Lock();
                            q_func('qtxt.query.svg1', 'z_cugp_svg.txt,' + txtreport + ',' + encodeURI(r_accy) + ';#non;' + t_bstation+ ';' + t_estation+ ';' + t_bprocess+ ';' + t_eprocess + ';#non;#non;'+t_bdate+';'+t_edate);
                            break;
						case 'z_cugp_svg2':
                            $('#Loading').Loading();
                            Lock();
                            q_func('qtxt.query.svg2', 'z_cugp_svg.txt,' + txtreport + ',' + t_ordeno+ ';' + t_no2+ ';' + t_workgno+ ';' + t_workgnoq);
                            break;
                        default:
                            alert('錯誤：未定義報表');
                    }
                });
			}

            function q_boxClose(s2) {
            }
            
            function q_gtPost(s2) {
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.svg1':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] == undefined){
                        	$('#Loading').hide();
                            Unlock();
                        }else {
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
							                    if (t_data[j].process[k].process == as[i].process)
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
		                                			gen: as[i].gen,
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
		                                		gen: as[i].gen,
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
		                                		gen: as[i].gen,
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
		                                	gen: as[i].gen,
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
		                                	gen: as[i].gen,
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
		                                	gen: as[i].gen,
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
					case 'qtxt.query.svg2':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] == undefined){
                        	$('#Loading').hide();
                            Unlock();
                        }else {
                            var n = -1;
                            var m = -1;
                            t_data = new Array();
                            for (var i in as) {
                                if (as[i].workgno != undefined) {
                                	n = -1;
                                	m = -1;
                                	for (var j = 0; j < t_data.length; j++){
					                    if (t_data[j].workgno == as[i].workgno && t_data[j].workgnoq == as[i].workgnoq){
					                    	n = j;
					                    	for (var k = 0; k < t_data[j].sp.length; k++)
							                    if (t_data[j].sp[k].station == as[i].station)
							                        m = k;
					                    }
									}
					                        
                                	if(n==-1){
                                		t_data.push({
                                			workgno : as[i].workgno,
                                			workgnoq : as[i].workgnoq,
                                			productno : as[i].productno,
                                			product : as[i].product,
                                			ordeno: as[i].ordeno,
                                			sp: new Array({
                                				stationno : as[i].stationno,
		                                		station : as[i].station,
		                                		detail : new Array({
		                                			processno : as[i].processno,
		                                			process : as[i].process,
		                                			datea : as[i].datea,
			                                		hours : as[i].hours,
			                                		prehours : as[i].prehours,
			                                		gen: as[i].gen,
			                                		noq : as[i].noq,
			                                		nos : as[i].nos,
			                                		workno : as[i].workno,
			                                		mproductno:as[i].mproductno,
			                                		mproduct:as[i].mproduct,
			                                		accy : as[i].accy
		                                		})
	                                		})
                                		});
                                	}else if(m==-1){
                                		t_data[n].sp.push({
                                			stationno : as[i].stationno,
		                                	station : as[i].station,
		                                	detail : new Array({
		                                		processno : as[i].processno,
		                                		process : as[i].process,
		                                		datea : as[i].datea,
			                                	hours : as[i].hours,
			                                	prehours : as[i].prehours,
			                                	gen: as[i].gen,
			                                	noq : as[i].noq,
			                                	nos : as[i].nos,
			                                	workno : as[i].workno,
			                                	mproductno:as[i].mproductno,
			                                	mproduct:as[i].mproduct,
			                                	accy : as[i].accy
		                                	})
                                		});
                                	}else{
                                		t_data[n].sp[m].detail.push({
                                			processno : as[i].processno,
		                                	process : as[i].process,
                                			datea : as[i].datea,
		                                	hours : as[i].hours,
		                                	prehours : as[i].prehours,
		                                	gen: as[i].gen,
		                                	noq : as[i].noq,
		                                	nos : as[i].nos,
		                                	workno : as[i].workno,
		                                	mproductno:as[i].mproductno,
			                                mproduct:as[i].mproduct,
		                                	accy : as[i].accy
                                		});
                                	}
                                }
                            }
                            $('#Loading').hide();
                            Unlock();
                            $('#chart02').barChart02({
                                data : t_data,
                            });
                            
                            $('#txtTotPage').val(t_data.length);
                            $('#txtCurPage').data('chart', 'chart02').val(1).change(function(e) {
                                $(this).val(parseInt($(this).val()));
                                $('#' + $(this).data('chart')).data('info').page($('#' + $(this).data('chart')), $(this).val());
                            });
                            $("#btnNext").data('chart', 'chart02');
                            $("#btnPrevious").data('chart', 'chart02');
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
							var p_height=200//固定背景製程高度
							var s_process=9;//每個製程要區分段落
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
							if(days<=12)
							day_width=900/days;
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
	                        		if(s_data.detail[i].process==t_data.process[j].process)
	                        			y=bkOrigin[1]+(p_height*j)+((i%s_process)*s_height);
	                        	}
	                        	
	                        	//計算製程的長度
	                        	//一天總時數
	                        	var totalgen=dec(s_data.gen);
	                        	//--------時數
	                        	if(totalgen<dec(s_data.detail[i].hours))
	                        		end_width=day_width;
	                        	else
	                        		end_width=(day_width/totalgen*dec(s_data.detail[i].hours));
	                        	
	                        	//如果製程沒有連續
	                        	if(t_date!=pre_date){
									var t4=new Date((dec(t_date.substr(0,3))+1911)+'/'+t_date.substr(4,2)+'/'+t_date.substr(7,2));
									var tdays=t4.getTime()-t1.getTime();
									tdays= Math.floor(tdays / (24 * 3600 * 1000))
	                        		x=bkOrigin[0]+(day_width*tdays);
	                        	}
	                        	
	                        	tmpPath += '<rect id="'+s_data.detail[i].workno+'" class="workno" x="'+x+'" y="'+y+'" width="' + end_width + '" height="'+s_height+'" style="fill:' + itemColor[i % itemColor.length] + ';"/>';
	                        	tmpPath += '<text id="'+s_data.detail[i].workno+'" class="workno" text-anchor="start" x="'+(x+end_width)+'" y="' + (y+s_height/2) + '" fill="black">' + (s_data.detail[i].comp==''?s_data.detail[i].process:s_data.detail[i].comp) + '</text>';
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
                $.fn.barChart02 = function(value) {
                    $(this).data('info', {
                        curIndex : -1,
                        cugData : value.data,
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
                            var tmpPath = "";
							var bkColor = ['rgb(210,233,255)', 'rgb(255,238,221)'];//背景色
							var bkN = t_data.sp.length;//分幾個框
							var p_height=200//固定背景框的高度
							var s_section=4//固定工作框的段落
							var s_height=p_height/s_section//固定工作框的高度
							
							var start_date='';//起始
                        	var end_date='';//終止
                        	for(var i=0;i<t_data.sp.length;i++){
                        		for(var j=0;j<t_data.sp[i].detail.length;j++){
                        			if(start_date=='' || start_date>t_data.sp[i].detail[j].datea)
                        				start_date=t_data.sp[i].detail[j].datea;
                        			if(end_date=='' || end_date<t_data.sp[i].detail[j].datea)
                        				end_date=t_data.sp[i].detail[j].datea;
                        		}
                        	}
                        	
							//寄算天數差
							var t1=new Date((dec(start_date.substr(0,3))+1911)+'/'+start_date.substr(4,2)+'/'+start_date.substr(7,2));
							var t2=new Date((dec(end_date.substr(0,3))+1911)+'/'+end_date.substr(4,2)+'/'+end_date.substr(7,2));
							var days=t2.getTime()-t1.getTime();
							days= Math.floor(days / (24 * 3600 * 1000))+1
							var day_width=70;//估定天數大小
							if(days<=12)
								day_width=900/days;
							var bkOrigin = [160,50];//邊界
							
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
                        	
                        	//排產編號(標頭)
                        	tmpPath += '<text font-size="22" text-anchor="start" x="'+(bkOrigin[0])+'" y="' + 30 + '" fill="black">'
                        	+'排產編號：'+ t_data.workgno+'-'+t_data.workgnoq+'&nbsp;&nbsp;&nbsp;&nbsp;製品：'+t_data.product+'</text>';
                        	
                        	//工作中心名稱(Y軸)
                        	for(var i=0; i<t_data.sp.length;i++){
                        		var station_name=emp(t_data.sp[i].station)?'無工作中心名稱':t_data.sp[i].station;
                        		//var process_name=emp(t_data.sp[i].process)?'無製程名稱':t_data.sp[i].process;
                        		tmpPath += '<text text-anchor="end" x="'+(bkOrigin[0]-10)+'" y="' + (bkOrigin[1]+p_height*(i+1)-((p_height+10)/2)) + '" fill="black">' + station_name + '</text>';
                        		//tmpPath += '<text text-anchor="end" x="'+(bkOrigin[0]-10)+'" y="' + (bkOrigin[1]+p_height*(i+1)-((p_height+10)/2)+20) + '" fill="black">' + process_name + '</text>';
                        	}
                        	
                        	//製程甘特圖
                        	var itemColor = ['rgb(180,200,180)', 'rgb(200,180,180)', 'rgb(180,180,200)', 'rgb(200,180,200)'];
                        	var x=bkOrigin[0];
                        	var y=(bkOrigin[1]+5);
	                        var end_width=0;
                        	
                        	for(var i=0;i<t_data.sp.length;i++){
                        		//計算工作中心的起始Y
	                        	//y=bkOrigin[1]+(p_height*i)+((p_height-s_height)/2);
                        		for(var j=0;j<t_data.sp[i].detail.length;j++){
                        			//計算工作中心的起始Y
                        			y=bkOrigin[1]+(p_height*i)+((j%s_section)*s_height);
                        			//計算製令的長度
                        			//當天總時數
                        			var totalgen=dec(t_data.sp[i].detail[j].gen);
                        			//--------時數
	                        		if(totalgen<dec(t_data.sp[i].detail[j].hours))
		                        		end_width=day_width;
		                        	else
		                        		end_width=(day_width/totalgen*dec(t_data.sp[i].detail[j].hours));
		                        	
		                        	var t_date=t_data.sp[i].detail[j].datea
		                        	var t4=new Date((dec(t_date.substr(0,3))+1911)+'/'+t_date.substr(4,2)+'/'+t_date.substr(7,2));
									var tdays=t4.getTime()-t1.getTime();
									tdays= Math.floor(tdays / (24 * 3600 * 1000))
									//邊界+日期長度起始+當天前置時間
	                        		x=bkOrigin[0]+(day_width*tdays)+(day_width/totalgen*dec(t_data.sp[i].detail[j].prehours));
                        			
                        			//長條
                        			tmpPath += '<rect id="'+t_data.sp[i].detail[j].workno+'" class="workno" x="'+x+'" y="'+y+'" width="' + end_width + '" height="'+s_height+'" style="fill:' + itemColor[j % itemColor.length] + ';"/>';
                        			//製令編號
                        			tmpPath += '<text id="'+t_data.sp[i].detail[j].workno+'" font-size="12" class="workno" text-anchor="start" x="'+x+'" y="' + (y+15) + '" fill="black">' + t_data.sp[i].detail[j].workno + '</text>';
                        			//製程
                        			tmpPath += '<text id="'+t_data.sp[i].detail[j].workno+'" font-size="12" class="workno" text-anchor="start" x="'+x+'" y="' + (y+30) + '" fill="black">' + (emp(t_data.sp[i].detail[j].process)?'無製程名稱':t_data.sp[i].detail[j].process) + '</text>';
                        			//成品
                        			tmpPath += '<text id="'+t_data.sp[i].detail[j].workno+'" font-size="12" class="workno" text-anchor="start" x="'+x+'" y="' + (y+45) + '" fill="black">' + t_data.sp[i].detail[j].mproduct + '</text>';
                        		}
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
				<div id='chart02' class="z_cugp chart"> </div>
			</div>
			<div id='dataSearch' class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          