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
		<script type="text/javascript">
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_paytran');
			});
			function q_gfPost() {

				$('#qReport').q_report({
					fileName : 'z_paytran',
					options : [{
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1',
						name : 'date'
					}, {
						type : '2',
						name : 'tgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '2',
						name : 'driver',
						dbf : 'driver',
						index : 'noa,namea',
						src : 'driver_b.aspx'
					}, {
						type : '6',
						name : 'zrc2no'
					}, {
						type : '6',
						name : 'xcarno'
					}, {
						type : '5', //select
						name : 'xsort1',
						value : q_getPara('z_tre.sort1').split(',')
					}, {
						type : '6',
						name : 'xnoa'
					}]
				});
				q_popAssign();
	                q_langShow();

				$('#txtDate1').mask('999/99/99');
				$('#txtDate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();

				var t_date, t_year, t_month, t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);

				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
			}

			function q_boxClose(t_name) {
			}

			function q_gtPost(t_name) {
			}
		</script>
	</head>
	<body>

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