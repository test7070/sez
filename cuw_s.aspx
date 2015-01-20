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
			var q_name = "cuw_s";
			aPop = new Array(
				['txtStationno', 'lblStationno', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx']
			)
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

			function q_seekStr() {
				var t_noa = $.trim($('#txtNoa').val());
				var t_bdate = $.trim($('#txtBdate').val());
				var t_edate = $.trim($('#txtEdate').val());
				var t_stationno = $.trim($('#txtStationno').val());
				var t_station = $.trim($('#txtStation').val());
				t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
				/// 100. .
				t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;
				/// 100. .
				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) +
										q_sqlPara2("stationno", t_stationno) +
										q_sqlPara2("datea", t_bdate, t_edate)

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
			input{
				font-size:medium;
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;">
						<input class="txt" id="txtBdate" type="text" style="width:90px;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblNoa'></a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:20%;"><a id='lblStationno'></a></td>
					<td>
						<input class="txt" id="txtStationno" type="text" style="width:35%;" />
						<input class="txt" id="txtStation" type="text" style="width:50%;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>