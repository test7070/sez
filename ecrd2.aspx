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
			var q_name = "ecrd2";
			var q_readonly = ['txtNoa', 'txtComp' ,'txtWorker', 'txtWorker2','txtProduct','txtPrice','txtUprice'];
			var q_readonlys = [];
			var bbmNum = [
				['txtPrice',10,2,1],['txtOweight',10,2,1],['txtOmoney',10,0,1],
				['txtUprice',10,2,1],['txtAweight',10,2,1],['txtAmoney',10,0,1],
				['txtWeight',10,2,1],['txtMoney',10,0,1],['txtCash',10,0,1],
				['txtLc',10,0,1]
			];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 20;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
				['txtCustno', 'lblCustno', 'cust', 'noa,comp,typea','txtCustno,txtComp,cmbTypea,txtStyle', 'cust_b.aspx'],
				['txtGrpno', 'lblGrpno', 'cust', 'noa,comp', 'txtGrpno,txtGrpname', 'cust_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('custtype', '', 0, 0, 0, "custtype");
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_mask(bbmMask);
				bbmMask = [['txtDatea',r_picd],['txtIndate',r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbStyle", q_getPara('adsss.stype'));
				
				$('#txtStyle').change(function() {
					$('#txtProduct').val($('#cmbStyle').find("option:selected").text());
					
					//Uprice,se2有問題 uccp
					
					var t_where = "where=^^ mon='"+$('#txtDatea').val().substr(0,6)+"' and datea<='"+$('#txtDatea').val().substr(0,6)+"' and productno='"+$('#txtProductno').val()+"'^^";
            		q_gt('adpro', t_where, 0, 0, 0, "findprice", r_accy);
				});
				
				$('#txtDatea').change(function() {
					var t_where = "where=^^ mon='"+$('#txtDatea').val().substr(0,6)+"' and datea<='"+$('#txtDatea').val().substr(0,6)+"' and productno='"+$('#txtProductno').val()+"'^^";
            		q_gt('adpro', t_where, 0, 0, 0, "findprice", r_accy);
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
					case 'findprice':
						var as = _q_appendData("adpro", "", true);
						if (as[0] != undefined) {
							$('#txtPrice').val(as[0].exreprice);
						}
						break;
					case 'custtype':
						var as = _q_appendData("custtype", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
							q_cmbParse("cmbTypea", t_item);
							if(abbm[q_recno])
								$("#cmbTypea").val(abbm[q_recno].typea);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ecrd2_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date()).focus();
				$('#txtIndate').val(q_cdn(q_date(),9));
				//預設
				$('#cmbStyle').val('2');
				$('#txtProduct').val($('#cmbStyle').find("option:selected").text());
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {

			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				Lock();
				if(q_cur==1){
					$('#txtWorker').val(r_name);
				}else{
					$('#txtWorker2').val(r_name);
				}
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ecrd2') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();
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
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 25%;
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
				width: 73%;
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
			input[type="text"], input[type="button"],select {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left; width:35%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:20%"><a id='vewDatea'></a></td>
						<td align="center" style="width:75%"><a id='vewComp'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp'>~comp</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 63%;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='5'>
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblGrpno' class="lbl btn"> </a></td>
						<td>
							<input id="txtGrpno" type="text" class="txt c1"/>
							<input id="txtGrpname" type="hidden" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan="3"><input id="txtComp" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblStyle' class="lbl"> </a></td>
						<td><select id='cmbStyle' class="txt c1"> </select></td>
						<td><span> </span><a id='lblProduct' class="lbl"> </a></td>
						<td>
							<input id="txtProduct" type="text" class="txt c1"/>
							<input id="txtProductno" type="hidden" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblOweight' class="lbl"> </a></td>
						<td><input id="txtOweight" type="text" class="txt num" style="width:90%"/><span>MT</span></td>
						<td><span> </span><a id='lblOmoney' class="lbl"> </a></td>
						<td><input id="txtOmoney" type="text" class="txt c1 num" style="width:90%"/><span>萬</span></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUprice' class="lbl"> </a></td>
						<td><input id="txtUprice" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblAweight' class="lbl"> </a></td>
						<td><input id="txtAweight" type="text" class="txt c1 num" style="width:90%"/><span>MT</span></td>
						<td><span> </span><a id='lblAmoney' class="lbl"> </a></td>
						<td><input id="txtAmoney" type="text" class="txt c1 num" style="width:90%"/><span>萬</span></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num" style="width:90%"/><span>MT</span></td>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt c1 num" style="width:90%"/><span>萬</span></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCash' class="lbl"> </a></td>
						<td><input id="txtCash" type="text" class="txt c1 num" style="width:90%"/><span>天</span></td>
						<td><span> </span><a id='lblLc' class="lbl"> </a></td>
						<td><input id="txtLc" type="text" class="txt c1 num" style="width:90%"/><span>天</span></td>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>