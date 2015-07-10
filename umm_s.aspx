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
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "umm_s";
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx']);
			var bbmNum = new Array(['txtMoney', 15, 0, 1]);
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
                q_gt('part', '', 0, 0, 0, "");
                q_gt('acomp', '', 0, 0, 0, "");
                $('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
                $('#txtNoa').focus();
                if (q_getPara('sys.project').toUpperCase()!='YC'){
                	$('.yc').hide();
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'part':
                        var t_part = '@全部';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_cmbParse("cmbPart", t_part);
                        break;
                    case 'acomp':
                        var t_acomp = '@全部';
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_acomp+= (t_acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_cmbParse("cmbCno", t_acomp);
                        break;
                }
            }

            function q_seekStr() {
                t_bdate = $.trim($('#txtBdate').val());
                t_edate = $.trim($('#txtEdate').val());
                t_mon = $.trim($('#txtMon').val());
                t_noa = $.trim($('#txtNoa').val());
                t_custno = $.trim($('#txtCustno').val());
                t_cust = $.trim($('#txtCust').val());
                t_part = $('#cmbPart').find(":selected").text();
                t_cno = $.trim($('#cmbCno').val());
                t_checkno = $.trim($('#txtCheckno').val());
                t_accno = $.trim($('#txtAccno').val());
				t_vccno = $.trim($('#txtVccno').val());
				t_money = $.trim($('#txtMoney').val());
				
                var t_where = " 1=1 " 
                + q_sqlPara2("datea", t_bdate, t_edate) 
                + q_sqlPara2("accno", t_accno) 
                + q_sqlPara2("noa", t_noa) 
				+ q_sqlPara2("cno", t_cno);
				if (t_cust.length>0)
                    t_where += " and charindex('" + t_cust + "',comp)>0";
                if ($('#cmbPart').val().length>0)
                    t_where += " and charindex('" + t_part + "',part)>0";
				if (t_custno.length>0)
                    t_where += " and (charindex('" + t_custno + "',custno)>0 or charindex('" + t_custno + "',custno2)>0)";
               	if (t_checkno.length>0)
                    t_where += " and exists(select noa from umms where umms.noa=umm.noa and charindex('" + t_checkno + "',umms.checkno)>0)";
                if (t_vccno.length>0)
                	t_where += " and exists(select noa from umms where umms.noa=umm.noa and charindex('" + t_vccno + "',umms.vccno)>0)";
                if (t_mon.length>0){
                    t_where += "and ('"+t_mon+"'=case when isnull(mon,'')='' then left(datea,6) else mon end "
                        +" or exists(select noa from umms where umms.noa=umm.noa and charindex('"+t_mon+"',umms.memo2)>0) )";
                }
                if(t_money!=0){
                	t_where += " and exists(select noa from umms where umms.noa=umm.noa and money="+t_money+")";
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
					<td class='seek'  style="width:20%;"><a id='lblPart'> </a></td>
					<td><select id="cmbPart" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAcomp'> </a></td>
					<td><select id="cmbCno" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
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
					<td class='seek'  style="width:20%;"><a id='lblMon'> </a></td>
					<td><input class="txt" id="txtMon" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'> </a></td>
					<td><input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCust'> </a></td>
					<td><input class="txt" id="txtCust" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCheckno'> </a></td>
					<td><input class="txt" id="txtCheckno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAccno'> </a></td>
					<td><input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblVccno'> </a></td>
					<td><input class="txt" id="txtVccno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr yc'>
					<td class='seek'  style="width:20%;"><a id='lblMoney'>收款金額</a></td>
					<td><input class="txt" id="txtMoney" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>