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
		var q_name="lc";
		var q_readonly = ['txtWorker','txtWorker2'];
		var bbmNum = []; 
		var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
		//ajaxPath = ""; //  execute in Root
		aPop = new Array(['txtNoa', 'lblNamea','acc','acc1,acc2', 'txtNoa,txtNamea', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
		 				  ['txtAccno', 'lblAccno','acc','acc1,acc2', 'txtAccno', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
		 				  ['txtAccno2', 'lblAccno2','acc','acc1,acc2', 'txtAccno2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
		 				  ['txtAccno4', 'lblAccno4','acc','acc1,acc2', 'txtAccno4', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
		 				  ['txtAccno6', 'lblAccno6','acc','acc1,acc2', 'txtAccno6', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
		$(document).ready(function () {
			bbmKey = ['noa'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1)
			$('#txtNoa').focus();
		});
 
	   function main() {
		   if (dataErr)   
		   {
			   dataErr = false;
			   return;
		   }
			mainForm(0); // 1=Last  0=Top
		}  

		function mainPost() { 
			bbmMask = [['txtDatea',r_picd]]; 
			q_mask(bbmMask);
			q_cmbParse("cmbCoin", q_getPara('sys.coin'));
			$('#btnDetail').click(function(){
				var t_noa = trim($('#txtNoa').val()).replace('.','');
				if(t_noa.length > 0){
					var t_where = "left(noa," + t_noa.length+")='"+t_noa+"' and len(noa)=" +(t_noa.length+3);
					q_box('lcs.aspx', 'lcs;' + t_where, "95%", "95%", q_getMsg('popLcs'));
				}
			});
		}

		function q_boxClose( s2) {
			var ret; 
			switch (b_pop) {
				case q_name + '_s':
					q_boxClose2(s2); ///   q_boxClose 3/4
					break;
			}   /// end Switch
		}


		function q_gtPost(t_name) {  
			switch (t_name) {
				case q_name: if (q_cur == 4)  
						q_Seek_gtPost();
					break;
			}  /// end switch
		}
		
		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
		}

		function combPay_chg() {   
			var cmb = document.getElementById("combPay")
			if (!q_cur) 
				cmb.value = '';
			else
				$('#txtPay').val(cmb.value);
			cmb.value = '';
		}

		function btnIns() {
			_btnIns();
			$('#txtNoa').focus();
		}

		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;

			_btnModi();
			$('#txtComp').focus();
		}

		function btnPrint() {
 
		}
		function btnOk() {
			var t_err = '';

			t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
			if( t_err.length > 0) {
				alert(t_err);
				return;
			}
			if(q_cur==1)
				$('#txtWorker').val(r_name);
			else
				$('#txtWorker2').val(r_name);
			var t_noa = trim($('#txtNoa').val());
			if ( t_noa.length==0 )  
				q_gtnoa(q_name, t_noa);
			else
				wrServer(  t_noa);
		}

		function wrServer( key_value) {
			var i;

			xmlSql = '';
			if (q_cur == 2)   /// popSave
				xmlSql = q_preXml();

			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			_btnOk(key_value, bbmKey[0], '','',2);
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
		}

		function q_appendData(t_Table) {
			return _q_appendData(t_Table);
		}

		function btnSeek(){
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
		 #dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 98%;
				margin: -1px;
				border: 1px black solid;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 9%;
			}
			.tbbm .tdZ {
				width: 2%;
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
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c4 {
				width: 18%;
				float: left;
			}
			.txt.c5 {
				width: 80%;
				float: left;
			}
			.txt.c6 {
				width: 50%;
				float: left;
			}
			.txt.c7 {
				width: 70%;
				float: left;
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size:medium;
			}
			.tbbm textarea {
				font-size: medium;
			}
			
			 input[type="text"],input[type="button"] {	 
				font-size: medium;
			}
			.tbbm .ch1, .tbbm .ch2, .tbbm .ch3, .tbbm .ch4 {background-color:  #FFEC8B; text-align: right;font-size: medium;}
	</style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
		<div class="dview" id="dview" style="float: left;  width:25%;"  >
		   <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
			<tr>
				<td align="center" style="width:5%"><a id='vewChk'></a></td>
				<td align="center" style="width:15%"><a id='vewNoa'></a></td>
				<td align="center" style="width:30%"><a id='vewNamea'></a></td>
				<td align="center" style="width:15%"><a id='vewAccno3'></a></td>
				<td align="center" style="width:30%"><a id='vewAccname3'></a></td>
			</tr>
			 <tr>
				   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
				   <td align="center" id='noa'>~noa</td>
				   <td align="center" id='namea'>~namea</td>
				   <td align="center" id='accno3'>~accno3</td>
				   <td align="center" id='accname3'>~accname3</td>
			</tr>
		</table>
		</div>
		<div class='dbbm' style="width: 70%;float: left;">
		<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
		  <tr class="tr1">
			   <td class="td1"><span> </span><a id="lblNamea" class="lbl btn"></a></td>
			   <td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
			   <td class="td4" colspan="2"><input id="txtNamea" type="text" class="txt c1" /></td>
			   <td class="td5"><span> </span><a id="lblCredit" class="lbl"></a></td>
			   <td class="td6"><input id="txtCredit" type="text" class="txt num c1" /></td>
			   <td class="td7"><span> </span><a id="lblDatea" class="lbl"></a></td>
			   <td class="td8"><input id="txtDatea" type="text" class="txt c1" /></td>  
			</tr>
			<tr class="tr2">
			   <td class="td1"><span> </span><a id="lblAccno" class="lbl btn"></a></td>
			   <td class="td2"><input id="txtAccno" type="text" class="txt c1"/></td>
			   <td class="td3"><span> </span><a id="lblAccno2" class="lbl btn"></a></td>
			   <td class="td4"><input id="txtAccno2" type="text" class="txt c1" /></td>
			   <td class="td5"><span> </span><a id="lblAccno4" class="lbl btn"></a></td>
			   <td class="td6"><input id="txtAccno4" type="text" class="txt c1" /></td>
			   <td class="td7"><span> </span><a id="lblAccno6" class="lbl btn"></a></td>
			   <td class="td8"><input id="txtAccno6" type="text" class="txt c1" /></td>
			   <td class="td9"><span> </span><a id="lblAccno5" class="lbl"></a></td>
			   <td class="tdA"><input id="txtAccno5" type="text" class="txt c1" /></td> 
			</tr> 
			<tr class="tr3">
				<td align="left"><a id="lblSet" style="color: #000066;font-size: 20px;"></a></td>
			</tr> 
			<tr class="tr4">
			   <td class="ch1"><span> </span><a id="lblConrate2" class="lbl"></a></td>
			   <td class="ch2"><input id="txtConrate2" type="text" class="txt num c7"/> <a id="lblSymbol" ></a></td>
			   <td class="ch3"><span> </span><a id="lblConrate1" class="lbl"></a></td>
			   <td class="ch4"><input id="txtConrate1" type="text" class="txt num c7"/> <a id="lblSymbol1"></a></td>
			   <td class="td5"><span> </span><a id="lblExpire" class="lbl"></a></td>
			   <td class="td6"><input id="txtExpire" type="text" class="txt num c2"/> <a id="lblsymbol2"></a></td>
			   <td class="td7"><span> </span><a id="lblRate" class="lbl"></a></td>
			   <td class="td8"><input id="txtRate" type="text" class="txt num c1"/></td>
			   <td class="td9"><span> </span><a id="lblCoin" class="lbl"></a></td>
			   <td class="tdA"><select id="cmbCoin" class="txt c1"></select></td>  
			</tr>
			<tr class="tr5">
			   <td class="td1"><span> </span><a id="lblAccname3" class="lbl"></a></td>
			   <td class="td2"><input id="txtAccno3" type="text" class="txt c1"/></td>
			   <td class="td4" colspan="2"><input id="txtAccname3" type="text" class="txt c1"/></td>
			   <td class="td5"><span> </span><a id="lblUnpay" class="lbl"></a></td>
			   <td class="td6"><input id="txtUnpay" type="text" class="txt num c1"/></td>
			   <td class="td8" colspan="2"><input id="txtUnpayus" type="text" class="txt num c1"/></td>
			   <td class="td9"><span> </span><a id="lblTotal" class="lbl"></a></td>
			   <td class="tdA"><input id="txtTotal" type="text" class="txt num c1"/></td>  
			</tr>
			<tr class="tr6">
			   <td class="td1"><span> </span><a id="lblDetail" class="lbl"></a></td>
			   <td class="td2"><input id="btnDetail" type="button"/></td>
			   <td class="td3"><span> </span><a id="lblWorker" class="lbl"></a></td>
			   <td class="td4"><input id="txtWorker" type="text" class="txt c1"/></td>
			   <td class="td5"><span> </span><a id="lblWorker2" class="lbl"></a></td>
			   <td class="td6"><input id="txtWorker2" type="text" class="txt c1"/></td>
			</tr>
		</table>
		</div>
		</div> 
	<input id="q_sys" type="hidden" />
</body>
</html>
