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
			aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx'], ['txtCarno1', '', 'car2', 'a.noa,driverno,driver', 'txtCarno1', 'car2_b.aspx'], ['txtCarno2', '', 'car2', 'a.noa,driverno,driver', 'txtCarno2', 'car2_b.aspx'], ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx']);
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			function z_tran() {
			}
			z_tran.prototype = {
				isInit : false, data : {
					carteam : null, calctypes : null, calctype : null, carkind : null, acomp : null
				}, isLoad : function() {
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
				q_gf('', 'z_carcs');
			});
			function q_gfPost() {
				q_gt('carteam', '', 0, 0, 0, "");
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'carteam':
						t_data.data['carteam'] = '';
						var as = _q_appendData("carteam", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['carteam'] += (t_data.data['carteam'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						q_gt('calctype2', '', 0, 0, 0, "calctypes");
						break;
					case 'calctypes':
						t_data.data['calctypes'] = '';
						var as = _q_appendData("calctypes", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['calctypes'] += (t_data.data['calctypes'].length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
						}
						q_gt('carkind', '', 0, 0, 0, "");
						break;
					case 'carkind':
						t_data.data['carkind'] = '';
						var as = _q_appendData("carkind", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['carkind'] += (t_data.data['carkind'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
						}
						q_gt('acomp', '', 0, 0, 0);
						break;
					case 'acomp':
						t_data.data['acomp'] = '';
						var as = _q_appendData("acomp", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['acomp'] += (t_data.data['acomp'].length > 0 ? ',' : '') + as[i].acomp;
						}
						q_gt('calctype', '', 0, 0, 0);
						break;
					case 'calctype':
						t_data.data['calctype'] = '';
						var as = _q_appendData("calctype", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['calctype'] += (t_data.data['calctype'].length > 0 ? ',' : '') + 'calctype_' + as[i].noa + '@' + as[i].namea;
						}
						loadFinish();
						break;
				}
			}
			function loadFinish(){
				$('#q_report').q_report({
					fileName : 'z_carcs', options : [{//[1]
						type : '0', name : 'accy', value : q_getId()[4]
					}, {/*1*///[2][3]
						type : '1', name : 'date'
					}, {/*2*///[4][5]
						type : '1', name : 'carno'
					}, {/*3*///[6][7]
						type : '2', name : 'driver', dbf : 'driver', index : 'noa,namea', src : 'driver_b.aspx'
					}, {/*4*///[8]
						type : '8', name : 'xtypea', value : q_getPara('z_carcs.typea').split(',')
					}, {/*5*///[9][10]
						type : '1', name : 'trandate'
					}, {/*6*///[11][12]
						type : '2', name : 'cust', dbf : 'cust', index : 'noa,comp', src : 'cust_b.aspx'
					}, {/*7*///[13]
						type : '6', name : 'xcarno'
					}, {/*8*///[14]
						type : '6', name : 'xpo'
					}, {/*9*///[15][16]
						type : '2', name : 'addr', dbf : 'addr', index : 'noa,addr', src : 'addr_b.aspx'
					}, {/*10*///[17]
						type : '8', name : 'xcarteam', value : t_data.data['carteam'].split(',')
					}, {/*11*///[18]
						type : '8', name : 'xcalctypes', value : t_data.data['calctypes'].split(',')
					}, {/*12*///[19]
						type : '5', name : 'xsort8', value : q_getMsg('tsort08').split('&')
					}, {/*13*///[20]
						type : '8', name : 'xfield05', value : q_getMsg('tfield05').split('&')
					}, {/*14*///[21]
						type : '5', name : 'xsort03', value : q_getMsg('tsort03').split('&')
					}, {/*15*///[22]
						type : '8', name : 'xcarkind', value : t_data.data['carkind'].split(',')
					}, {/*16*///[23]
						type : '8', name : 'cartype', value : q_getPara('car2.cartype').split(',')
					}, {/*17*///[24]
						type : '6', name : 'xmon'
					}, {/*18*///[25]
						type : '5', name : 'xinterval', value : [q_getPara('report.all')].concat(q_getPara('carcsa.interval').split(','))
					}, {/*19*///[26]
						type : '5', name : 'xcno', value : [q_getPara('report.all')].concat(t_data.data['acomp'].split(','))
					}, {//[27]
						type : '0', name : 'cinterval', value : q_getPara('carcsa.interval')
					}, {/*20*///[28]
						type : '6', name : 'xboatno'
					}, {/*21*///[29]
                        type : '5', name : 'xisoutside', value : ['#non@全部','N@公司車','Y@外車']
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
				$('#txtXmon').mask('999/99');
				$('#chkXcarteam').children('input').attr('checked', 'checked');
				$('#chkXcarkind').children('input').attr('checked', 'checked');
				$('#chkXcalctypes').children('input').attr('checked', 'checked');
				$('#chkXfield05').children('input').attr('checked', 'checked');
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
				$('#txtXmon').val(t_year + '/' + t_month);
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
			function q_boxClose(t_name) {
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