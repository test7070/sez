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
            var q_name = "stampuse_s";
            aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno', 'sss_b.aspx']
            , ['txtRsssno', 'lblRsss', 'sss', 'noa,namea', 'txtRsssno', 'sss_b.aspx']
            , ['txtTsssno', 'lblTsss', 'sss', 'noa,namea', 'txtTsssno', 'sss_b.aspx']);
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
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd], ['txtBrdate', r_picd], ['txtErdate', r_picd],['txtBtdate', r_picd], ['txtEtdate', r_picd]];
                q_mask(bbmMask);
                q_gt('acomp', '', 0, 0, 0, "");
                q_cmbParse("cmbStatus", "@全部,N@未繳回");
                $('#txtBdate').focus();
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        var t_acomp = '@全部';
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_acomp += (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_cmbParse("cmbAcomp", t_acomp);
                        break;
                }
            }

            function q_seekStr() {
                t_cno = $.trim($('#cmbAcomp').val());
                t_status = $.trim($('#cmbStatus').val());
                t_noa = $.trim($('#txtNoa').val());
                t_bdate = $.trim($('#txtBdate').val());
                t_edate = $.trim($('#txtEdate').val());
                t_sssno = $.trim($('#txtSssno').val());
                t_sss = $.trim($('#txtSss').val());
                t_brdate = $.trim($('#txtBrdate').val());
                t_erdate = $.trim($('#txtErdate').val());
                t_rsssno = $.trim($('#txtRsssno').val());
                t_rsss = $.trim($('#txtRsss').val());
                t_btdate = $.trim($('#txtBtdate').val());
                t_etdate = $.trim($('#txtEtdate').val());
                t_tsssno = $.trim($('#txtTsssno').val());
                t_tsss = $.trim($('#txtTsss').val());

                var t_where = " 1=1 " + q_sqlPara2("cno", t_cno) +q_sqlPara2("noa", t_noa) + q_sqlPara2("datea", t_bdate, t_edate) + q_sqlPara2("sssno", t_sssno) + q_sqlPara2("rdate", t_brdate, t_erdate) + q_sqlPara2("rsssno", t_rsssno) + q_sqlPara2("tdate", t_btdate, t_etdate) + q_sqlPara2("tsssno", t_tsssno);
                if (t_status.length > 0)
                    t_where += " and (len(rdate)=0 and len(tdate)=0)";
                if (t_sss.length > 0)
                    t_where += " and patindex('%" + t_sss + "%',namea)>0";
                if (t_rsss.length > 0)
                    t_where += " and patindex('%" + t_rsss + "%',rnamea)>0";
                if (t_tsss.length > 0)
                    t_where += " and patindex('%" + t_tsss + "%',tnamea)>0";
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
					<td class='seek'  style="width:20%;"><a id='lblAcomp'> </a></td>
					<td><select id="cmbAcomp" style="width:215px; font-size:medium;" ></select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblStatus'> </a></td>
					<td><select id="cmbStatus" style="width:215px; font-size:medium;" ></select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
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
					<td class='seek'  style="width:20%;"><a id='lblSssno'> </a></td>
					<td>
					<input class="txt" id="txtSssno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSss'> </a></td>
					<td>
					<input class="txt" id="txtSss" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblRdate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBrdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtErdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblRsssno'> </a></td>
					<td>
					<input class="txt" id="txtRsssno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblRsss'> </a></td>
					<td>
					<input class="txt" id="txtRsss" type="text" style="width:215px; font-size:medium;" />
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
					<td class='seek'  style="width:20%;"><a id='lblTsssno'> </a></td>
					<td>
					<input class="txt" id="txtTsssno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTsss'> </a></td>
					<td>
					<input class="txt" id="txtTsss" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>