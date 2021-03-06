<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
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
            var acompItem = '';
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_orde_r');
                //q_gt('acomp', '', 0, 0, 0, "");
            });
            
            function q_gtPost(t_name) {
                switch (t_name) {
                }
            }

            function q_gfPost() {
            	var uccgaItem = '';
            	q_gt('uccga', '', 0, 0, 0, "",r_accy,1);
				var as = _q_appendData("uccga", "", true);
				uccgaItem = " @全部";
				for ( i = 0; i < as.length; i++) {
					uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
				}
            	
                $('#qReport').q_report({
                    fileName : 'z_orde_r',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : q_getId()[4]
                    },{
						type : '0',//[2]
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					},{
						type : '0',//[3]
						name : 'xrlen',
						value : r_len
					}, {
                        type : '1', //[4][5]
                        name : 'xdate'
                    }, {
                        type : '1', //[6][7]
                        name : 'xmon'
                    }, {
                        type : '1', //[8][9]
                        name : 'xweek'
                    }, {
                        type : '6', //[10]
                        name : 'xyear'
                    }, {
                        type : '2', //[11][12]
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2', //[13][14]
                        name : 'xagent',
                        dbf : 'agent',
                        index : 'noa,agent',
                        src : 'agent_b.aspx'
                    }, {
                        type : '2', //[15][16]
                        name : 'xproduct',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    }, {
                        type : '2', //[17][18]
                        name : 'xfactory',
                        dbf : 'factory',
                        index : 'noa,factory',
                        src : 'factory_b.aspx'
                    }, {
                        type : '2', //[19][20]
                        name : 'xsales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '6', //[21]
                        name : 'xsalegrp'
                    }, {
                        type : '5',//[22]
                        name : 'xorder',
                        value : new Array('custno@客戶別', 'odate@接單日期','unvcc@未出貨')
                    }, {
                        type : '5',//[23]
                        name : 'yorder',
                        value : new Array('salgrp@業務組別', 'sales@業務','custno@客戶別','pno@產品')
                    }, {
                        type : '5',//[24]
                        name : 'zorder',
                        value : new Array('fact@產線','custno@客戶別','salgrp@業務組別', 'sales@業務')
                    },{
                        type : '1', //[25][26]
                        name : 'yyear'
                    }, {
                        type : '5',//[27]
                        name : 'xshow',
                        value : new Array('money@金額','mount@數量','profit@PF')
                    },{
                        type : '5', //[28]
                        name : 'xgroupano',
                        value : uccgaItem.split(',')
                    }, {
                        type : '5',//[29]
                        name : 'xmonweek',
                        value : new Array('mon@月','week@周')
                    }, {
                        type : '6', //[30]
                        name : 'xordeno'
                    }]
                });
                
                $('.q_report .report').css('width','500px');
                $('.q_report .report div').css('width','250px');
                
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                var r_1911=1911;
                if(r_len==4){
                    r_1911=0;                  
                    $.datepicker.r_len=4;
                    //$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                    $('#txtXdate1').datepicker();
                    $('#txtXdate2').datepicker();
                    $('#txtXmon1').mask(r_picm);
                    $('#txtXmon2').mask(r_picm);
                    $('#txtXyear').mask(r_pic);
                    $('#txtYyear1').mask(r_pic);
                    $('#txtYyear2').mask(r_pic);
                    $('#txtXdate1').mask(r_picd);
                    $('#txtXdate2').mask(r_picd);
                }else{
                    $('#txtXdate1').mask('999/99/99');
                    $('#txtXdate1').datepicker();
                    $('#txtXdate2').mask('999/99/99');
                    $('#txtXdate2').datepicker();
                    $('#txtXmon1').mask('999/99');
                    $('#txtXmon2').mask('999/99');
                    $('#txtXyear').mask('999');
                    $('#txtYyear1').mask('999');
                    $('#txtYyear2').mask('999');
                }

                $('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
                $('#txtXmon1').val(q_date().substr(0,r_len)+'/01');
                $('#txtXmon2').val(q_date().substr(0,r_len)+'/12');
                $('#txtXyear').val(q_date().substr(0,r_len))
                $('#txtYyear1').val(dec(q_date().substr(0,r_len))-5);
                $('#txtYyear2').val(q_date().substr(0,r_len));
                
                $('#txtXweek1').val(getISOYearWeek(new Date()));
                $('#txtXweek2').val(dec($('#txtXweek1').val())+8);
                
                $('#txtXweek1').keyup(function() {
                	$(this).val(dec($(this).val()));
                	if($(this).val()=="NaN" || $(this).val()=="0")
                		$(this).val('');
                	if(dec($(this).val())>53)
                		$(this).val(53);
				});
				$('#txtXweek2').keyup(function() {
                	$(this).val(dec($(this).val()));
                	if($(this).val()=="NaN" || $(this).val()=="0")
                		$(this).val('');
                	if(dec($(this).val())>53)
                		$(this).val(53);
				});
            }
			
			function getISOYearWeek(date){  
		        var commericalyear=getCommerialYear(date);  
		        var date2=getYearFirstWeekDate(commericalyear);     
		        var day1=date.getDay();     
		        if(day1==0) day1=7;     
		        var day2=date2.getDay();     
		        if(day2==0) day2=7;     
		        var d = Math.round((date.getTime() - date2.getTime()+(day2-day1)*(24*60*60*1000)) / 86400000);       
		        return Math.ceil(d / 7)+1;   
		    }
		    
		    function getYearFirstWeekDate(commericalyear){  
		        var yearfirstdaydate=new Date(commericalyear, 0, 1);     
		        var daynum=yearfirstdaydate.getDay();   
		        var monthday=yearfirstdaydate.getDate();  
		        if(daynum==0) daynum=7;  
		        if(daynum<=4){  
		            return new Date(yearfirstdaydate.getFullYear(),yearfirstdaydate.getMonth(),monthday+1-daynum);  
		        }else{  
		            return new Date(yearfirstdaydate.getFullYear(),yearfirstdaydate.getMonth(),monthday+8-daynum)  
		        }   
		    }
		    
		    function getCommerialYear(date){  
		        var daynum=date.getDay();   
		        var monthday=date.getDate();  
		        if(daynum==0) daynum=7;  
		        var thisthurdaydate=new Date(date.getFullYear(),date.getMonth(),monthday+4-daynum);  
		        return thisthurdaydate.getFullYear();  
		    }
		    
            function q_boxClose(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="qReport"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>