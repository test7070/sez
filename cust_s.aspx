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
			var q_name = "cust_s";
			aPop = new Array(['txtNoa', 'lblNoa', 'cust', 'noa,nick', 'txtNoa', 'cust_b.aspx']
			,['txtSerial', 'lblSerial', 'cust', 'serial,noa,nick', 'txtSerial', 'cust_b.aspx']
			,['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno', 'sss_b.aspx']
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

				$('#txtNoa').focus();
			}

			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_comp = $('#txtComp').val();
				t_serial = $('#txtSerial').val();
				t_salesno = $('#txtSalesno').val();
				
				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("serial", t_serial)+ q_sqlPara2("salesno", t_salesno);
				if (t_comp.length > 0)
                    t_where += " and (patindex('%" + t_comp + "%',comp)>0 or patindex('%" + t_comp + "%',nick)>0)";
                    
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
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'></a></td>
					<td>
					<input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSerial'></a></td>
					<td>
					<input class="txt" id="txtSerial" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSales'></a></td>
					<td>
					<input class="txt" id="txtSalesno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
