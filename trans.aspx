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

            var decbbm = ['mount', 'price', 'price2', 'price3', 'discount', 'miles', 'reserve', 'tolls', 'ticket', 'gross', 'weight', 'plus', 'minus', 'mount2', 'total', 'overw', 'overh', 'total2', 'commission', 'gps', 'pton', 'pton2', 'unpack', 'dhirdprice'];
            var q_name = "trans";
            var q_readonly = [];
            var bbmNum = new Array(['txtUnpack', 10, 0], ['txtMount', 10, 0], ['txtPrice', 10, 2], ['txtPrice2', 10, 2], ['txtPrice3', 10, 2], ['txtDiscount', 10, 0], ['miles', 10, 2], ['txtReserve', 10, 0], ['tolls', 10, 0], ['txtTicket', 10, 0], ['txGross', 10, 2], ['txtWeight', 10, 2], ['txtPlus', 10, 0], ['txtMius', 10, 0], ['txtMount2', 10, 2], ['txtTotal', 10, 0], ['txtOverw', 10, 0], ['txtOverH', 10, 0], ['txtTotal2', 10, 0], ['txtCommission', 10, 0], ['txtGps', 10, 0], ['txtPton', 10, 2], ['txtPton2', 10, 2]);
            var bbmMask = new Array(['txtKdate', '999/99/99'], ['txtDatea', '999/99/99'], ['txtBilldate', '999/99/99']);
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver,cardealno,cardeal', 'txtCarno,txtDriverno,txtDriver,txtCardealno,txtCardeal', 'car2_b.aspx'], ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx'], ['txtAddno1', 'lblAdd1', 'addr', 'noa,addr', 'txtAddno1,txtAdd1', 'addr_b.aspx'], ['txtAddno2', 'lblAdd2', 'addr', 'noa,addr', 'txtAddno2,txtAdd2', 'addr_b.aspx'], ['txtAddno3', 'lblAdd3', 'addr', 'noa,addr', 'txtAddno3,txtAdd3', 'addr_b.aspx'], ['txtAddno4', 'lblAdd4', 'addr', 'noa,addr', 'txtAddno4,txtAdd4', 'addr_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtSales', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtWorker', 'lblWorker', 'sss', 'noa,name', 'txtWorkerno,txtWorker', 'sss_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];

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
                $('#txtNoa').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtComp').focus();
            }

            function btnPrint() {

            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);

                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());

                if($("#cmbCalctype").val() == '6')
                    $("#txtPrice2").val(0);
                else
                    $("#txtPrice3").val(0);

                if(t_noa.length == 0)
                    q_gtnoa(q_name, t_noa);
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
                /*border: 1px white double;
                 border-spacing: 0;
                 border-collapse: collapse;*/
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
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
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%;"><a id='vewChk'></a></td>
						<td align="center" style="width:20%;"><a id='vewNoa'></a></td>
						<td align="center" style="width:20%;"><a id='vewComp'></a></td>
						<td align="center" style="width:15%;"><a id='vewCarno'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='comp,4'>~comp,4</td>
						<td align="center" id='carno'>~carno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm" >
					<tr class="tr1">
						<td class="td1" ><span> </span><a id="lblKdate" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtKdate" type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
						<td class="td5" ><span> </span><a id="lblCarno" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtCarno" type="text"  class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblCustorde" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtCustorde" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1" ><span> </span><a id="lblDriver" class="lbl btn"></a></td>
						<td class="td2" >
						<input id="txtDriverno" type="text"  style='width:35%; float:left;'/>
						<input id="txtDriver" type="text"  style='width:65%; float:left;'/>
						</td>
						<td class="td3" ><span> </span><a id="lblCust" class="lbl btn"></a></td>
						<td class="td4" colspan="3">
						<input id="txtCustno" type="text"  style='width:25%; float:left;'/>
						<input id="txtComp" type="text"  style='width:75%; float:left;'/>
						</td>
						<td class="td5" ><span> </span><a id="lblCalctype" class="lbl"></a></td>
						<td class="td6" ><select id="cmbCalctype" class="txt c1"></select></td>
						
					</tr>
					<tr class="tr3">
						<td class="td1" ><span> </span><a id="lblAdd1" class="lbl btn"></a></td>
						<td class="td2">
						<input id="txtAddno1" type="text"  class="txt c2"/>
						<input id="txtAdd1" type="text"  class="txt c3"/>
						</td>
						<td class="td3" ><span> </span><a id="lblAdd2" class="lbl btn"></a></td>
						<td class="td4">
						<input id="txtAddno2" type="text" class="txt c2"/>
						<input id="txtAdd2" type="text"  class="txt c3"/>
						</td>
						<td class="td5" ><span> </span><a id="lblAdd3" class="lbl btn"></a></td>
						<td class="td6">
						<input id="txtAddno3" type="text" class="txt c2"/>
						<input id="txtAdd3" type="text"  class="txt c3"/>
						</td>
						<td class="td7" ><span> </span><a id="lblAdd4" class="lbl btn"></a></td>
						<td class="td8">
						<input id="txtAddno4" type="text"  class="txt c2"/>
						<input id="txtAdd4" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td3" ><span> </span><a id="lblUcc" class="lbl btn"></a></td>
						<td class="td4" >
						<input id="txtUccno" type="text"  class="txt c2"/>
						<input id="txtProduct" type="text"  class="txt c3"/>
						</td>
						
						
					</tr>
					<tr class="tr5">
						<td class="td1" ><span> </span><a id="lblMount" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtMount" type="text"  class="txt num c4"/>
						<select id="cmbUnit" class="txt c5" style="margin: -1px -2px 0px 2px;"></select></td>
						<td class="td3" ><span> </span><a id="lblPrice" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtPrice" type="text"  class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblTotal" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtTotal" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1" ><span> </span><a id="lblMount2" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtMount2" type="text"  class="txt num c4"/>
						<select id="cmbUnit2" class="txt c5"  style="margin: -1px -2px 0px 2px;"></select></td>
						<td class="td3" ><span> </span><a id="lblPrice2" class="lbl"></a><span> </span><a id="lblPrice3" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtPrice2" type="text"  class="txt num c1"/>
						<input id="txtPrice3" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1" ><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtNoa" type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblCaseno" class="lbl"></a></td>
						<td class="td4" colspan="3">
						<input id="txtCaseno" type="text"  style='width:50%; float:left;'/>
						<input id="txtCaseno2" type="text"  style='width:50%; float:left;'/>
						<td class="td7" ><span> </span><a id="lblTtype" class="lbl"></a></td>
						<td class="td8" ><select id="cmbTtype" class="txt c1"></select></td>
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1" ><span> </span><a id="lblPo" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtPo" type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblGross" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtGross" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" ><span> </span><a id="lblWeight" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtWeight" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr9">
						<td class="td1" ><span> </span><a id="lblTolls" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtTolls" type="text" class="txt num c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblReserve" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtReserve" type="text" class="txt num c1"/>
						</td>
						<td class="td5" ><span> </span><a id="lblMiles" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtMiles" type="text"  class="txt num c1"/>
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
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id="lblLtime" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtLtime" type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblStime" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtStime" type="text"  class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblDtime" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtDtime" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr12">
						<td class="td1" ><span> </span><a id="lblCarteam" class="lbl"></a></td>
						<td class="td2" ><select id="cmbCarteamno" class="txt c1"></select></td>
						<td class="td3" ><span> </span><a id="lblCardeal" class="lbl btn"></a></td>
						<td class="td4" colspan="3">
						<input id="txtCardealno" type="text"  style='width:25%; float:left;'/>
						<input id="txtCardeal" type="text"  style='width:75%; float:left;'/>
						</td>
					    <td class="td7" ><span> </span><a id="lblGps" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtGps" type="text"  class="txt num c1"/>
						</td>
					</tr>				
					<tr class="tr13">
						<td class="td1" ><span> </span><a id="lblSales" class="lbl btn"></a></td>
						<td class="td2">
						<input id="txtSalesno" type="text"  class="txt c2"/>
						<input id="txtSales" type="text"  class="txt c3"/>
						</td>
						<td class="td3" ><span> </span><a id="lblWorker" class="lbl btn"></a></td>
						<td class="td4">
						<input id="txtWorkerno" type="text"  class="txt c2"/>
						<input id="txtWorker" type="text"  class="txt c3"/>
						</td>
						<td class="td5"><span> </span><a id="lblThird" class="lbl"></a></td>
						<td class="td6">
						<input id="txtThird" type="text" class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblThirdprice" class="lbl"></a></td>
						<td class="td8">
						<input id="txtThirdprice" type="text" class="txt num c1" />
						</td>
						
					</tr>
					<tr class="tr14">
						<td class="td1" ><span> </span><a id="lblOrdeno" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtOrdeno" type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblUnpack" class="lbl"></a></td>
						<td class="td4">
						<input id="txtUnpack" type="text"  class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblPton" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtPton" type="text"  class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblPton2" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtPton2" type="text"  class="txt num c1"/>
						</td>	
					</tr>
					<tr class="tr15">
						<td class="td1" ><span> </span><a id="lblDiscount" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtDiscount" type="text" class="txt num c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblSo" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtSo" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr16">
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
						<td class="td7" ><span> </span><a id="lblCldate" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtCldate" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr17">
						<td class="td1"><span> </span><a id="lblFill" class="lbl"></a></td>
						<td class="td2">
						<input id="txtFill" type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblCaseend" class="lbl"></a></td>
						<td class="td4">
						<input id="txtCaseend" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblStatus" class="lbl"></a></td>
						<td class="td6">
						<input id="txtStatus" type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblBilldate" class="lbl"></a></td>
						<td class="td8">
						<input id="txtBilldate" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr18">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
						<td class="td2" colspan='7'>						<textarea id="txtMemo" style="width:100%; height: 127px;"></textarea></td>
					</tr>
						
						
					<tr class="tr19">
						<td class="td1"><span> </span><a id="lblOverw" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtOverw" type="text"  class="txt num c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblOverh" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtOverh" type="text"  class="txt num c1"/>
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
					<tr class="tr20">
						<td class="td1"><span> </span><a id="lblUmmbno" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtUmmbno" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblUmmno" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtUmmno" type="text"  class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblPaybno" class="lbl" style="font-size: 12px;"></a></td>
						<td class="td6" >
						<input id="txtPaybno" type="text"  class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblPayno" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtPayno" type="text"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
