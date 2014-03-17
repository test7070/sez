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
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_ordbp');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_ordbp',
					options : [{/*1*/
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					}, {/*1*/
						type : '1',
						name : 'xnoa'
					}, {/*2*/
						type : '5',
						name : 'xkind',
						value : [q_getPara('report.all')].concat(q_getPara('ordb.kind').split(','))
					}, {/*3*/
						type : '1',
						name : 'xdate'
					}, {/*4*/
						type : '2',
						name : 'xcno',
						dbf : 'acomp',
						index : 'noa,acomp',
						src : 'acomp_b.aspx'
					}, {/*5*/
						type : '2',
						name : 'xtggno',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {/*6*/
						type : '2',
						name : 'xproductno',
						dbf : 'bcc',
						index : 'noa,product',
						src : 'bcc_b.aspx'
					}, {/*7*/
                        type : '1',
                        name : 'yodate'
                    }, {/*8*/
                        type : '2',
                        name : 'yproductno',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {/*9*/
                        type : '6',
                        name : 'yordbno'
                    }, {/*10*/
                        type : '6',
                        name : 'yordeno'
                    }, {/*11*/
                        type : '6',
                        name : 'yworkgno'
                    }]
				});
				q_popAssign();

				$('#txtXdate1').mask('999/99/99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99/99');
				$('#txtXdate2').datepicker();
				
				$('#txtYodate1').mask('999/99/99');
                $('#txtYodate1').datepicker();
                $('#txtYodate2').mask('999/99/99');
                $('#txtYodate2').datepicker();
                
                         
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
				var t_para = (typeof (q_getId()[3]) == 'undefined' ? '' : q_getId()[3]).split('&');
                for(var i=0;i<t_para.length;i++){
                    if(t_para[i].indexOf('noa=') >= 0){
                        t_no = t_para[i].replace('noa=', '');
                        if (t_no.length > 0) {
                            $('#txtYordbno').val(t_no);
                        }
                    }else if(t_para[i]=='action=z_ordbp06'){
                        $('#q_report').find('span.radio').eq(5).parent().click();
                        $('#q_report').data('info').execute($('#q_report'));
                    }    
                } 
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