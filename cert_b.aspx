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
			var q_name = "cert";
			var q_readonly = [];
			var bbmNum = [['txtWeight', 10, 2, 1],['txtChemistry_c', 10, 2, 1],['txtChemistry_si', 10, 2, 1],
						  ['txtChemistry_mn', 10, 2, 1],['txtChemistry_p', 10, 2, 1],['txtChemistry_s', 10, 2, 1],
						  ['txtChemistry_cr', 10, 2, 1],['txtChemistry_ni', 10, 2, 1],['txtChemistry_n', 10, 2, 1],
						  ['txtChemistry_cu', 10, 2, 1],['txtTs', 10, 2, 1],['txtYs', 10, 2, 1],
						  ['txtElong', 10, 2, 1],['txtHrb', 10, 2, 1],['txtHv', 10, 2, 1],
						 ];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			$(document).ready(function () {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)
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
				var Cert_Seq = window.parent.btnCert_Seq;
				var Parent = window.parent.document;
				var t_uno = Parent.getElementById('txtUno_' + Cert_Seq);
				var t_product = Parent.getElementById('txtProduct_' + Cert_Seq);
				var t_productno = Parent.getElementById('txtProductno_' + Cert_Seq);
				var t_weight = Parent.getElementById('txtWeight_' + Cert_Seq);
				var t_bno = (Cert_Seq == -2?Parent.getElementById('txtBno'):Parent.getElementById('txtBno_' + Cert_Seq));
				_btnIns();
				$('#txtNoa').focus();
				if(Cert_Seq != -1 && Cert_Seq != null){
					if(AutoFill = confirm('代入資料?')){
						$('#txtProduct').val((t_product != null ? t_product.value: ''));
						$('#txtProductno').val((t_productno != null ? t_productno.value: ''));
						$('#txtWeight').val((t_weight != null ? t_weight.value: ''));
						$('#txtHeat').val((t_bno != null ? t_bno.value: ''));
						$('#txtNoa').val((t_uno != null ? t_uno.value: '')).focus();
					}
				}
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
				t_err = q_chkEmpField(['txtNoa', q_getMsg('lblNoa')]);

				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				var t_noa = trim($('#txtNoa').val());

				if (t_noa.length == 0)   
					alert('【 ' + q_getMsg('lblNoa') + ' 】' + mess_emp2);
				else
					wrServer(t_noa);
			}
	
			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
	
			function refresh(recno) {
				_refresh(recno);
			}
	
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
	
			function btnMinus(id) {
				_btnMinus(id);
			}
	
			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign(); 
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
		.txt.c1{
			width:95%;
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
		.trX{
			background: pink;
		}
		.trXA{
			background: #FFFF80;
		}
		.trTitle{
			padding-left: 18px;
			font-size: 18px;
			font-weight: bolder;
			color: brown;
			letter-spacing: 5px;
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
					<td align="center" style="width:25%"><a id='vewNoa' class="lbl"> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
					<td align="center" id='noa'>~noa</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing=''>
				<tr class="tr1">
					<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
					<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblProduct" class="lbl"> </a></td>
					<td class="td4"><input id="txtProduct" type="text" class="txt c1" /></td>
					<td class="td5"><span> </span><a id="lblSize" class="lbl"> </a></td>
					<td class="td6"><input id="txtSize" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr2">
					<td class="td1"><span> </span><a id='lblProductno' class="lbl"> </a></td>
					<td class="td2"><input id="txtProductno"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblSpec" class="lbl"> </a></td>
					<td class="td4"><input id="txtSpec" type="text" class="txt c1" /></td>
					<td class="td5"><span> </span><a id="lblHeat" class="lbl"> </a></td>
					<td class="td6"><input id="txtHeat" type="text" class="txt c1" /></td>
				</tr> 
				<tr class="tr3">
					<td class="td1"><span> </span><a id='lblWeight' class="lbl"> </a></td>
					<td class="td2"><input id="txtWeight"  type="text"  class="txt c1 num"/></td>
					<td class="td3"><span> </span><a id="lblSpecif" class="lbl"> </a></td>
					<td class="td4"><input id="txtSpecif" type="text" class="txt c1" /></td>
				</tr>
				<tr>
					<td colspan="6" class="trX"><span> </span><a class="trTitle" id="lblChemistry"></a></td>
				</tr>
				<tr class="tr4">
					<td class="td1 trX"><span> </span><a id='lblChemistry_c' class="lbl"> </a></td>
					<td class="td2 trX"><input id="txtChemistry_c"  type="text"  class="txt c1 num"/></td>
					<td class="td3 trX"><span> </span><a id="lblChemistry_si" class="lbl"> </a></td>
					<td class="td4 trX"><input id="txtChemistry_si" type="text" class="txt c1 num" /></td>
					<td class="td5 trX"><span> </span><a id="lblChemistry_mn" class="lbl"> </a></td>
					<td class="td6 trX"><input id="txtChemistry_mn" type="text" class="txt c1 num" /></td>
				</tr>
				<tr class="tr5">
					<td class="td1 trX"><span> </span><a id='lblChemistry_p' class="lbl"> </a></td>
					<td class="td2 trX"><input id="txtChemistry_p"  type="text"  class="txt c1 num"/></td>
					<td class="td3 trX"><span> </span><a id="lblChemistry_s" class="lbl"> </a></td>
					<td class="td4 trX"><input id="txtChemistry_s" type="text" class="txt c1 num" /></td>
					<td class="td5 trX"><span> </span><a id="lblChemistry_cr" class="lbl"> </a></td>
					<td class="td6 trX"><input id="txtChemistry_cr" type="text" class="txt c1 num" /></td>
				</tr>                               
				<tr class="tr6">
					<td class="td1 trX"><span> </span><a id='lblChemistry_ni' class="lbl"> </a></td>
					<td class="td2 trX"><input id="txtChemistry_ni"  type="text"  class="txt c1 num"/></td>
					<td class="td3 trX"><span> </span><a id="lblChemistry_n" class="lbl"> </a></td>
					<td class="td4 trX"><input id="txtChemistry_n" type="text" class="txt c1 num" /></td>
					<td class="td5 trX"><span> </span><a id="lblChemistry_cu" class="lbl"> </a></td>
					<td class="td6 trX"><input id="txtChemistry_cu" type="text" class="txt c1 num" /></td>
				</tr>                               
				<tr>
					<td colspan="6" class="trXA"><span> </span><a class="trTitle" id="lblMechanicalstrength"></a></td>
				</tr>
				<tr class="tr7">
					<td class="td1 trXA"><span> </span><a id='lblTs' class="lbl"> </a></td>
					<td class="td2 trXA"><input id="txtTs"  type="text"  class="txt c1 num"/></td>
					<td class="td3 trXA"><span> </span><a id="lblYs" class="lbl"> </a></td>
					<td class="td4 trXA"><input id="txtYs" type="text" class="txt c1 num" /></td>
					<td class="td5 trXA"><span> </span><a id="lblElong" class="lbl"> </a></td>
					<td class="td6 trXA"><input id="txtElong" type="text" class="txt c1 num" /></td>
				</tr>
				<tr>
					<td colspan="6" class="trX"><span> </span><a class="trTitle" id="lblHardness"></a></td>
				</tr>
				<tr class="tr8">
					<td class="td1 trX"><span> </span><a id='lblHrb' class="lbl"> </a></td>
					<td class="td2 trX"><input id="txtHrb"  type="text"  class="txt c1 num"/></td>
					<td class="td3 trX"><span> </span><a id="lblHv" class="lbl"> </a></td>
					<td class="td4 trX"><input id="txtHv" type="text" class="txt c1 num" /></td>
					<td class="td5 trX"></td>
					<td class="td6 trX"></td>
				</tr>    
			</table>
        </div>
	</div>
	<input id="q_sys" type="hidden" />
	<input id="q_sys" type="hidden" />
</body>
</html>