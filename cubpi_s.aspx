<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <script src="../script/qbox.js" type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
			var q_name = "cubpi_s";
			aPop = new Array(['txtMechno', 'lblMechno', 'mech', 'noa,mech', 'txtMechno', 'mech_b.aspx']);
			$(document).ready(function() {
				main();
			});
			function main() {
				mainSeek();
				q_gf('', q_name);
				$('#txtDime').val(0);
				$('#txtWidth').val(0);
				$('#txtLengthb').val(0);
				$('#txtRadius').val(0);
			}
			function q_gfPost() {
				q_getFormat();
				q_langShow();
				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", '@全部,' + q_getPara('cubpi.typea'));
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker();
				$('#txtNoa').focus();
			}
			function wbbsSearchStr(bbsField, value, bbmkey, bbskey) {
				var wbbsStr = '';
				if (bbsField['length'] > 0) {
					wbbsStr = " and ((select count(*) from cubu" + r_accy + " ";
					wbbsStr = wbbsStr + "where " + 'left( ' + bbsField + ',' + value.length + ")='" + value + "' and ";
					wbbsStr = wbbsStr + bbskey + " = cub" + r_accy + '.' + bbskey + ")>0)";
				}
				return wbbsStr;
			}
			function q_seekStr() {
				t_typea = $.trim($('#cmbTypea').val());
				t_noa = $.trim($('#txtNoa').val());
				t_mechno = $.trim($('#txtMechno').val());
				t_mech = $.trim($('#txtMech').val());
				t_ordeno = $.trim($('#txtOrdeno').val());
				t_uno = $.trim($('#txtUno').val());
				t_inuno = $.trim($('#txtInuno').val());
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_dime = q_float('txtDime');
                t_width = q_float('txtWidth');
                t_lengthb = q_float('txtLengthb');
                t_radius = q_float('txtRadius');
                
                t_bdime = q_float('txtBdime');
                t_bwidth = q_float('txtBwidth');
                t_blength = q_float('txtBlength');
                t_bradius = q_float('txtBradius');
                t_edime = q_float('txtEdime');
                t_ewidth = q_float('txtEwidth');
                t_elength = q_float('txtElength');
                t_eradius = q_float('txtEradius');
				
				var t_where = " 1=1 " + q_sqlPara2("typea", t_typea) + q_sqlPara2("noa", t_noa) + q_sqlPara2("datea", t_bdate, t_edate) + q_sqlPara2("mechno", t_mechno);
				if (t_mech.length > 0)
					t_where += " and charindex('" + t_mech + "',mech)>0";
				if (t_ordeno.length > 0)
					t_where += " and exists(select noa from cubs" + r_accy + " where cubs" + r_accy + ".noa=cub" + r_accy + ".noa and cubs" + r_accy + ".ordeno='" + t_ordeno + "')";
				if (t_uno.length > 0)
					t_where += " and exists(select noa from cubt" + r_accy + " where cubt" + r_accy + ".noa=cub" + r_accy + ".noa and cubt" + r_accy + ".uno='" + t_uno + "')";
				if (t_inuno.length > 0)
					t_where += " and exists(select noa from cubu" + r_accy + " where cubu" + r_accy + ".noa=cub" + r_accy + ".noa and cubu" + r_accy + ".uno='" + t_inuno + "')";
				if (t_dime != 0 && !isNaN(t_dime))
					t_where += " and exists(select noa from cubt" + r_accy + " where cubt" + r_accy + ".noa=cub" + r_accy + ".noa and cubt" + r_accy + ".dime=" + t_dime + ")";
				if (t_width != 0 && !isNaN(t_width))
					t_where += " and exists(select noa from cubt" + r_accy + " where cubt" + r_accy + ".noa=cub" + r_accy + ".noa and cubt" + r_accy + ".width=" + t_width + ")";
				if (t_lengthb != 0 && !isNaN(t_lengthb))
					t_where += " and exists(select noa from cubt" + r_accy + " where cubt" + r_accy + ".noa=cub" + r_accy + ".noa and cubt" + r_accy + ".lengthb=" + t_lengthb + ")";
				if (t_radius != 0 && !isNaN(t_radius))
					t_where += " and exists(select noa from cubt" + r_accy + " where cubt" + r_accy + ".noa=cub" + r_accy + ".noa and cubt" + r_accy + ".radius=" + t_radius + ")";
				if (!(t_bdime==0 && t_edime==0))
                    t_where += " and exists(select noa from cubu" + r_accy + " where cubu" + r_accy + ".noa=cub" + r_accy + ".noa and cubu" + r_accy + ".dime between " + t_bdime + " and "+t_edime+")";
                if (!(t_bwidth==0 && t_width==0))
                    t_where += " and exists(select noa from cubu" + r_accy + " where cubu" + r_accy + ".noa=cub" + r_accy + ".noa and cubu" + r_accy + ".width between " + t_bwidth + " and "+t_ewidth+")";
                if (!(t_blength==0 && t_elength==0))
                    t_where += " and exists(select noa from cubu" + r_accy + " where cubu" + r_accy + ".noa=cub" + r_accy + ".noa and cubu" + r_accy + ".length between " + t_blength + " and "+t_elength+")";
                if (!(t_bradius==0 && t_eradius==0))
                    t_where += " and exists(select noa from cubu" + r_accy + " where cubu" + r_accy + ".noa=cub" + r_accy + ".noa and cubu" + r_accy + ".radius between " + t_bradius + " and "+t_eradius+")";
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
            <table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;' >
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblTypea'> </a></td>
                    <td><span style="display:block;float:left;width:20px;">&nbsp;</span><select id="cmbTypea" style="float:left;width:215px; font-size:medium;" ></select></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                    <td><span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtNoa" type="text" style="float:left;width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td   style="width:35%;" ><a id='lblDatea'></a></td>
                    <td style="width:65%;  "><span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtBdate" type="text" style="float:left;width:90px; font-size:medium;" />
                    <span style="display:block;float:left;width:35px;">&sim;</span>
                    <input class="txt" id="txtEdate" type="text" style="float:left;width:90px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblMechno'></a></td>
                    <td>
                        <span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtMechno" type="text" style="float:left;width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblMech'></a></td>
                    <td>
                        <span style="display:block;float:left;width:20px;">&nbsp;</span>
                        <input class="txt" id="txtMech" type="text" style="float:left;width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblOrdeno'></a></td>
                    <td>
                        <span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtOrdeno" type="text" style="float:left;width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblUno'></a></td>
                    <td>
                        <span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtUno" type="text" style="float:left;width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;">厚(領料)</td>
                    <td>
                        <span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtDime" type="text" style="float:left;width:215px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;">寬(領料)</td>
                    <td>
                        <span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtWidth" type="text" style="float:left;width:215px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;">長(領料)</td>
                    <td>
                        <span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtLengthb" type="text" style="float:left;width:215px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;">短徑(領料)</td>
                    <td>
                        <span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtRadius" type="text" style="float:left;width:215px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblInuno'></a></td>
                    <td>
                        <span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtInuno" type="text" style="float:left;width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;">厚(入庫)</td>
                    <td><span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtBdime" type="text" style="float:left;width:90px; font-size:medium;text-align: right;" />
                    <span style="display:block;float:left;width:35px;">&sim;</span>
                    <input class="txt" id="txtEdime" type="text" style="float:left;width:90px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;">寬(入庫)</td>
                    <td><span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtBwidth" type="text" style="float:left;width:90px; font-size:medium;text-align: right;" />
                    <span style="display:block;float:left;width:35px;">&sim;</span>
                    <input class="txt" id="txtEwidth" type="text" style="float:left;width:90px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;">長(入庫)</td>
                    <td><span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtBlength" type="text" style="float:left;width:90px; font-size:medium;text-align: right;" />
                    <span style="display:block;float:left;width:35px;">&sim;</span>
                    <input class="txt" id="txtElength" type="text" style="float:left;width:90px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;">短徑(入庫)</td>
                    <td><span style="display:block;float:left;width:20px;">&nbsp;</span>
                    <input class="txt" id="txtBradius" type="text" style="float:left;width:90px; font-size:medium;text-align: right;" />
                    <span style="display:block;float:left;width:35px;">&sim;</span>
                    <input class="txt" id="txtEradius" type="text" style="float:left;width:90px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
            </table>
            <!--#include file="../inc/seek_ctrl.inc"-->
        </div>
    </body>
</html>