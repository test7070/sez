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
            var q_name = "uf_s";
            var aPop = new Array(['txtBankno', '', 'bank', 'noa,bank', 'txtBankno', 'bank_b.aspx']);
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

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                $('#txtBdate').focus();

            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_bankno = $('#txtBankno').val();
                t_worker = $('#txtWorker').val();
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_accno = $('#txtAccno').val();
                t_money = parseFloat($('#txtMoney').val().length==0?'0':$('#txtMoney').val());

                t_checkno = $.trim($('#txtCheckno').val());
				
                var t_where = " 1=1 " 
                + q_sqlPara2("noa", t_noa) 
                + q_sqlPara2("bankno", t_bankno) 
                + q_sqlPara2("worker", t_worker)
                + q_sqlPara2("accno", t_accno) 
                + q_sqlPara2("datea", t_bdate, t_edate);
				if(t_checkno.length>0)
					t_where += " and exists(select noa from ufs where ufs.noa=uf.noa and patindex('%" + t_checkno + "%',ufs.checkno)>0)";
				if(t_money!=0)
					t_where += " and exists(select noa from ufs where ufs.noa=uf.noa and ufs.money="+t_money+")";
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
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblBankno'></a></td>
					<td>
					<input class="txt" id="txtBankno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblWorker'></a></td>
					<td>
					<input class="txt" id="txtWorker" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCheckno'></a></td>
					<td>
					<input class="txt" id="txtCheckno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMoney'></a></td>
					<td>
					<input class="txt" id="txtMoney" type="text" style="width:215px; font-size:medium;text-align: right;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAccno'></a></td>
					<td>
					<input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;text-align: right;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
