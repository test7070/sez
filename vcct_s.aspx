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
		<script type="text/javascript">
            var q_name = "vcct_s";
			aPop = new Array();

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
                q_cmbParse("cmbTypea", '@全部,'+q_getPara('vcct.typea'));
                q_cmbParse("cmbKind", q_getPara('vcct.kind'));

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                $('#txtBdate').focus();
                
                if(q_getPara('sys.project').toUpperCase()=='RB' ){
					$('.rb').show();
					$('#lblSono').text('銷貨單號');
				}else{
					$('.rb').hide();
				}
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_serial = $('#txtSerial').val();
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_typea = $('#cmbTypea').val();
                t_kind = $('#cmbKind').val();
                t_sono = $('#txtSono').val();
                
                t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        		t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .
        

                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("datea", t_bdate, t_edate) + q_sqlPara2("typea", t_typea) + q_sqlPara2("kind", t_kind)
                + q_sqlPara2("serial", t_serial) +q_sqlPara2("sono", t_sono);

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
		</style>
	</head>
	<body>
		<div style="width:95%; text-align:center;padding:15px;">
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td style="width:75%;"><input class="txt" id="txtNoa" type="text" style="width:95%; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSerial'> </a></td>
					<td style="width:75%;"><input class="txt" id="txtSerial" type="text" style="width:95%; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTypea'> </a></td>
					<td style="width:75%;"><select id="cmbTypea"  style="width:95%; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblKind'> </a></td>
					<td style="width:75%;"><select id="cmbKind"  style="width:95%; font-size:medium;" > </select>
					</td>
				</tr>
				<tr class='seek_tr rb' style="display: none;">
					<td class='seek'  style="width:20%;"><a id='lblSono'> </a></td>
					<td style="width:75%;"><input class="txt" id="txtSono" type="text" style="width:95%; font-size:medium;" /></select>
					</td>
				</tr>
				
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
