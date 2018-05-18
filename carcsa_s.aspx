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
			var q_name = "carcsa_s";
			aPop=new Array(
				['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']
				,['txtDriverno', 'lblDriverno', 'driver', 'noa,namea', 'txtDriverno', 'driver_b.aspx']
				,['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx']);

			
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

				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBtrandate', r_picd], ['txtEtrandate', r_picd],['txtMon', r_picm]];
				q_mask(bbmMask);
				//q_gt('acomp', '', 0, 0, 0, "");
				q_cmbParse("cmbInterval", '@全部,'+q_getPara('carcsa.interval'));
				$('#txtNoa').focus();
				
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
				$('#txtBtrandate').datepicker();
				$('#txtEtrandate').datepicker(); 
			}
			/*function q_gtPost(t_name) {
                switch (t_name) {
                	case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
	                        var t_item = "@全部";
	                        for ( i = 0; i < as.length; i++) {
	                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
	                        }
	                        q_cmbParse("cmbCno", t_item);
                        }
                        break;
                } 
            }
*/
			function q_seekStr() {
				t_noa = $.trim($('#txtNoa').val());
				t_ordeno = $.trim($('#txtOrdeno').val());
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_btrandate = $('#txtBtrandate').val();
				t_etrandate = $('#txtEtrandate').val();
				t_mon=$('#txtMon').val();
				t_carno = $.trim($('#txtCarno').val());
				t_interval = $('#cmbInterval').val();
				t_custno = $.trim($('#txtCustno').val());
				t_comp = $.trim($('#txtComp').val());
				//t_cno = $('#cmbCno').val();
				t_driverno = $.trim($('#txtDriverno').val());
				t_tranno = $.trim($('#txtTranno').val());
				
				var t_where = " 1=1 " 
				+ q_sqlPara2("noa", t_noa) 
				+ q_sqlPara2("ordeno", t_ordeno) 
				+ q_sqlPara2("tdate", t_bdate, t_edate)
				+ q_sqlPara2("trandate", t_btrandate, t_etrandate) 
				+ q_sqlPara2("mon", t_mon)
				+ q_sqlPara2("custno", t_custno)
				+ q_sqlPara2("interval", t_interval)
				//+ q_sqlPara2("cno", t_cno)
				;
				if (t_comp.length>0)
                    t_where += " and charindex('" + t_comp + "',comp)>0";
				if (t_carno.length>0)
                    t_where += " and exists(select noa from carcsas where carcsas.noa=carcsa.noa and carcsas.carno='"+t_carno+"')";
                if (t_driverno.length>0)
                    t_where += " and exists(select noa from carcsas where carcsas.noa=carcsa.noa and carcsas.driverno='"+t_driverno+"')";
                if (t_tranno.length>0)
                    t_where += " and exists(select noa from carcsas where carcsas.noa=carcsa.noa and carcsas.tranno='"+t_tranno+"')";
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
				<!--<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAcomp'> </a></td>
					<td><select id="cmbCno" style="width:215px; font-size:medium;" > </select></td>
				</tr>-->
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblInterval'> </a></td>
					<td><select id="cmbInterval" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblOrdeno'> </a></td>
					<td><input class="txt" id="txtOrdeno" type="text" style="width:215px; font-size:medium;" /></td>
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
					<td   style="width:35%;" ><a id='lblTrandate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBtrandate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEtrandate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>		
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMon'> </a></td>
					<td><input class="txt" id="txtMon" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarno'> </a></td>
					<td><input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDriverno'> </a></td>
					<td><input class="txt" id="txtDriverno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'> </a></td>
					<td><input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'> </a></td>
					<td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTranno'> </a></td>
					<td><input class="txt" id="txtTranno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>