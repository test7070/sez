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
			var t_mech = '',t_ucc='';
			$(document).ready(function() {
				q_getId();
				q_gt('ucc', '', 0, 0, 0, "");
				
			});
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'ucc':
						t_ucc = '';
						var as = _q_appendData("ucc", "", true);
						for ( i = 0; i < as.length; i++) {
							t_ucc += (t_ucc.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].noa;
						}
						q_gt('mech', '', 0, 0, 0, "");	
						break;
					case 'mech':
						t_mech = '';
						var as = _q_appendData("mech", "", true);
						for ( i = 0; i < as.length; i++) {
							t_mech += (t_mech.length > 0 ? '&' : '') + as[i].noa + '@' + as[i].mech;
						}
						q_gf('', 'z_cutp');
						break;
				}
			}
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_cutp',
					options : [{
						type : '0', //[1]
						name : 'r_tel',
						value : q_getPara('sys.tel')
					}, {
						type : '0', //[2]
						name : 'accy',
						value : r_accy
					}, {
						type : '6', //[3]       1
						name : 'xnoa'
					}, {
						type : '1', //[4][5]    2
						name : 'date'
					}, {
						type : '2', //[6][7]    3
						name : 'tggno',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '2', //[8][9]     4
						name : 'mechno',
						dbf : 'mech',
						index : 'noa,mech',
						src : 'mech_b.aspx'
					}, {
						type : '0', //[10]
						name : 's_typea2',
						value : q_getPara('cut.type2')
					}, {
						type : '0', //[11]
						name : 's_typea2A',
						value : q_getPara('cut.type2A')
					}, {
						type : '8', //[12]       5
						name : 'xprintsize',
						value : "1@".split(',')
					}, {
						type : '8', //[13]        6
						name : 'xprintmemo',
						value : "1@".split(',')						
					}, {
						type : '0', //[14]
						name : 'proj',
						value : q_getPara('sys.project')			
					}, {
						type : '5', //[15]        7
						name : 'xbproduct',
						value : t_ucc.split('&')
					}, {
						type : '5', //[16]        8
						name : 'xeproduct',
						value : t_ucc.split('&')
					},{
                        type : '8',//[17]  9
                        name : 'xmech',
                        value : t_mech.split('&')
                    },{
                        type : '8',//[18]  10
                        name : 'xoption',
                        value : 'cut@裁剪作業&cubm@機台排程'.split('&')
                    }]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				
				if(q_getPara('sys.project')=='pe'){					
					$('#q_report div div').eq(1).hide();
					$('#q_report div div span').eq(1).text('裁剪單');
				}
				
				var t_no = typeof (q_getId()[3]) == 'undefined' ? '' : q_getId()[3];
				if (t_no.indexOf('noa=') >= 0) {
					t_no = t_no.replace('noa=', '');
					if (t_no.length > 0) {
						$('#txtXnoa').val(t_no);
					}
				}
				$('#chkXprintmemo input[type=checkbox]').prop('checked',true);
				$('#txtDate1').mask('999/99/99');
				$('#txtDate1').datepicker();
				$('#txtDate2').mask('999/99/99');
				$('#txtDate2').datepicker();
				
				$('#Xbproduct select').change(function(e){
					$('#Xeproduct select').val($('#Xbproduct select').val());
				});
				
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