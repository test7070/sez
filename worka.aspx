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
		q_desc=1;
		q_tables = 's';
		var q_name = "worka";
		var decbbs = ['mount','weight'];
		var decbbm = ['mount'];
		var q_readonly = ['txtWorker'];
		var q_readonlys = [];
		var bbmNum = [];  // 允許 key 小數
		var bbsNum = [['txtMount', 12, 0 , 1],['txtWeight', 15, 2 , 1]];
		var bbmMask = [['txtTimea', '99:99']];
		var bbsMask = [];
		q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea';
		//ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(
					['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
					['txtStoreno','lblStore','store','noa,store','txtStoreno,txtStore','store_b.aspx'],
					['txtCuano','lblCuano','inb','noa,datea','txtCuano,txtCuadate','inb_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy],
					['txtWorkno','lblWorknos','work','noa,stationno,station,processno,process,modelno,model,ordeno,no2','txtWorkno,txtStationno,txtStation,txtProcessno,txtProcess,txtModelno,txtModel,txtOrdeno,txtNo2','work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy],
					['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx'],
					['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
					['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx'],
					['txtProcessno','lblProcess','process','noa,process','txtProcessno,txtProcess','process_b.aspx','95%'],
					['txtOrdeno','lblOrdeno','ordes','noa,no2,productno,product','txtOrdeno,txtNo2,txtProductno,txtProduct','ordes_b.aspx','95%']
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
			bbmMask = [['txtDatea', r_picd], ['txtCuadate', r_picd],['txtTimea', '99:99']];
			q_mask(bbmMask);
			q_cmbParse("cmbTypea", q_getPara('worka.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
			
			$('#btnWorkimport').click(function(){
				if(emp($('#txtWorkno').val())){
					alert('請輸入' + q_getMsg('lblWorkno'));
					return;
				}
				var t_where = '';
                var workno = $('#txtWorkno').val();
                if(workno.length > 0)
                	t_where = "noa='" + workno + "'";
                q_box("works_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'works', "95%", "95%", q_getMsg('popWork'));
			});
			
			$('#txtWorkno').change(function(){
				var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
				q_gt('works', t_where , 0, 0, 0, "", r_accy);
			});
			$('#lblWorkno').click(function(){
				var t_where = emp($('#txtWorkno').val())?'':"charindex ('"+$('#txtWorkno').val()+"',noa)>0 ";
				q_box('work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";"+t_where+";" + r_accy, 'work', "95%", "95%", q_getMsg('popWork'));
			});
		}

		function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
			var ret; 
			switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
				case 'work':
                	b_ret = getb_ret();
                	if(b_ret){
                		$('#txtWorkno').val(b_ret[0].noa);
                		$('#txtStationno').val(b_ret[0].stationno);
                		$('#txtStation').val(b_ret[0].station);
                		$('#txtProcessno').val(b_ret[0].processno);
                		$('#txtProcess').val(b_ret[0].process);
                		$('#txtModelno').val(b_ret[0].modelno);
                		$('#txtModel').val(b_ret[0].model);
                		$('#txtOrdeno').val(b_ret[0].ordeno);
                		$('#txtNo2').val(b_ret[0].no2);

                		var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
						q_gt('works', t_where , 0, 0, 0, "", r_accy);
                	}
                break;
				case 'works':
					if (q_cur > 0 && q_cur < 4) {
						b_ret = getb_ret();
						if (!b_ret || b_ret.length == 0)
							return;
						var i, j = 0;
						for (i = 0; i < b_ret.length; i++) {
							if(b_ret[i].istd=='true'){
								b_ret[i].productno=b_ret[i].tproductno
								b_ret[i].product=b_ret[i].tproduct
							}
							
							if(b_ret[i].unit.toUpperCase()=='KG'){
								b_ret[i].xmount=0;
								b_ret[i].xweight=b_ret[i].emount;
							}else{
								b_ret[i].xmount=b_ret[i].emount;
								b_ret[i].xweight=0;
							}
						}
						
						q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtWeight,txtMemo', b_ret.length, b_ret
														   , 'productno,product,unit,xmount,xweight,memo'
														   , 'txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
						bbsAssign();
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
				case 'works':
					//清空表身資料
            		for(var i = 0; i < q_bbsCount; i++) {
            			$('#btnMinus_'+i).click();
            		}
					var as = _q_appendData("works", "", true);
					for (i = 0; i < as.length; i++) {
							if(as[i].istd=='true'){
								as[i].productno=as[i].tproductno
								as[i].product=as[i].tproduct
							}
							
							if(as[i].unit.toUpperCase()=='KG'){
								as[i].xmount=0;
								as[i].xweight=as[i].emount;
							}else{
								as[i].xmount=as[i].emount;
								as[i].xweight=0;
							}
						}
					q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtWeight,txtMemo', as.length, as
														   , 'productno,product,unit,xmount,xweight,memo'
														   , '');   /// 最後 aEmpField 不可以有【數字欄位】
				 break;
				case q_name: 
				if (q_cur == 4)   // 查詢
					q_Seek_gtPost();
					break;
				}  /// end switch
		}

		function btnOk() {
			t_err = '';
			t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
			if (t_err.length > 0) {
				alert(t_err);
				return;
			}

			$('#txtWorker').val(r_name)
			sum();

			var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
			if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
				q_gtnoa(q_name, replaceAll(q_getPara('sys.key_worka') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
			else
				wrServer(s1);
		}

		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;

			q_box('worka_s.aspx', q_name + '_s', "500px", "410px", q_getMsg("popSeek"));
		}

		function bbsAssign() {  /// 表身運算式
			_bbsAssign();
			for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
				$('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });

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
			q_box('z_workap.aspx'+ "?;;;noa="+trim($('#txtNoa').val())+";"+r_accy, '', "95%", "95%", m_print);
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
			as['datea'] = abbm2['datea'];
			as['cuano'] = abbm2['cuano'];
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
			if (t_para) {
				$('#btnWorkimport').attr('disabled', 'disabled');
			}else {
				$('#btnWorkimport').removeAttr('disabled');
			}
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
		
		function q_popPost(s1) {
		    	switch (s1) {
			        case 'txtWorkno':
           				var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
					    q_gt('works', t_where , 0, 0, 0, "", r_accy);
			        break;
		    	}
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
            	float:left;
                width: 22%;
                
            }
            .txt.c8 {
            	float:left;
                width: 65px;
                
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
         .dbbs .tbbs{
         	margin:0;
         	padding:2px;
         	border:2px lightgrey double;
         	border-spacing:1px;
         	border-collapse:collapse;
         	font-size:medium;
         	color:blue;
         	background:#cad3ff;
         	width: 100%;
         }
		 .dbbs .tbbs tr{
		 	height:35px;
		 }
		 .dbbs .tbbs tr td{
		 	text-align:center;
		 	border:2px lightgrey double;
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
				<td align="center" style="width:25%"><a id='vewNoa'></a></td>
				<td align="center" style="width:40%"><a id='vewProduct'></a></td>
			</tr>
			 <tr>
				   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
				   <td align="center" id='datea'>~datea</td>
				   <td align="center" id='noa'>~noa</td>
				   <td align="center" id='productno product'>~productno ~product</td>
			</tr>
		</table>
		</div>
		<div class='dbbm' style="width: 68%;float:left">
		<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
		<tr>
			<td><span> </span><a id='lblType' class="lbl"> </a></td>
			<td><select id="cmbTypea" class="txt c1"> </select></td>
			<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
			<td><input id="txtDatea" type="text" class="txt c1"/></td>
			<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
			<td><input id="txtNoa"   type="text" class="txt c1"/></td>
		</tr>
		<tr>
			<td><span> </span><a id='lblWorkno' class="lbl btn"> </a></td>
			<td><input id="txtWorkno" type="text"  class="txt c1"/></td>
			
			<td><span> </span><a id='lblStation' class="lbl btn"> </a></td>
			<td>
				<input id="txtStationno" type="text" class="txt c2"/>
				<input id="txtStation" type="text" class="txt c3"/>
			</td>
			<td><span> </span><a id='lblProcess' class="lbl btn"> </a></td>
			<td><input id="txtProcessno" type="text" class="txt c2"/><input id="txtProcess" type="text"  class="txt c3"/></td>
		</tr>
		<tr>		
			<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
			<td><input id="txtStoreno"  type="text" class="txt c2"/><input id="txtStore" type="text" class="txt c3"/></td> 
			<td><span> </span><a id='lblOrdeno' class="lbl btn"> </a></td>
			<td><input id="txtOrdeno" type="text"  style='width:75%;'/><input id="txtNo2" type="text"  style='width:25%;'/></td>
			<td><span> </span><a id='lblModel' class="lbl"> </a></td>
			<td><input id="txtModelno" type="text" class="txt c2"/><input id="txtModel" type="text" class="txt c3"/></td>
		</tr>
		<tr>
			<td><span> </span><a id='lblTimea' class="lbl"> </a></td>
			<td><input id="txtTimea" type="text"  class="txt c1"/></td>
			<td> </td>
			<td><!--<input type="button" id="btnWorkimport">--></td>
			<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
			<td><input id="txtWorker" type="text"  class="txt c1"/></td>
		<tr>
			<td><span> </span><a id='lblProductno' class="lbl btn"> </a></td>
			<td><input id="txtProductno" type="text"  class="txt c1"/></td>
			<td><span> </span><a id='lblProduct' class="lbl"> </a></td>
			<td colspan='3'><input id="txtProduct" type="text"  style="width: 99%;"/></td>
		</tr>
		<tr>
			<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
			<td colspan='5'><input id="txtMemo" type="text"  style="width: 99%;"/></td>
		</tr>
		</table>
		</div>
	
		<div class='dbbs'>
		<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
			<tr style='color:White; background:#003366;' >
				<td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
				<td align="center"><a id='lblProductnos'></a></td>
				<td align="center"><a id='lblProduct_s'></a></td>
				<td align="center"><a id='lblUnit'></a></td>
				<td align="center"><a id='lblMounts'></a></td>
				<td align="center"><a id='lblWeights'></a></td>
				<td align="center"><a id='lblTypes'></a></td>
				<td align="center"><a id='lblMechno'></a></td>
				<td align="center"><a id='lblMech'></a></td>
				<td align="center"><a id='lblMemos'></a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
				<td style="width:10%;">
					<input class="txt"  id="txtProductno.*" type="text" style="width:80%;" />
					<input class="btn"  id="btnProductno.*" type="button" value='.' style="width:10%;"  />
				</td>
				<td style="width:10%;">
					<input id="txtProduct.*" type="text" class="txt c1"/>
				</td>
				<td style="width:4%;">
					<input id="txtUnit.*" type="text" class="txt c1"/>
				</td>
				<td style="width:8%;">
					<input id="txtMount.*" type="text" class="txt c1" style="text-align:right"/>
				</td>
				<td style="width:8%;">
					<input id="txtWeight.*" type="text" class="txt c1" style="text-align:right"/>
				</td>
				<td style="width:10%;">
					<input id="txtTypea.*" type="text" class="txt c1"/>
				</td>
				<td style="width:10%;">
					<input class="txt" id="txtMechno.*" type="text" style="width:80%;" />
					<input class="btn"  id="btnMechno.*" type="button" value='.' style="width:10%;"  />
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
