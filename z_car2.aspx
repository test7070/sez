<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="/../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/z_report.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<link rel="stylesheet" href="//59.125.143.170/jquery/css/qreport.css" />
		<script src="//59.125.143.170/jquery/js/qset.js" type="text/javascript"></script>
		<script type="text/javascript">
            $(document).ready(function() {
                _q_boxClose();
                q_gf('', 'z_car2');
            });
            function q_gfPost() {
                q_func('car2.getItem', '3,4,5');
            }

            function q_boxClose(t_name) {
            }

            function q_gtPost(t_name) {
            }

            function q_funcPost(t_func, result) {
                if(result.substr(0, 5) == '<Data') {
                    var tmp = _q_appendData('carteam', '', true);
                    var t_carteam = '';
                    for(var z = 0; z < tmp.length; z++) {
                        t_carteam = t_carteam + (t_carteam.length > 0 ? ',' : '') + tmp[z].noa + '@' + tmp[z].team;
                    }
                    $('#qReport').q_report({
                        fileName : 'z_car2',
                        options : [{
                            type : '0',
                            name : 'gqbTypea',
                            value : q_getPara('gqb.typea')
                        },{
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
                        },{
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
                        }]
                    });
                    q_getFormat();
                    q_langShow();
                    q_popAssign();

                    $('#txtMon1').mask('999/99');
                    $('#txtMon2').mask('999/99');
                    $('#txtDate1').mask('999/99/99');
                    $('#txtDate1').datepicker();
                    $('#txtDate2').mask('999/99/99');
                    $('#txtDate2').datepicker();
                    $('#txtEnddate').mask('999/99/99');
                    $('#txtEnddate').datepicker();
                    
                } else
                    alert('Error!' + '\r' + t_func + '\r' + result);
            }
		</script>
	</head>
	<body>
		<div id="container">
			<div id="qReport"></div>
		</div>
		<div class="prt" >
			<!--#include file="../inc/print_ctrl.inc"-->
		</div>
	</body>
</html>