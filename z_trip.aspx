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
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_trip');
            });
            function q_gfPost() {

                $('#q_report').q_report({
                    fileName : 'z_trip',
                    options : [{
                        type : '1',
                        name : 'date'
                    }, {
                        type : '2',
                        name : 'sssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2',
                        name : 'partno',
                        dbf : 'part',
                        index : 'noa,part',
                        src : 'part_b.aspx'
                    }]
                });

                q_popAssign();
                q_langShow();
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();

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
                
                if(r_rank <7){
                	q_gt('sss', "where=^^noa='" + r_userno + "'^^", 0, 0,0,"");
                }
                
            }

            function q_boxClose(s2) {
            }
			
			var ssspartno=r_partno,ssspart='';
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'sss':
                		var as = _q_appendData('sss', '', true);
						if(as[0]){
							ssspartno=as[0].partno;
							ssspart=as[0].part;
							q_gt('authority', "where=^^a.noa='trip' and a.sssno='" + r_userno + "'^^", 0, 0,0,"");
						}
                		break;
                	case 'authority':
						var as = _q_appendData('authority', '', true);
                        if (as[0] != undefined) {
							if (as.length > 0 && as[0]["pr_modi"] == "true"){
								$('#txtPartno1a').val(ssspartno).attr('disabled', 'disabled');
								$('#txtPartno1b').val(ssspart);
								$('#txtPartno2a').val(ssspartno).attr('disabled', 'disabled');
								$('#txtPartno2b').val(ssspart);
							}else{
								$('#txtSssno1a').val(r_userno).attr('disabled', 'disabled');
								$('#txtSssno1b').val(r_name);
								$('#txtSssno2a').val(r_userno).attr('disabled', 'disabled');
								$('#txtSssno2b').val(r_name);
							}
						}
                		break;
                }
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

