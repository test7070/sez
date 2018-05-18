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
		aPop  =  new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driver','txtXcarno', 'car2_b.aspx'],
			['txtXuccno', 'lblXuccno', 'ucc', 'noa,product', 'txtXuccno', 'ucc_b.aspx'],
			['txtXcarnos', 'lblXcarno', 'car2', 'a.noa,driverno,driver','txtXcarnos', 'car2_b.aspx']
			);
		
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_trand');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_trand',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '6', //[2]
						name : 'mon'
					}, {
						type : '6', //[3]
						name : 'xdate'
					}, {
						type : '6', //[4]
						name : 'xcarno'
					}, {
						type : '1', //[5][6]
						name : 'trandate'
					}, {
						type : '6', //[7]
						name : 'xuccno'
                    }, {/*3*/
                        type : '2', //[8][9]
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
					}, {
						type : '6', //[10]
						name : 'caseno'
					}, {
	                        type : '6', //[11]
	                        name : 'xcarnos'
					}, {
	                        type : '6', //[12]
	                        name : 'xyear'
	                }]
				});
				q_popAssign();
				$('#txtTrandate1').mask('999/99/99');
				$('#txtTrandate1').datepicker();
				$('#txtTrandate2').mask('999/99/99');
				$('#txtTrandate2').datepicker();
				$('#txtMon').mask('999/99');
				$('#txtXdate').mask('999/99/99');
				$('#txtXyear').mask('999');
				var t_date, t_year, t_month, t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtTrandate1').val(t_year + '/' + t_month + '/' + t_day);
				$('#txtMon').val(t_year + '/' + t_month);
				$('#txtXyear').val(t_year);
				
				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtTrandate2').val(t_year + '/' + t_month + '/' + t_day);
				
			
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
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

