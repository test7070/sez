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
			var xgroupanoStr = '';
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gt('uccga', '', 0, 0, 0, "");
				var txtreport = '';

				$('#q_report').click(function(e) {
					for (var i = 0; i < $('#q_report').data().info.reportData.length; i++) {
						if ($('.radio.select').next().text() == $('#q_report').data().info.reportData[i].reportName) {
							txtreport = $('#q_report').data().info.reportData[i].report;
							if (txtreport == 'z_work1' || txtreport == 'z_work5')
								$('#lblXdate').text('生產日期');
							else if (txtreport == 'z_work12' || txtreport == 'z_work13')
								$('#lblXdate').text('重工日期');
							else
								$('#lblXdate').text('應開工日');
						}
					}
				});

			});
			var xgroupanoStr = '';
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_work',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '6', //[2]    1
						name : 'xnoa'
					}, {
						type : '1', //[3][4]  2
						name : 'xdate'
					}, {
						type : '2', //[5][6]  3
						name : 'tgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '2', //[7] [8]  4
						name : 'xstation',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					}, {
						type : '2', //[9] [10] 5
						name : 'xstoreno',
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					}, {
						type : '2', //[11] [12] 6
						name : 'xproductno',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '8', //[13] 7
						name : 'aberrant',
						value : ('異常').split(',')
					}, {
						type : '2', //[14] [15] 8
						name : 'xprocess',
						dbf : 'process',
						index : 'noa,process',
						src : 'process_b.aspx'
					}, {
						type : '6', //[16] 9
						name : 'xcuano'
					}, {
						type : '6', //[17] 10
						name : 'xworkno'
					}, {
						type : '5', //[18] 11
						name : 'xorder',
						value : ('1@依子件,2@依上一階製品,3@依製成品').split(',')
					}, {
						type : '5', //[19] 12
						name : 'xgroupano',
						value : xgroupanoStr.split(',')
					}, {
						type : '8', //[20] 13
						name : 'xshowdiff',
						value : ('1@僅顯示差異>+-0.5').split(',')
					}, {
						type : '5', //[21] 14
						name : 'xenda',
						value : '0@未完工,1@已完工'.split(',')
					}, {
						type : '1', //[22][23] 15
						name : 'ydate'
					}, {
						type : '2', //[24] [25] 16
						name : 'ystation',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					}, {
						type : '8', //[26] 17
						name : 'xdetail',
						value : ('detail@明細').split(',')
					}, {
						type : '6', //[27]
						name : 'xmon'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate2').mask('999/99/99');
				$('#txtYdate1').mask('999/99/99');
                $('#txtYdate2').mask('999/99/99');
                $('#txtXmon').mask('999/99');
				$('#txtXmon').val(q_date().substring(0,6));
                $('#txtYdate1').datepicker();
                $('#txtYdate2').datepicker();
                $('#txtYdate1').val(q_date());
                $('#txtYdate2').val(q_date());
				$('#txtXdate1').val(q_date().substring(0,7)+'01');
				//$('#txtXdate1').val(q_date().substring(0,7)+'01');
				$('.q_report .option:first').css('width','700px')
				$('#Xproductno').css('width','690px');
				$('#Xproductno .c2').css('width','130px');
				$('#Xproductno .c3').css('width','130px');
				var lastDays = $.datepicker._getDaysInMonth(q_date().substring(0, 3), q_date().substring(4, 6) - 1);
				$('#txtXdate2').val(q_date().substring(0, 7) + lastDays);

				$("#lblXcuano").css("font-size", "13px");
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						var t_item = "#non@全部";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
						}
						xgroupanoStr = t_item;
						q_gf('', 'z_work');
						break;
				}
			}
		</script>
		<style type="text/css">
			.q_report .report {
				position: relative;
				width: 440px;
				margin-right: 2px;
				border: 1px solid #76a2fe;
				background: #EEEEEE;
				float: left;
				border-radius: 5px;
			}
			.q_report .report div {
				display: block;
				float: left;
				width: 220px;
				height: 30px;
				font-size: 14px;
				font-weight: normal;
				cursor: pointer;
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