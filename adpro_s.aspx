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
			var q_name = "adpro_s";
			aPop = new Array(
				['txtProductno', '', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', "ucaucc_b.aspx"],
				['txtTggno', '', 'tgg', 'noa,comp', 'txtTggno', "tgg_b.aspx"]
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
				bbmMask = [['txtMon', r_picm], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_mask(bbmMask);
				$('#txtMon').focus();
			}

			function q_seekStr() {
				t_mon = $('#txtMon').val();
				t_noa = $('#txtNoa').val();
				t_productno = $('#txtProductno').val();
				t_product = $('#txtProduct').val();
				t_tggno = $('#txtTggno').val();
				t_comp = $('#txtComp').val();
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
				t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;

				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) +
										q_sqlPara2("mon", t_mon) + 
										q_sqlPara2("datea", t_bdate, t_edate) + 
										q_sqlPara2("productno", t_productno) + 
										q_sqlPara2("product", t_product) + 
										q_sqlPara2("tggno", t_tggno) + 
										q_sqlPara2("comp", t_comp);

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
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBdate" type="text" style="width:90px;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblMon'></a></td>
					<td><input class="txt" id="txtMon" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblNoa'></a></td>
					<td><input class="txt" id="txtNoa" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblProductno'></a></td>
					<td><input class="txt" id="txtProductno" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblProduct'></a></td>
					<td><input class="txt" id="txtProduct" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblTggno'></a></td>
					<td><input class="txt" id="txtTggno" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblComp'></a></td>
					<td><input class="txt" id="txtComp" type="text"/></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>