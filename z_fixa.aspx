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
			aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx']
			,['txtXcarplateno', 'lblXcarplate', 'carplate', 'noa,carplate,driver', 'txtXcarplateno', 'carplate_b.aspx']
			,['txtXproductno', 'lblXproductno', 'fixucc', 'noa,namea', 'txtXproductno', 'fixucc_b.aspx']);
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_fixa');
			});  
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_fixa',
					options : [{//[1]
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					},{//[2]
						type : '0',
						name : 'namea',
						value : r_name
					}, {/*1 [3],[4]*/
						type : '1',
						name : 'mon'
					}, {/*2 [5]*/
						type : '6',
						name : 'xcarno'
					}, {/*3 [6]*/
						type : '6',
						name : 'xcarplateno'
					}, {/*4 [7],[8]*/
						type : '2',
						name : 'driver',
						dbf : 'driver',
						index : 'noa,namea',
						src : 'driver_b.aspx'
					}, {/*5 [9]*/
						type : '6',
						name : 'xmoney'
					}, {/*6 [10],[11]*/
						type : '2',
						name : 'tgg',
						dbf : 'tgg',
						index : 'noa,nick',
						src : 'tgg_b.aspx'
					}, {/*7 [12],[13]*/
						type : '2',
						name : 'xproduct',
						dbf : 'fixucc',
						index : 'noa,namea',
						src : 'fixucc_b.aspx'
                    }, {/*8 [14]*/
	                    type : '5', //select
	                    name : 'xorder',
	                    value : ('車號,司機,維修日期,料名編號').split(',')
 					}, {/*9 [15],[16]*/
						type : '1',
						name : 'date'
					}, {/*10 [17],[18]*/
						type : '1',
						name : 'ydate'
					}, {/*11 [19],[20]*/
						type : '1',
						name : 'yfixadate'
					}, {/*12 [21],[22]*/
						type : '2',
						name : 'ytgg',
						dbf : 'tgg',
						index : 'noa,nick',
						src : 'tgg_b.aspx'
					}, {/*13 [23]*/
						type : '6',
						name : 'ycarno'
					}, {/*14 [24]*/
						type : '6',
						name : 'ycarplateno'
					}, {/*15 [25]*/
						type : '6',
						name : 'ymoney'
					}, {/*16 [26]*/
                        type : '8',
                        name : 'xoption01',
                        value : q_getMsg('toption01').split('&')
                    }]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();

				$('#txtMon1').mask('999/99');
				$('#txtMon2').mask('999/99');
				$('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                
                $('#txtYdate1').mask('999/99/99');
                $('#txtYdate1').datepicker();
                $('#txtYdate2').mask('999/99/99');
                $('#txtYdate2').datepicker();
				$('#txtYfixadate1').mask('999/99/99');
                $('#txtYfixadate1').datepicker();
                $('#txtYfixadate2').mask('999/99/99');
                $('#txtYfixadate2').datepicker();
                
				var t_date, t_year, t_month, t_day;
				t_date = new Date();
				t_date.setDate(1);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtMon1').val(t_year + '/' + t_month);

				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtMon2').val(t_year + '/' + t_month);
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
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

