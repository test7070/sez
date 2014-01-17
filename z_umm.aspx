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
            aPop = new Array(['txtXpart', '', 'part', 'noa,part', 'txtXpart', "part_b.aspx"]);
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_umm');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_umm',
                    options : [{
                        type : '6', //[1]
                        name : 'xcno'
                    }, {
                        type : '6', //[2]
                        name : 'xpart'
                    }, {
                        type : '1', //[3][4]
                        name : 'date'
                    }, {
                        type : '2', //[5][6]
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '1', //[7][8]
                        name : 'xdate'
                    }, {
                        type : '0',
                        name : 'accy', //[9]
                        value : r_accy + "_" + r_cno
                    }, {
                        type : '0', //[10]
                        name : 'xaccy',
                        value : r_accy
                    }, {
                        type : '2', //[11][12]
                        name : 'scno',
                        dbf : 'acomp',
                        index : 'noa,acomp',
                        src : 'acomp_b.aspx'
                    }, {
                        type : '1', //[13][14]
                        name : 'smon'
                    }, {
                        type : '2', //[15][16]
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2', //[17][18]
                        name : 'product',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    }, {
                        type : '6', //[19]
                        name : 'xmemo'
                    }, {
                        type : '6', //[20]
                        name : 'paytype'
                    },{
						type : '0', //[21] //判斷vcc是內含或應稅 內含不抓vcca
						name : 'vcctax',
						value : q_getPara('sys.d4taxtype')
					}, {
                        type : '8', //[22]
                        name : 'showunpay', //只顯示未收
                        value : "1@只顯示未收".split(',')
	                }]
                });
                q_popAssign();
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtXdate1').mask('99/99');
                $('#txtXdate2').mask('99/99');
                $('#txtSmon1').mask('999/99');
                $('#txtSmon2').mask('999/99');
                $('#Xmemo').removeClass('a2').addClass('a1');
                $('#txtXmemo').css('width', '85%');
                $('.q_report .report').css('width', '420px');
                $('.q_report .report div').css('width', '200px');

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
                $('#txtSmon1').val(t_year + '/' + t_month);
                $('#txtSmon2').val(t_year + '/' + t_month);

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
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate1').val(t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtXdate2').val(t_month + '/' + t_day);
                
                var tmp = document.getElementById("txtPaytype");
                var selectbox = document.createElement("select");
                selectbox.id="combPay";
                selectbox.style.cssText ="width:15px;font-size: medium;";
                //selectbox.attachEvent('onchange',combPay_chg);
                //selectbox.onchange="combPay_chg";
                tmp.parentNode.appendChild(selectbox,tmp);
                q_cmbParse("combPay", '全部,'+q_getPara('vcc.paytype')); 
                $('#txtPaytype').val('全部');
                
                $('#combPay').change(function() {
					var cmb = document.getElementById("combPay")
		                $('#txtPaytype').val(cmb.value);
				});
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

