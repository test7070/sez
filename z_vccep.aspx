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
			var t_first=true;
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_vccep');
                
                $('#q_report').click(function(e) {
					if(window.parent.q_name=="packing"){
						var delete_report=999;
						for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
							if($('#q_report').data().info.reportData[i].report!='z_vccep4'){
								$('#q_report div div').eq(i).hide();
							}
						}
						
						$('#q_report div div .radio').parent().each(function(index) {
							if(!$(this).is(':hidden') && t_first){
								$(this).children().removeClass('nonselect').addClass('select');
								t_first=false;
							}
							if($(this).is(':hidden') && t_first){
								$(this).children().removeClass('select').addClass('nonselect');
							}
						});
					}
				});
                
                
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_vccep',
                        options : [{
	                        type : '0',
	                        name : 'accy',
	                        value : r_accy
	                    },{
	                        type : '6',
	                        name : 'xnoa'
	                    },{
	                        type : '1',
	                        name : 'xdate'
	                    },{
	                        type : '2',
	                        name : 'cust',
	                        dbf : 'cust',
	                        index : 'noa,comp',
	                        src : 'cust_b.aspx'
	                    },{
	                        type : '2',
	                        name : 'acomp',
	                        dbf : 'acomp',
	                        index : 'noa,comp',
	                        src : 'acomp_b.aspx'
	                    },{
	                        type : '2',
	                        name : 'sales',
	                        dbf : 'sss',
	                        index : 'noa,namea',
	                        src : 'sss_b.aspx'
	                    },{
	                        type : '2',
	                        name : 'icomp',
	                        dbf : 'tgg',
	                        index : 'noa,comp',
	                        src : 'tgg_b.aspx'
	                    },{
	                        type : '2',
	                        name : 'bcomp',
	                        dbf : 'tgg',
	                        index : 'noa,comp',
	                        src : 'tgg_b.aspx'
	                    },{
	                        type : '1',
	                        name : 'cldate'
	                    }, {//[17]
	                        type : '0',
	                        name : 'xstype',
	                        value : q_getPara('orde.stype')
	                    },{
	                        type : '6',
	                        name : 'xcustorde'
	                    },{
	                        type : '6',
	                        name : 'xblno'
	                    },{
	                        type : '6',
	                        name : 'xcaseno'
	                    },{
	                        type : '0',
	                        name : 'xtel',
	                        value : q_getPara('sys.tel')
	                    }]
                    });
                q_popAssign();
                
                if(r_len==4){                 
                    $.datepicker.r_len=4;
                    //$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                	
                $('#txtXdate1').mask(r_picd);
                $('#txtXdate1').datepicker();
                $('#txtXdate1').val(q_cdn(q_date(),-7));
                $('#txtXdate2').mask(r_picd);
                $('#txtXdate2').datepicker();
                $('#txtXdate2').val(q_cdn(q_date(),+7));
                $('#txtCldate1').mask(r_picd);
                $('#txtCldate1').datepicker();
                $('#txtCldate1').val(q_date());
                $('#txtCldate2').mask(r_picd);
                $('#txtCldate2').datepicker();  
                $('#txtCldate2').val(q_cdn(q_date(),+14));
                
	            /*var t_date,t_year,t_month,t_day;
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
	            $('#txtXdate2').val(t_year+'/'+t_month+'/'+t_day);*/
	            
	             if(q_getHref()[1]!=undefined){
                	$('#txtXnoa').val(q_getHref()[1]);
                	$('.option input').not('#txtXnoa').val('');
                }
                
                $('#txtXnoa').change(function() {
                	if($(this).val().length>0){
                		$('.option input').not('#txtXnoa').val('');
                	}else{
                		$('#txtXdate1').mask(r_picd);
		                $('#txtXdate1').datepicker();
		                $('#txtXdate1').val(q_cdn(q_date(),-7));
		                $('#txtXdate2').mask(r_picd);
		                $('#txtXdate2').datepicker();
		                $('#txtXdate2').val(q_cdn(q_date(),+7));
		                $('#txtCldate1').mask(r_picd);
		                $('#txtCldate1').datepicker();
		                $('#txtCldate1').val(q_date());
		                $('#txtCldate2').mask(r_picd);
		                $('#txtCldate2').datepicker();  
		                $('#txtCldate2').val(q_cdn(q_date(),+14));
                	}
				});
				
				$('#q_report div div .radio.select').click();
            }

            function q_boxClose(s2) {
            }
            function q_gtPost(s2) {
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
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          