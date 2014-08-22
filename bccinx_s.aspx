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
			var q_name = "bccinx_s";
			aPop = new Array(['txtBccno', 'lblBccno', 'bcc', 'noa,product', 'txtBccno', 'bcc_b.aspx']);
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
				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_mask(bbmMask);
				$('#txtBdate').focus();
			}

			function q_gtPost(t_name) {
				switch (t_name) {
				}
			}

			function wbbsSearchStr(txtName) {
				var wbbsStr = '';
				var bbsAt, value, t_name;
				if (txtName && txtName['length'] > 3) {
					bbsAt = txtName.slice(3, (txtName.length + 1));
					value = $('#' + txtName).val();
					t_name = window['parent']['q_name'] + 's';
					if (bbsAt['length'] > 0 && value) {
						wbbsStr = " and ((select count(*) from " + t_name;
						wbbsStr = wbbsStr + " where " + 'left( ' + bbsAt + ',' + value['length'] + ")='" + value + "' and ";
						wbbsStr = wbbsStr + "noa = " + t_name.substr(0, t_name['length'] - 1) + '.noa)>0)';
					}
				}
				return wbbsStr;
			}

			function q_seekStr() {
				t_noa = $.trim($('#txtNoa').val());
				t_bdate = $.trim($('#txtBdate').val());
				t_edate = $.trim($('#txtEdate').val());
				
				var t_where = " 1=1 "  q_sqlPara2("noa", t_noa) + q_sqlPara2("datea", t_bdate, t_edate) + wbbsSearchStr('txtBccno');
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
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDate'></a></td>
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
					<td class='seek'  style="width:20%;"><a id='lblBccno'></a></td>
					<td>
					<input class="txt" id="txtBccno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>