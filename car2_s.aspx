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
			var q_name = "car2_s";
			
			aPop = [['txtCarno', 'lblCarno', 'car2', 'a.noa,carownerno,carowner', 'txtCarno,txtCarownerno', 'car2_b.aspx'],
						['txtCarownerno', 'lblCarowner', 'carowner', 'noa,namea', 'txtCarownerno', 'carowner_b.aspx'], 
				 		['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno', 'driver_b.aspx']];


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
				q_gt('cardeal', '', 0, 0, 0, "");
				q_cmbParse("cmbCartype", '@全部,'+q_getPara('car2.cartype'));
				
				$('#txtCarno').focus();
				/*$('#txtEindate').keydown(function(e) {
					if(e.which==13)
						$('#txtNoa').focus();
				});*/
			}
			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'cardeal':
                        var t_cardeal = '@全部';
                        var as = _q_appendData("cardeal", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_cardeal += (t_cardeal.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
                        }
                        q_cmbParse("cmbCardealno", t_cardeal);
                        break;
                }
            }

			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_carno = $('#txtCarno').val();
				t_bindate = $('#txtBindate').val();
				t_eindate = $('#txtEindate').val();
				t_driverno = $('#txtDriverno').val();
				t_cardealno = $('#cmbCardealno').val();
				t_carownerno = $('#txtCarownerno').val();
				t_cartype = $('#cmbCartype').val();
				t_cardno = $('#txtCardno').val();
				t_engineno = $('#txtEngineno').val();

				var t_where = " 1=1 " 
				+ q_sqlPara2("indate", t_bindate, t_eindate) + q_sqlPara2("driverno", t_driverno) 
				+ q_sqlPara2("a.cardealno", t_cardealno) 
				+ q_sqlPara2("a.carownerno", t_carownerno) 
				+ q_sqlPara2("a.cartype", t_cartype)
				+ q_sqlPara2("a.cardno", t_cardno)
				+ q_sqlPara2("a.engineno", t_engineno);
				
				if(!emp(t_carno))
					t_where+= " and (charindex('"+t_carno+"',a.noa)>0 or charindex('"+t_carno+"',oldnoa)>0 or a.noa in (select noa from carchange where charindex('"+t_carno+"',oldcarno)>0)) ";
				
				t_where = " where=^^" + t_where + " ^^ ";	
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
					<td class='seek'  style="width:20%;"><a id='lblCartype'></a></td>
					<td><select class="txt" id="cmbCartype" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCardealno'></a></td>
					<td><select class="txt" id="cmbCardealno" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBindate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEindate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr' style="display:none;">
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
					<td class='seek'  style="width:20%;"><a id='lblDriverno'></a></td>
					<td>
					<input class="txt" id="txtDriverno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarownerno'></a></td>
					<td>
					<input class="txt" id="txtCarownerno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCardno'></a></td>
					<td>
					<input class="txt" id="txtCardno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblEngineno'></a></td>
					<td>
					<input class="txt" id="txtEngineno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
