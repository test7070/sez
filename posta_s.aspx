<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
            var q_name = "posta_s";
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
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                $('#txtSno').focus();
                $('#txtBdate').datepicker();
                $('#txtEdate').datepicker();
            }

            function q_seekStr() {
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_sno = $.trim($('#txtSno').val());
                t_useno = $.trim($('#txtUseno').val());
                t_comp = $.trim($('#txtComp').val());
                var t_where = " 1=1 " 
                	+ q_sqlPara2("datea", t_bdate, t_edate);
				if(t_sno.length>0)
					t_where += " and exists(select noa from postas where postas.noa=posta.noa and charindex('"+t_sno+"',postas.sno)>0)";
                if(t_useno.length>0)
					t_where += " and exists(select noa from postas where postas.noa=posta.noa and charindex('"+t_useno+"',postas.useno)>0)";
				if(t_comp.length>0)
					t_where += " and exists(select noa from postas where postas.noa=posta.noa and charindex('"+t_comp+"',postas.comp)>0)";
               
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
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td   style="width:35%;"><a id='lblDate'>交寄日期</a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblSno'>掛號號碼</a></td>
					<td style="width:65%;"><input class="txt" id="txtSno" type="text" style="width:150px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;"><a id='lblUseno'>收件人編號</a></td>
					<td style="width:65%;"><input class="txt" id="txtUseno" type="text" style="width:150px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;"><a id='lblComp'>收件人</a></td>
					<td style="width:65%;"><input class="txt" id="txtComp" type="text" style="width:150px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
