<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "adpipe_s";
			aPop = new Array(
				['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', "ucaucc_b.aspx"]
			);
			$(document).ready(function() {
				main();
			});

			function main() {
				mainSeek();
				q_gf('', q_name);
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();
				bbmMask = [['txtMon', r_picm]];
				q_mask(bbmMask);
				$('#txtMon').focus();
			}

			function q_seekStr() {
				t_mon = $('#txtMon').val();
				t_noa = $('#txtNoa').val();
				t_style = $('#txtStyle').val();
				t_productno = $('#txtProductno').val();
				t_product = $('#txtProduct').val();
				t_spec = $('#txtSpec').val();
				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) +
										q_sqlPara2("mon", t_mon) +
										q_sqlPara2("style", t_style) +
										q_sqlPara2("productno", t_productno) +
										q_sqlPara2("product", t_product);
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
			.txt{
				width:215px;
				font-size:medium;
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblMon'> </a></td>
					<td><input class="txt" id="txtMon" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblProductno'> </a></td>
					<td><input class="txt" id="txtProductno" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblProduct'> </a></td>
					<td><input class="txt" id="txtProduct" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblStyle'> </a></td>
					<td><input class="txt" id="txtStyle" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblSpec'> </a></td>
					<td><input class="txt" id="txtSpec" type="text" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>