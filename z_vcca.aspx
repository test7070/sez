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
            t_cno = '';
            t_isinit = false;
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_vcca');
            });
            function q_gfPost() {
                q_gt('acomp', '', 0, 0, 0);
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        t_cno = '';
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_cno += (t_cno.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
                        }
                        t_cno += ',checkAll@全選';
                        LoadFinish();
                        break;
                }
            }

            function LoadFinish() {
                $('#q_report').q_report({
                    fileName : 'z_vcca',
                    options : [{/*0 [1]*/
                        type : '0',
                        name : 'accy',
                        value : r_accy
                    },{/*0 [2]*/
                        type : '0',
                        name : 'xworker',
                        value : r_name
                    }, {/*1 [3][4]*/
                        type : '1',
                        name : 'xmon'
                    }, {/*2 [5][6]*/
                        type : '1',
                        name : 'xdate'
                    }, {/*3 [7][8]*/
                        type : '2',
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*4 [9][10]*/
                        type : '2',
                        name : 'xproduct',
                        dbf : 'ucca',
                        index : 'noa,product',
                        src : 'ucca_b.aspx'
                    }, {/*5 [11]*/
                        type : '5',
                        name : 'xtype',
                        value : [' @全部','2@二聯','3@三聯']
                    }, {/*6 [12]*/
                        type : '8',
                        name : 'xcno',
                        value : t_cno.split(',')
                    }, {/*3 [13][14]*/
                        type : '2',
                        name : 'xtgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }]
                });
                q_popAssign();
                q_langShow();
                $('#txtXmon1').mask('999/99');
                $('#txtXmon2').mask('999/99');
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate2').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').datepicker();
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

                $("input[type='checkbox'][value='checkAll']").click(function() {
                    if ($(this).next('span').text() == '全選') {
                        $("input[type='checkbox'][value!='']").attr('checked', true);
                        $(this).removeAttr('checked');
                        $(this).next('span').text('取消全選');
                    } else if ($(this).next('span').text() == '取消全選') {
                        $("input[type='checkbox'][value!='']").removeAttr('checked');
                        $(this).next('span').text('全選');
                    }
                });
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