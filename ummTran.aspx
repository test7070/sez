<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj.js' type="text/javascript"></script>
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
		    q_desc = 1
		    q_tables = 's';
		    var q_name = "umm";
		    var q_readonly = ['txtNoa', 'txtWorker', 'txtAccno', 'txtCno', 'txtAcomp'];
		    var q_readonlys = ['txtVccno', 'txtPart', 'txtPartno', 'txtUnpay', 'txtTypea'];
		    var bbmNum = new Array(['txtOutsource', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtOpay', 10, 0, 1], ['txtUnopay', 10, 0, 1], ['textOpay', 10, 0, 1]);
		    var bbsNum = [['txtMoney', 10, 0, 1], ['txtChgs', 10, 0,1], ['txtPaysale', 10, 0,1], ['txtUpay', 10, 0,1]];
		    var bbmMask = [];
		    var bbsMask = [];

		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'Datea';
		    aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
            ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
             ['txtAccc5_', 'btnAcc_', 'acc', 'acc1,acc2,acc7', 'txtAccc5_,txtAccc6_,txtAccc7_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno];
             ['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'],
             ['txtUmmaccno_', '', 'ummacc', 'noa,typea', 'txtUmmaccno_,txtTypea_', 'ummacc_b.aspx']);

		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();
		        q_gt(q_name, q_content, q_sqlCount, 1);
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
		        bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
		        q_mask(bbmMask);
		        bbsMask = [['txtIndate', r_picd], ['txtMon', r_picm]];

		        $('#btnAuto').click(function (e) {
		            var t_money, t_chgs, t_paysale, sum_money = 0, sum_chgs = 0, sum_paysale = 0;
		            for (var i = 0; i < q_bbsCount; i++) {
		                t_money = parseInt($.trim($('#txtMoney_' + i).val()).length == 0 ? '0' : $('#txtMoney_' + i).val().replace(/,/g, ''), 10);
		                if (t_money > 0)
		                    t_chgs = parseInt($.trim($('#txtChgs_' + i).val()).length == 0 ? '0' : $('#txtChgs_' + i).val().replace(/,/g, ''), 10);
		                else {
		                    t_chgs = 0;
		                    alert('');
		                }
		                $('#txtPaysale_' + i).val(0);
		                sum_money = sum_money + t_money;
		                sum_chgs = sum_chgs + t_chgs;
		            }

		        });

		        $('#txtCustno').change(function () {
		            var t_custno = $('#txtCustno').val();
                    q_gt("umm_opay", "where=^^custno='" + t_custno + "'^^", 1, 1, 0, '', r_accy);
                });
		        $('#btnTrd').click(function (e) {
		            if (q_cur == 1 || q_cur == 2) {
		                if ($.trim($('#txtCustno').val()) == 0) {
		                    alert('Please enter the customer no.');
		                    return false;
		                }
		                var t_custno = "'" + $.trim($('#txtCustno').val()) + "'";
		                t_where = "where=^^ custno=" + t_custno + " and unpay!=0 ";
		                t_where1 = " where[1]=^^ noa!='" + $('#txtNoa').val() + "' and ( 1=1 ";
		                for (var i = 0; i < q_bbsCount; i++) {
		                    if ($.trim($('#txtVccno_' + i).val()).length > 0) {
		                        t_where = t_where + "or noa='" + $('#txtVccno_' + i).val() + "'";
		                        t_where1 = t_where1 + "or vccno='" + $('#txtVccno_' + i).val() + "'";
		                    }
		                }
		                t_where = t_where + "^^";
		                t_where1 = t_where1 + ")^^";
		                q_gt('trd_umm', t_where + t_where1, 0, 0, 0, "", r_accy);
		            }
		        });
		        $('#btnVcctran').click(function (e) {
		            if (q_cur == 1 || q_cur == 2) {
		                if ($.trim($('#txtCustno').val()) == 0) {
		                    alert('Please enter the customer no.');
		                    return false;
		                }
		                var t_custno = "'" + $.trim($('#txtCustno').val()) + "'";
		                t_where = "where=^^ custno=" + t_custno + " and unpay!=0 ";
		                t_where1 = " where[1]=^^ noa!='" + $('#txtNoa').val() + "' and ( 1=1 ";
		                for (var i = 0; i < q_bbsCount; i++) {
		                    if ($.trim($('#txtVccno_' + i).val()).length > 0) {
		                        t_where = t_where + "or noa='" + $('#txtVccno_' + i).val() + "'";
		                        t_where1 = t_where1 + "or vccno='" + $('#txtVccno_' + i).val() + "'";
		                    }
		                }
		                t_where = t_where + "^^";
		                t_where1 = t_where1 + ")^^";
		                q_gt('vcc_umm', t_where + t_where1, 0, 0, 0, "", r_accy);
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
		            case 'umm_opay':
		                var as = _q_appendData('umm', '', true);
		                if (as.length > 0)
		                    $('#textOpay').val( round( as[0].total,0));
		                break;
		            case 'trd_umm':
		                var curData = new Array();
		                for (var i = 0; i < q_bbsCount; i++) {
		                    if ($('#txtVccno_' + i).val().length > 0) {
		                        curData.push({
		                            index: i,
		                            vccno: $('#txtVccno_' + i).val(),
		                            paysale: parseInt($.trim($('#txtPaysale_' + i).val()).length == 0 ? '0' : $('#txtPaysale_' + i).val().replace(/,/g, ''), 10)
		                        });
		                    }
		                }
		                var as = _q_appendData("trd", "", true);
		                for (var i = 0; i < as.length; i++) {
		                    as[i].total = parseInt($.trim(as[i].total).length == 0 ? '0' : as[i].total, 10);
		                    as[i].paysale = parseInt($.trim(as[i].paysale).length == 0 ? '0' : as[i].paysale, 10);
		                    for (var j = 0; j < curData.length; j++) {
		                        if (as[i].noa == curData[j].vccno) {
		                            as[i].paysale += curData[j].paysale;
		                        }
		                    }
		                    if (as[i].total - as[i].paysale == 0) {
		                        as.splice(i, 1);
		                        i--;
		                    } else {
		                        as[i]._unpay = (as[i].total - as[i].paysale).toString();
		                        as[i].total = as[i].total.toString();
		                        as[i].paysale = as[i].paysale.toString();
		                    }
		                }
		                q_gridAddRow(bbsHtm, 'tbbs', 'txtVccno,txtPaysale,txtUnpay', as.length, as, 'noa,_unpay,_unpay', 'txtVccno', '');
		                sum();
		                break;
		            case 'vcc_umm':
		                var curData = new Array();
		                for (var i = 0; i < q_bbsCount; i++) {
		                    if ($('#txtVccno_' + i).val().length > 0) {
		                        curData.push({
		                            index: i,
		                            vccno: $('#txtVccno_' + i).val(),
		                            paysale: parseInt($.trim($('#txtPaysale_' + i).val()).length == 0 ? '0' : $('#txtPaysale_' + i).val().replace(/,/g, ''), 10)
		                        });
		                    }
		                }
		                var as = _q_appendData("vcc", "", true);
		                for (var i = 0; i < as.length; i++) {
		                    as[i].total = parseInt($.trim(as[i].total).length == 0 ? '0' : as[i].total, 10);
		                    as[i].paysale = parseInt($.trim(as[i].paysale).length == 0 ? '0' : as[i].paysale, 10);
		                    for (var j = 0; j < curData.length; j++) {
		                        if (as[i].noa == curData[j].vccno) {
		                            as[i].paysale += curData[j].paysale;
		                        }
		                    }
		                    if (as[i].total - as[i].paysale == 0) {
		                        as.splice(i, 1);
		                        i--;
		                    } else {
		                        as[i]._unpay = (as[i].total - as[i].paysale).toString();
		                        as[i].total = as[i].total.toString();
		                        as[i].paysale = as[i].paysale.toString();
		                    }
		                }
		                q_gridAddRow(bbsHtm, 'tbbs', 'txtVccno,txtPaysale,txtUnpay', as.length, as, 'noa,_unpay,_unpay', 'txtVccno', '');
		                sum();
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
		        abbm[q_recno]['accno'] = xmlString;
		        $('#txtAccno').val(xmlString);
		    }

		    function btnOk() {
		        $('#txtWorker').val(r_name);
		        var isError = false, t_money, t_chgs, t_paysale, sum_money=0, sum_chgs=0, sum_paysale=0;
		        for (var i = 0; i < q_bbsCount; i++) {
		            $('#txtTypea_' + i).parent().parent().removeClass('error');

		            t_money = parseInt($.trim($('#txtMoney_' + i).val()).length == 0 ? '0' : $('#txtMoney_' + i).val().replace(/,/g, ''), 10);
		            t_chgs = parseInt($.trim($('#txtChgs_' + i).val()).length == 0 ? '0' : $('#txtChgs_' + i).val().replace(/,/g, ''), 10);
		            t_paysale = parseInt($.trim($('#txtPaysale_' + i).val()).length == 0 ? '0' : $('#txtPaysale_' + i).val().replace(/,/g, ''), 10);
		            sum_money = sum_money + t_money;
		            sum_chgs = sum_chgs + t_chgs;
		            sum_paysale = sum_paysale + t_paysale;


		            if ($.trim($('#txtTypea_' + i).val()).length == 0) {
		                if (t_money != 0 || t_chgs != 0 || t_paysale != 0) {
		                    isError = true;
		                    $('#txtTypea_' + i).parent().parent().addClass('error');
		                }
		            }
		        }
		        if (isError) {
		            alert('Please enter the type!');
		            return false;
		        }
		        alert((sum_money + sum_chgs) + "--" + sum_paysale);
                if (sum_money + sum_chgs < sum_paysale) {
		            alert('�T��s�ɡG���ڪ��B + �O�� > �R�b���B');
		            return false;
		        }

		        $('#txtWorker').val(r_name);
		        sum();

		        var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ummtran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;

		        q_box('umm_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
		    }

		    function combPay_chg() {
		    }

		    function bbsAssign() {
		        _bbsAssign();
		        for (var i = 0; i < q_bbsCount; i++) {
		            /*Money*/
		            if (typeof ($('#txtMoney_' + i).data('info')) == 'undefined')
		                $('#txtMoney_' + i).data('info', {
		                    isSetChange: false
		                });
		            if (typeof ($('#txtMoney_' + i).data('info').isSetChange) == 'undefined')
		                $('#txtMoney_' + i).data('info').isSetChange = false;
		            if (!$('#txtMoney_' + i).data('info').isSetChange) {
		                $('#txtMoney_' + i).data('info').isSetChange = true;
		                $('#txtMoney_' + i).change(function (e) {
		                    sum();
		                });
		            }
		            /*Chgs*/
		            if (typeof ($('#txtChgs_' + i).data('info')) == 'undefined')
		                $('#txtChgs_' + i).data('info', {
		                    isSetChange: false
		                });
		            if (typeof ($('#txtChgs_' + i).data('info').isSetChange) == 'undefined')
		                $('#txtChgs_' + i).data('info').isSetChange = false;
		            if (!$('#txtChgs_' + i).data('info').isSetChange) {
		                $('#txtChgs_' + i).data('info').isSetChange = true;
		                $('#txtChgs_' + i).change(function (e) {
		                    sum();
		                });
		            }
		            /*Paysale*/
		            if (typeof ($('#txtPaysale_' + i).data('info')) == 'undefined')
		                $('#txtPaysale_' + i).data('info', {
		                    isSetChange: false
		                });
		            if (typeof ($('#txtPaysale_' + i).data('info').isSetChange) == 'undefined')
		                $('#txtPaysale_' + i).data('info').isSetChange = false;
		            if (!$('#txtPaysale_' + i).data('info').isSetChange) {
		                $('#txtPaysale_' + i).data('info').isSetChange = true;
		                $('#txtPaysale_' + i).change(function (e) {
		                    sum();
		                });
		            }
		        }
		    }

		    function btnIns() {
		        _btnIns();
		        $('#txtNoa').val('AUTO');
		        $('#txtDatea').val(q_date());
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
		            return;
		        _btnModi();
		    }

		    function btnPrint() {

		    }

		    function wrServer(key_value) {
		        var i;

		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);

		    }

		    function bbsSave(as) {
		        if (!as['typea']) {
		            as[bbsKey[1]] = '';
		            return;
		        }

		        q_nowf();

		        return true;
		    }

		    function sum() {
		        var t_money = 0, t_pay = 0;
		        for (var j = 0; j < q_bbsCount; j++) {
		            t_money += parseInt($.trim($('#txtMoney_' + j).val()).length == 0 ? '0' : $('#txtMoney_' + j).val().replace(/,/g, ''), 10);
		            t_money += parseInt($.trim($('#txtChgs_' + j).val()).length == 0 ? '0' : $('#txtChgs_' + j).val().replace(/,/g, ''), 10);
		            t_pay += parseInt($.trim($('#txtPaysale_' + j).val()).length == 0 ? '0' : $('#txtPaysale_' + j).val().replace(/,/g, ''), 10);
		        }
		        $('#txtTotal').val(t_money);
		        $('#txtPaysale').val(t_pay);
		        $('#txtUnpay').val(t_money - t_pay);
		    }

		    function refresh(recno) {
		        _refresh(recno);
		        var t_custno = $('#txtCustno').val();
		        q_gt("umm_opay", "where=^^custno='" + t_custno + "'^^", 1, 1, 0, '', r_accy);
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
                width: 18%;
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
                width: 80%;
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
                width: 48%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
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
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:28%"><a id='vewDatea'></a></td>
						<td align="center" style="width:38%"><a id='vewComp'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp,4'>~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1" ><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2" >
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td4" >
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td class="td5" ><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td6">
						<input id="txtMon" type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblPayc' class="lbl"></a></td>
						<td class="td8">
						<input id="txtPayc" type="text" class="txt c1"/>
						</td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr2">
						<td class="td1" ><span> </span><a id='lblAcomp' class="lbl btn"></a></td>
						<td class="td2" >
						<input id="txtCno"  type="text" class="txt c4"/>
						<input id="txtAcomp"    type="text" class="txt c5"/>
						</td>
						<td class="td3"><span> </span><a id='lblCust' class="lbl btn"></a></td>
						<td class="td4" colspan="2">
						<input id="txtCustno" type="text" class="txt c4"/>
						<input id="txtComp"  type="text" class="txt c5"/>
						</td>
						<td class="7">
						<input type="button" id="btnTrd" class="txt c1 " />
						</td>
						<td class="8">
						<input type="button" id="btnVcctran" class="txt c1 " />
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblOutsource' class="lbl"></a></td>
						<td class="td2">
						<input id="txtOutsource"  type="text" class="txt num c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblTotal' class="lbl"></a></td>
						<td class="td4">
						<input id="txtTotal" type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblPaysale' class="lbl"></a></td>
						<td class="td6">
						<input id="txtPaysale"  type="text" class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblUnpay' class="lbl"></a></td>
						<td class="td8">
						<input id="txtUnpay"  type="text" class="txt num c1"/>
						</td>
					</tr>  
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblOpay' class="lbl"></a></td>
						<td class="td2">
						<input id="txtOpay"  type="text" class="txt num c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblUnopay' class="lbl"></a></td>
						<td class="td4">
						<input id="txtUnopay"  type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblTextopay' class="lbl"></a></td>
						<td class="td6">
						<input id="textOpay"  type="text" class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblAccno' class="lbl"></a></td>
						<td class="td8">
						<input id="txtAccno"  type="text" class="txt c1"/>
						</td>

					</tr>
					<tr class="tr5">
						<td class="td1"><input type="button" id="btnAuto" class="txt c1 "  style="width: 70%;"/> <a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan='3' >	<textarea id="txtMemo"  rows='3' style="width: 99%; height: 50px;" ></textarea></td>
						<td class="td5"><a id='lblWorker' class="lbl"></a></td>
						<td class="td6" >
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblApv' class="lbl"></a></td>
						<td class="td8" >
						<input id="txtApv"  type="text" class="txt c1" disabled = "disabled"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblChecker" class="lbl"></a></td>
						<td class="td2">
						<input id="txtchecker" type="text" class="txt c2"/>
						<input id="txtCheckermemo"  type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id="lblApprov" class="lbl"></a></td>
						<td class="td4">
						<input id="txtApprov"  type="text" class="txt c2"/>
						<input id="txtApprovmemo"  type="text" class="txt c3"/>
						</td>
						<td class="td5"><span> </span><a id="lblApprove"class="lbl"></a></td>
						<td class="td6">
						<input id="txtApprove"  type="text" class="txt c2"/>
						<input id="txtApprovememo"  type="text" class="txt c3"/>
						</td>
						<td class="td7"><span> </span><a id="lblApprove2"class="lbl"></a></td>
						<td class="td8">
						<input id="txtApprove2"  type="text" class="txt c2"/>
						<input id="txtApprove2memo"  type="text" class="txt c3"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:3%;"><a id='lblAcc1'></a></td>
					<td align="center" style="width:3%;"><a id='lblMoney'></a></td>
					<td align="center" style="width:3%;"><a id='lblChgs'></a></td>
					<td align="center" style="width:5%;"><a id='lblCheckno'></a></td>
					<td align="center" style="width:5%;"><a id='lblAccount'></a></td>
					<td align="center" style="width:7%;"><a id='lblBank'></a></td>
					<td align="center" style="width:3%;"><a id='lblIndate'></a></td>
					<td align="center" style="width:4%;"><a id='lblMemos'></a></td>
					<td align="center" style="width:3%;"><a id='lblPaysales'></a></td>
					<td align="center" style="width:5%;"><a id='lblVccno'></a></td>
					<td align="center" style="width:3%;"><a id='lblUnpay_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblPart'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input type="button" id="btnMinus.*"  value='-' style=" font-weight: bold;" />
					<input type="text" id="txtNoq.*" style="display:none;" />
					</td>
					<td>
						<input type="text" id="txtAcc1.*"  style="float:left;width:25%;"/>
						<input type="text" id="txtAcc2.*"  style="float:left;width:55%;"/>
					</td>
					<td>
					<input type="text" id="txtMoney.*" style="text-align:right;width:95%;"/>
					</td>
					<td>
					<input type="text" id="txtChgs.*" style="text-align:right;width:95%;"/>
					</td>
					<td>
					<input type="text" id="txtCheckno.*"  style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtAccount.*"  style="width:95%;" />
					</td>
					<td>
					<input type="button" id="btnBankno.*"  style="float:left;width:7%;" value="."/>
					<input type="text" id="txtBankno.*"  style="float:left;width:35%;" />
					<input type="text" id="txtBank.*" style="float:left;width:40%;"/>
					</td>
					<td>
					<input type="text" id="txtIndate.*" style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtMemo.*" style="width:95%;"/>
					</td>
  					<td>
					<input type="text" id="txtPaysale.*" style="text-align:right;width:95%;"/>
					</td>
					<td>
					<input type="text" id="txtVccno.*" style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtUnpay.*"  style="width:95%; text-align: right;" />
					</td>
					<td>
					<input type="text" id="txtPart.*"  style="float:left;width: 95%;"/>
					</td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
