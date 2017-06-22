<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "trancommi_s";
			var bbmMask = [];
			aPop = new Array(
								['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], 
								['txtAddrno', 'lblAddr', 'addr', 'noa,addr', 'txtAddrno,txtAddr', 'addr_b.aspx'], 
								['txtSalesno', 'lblSales', 'cust', 'noa,comp', 'txtSalesno,txtSales', 'cust_b.aspx'] 
								/*['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']*/
							);

			$(document).ready(function() {
				main();
			});
			/// end ready

			function main() {
				mainSeek();
				q_gf('', q_name);
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();
				$('#txtNoa').focus();
			}

			function q_seekStr() {
				t_custno = $.trim($('#txtCustno').val());
				t_addrno = $.trim($('#txtAddrno').val());
				t_salesno = $.trim($('#txtSalesno').val());
				t_comp = $.trim($('#txtComp').val());
				t_addr = $.trim($('#txtAddr').val());
				t_sales = $.trim($('#txtSales').val());
				

				var t_where = " 1=1 "
					+q_sqlPara2("custno", t_custno)
					+q_sqlPara2("addrno", t_addrno)
					+q_sqlPara2("salesno", t_salesno)
					+q_sqlPara2("comp", t_comp)
					+q_sqlPara2("addr", t_addr)
					+q_sqlPara2("sales", t_sales);

				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCust'> </a></td>
					<td>
						<input class="txt" id="txtCustno" type="text" style="width:30%; font-size:medium;" />
						<input class="txt" id="txtComp" type="text" style="width:60%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAddr'> </a></td>
					<td>
						<input class="txt" id="txtAddrno" type="text" style="width:30%; font-size:medium;" />
						<input class="txt" id="txtAddr" type="text" style="width:60%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSales'> </a></td>
					<td>
						<input class="txt" id="txtSalesno" type="text" style="width:30%; font-size:medium;" />
						<input class="txt" id="txtSales" type="text" style="width:60%; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
