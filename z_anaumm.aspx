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
			var txtreport='',t_txtreport='';
			aPop = new Array(['txtXpart', '', 'part', 'noa,part', 'txtXpart', "part_b.aspx"]);
			var isInit = false;
            if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_anaumm');
                
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
							if(txtreport=='z_anaumm4')
								$('#btnSvg').val($('#q_report').data().info.reportData[i].reportName+'長條圖顯示');
						}
					}
					if(txtreport=='z_anaumm4')
						$('#btnSvg').show();
					
					if(t_txtreport!=txtreport){
						//直接執行
						var accy=r_accy+"_"+r_cno;
						var xaccy=r_accy;
						var bxpartno=$('#txtXpartno1a').val().length==0?'#non':$('#txtXpartno1a').val()
						var expartno=$('#txtXpartno2a').val().length==0?'ZZZZZ':$('#txtXpartno2a').val()
						var bxcust=$('#txtXcust1a').val().length==0?'#non':$('#txtXcust1a').val()
						var excust=$('#txtXcust2a').val().length==0?'ZZZZZ':$('#txtXcust2a').val()
						var bscno=$('#txtScno1a').val().length==0?'#non':$('#txtScno1a').val()
						var escno=$('#txtScno2a').val().length==0?'ZZZZZ':$('#txtScno2a').val()
					
						var bxdate=q_date();
						//取得前一天
						var nextdate=new Date(dec(bxdate.substr(0,3))+1911,dec(bxdate.substr(4,2))-1,dec(bxdate.substr(7,2)));
					    nextdate.setDate(nextdate.getDate() -1)
					    //bxdate=''+(nextdate.getFullYear()-1911)+'/';
					    //月份
					    if(nextdate.getMonth()+1<10)
					    	bxdate='0'+(nextdate.getMonth()+1)+'/';
					    else
					       	bxdate=(nextdate.getMonth()+1)+'/';
					    //日期
					    if(nextdate.getDate()<10)
					    	bxdate=bxdate+'0'+(nextdate.getDate());
					    else
					     	bxdate=bxdate+(nextdate.getDate());
					     	
						var exdate=bxdate;
						var xmon=$('#txtXmon').val().length==0?q_date().substr(0,6):$('#txtXmon').val()
						var bacc=$('#txtAcc1a').val().length==0?'#non':$('#txtAcc1a').val()
						var eacc=$('#txtAcc2a').val().length==0?'ZZZZZ':$('#txtAcc2a').val()
						
						var bcarowner=$('#txtCarowner1a').val().length==0?'#non':$('#txtCarowner1a').val()
						var ecarowner=$('#txtCarowner2a').val().length==0?'#non':$('#txtCarowner2a').val()
						var t_sssno='#non'
						var bxmoney=$('#txtXmoney1').val().length==0?'#non':$('#txtXmoney1').val()
						var exmoney=$('#txtXmoney2').val().length==0?'#non':$('#txtXmoney2').val()
						var zorder='#non'
						var bmon=$('#txtMon1').val().length==0?'#non':$('#txtMon1').val()
						var emon=$('#txtMon2').val().length==0?'#non':$('#txtMon2').val()
						var xtrdno='#non'
						var xsort05='#non'
						var bummdate=$('#txtUmmdate1').val().length==0?'#non':$('#txtUmmdate1').val()
						var eummdate=$('#txtUmmdate2').val().length==0?'#non':$('#txtUmmdate2').val()
						var xvccno='#non'
						var xsort06='#non'
						
						var t_where = accy+ ';' + xaccy + ';' + bxpartno + ';' + expartno + ';' + bxcust + ';' + excust+ ';' + bscno+ ';'+ escno+ ';' + bxdate+ ';' + exdate+ ';' + xmon+ ';' + bacc+ ';' + eacc +
						 ';'+ bcarowner+';' + ecarowner+';'+t_sssno+';'+bxmoney+';'+exmoney+';'+zorder+';'+bmon+';'+emon+';'+xtrdno+';'+xsort05+';'+bummdate+';'+eummdate+';'+xvccno+';'+xsort06;
						
						var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",bxdate=" + bxdate + ",exdate=" + exdate + ",r_cno=" + r_cno;
				        q_gtx(txtreport, t_where + ";;" + t_para + ";;z_anaumm;;" + q_getMsg('qTitle'));
			       		
			       		t_txtreport=txtreport
			       }
				});
				
				$('#btnSvg').click(function(e) {
					$('#dataSearch').hide();
					
					//帶入參數
					var xdate2='#non';
					if(!emp($('#txtXdate2').val()))
						xdate2=$('#txtXdate2').val();
					q_func('qtxt.query','z_anaumm.txt,'+txtreport+','+encodeURI(r_accy+'_'+r_cno) + ';' + encodeURI($('#txtXdate1').val()) + ';' + encodeURI(xdate2));
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
                q_gt('carteam', '', 0, 0, 0, "");
                q_gt('calctype2', '', 0, 0, 0, "calctypes");
                q_gt('carkind', '', 0, 0, 0, "");
                q_gt('acomp', '', 0, 0, 0);
                q_gt('calctype', '', 0, 0, 0);
                q_gt('sss', "where=^^ partno='07'^^" , 0, 0, 0, "", r_accy);
            }
			var sssno='';
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'sss':
            			var as = _q_appendData("sss", "", true);
            			for (var i = 0; i < as.length; i++) {
            				sssno+=as[i].noa+'.';
            			}
            			sssno=sssno.substr(0,sssno.length-1);
            			LoadQ_report();
            		break;
                    default:
                    	break;
                }
			}
			
			function LoadQ_report(){
				if (sssno.length>0 && !isInit) {
                    isInit = true;
					$('#q_report').q_report({
	                	fileName : 'z_anaumm',
	                    options : [{//[1]
							type : '0',
							name : 'accy',
							value : r_accy+"_"+r_cno
						},{//[2]
							type : '0',
							name : 'xaccy',
							value : r_accy
						}, {//[3][4]部門01-1
	                        type : '2',
	                        name : 'xpartno',
	                        dbf : 'part',
	                        index : 'noa,part',
	                        src : 'part_b.aspx'
	                    }, {//[5][6]客戶01-2
	                        type : '2',
	                        name : 'xcust',
	                        dbf : 'cust',
	                        index : 'noa,comp',
	                        src : 'cust_b.aspx'
	                    }, {//[7][8]公司01-4
	                        type : '2',
	                        name : 'scno',
	                        dbf : 'acomp',
	                        index : 'noa,acomp',
	                        src : 'acomp_b.aspx'
	                    },{//[9][10]日期01-8
	                        type : '1',
	                        name : 'xdate'
	                    },{//[11]月份02-1
	                        type : '6',
	                        name : 'xmon'
	                    }, {//[12][13]會計科目02-2
	                        type : '2',
	                        name : 'acc',
	                        dbf : 'acc',
	                        index : 'acc1,acc2',
	                        src :  "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
	                    }, {/*18-[14][15]-車主02-4*/
	                        type : '2',
	                        name : 'carowner',
	                        dbf : 'carowner',
	                        index : 'noa,namea',
	                        src : 'carowner_b.aspx'
	                    }, {/*20-[16]-管理帳號02-8*/
		                    type : '8', //select
		                    name : 'sssno',
		                    value : (sssno).split('.')
		                }, {/*21-[17][18]-金額範圍03-1*/
	                        type : '1',
	                        name : 'xmoney'
	                    }, {/*22-[19]-排序依車主、金額03-2*/
		                    type : '5', //select
		                    name : 'zorder',
		                    value : ('車主,金額').split(',')
	                    }, {/*23-[20][21]-帳款月份03-4*/
						    type : '1',
							name : 'mon'
						}, {/*24[22]-請款單號-03-8*/
							type : '6',
							name : 'xtrdno'
						}, {/*25[23]-排序方式-04-1*/
							type : '5',
							name : 'xsort05',
							value : q_getMsg('tsort05').split('&')
						}, {/*26[24][25]-收款日期04-2*/
							type : '1',
							name : 'ummdate'
						}, {/*27-[26]-請款單號04-4*/
							type : '6',
							name : 'xvccno'
						}, {/*28-[27]-排序方式04-8*//*07*/
							type : '5',
							name : 'xsort06',
							value : q_getMsg('tsort06').split('&')
						}]
					})
				};
                q_popAssign();
                q_langShow();
	                $('#txtDate1').mask('999/99/99');
		            $('#txtDate1').datepicker();
		            $('#txtDate2').mask('999/99/99');
		            $('#txtDate2').datepicker(); 
		            $('#txtXdate1').mask('99/99');
		            $('#txtXdate2').mask('99/99');
		            $('#txtMon1').mask('999/99');
					$('#txtMon2').mask('999/99');
					$('#txtUmmdate1').mask('999/99/99');
					$('#txtUmmdate2').mask('999/99/99');
					$('#txtUmmdate1').datepicker();
					$('#txtUmmdate2').datepicker();
					$('#txtXmoney1').val(-99999999);
	                $('#txtXmoney2').val(99999999);
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
	                $('#txtMon1').val(t_year + '/' + t_month);
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
					$('#txtMon2').val(t_year + '/' + t_month);
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
			
			
			
			function q_boxClose(t_name) {
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query':
                    	var as = _q_appendData("tmp0", "", true, true);
                    	var bar=new Array();
	                    //長條圖
	                     if( txtreport=='z_anaumm4'){
	                     	if (as[0] == undefined) {
	                           	$('#Loading').hide();
	                           	alert('沒有資料!!');
	                        }else{
	                        	var mon='';
	                        	var n = -1;
								var x_maxmoney=0,x_minmoney=0;
		                        for (i = 0; i < as.length; i++) {
		                        	var t_detail;
		                        	if(mon==''||mon!=as[i].mon){
		                        		x_maxmoney=0;
		                        		x_minmoney=0;
		                        	}
		                        	t_detail = {
		                        		datea : as[i].accc2,
		                                inmoney : as[i].inmoney,
		                                paymoney : as[i].paymoney,
		                                ainmoney : as[i].ainmoney,
		                                binmoney : as[i].binmoney,
		                                cinmoney : as[i].cinmoney,
		                                apaymoney : as[i].apaymoney,
		                                bpaymoney : as[i].bpaymoney,
		                                cpaymoney : as[i].cpaymoney
									};
		                        	//判斷該月份的最大值與最小值
		                            x_maxmoney=Math.max(x_maxmoney,dec(as[i].inmoney),dec(as[i].paymoney),dec(as[i].inmoney)-dec(as[i].paymoney))
		                            x_minmoney=Math.min(x_minmoney,dec(as[i].inmoney),dec(as[i].paymoney),dec(as[i].inmoney)-dec(as[i].paymoney))
		                        	if(mon==''||mon!=as[i].mon){
		                        		bar.push({
					                        mon:as[i].mon,
					                        detail : [t_detail],
					                        maxmoney:x_maxmoney,
					                        minmoney:x_minmoney
										});
										mon=as[i].mon;
										n++;
		                        	}else{
				                        bar[n].detail.push(t_detail);
				                        bar[n].maxmoney=x_maxmoney;
				                    	bar[n].minmoney=x_minmoney;
									}
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
                        Data : value.data,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            obj.data('info').curIndex = 0;
                            obj.data('info').refresh(obj);
                        },
                        page : function(obj, n) {
                            if (n > 0 && n <= obj.data('info').Data.length) {
                                obj.data('info').curIndex = n - 1;
                                obj.data('info').refresh(obj);
                            } else
                                alert('頁數錯誤。');
                        },
                        next : function(obj) {
                            if (obj.data('info').curIndex == obj.data('info').Data.length - 1)
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
                        	obj.width(950).height(500);
                            var t_color1 = ['rgb(210,233,255)', 'rgb(255,238,221)'];
                            var t_n = 10;
                            //分幾個區塊
                            var t_height = 350, t_width = 600;
                            var tmpPath = '<rect x="0" y="0" width="950" height="500" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
                            for (var i = 0; i < t_n; i++)
                                tmpPath += '<rect x="100" y="' + (50 + (t_height / t_n) * i) + '" width="' + t_width + '" height="' + (t_height / t_n) + '" style="fill:' + t_color1[i % t_color1.length] + ';"/>';                          
                            //Y軸
                            tmpPath += '<line x1="100" y1="50" x2="100" y2="' + (50 + t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                         
                            var t_detail = obj.data('info').Data[obj.data('info').curIndex].detail;
                            var t_maxMoney = obj.data('info').Data[obj.data('info').curIndex].maxmoney;
                            //t_maxMoney=(dec(t_maxMoney.toString().substr(0,1))+1)*Math.pow(10,t_maxMoney.toString().length-1);
                            
                            var t_minMoney = obj.data('info').Data[obj.data('info').curIndex].minmoney;
							var t_n = round((t_width - 20) / t_detail.length, 0);
                            var x, y, w, h, bx, by, t_output, t_money;
                            tmpPath += '<text x="' + (450) + '" y="' + (20) + '" fill="black">【' + obj.data('info').Data[obj.data('info').curIndex].mon + '月】</text>';
                            tmpPath += '<text x="' + (70) + '" y="' + (20) + '" fill="black">金額</text>';
                            tmpPath += '<text x="' + (50 + t_width + 50) + '" y="' + (50 + t_height + 30) + '" fill="black">日期</text>';
                            
                            x = 50;
                            var t_Y = 50 + t_height - round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_height, 0);
                            tmpPath += '<line x1="95" y1="' + t_Y + '" x2="100" y2="' + t_Y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text text-anchor="end" x="90" y="' + t_Y + '" fill="black">0</text>';
                            //X軸
                            tmpPath += '<line x1="100" y1="' + (t_Y) + '" x2="' + (100 + t_width) + '" y2="' + (t_Y) + '" style="stroke:rgb(0,0,0);stroke-width:1"/>';

                            //Y
                            tmpPath += '<text text-anchor="end" x="90" y="' + (50) + '" fill="black">' + FormatNumber(t_maxMoney) + '</text>';
                            tmpPath += '<line x1="95" y1="50" x2="100" y2="50" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text text-anchor="end" x="90" y="' + (50 + t_height) + '" fill="black">' + FormatNumber(t_minMoney) + '</text>';
                            tmpPath += '<line x1="95" y1="' + (50 + t_height) + '" x2="100" y2="' + (50 + t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            
                            var t_range = round((t_maxMoney - t_minMoney)/5,0);
                            var i = Math.pow(10,(t_range+'').length-1);
                            var t_range = Math.floor(t_range/i)*i;
                            t_money = t_range;
                            while (t_money < t_maxMoney) {
                            	if((t_maxMoney-t_money)/(t_maxMoney - t_minMoney)>0.05){
	                                y = t_Y - round(t_money / (t_maxMoney - t_minMoney) * t_height, 0);
	                                tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
	                                tmpPath += '<text text-anchor="end" x="90" y="' + y + '" fill="black">' + FormatNumber(t_money)+ '</text>';
                            	}
                            	t_money += t_range;
                            }
                            t_money = -t_range;
                            while (t_money > t_minMoney) {
                            	if(Math.abs(t_minMoney-t_money)/(t_maxMoney - t_minMoney)>0.05){
	                                x = 90;
	                                y = t_Y - round(t_money / (t_maxMoney - t_minMoney) * t_height, 0);
	                                tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
	                                tmpPath += '<text text-anchor="end" x="90" y="' + y + '" fill="black">' + FormatNumber(t_money) + '</text>';
                               	}
                               	t_money -= t_range;
                            }
                            
                            //損益的顏色
	                        tmpPath += '<defs>' + '<linearGradient id="barchart_profitColor1" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
	                        tmpPath += '<defs>' + '<linearGradient id="barchart_profitColor2" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
	
	                        //損益
	                        for (var i = 0; i < t_detail.length; i++) {
	                        	t_output = dec(t_detail[i].inmoney)-dec(t_detail[i].paymoney);
	                            h = Math.abs(round(t_output / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0));
	                            x = 100 + 10 + t_n * i - (i == 0 ? 9 : 10);
	                            if(t_output >= 0){
	                            	y = t_Y - h;
	                            }else{
	                            	y = t_Y;
	                            }
	                            tmpPath += '<rect id="barChart_profit' + i + '" class="barChart_profit" x="' + x + '" y="' + y + '" width="' + t_n + '" height="' + h + '" fill="url(#barchart_profitColor1)"/>';
	                        }
	                        //收入
	                        for (var i = 0; i < t_detail.length; i++) {//連接線
	                            x = 100 + 10 + t_n * i;
	                            y = t_Y - round(dec(t_detail[i].inmoney) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                            if (i > 0)
	                                tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(255,0,0);stroke-width:1"/>';
	                            bx = x;
	                            by = y;
	                        }
	                        for (var i = 0; i < t_detail.length; i++) {
	                            x = 100 + 10 + t_n * i;
	                            y = t_Y - round(dec(t_detail[i].inmoney) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                            tmpPath += '<circle id="barChart_in' + i + '" class="barChart_in" class="" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
	                        }
	                        //支出
	                        for (var i = 0; i < t_detail.length; i++) {//連接線
	                            x = 100 + 10 + t_n * i;
	                            y = t_Y - round(dec(t_detail[i].paymoney) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                            if (i > 0)
									tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(0,255,0);stroke-width:1"/>';
								bx = x;
	                            by = y;
							}
							for (var i = 0; i < t_detail.length; i++) {
	                        	x = 100 + 10 + t_n * i;
	                            y = t_Y - round(dec(t_detail[i].paymoney) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                            tmpPath += '<circle id="barChart_out' + i + '" class="barChart_out" class="" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
	                            tmpPath += '<text id="barChart_date' + i + '" class="barChart_date" x="' + (x - 10) + '" y="' + (50 + t_height + 30) + '" fill="black">' + t_detail[i].datea.substr(3,2) + '</text>';
							}
	                            
                            //符號說明
                            tmpPath += '<line x1="800" y1="45" x2="820" y2="45" style="stroke:rgb(0,0,0);stroke-width:1"/>';
                            tmpPath += '<circle class="" cx="810" cy="45" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
                            tmpPath += '<text x="830" y="50" fill="black">支出</text>';

                            tmpPath += '<line x1="800" y1="75" x2="820" y2="75" style="stroke:rgb(0,0,0);stroke-width:1"/>';
	                        tmpPath += '<circle class="" cx="810" cy="75" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
	                        tmpPath += '<text x="830" y="80" fill="black">收入</text>';

                            tmpPath += '<rect x="800" y="95" width="20" height="20" fill="url(#barchart_profitColor1)"/>';
                            tmpPath += '<text x="830" y="110" fill="black">損益</text>';

                            obj.html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                            //事件
                            obj.children('svg').find('.barChart_in').hover(function(e) {
                                $(this).attr('fill', 'rgb(255,151,151)');
                                var n = $(this).attr('id').replace('barChart_in', '');
                                $('#barChart_date' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'rgb(255,0,0)');
                                var n = $(this).attr('id').replace('barChart_in', '');
                                $('#barChart_date' + n).attr('fill', 'black');
                            }).click(function(e){
                            	var obj = $(this).parent().parent();
                                var n = $(this).attr('id').replace('barChart_in', '');
                                var t_index = obj.data('info').curIndex;
                                var alerttxt='';
                                alerttxt+='收入總金額：'+obj.data('info').Data[t_index].detail[n].inmoney+'\n';
                                alerttxt+='現金收入金額：'+obj.data('info').Data[t_index].detail[n].ainmoney+'\n';
                                alerttxt+='銀行存款收入金額：'+obj.data('info').Data[t_index].detail[n].binmoney+'\n';
                                alerttxt+='應收票據收入金額：'+obj.data('info').Data[t_index].detail[n].cinmoney;
                            	alert(alerttxt);
                            });
	                            
                            obj.children('svg').find('.barChart_out').hover(function(e) {
                                $(this).attr('fill', 'rgb(255,151,151)');
                                var n = $(this).attr('id').replace('barChart_out', '');
                                $('#barChart_date' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'rgb(0,255,0)');
                                var n = $(this).attr('id').replace('barChart_out', '');
                                $('#barChart_date' + n).attr('fill', 'black');
                            }).click(function(e){
                            	var obj = $(this).parent().parent();
                                var n = $(this).attr('id').replace('barChart_out', '');
                                var t_index = obj.data('info').curIndex;
                                var alerttxt='';
                               	alerttxt+='支出總金額：'+obj.data('info').Data[t_index].detail[n].paymoney+'\n';
                                alerttxt+='現金支出金額：'+obj.data('info').Data[t_index].detail[n].apaymoney+'\n';
                                alerttxt+='銀行存款支出金額：'+obj.data('info').Data[t_index].detail[n].bpaymoney+'\n';
                                alerttxt+='應收票據支出金額：'+obj.data('info').Data[t_index].detail[n].cpaymoney;
                            	alert(alerttxt);
                            });

                            obj.children('svg').find('.barChart_profit').hover(function(e) {
                                $(this).attr('fill', 'url(#barchart_profitColor2)');
                                var n = $(this).attr('id').replace('barChart_profit', '');
                                $('#barChart_date' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'url(#barchart_profitColor1)');
                                var n = $(this).attr('id').replace('barChart_profit', '');
                                $('#barChart_date' + n).attr('fill', 'black');
                            }).click(function(e){
                            	var obj = $(this).parent().parent();
                                var n = $(this).attr('id').replace('barChart_profit', '');
                                var t_index = obj.data('info').curIndex;
                                var alerttxt='';
                                alerttxt+='損益總金額：'+FormatNumber(dec(obj.data('info').Data[t_index].detail[n].inmoney)-dec(obj.data('info').Data[t_index].detail[n].paymoney))+'\n';
                                alerttxt+='現金損益金額：'+FormatNumber(dec(obj.data('info').Data[t_index].detail[n].ainmoney)-dec(obj.data('info').Data[t_index].detail[n].apaymoney))+'\n';
                                alerttxt+='銀行存款損益金額：'+FormatNumber(dec(obj.data('info').Data[t_index].detail[n].binmoney)-dec(obj.data('info').Data[t_index].detail[n].bpaymoney))+'\n';
                                alerttxt+='應收票據損益金額：'+FormatNumber(dec(obj.data('info').Data[t_index].detail[n].cinmoney)-dec(obj.data('info').Data[t_index].detail[n].cpaymoney));
                            	alert(alerttxt);
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
           
          