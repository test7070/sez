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

            var decbbs = ['mount']
            var decbbm = ['mount', 'price', 'price2', 'price3', 'discount', 'reserve', 'gross', 'plus', 'minus', 'mount2', 'total', 'total2', 'commission', 'unpack', 'thirdprice'];
            var q_name = "tranorde";
            var q_readonly = ['txtNoa', 'txtTranquatno', 'txtTranquatnoq'];
            var q_readonlys = [];
            var bbsNum = [];
            var bbsMask = [];
            var bbmNum = new Array(['txtUnpack', 10, 0], ['txtMount', 10, 0], ['txtPrice', 10, 2], ['txtPrice2', 10, 2], ['txtPrice3', 10, 2], ['txtDiscount', 10, 0], ['miles', 10, 2], ['txtReserve', 10, 0], ['tolls', 10, 0], ['txtTicket', 10, 0], ['txGross', 10, 2], ['txtWeight', 10, 2], ['txtPlus', 10, 0], ['txtMius', 10, 0], ['txtMount2', 10, 2], ['txtTotal', 10, 0], ['txtOverw', 10, 0], ['txtOverH', 10, 0], ['txtTotal2', 10, 0], ['txtCommission', 10, 0], ['txtGps', 10, 0], ['txtPton', 10, 2], ['txtPton2', 10, 2]);
            var bbmMask = new Array(['txtTrandate', '999/99/99'], ['txtOdate', '999/99/99'], ['txtDatea', '999/99/99'], ['txtBilldate', '999/99/99']);
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver,cardealno,cardeal', 'txtCarno,txtDriverno,txtDriver,txtCardealno,txtCardeal', 'car2_b.aspx'], ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx'], ['txtStraddrno', 'lblStraddr', 'addr', 'noa,addr', 'txtStraddrno,txtStraddr', 'addr_b.aspx'], ['txtEndaddrno', 'lblEndaddr', 'addr', 'noa,addr', 'txtEndaddrno,txtEndaddr', 'addr_b.aspx'], ['txtAddr_placeno', 'lblAddr_place', 'addr', 'noa,addr', 'txtAddr_placeno,txtAddr_place', 'addr_b.aspx'], ['txtAddr_transno', 'lblAddr_trans', 'addr', 'noa,addr', 'txtAddr_transno,txtAddr_trans', 'addr_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtSales', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtWorker', 'lblWorker', 'sss', 'noa,name', 'txtWorkerno,txtWorker', 'sss_b.aspx']);
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
                q_mask(bbmMask);
                mainForm(0);
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'tranorde.check':
                        if(result.substring(0, 1) != '1')
                            alert(result);
                        else {
                            var t_noa = trim($('#txtNoa').val());
                            var t_date = trim($('#txtDatea').val());
                            if(t_noa.length == 0 || t_noa == "AUTO")
                                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                            else
                                wrServer(t_noa);
                        }
                        break;
                    case 'car2.getItem':
                        if(result.substr(0, 5) == '<Data') {
                            var tmp = _q_appendData('carteam', '', true);
                            var value = '';
                            for(var z = 0; z < tmp.length; z++) {
                                value = value + (value.length > 0 ? ',' : '') + tmp[z].noa + '@' + tmp[z].team;
                            }
                            q_cmbParse("cmbCarteamno", value);
                            refresh(q_recno);
                        } else
                            alert('Error!' + '\r' + t_func + '\r' + result);
                        break;
                }
            }

            function mainPost() {
                fbbm[fbbm.length] = 'txtMemo';
                q_cmbParse("cmbCalctype", q_getPara('trans.calctype'));
                q_cmbParse("cmbTtype", q_getPara('trans.ttype'));
                q_cmbParse("cmbCasetype", q_getPara('trans.casetype'));
                q_cmbParse("cmbUnit", q_getPara('trans.unit'));
                q_cmbParse("cmbUnit2", q_getPara('trans.unit'));
                q_func('car2.getItem', '3,4,5');

                $("#cmbCalctype").change(function() {
                    if($("#cmbCalctype").val() == '6') {
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
                    sum();
                });
                $("#txtMount").change(function() {
                    sum();
                });
                $("txtPrice").change(function() {
                    sum();
                });
                $("#txtMount2").change(function() {
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
                $("#btnTranquat").click(function(e) {
                    t_where = "b.custno='" + $('#txtCustno').val() + "' and not exists(select * from tranorde" + r_accy + " c where a.noa = c.tranquatno and a.no3 = c.tranquatnoq and not c.noa='" + $('#txtNoa').val() + "')";
                    q_box("tranquat_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;tranquatno=" + $('#txtTranquatno').val() + '_' + $('#txtTranquatnoq').val() + ";", 'tranquats', "95%", "650px", q_getMsg('popTranquat'));
                });
            }

            function sum() {
                $("#txtTotal").val($("#txtMount").val() * $("#txtPrice").val());
                $("#txtTotal2").val($("#txtMount2").val() * (1 - $("#txtDiscount").val()) * ($("#cmbCalctype").val() == '6' ? $("#txtPrice3").val() : $("#txtPrice2").val()));
            }

            function txtCopy(dest, source) {
                var adest = dest.split(',');
                var asource = source.split(',');
                $('#' + adest[0]).focus(function() {
                    if(trim($(this).val()).length == 0)
                        $(this).val(q_getMsg('msgCopy'));
                });
                $('#' + adest[0]).focusout(function() {
                    var t_copy = ($(this).val().substr(0, 1) == '=');
                    var t_clear = ($(this).val().substr(0, 2) == ' =');
                    for(var i = 0; i < adest.length; i++) { {
                            if(t_copy)
                                $('#' + adest[i]).val($('#' + asource[i]).val());

                            if(t_clear)
                                $('#' + adest[i]).val('');
                        }
                    }
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'tranquats':
                        if(q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if(!(!b_ret || b_ret.length == 0)) {
                                $('#txtTranquatno').val(b_ret[0].noa);
                                $('#txtTranquatnoq').val(b_ret[0].noq);
                                $('#txtUccno').val(b_ret[0].productno);
                                $('#txtProduct').val(b_ret[0].product);
                                $('#txtMount').val(b_ret[0].mount);
                                $('#txtPrice').val(b_ret[0].price);
                                $('#txtUnit').val(b_ret[0].unit);
                                $('#txtStraddrno').val(b_ret[0].straddrno);
                                $('#txtStraddr').val(b_ret[0].straddr);
                                $('#txtEndaddrno').val(b_ret[0].endaddrno);
                                $('#txtEndaddr').val(b_ret[0].endaddr);
                                $('#txtMemo').val(b_ret[0].memo);
                            }
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function q_gtPost(t_name) {

                switch (t_name) {
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();

                        if(q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)
                    return;

                q_box('cust_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
                var cmb = document.getElementById("combPay");
                if(!q_cur)
                    cmb.value = '';
                else
                    $('#txtPay').val(cmb.value);
                cmb.value = '';
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {

            }

            function btnOk() {
                if($("#cmbCalctype").val() == '6')
                    $("#txtPrice2").val(0);
                else
                    $("#txtPrice3").val(0);

                //q_func('tranorde.check', r_accy + "," + $('#txtNoa').val() + ",empty");
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                if($("#cmbCalctype").val() == '6') {
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
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if(q_tables == 's')
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
                width: 73%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
                border-collapse: collapse;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr .td1, .tbbm tr .td3, .tbbm tr .td5, .tbbm tr .td7 {
                width: 10%;
            }
            .tbbm tr .td2, .tbbm tr .td4, .tbbm tr .td6, .tbbm tr .td8 {
                width: 10%;
            }
            .tbbm tr .td9 {
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
            .tbbm tr td {
                margin: 0px -1px;
                padding: 0;
            }
            .tbbm tr td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbm tr td input[type="button"] {
                width: auto;
                font-size: medium;
                float: right;
            }
            .tbbm tr td select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbm .tr16, .tbbm .tr17, .tbbm .tr18, .tbbm .tr19, .tbbm .tr20 {
                background-color: #FFEC8B;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 98%;
                height: 98%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
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
						<td align="center" style="width:20%"><a id='vewCust'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='ordeno'>~ordeno</td>
						<td align="center" id='cust,4'>~cust,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1" ><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtNoa" type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
						<td class="td5" ></td>
						<td class="td6" ></td>
						<td class="td7" >
						<input type="button" id="btnTranquat" />
						</td>
						<td class="td8" >
						<input type="text" id="txtTranquatno" style="width:75%;float: left; " />
						<input type="text" id="txtTranquatnoq" style="width:25%;float: left; " />
						</td>
						<td class="td9" ></td>
					</tr>
					<tr class="tr2">
						<td class="td1" ><span> </span><a id="lblCust" class="lbl btn"></a></td>
						<td class="td2" colspan="3">
						<input id="txtCustno" type="text"  style='width:25%; float:left;'/>
						<input id="txtComp" type="text"  style='width:75%; float:left;'/>
						</td>
						<td class="td5" ><span> </span><a id="lblOdate" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtOdate" type="text"  class="txt c1"/>
						</td>
						<td class="td7" ><span> </span><a id="lblTrandate" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtTrandate" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1" ><span> </span><a id="lblTtype" class="lbl"></a></td>
						<td class="td2" ><select id="cmbTtype" class="txt c1"></select></td>
						<td class="td3" ><span> </span><a id="lblCarteam" class="lbl"></a></td>
						<td class="td4" ><select id="cmbCarteamno" class="txt c1"></select></td>
						<td class="td5" ><span> </span><a id="lblPalno" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtPalno" type="text"  class="txt c1"/>
						</td>
						<td align="right">
						<input id="chkIspal" type="checkbox" style=" "/>
						</td>
						<td class="td8"><span> </span><a id="lblIspal"></a></td>
					</tr>
					<tr class="tr4">
						<td class="td1" ><span> </span><a id="lblStraddr" class="lbl btn"></a></td>
						<td class="td2" colspan="3">
						<input id="txtStraddrno" type="text"  class="txt c2"/>
						<input id="txtStraddr" type="text"  class="txt c3"/>
						</td>
						<td class="td3" ><span> </span><a id="lblEndaddr" class="lbl btn"></a></td>
						<td class="td4" colspan="3">
						<input id="txtEndaddrno" type="text" class="txt c2"/>
						<input id="txtEndaddr" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1" ><span> </span><a id="lblSales" class="lbl btn"></a></td>
						<td class="td2" colspan="3">
						<input id="txtSalesno" type="text"  class="txt c2"/>
						<input id="txtSales" type="text"  class="txt c3"/>
						</td>
						<td class="td3" ><span> </span><a id="lblWorker" class="lbl btn"></a></td>
						<td class="td4" colspan="3">
						<input id="txtWorkerno" type="text"  class="txt c2"/>
						<input id="txtWorker" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1" ><span> </span><a id="lblUcc" class="lbl btn"></a></td>
						<td class="td2" colspan="5">
						<input id="txtUccno" type="text"  class="txt c2"/>
						<input id="txtProduct" type="text"  class="txt c3"/>
						</td>
						<td class="td7"><span> </span><a id="lblThirdprice" class="lbl"></a></td>
						<td class="td8">
						<input id="txtThirdprice" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1" ><span> </span><a id="lblMount" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtMount" type="text"  class="txt num c4"/>
						<select id="cmbUnit" class="txt c5" style="margin: -1px -2px 0px 2px;"></select></td>
						<td class="td3" ><span> </span><a id="lblMount2" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtMount2" type="text"  class="txt num c4"/>
						<select id="cmbUnit2" class="txt c5"  style="margin: -1px -2px 0px 2px;"></select></td>
						<td class="td5" ><span> </span><a id="lblGross" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtGross" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr9">
						<td class="td1" ><span> </span><a id="lblCalctype" class="lbl"></a></td>
						<td class="td2" ><select id="cmbCalctype" class="txt c1"></select></td>
						<td class="td3" ><span> </span><a id="lblPrice" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtPrice" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" ><span> </span><a id="lblPrice2" class="lbl"></a><span> </span><a id="lblPrice3" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtPrice2" type="text"  class="txt num c1"/>
						<input id="txtPrice3" type="text"  class="txt num c1"/>
						</td>
						<td class="td7" ><span> </span><a id="lblDiscount" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtDiscount" type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr10">
						<td class="td1" ><span> </span><a id="lblPlus" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtPlus" type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblMinus" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtMinus" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" ><span> </span><a id="lblReserve" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtReserve" type="text" class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblUnpack" class="lbl"></a></td>
						<td class="td8">
						<input id="txtUnpack" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr11">
						<td class="td1" ><span> </span><a id="lblCaseno" class="lbl"></a></td>
						<td class="td2" colspan="3">
						<input id="txtCaseno" type="text"  style='width:50%; float:left;'/>
						<input id="txtCaseno2" type="text"  style='width:50%; float:left;'/>
						</td>
						<td class="td5" ><span> </span><a id="lblPo" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtPo" type="text"  class="txt c1"/>
						</td>
						<td class="td7" ><span> </span><a id="lblSo" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtSo" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr12">
						<td class="td1" ><span> </span><a id="lblCaseuse" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtCaseuse" type="text" class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblTraceno" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtTraceno" type="text"  class="txt c1"/>
						</td>
						<td class="td5" ><span> </span><a id="lblCasetype" class="lbl"></a></td>
						<td class="td6" ><select id="cmbCasetype" class="txt c1"></select></td>
					</tr>
					<tr class="tr13">
						<td class="td1"><span> </span><a id="lblFill" class="lbl"></a></td>
						<td class="td2">
						<input id="txtFill" type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblCaseend" class="lbl"></a></td>
						<td class="td4">
						<input id="txtCaseend" type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblBilldate" class="lbl"></a></td>
						<td class="td8">
						<input id="txtBilldate" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr14">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
						<td class="td2" colspan='7'>						<textarea id="txtMemo" style="width:99%; height: 35px;"></textarea></td>
					</tr>
					<tr class="tr15">
						<td class="td7"><span> </span><a id="lblTotal" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtTotal" type="text"  class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblTotal2" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtTotal2" type="text"  class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblCommission" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtCommission" type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr16">
						<td class='td1'><span> </span><a id="lblExcon" class="lbl" style="color: #ff0033;font-weight:bolder;"></a></td>
						<td class="td2"></td>
						<td class='td3'></td>
						<td class="td4"></td>
						<td class="td5"><span> </span><a id="lblImcon" class="lbl" style="color: #ff0033;font-weight:bolder;"></a></td>
						<td class="td6"></td>
						<td class="td7"></td>
						<td class="td8"></td>
						<td calss="td9"></td>
					</tr>
					<tr class="tr17">
						<td class="td1"><span> </span><a id="lblBoatname" class="lbl" style="color: #ff0033;"></a></td>
						<td class="td2">
						<input id="txtBoatname"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblShip" class="lbl"></a></td>
						<td class="td4">
						<input id="txtShip"  type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblAddr_place" class="lbl btn" style="font-size: 14px;"></a></td>
						<td class="td6" colspan="3">
						<input id="txtAddr_placeno"  type="text" class="txt c2"/>
						<input id="txtAddr_place"  type="text" class="txt c3"/>
						</td>
						<td class="td9"></td>
					</tr>
					<tr class="tr18">
						<td class="td1"><span> </span><a id="lblPort" class="lbl"></a></td>
						<td class="td2">
						<input id="txtPort"  type="text" class="txt c1"/>
						</td>
						<td class="td3"></td>
						<td class="td4"></td>
						<td class="td5"><span> </span><a id="lblAddr_orde" class="lbl" style="font-size: 14px;"></a></td>
						<td class="td6" colspan="3">
						<input id="txtAddr_orde"  type="text" style="width: 98%;"/>
						</td>
						<td calss="td9"></td>
					</tr>
					<tr class="tr19">
						<td class="td1"><span> </span><a id="lblAddr_trans" class="lbl btn"></a></td>
						<td class="td2" colspan="3">
						<input id="txtAddr_transno"  type="text" class="txt c2"/>
						<input id="txtAddr_trans"  type="text" class="txt c3"/>
						</td>
						<td class="td5"></td>
						<td class="td6">
						<input id="txtPortno"  type="text" class="txt c1"/>
						</td>
						<td class="td8"align="left" colspan="2"><span> </span><a id="lblPortno"class="txt c1" ></a></td>
						<td calss="td9"></td>
					</tr>
					<tr class="tr20">
						<td class="td1"><span> </span><a id="lblCldate" class="lbl"></a></td>
						<td class="td2">
						<input id="txtCldate"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblNodate" class="lbl"></a></td>
						<td class="td4">
						<input id="txtNodate"  type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblMadate" class="lbl"></a></td>
						<td class="td6">
						<input id="txtMadate"  type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblRedate" class="lbl" style="color: #ff0033;"></a></td>
						<td class="td8">
						<input id="txtRedate"  type="text" class="txt c1"/>
						</td>
						<td calss="td9"></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr name="schema">
					<td class="td0" style="width:2%"><span style="display: block; width:95%; height:0px;"> </span></td>
					<td class="td1" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
					<td class="td2" style="width:11%"><span style="display: block; width:95%; height:0px;"> </span></td>
					<td class="td3" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
					<td class="td4" style="width:11%"><span style="display: block; width:95%; height:0px;"> </span></td>
					<td class="td5" style="width:11%"><span style="display: block; width:95%; height:0px;"> </span></td>
					<td class="td6" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
					<td class="td7" style="width:25%"><span style="display: block; width:95%; height:0px;"> </span></td>
					<td class="td8" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
					<td class="td9" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
				</tr>
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" ><a id='lblDodate'></a></td>
					<td align="center" ><a id='lblAddr_do'></a></td>
					<td align="center" ><a id='lblCasetypes'></a></td>
					<td align="center" ><a id='lblAddr_get'></a></td>
					<td align="center" ><a id='lblCasenos'></a></td>
					<td align="center" ><a id='lblMounts'></a></td>
					<td align="center" ><a id='lblMemos'></a></td>
					<td align="center" ><a id='lblMount_undo'></a></td>
					<td align="center" ><a id='lblMount_unre'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>
					<td >
					<input class="txt c1" id="txtDodate.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtAddr_do.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtCasetype.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtAddr_get.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtCaseno.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtMount.*" type="text" style="text-align: right;"/>
					</td>
					<td >
					<input class="txt c1" id="txtMemo.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtMount_undo.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtMount_unre.*" type="text" />
					<input id="txtNoq.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
