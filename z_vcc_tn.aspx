<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="/../script/jquery.min.js" type="text/javascript"></script>
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
            var gfrun = false;
            var cnoItem = '';
            var processItem = '';

            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;103";
            }
            
            $(document).ready(function() {
                q_getId();
                if (cnoItem.length == 0) {
                    q_gt('acomp', '', 0, 0, 0, "");
                }
                if (processItem.length == 0) {
                    q_gt('process', '', 0, 0, 0, "");
                }
            });
            
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_vcc_tn',
                    options : [{
                        type : '0', //[1] 
                        name : 'accy',
                        value : q_getId()[4]
                    },{
                        type : '5', //[2]//1
                        name : 'xcno',
                        value : cnoItem.split(',')
                    }, {
                        type : '1', //[3][4]//2
                        name : 'datea'
                    },{
						type : '1',//[5][6]//4
						name : 'ordeno'
					},{
                        type : '2', //[7][8]//8
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
						type : '8', //[9]//10
						name : 'xprocess',
						value : (processItem).split(',')
					}]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                $('#txtDatea1').mask('999/99/99');
                $('#txtDatea1').datepicker();
                $('#txtDatea2').mask('999/99/99');
                $('#txtDatea2').datepicker();

                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDatea1').val(t_year + '/' + t_month + '/' + t_day);

                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear() - 1911;
                t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDatea2').val(t_year + '/' + t_month + '/' + t_day);
                
                $("input[type='checkbox'][value!='']").attr('checked', true);
                $("input[type='checkbox'][value='checkAll']").removeAttr('checked');
                $("input[type='checkbox'][value='checkAll']").next('span').text('取消全選');

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
            
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        cnoItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            cnoItem = cnoItem + (cnoItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
                        }
                        break;
					case 'process':
                        var as = _q_appendData("process", "", true);
                        processItem = "";
                        for ( i = 0; i < as.length; i++) {
                            processItem = processItem + (processItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].process;
                        }
                        processItem += ',checkAll@全選';
                        break;
                }
                if (cnoItem.length > 0 && processItem.length > 0 && !gfrun) {
                    gfrun = true;
                    q_gf('', 'z_vcc_tn');
                }
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
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>