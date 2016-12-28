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
		var q_name="carcha";
		var q_readonly = ['txtWorker'];
		var bbmNum = [['txtMiles',10,0,1],['txtCarmile',10,0,1]]; 
		var bbmMask = [['txtDatea', r_picd],['txtStime','99:99']]; 
		aPop = new Array(
			['txtDriverno', '', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
		);
		q_sqlCount = 6; brwCount = 6; brwCount2=20; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
		
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
			var bbmMask = [['txtDatea', r_picd],['txtStime','99:99']];
			q_mask(bbmMask); 
			$('#txtNoa').change(function(e){
			   	$(this).val($.trim($(this).val()).toUpperCase());		
				if($(this).val().length>0){
					if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
						t_where="where=^^ noa='"+$(this).val()+"'^^";
				   		q_gt('carcha', t_where, 0, 0, 0, "checkNoa_change", r_accy);
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
						break;
				
			}
		}


		function q_gtPost(t_name) {  
			switch (t_name) {
 				case 'checkNoa_change':
					var as = _q_appendData("carcha", "", true);
					if (as[0] != undefined){
						alert('已存在 '+as[0].noa+' '+as[0].namea);
					}
					Unlock();
					break;
				case 'checkNoa_btnOk':
					var as = _q_appendData("carcha", "", true);
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
			}
		}
		
		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)
				return;
		}
		function btnIns() {
			_btnIns();
			refreshBbm();
			$('#txtNoa').focus();
			$('#txtDatea').val(q_date());
			$('#txtDatea').focus();
		}

		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;
			_btnModi();
			refreshBbm();
			$('#txtDatea').focus();
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

			if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('carcha', t_where, 0, 0, 0, "checkNoa_btnOk", r_accy);
            }else{
                	wrServer($('#txtNoa').val());
            }
            if (q_cur == 1)
				$('#txtWorker').val(r_name);
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
				width: 350px;
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
				width: 750px;
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
				width: 49%;
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
				<td align="center" style="width:5%"><a id='vewChk'> </a>選</td>				
				<td align="center" style="width:40%"><a id='vewNoa'> </a>單據編號</td>
				<td align="center" style="width:50%"><a id='vewDriver'>駕駛員(檢查人)</a></td>								
			</tr>
			 <tr>
				   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
				   <td align="center" id='noa'>~noa</td>
				   <td align="center" id='driver'>~driver</td>
			</tr>
		</table>
		</div>
		<div class='dbbm' style="float: left;">
		<table class="tbbm"  id="tbbm" border="1">
			<tr align="center">
				<td colspan="2">單據編號</td>
				<td><input id="txtNoa"  type="text" class="txt c2"/></td>
				<td width="20%">駕駛員(檢查人)</td>
				<td width="20%">
					<input id="txtDriverno"  type="text" class="txt c2" />
					<input id="txtDriver"  type="text" class="txt c2" />
				</td>
			</tr>
			<tr align="center">
				<td colspan="2">檢查日期 </td>
				<td><input id="txtDatea"  type="text" class="txt c2"/></td>
				<td>檢查時間 </td>
				<td><input id="txtStime"  type="text" class="txt c1" /></td>
			</tr>
			<tr align="center">
				<td colspan="2">車　號</td>
				<td><input id="txtCarno"  type="text" class="txt c2" /></td>
				<td>里程數</td>
				<td><input id="txtMiles"  type="text" class="txt c1" /></td>
			</tr>
			<tr align="center">
				<td colspan="2">工　號</td>
				<td><input id="txtAddrno"  type="text" class="txt c2" /></td>
				<td>里程數</td>
				<td><input id="txtCarmile"  type="text" class="txt c1" /></td>
			</tr>		
			<tr align="center">
				<td width="10%"> 類別 </td>
				<td colspan="2">　　檢　查　項　目　　</td>
				<td>正常打ｖ</td>
				<td>　異　常　註　記　</td>
			</tr>
			<tr align="center">
	          <td rowspan="6">一<BR>檢<BR>查<BR>並<BR>加<BR>足</td>
	          <td width="10%">A</td>
	          <td>引擎機油是否足夠</td>
			  <td><input id="chkIaa" type="checkbox"/></td>
			  <td><input id="txtIaamemo"  type="text" class="txt c1" /></td>
	        </tr>
	        <tr align="center">
	          <td>B</td>
	          <td>冷卻液、電瓶水是否足夠、電瓶外是否損毀</td>
			  <td><input id="chkIbb" type="checkbox"/></td>
			  <td><input id="txtIbbmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>C</td>
	          <td>清潔液是否足夠</td>
			  <td><input id="chkIcc" type="checkbox"/></td>
			  <td><input id="txtIccmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>D</td>
	          <td>油箱是否加滿</td>
			  <td><input id="chkIdd" type="checkbox"/></td>
			  <td><input id="txtIddmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>E</td>
	          <td>輪胎胎壓是否足夠</td>
			  <td><input id="chkIee" type="checkbox"/></td>
			  <td><input id="txtIeememo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>F</td>
	          <td>煞車系統是否正常</td>
			  <td><input id="chkIff" type="checkbox"/></td>
			  <td><input id="txtIffmemo"  type="text" class="txt c1" /></td>
	        </tr>
	<!--------------------------------------------------->
			<tr align="center">
	          <td>二</td>
	          <td colspan="2">檢視機油、油箱、儲氣筒、水箱是否有異常洩漏</td>
			  <td><input id="chkIia" type="checkbox"/></td>
			  <td><input id="txtIiamemo"  type="text" class="txt c1" /></td>
	        </tr>
	<!--------------------------------------------------->
			<tr align="center">
	          <td>三</td>
	          <td colspan="2">是否排放儲氣筒內積水</td>
			  <td><input id="chkIiia" type="checkbox"/></td>
			  <td><input id="txtIiiamemo"  type="text" class="txt c1" /></td>
	        </tr>
	<!--------------------------------------------------->
			<tr align="center">
	          <td rowspan="4">四<BR>清<BR>潔</td>
	          <td>A</td>
	          <td>燈光作用是否正常</td>
			  <td><input id="chkIva" type="checkbox"/></td>
			  <td><input id="txtIvamemo"  type="text" class="txt c1" /></td>
	        </tr>
	        <tr align="center">
	          <td>B</td>
	          <td>反光板是否清潔並作用正常</td>
			  <td><input id="chkIvb" type="checkbox"/></td>
			  <td><input id="txtIvbmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>C</td>
	          <td>鏡片是否清潔並作用正常</td>
			  <td><input id="chkIvc" type="checkbox"/></td>
			  <td><input id="txtIvcmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>D</td>
	          <td>車體外觀是否清潔</td>
			  <td><input id="chkIvd" type="checkbox"/></td>
			  <td><input id="txtIvdmemo"  type="text" class="txt c1" /></td>
	        </tr>
	<!--------------------------------------------------->
			<tr align="center">
	          <td rowspan="5">五<BR>板<BR>架</td>
	          <td>A</td>
	          <td>氣管接頭是否有鬆脫或外漏情形</td>
			  <td><input id="chkVaa" type="checkbox"/></td>
			  <td><input id="txtVaamemo"  type="text" class="txt c1" /></td>
	        </tr>
	        <tr align="center">
	          <td>B</td>
	          <td>電線接頭是否有鬆脫或外露情形</td>
			  <td><input id="chkVbb" type="checkbox"/></td>
			  <td><input id="txtVbbmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>C</td>
	          <td>燈光是否清潔並作用良好</td>
			  <td><input id="chkVcc" type="checkbox"/></td>
			  <td><input id="txtVccmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>D</td>
	          <td>輪胎胎壓是否足夠</td>
			  <td><input id="chkVdd" type="checkbox"/></td>
			  <td><input id="txtVddmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>E</td>
	          <td>底盤各部位是否有無變形或滲漏現象</td>
			  <td><input id="chkVee" type="checkbox"/></td>
			  <td><input id="txtVeememo"  type="text" class="txt c1" /></td>
	        </tr>
	<!--------------------------------------------------->
			<tr align="center">
	          <td rowspan="3">六<BR>油槽<BR>貨櫃</td>
	          <td>A</td>
	          <td>油槽貨櫃表面是否有破損</td>
			  <td><input id="chkVia" type="checkbox"/></td>
			  <td><input id="txtViamemo"  type="text" class="txt c1" /></td>
	        </tr>
	        <tr align="center">
	          <td>B</td>
	          <td>油槽貨櫃各閥是否有異常</td>
			  <td><input id="chkVib" type="checkbox"/></td>
			  <td><input id="txtVibmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>C</td>
	          <td>檢視安全閥是否有鬆脫或有無洩漏現象</td>
			  <td><input id="chkVic" type="checkbox"/></td>
			  <td><input id="txtVicmemo"  type="text" class="txt c1" /></td>
	        </tr>
	<!--------------------------------------------------->
			<tr align="center">
	          <td rowspan="3">七<BR>安制<BR>　動<BR>全閥</td>
	          <td>A</td>
	          <td>固定卡榫及鏈條、勾環有無鬆脫</td>
			  <td><input id="chkViia" type="checkbox"/></td>
			  <td><input id="txtViiamemo"  type="text" class="txt c1" /></td>
	        </tr>
	        <tr align="center">
	          <td>B</td>
	          <td>煞車作用是否正常</td>
			  <td><input id="chkViib" type="checkbox"/></td>
			  <td><input id="txtViibmemo"  type="text" class="txt c1" /></td>
	        </tr>
			<tr align="center">
	          <td>C</td>
	          <td>氣管接頭是否有鬆脫或破裂情形</td>
			  <td><input id="chkViic" type="checkbox"/></td>
			  <td><input id="txtViicmemo"  type="text" class="txt c1" /></td>
	        </tr>
	<!--------------------------------------------------->
			<tr align="center">
	          <td rowspan="3">八<BR>安<BR>全<BR>裝<BR>備</td>
	          <td>A.共通性</td>
	          <td colspan="3" align="left">
		        <input id="chkViiiaa" type="checkbox"/>乾粉滅火器　　　
		        <input id="chkViiiab" type="checkbox"/>危險物品標示牌　
		        <input id="chkViiiac" type="checkbox"/>裝卸料檢點表　　<BR>
				<input id="chkViiiad" type="checkbox"/>水桶　　　　　　
				<input id="chkViiiae" type="checkbox"/>工具箱　　　　　
			 	<input id="chkViiiaf" type="checkbox"/>緊急應變手冊　　<BR>
				<input id="chkViiiag" type="checkbox"/>輪檔　　　　　　
				<input id="chkViiiah" type="checkbox"/>橡膠槌　　　　　
	          </td>
	        </tr>
	        <tr align="center">
	          <td>B.特殊裝備</td>
	          <td colspan="3" align="left">
				<input id="chkViiiba" type="checkbox"/>裝卸料檢點表　　
				<input id="chkViiibb" type="checkbox"/>水桶　　　　　　
				<input id="chkViiibc" type="checkbox"/>工具箱　　　　　<BR>
				<input id="chkViiibd" type="checkbox"/>耐酸手套　　　　
				<input id="chkViiibf" type="checkbox"/>護目鏡　　　　　
				<input id="chkViiibg" type="checkbox"/>接地鋼片　　　　<BR>
				<input id="chkViiibe" type="checkbox"/>防護面具(含慮毒罐)　　　　　　　
			  </td>
	        </tr>
			<tr align="center">
	          <td >C.急救箱</td>
	          <td colspan="3">雙氧水、碘酒、消炎粉、黃黴素軟膏、胺水、生理食鹽水、藥用棉花、繃帶捲<BR>
				(缺項請註明：<input id="txtViiicmemo"  type="text" class="txt　C2" style="float: none;width: 400px;"/>)
			  </td>
	        </tr>
	<!--------------------------------------------------->
			<tr align="center">
	          <td>九</td>
	          <td colspan="2">駕駛員服裝儀容是否整齊、精神是否良好</td>
			  <td><input id="chkIxa" type="checkbox"/></td>
			  <td><input id="txtIxamemo"  type="text" class="txt c1" /></td>
	        </tr>
	        <tr align="center">
	          <td  colspan="6">
					說明：檢驗人應確實執行並勾選，若填寫不完整或未經核准均為無效，不得出車。<BR>
					核檢人每周至少要抽檢2天。

			  </td>
	        </tr>
	       	<tr align="center">
	       	  <td  colspan="2">核准(調派人員)</td>
			  <td><input id="txtApv"  type="text" class="txt c2" /></td>
			  <td>核檢人</td>
			  <td><input id="txtWorker"  type="text" class="txt c1" /></td>
	        </tr>
		</table>
		</div>
		</div> 
		<input id="q_sys" type="hidden" />	
</body>
</html>
