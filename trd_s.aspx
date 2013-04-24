<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "trd_s";
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx']);

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

				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbUmm", '@全部,Y@已收完,N@未收完');
				$('#txtBdate').focus();
			}

			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_custno = $('#txtCustno').val();
				t_comp = $('#txtCust').val();
				t_mon = $('#txtMon').val();
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_invono = $.trim($('#txtInvono').val());
				t_umm = $.trim($('#cmbUmm').val());
				
				var t_where = " 1=1 and (len(isnull(datea,''))!=9 or datea>='101/08/01') " + q_sqlPara2("noa", t_noa) + q_sqlPara2("custno", t_custno) + q_sqlPara2("mon", t_mon) + q_sqlPara2("datea", t_bdate, t_edate);
				if (t_comp.length > 0)
                    t_where += " and patindex('%" + t_comp + "%',comp)>0";
				if (t_invono.length > 0)
                    t_where += " and patindex('%" + t_invono + "%',vccano)>0"; 
                if(t_umm=='Y')
		       		t_where += " and unpay=0"
		       	if(t_umm=='N')
		       		t_where += " and unpay!=0"	
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe;
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblUmm'></a></td>
					<td>
					<select class="txt" id="cmbUmm" style="width:215px; font-size:medium;"> </select>
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMon'></a></td>
					<td>
					<input class="txt" id="txtMon" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
					<td>
					<input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCust'></a></td>
					<td>
					<input class="txt" id="txtCust" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblInvono'></a></td>
					<td>
					<input class="txt" id="txtInvono" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
