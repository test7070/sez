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
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_uselab');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_uselab',
					options : [{//[1]
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					}, {//[2][3]
						type : '2',
						name : 'custno',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {/*[4][5]*/
						type : '1',
						name : 'xmon'
					}, {
						type : '0', //[6] 
						name : 'xproject',
						value : q_getPara('sys.project').toUpperCase()
					}, {//[7][8]
						type : '2',
						name : 'tggno',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {/*[9]*/
                        type : '5',
                        name : 'typea',
                        value : 'comp@公司,fact@工廠,invo@發票,home@通信'.split(',')
                    }, {//[10][11]
						type : '2',
						name : 'xcno',
						dbf : 'acomp',
						index : 'noa,acomp',
						src : 'acomp_b.aspx'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				$('#txtXmon1').mask(r_picm);
				$('#txtXmon2').mask(r_picm);
				$('#txtXmon1').val(q_date().substr(0,r_lenm));
				$('#txtXmon2').val(q_date().substr(0,r_lenm));
				
				$('#btnOk').before($('#btnOk').clone().attr('id', 'btnOk2').attr('value','查詢').show()).hide();
				$('#btnOk2').click(function() {
					var t_invoice = $.trim($('#txtYnoa').val());
					var bno = $.trim($('#txtcustno1').val());
					var eno = $.trim($('#txtcustno2').val());
					switch($('#q_report').data('info').radioIndex) {
						case 12:
							window.open("./pdf_uselab13.aspx?db="+q_db+"&bno="+$('#txtcustno1').val()+"&eno="+$('#txtcustno2').val());
							break;
                  		default:
                  			$('#result').hide();
                  			$('#btnOk').click();
                  			break;
                  	}
					
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
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
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