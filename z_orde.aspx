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
             if(location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;101";
            }
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_orde');
               
            });
            function q_gfPost() {
                $('#qReport').q_report({
                    fileName : 'z_orde',
                    options : [{
                        type : '0',//[1]
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '1',//[2][3]
                        name : 'xdate'
                    },{
                        type : '1',//[4][5]
                        name : 'xodate'
                    }, {
                        type : '2',//[6][7]
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2',//[8][9]
                        name : 'xsales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2',//[10][11]
                        name : 'xproduct',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {
                        type : '5', //[12]
                        name : 'xstype',
                        value : [q_getPara('report.all')].concat(q_getPara('orde.stype').split(','))
                    }, {
                        type : '5', //[13]
                        name : 'xtran',
                        value : [q_getPara('report.all')].concat(q_getPara('sys.tran').split(','))
                    }, {
                        type : '5', //[14]
                        name : 'xcancel',
                        value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
                    }, {
                        type : '5', //[15]
                        name : 'xend',
                        value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
                    }, {
                        type : '0', //[16] //判斷是否顯示規格
                        name : 'isspec',
                        value : q_getPara('sys.isspec')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
 				$('#txtXodate1').mask('999/99/99');
                $('#txtXodate1').datepicker();
                $('#txtXodate2').mask('999/99/99');
                $('#txtXodate2').datepicker();
                
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXodate1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXodate2').val(t_year + '/' + t_month + '/' + t_day);
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
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="qReport"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>