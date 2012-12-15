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
            var q_name = "chgcash_s";

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
                q_gt('part', '', 0, 0, 0, "");
                q_gt('chgpart', '', 0, 0, 0, "");
                q_cmbParse("cmbDc", '@全部,' + q_getPara('chgcash.typea'));
                $('#txtBdate').focus();
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'carteam':
                        var t_carteam = '@全部';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_carteam += (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_cmbParse("cmbCarteam", t_carteam);
                        break;
                    case 'part':
                        var t_part = '@全部';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_cmbParse("cmbPart", t_part);
                        break;
                    case 'chgpart':
                        var t_chgpart = '@全部';
                        var as = _q_appendData("chgpart", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_chgpart += (t_chgpart.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_cmbParse("cmbChgpart", t_chgpart);
                        break;
                }
            }

            function q_seekStr() {
                t_driverno = $.trim($('#txtDriverno').val());
                t_driver = $.trim($('#txtDriver').val());
                t_sssno = $.trim($('#txtSssno').val());
                t_sss = $.trim($('#txtSss').val());
                t_carno = $.trim($('#txtCarno').val());
                t_po = $.trim($('#txtPo').val());
                t_bdate = $.trim($('#txtBdate').val());
                t_edate = $.trim($('#txtEdate').val());
                t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
                t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;
                t_carteam = $.trim($('#cmbCarteam').val());
                t_part = $.trim($('#cmbPart').val());
                t_chgpart = $.trim($('#cmbChgpart').val());
                t_dc = $.trim($('#cmbDc').val());

                var t_where = " 1=1 " + q_sqlPara2("driverno", t_driverno) + q_sqlPara2("driver", t_driver) + q_sqlPara2("sssno", t_sssno) + q_sqlPara2("sss", t_sss) + q_sqlPara2("carno", t_carno) + q_sqlPara2("po", t_po) + q_sqlPara2("datea", t_bdate, t_edate) + q_sqlPara2("carteamno", t_carteam) + q_sqlPara2("partno", t_part) + q_sqlPara2("chgpartno", t_chgpart) + q_sqlPara2("dc", t_dc);

                t_where = ' where=^^' + t_where + '^^ ';
               // alert(t_where);
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
					<td class='seek'  style="width:20%;"><a id='lblPart'></a></td>
					<td><select id="cmbPart" style="width:215px; font-size:medium;" ></select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblChgpart'></a></td>
					<td><select id="cmbChgpart" style="width:215px; font-size:medium;" ></select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarteam'></a></td>
					<td><select id="cmbCarteam" style="width:215px; font-size:medium;" ></select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDc'></a></td>
					<td><select id="cmbDc" style="width:215px; font-size:medium;" ></select></td>
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
					<td class='seek'  style="width:20%;"><a id='lblSss'></a></td>
					<td>
					<input class="txt" id="txtSssno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtSss" type="text" style="width:115px; font-size:medium;" />
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
					<td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
					<td>
					<input class="txt" id="txtCarno" type="text" style="width:120px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblPo'></a></td>
					<td>
					<input class="txt" id="txtPo" type="text" style="width:120px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>