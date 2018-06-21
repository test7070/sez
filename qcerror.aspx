<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_tables = 's';
			var q_name = "cut";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [['txtTheory',10,3,1],['txtHweight',10,3,1],['txtWeight',10,3,1],['txtDivide',10,0,1]
				,['txtSprice',10,3,1],['txtWprice',10,3,1],['txtDime',10,3,1],['txtWidth',10,3,1],['txtLengthb',10,3,1],['txtMweight',10,3,1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'],
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'], 
				['txtProductno', 'lblProduct', 'ucaucc', 'noa,product,unit,spec', 'txtProductno,txtProduct', 'ucaucc_b.aspx'],
				['txtMechno', 'lblMechx', 'sss', 'noa,namea', 'txtMechno,txtMech', 'sss_b.aspx']
			);
			q_desc = 1;
			brwCount2 = 19;
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('style', '', 0, 0, 0, '');
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picd],['txtGtime', r_picd],['txtType2', r_picd]];
				bbsMask = [];
				q_mask(bbmMask);
				document.title = '品質異常報告';
			}

			function q_boxClose(s2) {///   q_boxClose 2/4

			}

			function q_popPost(s1) {
			
			}
			
			function bbsClear() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#btnMinus_' + i).click();
				}
			}

			function q_gtPost(t_name) {

			}
            
            function q_funcPost(t_func, result) {

  			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				var s1 = xmlString.split(';');
				q_func('qtxt.query.updatecuts', 'cut.txt,updatecuts,'+$('#txtNoa').val());
				Unlock(1);
			}
			
			function btnOk() {
				Lock(1, {
					opacity : 0
				});
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
			var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
			if (s1.length == 0 || s1 == "AUTO")
				q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + $('#txtDatea').val(), '/', ''));
			else
				wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					q_cmbParse("combStyle_"+j, ',全檢,修整,退回,特採,降級使用,報廢,其它');
					$('#lblNo_' + j).text(j + 1);
				
				$('#combStyle_' + j).change(function() {
					t_IdSeq = -1;
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					if(q_cur==1 || q_cur==2)
						$('#txtStyle_'+b_seq).val($('#combStyle_'+b_seq).find("option:selected").text());
				});
			}	
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
						q_box("z_qcad.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'cut', "95%", "95%", m_print);
				}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['mount'] ) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				return true;
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
			.dview {
				float: left;
				width: 350px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 1000px;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: larger;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 10%;
			}
			.tbbm .tdZ {
				width: 1%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: black;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 95%;
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
			}
			.dbbs {
				width: 950px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1500px;">
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a>日期</a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewProduct'> </a></td>
						<td align="center" style="width:100px; color:black;"><a>檢測人員</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='product'>~product</td>
						<td align="center" id='mech'>~mech</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt" style="width:120px;"/></td>
						<td><span> </span><a id="lblDateaa" class="lbl" >登錄日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1" style="width:120px;"/></td>
					</tr>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdenoo" class="lbl">採購/工令號</a></td>
						<td><input id="txtOrdeno" type="text" class="txt" style="width:120px;"/></td>
						<td><span> </span><a class="lbl">回覆日期</a></td>
						<td><input id="txtMon" type="text" class="txt" style="width:120px;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn" > </a></td>
						<td>
							<input id="txtCustno" type="text" style="float:left;width:30%;"/>
							<input id="txtCust" type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblenda" class="lbl">結案日期</a></td>
						<td><input id="txtGtime" type="text" class="txt" style="width:120px;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTggg" class="lbl btn">廠商</a></td>
						<td><input id="txtTggno" type="text" class="txt c1" style="float:left;width:30%;"/>
							   <input id="txtTgg" type="text"  class="txt c1" style="float:left;width:70%;"/>
					   </td>
					   	<td><span> </span><a class="lbl">收文單位</a></td>
						<td><input id="txtTypea" type="text" class="txt" style="width:120px;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl btn"> </a></td>
						<td>
							<input id="txtProductno" type="text" style="float:left;width:40%;"/>
							<input id="txtProduct" type="text" style="float:left;width:60%;"/>
						</td>
						<td><span> </span><a id="lblMount" class="lbl">數量</a></td>
						<td><input id="txtMount" type="text"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblKindd" class="lbl">型號</a></td>
						<td><input id="txtKind" type="text"/></td>
						<td><span> </span><a id="lblGmountx" class="lbl">抽驗數</a></td>
						<td><input id="txtGmount" type="text"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSpec" class="lbl"> </a></td>
						<td><input id="txtSpec" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMechx" class="lbl btn">檢測人員</a></td>
						<td>
						<input id="txtMechno" type="text"  style="float:left;width:40%;"/>
						<input id="txtMech" type="text"  style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo1" class="lbl" >異常內容說明</a></td>
						<td>
							<textarea id='txtStore' row=4 class="txt c1" style="height:100px;"></textarea>
						<td><span> </span><a id="lblMemo2" class="lbl" >要求標準</a></td>
						<td>
							<textarea id='txtComp' row=4 class="txt c1" style="height:100px;"></textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo3" class="lbl" >允收範圍</a></td>
						<td>
							<textarea id='txtClass' row=4 class="txt c1" style="height:100px;"></textarea>
						<td><span> </span><a id="lblMemo4" class="lbl" >處理方式</a></td>
						<td>
							<textarea id='txtMemo' row=4 class="txt c1" style="height:100px;"></textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo5" class="lbl" >矯正及預防措施</a></td>
						<td>
							<textarea id='txtCardeal' row=4 class="txt c1" style="width: 99%;height:100px;"></textarea>
						</td>
						<td><span> </span><a id="lblMemo4" class="lbl" >績效確認</a></td>
						<td>
							<textarea id='txtStoreno' row=4 class="txt c1" style="height:100px;"></textarea>
						</td>
					</tr>
					<tr>
							<td colspan="3">
								<span> </span><a class='lbl'>確認日期</a>
							</td>
							<td>
								<input id="txtType2" type="text" style="width: 45%"/>
							</tr>
						</tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td style="width:150px;" align="center"><a>判定</a></td>
					<td align="center" style="width:120px;"><a>數量</a></td>
					<td align="center" style="width:300px;"><a>處理費用</a></td>
					<td align="center" style="width:300px;"><a>費用分攤</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
                        <input type="text" id="txtStyle.*" type="text" class="txt c1" style="width: 80%;"/>
                        <select id="combStyle.*" class="txt" style="width: 17px;"> </select>
                    </td>
					<td><input id="txtMount.*" type="text" style="width:95%;" /></td>
					<td>
						<a>人工</a>
                        <input type="text" id='txtDime.*' style="width: 15%;"/>
						<a>材料</a>
                        <input type="text" id='txtWidth.*' style="width: 15%;"/>
						<a>效率差異</a>
                        <input type="text" id='txtLengthb.*' style="width: 15%;"/>
						<a>運輸</a>
                        <input type="text" id='txtDivide.*' style="width: 15%;"/>
						<a>其他</a>
                        <input type="text" id='txtTheory.*' style="width: 15%;"/>
                    </td>
					<td>
						<a>公司</a>
						<input type="text" type="text" id='txtHweight.*' style="width: 15%;"/>
						<a>廠商</a>
						<input type="text" type="text" id='txtMweight.*'  style="width: 15%;"/>
						<a>單位主管</a>
						<input type="text" type="text" id='txtWeight.*'  style="width: 15%;"/>
						<a>作業人員</a>
						<input type="text" type="text" id='txtWprice.*'  style="width: 15%;"/>
                    </td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>