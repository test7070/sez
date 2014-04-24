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
			var q_name = "work";
			var decbbs = ['weight', 'uweight', 'mount', 'gmount', 'emount', 'hours'];
			var decbbm = ['mount', 'inmount', 'errmount', 'rmount', 'price', 'hours'];
			var q_readonly = ['txtNoa', 'txtComp', 'txtProduct', 'txtStation'];
			var q_readonlys = ['txtOrdeno', 'txtNo2', 'txtNoq', 'txtTproductno', 'txtTproduct'];
			var bbmNum = [['txtPrice', 10, 2, 1], ['txtWmount', 10, 0, 1]];
			var bbsNum = [
				['txtMount', 15, 2, 1], ['txtGmount', 15, 2, 1], ['txtEmount', 15, 2, 1],
				['txtCost', 15, 0, 1], ['txtPrice', 15, 0, 1]
			];
			var bbmMask = [];
			var bbsMask = [['txtCuadate', '999/99/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			q_desc = 1;
			brwCount2 = 7;
			aPop = new Array(
				['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx'],
				['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx'],
				['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
				['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
				['txtProcessno_', 'btnProcessno_', 'process', 'noa,process', 'txtProcessno_,txtProcess_', 'process_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				q_mask(bbmMask);
				mainForm(1);
				$('#txtKdate').focus();
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [
					['txtKdate', r_picd], ['txtWorkdate', r_picd], ['txtUindate', r_picd],
					['txtCuadate', r_picd], ['txtEnddate', r_picd]
				];
				q_mask(bbmMask);
				$('#txtProductno').change(function() {
					var t_where = "where=^^ noa ='" + $('#txtProductno').val() + "' ^^";
					q_gt('uca', t_where, 0, 0, 0, "", r_accy);
				});
				
				$('#btnUnfreeze').click(function() {
					if($('#chkIsfreeze').prop('checked')){
						q_func('qtxt.query','workunfreeze.txt,unfreeze,'+ encodeURI($('#txtNoa').val()));
						abbm[q_recno].isfreeze='false';
						$('#chkIsfreeze').prop('checked',false);
					}else
						alert('此製令無凍結!!');
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'td':
						ret = getb_ret();
						if (ret != undefined) {
							//1020629將替代品直接取代品名欄位不需要在寫入下面欄位
							$('#txtProductno_' + b_seq).val(ret[0].uccno)
							$('#txtProduct_' + b_seq).val(ret[0].product)
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'uca':
						var as = _q_appendData("ucas", "", true);
						if (as[0] != undefined) {
							q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount', as.length, as, 'productno,product,unit,mount', '');
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				t_err = ''
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				$('#txtWorker').val(r_name)
				sum();
				var t_date = $('#txtKdate').val();
				var s1 = $('#txt' + bbmKey[0][0].toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_work') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('work_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#lblNo_' + i).text(i + 1);
						$('#btnTproductno_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//t_where = "CHARINDEX(noa,(select td from uca a left join ucas b on a.noa=b.noa where a.noa='"+$('#txtProductno').val()+"' and b.productno='"+$('#txtProductno_'+b_seq).val()+"'))>0";
							t_where = "noa='" + $('#txtProductno_' + b_seq).val() + "'";
							q_box("ucctd_b2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'td', "95%", "650px", q_getMsg('popTd'));
						});
						$('#chkIstd_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if ($('#chkIstd_'+b_seq)[0].checked == true && (q_cur > 0 && q_cur < 3)) {
								$('#btnTproductno_' + b_seq).show();
							} else {
								$('#btnTproductno_' + b_seq).hide();
							}
						});
					}
				}
				_bbsAssign();
				for (var j = 0; j < q_bbsCount; j++) {
					if ($('#chkIstd_'+j)[0].checked == true && (q_cur > 0 && q_cur < 3)) {
						$('#btnTproductno_' + j).show();
					} else {
						$('#btnTproductno_' + j).hide();
					}
				}
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtKdate').val(q_date()).focus();
				$('#txtCuano').attr('disabled', 'disabled');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				for (var j = 0; j < q_bbsCount; j++) {
					if ($('#chkIstd_'+j)[0].checked == true && (q_cur > 0 && q_cur < 3)) {
						$('#btnTproductno_' + j).show();
					} else {
						$('#btnTproductno_' + j).hide();
					}
				}
				$('#txtProduct').focus();
			}

			function btnPrint() {
				q_box("z_workp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $.trim($('#txtNoa').val()) + ";" + r_accy, 'z_workp', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0][0].toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['ordeno'] = abbm2['ordeno'];
				as['no2'] = abbm2['no2'];
				as['tggno'] = abbm2['tggno'];
				return true;
			}

			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
				for (var j = 0; j < q_bbsCount; j++) {
				}
			}

			function refresh(recno) {
				_refresh(recno);
				for (var j = 0; j < q_bbsCount; j++) {
					$('#btnTproductno_' + j).hide();
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#btnUnfreeze').removeAttr('disabled');
				}else {
					$('#btnUnfreeze').attr('disabled', 'disabled');
				}
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}

			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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
			
			function q_funcPost(t_func, result) {
		        alert('凍結已取消!!');
		    } //endfunction
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 68%;
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
				/*width: 9%;*/
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
			.txt.c5 {
				width: 71%;
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
			.tbbm td input[type="button"] {
				float: left;
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.tbbs a {
				font-size: medium;
			}
			.tbbs a {
				font-size: medium;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
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
		<div id="dmain" style="width:1400px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left; width:400px;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewNoa'></a></td>
						<td align="center" style="width:20%"><a id='vewComp'></a></td>
						<td align="center" style="width:40%"><a id='vewProduct'></a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='comp,4'>~comp,4</td>
						<td align="center" id='productno product'>~productno ~product</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 1000px;float:left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr style="height:1px;">
						<td style="width:100px;"> </td>
						<td style="width:280px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:200px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:200px;"> </td>
						<td style="width:2px;"> </td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblCuadate" class="lbl"> </a></td>
						<td class="td4"><input id="txtCuadate" type="text" class="txt"/></td>
						<td class="td5"><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td class="td6"><input id="txtMount" type="text" class="txt num"/></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblKdate" class="lbl"> </a></td>
						<td class="td2">
							<input id="txtKdate" type="text" class="txt" style="width: 50%"/></br>
							<input id="chkEnda" type="checkbox" style="float: left;" />
							<span> </span><a id="lblEnda" class="lbl" style="float: left;"> </a>
							<input id="chkIsrework" type="checkbox" style="float: left;" />
							<span> </span><a id="lblIsrework" class="lbl" style="float: left;"> </a>
						</td>
						<td class="td3"><span> </span><a id="lblWorkdate" class="lbl"> </a></td>
						<td class="td4"><input id="txtWorkdate" type="text" class="txt"/></td>
						<td class="td5"><span> </span><a id="lblUnit" class="lbl"> </a></td>
						<td class="td6"><input id="txtUnit" type="text" class="txt"/></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblProductno" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtProductno" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblUindate" class="lbl"> </a></td>
						<td class="td4"><input id="txtUindate" type="text" class="txt"/></td>
						<td class="td5"><span> </span><a id="lblInmount" class="lbl"> </a></td>
						<td class="td6"><input id="txtInmount" type="text" class="txt num"/></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblProduct" class="lbl"> </a></td>
						<td class="td2"><input id="txtProduct" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblEnddate" class="lbl"> </a></td>
						<td class="td4"><input id="txtEnddate" type="text" class="txt"/></td>
						<td class="td5"><span> </span><a id="lblRmount" class="lbl"> </a></td>
						<td class="td6"><input id="txtRmount" type="text" class="txt num"/></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblStation" class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtStationno" type="text" class="txt" style="width: 50%"/>
							<input id="txtStation" type="text" class="txt" style="width: 50%"/>
						</td>
						<td class="td3"><span> </span><a id="lblRank" class="lbl"> </a></td>
						<td class="td4"><input id="txtRank" type="text" class="txt"/></td>
						<td class="td5"><span> </span><a id="lblWmount" class="lbl"> </a></td>
						<td class="td6"><input id="txtWmount" type="text" class="txt num"/></td>
						<!--<td class="td5"><span> </span><a id="lblErrmount" class="lbl"> </a></td>
						<td class="td6"><input id="txtErrmount" type="text" class="txt num"/></td>-->
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblTggno" class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtTggno" type="text" class="txt" style="width: 50%"/>
							<input id="txtComp" type="text" class="txt" style="width: 50%"/>
						</td>
						<td class="td3"><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td class="td4"><input id="txtPrice" type="text" class="txt num"/></td>
						<td class="td5"><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td class="td6">
							<input id="txtOrdeno" type="text" class="txt" style="width: 70%"/>
							<input id="txtNo2" type="text" class="txt" style="width: 20%"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblProcess" class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtProcessno" type="text" class="txt" style="width: 50%"/>
							<input id="txtProcess" type="text" class="txt" style="width: 50%"/>
						</td>
						<td class="td3"><span> </span><a id="lblModel" class="lbl"> </a></td>
						<td class="td4">
							<input id="txtModelno" type="text" class="txt" style="width: 45%"/>
							<input id="txtModel" type="text" class="txt" style="width: 45%"/>
						</td>
						<td class="td3"><span> </span><a id="lblStyle" class="lbl isStyle"> </a></td>
						<td class="td4"><input id="txtStyle" type="text" class="txt isStyle"/></td>
					</tr>
					<tr class="tr9">
						<!--<td class="td1"><span> </span><a id="lblWages" class="lbl"> </a></td>
						<td class="td2"><input id="txtWages" type="text" class="txt num"/></td>
						<td class="td3"><span> </span><a id="lblMakes" class="lbl"> </a></td>
						<td class="td4"><input id="txtMakes" type="text" class="txt num"/></td>-->
						<td class="td1"><span> </span><a id="lblHours" class="lbl"> </a></td>
						<td class="td2"><input id="txtHours" type="text" class="txt c1 num"/></td>
						<td class="td3"><span> </span><a id="lblIsfreeze" class="lbl"> </a></td>
						<td class="td4">
							<input id="chkIsfreeze" type="checkbox"/>
							<input id="btnUnfreeze" type="button" value="取消凍結" style="float: inherit;" />
						</td>
						<td class="td5"><span> </span><a id="lblCuano" class="lbl"> </a></td>
						<td class="td6">
							<input id="txtCuano" type="text" class="txt" style="width: 70%"/>
							<input id="txtCuanoq" type="text" class="txt" style="width: 20%"/>
						</td>
					</tr>
					<!--<tr class="tr8">
						<td class="td1"><span> </span><a id="lblWages_fee" class="lbl"> </a></td>
						<td class="td2"><input id="txtWages_fee" type="text" class="txt num"/></td>
						<td class="td3"><span> </span><a id="lblMakes_fee" class="lbl"> </a></td>
						<td class="td4"><input id="txtMakes_fee" type="text" class="txt num"/></td>
					</tr>-->
					<tr class="tr10">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan='5'>
							<input id="txtMemo" type="text" class="txt c1 "/>
							<input id="txtUno" type="text" class="txt" style="display: none;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1420px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a id='lblProcesss'> </a></td>
					<td align="center" style="width:180px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblStyles'> </a></td>
					<td align="center" style="width:80px;"><a id='lblCuadates'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMounts'> </a></td>
					<td align="center" style="width:100px;"><a id='lblGmount'> </a></td>
					<td align="center" style="width:100px;"><a id='lblEmount'> </a></td>
					<td align="center" style="width:40px;"><a id='lblTd'> </a></td>
					<!--<td align="center" style="width:17%;"><a id='lblTproduct_s'> </a></td>-->
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblCosts'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemos'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProcessno.*" type="text" class="txt c5"/>
						<input class="btn" id="btnProcessno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtProcess.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtProductno.*" type="text" class="txt" style="width: 75%;"/>
						<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtProduct.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtStyle.*" type="text" class="txt c1"/></td>
					<td><input id="txtCuadate.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGmount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtEmount.*" type="text" class="txt c1 num"/></td>
					<td align="center">
						<!--<input id="txtTd.*" type="text" class="txt c1"/>-->
						<input id="chkIstd.*" type="checkbox"/>
						<input class="btn" id="btnTproductno.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<!--<td>//1020629將替代品直接取代品名欄位不需要在寫入下面欄位
					<input id="txtTproductno.*" type="text" class="txt c1"/>
					<input id="txtTproduct.*" type="text" class="txt c1"/>
					</td>-->
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtCost.*" type="text" class="txt c1 num"/></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>