<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_kpisale');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_kpisale',
					options : [{
						type : '0',
						name : 'accy',
						value : q_getId()[4] //[1]
					},{
						type : '1',
						name : 'xdate'
					},{
						type : '2',
						name : 'xucc',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					},{
						type : '8',
						name : 'aberrant',
						value : ('1@異常篩選').split(',')
					},{
						type : '6',
						name : 'xkpi_1'
					},{
						type : '6',
						name : 'xkpi_2'
					},{
						type : '6',
						name : 'xkpi_3'
					},{
						type : '6',
						name : 'xkpi_4'
					},{
						type : '6',
						name : 'xkpi_5'
					},{
						type : '6',
						name : 'xkpi_6'
					},{
						type : '6',
						name : 'xkpi_7'
					},{
						type : '6',
						name : 'xkpi_8'
					},{
						type : '6',
						name : 'xkpi_9'
					},{
						type : '6',
						name : 'xkpi_10'
                    }]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask(r_picd);
				$('#txtXdate2').datepicker();
				$('#txtXdate1').val(q_date()).focus();
				$('#txtXdate2').val(q_date());
				var ErrCheckbox = $('#chkAberrant').children('input');
				$(ErrCheckbox).change(function(){
					if($('#Aberrant').css('display') == 'block'){
						if($(this).is(':checked')){
							$('div[id*="Xkpi_"]').each(function(){
								$(this).show();
							});
						}else{
							$('div[id*="Xkpi_"]').each(function(){
								$(this).hide();
							});
						}
					}
				});
				$('.report').click(function(){
					$(ErrCheckbox).change();
				});
				//調整異常篩選細項 開始
				$('div[id*="Xkpi_"]').each(function(){
					$(this).removeAttr('class').attr('class','option a1');
					$(this).children('.label').removeAttr('class').attr('class','label').css('width','150px').css('text-align','right');
					$(this).children('input').after('<div class="label"><span id="lblXkpiSubTitle_1">%</span></div>');
					$(this).children('input').css('text-align','right');
					var Title = $(this).children('.label').children('span').eq(0).text();
					if(Title.indexOf('率') == -1 && Title.indexOf('比') == -1){
						$(this).children('.label').children('span').eq(1).text('');
					}
				});
				//調整異常篩選細項 結束
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
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>