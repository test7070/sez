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
					options : [{/* [1]*/
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					}, {/*1 [2][3]*/
						type : '1',
						name : 'xnoa'
					}, {/*2 [4]*/
						type : '5',
						name : 'xkind',
						value : [q_getPara('report.all')].concat(q_getPara('ordb.kind').split(','))
					}, {/*3 [5][6]*/
						type : '1',
						name : 'xdate'
					}, {/*4 [7][8]*/
						type : '2',
						name : 'xcno',
						dbf : 'acomp',
						index : 'noa,acomp',
						src : 'acomp_b.aspx'
					}, {/*5 [9][10]*/
						type : '2',
						name : 'xtggno',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {/*6 [11][12]*/
						type : '2',
						name : 'xproductno',
						dbf : 'bcc',
						index : 'noa,product',
						src : 'bcc_b.aspx'
					}, {/*7 [13][14]*/
                        type : '1',
                        name : 'yodate'
                    }, {/*8 [15][16]*/
                        type : '2',
                        name : 'yproductno',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {/*9 [17]*/
                        type : '6',
                        name : 'yordbno'
                    }, {/*10 [18]*/
                        type : '6',
                        name : 'yordeno'
                    }, {/*11 [19]*/
                        type : '6',
                        name : 'yworkgno'
                    },{/* [20]*/
                        type : '0',
                        name : 'ykind',
                        value : q_getPara('ordb.kind')
                    }
                    //---追蹤表用----------------------------------------------------------
                   , {/*12 [21][22]*/
                        type : '1',
                        name : 'zdatea'
                    }, {/*13 [23][24]*/
                        type : '1',
                        name : 'zldate'
                    }, {/*14 [25][26]*/
                        type : '2',
                        name : 'zproductno',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    },{/*15 [27]*/
                        type : '5',
                        name : 'zordc',
                        value : [q_getPara('report.all')].concat('1@已採購,2@未採購'.split(','))
                    }
                    //---追蹤表用----------------------------------------------------------
                    ,{/*16 [28]*/
                        type : '5',
                        name : 'showquat',
                        value : '#non@未詢價且未議價,1@未詢價,2@未議價'.split(',')
                    }, {/*17 [29]*/
                        type : '6',
                        name : 'zordbno'
                    }, {/*18 [30][31]*/
                        type : '1',
                        name : 'znoa'
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
                
                $('#txtZdatea1').mask('999/99/99');
                $('#txtZdatea1').datepicker();
                $('#txtZdatea2').mask('999/99/99');
                $('#txtZdatea2').datepicker();
                
                $('#txtZldate1').mask('999/99/99');
                $('#txtZldate1').datepicker();
                $('#txtZldate2').mask('999/99/99');
                $('#txtZldate2').datepicker();
                
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
                            $('#txtZordbno').val(t_no);
                            $('#txtZnoa1').val(t_no);
                            $('#txtZnoa2').val(t_no);
                        }
                    }else if(t_para[i]=='action=z_ordbp06'){
                        $('#q_report').find('span.radio').eq(5).parent().click();
                        $('#q_report').data('info').execute($('#q_report'));
                    }    
                } 
                $('.c4').css("width","120px");
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