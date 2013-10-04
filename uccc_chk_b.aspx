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
			var q_name = 'view_uccc', t_content = ' ', bbsKey = ['uno'],afilter = [], as; 
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

			var maxAbbsCount = 0;
			function refresh() {
				_refresh();
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtUno_' + j).val() == abbs[i].uno) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
						if (abbs[i].emount <= 0 || abbs[i].eweight <= 0) {
							abbs.splice(i, 1);
							i--;
						}
					}
					maxAbbsCount = abbs.length;
				}
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
						$('#lblSize_st').text(q_getPara('sys.lblSizea'));
						$('input[id*="txtLengthb_"]').css('width','29%');
						$('input[id*="txtWidth_"]').css('width','29%');
						$('input[id*="txtDime_"]').css('width','29%');
						$('input[id*="txtRadius_"]').remove();
						$('span[id*="StrX1"]').remove();
					}else if((t_cmbKind !='A') && (t_cmbKind !='B')){
						$('#lblSize_st').text(q_getPara('sys.lblSizec'));
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
					$('#lblSize_st').text(q_getPara('sys.lblSizea'));
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
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="dbbs">
			<table id="tbbs" border="2"  cellpadding='2' cellspacing='1' style='width:98%' >
				<tr style='color:White; background:#003366;'>
					<th align="center" >
						<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<td align="center" style="width:8%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblEmount_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblEweight_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:20%;"><a id='lblSize_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblMweight_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblMemo_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center" style="width:2%;"><input id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td><input id="txtUno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td><input id="txtProductno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td><input id="txtProduct.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td><input id="txtEmount.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
					<td><input id="txtEweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
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
					<td><input id="txtMweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
					<td><input id="txtMemo.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"--> 
		</div>
	</body>
</html>