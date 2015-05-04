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
            var q_name = "tre_s";
			aPop = new Array(
		    ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno', 'driver_b.aspx'], 
             ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']);
			function z_tre() {
			}
            z_tre.prototype = {
                carteam : ''
            };
            var t_data = new z_tre();

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
                q_cmbParse("cmbIspay", '@全部,N@未付');
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
                        break;
                }
                if (t_data.carteam.length > 0){
                    q_cmbParse("cmbCarteam", t_data.carteam);
                }
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_driverno = $('#txtDriverno').val();
                t_driver = $.trim($('#txtDriver').val());
                t_carno = $('#txtCarno').val();
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_accno = $.trim($('#txtAccno').val());
                t_carteam = $('#cmbCarteam').val();
				t_tranno = $.trim($('#txtTranno').val());
				t_ispay = $('#cmbIspay').val();
				
                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("driverno", t_driverno) + q_sqlPara2("carno", t_carno) + q_sqlPara2("datea", t_bdate, t_edate)+ q_sqlPara_or(["accno", "accno2"], t_accno);
                if (t_carteam.length > 0)
                    t_where += q_sqlPara2("carteamno", t_carteam);
                if (t_driver.length > 0)
                    t_where += " and charindex('" + t_driver + "',driver)>0";     
				if(t_tranno.length>0)
		       		t_where += " and exists(select noa from view_tres"+r_accy+" where view_tres"+r_accy+".noa=view_tre"+r_accy+".noa and view_tres"+r_accy+".tranno='"+t_tranno+"')";
                if(t_ispay.length>0)
                    t_where +=" and not exists(select * from tre_accc where CHARINDEX(view_tre"+r_accy+".noa,treno)>0)";
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
                    <td class='seek'  style="width:20%;"><a id='lblIspay'></a></td>
                    <td><select id="cmbIspay" style="width:215px; font-size:medium;" ></select></td>
                </tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarteam'></a></td>
					<td><select id="cmbCarteam" style="width:215px; font-size:medium;" ></select></td>
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
					<td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
					<td>
					<input class="txt" id="txtCarno" type="text" style="width:90px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTranno'></a></td>
					<td>
					<input class="txt" id="txtTranno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAccno'></a></td>
					<td>
					<input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>