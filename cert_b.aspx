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
			var bbmNum = [];
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
				_btnIns();
				$('#txtNoa').focus();
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
					<td align="center" style="width:40%"><a id='vewVccno' class="lbl"> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='vccno'>~vccno</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing=''>
				<tr class="tr1">
					<td class="td1" ><span> </span><a id='lblNoa' class="lbl"> </a></td>
					<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblVccno" class="lbl" style="font-size: 14px;"> </a></td>
					<td class="td4"><input id="txtVccno" type="text" class="txt c1" /></td>
					<td class="td5"><span> </span><a id="lblDatea" class="lbl"> </a></td>
					<td class="td6"><input id="txtDatea" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr2">
					<td class="td1" colspan="2"><span> </span><a id='lblComp' class="lbl"> </a></td>
					<td class="td2" colspan="5"><input id="txtComp"  type="text" class="txt c1" /></td>
				</tr>  
				<tr class="tr3">
					<td class="td1"><span> </span><a id='lblAddress' class="lbl"> </a></td>
					<td class="td2" colspan="5"><input id="txtAddr"  type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr4">
					<td class="td1"><span> </span><a id='lblShipped' class="lbl"> </a></td>
					<td class="td2" colspan="3"><input id="txtShipped"  type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr5">
					<td class="td1" ><span> </span><a id='lblFroma' class="lbl"> </a></td>
					<td class="td2" colspan="5"><input id="txtFroma"  type="text"  class="txt c1"/></td>
				</tr>                               
				<tr class="tr6">
					<td class="td1" ><span> </span><a id='lblToa' class="lbl"> </a></td>
					<td class="td2" colspan="5"><input id="txtToa"  type="text"  class="txt c1"/></td>
				</tr>                               
				<tr class="tr7">
					<td class="td1" ><span> </span><a id='lblEtd' class="lbl"> </a></td>
					<td class="td2"><input id="txtEtd"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblEta" class="lbl"> </a></td>
					<td class="td4"><input id="txtEta" type="text" class="txt c1" /></td>
					<td class="td5"><span> </span><a id='lblClosing' class="lbl"> </a></td>
					<td class="td6"><input id="txtClosing"  type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr8">
					<td class="td1" ><span> </span><a id='lblPno' class="lbl"> </a></td>
					<td class="td2"><input id="txtPno"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblCno" class="lbl"> </a></td>
					<td class="td4"><input id="txtCno" type="text" class="txt c1" /></td>
					<td class="td5"><span> </span><a id="lblLcno" class="lbl"> </a></td>
					<td class="td6"><input id="txtLcno" type="text" class="txt c1" /></td>
				</tr>    
				<tr class="tr9">
					<td class="td1"><span> </span><a id="lblTotal" class="lbl"> </a></td>
					<td class="td2"><input id="txtTotal" type="text" class="txt c1 num" /></td>
					<td class="td3"><span> </span><a id="lblUsd" class="lbl"> </a></td>
					<td class="td4"><input id="txtUsd" type="text" class="txt c1 num" /></td>
					<td class="td5" colspan="2" align="center">
						<input id="btnInvo" type="button">
						<input id="btnPack" type="button">
					</td>
					
				</tr>
				<tr class="tr10">
					<td class="td1"><span> </span><a id='lblTitle' class="lbl"> </a></td>
					<td class="td2" colspan="5"><input id="txtTitle"  type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr11">
					<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
					<td class="td2" colspan="5"><textarea id="txtMemo"  style="width:95%; height: 60px;"> </textarea></td>
				</tr>
			</table>
        </div>
	</div>
	<input id="q_sys" type="hidden" />
	<input id="q_sys" type="hidden" />
</body>
</html>