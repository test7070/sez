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
				$(".control").hide();
				
				$('#q_report').click(function(e) {
					$('#btnSvg').hide();
					$('#pieChart').hide();
					$('#barChart').hide();
					$('#dataSearch').show();
					$(".control").hide();
					for(var i =0 ;i<$('#q_report').data().info.reportData.length;i++){
						if($(".select")[0].nextElementSibling.innerText==$('#q_report').data().info.reportData[i].reportName){
							$('#btnSvg').val($('#q_report').data().info.reportData[i].reportName+'圖形顯示');
							//下面註解取得z_xxxxx
							txtreport=$('#q_report').data().info.reportData[i].report;
						}
					}
					if(txtreport=='z_anadc1' || txtreport=='z_anadc3' || txtreport=='z_anadc5' || txtreport=='z_anadc7')
						$('#btnSvg').show();
					if(txtreport=='z_anadc6')
						$('#btnSvg').show();
				});
				$('#btnSvg').click(function(e) {
					if(txtreport=='z_anadc1' || txtreport=='z_anadc3' || txtreport=='z_anadc5' || txtreport=='z_anadc7')
						$('#pieChart').show();
					if(txtreport=='z_anadc6'){
						$('#barChart').show();
						$(".control").show();
					}
						
					$('#dataSearch').hide();
					
					//帶入參數
					var cust2a='#non',part2a='#non',sss2a='#non';
					if(!emp($('#txtCust2a').val()))
						cust2a=$('#txtCust2a').val();
					if(!emp($('#txtPart2a').val()))
						part2a=$('#txtPart2a').val();
					if(!emp($('#txtSss2a').val()))
						sss2a=$('#txtSss2a').val();
					q_func('qtxt.query','z_anadc.txt,'+txtreport+','+encodeURI(r_accy) + ';' + encodeURI($('#txtDate1').val()) + ';' + encodeURI($('#txtDate2').val()) + ';' + encodeURI($('#txtXmon').val()) + ';' + encodeURI($('#txtCust1a').val())+ ';' + encodeURI(cust2a)+ ';' + encodeURI($('#txtPart1a').val())+ ';' + encodeURI(part2a)+ ';' + encodeURI($('#txtSss1a').val())+ ';' + encodeURI(sss2a));
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
                        //圓餅圖
                        if(txtreport=='z_anadc1' || txtreport=='z_anadc3' || txtreport=='z_anadc5' || txtreport=='z_anadc7'){
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
		                        			value:dec(as[i].total)
		                        		}
	                        		}else if(txtreport=='z_anadc7'){
		                        		pie[i]={
		                        			text:as[i].namea,
		                        			money:as[i].money,
		                        			salary:as[i].salary,
		                        			partcost:as[i].partcost,
		                        			total:as[i].total,
		                        			value:dec(as[i].total)
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
                        }
                        //長條圖
                        if(txtreport=='z_anadc6'){
                        	var bar=new Array();
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
	                                if(x_maxmoney<dec(as[i].money01)){x_maxmoney=dec(as[i].money01)}
	                                if(x_maxmoney<dec(as[i].partcost01)){x_maxmoney=dec(as[i].partcost01)}
	                                if(x_maxmoney<dec(as[i].total01)){x_maxmoney=dec(as[i].total01)}
	                                if(x_minmoney>dec(as[i].money01)){x_minmoney=dec(as[i].money01)}
	                                if(x_minmoney>dec(as[i].partcost01)){x_minmoney=dec(as[i].partcost01)}
	                                if(x_minmoney>dec(as[i].total01)){x_minmoney=dec(as[i].total01)}
	                                
		                        	bar[i]={
			                        			custno:as[i].custno,
			                        			comp:as[i].comp,
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
	                                if(x_maxmoney<dec(as[i].money02)){x_maxmoney=dec(as[i].money02)}
	                                if(x_maxmoney<dec(as[i].partcost02)){x_maxmoney=dec(as[i].partcost02)}
	                                if(x_maxmoney<dec(as[i].total02)){x_maxmoney=dec(as[i].total02)}
	                                if(x_minmoney>dec(as[i].money02)){x_minmoney=dec(as[i].money02)}
	                                if(x_minmoney>dec(as[i].partcost02)){x_minmoney=dec(as[i].partcost02)}
	                                if(x_minmoney>dec(as[i].total02)){x_minmoney=dec(as[i].total02)}
	                                
	                                t_detail = {
	                                        mon : '03',
	                                        money : as[i].money03,
	                                        salarycost : as[i].salarycost03,
	                                        partcost : as[i].partcost03,
	                                        total : as[i].total03
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money03)){x_maxmoney=dec(as[i].money03)}
	                                if(x_maxmoney<dec(as[i].partcost03)){x_maxmoney=dec(as[i].partcost03)}
	                                if(x_maxmoney<dec(as[i].total03)){x_maxmoney=dec(as[i].total03)}
	                                if(x_minmoney>dec(as[i].money03)){x_minmoney=dec(as[i].money03)}
	                                if(x_minmoney>dec(as[i].partcost03)){x_minmoney=dec(as[i].partcost03)}
	                                if(x_minmoney>dec(as[i].total03)){x_minmoney=dec(as[i].total03)}
	                                
	                                t_detail = {
	                                        mon : '04',
	                                        money : as[i].money04,
	                                        salarycost : as[i].salarycost04,
	                                        partcost : as[i].partcost04,
	                                        total : as[i].total04
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money04)){x_maxmoney=dec(as[i].money04)}
	                                if(x_maxmoney<dec(as[i].partcost04)){x_maxmoney=dec(as[i].partcost04)}
	                                if(x_maxmoney<dec(as[i].total04)){x_maxmoney=dec(as[i].total04)}
	                                if(x_minmoney>dec(as[i].money04)){x_minmoney=dec(as[i].money04)}
	                                if(x_minmoney>dec(as[i].partcost04)){x_minmoney=dec(as[i].partcost04)}
	                                if(x_minmoney>dec(as[i].total04)){x_minmoney=dec(as[i].total04)}
	                                
	                                t_detail = {
	                                        mon : '05',
	                                        money : as[i].money05,
	                                        salarycost : as[i].salarycost05,
	                                        partcost : as[i].partcost05,
	                                        total : as[i].total05
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money05)){x_maxmoney=dec(as[i].money05)}
	                                if(x_maxmoney<dec(as[i].partcost05)){x_maxmoney=dec(as[i].partcost05)}
	                                if(x_maxmoney<dec(as[i].total05)){x_maxmoney=dec(as[i].total05)}
	                                if(x_minmoney>dec(as[i].money05)){x_minmoney=dec(as[i].money05)}
	                                if(x_minmoney>dec(as[i].partcost05)){x_minmoney=dec(as[i].partcost05)}
	                                if(x_minmoney>dec(as[i].total05)){x_minmoney=dec(as[i].total05)}
	                                
	                                t_detail = {
	                                        mon : '06',
	                                        money : as[i].money06,
	                                        salarycost : as[i].salarycost06,
	                                        partcost : as[i].partcost06,
	                                        total : as[i].total06
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money06)){x_maxmoney=dec(as[i].money06)}
	                                if(x_maxmoney<dec(as[i].partcost06)){x_maxmoney=dec(as[i].partcost06)}
	                                if(x_maxmoney<dec(as[i].total06)){x_maxmoney=dec(as[i].total06)}
	                                if(x_minmoney>dec(as[i].money06)){x_minmoney=dec(as[i].money06)}
	                                if(x_minmoney>dec(as[i].partcost06)){x_minmoney=dec(as[i].partcost06)}
	                                if(x_minmoney>dec(as[i].total06)){x_minmoney=dec(as[i].total06)}
	                                
	                                t_detail = {
	                                        mon : '07',
	                                        money : as[i].money07,
	                                        salarycost : as[i].salarycost07,
	                                        partcost : as[i].partcost07,
	                                        total : as[i].total07
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money07)){x_maxmoney=dec(as[i].money07)}
	                                if(x_maxmoney<dec(as[i].partcost07)){x_maxmoney=dec(as[i].partcost07)}
	                                if(x_maxmoney<dec(as[i].total07)){x_maxmoney=dec(as[i].total07)}
	                                if(x_minmoney>dec(as[i].money07)){x_minmoney=dec(as[i].money07)}
	                                if(x_minmoney>dec(as[i].partcost07)){x_minmoney=dec(as[i].partcost07)}
	                                if(x_minmoney>dec(as[i].total07)){x_minmoney=dec(as[i].total07)}
	                                
	                                t_detail = {
	                                        mon : '08',
	                                        money : as[i].money08,
	                                        salarycost : as[i].salarycost08,
	                                        partcost : as[i].partcost08,
	                                        total : as[i].total08
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money08)){x_maxmoney=dec(as[i].money08)}
	                                if(x_maxmoney<dec(as[i].partcost08)){x_maxmoney=dec(as[i].partcost08)}
	                                if(x_maxmoney<dec(as[i].total08)){x_maxmoney=dec(as[i].total08)}
	                                if(x_minmoney>dec(as[i].money08)){x_minmoney=dec(as[i].money08)}
	                                if(x_minmoney>dec(as[i].partcost08)){x_minmoney=dec(as[i].partcost08)}
	                                if(x_minmoney>dec(as[i].total08)){x_minmoney=dec(as[i].total08)}
	                                
	                                t_detail = {
	                                        mon : '09',
	                                        money : as[i].money09,
	                                        salarycost : as[i].salarycost09,
	                                        partcost : as[i].partcost09,
	                                        total : as[i].total09
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money09)){x_maxmoney=dec(as[i].money09)}
	                                if(x_maxmoney<dec(as[i].partcost09)){x_maxmoney=dec(as[i].partcost09)}
	                                if(x_maxmoney<dec(as[i].total09)){x_maxmoney=dec(as[i].total09)}
	                                if(x_minmoney>dec(as[i].money09)){x_minmoney=dec(as[i].money09)}
	                                if(x_minmoney>dec(as[i].partcost09)){x_minmoney=dec(as[i].partcost09)}
	                                if(x_minmoney>dec(as[i].total09)){x_minmoney=dec(as[i].total09)}
	                                
	                                t_detail = {
	                                        mon : '10',
	                                        money : as[i].money10,
	                                        salarycost : as[i].salarycost10,
	                                        partcost : as[i].partcost10,
	                                        total : as[i].total10
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money10)){x_maxmoney=dec(as[i].money10)}
	                                if(x_maxmoney<dec(as[i].partcost10)){x_maxmoney=dec(as[i].partcost10)}
	                                if(x_maxmoney<dec(as[i].total10)){x_maxmoney=dec(as[i].total10)}
	                                if(x_minmoney>dec(as[i].money10)){x_minmoney=dec(as[i].money10)}
	                                if(x_minmoney>dec(as[i].partcost10)){x_minmoney=dec(as[i].partcost10)}
	                                if(x_minmoney>dec(as[i].total10)){x_minmoney=dec(as[i].total10)}
	                                
	                                t_detail = {
	                                        mon : '11',
	                                        money : as[i].money11,
	                                        salarycost : as[i].salarycost11,
	                                        partcost : as[i].partcost11,
	                                        total : as[i].total11
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money11)){x_maxmoney=dec(as[i].money11)}
	                                if(x_maxmoney<dec(as[i].partcost11)){x_maxmoney=dec(as[i].partcost11)}
	                                if(x_maxmoney<dec(as[i].total11)){x_maxmoney=dec(as[i].total11)}
	                                if(x_minmoney>dec(as[i].money11)){x_minmoney=dec(as[i].money11)}
	                                if(x_minmoney>dec(as[i].partcost11)){x_minmoney=dec(as[i].partcost11)}
	                                if(x_minmoney>dec(as[i].total11)){x_minmoney=dec(as[i].total11)}
	                                
	                                t_detail = {
	                                        mon : '12',
	                                        money : as[i].money12,
	                                        salarycost : as[i].salarycost12,
	                                        partcost : as[i].partcost12,
	                                        total : as[i].total12
	                                };
	                                bar[i].detail.push(t_detail);
	                                if(x_maxmoney<dec(as[i].money12)){x_maxmoney=dec(as[i].money12)}
	                                if(x_maxmoney<dec(as[i].partcost12)){x_maxmoney=dec(as[i].partcost12)}
	                                if(x_maxmoney<dec(as[i].total12)){x_maxmoney=dec(as[i].total12)}
	                                if(x_minmoney>dec(as[i].money12)){x_minmoney=dec(as[i].money12)}
	                                if(x_minmoney>dec(as[i].partcost12)){x_minmoney=dec(as[i].partcost12)}
	                                if(x_minmoney>dec(as[i].total12)){x_minmoney=dec(as[i].total12)}
									
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
                            	if(txtreport=='z_anadc1' ||txtreport=='z_anadc3' )
                            		alert('客戶名稱：'+obj.data('info').value.data[$(this).data('info').index].text+'\n收入金額：'+obj.data('info').value.data[$(this).data('info').index].total+'\n所佔比例：'+round(dec(obj.data('info').value.data[$(this).data('info').index].rate)*100,2)+'%');
                            	else if(txtreport=='z_anadc5'){
                            		var txttmp='';
                            		txttmp='客戶名稱：'+obj.data('info').value.data[$(this).data('info').index].text+'\n';
                            		txttmp+='收入金額：'+obj.data('info').value.data[$(this).data('info').index].money+'\n'
                            		txttmp+='薪資攤提：'+obj.data('info').value.data[$(this).data('info').index].salarycost+'\n'
                            		txttmp+='費用攤提：'+obj.data('info').value.data[$(this).data('info').index].partcost+'\n'
                            		txttmp+='損益：'+obj.data('info').value.data[$(this).data('info').index].total+'\n'
                            		txttmp+='所佔比例：'+round(dec(obj.data('info').value.data[$(this).data('info').index].rate)*100,2)+'%'
                            		alert(txttmp);
                            	}else if(txtreport=='z_anadc7'){
                            		var txttmp='';
                            		txttmp='客戶名稱：'+obj.data('info').value.data[$(this).data('info').index].text+'\n';
                            		txttmp+='收入金額：'+obj.data('info').value.data[$(this).data('info').index].money+'\n'
                            		txttmp+='薪資：'+obj.data('info').value.data[$(this).data('info').index].salary+'\n'
                            		txttmp+='費用攤提：'+obj.data('info').value.data[$(this).data('info').index].partcost+'\n'
                            		txttmp+='損益：'+obj.data('info').value.data[$(this).data('info').index].total+'\n'
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
                            var t_minMoney = obj.data('info').Data[obj.data('info').curIndex].minmoney;
                            var t_cmaxMoney = FormatNumber(t_maxMoney);
                            t_cmaxMoney = (t_cmaxMoney).replace(/ /g,'&nbsp;');
							var t_cminMoney = FormatNumber(t_minMoney);
							t_cminMoney = (t_cminMoney).replace(/ /g,'&nbsp;');
							var t_n = round((t_width - 20) / t_detail.length, 0);
                            var x, y, w, h, bx, by, t_output, t_money;
                            tmpPath += '<text x="' + (500) + '" y="' + (20) + '" fill="black">【' + obj.data('info').Data[obj.data('info').curIndex].custno + '】' + obj.data('info').Data[obj.data('info').curIndex].comp + '</text>';
                            tmpPath += '<text x="' + (70) + '" y="' + (20) + '" fill="black">金額</text>';
                            tmpPath += '<text x="' + (50 + t_width + 50) + '" y="' + (50 + t_height + 30) + '" fill="black">月份</text>';
                            
							x = 50;
							
							var t_Y = 50 + t_height - round((0+Math.abs(t_minMoney)) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
							
                            tmpPath += '<line x1="95" y1="' + t_Y + '" x2="100" y2="' + t_Y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                           	tmpPath += '<text x="' + x + '" y="' + t_Y + '" fill="black" style="font-family: \'Times New Roman\';">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0</text>';
                           	//X軸
                            tmpPath += '<line x1="100" y1="' + (t_Y) + '" x2="' + (100 + t_width) + '" y2="' + (t_Y) + '" style="stroke:rgb(0,0,0);stroke-width:1"/>';
                            
                            //Y
                            tmpPath += '<text x="30" y="' + (50) + '" fill="black" style="font-family: \'Times New Roman\';">' + t_cmaxMoney + '</text>';
                            tmpPath += '<line x1="95" y1="50" x2="100" y2="50" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text x="30" y="' + (50+t_height) + '" fill="black" style="font-family: \'Times New Roman\';">' + t_cminMoney + '</text>';
                            tmpPath += '<line x1="95" y1="' + (50+t_height) + '" x2="100" y2="' + (50+t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            
                            var x_money=round(((t_maxMoney+Math.abs(t_minMoney))/10),0);
                            x_money=dec(x_money.toString().substr(0,1))*Math.pow(10,(x_money).toString().length-1);
                            
                            t_money = x_money;
                            while (t_money < t_maxMoney) {
                            	t_cmoney = FormatNumber(t_money);
                            	t_cmoney = (t_cmoney).replace(/ /g,'&nbsp;');
                                x = 30;
                                y = t_Y - round(t_money/ (t_maxMoney+Math.abs(t_minMoney))* t_height, 0);
                                tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                                tmpPath += '<text x="' + x + '" y="' + y + '" fill="black" style="font-family: \'Times New Roman\';">' + t_cmoney + '</text>';
                                t_money += x_money;
                            }
                            t_money = -x_money;
                            while (t_money > t_minMoney) {
                            	t_cmoney = FormatNumber(t_money);
                            	t_cmoney = (t_cmoney).replace(/ /g,'&nbsp;');
                                x = 30;
                                y = t_Y - round(t_money/ (t_maxMoney+Math.abs(t_minMoney))* t_height, 0);
                                tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                                tmpPath += '<text x="' + x + '" y="' + y + '" fill="black" style="font-family: \'Times New Roman\';">' + t_cmoney + '</text>';
                                t_money -= x_money;
                            }

                            //損益的顏色
                            tmpPath += '<defs>' + '<linearGradient id="chart01_outColor1" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart01_outColor2" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';

                            //損益
                            for (var i = 0; i < t_detail.length; i++) {
                                t_output = dec(t_detail[i].total);
                                h = Math.abs(round(t_output / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0));
                                x = 100 + 10 + t_n * i - (i == 0 ? 9 : 10);
                                if(t_output >= 0){
                                	y = t_Y - h;
                                }else{
                                	y = t_Y;
                                }
                                tmpPath += '<rect id="chart01_out' + i + '" class="chart01_out" x="' + x + '" y="' + y + '" width="' + t_n + '" height="' + h + '" fill="url(#chart01_outColor1)"/>';
                            }
                            //收入
                            for (var i = 0; i < t_detail.length; i++) {//連接線
                                x = 100 + 10 + t_n * i;
                                y = t_Y - round(dec(t_detail[i].money) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
                                if (i > 0)
                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(0,255,0);stroke-width:1"/>';
                                bx = x;
                                by = y;
                            }
                            for (var i = 0; i < t_detail.length; i++) {
                                x = 100 + 10 + t_n * i;
                                y = t_Y - round(dec(t_detail[i].money) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
                                tmpPath += '<circle id="chart01_profit' + i + '" class="chart01_profit" class="" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
                            }
                            //費用攤提
                            for (var i = 0; i < t_detail.length; i++) {//連接線
                                x = 100 + 10 + t_n * i;
                                y = t_Y - round(dec(t_detail[i].partcost) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
                                if (i > 0)
                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(255,0,0);stroke-width:1"/>';
                                bx = x;
                                by = y;
                            }
                            for (var i = 0; i < t_detail.length; i++) {
                                x = 100 + 10 + t_n * i;
                                y = t_Y - round(dec(t_detail[i].partcost) / (t_maxMoney+Math.abs(t_minMoney)) * t_height, 0);
                                tmpPath += '<circle id="chart01_in' + i + '" class="chart01_in" class="" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
                                tmpPath += '<text id="chart01_datea' + i + '" class="chart01_datea" x="' + (x - 10) + '" y="' + (50 + t_height + 30) + '" fill="black">' + t_detail[i].mon + '</text>';
                            }
                            //符號說明
                            tmpPath += '<rect x="800" y="90" width="20" height="20" fill="url(#chart01_outColor1)"/>';
                            tmpPath += '<text x="830" y="105" fill="black">損益</text>';
                            
                            tmpPath += '<line x1="800" y1="50" x2="820" y2="50" style="stroke:rgb(0,0,0);stroke-width:1"/>';
                            tmpPath += '<circle class="" cx="810" cy="50" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
                            tmpPath += '<text x="830" y="55" fill="black">費用攤提</text>';

                            tmpPath += '<line x1="800" y1="75" x2="820" y2="75" style="stroke:rgb(0,180,125);stroke-width:1"/>';
                            tmpPath += '<circle class="" cx="810" cy="75" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
                            tmpPath += '<text x="830" y="80" fill="black">收入</text>';

                            obj.html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                            //事件
                            obj.children('svg').find('.chart01_in').hover(function(e) {
                                $(this).attr('fill', 'rgb(255,151,151)');
                                var n = $(this).attr('id').replace('chart01_in', '');
                                $('#chart01_datea' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'red');
                                var n = $(this).attr('id').replace('chart01_in', '');
                                $('#chart01_datea' + n).attr('fill', 'black');
                            });
                            obj.children('svg').find('.chart01_out').hover(function(e) {
                                $(this).attr('fill', 'url(#chart01_outColor2)');
                                var n = $(this).attr('id').replace('chart01_out', '');
                                $('#chart01_datea' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'url(#chart01_outColor1)');
                                var n = $(this).attr('id').replace('chart01_out', '');
                                $('#chart01_datea' + n).attr('fill', 'black');
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
			<div id='pieChart'> </div>
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

