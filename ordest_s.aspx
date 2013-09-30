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
            var q_name = "ordest_s";
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno', 'cust_b.aspx']);
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
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBtrandate', r_picd], ['txtEtrandate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbKind", '@全部,'+q_getPara('sys.stktype'));
                q_cmbParse("cmbStype", '@全部,'+q_getPara('orde.stype'));
                q_cmbParse("cmbEnda", '@全部,1@已結案,0@未結案');
                $('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
                $('#txtNoa').focus();
            }
            function q_seekStr() {
            	t_kind = $.trim($('#cmbKind').val());
            	t_stype = $.trim($('#cmbStype').val());
            	t_enda = $.trim($('#cmbEnda').val());
                t_noa = $.trim($('#txtNoa').val());
		        t_custno = $.trim($('#txtCustno').val());
		        t_comp = $.trim($('#txtComp').val());
		        t_uno = $.trim($('#txtUno').val());

		        t_bdate = $('#txtBdate').val();
		        t_edate = $('#txtEdate').val();

		        var t_where = " 1=1 " 
		        + q_sqlPara2("kind", t_kind)
		        + q_sqlPara2("stype", t_stype)
		        + q_sqlPara2("enda", t_enda)
		        + q_sqlPara2("noa", t_noa) 
		        + q_sqlPara2("datea", t_bdate, t_edate) 		     
		        + q_sqlPara2("custno", t_custno);
		        if (t_comp.length>0)
                    t_where += " and charindex('" + t_comp + "',comp)>0";
		       	if(t_uno.length>0)
		       		t_where += " and exists(select noa from ordet"+r_accy+" where ordet"+r_accy+".noa=orde"+r_accy+".noa and ordet"+r_accy+".uno='"+t_uno+"')";
		       	
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
					<td class='seek'  style="width:20%;"><a id='lblStype'> </a></td>
					<td><select id="cmbStype" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblKind'> </a></td>
					<td><select id="cmbKind" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblEnda'> </a></td>
					<td><select id="cmbEnda" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
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
					<td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
					<td>
					<input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'></a></td>
					<td>
					<input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblUno'></a></td>
					<td>
					<input class="txt" id="txtUno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>