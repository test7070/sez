<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
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
		<script type="text/javascript">
            $(document).ready(function() {
                _q_boxClose();
                q_gf('', 'z_cust');
            });
            function q_gfPost() {
                var t_qtype = [q_getPara('report.all')].concat(q_getPara('cust.qtype').split(','));
                $('#qReport').q_report({
                    fileName : 'z_cust',
                    options : [{
                        type : 'date'
                    },{
                        type : 'mon'
                    },{
                        type : 'cust'
                    }, {
                        type : 'tgg'
                    },{
                        type : 'sss'
                    },{
                        type : 'select',
                        name : 'qtype',
                        value : t_qtype
                    }]
                });
                q_getFormat();
                q_langShow();
            }

            function q_boxClose(s2) {
                $('#qReport').data('info').q_boxClose(s2,$('#qReport'));
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