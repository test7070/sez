<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "vcc_s";
            aPop = new Array( ['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno', 'cust_b.aspx']);
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

				bbmMask = [['txtMon', r_picm],['txtBdate', r_picd],['txtEdate', r_picd]];
				q_mask(bbmMask);
				q_gt('acomp', '', 0, 0, 0, "");
				q_gt('part', '', 0, 0, 0, "");
				q_cmbParse("cmbStatus", "@全部,Y@已收完,N@未收完");
				$('#txtNoa').focus();
			}
			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        t_acomp = '@全部';
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_acomp += (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_cmbParse("cmbCno", t_acomp);
                        break;
                    case 'part':
                        t_part = '@全部';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_cmbParse("cmbPart", t_part);
                        q_cmbParse("cmbPart2", t_part);
                        break;
                }
            }

			function q_seekStr() {
				t_status = $('#cmbStatus').val();
				t_cno = $('#cmbCno').val();
				t_partno = $('#cmbPart').val();
				t_partno2 = $('#cmbPart2').val();
				t_noa = $.trim($('#txtNoa').val());
				t_mon = $('#txtMon').val();
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_custno = $.trim($('#txtCustno').val());
				t_cust = $.trim($('#txtCust').val());
				t_accno = $('#txtAccno').val();
				t_invono = $('#txtInvono').val();
				t_ordeno = $('#txtOrdeno').val();

				var t_where = " 1=1 "
				+ q_sqlPara2("cno", t_cno)
				+ q_sqlPara2("partno", t_partno)
				+ q_sqlPara2("partno2", t_partno2)
				+ q_sqlPara2("noa", t_noa)
				+ q_sqlPara2("mon", t_mon)
				+ q_sqlPara2("datea", t_bdate, t_edate)
				+ q_sqlPara2("accno", t_accno)
				+ q_sqlPara2("custno", t_custno)
				+ q_sqlPara2("invono", t_invono);
				
				if (t_cust.length > 0)
                    t_where += " and patindex('%" + t_cust + "%',comp)>0";
                if(t_status=='Y')
                	t_where += " and unpay=0";
                if(t_status=='N')
                	t_where += " and unpay!=0";
                	
				if(t_ordeno.length>0)
                	t_where += " and (noa in (select noa from view_vccs where ordeno='"+t_ordeno+"') or noa in (select noa from view_vcc where ordeno='"+t_ordeno+"'))";
                	
				t_where = ' where=^^ ' + t_where + ' ^^ ';
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
			input{
				font-size: medium;
				width:95%;
			}
			select{
				font-size: medium;
				width:95%;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="width:95%; text-align:center;padding:15px;" >
			<table id="seek" border="1" cellpadding="3" cellspacing="2" style="width:100%;">
				<tr class='seek_tr'>
					<td style="width: 30%;"><a id='lblAcomp'> </a></td>
					<td style="width: 70%;"><select id="cmbCno"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td style="width: 30%;"><a id='lblPart'> </a></td>
					<td style="width: 70%;"><select id="cmbPart"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td style="width: 30%;"><a id='lblPart2'> </a></td>
					<td style="width: 70%;"><select id="cmbPart2"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td style="width: 30%;"><a id='lblStatus'> </a></td>
					<td style="width: 70%;"><select id="cmbStatus"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblNoa'> </a></td>
					<td><input id="txtNoa" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblDatea'> </a></td>
					<td>
						<input id="txtBdate" type="text" style="width:40%; float:left;" />
						<span style="width:20px; display: block; float:left;">~</span>
						<input id="txtEdate" type="text" style="width:40%; float:left;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblMon'> </a></td>
					<td><input id="txtMon" type="text" style="width:40%;"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblCustno'> </a></td>
					<td><input id="txtCustno" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblCust'> </a></td>
					<td><input id="txtCust" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblInvono'> </a></td>
					<td><input id="txtInvono" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblAccno'> </a></td>
					<td><input id="txtAccno" type="text"/></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblOrdeno'> </a></td>
					<td><input id="txtOrdeno" type="text"/></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>