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
		var q_name="uccga";
		var q_readonly = ['txtWorker'];
		var bbmNum = []; 
		var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwCount2=20; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
		//ajaxPath = ""; //  execute in Root
		
		$(document).ready(function () {
			bbmKey = ['noa'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1);
			$('#txtNoa').focus();
		});

		//////////////////   end Ready
	   function main() {
		   if (dataErr)   
		   {
			   dataErr = false;
			   return;
		   }
			mainForm(0); // 1=Last  0=Top
		}  ///  end Main()


		function mainPost() { 
			$('#txtNoa').change(function(e){
			   	$(this).val($.trim($(this).val()).toUpperCase());		
				if($(this).val().length>0){
					if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
						t_where="where=^^ noa='"+$(this).val()+"'^^";
				   		q_gt('uccga', t_where, 0, 0, 0, "checkNoa_change", r_accy);
					}else{
						Lock();
						alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
						Unlock();
					}
				}
			});
		}
		
		function q_boxClose(s2) { 
			 var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				
			}   /// end Switch
		}


		function q_gtPost(t_name) {  
			switch (t_name) {
 				case 'checkNoa_change':
					var as = _q_appendData("uccga", "", true);
					if (as[0] != undefined){
						alert('已存在 '+as[0].noa+' '+as[0].namea);
					}
					Unlock();
					break;
				case 'checkNoa_btnOk':
					var as = _q_appendData("uccga", "", true);
					if (as[0] != undefined){
						alert('已存在 '+as[0].noa+' '+as[0].namea);
						Unlock();
						return;
					}else{
						wrServer($('#txtNoa').val());
						Unlock();
					}
					break;
				case q_name: if (q_cur == 4)   
						q_Seek_gtPost();
					break;
			}  /// end switch
		}
		
		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
		}
		function btnIns() {
			_btnIns();
			refreshBbm();
			$('#txtNoa').focus();
		}

		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;
			_btnModi();
			refreshBbm();
		}

		function btnPrint() {
 
		}
		function q_stPost() {
			if (!(q_cur == 1 || q_cur == 2))
				return false;
		}
		function btnOk() {
			Lock(); 
			$('#txtNoa').val($.trim($('#txtNoa').val()));   	
			if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
			}else{
				alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
				Unlock();
				return;
			}
			$('#txtWorker').val(r_name);
			if(q_cur==1){
				t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
				q_gt('uccga', t_where, 0, 0, 0, "checkNoa_btnOk", r_accy);
			}else{
				wrServer($('#txtNoa').val());
			}
		 }

		function wrServer( key_value) {
			var i;

			xmlSql = '';
			if (q_cur == 2)   
				xmlSql = q_preXml();

			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			_btnOk(key_value, bbmKey[0], '','',2);
		}

		
		
		function refresh(recno) {
			_refresh(recno);
			 refreshBbm();
		}
		function refreshBbm(){
				if(q_cur==1){
					$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
				}else{
					$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
				}
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
				width: 250px;
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
				width: 600px;
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
	  
			 input[type="text"],input[type="button"] {	 
				font-size: medium;
			}
	</style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
		<div class="dview" id="dview" style="float: left;"  >
		   <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
			<tr>
				<td align="center" style="width:5%"><a id='vewChk'></a></td>				
				<td align="center" style="width:15%"><a id='vewNoa'></a></td>
				<td align="center" style="width:25%"><a id='vewNamea'></a></td>								
			</tr>
			 <tr>
				   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
				   <td align="center" id='noa'>~noa</td>
				   <td align="center" id='namea'>~namea</td>
			</tr>
		</table>
		</div>
		<div class='dbbm' style="float: left;">
		<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>			
			<tr>
			   <td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
			   <td class="td2"><input id="txtNoa"  type="text" class="txt c1" /></td>
			   <td class="td3"></td>
			   <td class="td4"></td>
			</tr>
			<tr>
			   <td class="td1"><span> </span><a id='lblNamea' class="lbl"></a></td>
			   <td class="td2"><input id="txtNamea"  type="text" class="txt c1"/></td>
			</tr>
			<tr>
			   <td class="td1"><span> </span><a id='lblWorker' class="lbl"></a></td>
			   <td class="td2"><input id="txtWorker"  type="text" class="txt c1"/></td>
			   <td class="td3"></td>
			   <td class="td4"></td>
			</tr>	  
		</table>
		</div>
		</div> 
		<input id="q_sys" type="hidden" />	
</body>
</html>
