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
            aPop = new Array();
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_genz');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_genz',
                    options : [{
                        type : '0',//[1]
                        name : 'accy',
                        value : r_accy
                    }, {
                        type : '1',//[2][3]
                        name : 'date'
                    }, {
                        type : '2',//[4][5]
                        name : 'ucca',
                        dbf : 'ucca',
                        index : 'noa,product',
                        src : 'ucca_b.aspx'
                    }, {
                        type : '6',//[6]
                        name : 'xdate'
                    }, {
                        type : '8',//[7]
                        name : 'aberrant',
                        value : ('異常').split(',')
                    }, {
                        type : '8',//[8]
                        name : 'moneymeau',
                        value : ('結存金額明細表').split(',')
                    }, {
                        type : '8',//[9]
                        name : 'saleprice',
                        value : ('銷售金額').split(',')
                    }, {
                        type : '8',//[10]
                        name : 'gro',
                        value : ('毛利率').split(',')
                    }, {
                        type : '6',//[11]
                        name : 'xmon'
                    }]
                });
                
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtDate1').mask(r_picd);
                $('#txtDate2').mask(r_picd);
                $('#txtXdate').mask(r_picd);
                $('#txtXmon').mask('999/99');
                
                var r_1911=1911;
				if(r_len==4){//西元年
					r_1911=0;
					$.datepicker.r_len=4;
                    $('#txtDate1').datepicker();
                    $('#txtDate2').datepicker();
                    $('#txtXdate').datepicker();
				}else{
	                $('#txtDate1').datepicker();
	                $('#txtDate2').datepicker();
	                $('#txtXdate').datepicker();
               }

                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);
                $('#txtXmon').val(t_year + '/' + t_month);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - r_1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
                $('#txtXmon2').val(t_year + '/' + t_month);
                $('#txtXdate').val(q_date());
                
                $('#Aberrant').css('width', '300px').css('height', '30px');
                $('#Aberrant .label').css('width','0px');
                $('#chkAberrant').css('width', '220px').css('margin-top', '5px');
                $('#chkAberrant span').css('width','180px')
                $('#Moneymeau').css('width', '300px').css('height', '30px');
                $('#Moneymeau .label').css('width','0px');
                $('#chkMoneymeau').css('width', '220px').css('margin-top', '5px');
                $('#chkMoneymeau span').css('width','180px')
                $('#Saleprice').css('width', '300px').css('height', '30px');
                $('#Saleprice .label').css('width','0px');
                $('#chkSaleprice').css('width', '220px').css('margin-top', '5px');
                $('#chkSaleprice span').css('width','180px')
                $('#Gro').css('width', '300px').css('height', '30px');
                $('#Gro .label').css('width','0px');
                $('#chkGro').css('width', '220px').css('margin-top', '5px');
                $('#chkGro span').css('width','180px')
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
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>