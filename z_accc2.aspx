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
			aPop = [
				['txtXbpart', '', 'acpart', 'noa,part', 'txtXbpart', "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
				['txtXepart', '', 'acpart', 'noa,part', 'txtXepart', "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
			];
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_accc2');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_accc2',
					options : [{/*  [1]*/
						type : '0',
						name : 'accy',
						value : r_accy + "_" + r_cno
					}, {/*1-1 [2],[3]*/
						type : '1',
						name : 'date'
					}, {/*1-2 [4][5] 不含子科目*/
						type : '2',
						name : 'yacc',
						dbf : 'view_acc',
						index : 'acc1,acc2',
						src : "view_acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
					}, {/*1-4 [6][7]*/
						type : '2',
						name : 'part',
						dbf : 'part',
						index : 'noa,part',
						src : 'part_b.aspx'
					}, {/*1-1 [8],[9]*/
						type : '1',
						name : 'xbmon'
					}, {/*1-1 [10]*/
						type : '6',
						name : 'xbpart'
					}, {/*1-1 [11],[12]*/
						type : '1',
						name : 'xemon'
					}, {/*1-1 [13]*/
						type : '6',
						name : 'xepart'
					}, {/*  [14]*/
                        type : '0',
                        name : 'xlen',
                        value : r_len
                    }]
				});
				
				q_popAssign();
                q_getFormat();
                q_langShow();
				
				$('#txtDate1').mask('99/99');
				$('#txtDate2').mask('99/99');
				$('#txtXbmon1').mask(r_picm);
				$('#txtXbmon2').mask(r_picm);
				$('#txtXemon1').mask(r_picm);
				$('#txtXemon2').mask(r_picm);
				/*$('#txtDate1').mask(r_picd);
				$('#txtDate1').datepicker();
				$('#txtDate2').mask(r_picd);
				$('#txtDate2').datepicker();*/

				$('#Xbmon').css('width','370px');
				$('#txtXbpart').removeAttr('class').attr('class','c3 text');
				$('#Xbpart').css('width','230px');
				$('#Xemon').css('width','370px');
				$('#txtXepart').removeAttr('class').attr('class','c3 text');
				$('#Xepart').css('width','230px');
				
				$('#txtYacc1a').change(function(e) {
					var patt = /^(\d{4})([^\.,.]*)$/g;
					if(patt.test($(this).val()))
						$(this).val($(this).val().replace(patt,"$1.$2"));
					else if((/^(\d{4})$/).test($(this).val())){
						$(this).val($(this).val()+'.');
					}
				});
				$('#txtYacc2a').change(function(e) {
					var patt = /^(\d{4})([^\.,.]*)$/g;
					if(patt.test($(this).val()))
						$(this).val($(this).val().replace(patt,"$1.$2"));
					else if((/^(\d{4})$/).test($(this).val())){
						$(this).val($(this).val()+'.');
					}
				});
				
				if(q_getPara('acc.lockPart')=='1' && r_rank<8){
		        	$('#txtPart1a').val(r_partno);
		        	$('#txtPart1a').attr('Disabled','Disabled');
		        	$('#btnPart1').hide();
		        	$('#txtPart2a').val(r_partno);
		        	$('#txtPart2a').attr('Disabled','Disabled');
		        	$('#btnPart2').hide();
		        	
		        	$('#txtXbpart').val(r_partno);
		        	$('#txtXbpart').attr('Disabled','Disabled');
		        	$('#txtXepart').val(r_partno);
		        	$('#txtXepart').attr('Disabled','Disabled');
		        }
			}
			function q_boxClose(t_name) {
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
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