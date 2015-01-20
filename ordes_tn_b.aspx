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
			var q_name = 'ordes', t_bbsTag = 'tbbs', t_content = " field=datea,productno,product,spec,width,lengthb,lengthc,dime,unit,mount,noa,no2,price,datea,custno,style,class,uno,total,memo,comp", afilter = [], bbsKey = ['noa', 'no2'], as;
			var t_sqlname = 'ordes_load';
			t_postname = q_name;
			brwCount = -1;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
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

			function bbsAssign() {
				_bbsAssign();
			}

			function q_gtPost() {

			}

			function refresh() {
				_refresh();
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtProductno_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
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
			.c1{
				float:left;
				width:95%;
			}
		</style>
	</head>
	<body>
		<div id="dbbs" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:15%;"><a id='lblProductno'></a></td>
					<td align="center" style="width:15%;"><a id='lblProduct'></a></td>
					<td align="center" style="width:4%;"><a id='lblUnit'></a></td>
					<td align="center" style="width:8%;"><a id='lblMount'></a></td>
					<td align="center" style="width:15%;"><a id='lblNoa'></a></td>
					<td align="center" style="width:15%;"><a id='lblCust'></a></td>
					<td align="center" style="width:25%;"><a id='lblMemo'></a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input id="chkSel.*" type="checkbox"/></td>
					<td><input class="txt c1" id="txtProductno.*" type="text" /></td>
					<td><input class="txt c1" id="txtProduct.*" type="text" /></td>
					<td><input class="txt c1" id="txtUnit.*" type="text"/></td>
					<td><input class="txt c1" id="txtMount.*" type="text" style="text-align:right;"/></td>
					<td>
						<input type="text" class="txt" id="txtNoa.*" style="width:70%;"/>
						<input type="text" class="txt" id="txtNo2.*" style="width:25%"/>
					</td>
					<td><input class="txt c1" id="txtComp.*" type="text"/></td>
					<td><input class="txt c1" id="txtMemo.*" type="text"/>
						<input class="txt" id="txtWidth.*" type="hidden"/>
						<input class="txt" id="txtLengthb.*" type="hidden"/>
						<input class="txt" id="txtLengthc.*" type="hidden"/>
						<input class="txt" id="txtDime.*" type="hidden"/>
						<input class="txt" id="txtClass.*" type="hidden"/>
						<input class="txt" id="txtStyle.*" type="hidden"/>
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>