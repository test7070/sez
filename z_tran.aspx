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
			aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx'], ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx']);
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			function z_tran() {
			}


			z_tran.prototype = {
				isInit : false,
				data : {
					carteam : null,
					calctypes : null,
					calctype : null,
					carkind : null,
					acomp : null
				},
				isLoad : function() {
					var isLoad = true;
					for (var x in this.data) {
						isLoad = isLoad && (this.data[x] != null);
					}
					return isLoad;
				}
			};
			t_data = new z_tran();

			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_tran');
			});
			function q_gfPost() {
				q_gt('carteam', '', 0, 0, 0, "");
				q_gt('calctype2', '', 0, 0, 0, "calctypes");
				q_gt('carkind', '', 0, 0, 0, "");
				q_gt('acomp', '', 0, 0, 0);
				q_gt('calctype', '', 0, 0, 0);
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'carkind':
						t_data.data['carkind'] = '';
						var as = _q_appendData("carkind", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['carkind'] += (t_data.data['carkind'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
						}
						break;
					case 'carteam':
						t_data.data['carteam'] = '';
						var as = _q_appendData("carteam", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['carteam'] += (t_data.data['carteam'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						break;
					case 'calctype':
						t_data.data['calctype'] = '';
						var as = _q_appendData("calctype", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['calctype'] += (t_data.data['calctype'].length > 0 ? ',' : '') + 'calctype_' + as[i].noa + '@' + as[i].namea;
						}
						break;
					case 'calctypes':
						t_data.data['calctypes'] = '';
						var as = _q_appendData("calctypes", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['calctypes'] += (t_data.data['calctypes'].length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
						}
						break;
					case 'acomp':
						t_data.data['acomp'] = '';
						var as = _q_appendData("acomp", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['acomp'] += (t_data.data['acomp'].length > 0 ? ',' : '') + as[i].acomp;
						}
						break;
				}
		
				if (t_data.isLoad() && !t_data.isInit) {
					t_data.isInit  =  true;
					$('#q_report').q_report({
						fileName : 'z_tran',
						options : [{
							type : '0',
							name : 'accy',
							value : q_getId()[4]
						}, {/*1*/
							type : '1',
							name : 'date'
						}, {/*2*/
							type : '1',
							name : 'trandate'
						}, {/*3*/
							type : '2',
							name : 'cust',
							dbf : 'cust',
							index : 'noa,comp',
							src : 'cust_b.aspx'
						}, {/*4*/
							type : '2',
							name : 'driver',
							dbf : 'driver',
							index : 'noa,namea',
							src : 'driver_b.aspx'
						}, {/*5*/
							type : '6',
							name : 'xcarno'
						}, {/*6*/
							type : '6',
							name : 'xpo'
						}, {/*7*/
							type : '2',
							name : 'addr',
							dbf : 'addr',
							index : 'noa,addr',
							src : 'addr_b.aspx'
						}, {/*8*/
							type : '5',
							name : 'xacomp',
							value : t_data.data['acomp'].split(',')
						}, {/*9*/
							type : '5',
							name : 'xoption1',
							value : q_getMsg('toption1').split('&')
						}, {/*10*/
							type : '8',
							name : 'xoption2',
							value : q_getMsg('toption2').split('&')
						}, {/*11*/
							type : '8',
							name : 'xoption3',
							value : q_getMsg('toption3').split('&')
						}, {/*12*/
							type : '8',
							name : 'xcarteam',
							value : t_data.data['carteam'].split(',')
						}, {/*13*/
							type : '8',
							name : 'xcarkind',
							value : t_data.data['carkind'].split(',')
						}, {/*14*/
							type : '8',
							name : 'xcalctypes',
							value : t_data.data['calctypes'].split(',')
						},{/*15*/
							type : '6',
							name : 'zproduct'
						}, {/*16*/
							type : '6',
							name : 'zaddr'
						}, {/*17*/
							type : '6',
							name : 'zboatname'
						}, {/*18*/
							type : '6',
							name : 'zdelivery'
						}, {/*19*/
							type : '6',
							name : 'zplusmoney'
						}, {/*20*/
							type : '6',
							name : 'zminusmoney'
						}, {/*21*/
							type : '5',
							name : 'xsort8',
							value : q_getMsg('tsort8').split('&')
						}]
					});
					q_popAssign();
					q_langShow();

					$('#txtDate1').mask('999/99/99');
					$('#txtDate1').datepicker();
					$('#txtDate2').mask('999/99/99');
					$('#txtDate2').datepicker();
					$('#txtTrandate1').mask('999/99/99');
					$('#txtTrandate1').datepicker();
					$('#txtTrandate2').mask('999/99/99');
					$('#txtTrandate2').datepicker();
					
					$('#chkXcarteam').children('input').attr('checked','checked');
					$('#chkXcarkind').children('input').attr('checked','checked');
	                $('#chkXcalctypes').children('input').attr('checked','checked');
	                
					var t_date, t_year, t_month, t_day;
					t_date = new Date();
					t_date.setDate(1);
					t_year = t_date.getUTCFullYear() - 1911;
					t_year = t_year > 99 ? t_year + '' : '0' + t_year;
					t_month = t_date.getUTCMonth() + 1;
					t_month = t_month > 9 ? t_month + '' : '0' + t_month;
					t_day = t_date.getUTCDate();
					t_day = t_day > 9 ? t_day + '' : '0' + t_day;
					$('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);
					$('#txtTrandate1').val(t_year + '/' + t_month + '/' + t_day);
					t_date = new Date();
					t_date.setDate(35);
					t_date.setDate(0);
					t_year = t_date.getUTCFullYear() - 1911;
					t_year = t_year > 99 ? t_year + '' : '0' + t_year;
					t_month = t_date.getUTCMonth() + 1;
					t_month = t_month > 9 ? t_month + '' : '0' + t_month;
					t_day = t_date.getUTCDate();
					t_day = t_day > 9 ? t_day + '' : '0' + t_day;
					$('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
					$('#txtTrandate2').val(t_year + '/' + t_month + '/' + t_day);
				}

			}

			function q_boxClose(t_name) {
			}

		</script>
	</head>
	<body>
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