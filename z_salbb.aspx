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
				q_getId();
				q_gf('', 'z_salbb');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_salbb',
					options : [{
						type : '6', //[1]
						name : 'xyears'
					}, {
						type : '6', //[2]
						name : 'xmon'
					}, {
						type : '1', //[3][4]
						name : 'ydate'
					}, {
						type : '2', //[5][6]
						name : 'xsno',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '0', //[7]
						name : 'xusername',
						value : r_name
					}]
				});
				q_popAssign();
				
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }

				$('#txtXmon').mask(r_picm);
				$('#txtXyears').mask(r_pic);
				$('#txtXyears').val(q_date().substring(0,r_len));
				$('#txtYdate1').mask(r_picd);
				$('#txtYdate1').datepicker();
				$('#txtYdate2').mask(r_picd);
				$('#txtYdate2').datepicker();
				
				$('#txtYdate1').val(q_date().substring(0,r_lenm)+'/01');
				$('#txtXmon').val(q_date().substring(0,r_lenm));
				$('#txtYdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
		</script>
		<style type="text/css">
			#frameReport table{
					border-collapse: collapse;
				}
		</style>
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