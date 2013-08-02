<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'uccc', t_content = ' ', bbsKey = ['uno'],afilter = [], as; 
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i,s1;
			$(document).ready(function () {
				var Parent = window.parent.document;
				if(Parent.getElementById('cmbKind')){
					var t_cmbKind = Parent.getElementById('cmbKind').value.substr(0,1);
					if(t_cmbKind=='A'){
						$('#dbbs').html($('#dbbs').html().replace(/txtWidth/g,'txtWA1'));
						$('#dbbs').html($('#dbbs').html().replace(/txtDime/g,'txtWidth'));
						$('#dbbs').html($('#dbbs').html().replace(/txtWA1/g,'txtDime'));
					}
				}else if(window.parent.q_name != 'cub'){
					$('#dbbs').html($('#dbbs').html().replace(/txtWidth/g,'txtWA1'));
					$('#dbbs').html($('#dbbs').html().replace(/txtDime/g,'txtWidth'));
					$('#dbbs').html($('#dbbs').html().replace(/txtWA1/g,'txtDime'));
				}
				main();
			});         /// end ready

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6,t_content);
			}
			
			function bbsAssign() { 
				_bbsAssign();
			}

			function q_gtPost() {}

			function refresh() {
				_refresh();
				$('#checkAllCheckbox').click(function(){
					$('input[type=checkbox][id^=chkSel]').each(function(){
						var t_id = $(this).attr('id').split('_')[1];
						if(!emp($('#txtUno_' + t_id).val()))
							$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
					});
				});
				var Parent = window.parent.document;
				if(Parent.getElementById('cmbKind')){
					var t_cmbKind = Parent.getElementById('cmbKind').value.substr(0,1);
					if(t_cmbKind=='A'){
						$('#lblSize_st').text('厚度x寬度x長度');
						$('input[id*="txtLengthb_"]').css('width','29%');
						$('input[id*="txtWidth_"]').css('width','29%');
						$('input[id*="txtDime_"]').css('width','29%');
						$('input[id*="txtRadius_"]').remove();
						$('span[id*="StrX1"]').remove();
					}else if((t_cmbKind !='A') && (t_cmbKind !='B')){
						$('#lblSize_st').text('長度');
						$('#lblSize_st').parent().css('width','6%');
						$('input[id*="txtLengthb_"]').css('width','95%');
						$('input[id*="txtRadius_"]').remove();
						$('input[id*="txtWidth_"]').remove();
						$('input[id*="txtDime_"]').remove();
						$('span[id*="StrX1"]').remove();
						$('span[id*="StrX2"]').remove();
						$('span[id*="StrX3"]').remove();
					}
				}else if(window.parent.q_name != 'cub'){
					$('#lblSize_st').text('厚度x寬度x長度');
					$('input[id*="txtLengthb_"]').css('width','29%');
					$('input[id*="txtWidth_"]').css('width','29%');
					$('input[id*="txtDime_"]').css('width','29%');
					$('input[id*="txtRadius_"]').remove();
					$('span[id*="StrX1"]').remove();
				}
				_readonly(true);
			}	
		</script>
    	<style type="text/css">
			.StrX{
				margin-right:-2px;
				margin-left:-2px;
			}
		</style>
	</head>
	<body> 
		<div id="dbbs">
			<table id="tbbs" border="2"  cellpadding='2' cellspacing='1' style='width:98%' >
				<tr style='color:White; background:#003366;'>
					<th align="center" >
						<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<td align="center" style="width:8%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:20%;"><a id='lblSize_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblEordmount_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblEordweight_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblMweight_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblMemo_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblOrdeno_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblNo2_st'> </a></td>                
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center" style="width:2%;"><input id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td><input id="txtUno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td><input id="txtProductno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td><input id="txtProduct.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td><input id="txtSpec.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td>
						<input id="txtRadius.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
						<span id="StrX1" class="StrX">x</span>
						<input id="txtWidth.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
						<span id="StrX2" class="StrX">x</span>
						<input id="txtDime.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
						<span id="StrX3" class="StrX">x</span>
						<input id="txtLengthb.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
					</td>
					<td><input id="txtEordmount.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
					<td><input id="txtEordweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
					<td><input id="txtMweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
					<td><input id="txtMemo.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td><input id="txtOrdeno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td><input id="txtNo2.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"--> 
		</div>
	</body>
</html>