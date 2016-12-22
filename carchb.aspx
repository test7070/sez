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
		var q_name="carchb";
		var q_readonly = ['txtWorker'];
		var bbmNum = []; 
		var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwCount2=20; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
		
		$(document).ready(function () {
			bbmKey = ['noa'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1);
			$('#txtNoa').focus();
			
			if (r_rank >= 8){
				q_content = "";
				q_gt(q_name, q_content, q_sqlCount, 1);
			}else{
				//q_content = "where=^^noa='" + r_userno + "'^^";
				t_where = "where=^^ a.noa='" + q_name + "' and a.sssno='"+r_userno+"' ^^";
				q_gt('authority', t_where, 0, 0, 0, "", r_accy);
			}
		
		});
		
	   function main() {
		   if (dataErr)   
		   {
			   dataErr = false;
			   return;
		   }
			mainForm(0); 
		}


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
			
			if (q_getPara('sys.project').toUpperCase()=='XY'){
				$('.isXY').show();
			}else{
				$('.isXY').hide();
			}
			
		}
		
		function q_boxClose(s2) { 
			 var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				
			}
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
			Unlock();
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
				width: 400px;
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
				<td align="center" style="width:5%"><a id='vewChk'> </a></td>				
				<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
				<td align="center" style="width:70%"><a id='vewNamea'> </a></td>								
			</tr>
			 <tr>
				   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
				   <td align="center" id='noa'>~noa</td>
				   <td align="center" id='namea'>~namea</td>
			</tr>
		</table>
		</div>
		<div class='dbbm' style="float: left;">
		<table class="tbbm"  id="tbbm"   border="1">			
				<tr align="center">
					<td rowspan="3"> 項<br> 次 </td>
					<td rowspan="3"> 檢　查　項　目 </td>
					<td rowspan="3">　檢　查　標　準　</td>
					<td colspan="3">前手駕駛座頁中檢察</td>
					<td colspan="3">後手駕駛座頁中檢察</td>
				<tr>
				<tr align="center">
					<td>時機</td>
					<td>正常</td>
					<td>異常</td>
					<td>時機</td>
					<td>正常</td>
					<td>異常</td>
		        </tr>
				<tr align="center">
					<td rowspan="5"> 板<br> 櫃 </td>
					<td>簾幕、雨棚</td>
					<td>無破損漏水、束帶完整、操作順暢</td>
					<td rowspan="28">尾<p>車<p>車<p>尾<p>號<p>︵<p>︶</td>
					<td></td>
					<td></td>
					<td rowspan="28">尾<p>車<p>車<p>尾<p>號<p>︵<p>︶</td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>車柄及中性</td>
					<td>完整無變形操作順暢</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>簾幕櫃</td>
					<td>櫃頂、尾門、防水條完整無變形</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>綑綁器</td>
					<td>完整無變形</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>安全插銷</td>
					<td>安全插銷處、插銷完整</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
		<!--------------------------------------------------->
				<tr align="center">
					<td rowspan="6"> 油<br> 罐 </td>
					<td>人孔蓋</td>
					<td>扣抱緊路良好、墊圈完整無洩漏、異味及油漬</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>槽體、爬梯、排水閥</td>
					<td>外觀無變形、龜裂、銹蝕等，槽頂排水順暢閥門正常</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>洩料軟管</td>
					<td>外觀無變破損二端接頭無變形墊圏、盲塞完整</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>管路、溫度表</td>
					<td>支架固定穩固、管路無歸裂滲漏、溫度表作用正常</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>閥門、接地線</td>
					<td>裝、卸料閥操作順暢無洩漏、緊急遮斷間、通氣閥、<br>
					呼吸閥作用正常，盲蓋、墊圈、接地線等完整。</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>煞車反鎖</td>
					<td>操作及作用正常、閥門及管路無漏氣</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
		<!--------------------------------------------------->
				<tr align="center">
					<td rowspan="7"> 高<br> 壓 </td>
					<td>槽體</td>
					<td>外觀無變形、龜裂、銹蝕等</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>管路、壓力（溫度）<br>表</td>
					<td>支架固定穩固、管路無歸裂滲漏、壓力(溫度)<br>
					表作用正常</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>洩料軟管</td>
					<td>外表鋼絲及接頭處無破損</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>閥門、接地線</td>
					<td>操作順暢無滲漏油漬異味、盲蓋、墊圈等完整</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>煞車反鎖</td>
					<td>操作及作用正常、閥門及管路無溫度</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>安全閥</td>
					<td>閥門在開位置、鉛封完整、作用正常</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>洩料馬達及幫浦</td>
					<td>幫浦油面視窗一半以上，馬達線無破損，無<br>
					熔絲開關及電磁開關完整</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
		<!--------------------------------------------------->
				<tr align="center">
					<td rowspan="7"> 粉<br> 粒<br> 槽 </td>
					<td>蒸發器</td>
					<td>固定座、螺絲完整無鬆脫、管路無洩漏龜裂</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>槽體、爬梯</td>
					<td>外觀無變形、龜裂、銹蝕等，卸料等無漏氣</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>管路</td>
					<td>支架、管束固定穩固、管路無龜裂滲漏</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>安全閥、壓力表</td>
					<td>開啟壓力正常、管壓、桶壓壓力錶作用正常</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>閥門、接地線</td>
					<td>卸料閥操作順暢無滲漏作用正常、盲蓋、墊圈、接<br>
					地線等完整。</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>人孔蓋</td>
					<td>扣把緊度良好完整、墊圈完整卸料時無洩漏</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>震動馬達</td>
					<td>作用良好</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
		<!--------------------------------------------------->
				<tr align="center">
					<td rowspan="3"> 傾<br> 卸<br> 車 </td>
					<td>覆蓋網、馬達</td>
					<td>不破損、作用正常</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>攀昇油壓缸</td>
					<td>支架固定穩固、油壓缸、軟管無破損滲漏</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
				<tr align="center">
					<td>車斗及尾門</td>
					<td>無破損變形、尾門開啟及緊閉良好</td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
		        </tr>
		<!--------------------------------------------------->
				<tr>
					<td colspan="2">值班人員檢查出車<br>駕駛員身體狀況</td>
					<td colspan="7">1.精神狀況：<input type="checkbox" name="a01">佳</input>
												<input type="checkbox" name="a02">不佳</input>　　
									2.喝酒或吃藥：<input type="checkbox" name="a03">有</input>
												<input type="checkbox" name="a04">沒有</input>  酒測值_____mg/L<br>
									3.血壓及心跳：_____/_____/_____ <input type="checkbox" name="a05">合格</input>
																	<input type="checkbox" name="a05">不合格</input><br>
									4.監督員簽名：　　　　日期：　　　　時間：　　時　　分
					</td>
				<tr>
				<tr align="center">
					<td colspan="2"> 異　常　說　明 </td>
					<td colspan="5"></td>
					<td colspan="2">修復單編號：<p></td>
				<tr>
				<tr>
					<td colspan="9">註：1.以上檢查油、水、氣不足請自行添加，其他異常無法處理請填修復單請修。<br>
									　　2.未依規定執行回廠及出車前檢查者每次依品質獎金核發準則減發500元。<br>
									　　3.駕駛員精神、身體狀況不佳(高血壓含160以上)或飲酒者(酒測值含0.001mg/L以上)不准出車。<br>
					</td>
				<tr>
				<tr>
					<td>調度員：__________________　　　　後手駕駛員：__________________　　　　前手駕駛員：__________________
					</td>
				<tr>
					
		</table>
		</div>
		</div> 
		<input id="q_sys" type="hidden" />	
</body>
</html>
