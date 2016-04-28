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
				//q_gf('', 'z_workp');
				q_gt('uccga', '', 0, 0, 0, "");
			});
			var xgroupanoStr = '';
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_workp',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '1', //[2][3]
						name : 'xnoa'
					}, {
						type : '1', //[4] [5]
						name : 'xdate'
					}, {
						type : '2',//[6][7]
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '6', //[8]
						name : 'xcuano'
					}, {
						type : '0', //[9]
						name : 'r_name',
						value : r_name
					}, {
						type : '2', //[10][11]
						name : 'xproduct',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '6', //[12]
						name : 'xstyle'
					}, {
						type : '1', //[13] [14]
						name : 'xdate2'
					}, {
						type : '2', //[15] [16]  
						name : 'xstation',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					},{
						type : '2', //[17] [18] 
						name : 'xstationg',
						dbf : 'stationg',
						index : 'noa,namea',
						src : 'stationg_b.aspx'
					}, {
						type : '5', //[19]
						name : 'xgroupano',
						value : xgroupanoStr.split(',')
					}, {
						type : '5', //[20]
						name : 'xenda',
						value : '0@未完工,1@已完工'.split(',')
					}, {
						type : '8', //[21]
						name : 'xworkj',
						value : ('1@含非正式製令').split(',')
					}, {
						type : '2', //[22] [23] 20
						name : 'yproduct',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				$('#txtXdate1').datepicker().mask(r_picd);
				$('#txtXdate2').datepicker().mask(r_picd);
				$('#txtXdate21').datepicker().mask(r_picd);
				$('#txtXdate22').datepicker().mask(r_picd);
				$('#txtXnoa1').css('width', '160px');
				$('#txtXnoa2').css('width', '160px');
				var t_key = q_getHref();
				//抓製令單號
				if (window.parent.q_name == 'workg') {
					if (t_key[1] != undefined) {
						var t_where = "where=^^ cuano='" + t_key[1] + "'^^";
						q_gt('work', t_where, 0, 0, 0, "", r_accy);
					}
				} else {
					if (t_key[1] != undefined) {
						$('#txtXnoa1').val(t_key[1]);
						$('#txtXnoa2').val(t_key[1]);
					}
				}
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
				switch (s2) {
					case 'work':
						var as = _q_appendData("work", "", true);
						if (as[0] != undefined) {
							$('#txtXnoa2').val(as[0].noa);
							$('#txtXnoa1').val(as[as.length - 1].noa);
						} else {
							$('#txtXnoa2').val('');
							$('#txtXnoa1').val('');
							$('#txtXdate1').val(q_date().substring(0, 7) + '01');
							var lastDays = $.datepicker._getDaysInMonth(q_date().substring(0, 3), q_date().substring(4, 6) - 1);
							$('#txtXdate2').val(q_date().substring(0, 7) + lastDays);
						}
						break;
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						var t_item = "#non@全部";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
						}
						xgroupanoStr = t_item;
						q_gf('', 'z_workp');
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