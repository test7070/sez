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
			var q_name = "ucx_s";
			aPop = new Array(
				['txtNoa', '', 'uca', 'noa,product', 'txtNoa,txtProduct', "uca_b.aspx"],
				['txtTggno', 'lblTgg', 'tgg', 'noa,nick', 'txtTggno,txtComp', 'tgg_b.aspx'],
				['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx']
			);
			$(document).ready(function() {
				main();
			});

			function main() {
				mainSeek();
				q_gf('', q_name);
				q_gt('uccga', '', 0, 0, 0, "");
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();
				q_cmbParse("cmbTypea", '@全部,' + q_getPara('uca.typea'));
				if (q_getPara('sys.project').toUpperCase()=='AD' || q_getPara('sys.project').toUpperCase()=='JO'){
					aPop = new Array(
						['txtNoa', '', 'uca', 'noa,product', 'txtNoa', "uca_b.aspx"],
						['txtTggno', 'lblTgg', 'tgg', 'noa,nick', 'txtTggno,txtComp', 'tgg_b.aspx'],
						['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx']
					);
				}
				$('#txtNoa').focus();
			}

			function q_gtPost(s2){
				switch(s2){
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
							}
							q_cmbParse("cmbGroupano", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupano").val(abbm[q_recno].groupano);
							}
						}
						break;
				}
			}
			
			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_product = $('#txtProduct').val();
				t_processno = $('#txtProcessno').val();
				t_process = $('#txtProcess').val();
				//t_typea = $('#cmbTypea').val();
				t_tggno = $('#txtTggno').val();
				t_comp = $('#txtComp').val();
				t_groupano = $('#cmbGroupano').val();
				t_style = $('#txtStyle').val();

				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) +
										q_sqlPara2("processno", t_processno) +
										//q_sqlPara2("typea", t_typea) +
										q_sqlPara2("groupano", t_groupano) +
										q_sqlPara2("tggno", t_tggno);
				
				if (t_product.length > 0)
					t_where += " and charindex('" + t_product + "',product)>0";										
				if (t_style.length > 0)
					t_where += " and charindex('" + t_style + "',style)>0";
				if (t_process.length > 0)
					t_where += " and charindex('" + t_process + "',process)>0";
				if (t_comp.length > 0)
					t_where += " and charindex('" + t_comp + "',comp)>0";
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
					<td class='seek' style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt c1" id="txtNoa" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblProduct'> </a></td>
					<td><input class="txt c1" id="txtProduct" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblStyle'> </a></td>
					<td><input class="txt c1" id="txtStyle" type="text" /></td>
				</tr>
				<tr class='seek_tr' style="display: none;">
					<td class='seek' style="width:20%;"><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" class="c1" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblGroupano'> </a></td>
					<td><select id="cmbGroupano" class="c1" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblProcessno'> </a></td>
					<td>
						<input class="txt" id="txtProcessno" type="text" style="width:90px; font-size:medium;" />
						<input class="txt" id="txtProcess" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblTggno'> </a></td>
					<td>
						<input class="txt" id="txtTggno" type="text" style="width:90px; font-size:medium;" />
						<input class="txt" id="txtComp" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>