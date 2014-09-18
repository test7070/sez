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
				q_gf('', 'z_salaward_it');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_salaward_it',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '6', //[2]
						name : 'xyear'
					}, {
						type : '1', //[3][4]
						name : 'xmon'
					}, {
						type : '1', //[5][6]
						name : 'xnoa'
					}, {/*3*/
						type : '2', //[7][8]
						name : 'sss',
						dbf : 'sss',
						index : 'noa,namea',
						src : 'sss_b.aspx'
					}, {
						type : '2', //[9][10]
						name : 'part',
						dbf : 'part',
						index : 'noa,part',
						src : 'part_b.aspx'
					}, {
						type : '5', //[11]
						name : 'xorder',
						value : (('').concat(new Array("員工編號", "部門"))).split(',')
					}]
				});
				q_popAssign();
				$('#txtXyear').mask(r_picm);
				$('#txtXmon1').val(q_date().substr(0, 6)).mask(r_picm);
				$('#txtXmon2').val(q_date().substr(0, 6)).mask(r_picm);
				$('#txtXyear').val(q_date().substr(0, 6));
				if(q_getHref()[1]!=undefined){
					$('#txtXnoa1').val(q_getHref()[1]);
					$('#txtXnoa2').val(q_getHref()[1]);
				}
				
			}

			var exchange = function(a, b) {
				try {
					var tmpTop = a.offset().top;
					var tmpLeft = a.offset().left;
					a.offset({
						top : b.offset().top,
						left : b.offset().left
					});
					b.offset({
						top : tmpTop,
						left : tmpLeft
					});
				} catch(e) {
				}
			};

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

