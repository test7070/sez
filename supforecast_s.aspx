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
            var q_name = "supforecast_s";
            var aPop = new Array(
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtFactno', 'lblFactory', 'factory', 'noa,factory', 'txtFactno,txtFactory', 'factory_b.aspx']
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

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                $('#txtBdate').focus();

            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_mon = $('#txtMon').val();
                t_factno = $('#txtFactno').val();
                t_factory = $('#txtFactory').val();
                t_salesno = $('#txtSalesno').val();
                t_sales = $('#txtSales').val();

                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("mon", t_mon) + q_sqlPara2("factno", t_factno) + q_sqlPara2("factory", t_factory) + q_sqlPara2("salesno", t_salesno) + q_sqlPara2("sales", t_sales);

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
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblMon'> </a></td>
					<td><input class="txt" id="txtMon" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblFactno'> </a></td>
					<td><input class="txt" id="txtFactno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblFactory'> </a></td>
					<td><input class="txt" id="txtFactory" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblSalesno'> </a></td>
					<td><input class="txt" id="txtSalesno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblSales'> </a></td>
					<td><input class="txt" id="txtSales" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>