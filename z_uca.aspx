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
				q_gt('uccga', '', 0, 0, 0, "");
			});
			var xgroupanoStr = '';
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_uca',
					options : [{
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1',
						name : 'date' //[2][3]
					}, {
						type : '2',
						name : 'product', //[4][5]
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '2',
						name : 'storeno', //[6][7]
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
						type : '6',
						name : 'edate' //[8]
					}, {
						type : '1',
						name : 'ordeno' //[9][10]
					}, {
						type : '5',
						name : 'ucctype', //[11]
						value : [q_getPara('report.all')].concat(q_getPara('uccst.typea').split(','))
					}, {
						type : '5',
						name : 'outtypea', //[12]
						value : ('all@全部,out@委外,notout@非委外').split(',')
					}, {
						type : '5',
						name : 'xgroupano', //[13]
						value : xgroupanoStr.split(',')
					}, {
						type : '6',
						name : 'style' //[14]
					}, {
						type : '8',
						name : 'allucc',//[15]
						value : '1@顯示所有物品'.split(',')
					}, {
						type : '2', //[16][17]
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '0', //[18]
						name : 'xucctype',
						value : q_getPara('uccst.typea')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();

				$('#txtDate1').mask('999/99/99');
				$('#txtDate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();
				$('#Xgroupano select').removeClass('c4');
				$('#txtEdate').mask('999/99/99');
				$('#txtEdate').val(q_date().substr(0,3)+'/12/31');
				
				$('#q_report .option ').css('width','800px');
				$('.option .a1').css('width','790px');
				$('.option .a2').css('width','390px');
				$('.c6').css('width','90px');
				$('.c2').css('width','150px');
				$('.c3').css('width','150px');
				$('.c5').css('width','150px');
				$('.cmb').css('width','150px');
				$('#Allucc').css('width','390px').css('height','30px');
				$('#Allucc .label').css('width','0px');
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
				switch (s2) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						var t_item = "#non@全部";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
						}
						xgroupanoStr = t_item;
						q_gf('', 'z_uca');
						break;
				}
			}
		</script>
		<style type="text/css">
		</style>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
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