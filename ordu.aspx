<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "ordu";
			var q_readonly = ['txtNoa','txtGweight', 'txtOweight', 'txtWeight','txtMweight'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			aPop = new Array(
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
				['txtCustno', 'lblCustno', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtTeamno', 'lblTeam', 'team', 'noa,team', '0txtTeamno,txtTeam', 'team_b.aspx']
				
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtMon', r_picm]];
				q_mask(bbmMask);
				bbmNum = [['txtWeight2', 10, q_getPara('vcc.weightPrecision'), 1],['txtMweight', 10, q_getPara('vcc.weightPrecision'), 1],['txtOweight', 10, q_getPara('vcc.weightPrecision'), 1],
									['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1],['txtGweight', 10, q_getPara('vcc.weightPrecision'), 1]];
				bbsNum = [['txtOweight', 10, q_getPara('vcc.weightPrecision'), 1],['txtWeight', 10, q_getPara('vcc.weightPrecision'), 1],['txtGweight', 10, q_getPara('vcc.weightPrecision'), 1],
									['txtEweight', 10, q_getPara('vcc.weightPrecision'), 1]];
				q_cmbParse("cmbStyle", q_getPara('adsss.stype'));
				
				$('#txtMon').blur(function() {
					if(q_cur==1 || emp($('#txtAdprono').val()))
						q_gt('adpro',"where=^^mon='"+$('#txtMon').val()+"' and  style='"+$('#cmbStyle').val()+"'^^", 0, 0, 0, "getAdprow");
				});
				
				$('#cmbStyle').change(function() {
					if(q_cur==1 || emp($('#txtAdprono').val()))
						q_gt('adpro',"where=^^mon='"+$('#txtMon').val()+"' and  style='"+$('#cmbStyle').val()+"'^^", 0, 0, 0, "getAdprow");
				});
				
				$('#txtWeight2').change(function() {
					if(adpro_total<(orduother_total+dec($('#txtWeight2').val()))){
						alert("組別合計"+(orduother_total+dec($('#txtWeight2').val()))+"MT 月總重"+adpro_total+"MT 已超出該月設定");
					}
				});
				
				$('#txtTeamno').change(function() {
					if(!emp($('#txtTeamno').val()))
						q_gt('ordu',"where=^^ style='"+$('#cmbStyle').val()+"' and noa !='"+$('#txtNoa').val()+"' and teamno='"+$('#txtTeamno').val()+"' ^^ stop=1", 0, 0, 0, "getOrdu_prev");
				});
				
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			var adprow,adpro_total=0;
			var orduotherw,ordusotherw,orduother_total=0;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'getOrdu_prev':
						var as=q_appendData("ordus", "", true);
						q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtOweight', as.length, as
							, 'productno,product,oweight'
							, 'txtProductno');
						
						break;
					case 'getOrdu_otherw':
						orduotherw=q_appendData("ordu", "", true);
						ordusotherw=q_appendData("ordus", "", true);
							for ( var i = 0; i < orduotherw.length; i++) {
								orduother_total=q_add(orduother_total,dec(orduotherw[i].weight2));
							}
						break;
					case 'getAdprow':
						adprow = _q_appendData("adpro", "", true);
						for ( var i = 0; i < adprow.length; i++) {
							adpro_total=q_add(adpro_total,dec(adprow[i].weight));
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				if(adpro_total<q_add(orduother_total,dec($('#txtWeight2').val()))){
					alert("組別合計"+q_add(orduother_total,dec($('#txtWeight2').val()))+"MT 月總重"+adpro_total+"MT 已超出該月設定!!");
					return;
				}
							
				if(dec($('#txtOweight').val())>dec($('#txtWeight2').val())){
					alert("設定重合計"+$('#txtOweight').val()+"MT 大於 組別重"+$('#txtWeight2').val()+"MT !!");
					return;
				}
				
				var isreturn=false;
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val())){
						var adprows=0;
						for ( var j = 0; j < adprow.length; j++) {
							if(adprow[j].productno==$('#txtProductno_'+i).val())
								adprows=q_add(adprows,dec(adprow[j].weight));
						}
						
						var ordusotherws=0;
						for ( var j = 0; j < ordusotherw.length; j++) {
							if(ordusotherw[j].productno==$('#txtProductno_'+i).val())
								ordusotherws=q_add(ordusotherws,dec(ordusotherw[j].oweight));
						}
						
						if(adprows<q_add(dec($('#txtOweight_'+i).val()),ordusotherws)){
							alert($('#txtProductno_'+i).val()+"該月設定上限"+adprows+"MT \n 其他組別已設定"+ordusotherws+"MT 尚可設定"+q_sub(adprows,ordusotherws)+"MT\n 本次設定"+$('#txtOweight_'+i).val()+"MT");
							isreturn=true;
							break;
						}
					}
				}
				
				if(isreturn)
					return;
				
				Lock();
				var t_date = $('#txtMon').val();
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ordu_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtMon').val(q_date().substring(0,6)).focus();
				q_gt('ordu',"where=^^mon='"+$('#txtMon').val()+"' and  style='"+$('#cmbStyle').val()+"' and noa !='"+$('#txtNoa').val()+"' ^^", 0, 0, 0, "getOrdu_otherw");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				q_gt('adpro',"where=^^mon='"+$('#txtMon').val()+"' and  style='"+$('#cmbStyle').val()+"'^^", 0, 0, 0, "getAdprow");
				q_gt('ordu',"where=^^mon='"+$('#txtMon').val()+"' and  style='"+$('#cmbStyle').val()+"' and noa !='"+$('#txtNoa').val()+"' ^^", 0, 0, 0, "getOrdu_otherw");
				$('#txtTeamno').focus();
			}

			function btnPrint() {

			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtOweight_' + i).change(function(e) {
							sum();
						});
						$('#txtWeight_' + i).change(function(e) {
							sum();
						});
						$('#txtGweight_' + i).change(function(e) {
							sum();
						});
					}
				}
				_bbsAssign();
			}

			function bbsSave(as) {
				t_err = '';
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				if (t_err) {
					alert(t_err)
					return false;
				}
				return true;
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
					
				var t_oweight = 0, t_weight = 0, t_gweight = 0;
				for (var i = 0; i < q_bbsCount; i++) {
					t_oweight = q_add(t_oweight,q_float('txtOweight_' + i));
					t_weight = q_add(t_weight,q_float('txtWeight_' + i));
					t_gweight = q_add(t_gweight,q_float('txtGweight_' + i));
				}
				
				$('#txtOweight').val(t_oweight);
				$('#txtWeight').val(t_weight);
				$('#txtGweight').val(t_gweight);
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
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 400px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
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
				width: 650px;
				/*margin: -1px;
				 border: 1px black solid;*/
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
				color: blue;
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
				width: 95%;
				float: left;
			}
			.txt.c2 {
				width: 25%;
				float: left;
			}
			.txt.c3 {
				width: 74%;
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
				font-size: medium;
				width: 100%;
			}
			.dbbs {
				width: 950px;
			}
			.tbbs a {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--因se2的adpro單號可重複，導致adprono會有問題以及抓取資料有問題，所以依月份與類別來抓資料-->
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:30%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:15%"><a id='vewMon'> </a></td>
						<td align="center" style="width:30%"><a id='vewComp'> </a></td>
						<td align="center" style="width:15%"><a id='vewStyle'> </a></td>
						<!--<td align="center" style="width:15%"><a id='vewAdprono'> </a></td>-->
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='mon'>~mon</td>
						<td align="center" id='comp'>~comp</td>
						<td align="center" id='style=adsss.stype'>~style=adsss.stype</td>
						<!--<td align="center" id='adprono'>~adprono</td>-->
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
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
						<td class="td1"><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td class="td2"><input id="txtMon" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblStyle' class="lbl"> </a></td>
						<td class="td4"><select id="cmbStyle" class="txt c1"> </select></td>
						<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td6"><input id="txtNoa" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTeam' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtTeamno" type="text" class="txt c1"/>
							<input id="txtTeam" type="hidden" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblWeight2' class="lbl"> </a></td>
						<td class="td4"><input id="txtWeight2" type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblMweight' class="lbl"> </a></td>
						<td class="td6"><input id="txtMweight" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtCustno" type="text" class="txt c2"/>
							<input id="txtComp" type="text" class="txt c3"/>
						</td>
						<!--<td class="td5"><span> </span><a id='lblAdprono' class="lbl"> </a></td>
						<td class="td6"><input id="txtAdprono" type="text" class="txt c1" /></td>-->
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblOweight' class="lbl"> </a></td>
						<td class="td2"><input id="txtOweight" type="text" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td class="td4"><input id="txtWeight" type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblGweight' class="lbl"> </a></td>
						<td class="td6"><input id="txtGweight" type="text" class="txt num c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width: 2%;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:10%;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:20%;"><a id='lblOweight_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblGweight_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblEweight_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td>
						<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtProductno.*" style="width:85%; float:left;"/>
						<input type="hidden" id="txtProduct.*" class="txt c1"/>
					</td>
					<td><input id="txtOweight.*" type="text" class="txt num c1"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
					<td><input id="txtGweight.*" type="text" class="txt num c1"/></td>
					<td><input id="txtEweight.*" type="text" class="txt num c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>