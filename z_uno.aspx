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
				q_gf('', 'z_uno');
				
				$('#q_report').click(function(e) {
					if(q_getPara('sys.project').toUpperCase()!='RA'){
						var delete_report=0;
							for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
								if($('#q_report').data().info.reportData[i].report=='z_uno4')
									delete_report=i;
							}
							if($('#q_report div div').text().indexOf('批號庫存表')>-1)
								$('#q_report div div')[delete_report].remove()
					}
				});
			});
			function q_gfPost(t_name) {
				$('#q_report').q_report({
					fileName : 'z_uno',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : r_accy
					}, {/*1*/
						type : '6', //[2]
						name : 'xnoa'
					}, {/*1*/
						type : '0', //[3]
						name : 'xcubtype',
						value : q_getPara('cubpi.typea')
					}, {/*1*/
						type : '6', //[4]
						name : 'xenddate'
					}]
				});
				q_langShow();
				q_popAssign();
				var t_noa = q_getId()[3];
				if (t_noa.length > 0) {//used by z_uccstk
					$('#txtXnoa').val(t_noa);
					$('#btnOk').click();
				}
				
				$('#txtXenddate').val(q_date());
				$('#txtXenddate').mask('999/99/99');
				$('#txtXenddate').datepicker();
				
			}

			function q_boxClose(s2) {
			}

			function q_gtPost() {
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