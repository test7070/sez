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
			var uccgaItem = '';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				if (uccgaItem.length == 0) {
					q_gt('uccga', '', 0, 0, 0, "");
				}
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ucc',
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
						type : '1',
						name : 'ordeno' //[8][9]
					}, {
						type : '5',
						name : 'ucctype', //[10]
						value : [q_getPara('report.all')].concat((q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1) ? q_getPara('ucc.typea_it').split(',') : q_getPara('ucc.typea').split(','))
					}, {
						type : '5',
						name : 'outtypea', //[11]
						value : ('all@全部,out@委外,notout@非委外').split(',')
					}, {
						type : '5', //[12]
						name : 'xgroupano',
						value : uccgaItem.split(',')
					}, {
						type : '0', //[13]
						name : 'xgroupas',
						value : uccgaItem
					}, {
						type : '0', //[14]
						name : 'xucctype',
						value : (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1) ? q_getPara('ucc.typea_it') : q_getPara('ucc.typea')
					}, {
						type : '0', //[15]
						name : 'showprice',
						value : (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1) && r_rank < '7' ? '0' : '1'
					}, {
						type : '0', //[16] //判斷公司
						name : 'acomp',
						value : q_getPara('sys.comp')
					}, {
						type : '2', //[17][18]
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '6',
						name : 'edate' //[19]
					}, {
						type : '8',
						name : 'allucc',//[20]
						value : '1@顯示所有物品'.split(',')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();

				$('#txtDate1').mask('999/99/99');
				$('#txtDate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();

				$('#txtEdate').mask('999/99/99');
				$('#txtEdate').val(q_date());
				
				$('#Allucc').css('width','300px').css('height','30px');
				$('#Allucc .label').css('width','0px');
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						uccgaItem = "#non@全部";
						for ( i = 0; i < as.length; i++) {
							uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
						}
						q_gf('', 'z_ucc');
						break;
				}
			}
		</script>
		<style type="text/css">
			/*.q_report .option {
			 width: 600px;
			 }
			 .q_report .option div.a1 {
			 width: 580px;
			 }
			 .q_report .option div.a2 {
			 width: 220px;
			 }
			 .q_report .option div .label {
			 font-size:medium;
			 }
			 .q_report .option div .text {
			 font-size:medium;
			 }
			 .q_report .option div .cmb{
			 height: 22px;
			 font-size:medium;
			 }
			 .q_report .option div .c2 {
			 width: 80px;
			 }
			 .q_report .option div .c3 {
			 width: 110px;
			 }*/
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