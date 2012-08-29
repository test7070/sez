<%@ Page Language="C#" AutoEventWireup="true" %>
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

			var q_name = "trans";
			var q_readonly = ['txtNoa', 'txtTotal', 'txtTotal2', 'txtTrdno', 'txtTreno', 'txtWorkerno', 'txtWorker'];
			var bbmNum = new Array(['txtUnpack', 10, 0], ['txtInmount', 10, 3], ['txtPrice', 10, 3], ['txtPrice2', 10, 3], ['txtPrice3', 10, 3], ['txtDiscount', 10, 3], ['txtMiles', 10, 2], ['txtWeight', 10, 3], ['txtOutmount', 10, 3], ['txtTotal', 10, 0], ['txtOverw', 10, 0], ['txtTotal2', 10, 0], ['txtCommission', 10, 0], ['txtGps', 10, 0], ['txtPton', 10, 3], ['txtPton2', 10, 3], ['txtOverh', 10, 0], ['txtOverw', 10, 0]);
			var bbmMask = new Array(['txtTrandate', '999/99/99'], ['txtDatea', '999/99/99'], ['txtBilldate', '999/99/99'], ['txtCldate', '999/99/99'], ['txtLtime', '99:99'], ['txtStime', '99:99'], ['txtDtime', '99:99']);
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//  q_alias = 'a';
			q_desc = 1;
			aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver,cardealno,cardeal', 'txtCarno,txtDriverno,txtDriver,txtCardealno,txtCardeal', 'car2_b.aspx'], ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx'], ['txtStraddrno', 'lblStraddr', 'addr', 'noa,addr,productno,product,custprice,driverprice,driverprice2,commission', 'txtStraddrno,txtStraddr,txtUccno,txtProduct,txtPrice,txtPrice2,txtPrice3,txtCommission', 'addr_b.aspx'], ['txtAddno3', 'lblAdd3', 'addr', 'noa,addr', 'txtAddno3,txtAdd3', 'addr_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtCaseuseno', 'lblCaseuse', 'cust', 'noa,comp', 'txtCaseuseno,txtCaseuse', 'cust_b.aspx']);

			var t_height = 25;
			$(document).ready(function() {
				$('#dview').css('width', '1%');
				$('#dbbm').css('width', '98%');

				var tmp = $('tr.m').height();
				$('tr.m').height(t_height);
				t_height = tmp;

				bbmKey = ['noa'];

				$("#cmbCalctype").data('info', {
					item : new Array()
				});
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

				$('#btnSwitch').click(function() {
					if ($('#dview').css('display') == 'none') {
						$('#dview').css('width', '100%');
						$('#dview').css('display', '');
						$('#dbbm').css('width', '0%');
					} else {
						$('#dview').css('width', '0%');
						$('#dview').css('display', 'none');
						$('#dbbm').css('width', '100%');
					}
				});
			});

			function currentData() {
			}


			currentData.prototype = {
				data : [],
				exclude : ['txtNoa', 'txtNoq', 'txtWorker', 'txtTrdno', 'txtTreno', 'txtPton', 'txtPton2', 'txtGross', 'txtWeight', 'txtLtime', 'txtStime', 'txtDtime', 'txtBmiles', 'txtEmiles', 'txtMiles'],
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
				},
				isOutside : function() {
					var t_noa = $("#cmbCalctype").val();
					var t_isOutside = 0;
					for (var i in $("#cmbCalctype").data('info').item) {
						if ($("#cmbCalctype").data('info').item[i].noa == t_noa) {
							t_isOutside = $("#cmbCalctype").data('info').item[i].isOutside;
							break;
						}
					}
					return t_isOutside;
				},
				chgDiscount : function() {
					var t_noa = $("#cmbCalctype").val();
					var t_isOutside = 0;
					for (var i in $("#cmbCalctype").data('info').item) {
						if ($("#cmbCalctype").data('info').item[i].noa == t_noa) {
							if (!$("#cmbCalctype").data('info').item[i].isOutside)
								$('#txtDiscount').val($("#cmbCalctype").data('info').item[i].discount);
							break;
						}
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
				$('#dview').css('width', '0%');
				$('#dview').css('display', 'none');
				$('#dbbm').css('width', '100%');
				$('tr.m').height(t_height);
			}

			function mainPost() {
				$('#btnIns').val($('#btnIns').val() + "(F8)");
				$('#btnOk').val($('#btnOk').val() + "(F9)");
				q_mask(bbmMask);

				$('input[type="text"]').focus(function() {
					$(this).addClass('focus_b');
				}).blur(function() {
					$(this).removeClass('focus_b');
				});

				q_gt('calctype2', '', 0, 0, 0, "calctypes");
				q_gt('carteam', '', 0, 0, 0, "");
				q_cmbParse("cmbCasetype", "20'',40''");
				$("#cmbCalctype").change(function() {
					if (curData.isOutside()) {
						$("#lblPrice2").hide();
						$("#txtPrice2").hide();
						$("#lblPrice3").show();
						$("#txtPrice3").show();
					} else {
						$("#lblPrice3").hide();
						$("#txtPrice3").hide();
						$("#lblPrice2").show();
						$("#txtPrice2").show();
						curData.chgDiscount();
					}
					sum();
				}).click(function() {
					if (curData.isOutside()) {
						$("#lblPrice2").hide();
						$("#txtPrice2").hide();
						$("#lblPrice3").show();
						$("#txtPrice3").show();
					} else {
						$("#lblPrice3").hide();
						$("#txtPrice3").hide();
						$("#lblPrice2").show();
						$("#txtPrice2").show();
						curData.chgDiscount();
					}
					sum();
				});
				$("#cmbCalctype").focus(function() {
					var len = $("#cmbCalctype").children().length > 0 ? $("#cmbCalctype").children().length : 1;
					$("#cmbCalctype").attr('size', len + "");
				}).blur(function() {
					$("#cmbCalctype").attr('size', '1');
				});
				$("#cmbCarteamno").focus(function() {
					var len = $("#cmbCarteamno").children().length > 0 ? $("#cmbCarteamno").children().length : 1;
					$("#cmbCarteamno").attr('size', len + "");
				}).blur(function() {
					$("#cmbCarteamno").attr('size', '1');
				});
				$("#cmbCasetype").focus(function() {
					var len = $("#cmbCasetype").children().length > 0 ? $("#cmbCasetype").children().length : 1;
					$("#cmbCasetype").attr('size', len + "");
				}).blur(function() {
					$("#cmbCasetype").attr('size', '1');
				});

				$('#txtBmiles').change(function() {
					var bmiles = $.trim($('#txtBmiles').val()).length == 0 ? 0 : parseInt($.trim($('#txtBmiles').val()), 10);
					var emiles = $.trim($('#txtEmiles').val()).length == 0 ? 0 : parseInt($.trim($('#txtEmiles').val()), 10);
					if (bmiles == 0 && emiles == 0) {
						$('#txtMiles').removeAttr('readonly');
					} else {
						$('#txtMiles').attr('readonly', 'readonly');
					}
					sum();
				});
				$('#txtEmiles').change(function() {
					var bmiles = $.trim($('#txtBmiles').val()).length == 0 ? 0 : parseInt($.trim($('#txtBmiles').val()), 10);
					var emiles = $.trim($('#txtEmiles').val()).length == 0 ? 0 : parseInt($.trim($('#txtEmiles').val()), 10);
					if (bmiles == 0 && emiles == 0) {
						$('#txtMiles').removeAttr('readonly');
					} else {
						$('#txtMiles').attr('readonly', 'readonly');
					}
					sum();
				});
				$("#txtInmount").change(function() {
					if ($('#txtTreno').val().length == 0)
						q_tr('txtOutmount', q_float('txtInmount'), 3);
					sum();
				});
				$("#txtPton").change(function() {
					sum();
				});
				$("#txtPrice").change(function() {
					sum();
				});
				$("#txtOutmount").change(function() {
					sum();
				});
				$("#txtPton2").change(function() {
					sum();
				});
				$("#txtPrice2").change(function() {
					sum();
				});
				$("#txtPrice3").change(function() {
					sum();
				});
				$("#txtDiscount").change(function() {
					sum();
				});
				$("#txtCustno").change(function() {
					if ($("#txtCustno").val().length > 0) {
						$("#txtStraddrno").val($("#txtCustno").val());
						$("#txtStraddr").val("");
					}
				});

			}

			function sum() {
				if ($('#txtDiscount').val().length == 0) {
					$('#txtDiscount').val('1');
				}
				var t_mount = $.trim($('#txtInmount').val()).length == 0 ? 0 : parseFloat($.trim($('#txtInmount').val().replace(/,/g, '')), 10);
				t_mount = t_mount + ($.trim($('#txtPton').val()).length == 0 ? 0 : parseFloat($.trim($('#txtPton').val().replace(/,/g, '')), 10));
				$('#txtMount').val(t_mount);
				var t_price = $.trim($('#txtPrice').val()).length == 0 ? 0 : parseFloat($.trim($('#txtPrice').val().replace(/,/g, '')), 10);
				$("#txtTotal").val(Math.round(t_mount * t_price, 0));

				var t_discount = $.trim($('#txtDiscount').val()).length == 0 ? 0 : parseFloat($.trim($('#txtDiscount').val().replace(/,/g, '')), 10);
				t_mount = $.trim($('#txtOutmount').val()).length == 0 ? 0 : parseFloat($.trim($('#txtOutmount').val().replace(/,/g, '')), 10);
				t_mount = t_mount + ($.trim($('#txtPton2').val()).length == 0 ? 0 : parseFloat($.trim($('#txtPton2').val().replace(/,/g, '')), 10));
				$('#txtMount2').val(t_mount);
				if (curData.isOutside())
					t_price = $.trim($('#txtPrice3').val()).length == 0 ? 0 : parseFloat($.trim($('#txtPrice3').val().replace(/,/g, '')), 10);
				else
					t_price = $.trim($('#txtPrice2').val()).length == 0 ? 0 : parseFloat($.trim($('#txtPrice2').val().replace(/,/g, '')), 10);
				$("#txtTotal2").val(Math.round(t_mount * t_price * t_discount, 0));

				var bmiles = $.trim($('#txtBmiles').val()).length == 0 ? 0 : parseInt($.trim($('#txtBmiles').val().replace(/,/g, '')), 10);
				var emiles = $.trim($('#txtEmiles').val()).length == 0 ? 0 : parseInt($.trim($('#txtEmiles').val().replace(/,/g, '')), 10);
				if (bmiles != 0 && emiles != 0)
					$('#txtMiles').val(emiles - bmiles);
			}

			function txtCopy(dest, source) {
				var adest = dest.split(',');
				var asource = source.split(',');
				$('#' + adest[0]).focus(function() {
					if (trim($(this).val()).length == 0)
						$(this).val(q_getMsg('msgCopy'));
				});
				$('#' + adest[0]).focusout(function() {
					var t_copy = ($(this).val().substr(0, 1) == '=');
					var t_clear = ($(this).val().substr(0, 2) == ' =');
					for (var i = 0; i < adest.length; i++) { {
							if (t_copy)
								$('#' + adest[i]).val($('#' + asource[i]).val());

							if (t_clear)
								$('#' + adest[i]).val('');
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
					case 'calctypes':
						var as = _q_appendData("calctypes", "", true);
						var t_item = "";
						var item = new Array();
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
							item.push({
								noa : as[i].noa + as[i].noq,
								typea : as[i].typea,
								discount : as[i].discount,
								isOutside : as[i].isoutside.length == 0 ? false : (as[i].isoutside == "false" || as[i].isoutside == "0" || as[i].isoutside == "undefined" ? false : true)
							});
						}
						q_cmbParse("cmbCalctype", t_item);
						$("#cmbCalctype").val(abbm[q_recno].calctype);
						$("#cmbCalctype").data("info").item = item;
						if (curData.isOutside()) {
							$("#lblPrice2").hide();
							$("#txtPrice2").hide();
							$("#lblPrice3").show();
							$("#txtPrice3").show();
						} else {
							$("#lblPrice3").hide();
							$("#txtPrice3").hide();
							$("#lblPrice2").show();
							$("#txtPrice2").show();
						}
						break;
					case 'carteam':
						var as = _q_appendData("carteam", "", true);
						var t_item = "";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						q_cmbParse("cmbCarteamno", t_item);
						$("#cmbCarteamno").val(abbm[q_recno].carteamno);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();

						if (q_cur == 1 || q_cur == 2)
							q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('trans_s.aspx', q_name + '_s', "550px", "500px", q_getMsg("popSeek"));
				$('#dview').css('width', '100%');
				$('#dview').css('display', '');
				$('#dbbm').css('width', '0%');
			}

			function btnIns() {
				curData.copy();
				_btnIns();
				curData.paste();
				$('#txtNoa').val('AUTO');
				$('#txtNoq').val('001');
				if ($('#txtDatea').val().length == 0)
					$('#txtDatea').val(q_date());
				sum();
				$('#dview').css('width', '0%');
				$('#dview').css('display', 'none');
				$('#dbbm').css('width', '100%');
				$('#txtDatea').focus();

			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				sum();
				$('#dview').css('width', '0%');
				$('#dview').css('display', 'none');
				$('#dbbm').css('width', '100%');

				$('#txtDatea').focus();

			}

			function btnPrint() {
				q_box('z_trans.aspx' + "?;;;;" + r_accy, '', "800px", "600px", q_getMsg("popPrint"));
			}

			function btnOk() {
				var t_custno = $.trim($('#txtCustno').val());
				var t_addrno = $.trim($('#txtStraddrno').val());
				if (t_custno.length > 0 && t_addrno.length > 0) {
					t_addrno = t_addrno.substring(0, t_custno.length);
					if (t_addrno != t_custno) {
						alert('addr error!');
						return;
					}
				}

				$('#txtWorker').val(r_name);
				if (curData.isOutside())
					$("#txtPrice2").val(0);
				else
					$("#txtPrice3").val(0);
				sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
				$('#dview').css('width', '0%');
				$('#dview').css('display', 'none');
				$('#dbbm').css('width', '100%');
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);

				if (curData.isOutside()) {
					$("#lblPrice2").hide();
					$("#txtPrice2").hide();
					$("#lblPrice3").show();
					$("#txtPrice3").show();
				} else {
					$("#lblPrice3").hide();
					$("#txtPrice3").hide();
					$("#lblPrice2").show();
					$("#txtPrice2").show();
				}

				var treno = $('#txtTreno').val();
				var trdno = $('#txtTrdno').val();
				if (treno.length == 0 && trdno.length == 0) {
					if (q_cur != 1 && q_cur != 2) {
						$('#btnDele').remove('disabled');
					}
				} else
					$('#btnDele').attr('disabled', 'disabled');
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				var bmiles = $.trim($('#txtBmiles').val()).length == 0 ? 0 : parseInt($.trim($('#txtBmiles').val()), 10);
				var emiles = $.trim($('#txtEmiles').val()).length == 0 ? 0 : parseInt($.trim($('#txtEmiles').val()), 10);
				if (bmiles == 0 && emiles == 0) {
					$('#txtMiles').removeAttr('readonly');
				} else {
					$('#txtMiles').attr('readonly', 'readonly');
				}
				var treno = $('#txtTreno').val();
				if (treno.length > 0) {
					$('#txtOutmount').attr('readonly', 'readonly');
					$('#txtPton2').attr('readonly', 'readonly');
					$('#txtMount2').attr('readonly', 'readonly');
					$('#txtPrice2').attr('readonly', 'readonly');
					$('#txtPrice3').attr('readonly', 'readonly');
					$('#txtDiscount').attr('readonly', 'readonly');
					$('#cmbCalctype').attr('disabled', 'disabled');

					$('#txtDriverno').attr('readonly', 'readonly');
					$('#txtDriver').attr('readonly', 'readonly');
					$('#txtCarno').attr('readonly', 'readonly');

					$('#lblCarno').attr('id', 'lblCarno_zzzz');
					$('#lblDriver').attr('id', 'lblDriverno_zzzz');
				} else {
					$('#cmbCalctype').remove('disabled');
					$('#lblCarno_zzzz').attr('id', 'lblCarno');
					$('#lblDriver_zzzz').attr('id', 'lblDriverno');
				}
				var trdno = $('#txtTrdno').val();
				if (trdno.length > 0) {
					$('#txtInmount').attr('readonly', 'readonly');
					$('#txtPton').attr('readonly', 'readonly');
					$('#txtMount').attr('readonly', 'readonly');
					$('#txtPrice').attr('readonly', 'readonly');

					$('#txtCustno').attr('readonly', 'readonly');
					$('#txtComp').attr('readonly', 'readonly');
					$('#txtStraddrno').attr('readonly', 'readonly');
					$('#txtStraddr').attr('readonly', 'readonly');

					$('#lblCust').attr('id', 'lblCust_zzzz');
					$('#lblStraddr').attr('id', 'lblStraddr_zzzz');
				} else {
					$('#lblCust_zzzz').attr('id', 'lblCust');
					$('#lblStraddr_zzzz').attr('id', 'lblStraddr');
				}

				if (treno.length > 0 || trdno.length > 0) {
					$('#txtDatea').attr('disabled', 'disabled');
					$('#txtTrandate').attr('disabled', 'disabled');
				} else {
					$('#txtDatea').remove('disabled');
					$('#txtTrandate').remove('disabled');
				}
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
				$('#dview').css('width', '0%');
				$('#dview').css('display', 'none');
				$('#dbbm').css('width', '100%');
			}

			function q_popFunc(id, key_value) {
				/*switch(id) {
				 case 'txtStraddrno':
				 alert($('#txtStraddrno').data('price3'));

				 break;
				 }*/
			}

		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				overflow: hidden;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: 16px;
				/*background-color: #FFFF66;*/
				background-color: #cad3ff;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px white solid;
				color: blue;
			}
			.tview .th1 td {
				color: black;
				font-weight: bold;
			}
			.dbbm {
				float: left;
				margin: -1px;
				border: 1px black solid;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				/*border: 1px white double;
				 border-spacing: 0;
				 border-collapse: collapse;*/
				font-size: 16px;
				color: blue;
				background: #cad3ff;
				width: 100%;
				overflow: hidden;
			}
			.tbbm tr {
				height: 30px;
			}
			.tbbm td {
				width: 5%;
			}
			.tbbm .tdZ {
				width: 2%;
			}
			td .schema {
				display: block;
				width: 95%;
				height: 0px;
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
				font-size: 16px;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.tbbm tr td .txt.c1 {
				width: 100%;
				float: left;
			}
			.tbbm tr td .txt.c2 {
				width: 45%;
				float: left;
			}
			.tbbm tr td .txt.c3 {
				width: 55%;
				float: left;
			}
			.tbbm tr td .txt.c4 {
				width: 60%;
				float: left;
			}
			.tbbm tr td .txt.c5 {
				width: 40%;
				float: left;
			}
			.tbbm tr td .txt.num {
				text-align: right;
			}

			.txt.num {
				text-align: right;
			}
			td {
				margin: 0px -1px;
				padding: 0;
			}
			td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			input[readonly="readonly"]#txtMiles {
				color: green;
			}
			.focus_b {
				border-width: 3px;
				border-color: #FF7F24;
				border-style: double;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<input type="button" id="btnSwitch" value="切換"/>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr class="th1">
						<td align="center" style="width:30px;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px"><a id='vewNoa'> </a></td>
						<td align="center" style="width:100px;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px;"><a id='vewComp'> </a></td>
						<td align="center" style="width:100px;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:100px;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:100px;"><a id='vewAddr'> </a></td>
						<td align="center" style="width:100px;"><a id='vewInmount'> </a></td>
						<td align="center" style="width:100px;"><a id='vewPrice'> </a></td>
						<td align="center" style="width:100px;"><a id='vewOutmount'> </a></td>
						<td align="center" style="width:100px;"><a id='vewPrice2'> </a></td>
						<td align="center" style="width:100px;"><a id='vewPrice3'> </a></td>
						<td align="center" style="width:100px;"><a id='vewDiscount'> </a></td>
						<td align="center" style="width:100px;"><a id='vewPo'> </a></td>
						<td align="center" style="width:100px;"><a id='vewCaseno'> </a></td>
						<td align="center" style="width:100px;"><a id='vewCustorde'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp,2'>~comp,2</td>
						<td align="center" id='driver'>~driver</td>
						<td align="center" id='carno'>~carno</td>
						<td align="center" id='straddrno'>~straddrno</td>
						<td align="center" id='inmount'>~inmount</td>
						<td align="center" id='price'>~price</td>
						<td align="center" id='outmount'>~outmount</td>
						<td align="center" id='price2'>~price2</td>
						<td align="center" id='price3'>~price3</td>
						<td align="center" id='discount'>~discount</td>
						<td align="center" id='po'>~po</td>
						<td align="center" id='caseno'>~caseno</td>
						<td align="center" id='custorde'>~custorde</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' id='dbbm'>
				<table class="tbbm"  id="tbbm" >
					<tr name="schema" style="height:0px;">
						<td class="td1"><span class="schema"> </span></td>
						<td class="td2"><span class="schema"> </span></td>
						<td class="td3"><span class="schema"> </span></td>
						<td class="td4"><span class="schema"> </span></td>
						<td class="td5"><span class="schema"> </span></td>
						<td class="td6"><span class="schema"> </span></td>
						<td class="td7"><span class="schema"> </span></td>
						<td class="td8"><span class="schema"> </span></td>
						<td class="td9"><span class="schema"> </span></td>
						<td class="tdA"><span class="schema"> </span></td>
						<td class="tdB"><span class="schema"> </span></td>
						<td class="tdC"><span class="schema"> </span></td>
						<td class="tdD"><span class="schema"> </span></td>
						<td class="tdE"><span class="schema"> </span></td>
						<td class="tdF"><span class="schema"> </span></td>
						<td class="tdG"><span class="schema"> </span></td>
						<td class="tdZ"><span class="schema"> </span></td>
					</tr>
					<tr class="tr1 m">
						<td class="td1" colspan="2"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtTrandate" type="text"  class="txt c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtCarno" type="text"  class="txt c1"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtDriverno" type="text"  class="txt c2"/>
						<input id="txtDriver" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr2 m">
						<td class="td1" colspan="2"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td class="td3" colspan="6">
						<input id="txtCustno" type="text"  style='width:25%; float:left;'/>
						<input id="txtComp" type="text"  style='width:75%; float:left;'/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblCalctype" class="lbl"> </a></td>
						<td class="tdB" colspan="2"><select id="cmbCalctype" class="txt c1"></select></td>
						<td class="tdD" colspan="2"><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td class="tdF" colspan="2"><select id="cmbCarteamno" class="txt c1"></select></td>
					</tr>
					<tr class="tr3 m">
						<td class="td1" colspan="2"><span> </span><a id="lblStraddr" class="lbl btn"> </a></td>
						<td class="td3" colspan="6">
						<input id="txtStraddrno" type="text"  class="txt c2"/>
						<input id="txtStraddr" type="text"  class="txt c3"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblUcc" class="lbl btn"> </a></td>
						<td class="tdB" colspan="4">
						<input id="txtUccno" type="text"  class="txt c2"/>
						<input id="txtProduct" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr4 m">
						<td class="td1" colspan="2"><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtInmount" type="text"  class="txt num c1"/>
						<input id="txtMount" type="text" style="display:none;"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtPrice" type="text"  class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtTotal" type="text"  class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblCommission" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtCommission" type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr5 m">
						<td class="td1" colspan="2"><span> </span><a id="lblMount2" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtOutmount" type="text"  class="txt num c1"/>
						<input id="txtMount2" type="text" style="display:none;"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblPrice2" class="lbl"> </a><a id="lblPrice3" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtPrice2" type="text"  class="txt num c1"/>
						<input id="txtPrice3" type="text"  class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtDiscount" type="text" class="txt num c1"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblTotal2" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtTotal2" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr6 m">
						<td class="td1" colspan="2"><span> </span><a id="lblPton" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtPton" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblPton2" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtPton2" type="text"  class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblGross" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtGross" type="text"  class="txt num c1"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtWeight" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr7 m">
						<td class="td1" colspan="2"><span> </span><a id="lblCaseno" class="lbl"> </a></td>
						<td class="td3" colspan="6">
						<input id="txtCaseno" type="text"  style='width:50%; float:left;'/>
						<input id="txtCaseno2" type="text"  style='width:50%; float:left;'/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblCaseuse" class="lbl"> </a></td>
						<td class="tdB">
						<input id="txtCaseuseno" type="text" class="txt c1"/>
						</td>
						<td class="tdB" colspan="2">
						<input id="txtCaseuse" type="text" class="txt c1"/>
						</td>
						<td class="tdD"><span> </span><a id="lblCasetype" class="lbl"> </a></td>
						<td class="tdF" colspan="2"><select id="cmbCasetype" class="txt c1"></select></td>
					</tr>
					<tr class="tr8 m">
						<td class="td1" colspan="2"><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td class="td3" colspan="4">
						<input id="txtPo" type="text"  class="txt c1"/>
						</td>
						<td class="td7" colspan="2"><span> </span><a id="lblCustorde" class="lbl"> </a></td>
						<td class="td9" colspan="3">
						<input id="txtCustorde" type="text"  class="txt c1"/>
						</td>
						<td class="tdC" colspan="2"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="tdE" colspan="3">
						<input id="txtNoa" type="text"  class="txt c1"/>
						<input id="txtNoq" type="text"  style="display: none;"/>
						</td>
					</tr>
					<tr class="tr9 m">
						<td class="td1" colspan="2"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtSalesno" type="text"  class="txt c2"/>
						<input id="txtSales" type="text"  class="txt c3"/>
						</td>
						<td class="td1" colspan="2"><span> </span><a id="lblBmiles" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtBmiles" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblEmiles" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtEmiles" type="text"  class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblMiles" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtMiles" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="trA m">
						<td class="td1" colspan="2"><span> </span><a id="lblLtime" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtLtime" type="text"  class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblStime" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtStime" type="text"  class="txt c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblDtime" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtDtime" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="trB m">
						<td class="td1" colspan="2"><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td class="td3" colspan="5">
						<input id="txtCardealno" type="text"  style='width:25%; float:left;'/>
						<input id="txtCardeal" type="text"  style='width:75%; float:left;'/>
						</td>
						<td class="td8" colspan="2"><span> </span><a id="lblAdd3" class="lbl btn"> </a></td>
						<td class="tdA" colspan="3">
						<input id="txtAddno3" type="text" class="txt c2"/>
						<input id="txtAdd3" type="text"  class="txt c3"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblGps" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtGps" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="trC m">

						<td class="td5" colspan="2"><span> </span><a id="lblThird" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtThird" type="text" class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblThirdprice" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtThirdprice" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr class="trD m">
						<td class="td1" colspan="2"><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtOrdeno" type="text"  class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblSo" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtSo" type="text"  class="txt c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblTraceno" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtTraceno" type="text"  class="txt c1"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblUnpack" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtUnpack" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="trE m">
						<td class="td1" colspan="2"><span> </span><a id="lblCldate" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtCldate" type="text" class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblBilldate" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtBilldate" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="trF m">
						<td class="td1" colspan="2"><span> </span><a id="lblFill" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtFill" type="text"  class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblCaseend" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtCaseend" type="text" class="txt c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblStatus" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtStatus" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="trG m">
						<td class="td1" colspan="2"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="14">
						<input id="txtMemo" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="trH m">
						<td class="td1" colspan="2"><span> </span><a id="lblOverw" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtOverw" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblOverh" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtOverh" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="trI m">
						<td class="td1" colspan="2"><span> </span><a id="lblTrdno" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtTrdno" type="text" class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblTreno" class="lbl" style="font-size: 12px;"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtTreno" type="text"  class="txt c1"/>
						</td>
						<td class="td9" colspan="4"></td>
						<td class="tdD" colspan="2"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtWorker" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="trJ m">
						<td class="td1" colspan="2"><span> </span><a id="lblBoat" class="lbl "> </a></td>
						<td class="td3" colspan="2">
						<input id="txtBoat" type="text" class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblBoatname" class="lbl"></a></td>
						<td class="td7" colspan="2">
						<input id="txtBoatname" type="text"  class="txt c1"/>
						</td>
						<td class="tdB" colspan="2"><span> </span><a id="lblShip" class="lbl"> </a></td>
						<td class="tdD" colspan="2">
						<input id="txtShip" type="text"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
