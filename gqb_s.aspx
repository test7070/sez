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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			var q_name = "gqb_s";
			aPop=new Array(
				['txtTcompno', '', 'cust', 'noa,comp', 'txtTcompno', 'cust_b.aspx']
				, ['txtCompno', '', 'tgg', 'noa,comp', 'txtCompno', 'tgg_b.aspx']
				, ['txtBankno', '', 'bank', 'noa,bank', 'txtBankno', 'bank_b.aspx']);

			
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

				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBindate', r_picd], ['txtEindate', r_picd],['txtBtdate', r_picd], ['txtEtdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", '@全部,'+q_getPara('gqb.typea'));
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker();
				$('#txtBindate').datepicker();
				$('#txtEindate').datepicker();
				$('#txtBtdate').datepicker();
				$('#txtEtdate').datepicker(); 
				$('#txtGqbno').focus();
			}

			function q_seekStr() {
				t_typea = $.trim($('#cmbTypea').val());
				t_gqbno = $.trim($('#txtGqbno').val());
				t_bdate = $.trim($('#txtBdate').val());
				t_edate = $.trim($('#txtEdate').val());
				t_bindate = $.trim($('#txtBindate').val());
				t_eindate = $.trim($('#txtEindate').val());
				t_btdate = $.trim($('#txtBtdate').val());
				t_etdate = $.trim($('#txtEtdate').val());

				t_compno = $.trim($('#txtCompno').val());
				t_comp = $.trim($('#txtComp').val());
				t_tcompno = $.trim($('#txtTcompno').val());
				t_tcomp = $.trim($('#txtTcomp').val());
				t_bankno = $.trim($('#txtBankno').val());
				t_money = $.trim($('#txtMoney').val());
				
				var t_where = " 1=1 " 
				+ q_sqlPara2("typea", t_typea)
				+ q_sqlPara2("gqbno", t_gqbno)
				+ q_sqlPara2("datea", t_bdate, t_edate)
				+ q_sqlPara2("indate", t_bindate, t_eindate)
				+ q_sqlPara2("tdate", t_btdate, t_etdate) 
				+ q_sqlPara2("compno", t_compno)
				+ q_sqlPara2("tcompno", t_tcompno)
				+ q_sqlPara2("bankno", t_bankno);
				if (t_money.length>0)
					t_where += " and money="+t_money;
				if (t_comp.length>0)
                    t_where += " and patindex('%" + t_comp + "%',comp)>0";
                if (t_tcomp.length>0)
                    t_where += " and patindex('%" + t_tcomp + "%',tcomp)>0";
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
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTypea'> </a></td>
					<td><select class="txt" id="cmbTypea" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGqbno'> </a></td>
					<td><input class="txt" id="txtGqbno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblIndate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBindate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEindate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblTdate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBtdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEtdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCompno'> </a></td>
					<td><input class="txt" id="txtCompno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'> </a></td>
					<td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTcompno'> </a></td>
					<td><input class="txt" id="txtTcompno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTcomp'> </a></td>
					<td><input class="txt" id="txtTcomp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblBankno'> </a></td>
					<td><input class="txt" id="txtBankno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMoney'> </a></td>
					<td><input class="txt" id="txtMoney" type="text" style="width:215px; font-size:medium; text-align: right;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>