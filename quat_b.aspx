<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title> </title>
	<script src="../script/jquery.min.js" type="text/javascript"></script>
	<script src='../script/qj2.js' type="text/javascript"></script>
	<script src='qset.js' type="text/javascript"></script>
	<script src='../script/qj_mess.js' type="text/javascript"></script>
	<script src="../script/qbox.js" type="text/javascript"></script>
	<script src='../script/mask.js' type="text/javascript"></script>
	<link href="../qbox.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
		var q_name = 'view_quats', t_bbsTag = 'tbbs', t_content = " field=productno,product,unit,mount,notv,noa,no3,price,spec  order=odate ", afilter = [], bbsKey = ['noa', 'no3'], t_count = 0, as;
		var t_sqlname = 'view_quats';
		t_postname = q_name;
		brwCount = -1;
		//brwCount2 = 12;
		var isBott = false;  /// 是否已按過 最後一頁
		var txtfield = [], afield, t_data, t_htm;
		var i, s1;
	
		$(document).ready(function () {
			main();
		});		 /// end ready
	
		function main() {
			if (dataErr){
				dataErr = false;
				return;
			}
			mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
		}
	
		function bbsAssign() {  /// checked 
			_bbsAssign();
			if(q_getPara('sys.project').toUpperCase()=='XY'){
				$('.XY').hide();
			}
			if(q_getPara('sys.isspec')!='1')
				$('.isSpec').hide();
		}
		function q_gtPost() { 
	
		}
		function refresh() {
			_refresh();
			$('#checkAllCheckbox').click(function(){
				$('input[type=checkbox][id^=chkSel]').each(function(){
					var t_id = $(this).attr('id').split('_')[1];
					if(!emp($('#txtNoa_' + t_id).val()))
						$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
				});
			});
			if(q_getPara('sys.project').toUpperCase()=='XY'){
				$('.XY').hide();
			}
			if(q_getPara('sys.isspec')!='1')
				$('.isSpec').hide();
		}
	</script>
	<style type="text/css">
		.seek_tr
		{color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
			.txt.c8 {
				float:left;
				width: 65px;
				
			}
			.txt.num {
				text-align: right;
			}
	</style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
	<div id="dbbs">
		<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
			<tr style='color:White; background:#003366;' >
				<td align="center">
					<input type="checkbox" id="checkAllCheckbox"/>
				</td>
				<td align="center"><a id='lblProductno'> </a></td>
				<td align="center"><a id='lblProduct'> </a> <a id='lblSpec' class="isSpec"> </a></td>
				<td align="center"><a id='lblUnit'> </a></td>
				<td align="center"><a id='lblMount'> </a></td>
				<td align="center"><a id='lblPrice'> </a></td>
				<td class="XY" align="center"><a id='lblNotv'> </a></td>
				<td align="center"><a id='lblNoa'> </a></td>
				<td align="center"><a id='lblMemo'> </a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td style="width:1%;" align="center"><input id="chkSel.*" type="checkbox"  /></td>
				<td style="width:15%;"><input class="txt"  id="txtProductno.*" type="text" style="width:98%;" /></td>
				<td style="width:15%;">
					<input class="txt" id="txtProduct.*" type="text" style="width:98%;" />
					<input class="txt isSpec" id="txtSpec.*" type="text" style="width:98%;" />
				</td>
				<td style="width:4%;"><input class="txt" id="txtUnit.*" type="text" style="width:94%;"/></td>
				<td style="width:8%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
				<td style="width:8%;"><input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/></td>
				<td class="XY" style="width:8%;"><input class="txt" id="txtNotv.*" type="text" style="width:96%; text-align:right;"/></td>
				<td style="width:5%;"><input class="txt" id="txtNoa.*" type="text" style="width:96%;"/><input class="txt" id="txtNo3.*" type="text" /></td>
				<td><input class="txt" id="txtMemo.*" type="text" style="width:98%;"/><input id="recno.*" type="hidden" /></td>
			</tr>
		</table>
		<!--#include file="../inc/pop_ctrl.inc"--> 
	</div>
</body>
</html>