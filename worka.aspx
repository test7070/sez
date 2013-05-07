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
		q_tables = 's';
		var q_name = "worka";
		var decbbs = ['mount','weight'];
		var decbbm = ['mount'];
		var q_readonly = ['txtWorker'];
		var q_readonlys = [];
		var bbmNum = [];  // 允許 key 小數
		var bbsNum = [];
		var bbmMask = [];
		var bbsMask = [];
		q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea';
		//ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(
					['txtStationno', 'btnStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
					['txtStoreno','btnStore','store','noa,store','txtStoreno,txtStore','store_b.aspx'],
					['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx'],
					['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
		);
		$(document).ready(function () {
			bbmKey = ['noa'];
			bbsKey = ['noa', 'noq'];
			q_brwCount();  // 計算 合適  brwCount 
			 q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST

		});

		//////////////////   end Ready
	   function main() {
		   if (dataErr)  /// 載入資料錯誤
		   {
			   dataErr = false;
			   return;
		   }

			mainForm(1); // 1=最後一筆  0=第一筆

			$('#txtDatea').focus();
			
		} 
		function mainPost() { // 載入資料完，未 refresh 前
			q_getFormat();
			bbmMask = [['txtDatea', r_picd], ['txtCucdate', r_picd]];
			q_mask(bbmMask);
			q_cmbParse("cmbTypea", q_getPara('worka.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
			/*$('#btnquat').click(function () { btnquat(); });*/
			$('#btnCuaimport').click(function(){
				var t_where = '';
				var ordeno = $('#txtOrdeno').val();
				if(ordeno && ordeno.length >0){
					t_where = "where=^^ ordeno='" + ordeno + "' ^^";
					q_gt('cua_cuas',t_where , 0, 0, 0, "", r_accy);
				}else{
					alert('請輸入' + q_getMsg('lblOrdeno'));
				}
			});
		}

		function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
			var ret; 
			switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
				case 'ordes':
					if (q_cur > 0 && q_cur < 4) {
						b_ret = getb_ret();
						if (!b_ret || b_ret.length == 0)
							return;
						var i, j = 0;
						ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2', b_ret.length, b_ret
														   , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2'
														   , 'txtProductno,txtProduct,txtSpec');   /// 最後 aEmpField 不可以有【數字欄位】
						bbsAssign();

						for (i = 0; i < ret.length; i++) {
							k = ret[i];  ///ret[i]  儲存 tbbs 指標
							if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
								$('#txtMount_' + k).val(b_ret[i]['notv']);
								$('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
							}
							else {
								$('#txtWeight_' + k).val(b_ret[i]['notv']);
								$('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv'], b_ret[i]['weight']));
							}

						}  /// for i
					}
					break;
				
				case q_name + '_s':
					q_boxClose2(s2); ///   q_boxClose 3/4
					break;
			}   /// end Switch
			b_pop = '';
		}


		function q_gtPost(t_name) {  /// 資料下載後 ...
			switch (t_name) {
				case 'cua_cuas':
					var as = _q_appendData("cua_cuas", "", true);
					if(as[0]!=undefined){
						q_gridAddRow(bbsHtm, 'tbbs', 'txtProduct,txtProductno,txtUnit,txtMount', 1, as,
						 'product,productno,unit,cuamount', 'txtProductno');
					}
					break;
				case q_name: if (q_cur == 4)   // 查詢
					q_Seek_gtPost();
					break;
				}  /// end switch
		}

		function btnOk() {
			t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
			if (t_err.length > 0) {
				alert(t_err);
				return;
			}

			$('#txtWorker').val(r_name)
			sum();

			var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
			if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
				q_gtnoa(q_name, replaceAll('A' + $('#txtDatea').val(), '/', ''));
			else
				wrServer(s1);
		}

		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;

			q_box('worka_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
		}

		function bbsAssign() {  /// 表身運算式
			_bbsAssign();
			for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
				$('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
				$('#btnProductno_' + j).click(function () {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					pop('ucc');
				 });
				 $('#txtProductno_' + j).change(function () {
					 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					 q_bodyId($(this).attr('id'));
					 b_seq = t_IdSeq;
					 q_change($(this), 'ucc', 'noa', 'noa,product,unit');  /// 接 q_gtPost()
				 });

			} //j
		}

		function btnIns() {
			_btnIns();
			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
			$('#txtDatea').val(q_date());
			$('#txtDatea').focus();
		 }
		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;
			_btnModi();
			$('#txtProduct').focus();
		}
		function btnPrint() {
 
		}

		function wrServer( key_value) {
			var i;

			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			_btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
		}

		function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
			if (!as['productno']) {  //不存檔條件
				as[bbsKey[1]] = '';   /// no2 為空，不存檔
				return;
			}

			q_nowf();
			as['date'] = abbm2['date'];
			as['custno'] = abbm2['custno'];
			return true;
		}

		function sum() {
			var t1 = 0, t_unit, t_mount, t_weight = 0;
			for (var j = 0; j < q_bbsCount; j++) {

			}  // j
		}
		function refresh(recno) {
			_refresh(recno);
		}

		function readonly(t_para, empty) {
			_readonly(t_para, empty);
		}

		function btnMinus(id) {
			_btnMinus(id);
			sum();
		}

		function btnPlus(org_htm, dest_tag, afield) {
			_btnPlus(org_htm, dest_tag, afield);
			if (q_tables == 's')
				bbsAssign();  /// 表身運算式 
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
		.tview
		{
			FONT-SIZE: 12pt;
			COLOR:  Blue ;
			background:#FFCC00;
			padding: 3px;
			TEXT-ALIGN:  center;
		}	
		.tbbm
		{
			FONT-SIZE: 12pt;
			COLOR: blue;
			TEXT-ALIGN: left;
			border-color: white; 
			width:98%; border-collapse: collapse; background:#cad3ff;
		} 
		
		.tbbs
		{
			FONT-SIZE: 12pt;
			COLOR: blue ;
			TEXT-ALIGN: left;
			 BORDER:1PX LIGHTGREY SOLID;
			 width:98% ; height:98% ;  
		} 
		
	   
		.column1
		{
			width: 10%;
		}
		.column2
		{
			width: 10%;
		}	  
		.column3
		{
			width: 10%;
		}   
		.column4
		{
			width: 8%;
		}		   
		 .label1
		{
			width: 8%; text-align:right;
		}	   
		.label2
		{
			width: 10%; text-align:right;
		}
		.label3
		{
			width: 10%; text-align:right;
		}
	   .txt.c1
	   {
		   width: 95%;
	   }
	   .txt.c2
	   {
		   width: 45%;
	   }
	  
	</style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
		<div class="dview" id="dview" style="float: left;  width:32%;"  >
		   <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
			<tr>
				<td align="center" style="width:5%"><a id='vewChk'></a></td>
				<td align="center" style="width:20%"><a id='vewDatea'></a></td>
				<td align="center" style="width:25%"><a id='vewOrdeno'></a></td>
				<td align="center" style="width:40%"><a id='vewProduct'></a></td>
			</tr>
			 <tr>
				   <td ><input id="chkBrow.*" type="checkbox" style=' '/>.</td>
				   <td align="center" id='datea'>~datea</td>
				   <td align="center" id='ordeno'>~ordeno</td>
				   <td align="center" id='productno product'>~productno ~product</td>
			</tr>
		</table>
		</div>
		<div class='dbbm' style="width: 68%;float:left">
		<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
		<tr>
			<td class='label1'><a id="lblType" ></a></td>
			<td class="column1"><select id="cmbTypea" class="txt c1"> </select></td>
			<td class='label2'><a id="lblDatea" ></a></td>
			<td class="column2"><input id="txtDatea" type="text" class="txt c1"/></td>
			<td class='label3'><a id="lblNoa" ></a></td>
			<td class="column3"><input id="txtNoa"   type="text" class="txt c1"/></td>
		</tr>
		<tr>
			<td class='label1'><input id="btnStation" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
			<td class="column1">
				<input id="txtStationno" type="text" class="txt c2"/>
				<input id="txtStation" type="text" class="txt c2"/>
			</td>
			<td class='label2'><a id="lblCucdate" ></a></td>
			<td class="column2"><input id="txtCucdate" type="text"  class="txt c1"/></td>
			<td class='label3'><a id="lblWorkno" ></a></td>
			<td class="column3"><input id="txtWorkno" type="text"  class="txt c1"/></td></tr>
		<tr>		
			<td class="label1"><input id="btnStore" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
			<td class="column1"><input id="txtStoreno"  type="text" class="txt c2"/><input id="txtStore" type="text" class="txt c2"/></td> 
			<td class='label2'><a id="lblProcess" ></a></td>
			<td class="column2"><input id="txtProcessno" type="text" class="txt c2"/><input id="txtProcess" type="text"  class="txt c2"/></td>
			<td class='label3'><a id="lblOrdeno" ></a></td>
			<td class="column3"><input id="txtOrdeno" type="text"  style='width:80%;'/><input id="txtNo2" type="text"  style='width:10%;'/></td></tr>

		<tr>
			<td class='label1'><a id="lblProductno" ></a></td>
			<td class="column1"><input id="txtProductno" type="text"  class="txt c1"/></td>
			<td class='label2'><a id="lblMold" ></a></td>
			<td class="column2"><input id="txtMoldno" type="text" class="txt c2"/><input id="txtMold" type="text" class="txt c2"/></td>
			<td class='label3'><a id="lblWorker" ></a></td>
			<td class="column3"><input id="txtWorker" type="text"  class="txt c1"/></td></tr>
		<tr>
			<td class='label1'><a id="lblProduct" ></a></td>
			<td class="column1" colspan='5'><input id="txtProduct" type="text"  style="width: 99%;"/></td>
		</tr>
						<tr>
			<td class='label1'><a id="lblMemo" ></a></td>
			<td class="column1" colspan='5'><input id="txtMemo" type="text"  style="width: 99%;"/></td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<input type="button" id="btnCuaimport">
				<input type="button" id="btnAMimport">
			</td>
		</tr>
		</table>
		</div>
	
		<div class='dbbs'>
		<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
			<tr style='color:White; background:#003366;' >
				<td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
				<td align="center"><a id='lblProductnos'></a></td>
				<td align="center"><a id='lblProducts'></a></td>
				<td align="center"><a id='lblUnit'></a></td>
				<td align="center"><a id='lblMounts'></a></td>
				<td align="center"><a id='lblProcesss'></a></td>
				<td align="center"><a id='lblTypes'></a></td>
				<td align="center"><a id='lblMechno'></a></td>
				<td align="center"><a id='lblMech'></a></td>
				<td align="center"><a id='lblMemos'></a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
				<td style="width:10%;">
					<input class="txt"  id="txtProductno.*" type="text" style="width:80%;" />
					<input class="btn"  id="btnProductno.*" type="button" value='...' style="width:10%;"  />
				</td>
				<td style="width:10%;">
					<input id="txtProduct.*" type="text" class="txt c1"/>
				</td>
				<td style="width:4%;">
					<input id="txtUnit.*" type="text" class="txt c1"/>
				</td>
				<td style="width:12%;">
					<input id="txtMount.*" type="text" class="txt c1" style="text-align:right"/>
				</td>
				<td style="width:10%;">
					<input id="txtProcess.*" type="text" class="txt c1"/>
				</td>
				<td style="width:10%;">
					<input id="txtTypea.*" type="text" class="txt c1"/>
				</td>
				<td style="width:10%;">
					<input class="txt" id="txtMechno.*" type="text" style="width:80%;" />
					<input class="btn"  id="btnMechno.*" type="button" value='...' style="width:10%;"  />
				</td>
				<td style="width:10%;">
					<input id="txtMech.*" type="text" class="txt c1"/>
				</td>
				<td style="width:12%;">
					<input id="txtMemo.*" type="text" class="txt c1"/>
					<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
				</td>
			</tr>
		</table>
		</div>
		<input id="q_sys" type="hidden" />
</body>
</html>
