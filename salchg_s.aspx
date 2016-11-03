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
            var q_name = "salchg_s";
            var aPop = new Array(['txtSssno', '', 'sssall', 'noa,namea', 'txtSssno,txtNamea', 'sssall_b.aspx']);
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
                $('#txtBdate').focus();

                q_gt('salchgitem', '', 0, 0, 0, "");
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'salchgitem':
                        var as = _q_appendData("salchgitem", "", true);
                        var t_item = "@ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].item;
                        }
                        q_cmbParse("cmbPlusitem", t_item);
                        q_cmbParse("cmbMinusitem", t_item);
                        break;
                }  /// end switch
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_sssno = $('#txtSssno').val();
                t_namea = $('#txtNamea').val();

                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();

                t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
                /// 100.  .
                t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;
                /// 100.  .

                t_mon = $('#txtMon').val();

                var t_where = " 1=1 " + q_sqlPara2("datea", t_bdate, t_edate) + q_sqlPara2("mon", t_mon) + q_sqlPara2("namea", t_namea) + q_sqlPara2("sssno", t_sssno) + q_sqlPara2("noa", t_noa) + q_sqlPara2("minusitem", $('#cmbMinusitem').val()) + q_sqlPara2("plusitem", $('#cmbPlusitem').val());
                
                if(q_getPara('sys.project').toUpperCase()=='DC' && r_userno=='040136'){
                	//105/10/28 040136 調整
                }else if(!r_dele && r_rank < '8'){
                	t_where=t_where+" and sssno='" + r_userno + "'";
                }

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
		<div style='width:400px; text-align:center;padding:15px;' >
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
					<td class='seek'  style="width:20%;"><a id='lblMon'> </a></td>
					<td><input class="txt" id="txtMon" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSssno'> </a></td>
					<td>
						<input class="txt" id="txtSssno" type="text" style="width:90px; font-size:medium;" />
						&nbsp;
						<input class="txt" id="txtNamea" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td><span> </span><a id="lblMinusitem" class="lbl"> </a></td>
					<td><select id="cmbMinusitem" class="txt c1"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><span> </span><a id="lblPlusitem" class="lbl"> </a></td>
					<td><select id="cmbPlusitem" class="txt c1"> </select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
