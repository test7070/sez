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
            aPop = new Array(['txtTcarno1', '', 'car2', 'a.noa,carownerno,carowner', 'txtTcarno1', 'car2_b.aspx'], ['txtTcarno2', '', 'car2', 'a.noa,carownerno,carowner', 'txtTcarno2', 'car2_b.aspx']);
            t_item = "";

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_car2_rj');
                $('#carnotice').hide();

                $('#btnNotice').click(function() {
                    var xbdate = !emp($('#textBdate').val()) ? $('#textBdate').val() : '';
                    var xedate = !emp($('#textEdate').val()) ? $('#textEdate').val() : '999/99/99';
                    var xsssno = !emp($('#textSSSno').val()) ? $('#textSSSno').val() : sssno;
                    var sss_sql = '';
                    var sssno_count = 0;
                    //檢查最後一個是否有.
                    if (xsssno.substr(xsssno.length - 1, xsssno.length) == '.')
                        xsssno = xsssno.substr(0, xsssno.length - 1);

                    while (xsssno.indexOf('.') > -1) {
                        if (sssno_count == 0)
                            sss_sql += "and (sssno='" + xsssno.substr(0, xsssno.indexOf('.')) + "' "
                        else
                            sss_sql += "or sssno='" + xsssno.substr(0, xsssno.indexOf('.')) + "' "
                        sssno_count++;
                        xsssno = xsssno.substr(xsssno.indexOf('.') + 1, xsssno.length);
                    }

                    if (sssno_count > 0)
                        sss_sql += "or sssno='" + xsssno + "')";
                    else
                        sss_sql += "and sssno='" + xsssno + "'"

                    //不顯示報停
                    q_box("carnotice.aspx?" + r_userno + ";" + r_name + ";" + q_id + ";(a.checkdate between '" + xbdate + "' and '" + xedate + "' ) " + sss_sql + " and (a.enddate='' or a.enddate is null) and (a.outdate='' or a.outdate is null) and (a.wastedate='' or a.wastedate is null) and (a.suspdate='' or a.suspdate is null);" + r_accy, 'car2', "90%", "600px", q_getMsg("popNotice"));
                });

            });

            function q_gfPost() {

                q_getPara('car2.cartype')

                $('#q_report').q_report({
                    fileName : 'z_car2_rj',
                    options : [{//[1]
                        type : '0',
                        name : 'cartype',
                        value : q_getPara('car2.cartype')
                    }, {//1   [2][3]
                        type : '1',
                        name : 'date'
                    }, {//2   [4][5]
                        type : '2',
                        name : 'carowner',
                        dbf : 'carowner',
                        index : 'noa,namea',
                        src : 'carowner_b.aspx'
                    }, {//3   [6][7]
                        type : '2',
                        name : 'driver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {//4   [8]
                        type : '6',
                        name : 'xcarno'
                    }, {//5   [9]
                        type : '8',
                        name : 'xcartype',
                        value : q_getPara('car2.cartype').split(',')
                    }]
                });
                q_getFormat();
                q_langShow();
                q_popAssign();
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
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
                $('#txtXdate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_year + '/' + t_month + '/' + t_day);
            }

            function q_boxClose(s2) {
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
			<div id="carnotice">
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:300px">
					<tr>
						<td align="center" style="width:35%"><a id="lblxDatea" class="lbl">日期</a></td>
						<td align="left" style="width:65%">
						<input id="textBdate"  type="text"  class="txt" style="width: 40%;"/>
						~
						<input id="textEdate"  type="text"  class="txt" style="width: 40%;"/>
						</td>
					</tr>
					<tr>
						<td align="center" style="width:35%"><a id="lblxSSSno" class="lbl">管理者</a></td>
						<td align="left" style="width:65%">
						<input id="textSSSno"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td align="center" colspan="2">
						<input id="btnNotice" type="button" />
						</td>
					</tr>
				</table>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>