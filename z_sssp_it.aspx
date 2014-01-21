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
			aPop = new Array(
				['txtXcarno', '', 'cicar', 'a.noa,cust', 'txtXcarno', 'cicar_b.aspx'],
				['txtXcardealno', '', 'cicardeal', 'noa,comp', 'txtXcardealno', 'cardeal_b.aspx'],
				['txtXinsurerno', '', 'ciinsucomp', 'noa,insurer', 'txtXinsurerno', 'ciinsucomp_b.aspx'],
				['txtXsales', '', 'cisale', 'noa,namea', 'txtXsales', 'cisale_b.aspx']
			);
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_sssp_it');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_sssp_it',
					options : [{
						type : '0', //[1]
						name : 'xsss',
						value : r_userno
					}, {
						type : '6', //[2]
						name : 'xmon'
					}, {
						type : '5', //[3]
						name : 'xkind',
						value : (('').concat(new Array("本月", "上期", "下期"))).split(',')
					}, {
						type : '6', //[4]
						name : 'xyear'
					}]
				});
				q_langShow();
				q_popAssign();

				$('#txtXmon').mask('999/99');
				$('#txtXyear').mask('999');

				var t_date = q_date();
				var nextdate = new Date(dec(t_date.substr(0, 3)) + 1911, dec(t_date.substr(4, 2)) - 1, dec(t_date.substr(7, 2)));
				nextdate.setDate(nextdate.getDate() - 30);
				t_date = '' + (nextdate.getFullYear() - 1911) + '/';
				//月份
				if (nextdate.getMonth() + 1 < 10)
					t_date = t_date + '0' + (nextdate.getMonth() + 1);
				else
					t_date = t_date + (nextdate.getMonth() + 1);

				$('#txtXmon').val(t_date);
				$('#txtXyear').val(t_date.substr(0, 3));

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