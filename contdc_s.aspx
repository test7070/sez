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
            var q_name = "contdc_s";

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
                bbmMask = [['txtDatea', r_picd],['txtBcontdate', r_picd],['txtEcontdate', r_picd],['txtChangecontdate', r_picd]];
                q_mask(bbmMask);
                //q_cmbParse("cmbStype", q_getPara('cont.stype'));
                q_cmbParse("cmbEnsuretype", ('').concat(new Array( '定存單質押','不可撤銷保證','銀行本票質押','商業本票質押','現金質押')));
                $('#txtBdate').focus();
                q_gt('conttype', '', 0, 0, 0, "");
            }
			 function q_gtPost(t_name) {
                switch (t_name) {
                   case 'conttype':
                        var as = _q_appendData("conttype", "", true);
                        var t_stype = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_stype = t_stype + (t_stype.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].typea;
                        }
                        q_cmbParse("cmbStype", t_stype);
                        break;
						
                }
              }
            
            function q_seekStr() {
            	t_noa = $('#txtNoa').val();
            	t_datea = $('#txtDatea').val();
            	t_stype = $('#cmbStype').val();
            	t_contract = $('#txtContract').val();
            	t_ensuretype = $('#txtEnsuretype').val();
            	t_bcontdate = $('#txtBcontdate').val();
            	t_econtdate = $('#txtEcontdate').val();
            	t_changecontdate = $('#txtChangecontdate').val();
            	t_cno = $('#txtCno').val();
            	t_acomp = $('#txtAcomp').val();
            	t_custno = $('#txtCustno').val();
            	t_comp = $('#txtComp').val();

                t_bcontdate = t_bcontdate.length > 0 && t_bcontdate.indexOf("_") > -1 ? t_bcontdate.substr(0, t_bcontdate.indexOf("_")) : t_bcontdate;
                /// 100.  .
                t_econtdate = t_econtdate.length > 0 && t_econtdate.indexOf("_") > -1 ? t_econtdate.substr(0, t_econtdate.indexOf("_")) : t_econtdate;
                /// 100.  .

                var t_where = " 1=1 " + 
                	q_sqlPara2("noa", t_noa) + 
                	q_sqlPara2("datea", t_datea) + 
                	q_sqlPara2("stype", t_stype) + 
                	q_sqlPara2("contract", t_contract) + 
                	q_sqlPara2("ensuretype", t_ensuretype) + 
                	q_sqlPara2("bcontdate", t_bcontdate, t_econtdate) + 
                	q_sqlPara2("econtdate", t_bcontdate, t_econtdate) + 
                	q_sqlPara2("changecontdate", t_changecontdate) + 
                	q_sqlPara2("cno", t_cno) + 
                	q_sqlPara2("acomp", t_acomp) + 
                	q_sqlPara2("custno", t_custno) + 
                	q_sqlPara2("comp", t_comp);

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
	                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
	                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
	                <td class='seek'  style="width:20%;"><a id='lblDatea'></a></td>
	                <td><input class="txt" id="txtDatea" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
	                <td class='seek'  style="width:20%;"><a id='lblStype'></a></td>
	                <td><select id="cmbStype" class="txt c1"> </select></td>
				</tr>
				<tr class='seek_tr'>
	                <td class='seek'  style="width:20%;"><a id='lblEnsuretype'></a></td>
	                <td><select id="cmbEnsuretype" class="txt c1"> </select></td>
				</tr>
				<tr class='seek_tr'>
	                <td class='seek'  style="width:20%;"><a id='lblContract'></a></td>
	                <td><input class="txt" id="txtContract" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblContdate'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBcontdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEcontdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
	                <td class='seek'  style="width:20%;"><a id='lblChangecontdate'></a></td>
	                <td><input class="txt" id="txtChangecontdate" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblAcomp'></a></td>
                <td>
                	<input class="txt" id="txtCno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtAcomp" type="text" style="width:115px; font-size:medium;" />
                </td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
                <td>
                	<input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtComp" type="text" style="width:115px; font-size:medium;" />
                </td>
             </tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
