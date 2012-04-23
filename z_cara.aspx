<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="//59.125.143.170/jquery/js/jquery-1.7.2.min.js" type="text/javascript"></script>
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
                q_gf('', 'z_cara');
            });
            function q_gfPost() {
                $('#qReport').qReport({
                        fileName : 'z_cara',
                        options : [{
                            type : '1',
                            name : 'mon'
                        }, {
                            type : '1',
                            name : 'date'
                        }, {
                            type : '2',
                            name : 'carowner',
                            dbf : 'carowner',
                            index : 'noa,namea',
                            src : 'carowner_b.aspx'
                        }, {
                            type : '3',
                            name : 'carno',
                            dbf : 'car2',
                            index : 'a.noa',
                            src : 'car2_b.aspx'
                        }]
                    });
                    q_getFormat();
                    q_langShow();
                    q_popAssign();

                    $('#qReport_txtMonth').mask('999/99');
                    $('#qReport_txtMon1').mask('999/99');
                    $('#qReport_txtMon2').mask('999/99');
                    $('#qReport_txtDate1').mask('999/99/99');
                    $('#qReport_txtDate1').datepicker();
                    $('#qReport_txtDate2').mask('999/99/99');
                    $('#qReport_txtDate2').datepicker();
            }

            function q_boxClose(t_name) {
            }

            function q_gtPost(t_name) {
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