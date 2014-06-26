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
            aPop = new Array(['txtYacc1', '', 'acc', 'acc1,acc2', 'txtYacc1', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_gqb');

            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_gqb',
                    options : [{
                        type : '0',
                        name : 'accy',
                        value : r_accy + "_" + r_cno
                    }, {
                        type : '0',
                        name : 'ctypea',
                        value : q_getPara('gqb.typea')
                    }, {/*1*/
                        type : '5',
                        name : 'stype',
                        value : [q_getPara('report.all')].concat(q_getPara('gqb.typea').split(','))
                    }, {/*2*/
                        type : '5',
                        name : 'status',
                        value : [q_getPara('report.all')].concat(new Array('Y', 'N'))
                    }, {/*3*/
                        type : '1',
                        name : 'date'
                    }, {/*4*/
                        type : '1',
                        name : 'indate'
                    }, {/*5*/
                        type : '2',
                        name : 'bank',
                        dbf : 'bank',
                        index : 'noa,bank',
                        src : 'bank_b.aspx'
                    }, {/*6*/
                        type : '1',
                        name : 'gqbno'
                    }, {/*7*/
                        type : '5',
                        name : 'sort01',
                        value : q_getMsg('sort01').split('&')
                    }, {/*8*/
                        type : '1',
                        name : 'ydate'
                    }, {/*9 [16]*/
                        type : '6',
                        name : 'yacc1'
                    }, {/*10 [17][18]*/
                        type : '1',
                        name : 'xchkdate'
                    }, {/*11 [19][20]*/
                        type : '2',
                        name : 'xtcompno',
                        dbf : 'view_cust_tgg',
                        index : 'noa,comp',
                        src : 'view_cust_tgg_b.aspx'
                    }, {/*12 [21][22]*/
                        type : '2',
                        name : 'xcompno',
                        dbf : 'view_cust_tgg',
                        index : 'noa,comp',
                        src : 'view_cust_tgg_b.aspx'
                    }, {/*13 [23][24]*/
                        type : '1',
                        name : 'udate'
                    },{
						type : '0',
	                    name : 'r_tel',
	                    value : q_getPara('sys.tel')
					},{
	                    type : '0',
	                    name : 'r_addr',
	                    value : q_getPara('sys.addr')
					}]
                });
                q_popAssign();
                q_langShow();
				$('#txtR_tel').val(q_getPara('sys.tel'));
	            $('#txtR_addr').val(q_getPara('sys.addr'));
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtXchkdate1').mask('999/99/99');
                $('#txtXchkdate1').datepicker();
                $('#txtXchkdate2').mask('999/99/99');
                $('#txtXchkdate2').datepicker();

                $('#txtIndate1').mask('999/99/99');
                $('#txtIndate1').datepicker();
                $('#txtIndate2').mask('999/99/99');
                $('#txtIndate2').datepicker();
                
                $('#txtUdate1').mask('999/99/99');
                $('#txtUdate1').datepicker();
                $('#txtUdate2').mask('999/99/99');
                $('#txtUdate2').datepicker();
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                //$('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);
				//$('#txtIndate1').val(t_year + '/' + t_month + '/' + t_day);
                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                //$('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
                //$('#txtIndate2').val(t_year + '/' + t_month + '/' + t_day);

                $('#txtYdate1').mask('999/99/99');
                $('#txtYdate1').datepicker();
                $('#txtYdate2').mask('999/99/99');
                $('#txtYdate2').datepicker();

                $('#txtYacc1').change(function() {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');
                });
            }

            function q_boxClose(t_name) {
            }

            function q_gtPost(t_name) {
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