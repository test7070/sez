<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'orde', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], as;
			//, t_where = '';
			var t_sqlname = 'orde_load';
			t_postname = q_name;
			brwCount2 = 10;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
			q_desc=1;
			$(document).ready(function() {
				if (!q_paraChk())
					return;

				main();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
			}

			function mainPost(){
			}

			function bbsAssign() {
				_bbsAssign();
			}

			function q_gtPost(t_name) {
			}

			function refresh() {
				_refresh();
				for (var j = 0; j < brwCount2; j++) {
				q_cmbParse("combKind_"+j, q_getPara('sys.stktype'));
				q_cmbParse("combStype_"+j, q_getPara('orde.stype'));
					if(!emp($('#txtKind_'+j).val()))
						$('#combKind_'+j).val($('#txtKind_'+j).val());
					else
						$('#combKind_'+j).text('');
					if(!emp($('#txtStype_'+j).val()))
						$('#combStype_'+j).val($('#txtStype_'+j).val());
					else
						$('#combStype_'+j).text('');
			        $('#combStype_'+j).attr('disabled', 'disabled');
		            $('#combStype_'+j).css('background', t_background2);
			        $('#combKind_'+j).attr('disabled', 'disabled');
		            $('#combKind_'+j).css('background', t_background2);
				}
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtNoa_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
				_readonlys(true);
			}

		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:10%;"><a id='lblNoa'></a></td>
					<td align="center" style="width:8%;"><a id='lblOdate'></a></td>
					<td align="center" style="width:8%;"><a id='lblStype'></a></td>
					<td align="center" style="width:8%;"><a id='lblKind'></a></td>
					<td align="center" style="width:18%;"><a id='lblAcomp'></a></td>
					<td align="center" style="width:20%;"><a id='lblCust'></a></td>
					<td align="center" style="width:5%;"><a id='lblEnda'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="chkSel.*" type="checkbox"/>
					</td>
					<td><input class="txt"  id="txtNoa.*" type="text" style="width:98%;" /></td>
					<td><input class="txt"  id="txtOdate.*" type="text" style="width:98%;" /></td>
					<td>
						<select id="combStype.*" class="txt c1"></select>
						<input class="txt"  id="txtStype.*" type="text" style="display:none;" />
					</td>
					<td>
						<select id="combKind.*" class="txt c1"></select>
						<input class="txt"  id="txtKind.*" type="text" style="display:none;" />
					</td>
					<td>
						<input class="txt"  id="txtCno.*" type="text" style="width:25%;" />
						<input class="txt"  id="txtAcomp.*" type="text" style="width:70%;" />
					</td>
					<td>
						<input class="txt"  id="txtCustno.*" type="text" style="width:25%;" />
						<input class="txt"  id="txtComp.*" type="text" style="width:70%;" />
					</td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td><input class="txt"  id="txtMemo.*" type="text" style="width:98%;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
