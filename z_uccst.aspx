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
			var bbmNum = [['txtXradius1', 3, 0]];
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_uccst');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_uccst',
					options : [{
							type : '0', //[1]
							name : 'accy',
							value : q_getId()[4]
						},{
							type : '1', //[2][3]
							name : 'xdate'
						}, {
							type : '2', //[4][5]
							name : 'xproduct',
							dbf : 'ucaucc',
							index : 'noa,product',
							src : 'ucaucc_b.aspx'
						}, {
							type : '6', // [6]
							name : 'xedate'
						},{
							type : '1', //[7][8]
							name : 'xordeno'
						}, {
							type : '5', //[9]
							name : 'xstktype',
							value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
						},{
							type : '6', //[10]
							name : 'xstyle'
						},{
							type : '6', //[11]
							name : 'xwaste'
						},{
							type : '1', //[12][13]
							name : 'xradius'
						},{
							type : '1', //[14][15]
							name : 'xwidth'
						},{
							type : '1', //[16][17]
							name : 'xdime'
						},{
							type : '1', //[18][19]
							name : 'xlengthb'
						}
					]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();

				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				
				$('#txtXedate').mask('999/99/99');
				$('#txtXedate').val(q_date());
				
				$('#txtXradius1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXradius2').val(9999.99).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(9999.99);
				});
				$('#txtXwidth1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXwidth2').val(9999.99).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(9999.99);
				});
				$('#txtXdime1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXdime2').val(999.99).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(999.99);
				});
				$('#txtXlengthb1').val(0).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(0);
				});
				$('#txtXlengthb2').val(99999.9).addClass('num').focusout(function(){
					$(this).val(dec($(this).val()));
					if($(this).val() == 'NaN') $(this).val(99999.9);
				});
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
		</script>
		<style type="text/css">
			.num{
				text-align:right;
			}
		</style>
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