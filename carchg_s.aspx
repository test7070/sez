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
			var q_name = "carchg_s";
			aPop = new Array(
		    ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno', 'driver_b.aspx'], 
             ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']
             , ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
			function z_carchg() {
			}
            z_carchg.prototype = {
                carteam : ''
            };
            var t_data = new z_carchg();
            
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
				q_gt('carteam', '', 0, 0, 0, "");
				q_cmbParse("cmbTre", "@全部,Y@已立帳,N@未立帳");
				$('#txtBdate').focus();
			}
			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'carteam':
                        t_data.carteam = '@全部';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.carteam += (t_data.carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_cmbParse("cmbCarteam", t_data.carteam);
                        break;
                }
            }

			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_carno = $('#txtCarno').val();
				t_acc1 = $('#txtAcc1').val();
				t_acc2 = $('#txtAcc2').val();
				t_driverno = $('#txtDriverno').val();
				t_driver = $('#txtDriver').val();
				t_carteam = $('#cmbCarteam').val();
				t_tre = $('#cmbTre').val();
				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("datea", t_bdate, t_edate) + q_sqlPara2("carno", t_carno) + q_sqlPara2("driverno", t_driverno)
										 + q_sqlPara2("acc1", t_acc1) + q_sqlPara2("acc2", t_acc2);
				if (t_carteam.length > 0)
                    t_where += q_sqlPara2("carteamno", t_carteam);
                if (t_driver.length > 0)
                    t_where += " and patindex('%" + t_driver + "%',driver)>0";
                if(t_tre=='Y')
                	t_where += " and len(isnull(treno,''))>0 ";
                if(t_tre=='N')
                	t_where += " and len(isnull(treno,''))=0 ";
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
					<td class='seek'  style="width:20%;"><a id='lblCarteam'></a></td>
					<td><select id="cmbCarteam" style="width:215px; font-size:medium;" ></select></td>
				</tr>
				<tr class='seek_tr' style="display:none;">
					<td class='seek'  style="width:20%;"><a id='lblTre'></a></td>
					<td><select id="cmbTre" style="width:215px; font-size:medium;" ></select></td>
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
					<td class='seek'  style="width:20%;"><a id='lblDriver'></a></td>
					<td>
					<input class="txt" id="txtDriver" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAcc1'></a></td>
					<td>
					<input class="txt" id="txtAcc1" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtAcc2" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>