<%@ Page Language="C#" AutoEventWireup="true" %>
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
            var q_name = "trd";
            var q_readonly = ['txtNoa', 'txtMoney', 'txtTotal'];
            var q_readonlys = ['txtOrdeno', 'txtTranno', 'txtTrannoq'];
            var bbmNum = [['txtPrice', 11, 3]];
            var bbsNum = [['txtTranmoney', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver,cardealno,cardeal', 'txtCarno,txtDriverno,txtDriver,txtCardealno,txtCardeal', 'car2_b.aspx'], ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx'], ['txtStraddrno', 'lblStraddr', 'addr', 'noa,addr', 'txtStraddrno,txtStraddr', 'addr_b2.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtWorker', 'lblWorker', 'sss', 'noa,namea', 'txtWorkerno,txtWorker', 'sss_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                fbbm[fbbm.length] = 'txtMemo';
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtBtrandate', r_picd], ['txtEtrandate', r_picd]];
                q_mask(bbmMask);

                q_cmbParse("cmbTrtype", q_getPara('trd.trtype'));
                q_cmbParse("cmbTypea", q_getPara('sys.yn'));
                q_cmbParse("cmbTovcca", q_getPara('sys.yn'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

                $('#lblAccno').parent().click(function(e) {
                    q_box("accc.aspx?" + $('#txtAccno').val() + "'", 'accc', "850px", "600px", q_getMsg("popAccc"));
                });

                $('#cmbTaxtype').change(function(e) {
                    sum();
                });
                $('#txtTaxrate').change(function(e) {
                    sum();
                });
                $('#txtTax').change(function(e) {
                    sum();
                });

                $('#btnTrans').click(function(e) {
                    if(q_cur == 1 || q_cur == 2) {
                        if($.trim($('#txtCustno').val()) == 0) {
                            alert('Please enter the customer no.');
                            return false;
                        }
                        var t_ordeno = "'" + $.trim($('#txtOrdeno').val()) + "'";
                        var t_curno = "'" + $.trim($('#txtNoa').val()) + "'";
                        var t_custno = "'" + $.trim($('#txtCustno').val()) + "'";
                        var t_btrandate = "'" + $.trim($('#txtBtrandate').val()) + "'";
                        var t_etrandate = $.trim($('#txtEtrandate').val());
                        t_etrandate = t_etrandate.length == 0 ? "char(255)" : "'" + t_etrandate + "'";
                        var t_bodate = "'" + $.trim($('#txtBodate').val()) + "'";
                        var t_eodate = $.trim($('#txtEodate').val());
                        t_eodate = t_eodate.length == 0 ? "char(255)" : "'" + t_eodate + "'";
                        var t_bstraddrno = "'" + $.trim($('#txtBstraddrno').val()) + "'";
                        var t_estraddrno = $.trim($('#txtEstraddrno').val());
                        t_estraddrno = t_estraddrno.length == 0 ? "char(255)" : "'" + t_estraddrno + "'";
                        var t_bendaddrno = "'" + $.trim($('#txtBendaddrno').val()) + "'";
                        var t_eendaddrno = $.trim($('#txtEendaddrno').val());
                        t_eendaddrno = t_eendaddrno.length == 0 ? "char(255)" : "'" + t_eendaddrno + "'";
                        var t_tranordeno = "'" + $.trim($('#txtOrdeno').val()) + "'";
                        var t_po = "'" + $.trim($('#txtPo').val()) + "'";

                        t_where = "where=^^(custno=" + t_custno + ") and (isnull(datea,'') between " + t_btrandate + " and " + t_etrandate + ") and ";
                        if(!(t_po=="''"))
                        	t_where += " (trans" + r_accy + ".po=" + t_po + ") and";
                        if(!(t_bodate == "''" && t_eodate == "char(255)" && t_ordeno == "''"))
                            t_where += " exists(select * from tranorde" + r_accy + " where noa=trans" + r_accy + ".ordeno and (odate between " + t_bodate + " and " + t_eodate + ")) and ";
                        t_where += " not exists(select * from trds" + r_accy + " where not(noa=" + t_curno + ") and tranno=trans" + r_accy + ".noa and trannoq=trans" + r_accy + ".noq and (straddrno between " + t_bstraddrno + " and " + t_estraddrno + ") and (endaddrno between " + t_bendaddrno + " and " + t_eendaddrno + "))^^";
                        t_where += "order=^^datea,noa^^";
                        q_gt('trans', t_where, 0, 0, 0, "", r_accy);
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
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'trans':
                        var as = _q_appendData("trans", "", true);

                        q_gridAddRow(bbsHtm, 'tbbs', 'txtTranno,txtOrdeno,txtTrandate', as.length, as, 'tranno,ordeno,trandate', '', '');

                        /*while(as.length > q_bbsCount) {
                         $('#btnPlus').click();
                         }*/
                        for( i = 0; i < q_bbsCount; i++) {
                            _btnMinus("btnMinus_" + i);
                            if(i < as.length) {
                                $('#txtOrdeno_' + i).val(as[i].ordeno);
                                $('#txtTranno_' + i).val(as[i].noa);
                                $('#txtTrannoq_' + i).val(as[i].noq);
                                $('#txtTrandate_' + i).val(as[i].trandate);
                                $('#txtCarno_' + i).val(as[i].carno);
                                $('#txtRs_' + i).val();
                                $('#txtStraddr_' + i).val(as[i].straddr);
                                $('#txtEndaddr_' + i).val(as[i.endaddr]);
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
                            }
                        }
                        sum();
                        break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
            	 $('#txtWorker').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)
                    return;

                q_box('trd_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
                for(var i = 0; i < q_bbsCount; i++) {
                    if( typeof ($('#txtTranmoney_' + i).data('info')) == 'undefined')
                        $('#txtTranmoney_' + i).data('info', {
                            isSetChange : false
                        });

                    if( typeof ($('#txtTranmoney_' + i).data('info').isSetChange) == 'undefined') {
                        $('#txtTranmoney_' + i).data('info').isSetChange = false;

                    }
                    if(!$('#txtTranmoney_' + i).data('info').isSetChange) {
                        $('#txtTranmoney_' + i).data('info').isSetChange = true;
                        $('#txtTranmoney_' + i).change(function(e) {
                            sum();
                        });
                    }
                }
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['ordeno'] && !as['tranno'] && !as['trannoq']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['noa'] = abbm2['noa'];
                as['date'] = abbm2['date'];

                return true;
            }

            function sum() {
                var t_money = 0, t_rate = 0, t_tax = 0, t_total = 0;
                for( i = 0; i < q_bbsCount; i++) {
                	t_money += parseInt($.trim($('#txtTranmoney_' + i).val()).length == 0 ? '0' : $('#txtTranmoney_' + i).val().replace(/,/g,''), 10);
                }
                t_rate = parseInt($.trim($('#txtTaxrate').val()).length == 0 ? '0' : $('#txtTaxrate').val().replace(/,/g,''), 10);
                switch($('#cmbTaxtype').val()) {
                    case '1':
                        t_tax = Math.round(t_money * t_rate / 100);
                        t_total = t_money + t_tax;
                        break;
                    case '3':
                        t_total = t_money;
                        t_money = Math.round(t_total / (1 + t_rate / 100), 0);
                        t_tax = t_total - t_money;
                        break;
                    case '5':
                        t_tax = parseInt($.trim($('#txtTax').val()).length == 0 ? '0' : $('#txtTax').val().replace(/,/g,''), 10);
                        t_total = t_money + t_tax;
                        break;
                    default:
                        t_total = t_money;
                }
                $('#txtMoney').val(t_money);
                $('#txtTax').val(t_tax);
                $('#txtTotal').val(t_total);
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
                width: 23%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: 16px;
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
                font-size: 16px;
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
            .tbbm .tr2, .tbbm .tr3 {
                background-color: #FFEC8B;
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
                font-size: 16px;
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
                width: 150%;
            }
            .tbbs a {
                font-size: 14px;
            }
            input[type="text"],input[type="button"] {
                font-size:medium;
            }
            .num {
                text-align: right;
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
						<td align="center" style="width:20%"><a id='vewOrdeno'></a></td>
						<td align="center" style="width:20%"><a id='vewComp'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='ordeno'>~ordeno</td>
						<td align="center" id='comp,4'>~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td class="td4">
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblCust" class="lbl btn"></a></td>
						<td class="td6" colspan="3">
						<input id="txtCustno" type="text"  style='width:20%; float:left;'/>
						<input id="txtComp" type="text"  style='width:80%; float:left;'/>
						</td>
						<td class="td9"></td>
						<td class="tdA"></td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblTrandate" class="lbl"></a></td>
						<td class="td2" colspan="2">
						<input id="txtBtrandate" type="text"  class="txt c2"/>
						<span style="float:left;display: block;width:20px;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
						<input id="txtEtrandate" type="text"  class="txt c2"/>
						</td>
						<td class="td4"><span> </span><a id="lblStraddr" class="lbl btn"></a></td>
						<td class="td5" colspan="2">
						<input id="txtStraddrno" type="text"  class="txt c2"/>
						<input id="txtStraddr" type="text"  class="txt c3"/>
						</td>
						<td class="td6"><span> </span><a id="lblPo" class="lbl"></a></td>
						<td class="td7">
						<input id="txtPo" type="text"  class="txt c1"/>
						</td>
						<td class="td8"></td>
						<td class="td9">
						<input type="button" id="btnTrans" class="txt c1"/>
						</td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblOdate" class="lbl"></a></td>
						<td class="td2" colspan="2">
						<input id="txtBodate" type="text"  class="txt c2"/>
						<span style="float:left;display: block;width:20px;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
						<input id="txtEodate" type="text"  class="txt c2"/>
						</td>
						<td class="td3"><span> </span><a id="lblOrdeno" class="lbl"></a></td>
						<td class="td4">
						<input id="txtOrdeno" type="text" class="txt c1" />
						</td>
						<td class="td5"></td>
						<td class="td6"></td>
						<td class="td7"></td>
						<td class="td8"></td>
						<td class="td9"></td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblVccadate" class="lbl"></a></td>
						<td class="td2">
						<input id="txtVccadate" type="text" class="txt c1" />
						</td>
						<td class="td3"><span> </span><a id="lblVccano" class="lbl"></a></td>
						<td class="td4">
						<input id="txtVccano" type="text" class="txt c1" />
						</td>
						<td class="td5"><span> </span><a id="lblTovcca" class="lbl"></a></td>
						<td class="td6"><select id="cmbTovcca" class="txt c2"></select>
						<input id="txtMon" type="text"  class="txt c3"/>
						</td>
						<td class="td7"><span> </span><a id="lblTrtype" class="lbl"></a></td>
						<td class="td8"><select id="cmbTrtype"></select></td>
						<td class="td9"><span> </span><a id="lblTypea" class="lbl"></a></td>
						<td class="tdA"><select id="cmbTypea"></select></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblBoat" class="lbl btn"></a></td>
						<td class="td2" colspan="3">
						<input id="txtBoatno" type="text"  style='width:20%; float:left;'/>
						<input id="txtBoat" type="text"  style='width:80%; float:left;'/>
						</td>
						<td class="td5" ><span> </span><a id="lblBoatname" class="lbl"></a></td>
						<td class="td6" colspan="2">
						<input id="txtBoatname" type="text" style="width: 100%;" />
						</td>
						<td class="td8" colspan="3">
						<input id="txtShip" type="text" style="width: 100%;" />
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblMoney" class="lbl"></a></td>
						<td class="td2">
						<input id="txtMoney" type="text"  class="txt c1 num"/>
						</td>
						<td class="td3"><span> </span><a id="lblTaxrate" class="lbl"></a></td>
						<td class="td4"><select id="cmbTaxtype" class="txt c3"></select>
						<input id="txtTaxrate" type="text"  class="txt c2 num"/>
						</td>
						<td class="td5"><span> </span><a id="lblTax" class="lbl"></a></td>
						<td class="td6">
						<input id="txtTax" type="text" class="txt c1 num"/>
						</td>
						<td class="td7"><span> </span><a id="lblTotal" class="lbl"></a></td>
						<td class="td8">
						<input id="txtTotal" type="text" class="txt c1 num" />
						</td>
						<td class="td9"><span> </span><a id="lblAccno" class="lbl btn"></a></td>
						<td class="tdA">
						<input id="txtAccno" type="text"  class="txt c1"/>
						</td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
						<td class="td2" colspan="6">		<textarea id="txtMemo" cols="10" rows="5" style="width: 98%;height: 50px;"></textarea></td>
						<td class="td8"></td>
						<td class="td9"><span> </span><a id="lblWorker" class="lbl"></a></td>
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
					<td  align="center" style="width:2%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:4%;"><a id='lblTranno_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblTrandate_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblCarno_s'></a></td>
					<td align="center" style="width:1%;"><a id='lblRs_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblStraddr_s'></a></td>
					<td align="center" style="width:4%;"><a id='lblTranmoney_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblPaymemo_s'></a></td>
					<td align="center" style="width:1%;"><a id='lblFill_s'></a></td>
					<td align="center" style="width:2%;"><a id='lblCasetype_s'></a></td>
					<td align="center" style="width:4%;"><a id='lblCaseno_s'></a></td>
					<td align="center" style="width:4%;"><a id='lblCaseno2_s'></a></td>
					<td align="center" style="width:4%;"><a id='lblBoat_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblBoatname_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblShip_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblMemo_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblOverweightcost_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblOthercost_s'></a></td>
					<td align="center" style="width:4%;"><a id='lblOrdeno_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td >
					<input type="text" id="txtTranno.*" style="float:left; width: 95%;"/>
					<input type="text" id="txtTrannoq.*" style="display:none;"/>
					</td>
					<td >
					<input type="text" id="txtTrandate.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCarno.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtRs.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtStraddr.*" style="width:95%;" />
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
					<input type="text" id="txtCaseno.*" style="width:95%;" />
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
