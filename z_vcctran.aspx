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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            aPop = new Array(['txtPartno', '', 'part', 'noa,part', 'txtPartno', "part_b.aspx"], ['txtCustno', '', 'cust', 'noa,part', 'txtCustno', "cust_b.aspx"], ['txtSalesno', '', 'sss', 'noa,namea', 'txtSalesno', "sss_b.aspx"]);
            
            t_init = false;
            t_part = '';
            t_acomp = '';
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_vcctran');
            });
            function q_gfPost() {
				q_gt('acomp', '', 0, 0, 0, "");
                q_gt('part', '', 0, 0, 0, "");
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        t_acomp = ' @全部';
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_acomp += (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        break;
                    case 'part':
                        t_part = '';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        break;
                }

                if (!t_init && t_part.length > 0 && t_acomp.length > 0) {
                    $('#q_report').q_report({
                        fileName : 'z_vcctran',
                        options : [{/*[1]*/
                            type : '0',
                            name : 'accy',
                            value : r_accy
                        }, {/*1-[2][3]-請款單號 1-1*/
                            type : '1',
                            name : 'xnoa'
                        }, {/*2-[4][5]-日期 1-2*/
                            type : '1',
                            name : 'date'
                        }, {/*3-[6][7]-客戶 1-4*/
                            type : '2',
                            name : 'cust',
                            dbf : 'cust',
                            index : 'noa,comp',
                            src : 'cust_b.aspx'
                        }, {/*4-[8][9]-部門 1-8*//*1*/
                            type : '2',
                            name : 'partno',
                            dbf : 'part',
                            index : 'noa,part',
                            src : 'part_b.aspx'
                        }, {/*5-[10][11] 2-1-月份*/
                            type : '1',
                            name : 'xmon'
                        }, {/*6-[12][13] 2-2-公司*/
                            type : '2',
                            name : 'acomp',
                            dbf : 'cust',
                            index : 'noa,acomp',
                            src : 'acomp_b.aspx'
                        }, {/*7-[14][15] 2-4-業務*/
                            type : '2',
                            name : 'salesno',
                            dbf : 'sss',
                            index : 'noa,namea',
                            src : 'sss_b.aspx'
                        }, {/*8-[16][17] 2-8-日期*//*2*/
	                        type : '1',
	                        name : 'ydate'
	                    }, {/*9-[18][19] 3-1-帳款月份*/
	                        type : '1',
	                        name : 'ymon'
	                    }, {/*10-[20]3-2-公司*/
                            type : '5',
                            name : 'yacomp',
                            value : t_acomp.split(',')
                        }, {/*11-[21][22]3-4-客戶*/
	                        type : '2',
	                        name : 'ycust',
	                        dbf : 'cust',
	                        index : 'noa,comp',
	                        src : 'cust_b.aspx'
	                    }, {/*12-[23]-部門3-8*//*4*/
                            type : '8',
                            name : 'ypart',
                            value : t_part.split(',')
                        }, {/*13-[24]-轉來類別 4-1*/
	                        type : '6',
	                        name : 'ykind'
	                    }, {/*14-[25]-類別 4-2*/
                        	type : '5', //select
                        	name : 'typea',
                        	value : [q_getPara('report.all')].concat(q_getPara('lab_accc.typea').split(','))
                   		}, {/*15-[26]-其他設定(明細) 4-4*/
                         	type : '8',
                            name : 'xfilter',
                            value : q_getMsg('tfilter').split('&')
                        }, {/*16-[27]-請款日期 4-8*//*5*/
	                        type : '6',
	                        name : 'xpaydate'
	                    }, {/*17-[28]-請款單號 5-1*/
							type : '6',
							name : 'xvccno'
						}, {/*18-[29]-排序方式 5-2*/
							type : '5',
							name : 'xsort3',
							value : q_getMsg('tsort3').split('&')
						}, {/*19-[30]-收款日期 5-4*/
							type : '1',
							name : 'ummdate'
						}]
                    	});
                    q_popAssign();
                    q_langShow();

                    $('#txtXmon1').mask('999/99');
                    $('#txtXmon2').mask('999/99');
                    $('#txtDate1').mask('999/99/99');
                    $('#txtDate1').datepicker();
                    $('#txtDate2').mask('999/99/99');
                    $('#txtDate2').datepicker();
                    $('#txtXpaydate').mask('999/99/99');
                    $('#txtXpaydate').datepicker();
                    
                    $('#chkYpart').children('input').attr('checked','checked');
                    
                    $('#txtYmon1').mask('999/99');
                    $('#txtYmon2').mask('999/99');
                    $('#txtYdate1').mask('999/99/99');
                    $('#txtYdate1').datepicker();
                    $('#txtYdate2').mask('999/99/99');
                    $('#txtYdate2').datepicker();

                    var t_noa = typeof (q_getId()[5]) == 'undefined' ? '' : q_getId()[5];
                    t_noa = t_noa.replace('noa=', '');
                    $('#txtXnoa1').val(t_noa);
                    $('#txtXnoa2').val(t_noa);

                    var t_date, t_year, t_month, t_day;
                    t_date = new Date();
                    t_date.setDate(1);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtXmon1').val(t_year + '/' + t_month);
                    $('#txtYmon1').val(t_year + '/' + t_month);

                    t_date = new Date();
                    t_date.setDate(35);
                    t_date.setDate(0);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtXmon2').val(t_year + '/' + t_month);
                    $('#txtYmon2').val(t_year + '/' + t_month);

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
                    $('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
                    $('#txtXnoa1').css("width", "90px");
                    $('#txtXnoa2').css("width", "90px");
                    
                    t_init=true;
                }
            }

            function q_boxClose(s2) {
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

