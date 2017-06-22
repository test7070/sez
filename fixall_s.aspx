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
            var q_name = "fixall_s";
            aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno', 'tgg_b.aspx'],
        		['txtCarno', 'lblCarno', 'car2', 'a.noa,cardno', 'txtCarno', 'car2_b.aspx']);

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

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                q_cmbParse("cmbIsfixa", '@全部,Y@已轉,N@未轉');
                $('#txtBdate').focus();
            }

            function q_seekStr() {
            	t_isfixa = $('#cmbIsfixa').val();
            	t_bdate = $.trim($('#txtBdate').val());
                t_edate = $.trim($('#txtEdate').val());
                t_bfixadate = $.trim($('#txtBfixadate').val());
                t_efixadate = $.trim($('#txtEfixadate').val());
                t_noa = $.trim($('#txtNoa').val());
                t_mon = $.trim($('#txtMon').val());
                t_tggno = $.trim($('#txtTggno').val());
                t_carno = $.trim($('#txtCarno').val());
                t_fixano = $.trim($('#txtFixano').val());
                
                
                var t_where = "1=1 "
                + q_sqlPara2("datea", t_bdate, t_edate)
                + q_sqlPara2("fixadate", t_bfixadate, t_efixadate)
                + q_sqlPara2("noa", t_noa)
                + q_sqlPara2("mon", t_mon)
                + q_sqlPara2("tggno", t_tggno);
                
                if (t_isfixa == 'Y')
                    t_where += " and exists(select count(1) from fixalls where fixalls.noa=fixall.noa and len(isnull(fixalls.fixano,''))>0 having count(1)>0)";
                if (t_isfixa == 'N')
                    t_where += " and exists(select count(1) from fixalls where fixalls.noa=fixall.noa and len(isnull(fixalls.fixano,''))=0 having count(1)>0)";
                if(t_carno.length>0)
		       		t_where += " and exists(select noa from fixalls where fixalls.noa=fixall.noa and fixalls.carno='"+t_carno+"' )";
		       	if(t_fixano.length>0)
		       		t_where += " and exists(select noa from fixalls where fixalls.noa=fixall.noa and fixalls.fixano='"+t_fixano+"' )";
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
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblIsfixa'> </a></td>
					<td><select class="txt" id="cmbIsfixa" style="width:215px; font-size:medium;"> </select></td>
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
					<td   style="width:35%;" ><a id='lblFixadate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBfixadate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEfixadate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMon'> </a></td>
					<td>
					<input class="txt" id="txtMon" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTgg'> </a></td>
					<td>
					<input class="txt" id="txtTggno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarno'> </a></td>
					<td>
					<input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblFixano'> </a></td>
					<td>
					<input class="txt" id="txtFixano" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
