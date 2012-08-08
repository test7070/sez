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
		<script src="//59.125.143.170/jquery/js/qset.js"></script>
		<script type="text/javascript">
            if(location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;100_1";
            }
            $(document).ready(function() {
                _q_boxClose();
                q_gf('', 'report_demo');
            });
            function q_gfPost() {
            	
                $('#qReport').q_report({
                    fileName : 'report_demo',
                    options : [{
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '1',
                        name : 'date'
                    }, {
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '3',
                        name : 'carno',
                        dbf : 'car2', 
                        index : 'a.noa',
                        src : 'car2_b.aspx'
                    }, {
                        type : '4', //radio
                        name : 'r1',
                        group : 'g1'
                    }, {
                        type : '5', //select
                        name : 's1',
                        value : [q_getPara('report.all')].concat(q_getPara('oil.product').split(','))
                    }, {
                        type : '6',
                        name : 'T6'
                    }, {
                        type : '7', //select
                        name : 's2',
                        value : q_getPara('oil.product').split(',')
                    }, {
                        type : '8', //checkbox
                        name : 'c1',
                        value : q_getPara('oil.product').split(',')
                    }]
                });
                q_getFormat();
                q_langShow();
                q_popAssign();

                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
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