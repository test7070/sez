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
				//q_gf('', 'z_workfp');
				q_gt('uccga', '', 0, 0, 0, "");
			});
			var xgroupanoStr = '';
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_workfp',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '6', //[2]
						name : 'xnoa'
					}, {
						type : '1', //[3][4]
						name : 'xdate'
					}, {
						type : '2', //[5][6]
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '2', //[7][8]
						name : 'xucaucc',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '5', //[9]
						name : 'xsortby',
						value : 'datea@依日期,pno@依品號'.split(',')
					}, {
						type : '5', //[10]
						name : 'xwhere',//f,u,q
						value : '4@階段一：委外製令單,1@階段二：已送驗未暫收,2@階段三：已暫收，未驗收,3@階段四：已驗收'.split(',')
					},{
						type : '1', //[11] [12]
						name : 'xcuadate'
					}, {
						type : '5', //[13]
						name : 'xgroupano',
						value : xgroupanoStr.split(',')
					}, {
						type : '5', //[14]
						name : 'xenda',
						value : '0@未完工,1@已完工'.split(',')
					}, {
						type : '8', //[15]
						name : 'xworkj',
						value : ('1@含非正式製令').split(',')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				if(r_outs==1){
					$('#txtXtgg1a').val(r_userno.toUpperCase()).attr('disabled','disabled');
					$('#txtXtgg2a').val(r_userno.toUpperCase()).attr('disabled','disabled');
					$('#btnXtgg1,#btnXtgg2').unbind('click');
					$('#chkXworkj [type]=checked').attr('disabled','disabled');
				}
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate2').mask('999/99/99');
				$('#txtXcuadate1').mask('999/99/99');
				$('#txtXcuadate2').mask('999/99/99');
				$('#Xwhere select').css('width','180px')
				$('#txtXdate1').val(q_date().substring(0, 7) + '01');
				var lastDays = $.datepicker._getDaysInMonth(q_date().substring(0, 3), q_date().substring(4, 6) - 1);
				$('#txtXdate2').val(q_date().substring(0, 7) + lastDays);
				var t_key = q_getHref();
				if (t_key[1] != undefined)
					$('#txtXnoa').val(t_key[1]);
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
						q_gf('', 'z_workfp');
						break;
				} /// end switch
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