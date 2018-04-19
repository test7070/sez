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
			var q_name = "tranvcce_ay_s";
			
			aPop = new Array(
				['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
				,['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']);
				
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

				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBtrandate', r_picd], ['txtEtrandate', r_picd]];
				q_mask(bbmMask);
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker();
				$('#txtBtrandate').datepicker();
				$('#txtEtrandate').datepicker(); 
				$('#txtNoa').focus();
				q_cmbParse("cmbDldate",',北部,中部,南部,回頭車');
			}

			function q_seekStr() {
				t_bdate = $.trim($('#txtBdate').val());
				t_edate = $.trim($('#txtEdate').val());
				t_noa = $.trim($('#txtNoa').val());
				t_cno = $.trim($('#txtCno').val());
				t_acomp = $.trim($('#txtAcomp').val());
				t_custno = $.trim($('#txtCustno').val());
				t_comp = $.trim($('#txtComp').val());
				t_dldate = $('#cmbDldate').val();
				
				
				var t_where = " 1=1 "
					+q_sqlPara2("datea", t_bdate, t_edate)
					+q_sqlPara2("noa", t_noa)
					+q_sqlPara2("custno", t_custno)
					+q_sqlPara2("cno",t_cno)
					+q_sqlPara2("No2",t_dldate);
					
				if(t_comp.length>0)	
					t_where += " and charindex('"+t_comp+"',comp)>0";
				if(t_acomp.length>0)	
					t_where += " and charindex('"+t_acomp+"',acomp)>0";
					
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
					<td style="width:35%;" ><a id='lblDatea'>日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>單號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCno'>公司編號</a></td>
					<td><input class="txt" id="txtCno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAcomp'>公司名稱</a></td>
					<td><input class="txt" id="txtAcomp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblCustno'>客戶編號</a></td>
                    <td><input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblComp'>客戶名稱</a></td>
                    <td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblTypea'>地區</a></td>
                    <td><select id="cmbDldate" class="txt c1" style="font-size:medium;"> </select></td>
                </tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
