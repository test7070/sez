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
            aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx']);
            t_carkind = '';
            t_oilkind = '';
            t_isinit = false;
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_oil');
            });
            function q_gfPost() {
				q_gt('carkind', '', 0, 0, 0, "");
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'carkind':
                        t_carkind = '';
                        var as = _q_appendData("carkind", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_carkind += (t_carkind.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
                        }
                        q_gt('oilstation', '', 0, 0, 0, "");
                        break;
                     case 'oilstation':
                        var as = _q_appendData("oilstation", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_oilkind += (t_oilkind.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].station;
                        }
                        setting();
                        break;
                }
            }
            function q_boxClose(s2) {
            }
            function setting(){
                $('#q_report').q_report({
                    fileName : 'z_oil',
                    options : [{/*[1]*/
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {/*1-1-[2][3]日期*/
                        type : '1',
                        name : 'date'
                    }, {/*1-2-[4][5]加油日期*/
                        type : '1',
                        name : 'xoildate'
                    }, {/*1-4-[6]-車號*/
                        type : '6',
                        name : 'xcarno'
                    }, {/*1-8-[7][8]-司機*//*01*/
                        type : '2',
                        name : 'driver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {/*4[9][10]-站名*/
                        type : '2',
                        name : 'oilstation',
                        dbf : 'oilstation',
                        index : 'noa,station',
                        src : 'oilstation_b.aspx'
                    }, {/*5-[11][12]-月份*/
                        type : '1',
                        name : 'mon'
                    }, {/*6-[13]車別*/
                        type : '8',
                        name : 'xcarkind',
                        value : t_carkind.split(',')
                    }, {/*7-[14]儲油槽*/
                        type : '8',
                        name : 'xoilkind',
                        value : t_oilkind.split(',')
                    }]
                });
                q_popAssign();
                q_langShow();
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtXoildate1').mask('999/99/99');
                $('#txtXoildate1').datepicker();
                $('#txtXoildate2').mask('999/99/99');
                $('#txtXoildate2').datepicker();
                
                $('#txtMon1').mask('999/99');
                $('#txtMon2').mask('999/99');
				$('#chkXcarkind').children('input').attr('checked', 'checked');
				
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
                $('#txtXoildate1').val(t_year + '/' + t_month + '/' + t_day);

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
                $('#txtXoildate2').val(t_year + '/' + t_month + '/' + t_day);

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

