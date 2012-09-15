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

			isEditTotal = false;
			q_tables = 's';
			var q_name = "trd";
			var q_readonly = ['txtNoa', 'txtDatea', 'txtMoney', 'txtTotal', 'txtWorker', 'txtMount', 'txtStraddr', 'txtEndaddr', 'txtPlusmoney', 'txtMinusmoney'];
			var q_readonlys = ['txtOrdeno', 'txtTranno', 'txtTrannoq'];
			var bbmNum = [['txtMoney', 10, 0], ['txtTaxrate', 10, 1], ['txtTax', 10, 0], ['txtTotal', 10, 0], ['txtDiscount', 10, 0], ['txtMount', 10, 3], ['txtPlus', 10, 0], ['txtPlusmoney', 10, 0], ['txtMinusmoney', 10, 0]];
			var bbsNum = [['txtTranmoney', 10, 0], ['txtOverweightcost', 10, 0], ['txtOthercost', 10, 0], ['txtmount', 10, 3], ['txtPrice', 10, 3]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			q_desc = 1;
			aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'], 
			['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx'], ['txtStraddrno', 'lblStraddr', 'addr', 'noa,addr', 'txtStraddrno,txtStraddr', 'addr_b2.aspx'], ['txtEndaddrno', '', 'addr', 'noa,addr', 'txtEndaddrno,txtEndaddr', 'addr_b2.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtWorker', 'lblWorker', 'sss', 'noa,namea', 'txtWorkerno,txtWorker', 'sss_b.aspx'], ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], ['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']);
			
			function trd() {}
			trd.prototype = {
				isLoadCustchgno: false,
				custchgno : new  Array(),
				isLoadVccano : false,
				vccano : new Array()
			}
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
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
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtBtrandate', r_picd], ['txtEtrandate', r_picd], ['txtVccadate', r_picd]];
				q_mask(bbmMask);

				q_cmbParse("cmbTrtype", q_getPara('trd.trtype'));
				q_cmbParse("cmbTypea", q_getPara('sys.yn'));
				q_cmbParse("cmbTovcca", q_getPara('sys.yn'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

				$('#lblAccno').parent().click(function(e) {
					q_box("accc.aspx?" + $('#txtAccno').val() + "'", 'accc', "850px", "600px", q_getMsg("popAccc"));
				});

				$('#cmbTrtype').focus(function() {
					var len = $("#cmbTrtype").children().length > 0 ? $("#cmbTrtype").children().length : 1;
					$("#cmbTrtype").attr('size', len + "");
				}).blur(function() {
					$("#cmbTrtype").attr('size', '1');
				});
				$('#cmbTypea').focus(function() {
					var len = $("#cmbTypea").children().length > 0 ? $("#cmbTypea").children().length : 1;
					$("#cmbTypea").attr('size', len + "");
				}).blur(function() {
					$("#cmbTypea").attr('size', '1');
				});
				$('#cmbTovcca').focus(function() {
					var len = $("#cmbTovcca").children().length > 0 ? $("#cmbTovcca").children().length : 1;
					$("#cmbTovcca").attr('size', len + "");
				}).blur(function() {
					$("#cmbTovcca").attr('size', '1');
				});
				$('#cmbTaxtype').change(function(e) {
					sum();
				}).focus(function() {
					var len = $("#cmbTaxtype").children().length > 0 ? $("#cmbTaxtype").children().length : 1;
					$("#cmbTaxtype").attr('size', len + "");
				}).blur(function() {
					$("#cmbTaxtype").attr('size', '1');
					sum();
				});
				$('#txtTaxrate').change(function(e) {
					sum();
				});
				$('#txtTax').change(function(e) {
					sum();
				});
				$('#txtDiscount').change(function(e) {
					sum();
				});
				$('#txtPlus').change(function(e) {
					sum();
				});
				$('#txtPlusmoney').change(function(e) {
					sum();
				});
				$('#txtMinusmoney').change(function(e) {
					sum();
				});
				$('#btnTrans').click(function(e) {
					if (q_cur == 1 || q_cur == 2) {
						if ($.trim($('#txtCustno').val()) == 0) {
							alert('請輸入客戶');
							return false;
						}
						var t_noa = "'" + $.trim($('#txtOrdeno').val()) + "'";
						var t_ordeno = "'" + $.trim($('#txtOrdeno').val()) + "'";
						var t_curno = "'" + $.trim($('#txtNoa').val()) + "'";
						var t_custno = "'" + $.trim($('#txtCustno').val()) + "'";
						var t_bdate = "'" + $.trim($('#txtBdate').val()) + "'";
						var t_edate = $.trim($('#txtEdate').val());
						t_edate = t_edate.length == 0 ? "char(255)" : "'" + t_edate + "'";
						var t_btrandate = "'" + $.trim($('#txtBtrandate').val()) + "'";
						var t_etrandate = $.trim($('#txtEtrandate').val());
						t_etrandate = t_etrandate.length == 0 ? "char(255)" : "'" + t_etrandate + "'";
						var t_bodate = "'" + $.trim($('#txtBodate').val()) + "'";
						var t_eodate = $.trim($('#txtEodate').val());
						t_eodate = t_eodate.length == 0 ? "char(255)" : "'" + t_eodate + "'";
						var t_straddrno = "'" + $.trim($('#txtStraddrno').val()) + "'";
						var t_endaddrno = $.trim($('#txtEndaddrno').val());
						t_endaddrno = t_endaddrno.length == 0 ? "char(255)" : "'" + t_endaddrno + "'";

						var t_tranordeno = "'" + $.trim($('#txtOrdeno').val()) + "'";
						var t_po = "'" + $.trim($('#txtPo').val()) + "'";

						t_where = "where=^^(custno=" + t_custno + ") and (isnull(trandate,'') between " + t_btrandate + " and " + t_etrandate + ") and (isnull(datea,'') between " + t_bdate + " and " + t_edate + " ) ";
						t_where += " and ( len(isnull(trdno,''))=0  or  trdno=" + t_noa + ")";

						t_where += " and (straddrno  between " + t_straddrno + " and " + t_endaddrno + ")";
						if (!(t_po == "''"))
							t_where += " and (trans" + r_accy + ".po=" + t_po + ")";
						if (!(t_bodate == "''" && t_eodate == "char(255)" && t_ordeno == "''"))
							t_where += "and exists(select * from tranorde" + r_accy + " where noa=trans" + r_accy + ".ordeno and (odate between " + t_bodate + " and " + t_eodate + "))";
						// t_where += " not exists(select * from trds" + r_accy + " where not(noa=" + t_curno + ") and tranno=trans" + r_accy + ".noa and trannoq=trans" + r_accy + ".noq and (straddrno between " + t_bstraddrno + " and " + t_estraddrno + ") and (endaddrno between " + t_bendaddrno + " and " + t_eendaddrno + "))^^";
						t_where += "^^";

						t_where += "order=^^datea,noa^^";
						$(this).val('請稍後');
						$(this).attr('disabled', 'disabled');
						q_gt('trans', t_where, 0, 0, 0, "", r_accy);
					}
				});
				$("#btnCustchg").click(function(e) {
					if ($('#txtCustno').val().length == 0) {
						alert('請輸入客戶編號!');
						return;
					}
					var t_custchgno='';
					if(curData.isLoadCustchgno){
						for(var i=0;i<curData.custchgno.length;i++)
							t_custchgno += (t_custchgno.length>0?',':'')+curData.custchgno[i];
						t_custchgno='custchgno='+t_custchgno;
					}
					t_where = "  custno='" + $('#txtCustno').val() + "' and  (trdno='" + $('#txtNoa').val() + "' or len(isnull(trdno,''))=0) ";
					q_box("custchg_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_custchgno + ";", 'custchg', "95%", "650px", q_getMsg('popCustchg'));
				});
				$("#btnVcca").click(function(e) {
					if ($('#txtCustno').val().length == 0) {
						alert('請輸入客戶編號!');
						return;
					}
					var t_vccano='';
					if(curData.isLoadVccano){
						for(var i=0;i<curData.vccano.length;i++)
							t_vccano += (t_vccano.length>0?',':'')+curData.vccano[i];
						t_vccano='vccano='+t_vccano;
					}
					t_where = "  custno='" + $('#txtCustno').val() + "' and  (trdno='" + $('#txtNoa').val() + "' or len(isnull(trdno,''))=0) ";
					q_box("vcca_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_vccano + ";", 'vcca', "95%", "650px", q_getMsg('popVcca'));
				});
				
				$('#txtMemo').change(function() {
					if (isEditTotal && $.trim($('#txtMemo').val()).substring(0, 1) == '.') {
						$('#txtTotal').removeAttr('readonly').css('background-color', 'white').css('color', 'black');
					} else {
						$('#txtTotal').attr('readonly', 'readonly').css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
						sum();
					}
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'custchg':
						if (b_ret != null) {
							var t_where='1!=1';
							curData.isLoadCustchgno = true;
							curData.custchgno = new Array();
							for (var i = 0; i < b_ret.length; i++) {
								curData.custchgno.push(b_ret[i].noa);
								t_where +=" or noa='"+b_ret[i].noa+"'";
							}
							q_gt('custchg', "where=^^"+t_where+"^^", 0, 0, 0, "");
						}
						break;
					case 'vcca':
						if (b_ret != null) {
							var t_where='1!=1';
							curData.isLoadVccano = true;
							curData.vccano = new Array();
							for (var i = 0; i < b_ret.length; i++) {
								curData.vccano.push(b_ret[i].noa);
								t_where +=" or noa='"+b_ret[i].noa+"'";
							}
							q_gt('vcca1', "where=^^"+t_where+"^^", 0, 0, 0, "");
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
					case 'custchg':
						var as = _q_appendData("custchg", "", true);
						var t_plusmoney=0,t_minusmoney=0;
						for ( i = 0; i < as.length; i++) {
							t_plusmoney+=parseFloat(as[i].plusmoney);
							t_minusmoney+=parseFloat(as[i].minusmoney);
						}
						$('#txtPlusmoney').val(t_plusmoney);
						$('#txtMinusmoney').val(t_minusmoney);
						sum();
						break;
					case 'vcca':
						var as = _q_appendData("vcca", "", true);
						var t_money=0,t_tax=0,t_total=0;
						for ( i = 0; i < as.length; i++) {
							t_money+=parseFloat(as[i].money);
							t_tax+=parseFloat(as[i].tax);
							t_tax+=parseFloat(as[i].tatol);
						}
						$('#txtVccamoney').val(t_money);
						$('#txtVccatax').val(t_tax);
						$('#txtVccatax').val(t_tatol);
						break;
					case 'trans':
						var as = _q_appendData("trans", "", true);
						q_gridAddRow(bbsHtm, 'tbbs', 'txtTranno,txtOrdeno,txtTrandate', as.length, as, 'tranno,ordeno,trandate', '', '');
						for ( i = 0; i < q_bbsCount; i++) {
							_btnMinus("btnMinus_" + i);
							if (i < as.length) {
								$('#txtOrdeno_' + i).val(as[i].ordeno);
								$('#txtTranno_' + i).val(as[i].noa);
								$('#txtTrannoq_' + i).val(as[i].noq);
								$('#txtTrandate_' + i).val(as[i].trandate);
								$('#txtCarno_' + i).val(as[i].carno);
								$('#txtRs_' + i).val();
								$('#txtStraddr_' + i).val(as[i].straddr);
								$('#txtTranmoney_' + i).val(as[i].total);
								$('#txtPaymemo_' + i).val();
								$('#txtFill_' + i).val(as[i].fill);
								$('#txtCasetype_' + i).val(as[i].csetype);
								$('#txtCaseno_' + i).val(as[i].caseno);
								$('#txtCaseno2_' + i).val(as[i].caseno2);
								$('#txtBoat_' + i).val();
								$('#txtBoatname_' + i).val();
								$('#txtMemo_' + i).val();
								$('#txtOverweightcost_' + i).val();
								$('#txtOthercost_' + i).val();
								$('#txtMount_' + i).val(as[i].mount);
								$('#txtPrice_' + i).val(as[i].price);
								$('#txtTotal_' + i).val(as[i].total);
								$('#txtCustorde_' + i).val(as[i].custorde);
								$('#txtProduct_' + i).val(as[i].product);
							}
						}
						sum();
						$('#btnTrans').val("出車單匯入");
						$('#btnTrans').removeAttr('disabled');
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				$('#txtWorker').val(r_name);
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				//-------------------------------------------------
				//回寫CUSTCHG
				if(curData.isLoadCustchgno){
					var t_custchgno='';
					for(var i=0;i<curData.custchgno.length;i++)
						t_custchgno+=(t_custchgno.length>0?',':'')+curData.custchgno[i];
					$('#txtCustchgno').val(t_custchgno);
				}
				//-------------------------------------------------
				//回寫VCCA
				if(curData.isLoadVccano){
					var t_vccano='';
					for(var i=0;i<curData.vccano.length;i++)
						t_vccano+=(t_vccano.length>0?',':'')+curData.vccano[i];
					$('#txtVccano').val(t_vccano);
				}
				//-------------------------------------------------
				sum();
				if ($('#txtMon').val().length == 0) {
					$('#txtMon').val($('#txtDatea').val().substring(0, 6));
				}
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('trd_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				_bbsAssign();
				for (var ix = 0; ix < q_bbsCount; ix++) {
					$('#lblNo_' + ix).text(ix + 1);
				}
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				curData = new trd();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				curData = new trd();
			}

			function btnPrint() {
				q_box('z_trd.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "800px", "600px", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['ordeno'] && !as['tranno'] && !as['trannoq']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['noa'] = abbm2['noa'];
				as['date'] = abbm2['date'];

				return true;
			}

			function sum() {
				if (isEditTotal && $.trim($('#txtMemo').val()).substring(0, 1) == '.')
					return;
				var t_money = 0, t_rate = 0, t_tax = 0, t_total = 0, t_mount = 0, t_plus = 0, t_plusmoney = 0, t_minusmoney = 0;
				for ( iz = 0; iz < q_bbsCount; iz++) {
					t_money += Math.round(q_float('txtTranmoney_' + iz) * 1000);
					t_mount += Math.round(q_float('txtMount_' + iz) * 1000);
				}
				t_money = t_money / 1000;
				t_mount = t_mount / 1000;

				t_discount = q_float('txtDiscount');
				t_plus = q_float('txtPlus');
				t_rate = q_float('txtTaxrate');
				t_plusmoney = q_float('txtPlusmoney');
				t_minusmoney = q_float('txtMinusmoney');
				switch($('#cmbTaxtype').val()+'') {
					case '1':
						$('#txtTaxrate').val(q_getPara('sys.taxrate'));
						t_rate = q_float('txtTaxrate');
						t_tax = Math.round((t_money - t_discount + t_plus) * t_rate / 100);
						t_total = (t_money - t_discount + t_plus + t_plusmoney - t_minusmoney) + t_tax;
						break;
					case '3':
						t_total = Math.round((t_money - t_discount + t_plus) / (1 + t_rate / 100), 0);
						t_tax = (t_money - t_discount + t_plus) - t_total;
						t_total = t_money + t_plusmoney - t_minusmoney;
						break;
					case '5':
						t_tax = q_float('txtTax');
						t_total = (t_money - t_discount + t_plus + t_plusmoney - t_minusmoney) + t_tax;
						break;
					default:
						t_total = (t_money - t_discount + t_plus + t_plusmoney - t_minusmoney);
				}

				$('#txtMoney').val(t_money);
				$('#txtDiscount').val(t_discount);
				$('#txtPlus').val(t_plus);
				$('#txtTax').val(t_tax);
				$('#txtTotal').val(t_total);
				$('#txtMount').val(t_mount);
			}

			function refresh(recno) {
				_refresh(recno);

			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (q_cur == 1 || q_cur == 2) {
					$('#btnTrans').removeAttr('disabled');
					$('#btnCustchg').removeAttr('disabled');
					$('#btnVcca').removeAttr('disabled');
				} else {
					$('#btnTrans').attr('disabled', 'disabled');
					$('#btnCustchg').attr('disabled', 'disabled');
					$('#btnVcca').attr('disabled', 'disabled');
				}
				if (isEditTotal && (q_cur == 1 || q_cur == 2) && $.trim($('#txtMemo').val()).substring(0, 1) == '.') {
					$('#txtTotal').removeAttr('readonly').css('background-color', 'white').css('color', 'black');
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
			}
		</script>
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
			.tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
				background-color: #FFEC8B;
			}
			.tbbm  .tr_import {
				background-color: #DAA520;
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
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 40%;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.dbbs {
				width: 2000px;
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
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:15%"><a id='vewDatea'></a></td>
						<td align="center" style="width:20%"><a id='vewVccano'></a></td>
						<td align="center" style="width:20%"><a id='vewComp'></a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='vccano'>~vccano</td>
						<td id='nick' style="text-align: center;">~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td4"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td5">
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
						<td class="td6"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td class="td7" colspan="3">
						<input id="txtCustno" type="text"  style='width:20%; float:left;'/>
						<input id="txtComp" type="text"  style='width:80%; float:left;'/>
						<input id="txtNick" type="text"  style="display:none;"/>
						</td>
						<td class="tdA"></td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblDate2" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtBdate" type="text"  class="txt c2"/>
						<span style="float:left;display: block;width:20px;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
						<input id="txtEdate" type="text"  class="txt c2"/>
						</td>
						<td class="td4"><span> </span><a id="lblStraddr" class="lbl btn"> </a></td>
						<td class="td5" colspan="6">
						<input id="txtStraddrno" type="text"  class="txt" style="float:left;width:15%;"/>
						<input id="txtStraddr" type="text"  class="txt" style="float:left;width:30%;"/>
						<span style="float:left; display:block; width:20px;">~</span>
						<input id="txtEndaddrno" type="text"  class="txt" style="float:left;width:15%;"/>
						<input id="txtEndaddr" type="text"  class="txt" style="float:left;width:30%;"/>
						</td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtBtrandate" type="text"  class="txt c2"/>
						<span style="float:left;display: block;width:20px;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
						<input id="txtEtrandate" type="text"  class="txt c2"/>
						</td>
						<td class="td4"><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td class="td5" colspan="3">
						<input id="txtPo" type="text"  class="txt c1"/>
						</td>
						<td class="td8"></td>
						<td class="td9"></td>
						<td class="tdA"></td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblOdate" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtBodate" type="text"  class="txt c2"/>
						<span style="float:left;display: block;width:20px;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
						<input id="txtEodate" type="text"  class="txt c2"/>
						</td>
						<td class="td3"><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td class="td4" colspan="2">
						<input id="txtOrdeno" type="text" class="txt c1" />
						</td>
						<td class="td6"></td>
						<td class="td7"></td>
						<td class="td8"></td>
						<td class="td9">
						<input type="button" id="btnTrans" class="txt c1"/>
						</td>
						<td class="tdZ"></td>
					</tr>
					<tr class=".tr_import">
						<td colspan="9"><input id="txtCustchgno" type="text" class="txt c1" style="display:none;"/></td>
						<td><input type="button" id="btnCustchg" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr class=".tr_import">
						<td><span> </span><a id="lblVccamoney" class="lbl"> </a></td>
						<td><input id="txtVccamoney" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblVccatax" class="lbl"> </a></td>
						<td><input id="txtVccatax" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblVccatotal" class="lbl"> </a></td>
						<td><input id="txtVccatotal" type="text" class="txt c1 num"/></td>
						<td colspan="2"> </td>
						<td>
							<input id="txtVccano" type="text" class="txt c1" style="display:none;"/>
							<input type="button" id="btnVcca" class="txt c1"/>
						</td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtCno" type="text"  class="txt" style="float: left; width:25%;"/>
						<input id="txtAcomp" type="text"  class="txt"  style="float: left; width:75%;"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td5"><span> </span><a id="lblTovcca" class="lbl"> </a></td>
						<td class="td6"><select id="cmbTovcca" class="txt c2"></select>
						<input id="txtMon" type="text"  class="txt c3"/>
						</td>
						<td class="td7"><span> </span><a id="lblTrtype" class="lbl"> </a></td>
						<td class="td8"><select id="cmbTrtype" class="txt c1"></select></td>
						<td class="td9"><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td class="tdA"><select id="cmbTypea" class="txt c1"></select></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblBoat" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtBoatno" type="text"  style='width:20%; float:left;'/>
						<input id="txtBoat" type="text"  style='width:80%; float:left;'/>
						</td>
						<td class="td5" ><span> </span><a id="lblBoatname" class="lbl"> </a></td>
						<td class="td6" colspan="2">
						<input id="txtBoatname" type="text" class="txt c1" />
						</td>
						<td class="td8" colspan="3">
						<input id="txtShip" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>

						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td>
						<input id="txtMoney" type="text"  class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td>
						<input id="txtDiscount" type="text"  class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblPlus" class="lbl"> </a></td>
						<td>
						<input id="txtPlus" type="text"  class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblTaxrate" class="lbl"> </a></td>
						<td><select id="cmbTaxtype" class="txt c3"></select>
						<input id="txtTaxrate" type="text"  class="txt c2 num"/>
						</td>
						<td><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td>
						<input id="txtTax" type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td>
						<input id="txtPlusmoney" type="text"  class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td>
						<input id="txtMinusmoney" type="text"  class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td>
						<input id="txtTotal" type="text"  class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td>
						<input id="txtMount" type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="5">
						<input id="txtMemo" type="text"  class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td class="td8">
						<input id="txtAccno" type="text"  class="txt c1"/>
						</td>
						<td class="td9"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="tdA">
						<input id="txtWorker" type="text"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:120px;"><a id='lblTrandate_s'></a></td>
					<td align="center" style="width:200px;"><a id='lblStraddr_s'></a></td>
					<td align="center" style="width:120px;"><a id='lblProduct_s'></a></td>
					<td align="center" style="width:120px;"><a id='lblMount_s'></a></td>
					<td align="center" style="width:120px;"><a id='lblPrice_s'></a></td>
					<td align="center" style="width:120px;"><a id='lblTotal_s'></a></td>
					<td align="center" style="width:100px;"><a id='lblCarno_s'></a></td>
					<td align="center" style="width:150px;"><a id='lblCustorde_s'></a></td>
					<td align="center" style="width:170px;"><a id='lblCaseno_s'></a></td>
					<td align="center" style="width:160px;"><a id='lblTranno_s'></a></td>
					<td align="center" style="width:30px;"><a id='lblRs_s'></a></td>
					<td align="center" style="width:100px;"><a id='lblTranmoney_s'></a></td>
					<td align="center" style="width:100px;"><a id='lblPaymemo_s'></a></td>
					<td align="center" style="width:50px;"><a id='lblFill_s'></a></td>
					<td align="center" style="width:50px;"><a id='lblCasetype_s'></a></td>
					<td align="center" style="width:150px;"><a id='lblCaseno2_s'></a></td>
					<td align="center" style="width:100px;"><a id='lblBoat_s'></a></td>
					<td align="center" style="width:100px;"><a id='lblBoatname_s'></a></td>
					<td align="center" style="width:100px;"><a id='lblShip_s'></a></td>
					<td align="center" style="width:100px;"><a id='lblMemo_s'></a></td>
					<td align="center" style="width:100px;"><a id='lblOverweightcost_s'></a></td>
					<td align="center" style="width:100px;"><a id='lblOthercost_s'></a></td>
					<td align="center" style="width:120px;"><a id='lblOrdeno_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
					<input type="text" id="txtTrandate.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtStraddr.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtProduct.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtMount.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtPrice.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtTotal.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtCarno.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCustorde.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCaseno.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtTranno.*" style="float:left; width: 95%;"/>
					<input type="text" id="txtTrannoq.*" style="display:none;"/>
					</td>
					<td >
					<input type="text" id="txtRs.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtTranmoney.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtPaymemo.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtFill.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCasetype.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCaseno2.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtBoat.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtBoatname.*" style="width:95%;"/>
					</td>
					<td >
					<input type="text" id="txtShip.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtMemo.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtOverweightcost.*" style="width:95%;text-align: right;"/>
					</td>
					<td >
					<input type="text" id="txtOthercost.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtOrdeno.*" style="width:95%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
