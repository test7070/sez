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
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_tran_sh');
            });
            
            aPop = new Array(
                ['txtXaddr1b', '', 'addr', 'noa,addr', 'txtXaddr1a,txtXaddr1b', 'addr_b.aspx'],
                ['txtXaddr2b', '', 'addr', 'noa,addr', 'txtXaddr2a,txtXaddr2b', 'addr_b.aspx'],
                ['txtXaddr21b', '', 'addr', 'noa,addr', 'txtXaddr21a,txtXaddr21b', 'addr_b.aspx'],
                ['txtXaddr22b', '', 'addr', 'noa,addr', 'txtXaddr22a,txtXaddr22b', 'addr_b.aspx']
            );
            
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_tran_sh',
                        options : [{
							type : '0',//[1]
							name : 'accy',
							value : r_accy
					},{
						type : '1',//[2][3]
						name : 'xdate'
					},{
						type : '1',//[4][5]
						name : 'noa'
					},{
						type : '2', //[6][7]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					},{
                        type : '2', //[8][9]
                        name : 'xaddr',
                        dbf : 'addr',
                        index : 'noa,addr',
                        src : 'addr_b.aspx'
                    },{
                        type : '2', //[10][11]
                        name : 'xaddr2',
                        dbf : 'addr',
                        index : 'noa,addr',
                        src : 'addr_b.aspx'
                    },{
                        type : '2',//[12][13]
                        name : 'xdriver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    },{
                        type : '5', //[14]
                        name : 'xchk1',
                        value : (' @全部,0@未登錄,1@已登錄').split(',')
                    },{
                        type : '5', //[15]
                        name : 'xchk2',
                        value : (' @全部,0@未確認,1@已確認').split(',')
                    }]
                    });
                q_popAssign();
                 $('#txtXdate1').mask('999/99/99');
	             $('#txtXdate1').datepicker();
	             $('#txtXdate2').mask('999/99/99');
	             $('#txtXdate2').datepicker(); 
               
                var t_noa=typeof(q_getId()[5])=='undefined'?'':q_getId()[5];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtNoa1').val(t_noa);
                $('#txtNoa2').val(t_noa);
                
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
                
                    $('#txtXaddr1b').removeAttr('disabled');
                    $('#txtXaddr2b').removeAttr('disabled');
                    $('#txtXaddr21b').removeAttr('disabled');
                    $('#txtXaddr22b').removeAttr('disabled');

                    $('#txtXaddr1b').change(function() {
                        if($('#txtXaddr1a').val().length==0){
                            $('#txtXaddr1a').val($('#txtXaddr1b').val());
                        }
                        
                    });
                    
                    $('#txtXaddr2b').change(function() {
                        if($('#txtXaddr2a').val().length==0){
                            $('#txtXaddr2a').val($('#txtXaddr2b').val());
                        }
                        
                    });
                    
                    $('#txtXaddr21b').change(function() {
                        if($('#txtXaddr21a').val().length==0){
                            $('#txtXaddr21a').val($('#txtXaddr21b').val());
                        }
                        
                    });
                    
                    $('#txtXaddr22b').change(function() {
                        if($('#txtXaddr22a').val().length==0){
                            $('#txtXaddr22a').val($('#txtXaddr22b').val());
                        }
                        
                    });

   
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
           
          