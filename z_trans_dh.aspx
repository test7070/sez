<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            var t_carteam = null;
            var t_calctypes = null;
            
            aPop = new Array(['txtXtggno', 'lblXtggno', 'tgg', 'noa,comp', 'txtXtggno', 'tgg_b.aspx']
        	,['txtXcardealno', 'lblXcardealno', 'acomp', 'noa,acomp', 'txtXcardealno', 'acomp_b.aspx']);
            
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_trans_dh');
            });
			
            function q_gfPost() {
                q_gt('carteam', '', 0, 0, 0, "load_1");
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'load_1':
                        t_carteam = '';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_carteam += (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_gt('calctype2', '', 0, 0, 0, "load_2");
                        break;
                    case 'load_2':
                        t_calctypes = '';
                        var as = _q_appendData("calctypes", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_calctypes += (t_calctypes.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                        }
                        LoadFinish();
                        break;
                    default:
                        break;
                }
            }
            function LoadFinish() {
            	$('#q_report').q_report({
                    fileName : 'z_trans_dh',
                    options : [{/*[1]-年度*/
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {/*1  [2][3]*/
                        type : '1',
                        name : 'xdate'
                    }, {/*2  [4][5]*/
                        type : '1',
                        name : 'xtrandate'
                    }, {/*3 [6]*/
                        type : '6',
                        name : 'xcarno'
                    }, {/*4 [7]*/
                        type : '6',
                        name : 'xtggno'
                    }, {/*5 [8]*/
                        type : '6',
                        name : 'xcardealno'
                    }, {/*6-[9]-車隊*/
                        type : '8',
                        name : 'xcarteam',
                        value : t_carteam.split(',')
                    }, {/*7-[10]-計算類別*/
                        type : '8',
                        name : 'xcalctype',
                        value : t_calctypes.split(',')
                    }, {/*8 [11],[12]*/
                        type : '2',
                        name : 'xcustno',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*9-[13],[14]-起迄地點*/
                        type : '2',
                        name : 'xaddr',
                        dbf : 'addr',
                        index : 'noa,addr',
                        src : 'addr_b.aspx'
                    }, {/*10 [15],[16]*/
                        type : '2',
                        name : 'xdriver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {/*11-[17]-pay*/
                        type : '8',
                        name : 'xpay',
                        value : ('pay@已立帳,unpay@未立帳').split(',')
                    }, {/*12-[18]-pay*/
                        type : '8',
                        name : 'xpay',
                        value : ('pay@已付款,unpay@未付款').split(',')
                    }, {/*13 [19][20]*/
                        type : '1',
                        name : 'mon'
                    },{/*14 [21][22]*/
                        type : '1',
                        name : 'xadate'
                    }, {/*15 [23]*/
                        type : '8',
                        name : 'xoption01',
                        value : q_getMsg('toption01').split('&')
                    }, {/*16 [24]*/
						type : '6',
						name : 'xnoa'
					}]
                });
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
                $('#txtXtrandate1').mask('999/99/99');
                $('#txtXtrandate1').datepicker();
                $('#txtXtrandate2').mask('999/99/99');
                $('#txtXtrandate2').datepicker();
                
                $('#chkXcarteam').children('input').attr('checked', 'checked');
                $('#chkXcalctype').children('input').attr('checked', 'checked');
                q_popAssign();
                q_langShow();
                
                t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
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

				t_date = new Date();
				t_date.setDate(35);
				t_date.setDate(0);
				t_year = t_date.getUTCFullYear() - 1911;
				t_year = t_year > 99 ? t_year + '' : '0' + t_year;
				t_month = t_date.getUTCMonth() + 1;
				t_month = t_month > 9 ? t_month + '' : '0' + t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day > 9 ? t_day + '' : '0' + t_day;
				$('#txtDate2').val(t_year + '/' + t_month + '/' + t_day );
				
				$('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
				
				$('#txtMon1').mask('999/99');
				$('#txtMon2').mask('999/99');
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