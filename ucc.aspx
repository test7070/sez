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

			var decbbm = ['inprice', 'saleprice', 'reserve', 'beginmount', 'uweight', 'beginmoney', 'drcr', 'price2', 'days', 'stkmount', 'safemount', 'stkmoney'];
			var q_name = "ucc";
			var q_readonly = ['txtWorker','txtDate2','textUccprice', 'textStk', 'textSaleprice', 'textInprice', 'textCosta', 'textOrdemount', 'textPlanmount', 'textIntmount', 'textAvaistk'];
			var bbmNum = [
				['txtSaleprice', 10, 2, 1], ['txtInprice', 10, 2, 1], ['txtStdmount', 10, 2, 1],
				['txtUweight', 15, 3, 1],['txtSafemount', 15, 2, 1],['txtDays', 10, 0, 1]
			];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'uno';
			aPop = new Array(['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);

			$(document).ready(function() {
				bbmKey = ['uno'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
				$('#txtUno').focus();

			});
			function currentData() {
			}


			currentData.prototype = {
				data : [],
				exclude : [],
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in curData.exclude) {
							if (fbbm[i] == curData.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				$('#txtUno').focus();
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtCdate', r_picd]];
				q_mask(bbmMask);
				if (q_getPara('sys.comp').indexOf('英特瑞') > -1)
					q_cmbParse("cmbTypea", q_getPara('ucc.typea_it'));//IR
				else
					q_cmbParse("cmbTypea", q_getPara('ucc.typea')+(q_getPara('sys.comp').indexOf('安美得') > -1?',null@其他':''));

				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_gt('uccga', '', 0, 0, 0, "");
				$('#btnUcctd').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("ucctd_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucctd', "680px", "650px", q_getMsg('btnUcctd'));
				});
				$('#btnTgg').click(function() {
					t_where = "productno='" + $('#txtNoa').val() + "'";
					q_box("ucctgg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucctgg', "95%", "95%", q_getMsg('btnTgg'));
				});
				$('#btnCust').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("ucccust.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucccust', "95%", "95%", q_getMsg('btnCust'));
				});
				$('#btnStkcost').mousedown(function(e) {
					if (e.button == 0) {
						$('#div_stkcost').css('top', e.pageY);
						$('#div_stkcost').css('left', e.pageX - $('#div_stkcost').width());
						$('#div_stkcost').toggle();
					}
				});
				$('#txtUno').change(function(){
					var thisVal = $.trim($(this).val());
					if(thisVal.length > 0){
						var t_where = "where=^^ noa='" + thisVal + "' ^^";
						Lock();
						q_gt('ucaucc', t_where, 0, 0, 0, "checkNoa", r_accy);
					}
				});
				$('#btnClose_div_stkcost').click(function() {
					$('#div_stkcost').toggle();
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///	q_boxClose 3/4
						break;
				}	/// end Switch
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'checkNoa':
						var as = _q_appendData("ucaucc", "", true);
						if (as[0] != undefined) {
							alert('物品編號重複!!');
							$('#txtUno').val('').focus();
						}
						Unlock();
						break;
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						if (as[0] != undefined) {
							var t_item = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
							q_cmbParse("cmbGroupano", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupano").val(abbm[q_recno].groupano);
							}
						}
						break;
					case 'uccgb':
						//中類
						var as = _q_appendData("uccgb", "", true);
						if (as[0] != undefined) {
							var t_item = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
							q_cmbParse("cmbGroupbno", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupbno").val(abbm[q_recno].groupbno);
							}
						}
						break;
					case 'uccgc':
						//小類
						var as = _q_appendData("uccgc", "", true);
						if (as[0] != undefined) {
							var t_item = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
							q_cmbParse("cmbGroupcno", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupcno").val(abbm[q_recno].groupcno);
							}
						}
						break;
					case 'workg_orde':
						var t_ordemount = 0, t_planmount = 0, t_intmount = 0;
						var as = _q_appendData("view_ordes", "", true);
						if (as[0] != undefined) {
							t_ordemount = dec(as[0].ordemount);
							t_planmount = dec(as[0].planmount);
							t_intmount = dec(as[0].inmount) + dec(as[0].purmount);
						}
						$('#textOrdemount').val(t_ordemount);
						//訂單
						$('#textPlanmount').val(t_planmount);
						//計畫
						$('#textIntmount').val(t_intmount);
						//在途
						//可用庫存=庫存+在途-訂單(+計畫??)
						$('#textAvaistk').val(q_float('textStk') + q_float('textIntmount') - q_float('textOrdemount'));
						break;
					case 'ucc_rc2':
						var as = _q_appendData("rc2s", "", true);
						$('#textInprice').val(0);
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtNoa').val())
									$('#textInprice').val(dec(as[i].price));
							}
						}
						break;
					case 'ucc_vcc':
						var as = _q_appendData("vccs", "", true);
						$('#textSaleprice').val(0);
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtNoa').val())
									$('#textSaleprice').val(dec(as[i].price));
							}
						}
						break;
					case 'ucc_price':
						var as = _q_appendData("costs", "", true);
						if (as[0] != undefined) {
							$('#textCosta').val(as[0].price);
						} else {
							$('#textCosta').val(0);
						}
						break;
					case 'ucc_stk':
						var as = _q_appendData("stkucc", "", true);
						var stkmount = 0;
						for (var i = 0; i < as.length; i++) {
							stkmount = stkmount + dec(as[i].mount);
						}
						$('#textStk').val(stkmount);
						$('#textAvaistk').val(q_float('textStk') + q_float('textIntmount') - q_float('textOrdemount'));
						break;
					case 'ucc_acomp_stk':
						var as = _q_appendData("acomp", "", true);
						var storeno = '';
						for (var i = 0; i < as.length; i++) {
							storeno = storeno + ',' + as[i].noa;
						}
						storeno = storeno.substr(1, storeno.length);
						var t_where = "where=^^ ['" + q_date() + "','" + storeno + "','') where productno='" + $('#txtNoa').val() + "' ^^";
						q_gt('calstk', t_where, 0, 0, 0, "ucc_stk", r_accy);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}	/// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('ucc_s.aspx', q_name + '_s', "500px", "410px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
				var cmb = document.getElementById("combPay");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPay').val(cmb.value);
				cmb.value = '';
			}

			function btnIns() {
				if ($('#Copy').is(':checked')) {
					curData.copy();
				}
				_btnIns();
				if ($('#Copy').is(':checked')) {
					curData.paste();
				}
				$('#txtUno').focus();
			}

			function btnModi() {
				if (emp($('#txtUno').val()))
					return;

				_btnModi();
				$('#txtComp').focus();
			}

			function btnPrint() {

			}

			function btnOk() {
				var t_err = '';

				t_err = q_chkEmpField([['txtUno', q_getMsg('lblUno')], ['txtComp', q_getMsg('lblComp')]]);
				$('#txtDate2').val(q_date());
				$('#txtWorker').val(r_name);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				var t_uno = trim($('#txtUno').val());
				$('#txtNoa').val(t_uno);

				if (t_uno.length == 0)
					q_gtnoa(q_name, t_uno);
				else
					wrServer(t_uno);
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
				//抓原物料單價
				var t_where = "where=^^ productno ='" + $('#txtNoa').val() + "' order by mon desc ^^";
				q_gt('costs', t_where, 0, 0, 0, "ucc_price", r_accy);
				//庫存
				if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1) {
					var t_where = "where=^^ 1=1 ^^";
					q_gt('acomp', t_where, 0, 0, 0, "ucc_acomp_stk", r_accy);
				} else {
					var t_where = "where=^^ ['" + q_date() + "','','') where productno='" + $('#txtNoa').val() + "' ^^";
					q_gt('calstk', t_where, 0, 0, 0, "ucc_stk", r_accy);
				}
				//最新出貨單價
				//var t_where = "where=^^ noa in (select noa from vccs"+r_accy+" where productno='"+$('#txtNoa').val()+"' and price>0 ) ^^ stop=1";
				//q_gt('vcc', t_where , 0, 0, 0, "ucc_vcc", r_accy);
				//最新進貨單價
				//var t_where = "where=^^ noa in (select noa from rc2s"+r_accy+" where productno='"+$('#txtNoa').val()+"' and price>0 ) ^^ stop=1";
				//q_gt('rc2', t_where , 0, 0, 0, "ucc_rc2", r_accy);

				//訂單、在途量、計畫
				var t_where = "where=^^ ['" + q_date() + "','','') where productno=a.productno ^^";
				var t_where1 = "where[1]=^^a.productno='" + $('#txtNoa').val() + "' and a.enda!='1' group by productno,style ^^";
				var t_where2 = "where[2]=^^1=0^^";
				var t_where3 = "where[3]=^^ d.stype='4' and c.productno=a.productno and c.enda!='1' ^^";
				var t_where4 = "where[4]=^^ 1=0 ^^";
				var t_where5 = "where[5]=^^ 1=0 ^^"
				var t_where6 = "where[6]=^^ 1=0 ^^"
				q_gt('workg_orde', t_where + t_where1 + t_where2 + t_where3 + t_where4+t_where5+t_where6, 0, 0, 0, "", r_accy);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
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
			.tview {
				FONT-SIZE: 12pt;
				COLOR: Blue;
				background: #FFCC00;
				padding: 3px;
				TEXT-ALIGN: center;
			}
			.tbbm {
				FONT-SIZE: 12pt;
				COLOR: blue;
				TEXT-ALIGN: left;
				border-color: white;
				width: 98%;
				border-collapse: collapse;
				background: #cad3ff;
			}
			.txt.c1 {
				width: 98%;
			}
			.txt.c2 {
				width: 95%;
			}
			.txt.c3 {
				width: 70%;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
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
			}
			.num {
				text-align: right;
			}
			.lbl{
				float: right;
				font-size: medium;
			}
			.tbbm tr td {
				width: 10%;
			}
			.tbbm tr {
				height: 35px;
			}
		</style>
	</head>
	<body>
		<div id="div_stkcost" style="position:absolute; top:300px; left:500px; display:none; width:300px; background-color: #ffffff; ">
			<table id="table_stkcost"  class="table_row" style="width:100%;" border="1" cellpadding='1'  cellspacing='0'>
				<tr>
					<td align="center" width="50%"><a class="lbl">原物料成本</a></td>
					<td align="center" width="50%"><input id="textCosta" type="text"  class="txt num c1"/></td>
				</tr>
				<tr>
					<td align="center" ><a class="lbl">訂單數量</a></td>
					<td align="center" ><input id="textOrdemount" type="text"  class="txt num c1"/></td>
				</tr>
				<tr>
					<td align="center" ><a class="lbl">計畫生產</a></td>
					<td align="center" ><input id="textPlanmount" type="text"  class="txt num c1"/></td>
				</tr>
				<tr>
					<td align="center" ><a class="lbl">在途量</a></td>
					<td align="center" ><input id="textIntmount" type="text"  class="txt num c1"/></td>
				</tr>
				<tr>
					<td align="center" ><a class="lbl">庫存量</a></td>
					<td align="center" ><input id="textStk" type="text"  class="txt num c1"/></td>
				</tr>
				<tr>
					<td align="center" ><a class="lbl">可用庫存</a></td>
					<td align="center" ><input id="textAvaistk" type="text"  class="txt num c1"/></td>
				</tr>
				<tr>
					<td align="center" colspan='2'>
						<input id="btnClose_div_stkcost" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div class="dview" id="dview" style="float: left;	width:32%;"	>
			<table class="tview" id="tview"	border="1" cellpadding='2'	cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:2%"><a id='vewChk'> </a></td>
					<td align="center" style="width:15%"><a id='vewUno'> </a></td>
					<td align="center" style="width:25%"><a id='vewProduct'> </a></td>
				</tr>
				<tr>
					<td><input id="chkBrow.*" type="checkbox" style=''/></td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='product'>~product</td>
				</tr>
			</table>
		</div>
		<div class='dbbm' style="width: 68%;float: left;">
			<table class="tbbm"	id="tbbm"	border="0" cellpadding='2'	cellspacing='0'>
				<tr>
					<td><a id='lblUno' class="lbl"> </a></td>
					<td colspan="5">
						<input type="text" id="txtUno" class="txt c3"/>
						<input type="text" id="txtNoa" style="display:none;"/>
						<div style="float:left;">
							<input id="Copy" type="checkbox" />
							<span> </span><a id="lblCopy"></a>
						</div>
					</td>
				</tr>
				<tr> 
					<td><a id='lblProduct' class="lbl"> </a></td>
					<td colspan='5'><input	type="text" id="txtProduct" class="txt c1"/></td>
					<td><input type="button" id="btnUcctd" style='width: auto; font-size: medium;' ></td>
				</tr>
				<tr>
					<td><a id='lblEngpro' class="lbl"> </a></td>
					<td colspan='5' ><input	type="text" id="txtEngpro" class="txt c1"/></td>
				</tr>
				<tr>
					<td><a id='lblSpec' class="lbl"> </a></td>
					<td colspan='5'><input	type="text" id="txtSpec"	class="txt c1"/></td>
					<td><input id="btnCust" type="button" style='width: auto; font-size: medium;'/></td>
				</tr>
				<tr>
					<td><a id='lblTggno' class="lbl btn"> </a></td>
					<td><input id="txtTggno" type="text" class="txt c1"/></td>
					<td colspan='4'><input id="txtTgg"	type="text" style="width: 97%;"/></td>
					<td><input id="btnTgg" type="button" style='width: auto; font-size: medium;'/></td>
				</tr>
				<tr>
					<td><a id='lblUnit' class="lbl"> </a></td>
					<td><input	type="text" id="txtUnit" class="txt c1"/></td>
					<td><a id='lblUweight' class="lbl"> </a></td>
					<td><input	type="text" id="txtUweight"	class="txt num c1"/></td>
					<td><a id='lblStdmount' class="lbl"> </a></td>
					<td><input	type="text" id="txtStdmount" class="txt num c1"/></td>
				</tr>
				<tr>
					<td><a id='lblType' class="lbl"> </a></td>
					<td><select id="cmbTypea" class="txt c1"> </select></td>
					<td><a id='lblSafemount' class="lbl"> </a></td>
					<td><input	type="text" id="txtSafemount" class="txt num c1"/></td>
					<td><a id='lblDays' class="lbl"> </a></td>
					<td><input	type="text" id="txtDays" class="txt c1 num"/></td>
				</tr>
				<tr>
					<td><a id='lblStyle' class="lbl"> </a></td>
					<td><input	type="text" id="txtStyle" class="txt c1"/></td>
					<td><a id='lblInprice' class="lbl"> </a></td>
					<td><input	type="text" id="txtInprice" class="txt num c1"/></td>
					<td><a id='lblSaleprice' class="lbl"> </a></td>
					<td><input	type="text" id="txtSaleprice"	class="txt num c1"/></td>
					<td class="td5"><input id="btnStkcost" type="button"  /></td>
				</tr>
				<tr>
					<td><a id='lblCoin' class="lbl"> </a></td>
					<td><select id="cmbCoin" class="txt c1"> </select></td>
					<td><a id='lblArea' class="lbl"> </a></td>
					<td><input	type="text" id="txtArea"	class="txt c1"/></td>
					<td><a id='lblTrantype' class="lbl"> </a></td>
					<td><select id="cmbTrantype" class="txt c1"></select></td>
				</tr>
				<tr>
					<td><a id='lblCdate' class="lbl"> </a></td>
					<td><input	type="text" id="txtCdate"	class="txt c1"/></td>
				</tr>
				<tr>
					<td><a id='lblGroupano' class="lbl"> </a></td>
					<td colspan="2"><select id="cmbGroupano" class="txt c1"></select></td>
					<td><a id='lblGroupbno' class="lbl"> </a></td>
					<td colspan="2"><select id="cmbGroupbno" class="txt c1"></select></td>
				</tr>
				<tr>
					<td><a id='lblGroupcno' class="lbl"> </a></td>
					<td colspan="2"><select id="cmbGroupcno" class="txt c1"> </select></td>
					<td></td>
					<td><a id='lblDate2' class="lbl"> </a></td>
					<td><input type="text" id="txtDate2" class="txt c1"/></td>
				</tr>
				<tr>
					<td><a id='lblRc2acc' class="lbl"> </a></td>
					<td><input	type="text" id="txtRc2acc" class="txt c1"/></td>
					<td><a id='lblVccacc' class="lbl"> </a></td>
					<td><input	type="text" id="txtVccacc" class="txt c1"/></td>
					<td><a id='lblWorker' class="lbl"> </a></td>
					<td><input id="txtWorker" type="text" class="txt c1" style='text-align:center;'/></td>
				</tr>
				<tr>
					<td><a id='lblMemo' class="lbl"> </a></td>
					<td colspan='5'> <input type="text" id="txtMemo" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>