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
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_rc2p');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_rc2p',
                        options : [{/* [1]*/
	                        type : '0',
	                        name : 'accy',
	                        value : r_accy
	                    },  {/* [2][3]*/
	                        type : '1',
	                        name : 'xnoa'
	                    }, {/* [4][5]*/
	                        type : '1',
	                        name : 'date'
	                    },{/* [6][7]*/
	                        type : '2',
	                        name : 'cust',
	                        dbf : 'cust',
	                        index : 'noa,comp',
	                        src : 'cust_b.aspx'
	                    } , {/* [8][9]*/
	                        type : '1',
	                        name : 'xmon'
	                    },{/* [10]*/
	                        type : '0',
	                        name : 'accy',
	                        value : q_getPara('sys.isspec')
	                    },{/* [11]*/
	                        type : '0',
	                        name : 'xproject',
	                        value : q_getPara('sys.project').toUpperCase()
	                    },{/* [12]*/
	                        type : '0',
	                        name : 'isspec',
	                        value : q_getPara('sys.isspec')
	                    }]
                    });
                q_popAssign();
                	
                	$('#txtXmon1').mask('999/99');
	                $('#txtXmon2').mask('999/99');
	                $('#txtDate1').mask('999/99/99');
	                $('#txtDate1').datepicker();
	                $('#txtDate2').mask('999/99/99');
	                $('#txtDate2').datepicker();  
	                
	            var t_noa=typeof(q_getId()[3])=='undefined'?'':q_getId()[3];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtXnoa1').val(t_noa);
                $('#txtXnoa2').val(t_noa);
                
                
                 var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXmon1').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXmon2').val(t_year+'/'+t_month);
	                
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