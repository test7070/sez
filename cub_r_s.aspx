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
			var q_name = "cub_r_s";
			var q_readonly = ['txtNoa', 'txtComp', 'txtTgg', 'txtMech'];
			aPop = new Array(
				['txtOrdeno', '', 'view_ordes', 'noa,no2,productno,product,custno,comp', 'txtOrdeno,txtNo2', ''],
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtProductno', 'lblProduct', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx']
			);
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
				$('.readonly').attr('readonly',true);
				q_cmbParse("cmbIssue", '@全部,Y@Y,N@N');
				q_cmbParse("cmbEnda", '@全部,Y@Y,N@N');
				q_cmbParse("cmbChecker", '@全部,Y@Y,N@N');
				q_cmbParse("cmbApprove", '@全部,Y@Y,N@N');
				
				q_cmbParse("cmbbbt1", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt2", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt3", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt4", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt5", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt6", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt7", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt8", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt9", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt10", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt11", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt12", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt13", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt14", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt15", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt16", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt17", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt18", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt19", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt20", '@全部,Y@完工,N@未完工');
				q_cmbParse("cmbbbt21", '@全部,Y@完工,N@未完工');
			}

			function q_gtPost(t_name) {
				switch (t_name) {
				}
			}

			function q_seekStr() {
				var t_bdate = $.trim($('#txtBdate').val());
                var t_edate = $.trim($('#txtEdate').val());
				var t_bnoa = $.trim($('#txtBnoa').val());
				var t_enoa = $.trim($('#txtEnoa').val());
				var t_custno = $.trim($('#txtCustno').val());
				var t_pno = $.trim($('#txtProductno').val());
				var t_enda = $('#cmbEnda').val();
				var t_issue = $('#cmbIssue').val();
				var t_checker = $('#cmbChecker').val();
				var t_approve = $('#cmbApprove').val();
				
				var t_where = " 1=1 " + q_sqlPara2("datea", t_bdate,t_edate) + q_sqlPara2("noa", t_bnoa,t_enoa)+
										q_sqlPara2("custno", t_custno) +
										q_sqlPara2("productno", t_pno) ;
										
				if(t_enda=='Y')
					t_where += " and isnull(enda,0)=1 ";
				if(t_enda=='N')
					t_where += " and isnull(enda,0)=0 ";
					
				if(t_issue=='Y')
					t_where += " and isnull(issuedate,'')!='' ";
				if(t_issue=='N')
					t_where += " and isnull(issuedate,'')='' ";
					
				if(t_checker=='Y')
					t_where += " and isnull(checker,'')!='' ";
				if(t_checker=='N')
					t_where += " and isnull(checker,'')='' ";
				
				if(t_approve=='Y')
					t_where += " and isnull(approve,'')!='' ";
				if(t_approve=='N')
					t_where += " and isnull(approve,'')='' ";
				
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
			input{
				font-size:medium;
			}
			.readonly{
				color: green;
				background: rgb(237, 237, 238);
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td><a id='lblDatea'>樣品單日期</a></td>
					<td colspan="3">
						<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblNoa'>樣品單號 </a></td>
					<td colspan="3">
						<input class="txt" id="txtBnoa" type="text" style="width:100px;font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEnoa" type="text" style="width:100px;font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td style="width: 100px;"><a id='lblIssue'>發行</a></td>
					<td style="width: 100px;"><select id="cmbIssue" class="txt c1" style="font-size:medium;"> </select></td>
					<td style="width: 100px;"><a id='lblEnda'>寄送</a></td>
					<td style="width: 100px;"><select id="cmbEnda" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblCust'>客戶</a></td>
					<td colspan="3">
						<input class="txt" id="txtCustno" type="text" style="width:90px;" />&nbsp;
						<input class="txt readonly" id="txtComp" type="text" style="width:120px;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblProduct'>製成品</a></td>
					<td colspan="3">
						<input class="txt" id="txtProductno" type="text" style="width:90px;" />&nbsp;
						<input class="txt readonly" id="txtProduct" type="text" style="width:120px;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblChecker'>業務核准</a></td>
					<td><select id="cmbChecker" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblApprove'>經理核准</a></td>
					<td><select id="cmbApprove" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt1'>流程第1項</a></td>
					<td><select id="cmbbbt1" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt2'>流程第2項</a></td>
					<td><select id="cmbbbt2" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt3'>流程第3項</a></td>
					<td><select id="cmbbbt3" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt4'>流程第4項</a></td>
					<td><select id="cmbbbt4" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt5'>流程第5項</a></td>
					<td><select id="cmbbbt5" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt6'>流程第6項</a></td>
					<td><select id="cmbbbt6" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt7'>流程第7項</a></td>
					<td><select id="cmbbbt7" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt8'>流程第8項</a></td>
					<td><select id="cmbbbt8" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt9'>流程第9項</a></td>
					<td><select id="cmbbbt9" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt10'>流程第10項</a></td>
					<td><select id="cmbbbt10" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>				
				<tr class='seek_tr'>
					<td><a id='lblBbt11'>流程第11項</a></td>
					<td><select id="cmbbbt11" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt12'>流程第12項</a></td>
					<td><select id="cmbbbt12" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt13'>流程第13項</a></td>
					<td><select id="cmbbbt13" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt14'>流程第14項</a></td>
					<td><select id="cmbbbt14" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt15'>流程第15項</a></td>
					<td><select id="cmbbbt15" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt16'>流程第16項</a></td>
					<td><select id="cmbbbt16" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt17'>流程第17項</a></td>
					<td><select id="cmbbbt17" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt18'>流程第18項</a></td>
					<td><select id="cmbbbt18" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt19'>流程第19項</a></td>
					<td><select id="cmbbbt19" class="txt c1" style="font-size:medium;"> </select></td>
					<td><a id='lblBbt20'>流程第20項</a></td>
					<td><select id="cmbbbt20" class="txt c1" style="font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblBbt21'>流程第21項</a></td>
					<td><select id="cmbbbt21" class="txt c1" style="font-size:medium;"> </select></td>
					<td> </td>
					<td> </td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>