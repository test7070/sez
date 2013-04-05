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

			q_desc = 1;
			q_tables = 's';
			var q_name = "fixin";
			var q_readonly = ['txtNoa', 'txtMoney', 'txtTotal', 'txtWorker'];
			var q_readonlys = [];
			var bbmNum = new Array(['txtDiscount', 10, 0], ['txtMoney', 10, 0], ['txtTax', 10, 0], ['txtTotal', 10, 0]);
			var bbsNum = new Array(['txtPrice', 10, 0], ['txtMount', 10, 0], ['txtMoney', 10, 0]);
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtNick', 'tgg_b.aspx'], 
			['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], 
			['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
			['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea,brand,unit,inprice', 'txtProductno_,txtProduct_,txtBrand_,txtUnit_,txtPrice_', 'fixucc_b.aspx'],
			['txtTireno_', ' ', 'tirestk', 'noa', 'txtTireno_', 'tireno_b.aspx']);

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

				mainForm(1);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtIndate', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('fixin.typea'));
				q_cmbParse("cmbTiretype", q_getPara('tire.typea'), 's');
				$('#txtTax').change(function() {
					sum();
				});
				$('#txtDiscount').change(function() {
					sum();
				});
				$('#lblOrdc').click(function() {
					lblOrdc();
				});
			}
			 function q_popPost(s1) {
                switch (s1) {
                    case 'txtTireno_':
                        $('#txtMemo_' + b_seq).focus();
                        break;
                }
            }
			function lblOrdc() {
				var t_tggno = trim($('#txtTggno').val());
				var t_ordeno = trim($('#txtOrdeno').val());
				var t_where = '';
				if (t_tggno.length > 0) {
					if (t_ordeno.length > 0)
						t_where = "enda='N' && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "") + "&& " + (t_ordeno.length > 0 ? q_sqlPara("noa", t_ordeno) : "") + "&& kind='2'";
					////  sql AND 語法，請用 &&
					else
						t_where = "enda='N' && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "") + "&& kind='2'";
					////  sql AND 語法，請用 &&
					t_where = t_where;
				} else {
					alert(q_getMsg('msgTggEmp'));
					return;
				}
				q_box('ordcs_b.aspx', 'ordcs;' + t_where, "95%", "650px", q_getMsg('popOrdc'));
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ordcs':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtOrdcno,txtNo2,txtPrice,txtMoney,txtMemo,txtMount', b_ret.length, b_ret, 'productno,product,unit,noa,no2,price,total,memo,mount', 'txtProductno,txtProduct');
							/// 最後 aEmpField 不可以有【數字欄位】
							bbsAssign();

							/*for (i = 0; i < ret.length; i++) {
							 k = ret[i];  ///ret[i]  儲存 tbbs 指標
							 if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
							 $('#txtMount_' + k).val(b_ret[i]['notv']);
							 $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
							 }
							 else {
							 $('#txtWeight_' + k).val(b_ret[i]['notv']);
							 $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv'], b_ret[i]['weight']));
							 }

							 }  /// for i*/
						}
						break;

					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}/// end Switch
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'tirestk':
						var as = _q_appendData("tirestk", "", true);
						if (as[0] != undefined) {
							if (q_cur == 2) {
								alert("該胎號已存在");
								$('#txtTireno_' + b_seq).val(bbs_tireno[b_seq]);
							} else if (q_cur == 1) {
								alert("該胎號已存在");
								$('#txtTireno_' + b_seq).focus();
							}
							tmp_tireno_modi1 = true;
						} else {
							tmp_tireno_modi1 = false;
						}
						break;
					case 'fixouts':
						var as = _q_appendData("fixouts", "", true);
						if (as[0] != undefined) {
							if (q_cur == 2) {
								alert("該胎號已領料");
								$('#txtTireno_' + b_seq).val(bbs_tireno[b_seq]);
							} else if (q_cur == 1) {
								alert("該胎號已領料");
								$('#txtTireno_' + b_seq).focus();
							}
							tmp_tireno_modi2 = true;
						} else {
							tmp_tireno_modi2 = false;
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			function btnOk() {
                if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            	}
                if (!q_cd($('#txtIndate').val())){
                	alert(q_getMsg('lblIndate')+'錯誤。');
                	return;
            	}
				$('#txtMon').val($.trim($('#txtMon').val()));
					if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
						alert(q_getMsg('lblMon')+'錯誤。');   
						return;
				}
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}

				for (var i = 0; i < q_bbsCount; i++) {
					for (var j = 0; j < q_bbsCount; j++) {
						if (i != j && $('#txtTireno_' + i).val() == $('#txtTireno_' + j).val() && $('#txtTireno_' + i).val() != '' && $('#txtTireno_' + j).val()) {
							alert('胎號重複，請修改');
							return;
						}
					}
				}

				$('#txtWorker').val(r_name)
				sum();

				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_fixin') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('fixin_s.aspx', q_name + '_s', "520px", "400px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
			}

			//儲存bbs的胎號
			var bbs_tireno = [];
			//儲存新增時的胎號
			var tmp_tireno = '';
			var tmp_tireno_modi1 = false;
			var tmp_tireno_modi2 = false;

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#lblNo_' + i).text(i + 1);
						//修改前先將bbs的胎號先儲存，來方便還原
						bbs_tireno[i] = $('#txtTireno_' + i).val();
						//判斷胎號是否已領料
						$('#txtTireno_' + i).change(function(e) {
							t_IdSeq = -1;
							/// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//表身胎號重複
							for (var j = 0; j < q_bbsCount; j++) {
								if ($('#txtTireno_' + b_seq).val() == $('#txtTireno_' + j).val() && !emp($('#txtTireno_' + j).val()) && b_seq != j) {
									alert('胎號重複!!');
									$('#txtTireno_' + b_seq).val('');
								}
							}
							//新增時儲存bbs的胎號，後面判斷是否有focus的問題
							if (!tmp_tireno_modi1 || tmp_tireno_modi2)
								tmp_tireno = $('#txtTireno_' + b_seq).val();
							if (!emp($('#txtTireno_' + b_seq).val())) {
								if (q_cur == 2 && !emp(bbs_tireno[b_seq])) {
									var t_where = "where=^^ tireno='" + bbs_tireno[b_seq] + "' ^^";
									q_gt('fixouts', t_where, 0, 0, 0, "", r_accy);
								} else if (q_cur == 1) {
									var t_where = "where=^^ tireno='" + $('#txtTireno_' + b_seq).val() + "' ^^";
									q_gt('fixouts', t_where, 0, 0, 0, "", r_accy);
								}
								var t_where2 = "where=^^ noa='" + $('#txtTireno_' + b_seq).val() + "' ^^";
								q_gt('tirestk', t_where2, 0, 0, 0, "", r_accy);
							}
						});

						$('#txtMount_' + i).change(function(e) {
							sum();
						});
						$('#txtPrice_' + i).change(function(e) {
							sum();
						});
						$('#txtMoney_' + i).change(function(e) {
							sum();
						});
						//$('#txtMemo_' + i).data('info', { index: i });
						$('#txtMemo_' + i).change(function(e) {
							if ($.trim($(this).val()).substring(0, 1) == '.')
								$('#txtMoney_' + i).removeAttr('readonly');
							else
								$('#txtMoney_' + i).attr('readonly', 'readonly');
							sum();
						});
						$('#txtMemo_' + i).change();
					}
				}
				_bbsAssign();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtMon').val(q_date().substring(0,6));
				$('#txtIndate').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtIndate').focus();
				sum();
			}

			function btnPrint() {
				q_box('z_fixinp.aspx', '', "95%", "650px", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				return true;
			}

			function q_popPost(t_id) {
				if ((q_cur == 1 || q_cur == 2) && t_id.substring(0, 13).toUpperCase() == 'TXTPRODUCTNO_') {
					sum();
				}
			}

			function sum() {
				if(!(q_cur==1 || q_cur==2))
					return;
				var t_mount, t_price, t_money = 0, t_tax, t_discount;
				for (var j = 0; j < q_bbsCount; j++) {
					t_mount = q_float('txtMount_'+j);
					t_price = q_float('txtPrice_'+j);
					$('#txtMoney_' + j).val(round(t_mount * t_price, 0));
					t_money += round(t_mount * t_price, 0);
				}
				t_tax = q_float('txtTax');
				t_discount = q_float('txtDiscount');
				$('#txtMoney').val(t_money);
				$('#txtTax').val(t_tax);
				$('#txtTotal').val(round(t_money + t_tax - t_discount, 0));
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				for (var i = 0; i < q_bbsCount; i++) {
					if ($.trim($('#txtMemo_' + i).val()).substring(0, 1) == '.')
						$('#txtMoney_' + i).removeAttr('readonly');
					else
						$('#txtMoney_' + i).attr('readonly', 'readonly');
				}
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
				tmp_tireno_modi1 = false;
				tmp_tireno_modi2 = false;
			}

			function checktireno(id) {
				//新增時儲存bbs的胎號，後面判斷是否有focus的問題
				if (tmp_tireno == $('#' + id).val() && tmp_tireno != '' && q_cur == 1 && (tmp_tireno_modi1 || tmp_tireno_modi2)) {
					alert("請修改胎號");
					$('#' + id).focus();
					return;
				}
			}
			function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 23%;
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
				width: 75%;
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
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 26%;
				float: left;
			}
			.txt.c3 {
				width: 70%;
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
			}

			.tbbs a {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			.bbs {
				float: left;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.tbbs .td1 {
				width: 9%;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewIndate'> </a></td>
						<td align="center" style="width:20%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='indate'>~indate</td>
						<td align="center" id='nick'>~nick</td>

					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="trZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblIndate" class="lbl"> </a></td>
						<td><input id="txtIndate"type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td><input id="txtDatea"type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMon" class="lbl" > </a></td>
						<td><input id="txtMon"type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td class='td6'><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td class="td7"><select id="cmbTypea" class="txt c1"></select></td>

					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblAcc1" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtAcc1" type="text" class="txt"  style="width:25%;"/>
						<input id="txtAcc2" type="text" class="txt" style="width:75%;"/>
						</td>
						<td class='td3'><span> </span><a id="lblInvono" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtInvono"type="text" class="txt c1"/>
						</td>
						
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtTggno" type="text" class="txt"  style="width:25%;"/>
						<input id="txtTgg" type="text" class="txt" style="width:75%;"/>
						<input id="txtNick" type="text" class="txt" style="display: none;"/>
						<td class="td5"><span> </span><a id='lblOrdc' class="lbl btn"></a></td><td class="td6">
						<input id="txtOrdcno"  type="text"  class="txt c1"/>
						</td></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtCno" type="text" class="txt" style="width:25%;"/>
						<input id="txtAcomp" type="text" class="txt" style="width:75%;"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtMoney" type="text" class="txt num c1" />
						</td>
						<td class="td3"><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtTax" type="text" class="txt num c1" />
						</td>
						<td class="td5"><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtDiscount" type="text" class="txt num c1" />
						</td>
						<td class="td7"><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td class="td8">
						<input id="txtTotal" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="5">
						<input id="txtMemo" type="text" class="txt c1" />
						</td>
						<td class="td7"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td8">
						<input id="txtWorker" type="text" class="txt c1" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'>
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:10%;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblBrand_s'> </a></td>
					<td align="center" style="width: 4%;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width: 7%;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width: 7%;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width: 7%;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width: 8%;"><a id='lblTireno_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblTiretype_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
					<input id="txtProductno.*" type="text" style="width: 75%;" />
					<input id="btnProductno.*" type="button" value=".." style="width: 15%;font-size: medium;"/>
					</td>
					<td >
					<input class="txt c1" id="txtProduct.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtBrand.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtUnit.*" type="text" />
					</td>
					<td >
					<input class="txt num c1" id="txtPrice.*" type="text" />
					</td>
					<td >
					<input class="txt num c1" id="txtMount.*" type="text" />
					</td>
					<td >
					<input class="txt num c1" id="txtMoney.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtTireno.*" type="text" onblur="checktireno(id);" />
					</td>
					<td >
					<input class="txt c1" id="txtMemo.*" type="text" />
					<input id="txtOrdcno.*" type="text" class="txt c3"/>
					<input id="txtNo2.*" type="text" class="txt c2"/>
					</td>
					<td ><select id="cmbTiretype.*" class="txt c1"></select></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
