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
				$('#btnSvg').val('圖形顯示');
				$('#pieChart').hide();
				$('#btnSvg').hide();
				$('#barChart').hide();
				$('#barChart2').hide();
				$(".control").hide();
				
				$('#q_report').click(function(e) {
					$('#btnSvg').hide();
					$('#pieChart').hide();
					$('#barChart').hide();
					$('#barChart2').hide();
					$('#dataSearch').show();
					$(".control").hide();
					
					for(var i =0 ;i<$('#q_report').data().info.reportData.length;i++){
						//if($(".select")[0].nextSibling.innerText==$('#q_report').data().info.reportData[i].reportName){
						if($('.radio.select').next().text()==$('#q_report').data().info.reportData[i].reportName){
							//下面註解取得q_lang的z_xxxxx
							txtreport=$('#q_report').data().info.reportData[i].report;
							if(txtreport=='z_anadc1' || txtreport=='z_anadc3' || txtreport=='z_anadc5' || txtreport=='z_anadc7')
								$('#btnSvg').val($('#q_report').data().info.reportData[i].reportName+'圓餅圖顯示');
							if(txtreport=='z_anadc6'||txtreport=='z_anadc8' || txtreport=='z_anadc9' ||txtreport=='z_anadc10' || txtreport=='z_anadc2' ||txtreport=='z_anadc4')
								$('#btnSvg').val($('#q_report').data().info.reportData[i].reportName+'長條圖顯示');
						}
					}
					if(txtreport=='z_anadc1' || txtreport=='z_anadc3' || txtreport=='z_anadc5' || txtreport=='z_anadc7'||txtreport=='z_anadc6'||txtreport=='z_anadc8'|| txtreport=='z_anadc9' ||txtreport=='z_anadc10' || txtreport=='z_anadc2' ||txtreport=='z_anadc4')
						$('#btnSvg').show();
				});
				$('#btnSvg').click(function(e) {
					/*if(txtreport=='z_anadc1' || txtreport=='z_anadc3' || txtreport=='z_anadc5' || txtreport=='z_anadc7')
						$('#pieChart').show();
					if(txtreport=='z_anadc6'||txtreport=='z_anadc8'|| txtreport=='z_anadc9' ||txtreport=='z_anadc10'){
						$('#barChart').show();
						$(".control").show();
					}*/
						
					$('#dataSearch').hide();
					
					//帶入參數
					var cust2a='#non',part2a='#non',sss2a='#non';
					if(!emp($('#txtCust2a').val()))
						cust2a=$('#txtCust2a').val();
					if(!emp($('#txtPart2a').val()))
						part2a=$('#txtPart2a').val();
					if(!emp($('#txtSss2a').val()))
						sss2a=$('#txtSss2a').val();
					q_func('qtxt.query','z_anadc.txt,'+txtreport+','+encodeURI(r_accy) + ';' + encodeURI($('#txtDate1').val()) + ';' + encodeURI($('#txtDate2').val()) + ';' + encodeURI($('#txtXmon').val()) + ';' + encodeURI($('#txtCust1a').val())+ ';' + encodeURI(cust2a)+ ';' + encodeURI($('#txtPart1a').val())+ ';' + encodeURI(part2a)+ ';' + encodeURI($('#txtSss1a').val())+ ';' + encodeURI(sss2a)+ ';' + encodeURI($('#txtXyear1').val())+ ';' + encodeURI($('#txtXyear2').val()));
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
					fileName : 'z_anadc',
					options : [ {
                            type : '6',
                            name : 'accy'
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
                        },{/*1*/
	                        type : '1',
	                        name : 'xyear'
						}, {
	                        type : '5', //select
	                        name : 'details',
	                        value : ('統計,明細').split(',')
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
	                $('#txtAccy').val(t_year);
	                $('#txtXyear1').val((dec(t_year)-1)>99?(dec(t_year)-1):'0'+(dec(t_year)-1));
	                $('#txtXyear2').val(t_year);
	                
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
                        //圓餅圖
                        if(txtreport=='z_anadc5' || txtreport=='z_anadc7'){
	                        //刪除負數的客戶或員工
	                        for (i = 0; i < as.length; i++) {
	                        	if(dec(as[i].total)<=0){
	                        	 	as.splice(i, 1);
	                             	i--;
	                            }
	                        }
	                        
	                        var pie=new Array();
	                        if (as[0] != undefined) {
	                        	for (i = 0; i < as.length; i++) {
	                        		if(txtreport=='z_anadc1'){
		                        		pie[i]={
		                        			text:as[i].comp,
		                        			total:as[i].total,
		                        			value:dec(as[i].total)
		                        		}
	                        		}else if(txtreport=='z_anadc3'){
		                        		pie[i]={
		                        			text:as[i].namea,
		                        			total:as[i].total,
		                        			value:dec(as[i].total)
		                        		}
	                        		}else if(txtreport=='z_anadc5'){
		                        		pie[i]={
		                        			text:as[i].comp,
		                        			money:as[i].money,
		                        			salarycost:as[i].salarycost,
		                        			partcost:as[i].partcost,
		                        			total:as[i].total,
		                        			value:dec(as[i].money)
		                        		}
	                        		}else if(txtreport=='z_anadc7'){
		                        		pie[i]={
		                        			text:as[i].namea,
		                        			money:as[i].money,
		                        			salary:as[i].salary,
		                        			partcost:as[i].partcost,
		                        			total:as[i].total,
		                        			value:dec(as[i].money)
		                        		}
	                        		}
	                        		color[i]=getRndColor();
	                        	}
	                        }
	                        
	                        $('#pieChart').pieChart({
								data : pie,
								x: 250,
								y: 250,
								radius: 200
							}); 
							$('#Loading').hide();
							$('#pieChart').show();
                        }
                        //長條圖(直)
                        var bar=new Array();
                        if(txtreport=='z_anadc6'||txtreport=='z_anadc8'){
                        	//var t_maxMoney=5000000,t_minMoney=-5000000;
	                        if (as[0] != undefined) {
	                        	for (i = 0; i < as.length; i++) {
		                        	var t_detail,x_maxmoney=0,x_minmoney=0;
		                        	t_detail = {
	                                        mon : '01',
	                                        money : as[i].money01,
	                                        salarycost : as[i].salarycost01,
	                                        partcost : as[i].partcost01,
	                                        total : as[i].total01
	                                };
	                                //判斷該客戶的最大值與最小值
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money01))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money01))
	                                
		                        	bar[i]={
			                        			custno:txtreport=='z_anadc6'?as[i].custno:as[i].sssno,
			                        			comp:txtreport=='z_anadc6'?as[i].comp:as[i].namea,
			                        			partno:as[i].partno,
			                        			part:as[i].pname,
			                        			detail : [t_detail],
			                        			maxmoney:0,
			                        			minmoney:0
			                        };
	                                t_detail = {
	                                        mon : '02',
	                                        money : as[i].money02,
	                                        salarycost : as[i].salarycost02,
	                                        partcost : as[i].partcost02,
	                                        total : as[i].total02
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money02))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money02))
	                                
	                                t_detail = {
	                                        mon : '03',
	                                        money : as[i].money03,
	                                        salarycost : as[i].salarycost03,
	                                        partcost : as[i].partcost03,
	                                        total : as[i].total03
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money03))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money03))
	                                
	                                t_detail = {
	                                        mon : '04',
	                                        money : as[i].money04,
	                                        salarycost : as[i].salarycost04,
	                                        partcost : as[i].partcost04,
	                                        total : as[i].total04
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money04))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money04))
	                                
	                                t_detail = {
	                                        mon : '05',
	                                        money : as[i].money05,
	                                        salarycost : as[i].salarycost05,
	                                        partcost : as[i].partcost05,
	                                        total : as[i].total05
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money05))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money05))
	                                
	                                t_detail = {
	                                        mon : '06',
	                                        money : as[i].money06,
	                                        salarycost : as[i].salarycost06,
	                                        partcost : as[i].partcost06,
	                                        total : as[i].total06
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money06))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money06))
	                                
	                                t_detail = {
	                                        mon : '07',
	                                        money : as[i].money07,
	                                        salarycost : as[i].salarycost07,
	                                        partcost : as[i].partcost07,
	                                        total : as[i].total07
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money07))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money07))
	                                
	                                t_detail = {
	                                        mon : '08',
	                                        money : as[i].money08,
	                                        salarycost : as[i].salarycost08,
	                                        partcost : as[i].partcost08,
	                                        total : as[i].total08
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money08))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money08))
	                                
	                                t_detail = {
	                                        mon : '09',
	                                        money : as[i].money09,
	                                        salarycost : as[i].salarycost09,
	                                        partcost : as[i].partcost09,
	                                        total : as[i].total09
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money09))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money09))
	                                
	                                t_detail = {
	                                        mon : '10',
	                                        money : as[i].money10,
	                                        salarycost : as[i].salarycost10,
	                                        partcost : as[i].partcost10,
	                                        total : as[i].total10
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money10))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money10))
	                                
	                                t_detail = {
	                                        mon : '11',
	                                        money : as[i].money11,
	                                        salarycost : as[i].salarycost11,
	                                        partcost : as[i].partcost11,
	                                        total : as[i].total11
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money11))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money11))
	                                
	                                t_detail = {
	                                        mon : '12',
	                                        money : as[i].money12,
	                                        salarycost : as[i].salarycost12,
	                                        partcost : as[i].partcost12,
	                                        total : as[i].total12
	                                };
	                                bar[i].detail.push(t_detail);
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money12))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money12))
									
									bar[i].maxmoney=x_maxmoney;
			                        bar[i].minmoney=x_minmoney;
			                   	}
	                        }
	                        $('#barChart').barChart({
								data : bar,
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
						
						if( txtreport=='z_anadc9' ||txtreport=='z_anadc10'){
							 if (as[0] != undefined) {
							 	var custno='';
							 	var n = -1;
							 	var x_maxmoney=0,x_minmoney=0;
	                        	for (i = 0; i < as.length; i++) {
	                        		var t_detail;
	                        		if(custno==''||custno!=(txtreport=='z_anadc9'?as[i].custno:as[i].sssno)){
	                        			x_maxmoney=0;
	                        			x_minmoney=0;
	                        		}
		                        	t_detail = {
	                                        mon : as[i].mon,
	                                        money01 : as[i].money01,
	                                        salarycost01 : as[i].salarycost01,
	                                        partcost01 : as[i].partcost01,
	                                        total01 : as[i].money01,
	                                        money02 : as[i].money02,
	                                        salarycost02 : as[i].salarycost02,
	                                        partcost02 : as[i].partcost02,
	                                        total02 : as[i].money02,
	                                        total03 : dec(as[i].money02)-dec(as[i].money01)
	                                };
	                                //判斷該客戶的最大值與最小值
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].money01),dec(as[i].money02),dec(as[i].money02)-dec(as[i].money01))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].money01),dec(as[i].money02),dec(as[i].money02)-dec(as[i].money01))
	                                if(custno==''||custno!=(txtreport=='z_anadc9'?as[i].custno:as[i].sssno)){
			                        	bar.push({
				                        			custno:txtreport=='z_anadc9'?as[i].custno:as[i].sssno,
				                        			comp:txtreport=='z_anadc9'?as[i].comp:as[i].namea,
				                        			xyear1:as[i].xyear1,
				                        			xyear2:as[i].xyear2,
				                        			partno:as[i].partno,
				                        			part:as[i].part,
				                        			detail : [t_detail],
				                        			maxmoney:x_maxmoney,
				                        			minmoney:x_minmoney
				                        });
				                        custno=(txtreport=='z_anadc9'?as[i].custno:as[i].sssno);
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
                        
                         //長條圖2(橫)
                         if( txtreport=='z_anadc2' ||txtreport=='z_anadc4'){
                         	if (as[0] == undefined) {
                            	$('#Loading').hide();
                            	alert('沒有資料!!');
                        	}else{
							 	var custno='';
							 	var n = -1;
							 	var x_maxmoney=0,x_minmoney=0;
	                        	for (i = 0; i < as.length; i++) {
	                                //判斷該客戶的最大值與最小值
	                                x_maxmoney=Math.max(x_maxmoney,dec(as[i].total))
	                                x_minmoney=Math.min(x_minmoney,dec(as[i].total))           
			                        bar.push({
				                        			custno:txtreport=='z_anadc2'?as[i].custno:as[i].sssno,
				                        			comp:txtreport=='z_anadc2'?as[i].comp:as[i].namea,
				                        			total:as[i].total
				                        });
	                        	}
	                        }
	                        $('#barChart2').barChart2({
								data : bar,
								maxMoney : x_maxmoney,
                                minMoney : x_minmoney
							});
							$('#txtCurPage').val(1).change(function(e) {
	                            $(this).val(parseInt($(this).val()));
	                        	$('#barChart2').data('info').page($('#barChart2'), $(this).val());
	                        });
	                        $('#txtTotPage').val(bar.length);
	                        $('#Loading').hide();
	                        $('#barChart2').show();
							//$(".control").show();
                         }
                        break;
                }
            }
            
            //設定色彩
            var color=new Array();
            
            function getRndColor(s){
				var getColor = function(){
					var r = Math.ceil((Math.random()*85)+170).toString(16);//亮色
					r = r.length==1?'0'+r:r;
					return r;
				}
				var color = (s==undefined)?'#':'';
				return(color + getColor() + getColor() + getColor());
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
                $.fn.pieChart = function(value) {
                    $(this).data('info', {
                        value : value,
                        fillColor : color,
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
                            var xbranch=0,ybranch=0;//分行
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
                                
                                if(i>14&&i%35==0){//分行
                                	xbranch+=120;
                                	ybranch=i;
                                }
                                
                                var pointLogo = [x + radius + 20+xbranch, (i-ybranch)* 20 + 30];
                                var pointText = [x + radius + 35+xbranch, (i-ybranch) * 20 + 40];
                                tmpPath += '<rect class="blockLogo" id="blockLogo_'+i+'" width="10" height="10" x="' + pointLogo[0] + '" y="' + pointLogo[1] + '" fill=' + fillColor + ' stroke=' + strokeColor + '/>';
                                tmpPath += '<text class="blockText" id="blockText_'+i+'" x="' + pointText[0] + '" y="' + pointText[1] + '" fill="#000000">' + obj.data('info').value.data[i].text + '</text>';
                                //tmpPath += '<path class="block" id="block_'+i+'" d="M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + ' 0 1 ' + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
                                if (degree != 360)
                                    tmpPath += '<path class="block" id="block_' + i + '" d="M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + (degree > 180 ? ' 1 1 ' : ' 0 1 ') + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
                                else
                                    tmpPath += '<circle class="block" id="block_' + i + '" cx="' + x + '" cy="' + y + '" r="' + radius + '" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
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
                            	if(txtreport=='z_anadc1' ||txtreport=='z_anadc3' )
                            		alert('客戶名稱：'+obj.data('info').value.data[$(this).data('info').index].text+'\n收入金額：'+obj.data('info').value.data[$(this).data('info').index].total+'\n所佔比例：'+round(dec(obj.data('info').value.data[$(this).data('info').index].rate)*100,2)+'%');
                            	else if(txtreport=='z_anadc5'){
                            		var txttmp='';
                            		txttmp='客戶名稱：'+obj.data('info').value.data[$(this).data('info').index].text+'\n';
                            		txttmp+='收入金額：'+obj.data('info').value.data[$(this).data('info').index].money+'\n'
                            		//txttmp+='薪資攤提：'+obj.data('info').value.data[$(this).data('info').index].salarycost+'\n'
                            		//txttmp+='費用攤提：'+obj.data('info').value.data[$(this).data('info').index].partcost+'\n'
                            		//txttmp+='損益：'+obj.data('info').value.data[$(this).data('info').index].total+'\n'
                            		txttmp+='所佔比例：'+round(dec(obj.data('info').value.data[$(this).data('info').index].rate)*100,2)+'%'
                            		alert(txttmp);
                            	}else if(txtreport=='z_anadc7'){
                            		var txttmp='';
                            		txttmp='客戶名稱：'+obj.data('info').value.data[$(this).data('info').index].text+'\n';
                            		txttmp+='收入金額：'+obj.data('info').value.data[$(this).data('info').index].money+'\n'
                            		//txttmp+='薪資：'+obj.data('info').value.data[$(this).data('info').index].salary+'\n'
                            		//txttmp+='費用攤提：'+obj.data('info').value.data[$(this).data('info').index].partcost+'\n'
                            		//txttmp+='損益：'+obj.data('info').value.data[$(this).data('info').index].total+'\n'
                            		txttmp+='所佔比例：'+round(dec(obj.data('info').value.data[$(this).data('info').index].rate)*100,2)+'%'
                            		alert(txttmp);
                            	}
                            });
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
                            tmpPath += '<text x="' + (450) + '" y="' + (20) + '" fill="black">【' + obj.data('info').Data[obj.data('info').curIndex].custno + '】' + obj.data('info').Data[obj.data('info').curIndex].comp +(txtreport=='z_anadc6'||txtreport=='z_anadc9'?'─'+obj.data('info').Data[obj.data('info').curIndex].part:'')+ '</text>';
                            tmpPath += '<text x="' + (70) + '" y="' + (20) + '" fill="black">金額</text>';
                            tmpPath += '<text x="' + (50 + t_width + 50) + '" y="' + (50 + t_height + 30) + '" fill="black">月份</text>';
                            
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
							
							if(txtreport=='z_anadc6'||txtreport=='z_anadc8'){
	                            //損益的顏色
	                            tmpPath += '<defs>' + '<linearGradient id="barchart_profitColor1" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
	                            tmpPath += '<defs>' + '<linearGradient id="barchart_profitColor2" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
	
	                            //損益
	                            /*for (var i = 0; i < t_detail.length; i++) {
	                                t_output = dec(t_detail[i].total);
	                                h = Math.abs(round(t_output / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0));
	                                x = 100 + 10 + t_n * i - (i == 0 ? 9 : 10);
	                                if(t_output >= 0){
	                                	y = t_Y - h;
	                                }else{
	                                	y = t_Y;
	                                }
	                                tmpPath += '<rect id="barChart_profit' + i + '" class="barChart_profit" x="' + x + '" y="' + y + '" width="' + t_n + '" height="' + h + '" fill="url(#barchart_profitColor1)"/>';
	                            }*/
	                            //收入
	                            for (var i = 0; i < t_detail.length; i++) {//連接線
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].money) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                if (i > 0)
	                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(255,0,0);stroke-width:1"/>';
	                                bx = x;
	                                by = y;
	                            }
	                            for (var i = 0; i < t_detail.length; i++) {
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].money) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                tmpPath += '<circle id="barChart_in' + i + '" class="barChart_in" class="" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
	                            }
	                            /*//費用攤提
	                            for (var i = 0; i < t_detail.length; i++) {//連接線
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].partcost) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                if (i > 0)
	                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(0,255,0);stroke-width:1"/>';
	                                bx = x;
	                                by = y;
	                            }
	                            for (var i = 0; i < t_detail.length; i++) {
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].partcost) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                tmpPath += '<circle id="barChart_out' + i + '" class="barChart_out" class="" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
	                                tmpPath += '<text id="barChart_mon' + i + '" class="barChart_mon" x="' + (x - 10) + '" y="' + (50 + t_height + 30) + '" fill="black">' + t_detail[i].mon + '</text>';
	                            }*/
	                            //薪資
	                            /*for (var i = 0; i < t_detail.length; i++) {//連接線
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].salarycost) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                if (i > 0)
	                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(255,255,0);stroke-width:1"/>';
	                                bx = x;
	                                by = y;
	                            }
	                            for (var i = 0; i < t_detail.length; i++) {
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].salarycost) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                tmpPath += '<circle id="barChart_salary' + i + '" class="barChart_salary" class="" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(255,255,0)"/>';
	                            }*/
	                            
	                            //符號說明
	                            //tmpPath += '<line x1="800" y1="50" x2="820" y2="50" style="stroke:rgb(0,0,0);stroke-width:1"/>';
	                            //tmpPath += '<circle class="" cx="810" cy="50" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
	                            //tmpPath += '<text x="830" y="55" fill="black">費用攤提</text>';
	
	                            tmpPath += '<line x1="800" y1="75" x2="820" y2="75" style="stroke:rgb(0,0,0);stroke-width:1"/>';
	                            tmpPath += '<circle class="" cx="810" cy="75" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
	                            tmpPath += '<text x="830" y="80" fill="black">收入</text>';
	                            
	                            /*tmpPath += '<line x1="800" y1="100" x2="820" y2="100" style="stroke:rgb(0,0,0);stroke-width:1"/>';
	                            tmpPath += '<circle class="" cx="810" cy="100" r="5" stroke="black" stroke-width="2" fill="rgb(255,255,0)"/>';
	                            if(txtreport=='z_anadc6')
	                            	tmpPath += '<text x="830" y="105" fill="black">薪資攤提</text>';
	                            else if(txtreport=='z_anadc8')
	                            	tmpPath += '<text x="830" y="105" fill="black">薪資</text>';
	                            	
	                            tmpPath += '<rect x="800" y="115" width="20" height="20" fill="url(#barchart_profitColor1)"/>';
	                            tmpPath += '<text x="830" y="130" fill="black">損益</text>';*/
	
	                            obj.html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
	                            //事件
	                            obj.children('svg').find('.barChart_in').hover(function(e) {
	                                $(this).attr('fill', 'rgb(255,151,151)');
	                                var n = $(this).attr('id').replace('barChart_in', '');
	                                $('#barChart_mon' + n).attr('fill', 'rgb(187,94,0)');
	                            }, function(e) {
	                                $(this).attr('fill', 'rgb(255,0,0)');
	                                var n = $(this).attr('id').replace('barChart_in', '');
	                                $('#barChart_mon' + n).attr('fill', 'black');
	                            }).click(function(e){
	                            	var obj = $(this).parent().parent();
	                                var n = $(this).attr('id').replace('barChart_in', '');
	                                var t_index = obj.data('info').curIndex;
	                                var alerttxt='';
	                                if(txtreport=='z_anadc6')
	                                	alerttxt='客戶名稱：'+obj.data('info').Data[t_index].comp+'\n'
	                                else if(txtreport=='z_anadc8')
	                                	alerttxt='員工名稱：'+obj.data('info').Data[t_index].comp+'\n'
	                                alerttxt+='收入金額：'+obj.data('info').Data[t_index].detail[n].money
	                            	alert(alerttxt);
	                            });
	                            
	                            obj.children('svg').find('.barChart_out').hover(function(e) {
	                                $(this).attr('fill', 'rgb(255,151,151)');
	                                var n = $(this).attr('id').replace('barChart_out', '');
	                                $('#barChart_mon' + n).attr('fill', 'rgb(187,94,0)');
	                            }, function(e) {
	                                $(this).attr('fill', 'rgb(0,255,0)');
	                                var n = $(this).attr('id').replace('barChart_out', '');
	                                $('#barChart_mon' + n).attr('fill', 'black');
	                            }).click(function(e){
	                            	var obj = $(this).parent().parent();
	                                var n = $(this).attr('id').replace('barChart_out', '');
	                                var t_index = obj.data('info').curIndex;
	                                var alerttxt='';
	                               	if(txtreport=='z_anadc6')
	                                	alerttxt='客戶名稱：'+obj.data('info').Data[t_index].comp+'\n'
	                                else if(txtreport=='z_anadc8')
	                                	alerttxt='員工名稱：'+obj.data('info').Data[t_index].comp+'\n'
	                                //alerttxt+='費用攤提金額：'+obj.data('info').Data[t_index].detail[n].partcost
	                            	alert(alerttxt);
	                            });
	                            
	                            obj.children('svg').find('.barChart_salary').hover(function(e) {
	                                $(this).attr('fill', 'rgb(255,151,151)');
	                                var n = $(this).attr('id').replace('barChart_salary', '');
	                                $('#barChart_mon' + n).attr('fill', 'rgb(187,94,0)');
	                            }, function(e) {
	                                $(this).attr('fill', 'rgb(255,255,0)');
	                                var n = $(this).attr('id').replace('barChart_salary', '');
	                                $('#barChart_mon' + n).attr('fill', 'black');
	                            }).click(function(e){
	                            	var obj = $(this).parent().parent();
	                                var n = $(this).attr('id').replace('barChart_salary', '');
	                                var t_index = obj.data('info').curIndex;
	                                var alerttxt='';
	                               	if(txtreport=='z_anadc6'){
	                                	alerttxt='客戶名稱：'+obj.data('info').Data[t_index].comp+'\n'
	                                	alerttxt+='薪資攤提：'+obj.data('info').Data[t_index].detail[n].salarycost+'\n'
	                                }else if(txtreport=='z_anadc8'){
	                                	alerttxt='員工名稱：'+obj.data('info').Data[t_index].comp+'\n'
	                                	alerttxt+='薪資：'+obj.data('info').Data[t_index].detail[n].salarycost+'\n'
	                                }
	                            	alert(alerttxt);
	                            });
	                            
	                            obj.children('svg').find('.barChart_profit').hover(function(e) {
	                                $(this).attr('fill', 'url(#barchart_profitColor2)');
	                                var n = $(this).attr('id').replace('barChart_profit', '');
	                                $('#barChart_mon' + n).attr('fill', 'rgb(187,94,0)');
	                            }, function(e) {
	                                $(this).attr('fill', 'url(#barchart_profitColor1)');
	                                var n = $(this).attr('id').replace('barChart_profit', '');
	                                $('#barChart_mon' + n).attr('fill', 'black');
	                            }).click(function(e){
	                            	var obj = $(this).parent().parent();
	                                var n = $(this).attr('id').replace('barChart_profit', '');
	                                var t_index = obj.data('info').curIndex;
	                                var alerttxt='';
	                                if(txtreport=='z_anadc6')
	                                	alerttxt='客戶名稱：'+obj.data('info').Data[t_index].comp+'\n'
	                                else if(txtreport=='z_anadc8')
	                                	alerttxt='員工名稱：'+obj.data('info').Data[t_index].comp+'\n'
	                                alerttxt+='收入：'+obj.data('info').Data[t_index].detail[n].money+'\n'
	                                alerttxt+=(txtreport=='z_anadc6'?'薪資攤提：':'薪資：')+obj.data('info').Data[t_index].detail[n].salarycost+'\n'
	                                //alerttxt+='費用攤提：'+obj.data('info').Data[t_index].detail[n].partcost+'\n'
	                                alerttxt+='損益：'+obj.data('info').Data[t_index].detail[n].total
	                            	alert(alerttxt);
	                            });
							}else if(txtreport=='z_anadc9'||txtreport=='z_anadc10'){
								//損益相差的顏色
	                            tmpPath += '<defs>' + '<linearGradient id="barchart_profitColor1" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
	                            tmpPath += '<defs>' + '<linearGradient id="barchart_profitColor2" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
								//損益相差
	                            for (var i = 0; i < t_detail.length; i++) {
	                                t_output = dec(t_detail[i].total03);
	                                h = Math.abs(round(t_output / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0));
	                                x = 100 + 10 + t_n * i - (i == 0 ? 9 : 10);
	                                if(t_output >= 0){
	                                	y = t_Y - h;
	                                }else{
	                                	y = t_Y;
	                                }
	                                tmpPath += '<rect id="barChart_profit' + i + '" class="barChart_profit" x="' + x + '" y="' + y + '" width="' + t_n + '" height="' + h + '" fill="url(#barchart_profitColor1)"/>';
	                            }
								
								//第一年
	                            for (var i = 0; i < t_detail.length; i++) {//連接線
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].total01) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                if (i > 0)
	                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(0,255,0);stroke-width:1"/>';
	                                bx = x;
	                                by = y;
	                            }
	                            for (var i = 0; i < t_detail.length; i++) {
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].total01) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                tmpPath += '<circle id="barChart_out' + i + '" class="barChart_out" class="" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
	                                tmpPath += '<text id="barChart_mon' + i + '" class="barChart_mon" x="' + (x - 10) + '" y="' + (50 + t_height + 30) + '" fill="black">' + t_detail[i].mon + '</text>';
	                            }
	                            //第二年
	                            for (var i = 0; i < t_detail.length; i++) {//連接線
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].total02) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                if (i > 0)
	                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(255,0,0);stroke-width:1"/>';
	                                bx = x;
	                                by = y;
	                            }
	                            for (var i = 0; i < t_detail.length; i++) {
	                                x = 100 + 10 + t_n * i;
	                                y = t_Y - round(dec(t_detail[i].total02) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
	                                tmpPath += '<circle id="barChart_in' + i + '" class="barChart_in" class="" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
	                            }
	                            
	                            //符號說明
	                            tmpPath += '<rect x="800" y="90" width="20" height="20" fill="url(#barchart_profitColor1)"/>';
	                            tmpPath += '<text x="830" y="105" fill="black">損益相差</text>';
	                            
	                            tmpPath += '<line x1="800" y1="50" x2="820" y2="50" style="stroke:rgb(0,0,0);stroke-width:1"/>';
	                            tmpPath += '<circle class="" cx="810" cy="50" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
	                            tmpPath += '<text x="830" y="55" fill="black">'+obj.data('info').Data[obj.data('info').curIndex].xyear1+'年</text>';
	
	                            tmpPath += '<line x1="800" y1="75" x2="820" y2="75" style="stroke:rgb(0,0,0);stroke-width:1"/>';
	                            tmpPath += '<circle class="" cx="810" cy="75" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
	                            tmpPath += '<text x="830" y="80" fill="black">'+obj.data('info').Data[obj.data('info').curIndex].xyear2+'年</text>';
	                            
	                            obj.html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
	                            //事件
	                            obj.children('svg').find('.barChart_out').hover(function(e) {
	                                $(this).attr('fill', 'rgb(255,151,151)');
	                                var n = $(this).attr('id').replace('barChart_out', '');
	                                $('#barChart_mon' + n).attr('fill', 'rgb(187,94,0)');
	                            }, function(e) {
	                                $(this).attr('fill', 'rgb(0,255,0)');
	                                var n = $(this).attr('id').replace('barChart_out', '');
	                                $('#barChart_mon' + n).attr('fill', 'black');
	                            }).click(function(e){
	                            	var obj = $(this).parent().parent();
	                                var n = $(this).attr('id').replace('barChart_out', '');
	                                var t_index = obj.data('info').curIndex;
	                                var alerttxt='';
	                               	if(txtreport=='z_anadc9'){
	                                	alerttxt='收入：'+obj.data('info').Data[t_index].detail[n].money01+'\n'
	                                	//alerttxt+='費用攤提：'+obj.data('info').Data[t_index].detail[n].partcost01+'\n'
	                                	//alerttxt+='薪資攤提：'+obj.data('info').Data[t_index].detail[n].salarycost01+'\n'
	                                	//alerttxt+='損益：'+obj.data('info').Data[t_index].detail[n].total01
	                                }
	                                else if(txtreport=='z_anadc10'){
	                                	alerttxt='收入：'+obj.data('info').Data[t_index].detail[n].money01+'\n'
	                                	//alerttxt+='費用攤提：'+obj.data('info').Data[t_index].detail[n].partcost01+'\n'
	                                	//alerttxt+='薪資：'+obj.data('info').Data[t_index].detail[n].salarycost01+'\n'
	                                	//alerttxt+='損益：'+obj.data('info').Data[t_index].detail[n].total01
	                                }
	                            	alert(alerttxt);
	                            });
	                            
	                            obj.children('svg').find('.barChart_in').hover(function(e) {
	                                $(this).attr('fill', 'rgb(255,151,151)');
	                                var n = $(this).attr('id').replace('barChart_in', '');
	                                $('#barChart_mon' + n).attr('fill', 'rgb(187,94,0)');
	                            }, function(e) {
	                                $(this).attr('fill', 'rgb(255,0,0)');
	                                var n = $(this).attr('id').replace('barChart_in', '');
	                                $('#barChart_mon' + n).attr('fill', 'black');
	                            }).click(function(e){
	                            	var obj = $(this).parent().parent();
	                                var n = $(this).attr('id').replace('barChart_in', '');
	                                var t_index = obj.data('info').curIndex;
	                                var alerttxt='';
	                                if(txtreport=='z_anadc9'){
	                                	alerttxt='收入：'+obj.data('info').Data[t_index].detail[n].money02+'\n'
	                                	//alerttxt+='費用攤提：'+obj.data('info').Data[t_index].detail[n].partcost02+'\n'
	                                	//alerttxt+='薪資攤提：'+obj.data('info').Data[t_index].detail[n].salarycost02+'\n'
	                                	//alerttxt+='損益：'+obj.data('info').Data[t_index].detail[n].total02
	                                }
	                                else if(txtreport=='z_anadc10'){
	                                	alerttxt='收入：'+obj.data('info').Data[t_index].detail[n].money02+'\n'
	                                	//alerttxt+='費用攤提：'+obj.data('info').Data[t_index].detail[n].partcost02+'\n'
	                                	//alerttxt+='薪資：'+obj.data('info').Data[t_index].detail[n].salarycost02+'\n'
	                                	//alerttxt+='損益：'+obj.data('info').Data[t_index].detail[n].total02
	                                }
	                            	alert(alerttxt);
	                            });
	                            
	                            obj.children('svg').find('.barChart_profit').hover(function(e) {
	                                $(this).attr('fill', 'url(#barchart_profitColor2)');
	                                var n = $(this).attr('id').replace('barChart_profit', '');
	                                $('#barChart_mon' + n).attr('fill', 'rgb(187,94,0)');
	                            }, function(e) {
	                                $(this).attr('fill', 'url(#barchart_profitColor1)');
	                                var n = $(this).attr('id').replace('barChart_profit', '');
	                                $('#barChart_mon' + n).attr('fill', 'black');
	                            }).click(function(e){
	                            	var obj = $(this).parent().parent();
	                                var n = $(this).attr('id').replace('barChart_profit', '');
	                                var t_index = obj.data('info').curIndex;
	                                var alerttxt='';
	                                alerttxt=obj.data('info').Data[obj.data('info').curIndex].xyear1+'年損益：'+obj.data('info').Data[t_index].detail[n].total01+'\n'
	                                alerttxt+=obj.data('info').Data[obj.data('info').curIndex].xyear2+'年損益：'+obj.data('info').Data[t_index].detail[n].total02+'\n'
	                                alerttxt+='損益相差：'+obj.data('info').Data[t_index].detail[n].total03
	                            	alert(alerttxt);
	                            });
							}//end txtreport=='z_anadc9'||txtreport=='z_anadc10'
                        }
                    });
                    $(this).data('info').init($(this));
                }
            	$.fn.barChart2 = function(value) {
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
                            	//毛利
                            	/*t_output = t_detail[i].profit;
                                W = Math.abs(round(t_output / (t_maxMoney - t_minMoney) * t_width, 0));
                                if(t_output>0){
                                	x = t_X;
                                }else{
                                	x = t_X - W;
                                }                          
 								y = strY + i*40 + 20;
                                tmpPath += '<rect class="chart2_item" id="chart2_profit' + i + '" x="' + x + '" y="' + y + '" width="' + W + '" height="' + 15 + '" fill="url(#chart2_color3)"/>';
                           		tmpPath += '<text class="chart2_item" id="chart2_cprofit'+i+'" x="'+(x+W + 5)+'" y="'+(y+15)+'" fill="#000000" >'+FormatNumber(t_output)+'</text>';	
                            	
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
                            tmpPath += '<rect x="'+(strX+t_width+50)+'" y="5" width="20" height="20" fill="url(#chart2_color1)"/>';
                            tmpPath += '<text x="'+(strX+t_width+70)+'" y="20" fill="black">收入</text>';
							/*tmpPath += '<rect x="'+(strX+t_width+50)+'" y="30" width="20" height="20" fill="url(#chart2_color3)"/>';
                            tmpPath += '<text x="'+(strX+t_width+70)+'" y="45" fill="black">毛利</text>';*/
							
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
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div id="svgbet">
				<input id="btnSvg" type="button" />
			</div>
			<div id='Loading'> </div>
			<div id='pieChart'> </div>
			<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			<div id='barChart'></div>
			<div id='barChart2'></div>
			<div id='dataSearch' class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

