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
                _q_boxClose();
                q_getId();
                q_gf('', 'z_tran');
            });
            function q_gfPost() {
                q_gt('carteam', '', 0, 0, 0, "");
            }

            function q_boxClose(t_name) {
            }
            function q_gtPost(t_name) {
            	var t_item = "";
            	switch (t_name) {
                    case 'carteam':
                        var as = _q_appendData("carteam", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length>0?',':'') + as[i].noa +'@' + as[i].team;
                        }    
                        break;
                }
                $('#qReport').q_report({
                    fileName : 'z_tran',
                    options : [{
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '6',
                        name : 'month'
                    }, {
                        type : '1',
                        name : 'mon'
                    }, {
                        type : '1',
                        name : 'trandate'
                    }, {
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2',
                        name : 'driver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {
                        type : '2',
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '5', //select
                        name : 'xcarteamno',
                        value : [q_getPara('report.all')].concat(t_item.split(','))
                    }, {
                        type : '6',
                        name : 'xcarno'
                    }, {
                        type : '6',
                        name : 'xpo'
                    }, {
                        type : '1',
                        name : 'datea'
                    }]
                });
                q_getFormat();
                q_langShow();
                q_popAssign();

                $('#txtMonth').mask('999/99');
                $('#txtMon1').mask('999/99');
                $('#txtMon2').mask('999/99');
                $('#txtTrandate1').mask('999/99/99');
                $('#txtTrandate1').datepicker();
                $('#txtTrandate2').mask('999/99/99');
                $('#txtTrandate2').datepicker();
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();  
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