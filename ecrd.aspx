<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			var q_name = "ecrd";
			var q_readonly = ['txtNoa','txtDatea','txtTimea','txtWorker'];
			var bbmNum = [['txtCredit', 10, 0, 1]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']);
			q_desc = 1;
			$(document).ready(function () {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});
	
			//////////////////   end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}	
				mainForm(0); // 1=Last  0=Top
			}  ///  end Main()
	
			function mainPost() {
				q_getFormat();
				bbmMask = [];
				q_mask(bbmMask);
				$('#btnCodazero').click(function(){
					if(q_cur==1){
						$('#txtCustno').val('');
						$('#txtComp').val('');						
						$('#txtCredit').val(0);
						$('#txtMemo').val('額度全部歸零');
						$('#txtWorker').val(r_name);
						var t_noa = trim($('#txtNoa').val());
						var t_date = trim($('#txtDatea').val());
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ecrd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					}
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {   
					case q_name + '_s':
						  q_boxClose2(s2); ///   q_boxClose 3/4
						  break;
				}
			}
			
			function q_gtPost(t_name) { 
				switch (t_name) {
					case q_name: 
						if (q_cur == 4)   
							  q_Seek_gtPost();
						  break;
				}
			}
	
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtCustno').focus();
			}
	
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}
	
			function btnPrint() {
			}

			function btnOk() {
				var t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtCustno', q_getMsg('lblCustno')]]);

				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				$('#txtWorker').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == 'AUTO')   
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ecrd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}
	
			function wrServer(key_value) {
				var NowTime = new Date;
				var w_Hours = padL(NowTime.getHours(),'0',2); 
				var w_Minutes = padL(NowTime.getMinutes(),'0',2); 
				$('#txtDatea').val(q_date());
				$('#txtTimea').val(w_Hours+':'+w_Minutes);
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
				var t_custno = trim($('#txtCustno').val());
				if(t_custno.length==0){t_custno=' ';}
				var t_credit = (dec($('#txtCredit').val()).toString() == 'NaN'?0:dec($('#txtCredit').val()));
				q_func('qtxt.query.ecrdchange','ecrd.txt,ecrdchange,'+t_custno+';'+t_credit);
			}
	
			function refresh(recno) {
				_refresh(recno);
			}
	
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(q_cur==1 || q_cur==2)
					$('#btnCodazero').removeAttr('disabled');
				else
					$('#btnCodazero').attr('disabled','disabled');
			}
	
			function btnMinus(id) {
				_btnMinus(id);
			}
	
			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}
	
			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}
	
			function btnSeek() {
				_btnSeek();
			}
	
			function btnTop() {
				_btnTop();
			}
			function btnPrev() {
				_btnPrev();
			}
			function btnPrevPage() {
				_btnPrevPage();
			}
	
			function btnNext() {
				_btnNext();
			}
			function btnNextPage() {
				_btnNextPage();
			}
	
			function btnBott() {
				_btnBott();
			}
			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}
	
			function btnDele() {
				_btnDele();
			}
	
			function btnCancel() {
				_btnCancel();
			}
	</script>
	<style type="text/css">
		#dmain{
			overflow:hidden;
		}
		.dview{
			float:left;
			width:25%;
		}
		.tview{
			margin:0;
			padding:2px;
			border:1px black double;
			border-spacing:0;
			font-size:16px;
			background-color:#FFFF66;
			color:blue;
		}
		.tview td{
			padding:2px;
			text-align:center;
			border:1px black solid;
		}
		.dbbm{
			float:left;
			width:70%;
			margin:-1px;
			border:1px black solid;
			border-radius:5px;
		}
		.tbbm{
			padding:0px;
			border:1px white double;
			border-spacing:0;
			border-collapse:collapse;
			font-size: medium;
			color:blue;
			background:#cad3ff;
			width:100%;
		}
		.tbbm tr{
			height:35px;
		}
		.tbbm tr td {
			margin:0px -1px;
			padding:0;
		}
		.tbbm tr td span {
			float: right;
			display: block;
			width: 5px;
			height: 10px;
		}
		.tbbm tr td .lbl {
			float: right;
			color: blue;
			font-size: medium;
		}
		.tbbm tr td .lbl.btn{
			color:#4297D7;
			font-weight:bolder;
		}
		.tbbm tr td .lbl.btn:hover{
			color:#FF8F19;
		}
		.tbbm tr td {
			width: 10%;
		}
		.txt.c1{
			width:95%;
			float:left;
		}
		.txt.c2{
			width:50%;
			float:left;
		}
		.txt.c3{
			width:45%;
			float:left;
		}
		.num{
			text-align:right;
		}
		.tbbm tr td input[type="text"]{
			border-width:1px;
			padding:0px;
			margin:-1px;
		}
		input[type="text"], input[type="button"] {
			font-size: medium;
		}
	</style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
	<div id='dmain' style="overflow:hidden;">
		<div class="dview" id="dview" style="float: left;  width:25%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk' class="lbl"> </a></td>
					<td align="center" style="width:25%"><a id='vewCustno' class="lbl"> </a></td>
					<td align="center" style="width:40%"><a id='vewDatea' class="lbl"> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
					<td align="center" id='custno'>~custno</td>
					<td align="center" id='datea timea'>~datea ~timea</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr class="tr1">
					<td class="td1" ><span> </span><a id='lblNoa' class="lbl"> </a></td>
					<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
					<td></td>
					<td></td>
				</tr>
				<tr class="tr2">
					<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
					<td class="td2">
						<input id="txtDatea"  type="text" class="txt c2" />
						<input id="txtTimea"  type="text" class="txt c3" />
					</td>
				</tr>  
				<tr class="tr3">
					<td class="td1"><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
					<td class="td2" colspan="2">
						<input id="txtCustno"  type="text" class="txt" style="width:22%;" />
						<input id="txtComp"  type="text" class="txt" style="width:73%;" />
					</td>
				</tr>  
				<tr class="tr4">
					<td class="td1"><span> </span><a id='lblCredit' class="lbl"> </a></td>
					<td class="td2"><input id="txtCredit"  type="text" class="txt c1 num" /></td>
					<td class="td3"><input id="btnCodazero" type="button"></td>
					<td></td>
				</tr>
				<tr class="tr5">
					<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
					<td class="td2" colspan="2"><input id="txtMemo"  type="text" class="txt c1" /></td>
					<td></td>
					<td></td>
				</tr>
				<tr class="tr6">
					<td class="td1" ><span> </span><a id='lblWorker' class="lbl"> </a></td>
					<td class="td2"><input id="txtWorker"  type="text"  class="txt c1"/></td>
					<td></td>
					<td></td>
				</tr>							   
			</table>
		</div>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>