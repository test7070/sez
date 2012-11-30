<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script type="text/javascript">
			var q_name = "car2_s";

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

				bbmMask = [['txtBindate', r_picd], ['txtEindate', r_picd]];
				q_mask(bbmMask);
				
				q_cmbParse("cmbCartype", '@全部,'+q_getPara('car2.cartype'));
				
				$('#txtBindate').focus();
			}

			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_carno = $('#txtCarno').val();
				t_bindate = $('#txtBindate').val();
				t_eindate = $('#txtEindate').val();
				t_driverno = $('#txtDriverno').val();
				t_driver = $('#txtDriver').val();
				t_cardealno = $('#txtCardealno').val();
				t_cardeal = $('#txtCardeal').val();
				t_carownerno = $('#txtCarownerno').val();
				t_carowner = $('#txtCarowner').val();
				t_cartype = $('#cmbCartype').val();
				t_bindate = t_bindate.length > 0 && t_bindate.indexOf("_") > -1 ? t_bindate.substr(0, t_bindate.indexOf("_")) : t_bindate;
				/// 100.  .
				t_eindate = t_eindate.length > 0 && t_eindate.indexOf("_") > -1 ? t_eindate.substr(0, t_eindate.indexOf("_")) : t_eindate;
				/// 100.  .

				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("carno", t_carno) 
				+ q_sqlPara2("indate", t_bindate, t_eindate) + q_sqlPara2("driverno", t_driverno) 
				+ q_sqlPara2("f.namea", t_driver) + q_sqlPara2("cardealno", t_cardealno) 
				+ q_sqlPara2("cardeal", t_cardeal) + q_sqlPara2("carownerno", t_carownerno) 
				+ q_sqlPara2("b.namea", t_carowner)+ q_sqlPara2("a.cartype", t_cartype);
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
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBindate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEindate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
					<td>
					<input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCardeal'></a></td>
					<td>
					<input class="txt" id="txtCardealno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtcardeal" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDriver'></a></td>
					<td>
					<input class="txt" id="txtDriverno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtDriver" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarowner'></a></td>
					<td>
					<input class="txt" id="txtCarownerno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtCarowner" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCartype'></a></td>
					<td><select class="txt" id="cmbCartype" style="width:215px; font-size:medium;"> </select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
