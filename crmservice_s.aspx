<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "crmservice_s";
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx']
            , ['txtSssno', 'lblSssno', 'sss', 'noa,namea', 'txtSssno', 'sss_b.aspx']);

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
                $('#txtNoa').focus();
                q_cmbParse("combReason", ",拜訪,客訴,咨詢,售後服務,其他");
				$('#combReason').change(function() {
					$('#txtReason').val($(this).val());
					$(this).val('');
				});
                $('#txtNamea').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                $('#txtComp').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
            
            	$('#txtBdate').datepicker();
            	$('#txtEdate').datepicker();
            }

            function q_seekStr() {///  搜尋按下時，執行
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_sssno = $('#txtSssno').val();
                t_custno = $('#txtCustno').val();
                t_noa = $('#txtNoa').val();
                t_reason = $('#txtReason').val();

                var t_where = " 1=1 " 
                	+ q_sqlPara2("datea", t_bdate, t_edate) 
                	+ q_sqlPara2("sssno", t_sssno) 
                	+ q_sqlPara2("custno", t_custno) 
                	+ q_sqlPara2("noa", t_noa);
                if(t_reason.length>0){
                	t_where += " and charindex('" + t_reason + "',reason)>0";	
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
                background-color: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><span style="display:block;float:left;width:20px;">&nbsp;</span>
					<input class="txt" id="txtNoa" type="text" style="float:left;width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblReason'> </a></td>
					<td>
						<span style="display:block;float:left;width:20px;">&nbsp;</span>
						<input class="txt" id="txtReason" type="text" style="float:left;width:180px; font-size:medium;" />
						<select id="combReason" style="float:left;width:30px; font-size:medium;"> </select>
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblSss' class="lbl btn"> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtSssno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblCust' class="lbl btn"> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
