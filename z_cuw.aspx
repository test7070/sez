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
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_cuw');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_cuw',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '2', //[2][3]
						name : 'xstationno',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					}, {
						type : '2', //[4][5]
						name : 'xproductno',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '1', //[6][7]
						name : 'xcuadate'
					}, {
						type : '1', //[8][9]
						name : 'xuindate'
					}, {
						type : '1', //[10][11]
						name : 'xdatea'
					}, {
						type : '2', //[12][13]
						name : 'xstationgno',
						dbf : 'stationg',
						index : 'noa,namea',
						src : 'stationg_b.aspx'
					}, {
						type : '2', //[14][15]
						name : 'xsssno',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
                if(r_len==4){                
                    $.datepicker.r_len=4;
                    //$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				
				$('#txtXcuadate1').datepicker().val(q_date()).mask(r_picd);
				$('#txtXcuadate2').datepicker().val(q_date()).mask(r_picd);
				$('#txtXuindate1').datepicker().val(q_date()).mask(r_picd);
				$('#txtXuindate2').datepicker().val(q_date()).mask(r_picd);
				$('#txtXdatea1').datepicker().val(q_date()).mask(r_picd);
				$('#txtXdatea2').datepicker().val(q_date()).mask(r_picd);
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