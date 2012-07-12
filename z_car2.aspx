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
            t_item = "";
           	t_item2 = "";
           	
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_car2');
            });
            function q_gfPost() {
                q_func('car2.getItem', '3,4,5');
            }

            function q_boxClose(t_name) {
            }

            function q_gtPost(t_name) {
            	  if(result.substr(0, 5) == '<Data') {
                    var tmp = _q_appendData('carteam', '', true);
                    var t_carteam = '';
                    for(var z = 0; z < tmp.length; z++) {
                        t_carteam = t_carteam + (t_carteam.length > 0 ? ',' : '') + tmp[z].noa + '@' + tmp[z].team;
                    }
                    $('#qReport').q_report({
                        fileName : 'z_car2',
                        options : [{
                            type : '1',
                            name : 'mon'
                        }, {
                            type : '1',
                            name : 'date'
                        }, {
                            type : '2',
                            name : 'cardeal',
                            dbf : 'cardeal',
                            index : 'noa,comp',
                            src : 'cardeal_b.aspx'
                        }, {
                            type : '2',
                            name : 'carowner',
                            dbf : 'carowner',
                            index : 'noa,namea',
                            src : 'carowner_b.aspx'
                        }, {
                            type : '2',
                            name : 'driver',
                            dbf : 'driver',
                            index : 'noa,namea',
                            src : 'driver_b.aspx'
                        }, {
                            type : '2',
                            name : 'sss',
                            dbf : 'sss',
                            index : 'noa,namea',
                            src : 'sss_b.aspx'
                        }, {
                            type : '5', //select
                            name : 'xcarteamno',
                            value : [q_getPara('report.all')].concat(t_carteam.split(','))
                        }, {
                            type : '6',
                            name : 'xcarno'
                        }, {
                            type : '6',
                            name : 'enddate'
                        }, {
                            type : '1',
                            name : 'dcarno'
                        }]
                    });
                    q_getFormat();
	                q_langShow();
	                q_popAssign();
	
	                
	                t_item = "";
	                t_item2 = "";
	                $('#chkXcarteamno').children('input').attr('checked','checked');
	                $('#chkXcalctype').children('input').attr('checked','checked');
	                
	                
	                
	                var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                $('#txtMon1').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                $('#txtMon2').val(t_year+'/'+t_month);
	                
	                
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
            }
		</script>
	</head>
	<body>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="qReport"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>