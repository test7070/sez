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
				_q_boxClose();
				q_getId();
				q_gf('', 'z_workg_jo');
			});
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_workg_jo',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '0', //[2]
						name : 'r_userno',
						value : r_userno
					}, {
						type : '0', //[3]
						name : 'r_name',
						value : r_name
					}, {
						type : '0', //[4]
						name : 'r_rank',
						value : r_rank
					}, {
						type : '6', //[5]
						name : 'xcuanoa'
					}, {
						type : '6', //[6]
						name : 'xcuanoq'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
				var t_key = q_getHref();
				if (t_key[1] != undefined) {
					$('#txtXcuanoa').val(t_key[1]);
				}
				
				$('#txtMount').change(function() {
					var t_mount=dec($('#txtMount').val());
					if(isNaN(t_mount))
						t_mount=0;
					$('#txtMount').val(t_mount);
					
				});
				$('#btnOK_div_in').click(function() {
					var t_mount=dec($('#txtMount').val());
					if(isNaN(t_mount))
						t_mount=0;
					if(t_mount>0){
						q_func('');
					}else{
						alert('請輸入入庫數量!!')
						return;
					}
					
					if($('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')!=''){
						
						$('#div_in').hide();	
					}else{
						alert("【"+$('#txtWorkno').val()+"】是模擬製令不得入庫!!");
					}
				});
				$('#btnClose_div_in').click(function() {
					$('#div_in').hide();
				});
				
				$('#btnOk').click(function() {
					$('#div_in').hide();
				});
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
				switch (s2) {
					case 'view_work':
						var as = _q_appendData("view_work", "", true);
						if (as[0] != undefined) {
							$('#txtProductno').val(as[0].productno);
							$('#txtProduct').val(as[0].product);
							$('#div_in').show();
						}else{
							alert('製令不存在!!');
						}
						break;
				} /// end switch
			}
			
			function workin(workno) {
				if(workno.value.length>0){
					$('#txtWorkno').val(workno.value);
					$('#div_in').css('top', $(workno).offset().top+20);
					$('#div_in').css('left', $(workno).offset().left);
					
					q_gt('view_work', "where=^^noa='"+workno.value+"'^^", 0, 0, 0, "");
				}
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="div_in" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray; z-index: 9;">
			<table id="table_in" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">製令編號</td>
					<td style="background-color: #f8d463;"><input id="txtWorkno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">製品編號</td>
					<td style="background-color: #f8d463;"><input id="txtProductno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">製品名稱</td>
					<td style="background-color: #f8d463;"><input id="txtProduct" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">入庫數量</td>
					<td style="background-color: #f8d463;"><input id="txtMount" style="font-size: medium;text-align: right;"></td>
				</tr>
				<tr>
					<td align="center" colspan='3'>
						<input id="btnOK_div_in" type="button" value="入庫" style="font-size: medium;">
						<input id="btnClose_div_in" type="button" value="關閉視窗" style="font-size: medium;">
					</td>
				</tr>
			</table>
		</div>
		
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