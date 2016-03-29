<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "ucrout3_s";
			aPop = new Array(
				['txtProductno', '', 'ucr2', 'noa,product', 'txtProductno', "ucr2_b.aspx"],
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
				bbmMask = [['txtBdate', r_picd],['txtEdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", '@全部,' + q_getPara('ucrout3.typea'));
				$('#txtNoa').focus();
			}

			function q_gtPost(s2){
				switch(s2){
					
				}
			}
			
			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_productno = $('#txtProductno').val();
				t_typea = $('#cmbTypea').val();
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_tggno = $('#txtTggno').val();

				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)
												  + q_sqlPara2("datea", t_bdate,t_edate) 
												  + q_sqlPara2("productno", t_productno) 
												  + q_sqlPara2("typea", t_typea) 
												  + q_sqlPara2("tgg", t_tggno)
												  ;
										
				
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
			.c1{
				width:215px;
				font-size:medium;
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblNoa'> </a></td>
					<td><input class="txt c1" id="txtNoa" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblDatea'> </a></td>
					<td>
						<input id="txtBdate" type="text" class="txt c1" style="width:36%;" />
						<span style="width:20px;">~</span>
						<input id="txtEdate" type="text" class="txt c1" style="width:36%;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" class="c1" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblTgg'> </a></td>
					<td><input class="txt c1" id="txtTggno" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblProductno'> </a></td>
					<td><input class="txt c1" id="txtProductno" type="text" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>