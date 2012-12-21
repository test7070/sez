﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
            var q_name = "vcca";
            var q_readonly = ['txtMoney', 'txtTotal', 'txtChkno', 'txtTax', 'txtAccno', 'txtWorker'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 15, 0], ['txtTax', 15, 0], ['txtTotal', 15, 0]];
            var bbsNum = [['txtMount', 15, 3], ['txtGmount', 15, 4], ['txtEmount', 15, 4], ['txtPrice', 15, 3], ['txtTotal', 15, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtComp2', 'acomp_b.aspx'], ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,zip_invo,addr_invo,serial', 'txtCustno,txtComp,txtNick,txtZip,txtAddress,txtSerial', 'cust_b.aspx'], ['txtBuyerno', 'lblBuyer', 'cust', 'noa,comp', 'txtBuyerno,txtBuyer', 'cust_b.aspx'], ['txtProductno_', 'btnProductno_', 'ucca', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucca_b.aspx']);
            q_xchg = 1;
            brwCount2 = 20;

            function currentData() {
            }


            currentData.prototype = {
                data : [],
                /*新增時複製的欄位*/
                include : ['txtDatea', 'txtCno', 'txtComp2', 'txtCustno', 'txtComp', 'txtNick', 'txtSerial', 'txtAddress', 'txtMon', 'txtNoa', 'txtBuyerno', 'txtBuyer'],
                /*記錄當前的資料*/
                copy : function() {
                    curData.data = new Array();
                    for (var i in fbbm) {
                        var isInclude = false;
                        for (var j in curData.include) {
                            if (fbbm[i] == curData.include[j]) {
                                isInclude = true;
                                break;
                            }
                        }
                        if (isInclude) {
                            curData.data.push({
                                field : fbbm[i],
                                value : $('#' + fbbm[i]).val()
                            });
                        }
                    }
                },
                /*貼上資料*/
                paste : function() {
                    for (var i in curData.data) {
                        $('#' + curData.data[i].field).val(curData.data[i].value);
                    }
                }
            };
            var curData = new currentData();

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
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm],['txtSerial','99999999']];
                q_mask(bbmMask);
                q_cmbParse("cmbTaxtype", ('').concat(new Array('1@應稅', '2@零稅率', '3@內含', '4@免稅', '5@自訂', '6@作廢')));
                $('#cmbTaxtype').focus(function() {
                    var len = $("#cmbTaxtype").children().length > 0 ? $("#cmbTaxtype").children().length : 1;
                    $("#cmbTaxtype").attr('size', len + "");
                }).blur(function() {
                    $("#cmbTaxtype").attr('size', '1');
                }).change(function(e) {
                    sum();
                }).click(function(e) {
                    sum();
                });
                $('#txtTax').change(function() {
                    sum();
                });
                $('#txtSerial').change(function(e) {
                    $('#txtSerial').val($.trim($('#txtSerial').val()));
                    if($('#txtSerial').val().length>0 && checkId($('#txtSerial').val())==0)
                    	alert(q_getMsg('lblSerial')+'錯誤。');
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {/// 重要：不可以直接 return ，最後需執行 originalClose();
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'vccar':
                        var as = _q_appendData("vccar", "", true);
                        if (as[0] == undefined) {
                            alert("發票本數不存在或已輸入過");
                        } else {
                            var vccars = _q_appendData("vccars", "", true);
                            if (vccars[0] != undefined) {
                                for (var i = 0; i < vccars.length; i++) {
                                    if (vccars[i].binvono <= $('#txtNoa').val() && vccars[i].einvono >= $('#txtNoa').val()) {
                                        wrServer($('#txtNoa').val());
                                        return;
                                    }
                                }
                            } else {
                                alert("發票號碼資料錯誤");
                                break;
                            }
                            alert("發票號碼超出範圍");
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)// 查詢
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
                $('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
                }                            
                $('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val()))
                    alert(q_getMsg('lblMon')+'錯誤。');
                $('#txtNoa').val($.trim($('#txtNoa').val()));
                if ($('#txtNoa').val().length > 0 && !(/^[a-z,A-Z]{2}[0-9]{8}$/g).test($('#txtNoa').val()))
                    alert(q_getMsg('lblNoa')+'錯誤。');
                $('#txtSerial').val($.trim($('#txtSerial').val()));
                if ($('#txtSerial').val().length > 0 && checkId($('#txtSerial').val())==0)
                    alert(q_getMsg('lblSerial')+'錯誤。');
                sum();
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCno', q_getMsg('lblAcomp')]]);
                // 檢查空白
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                if (q_cur == 1) {
                    //判斷發票號碼是否存在或超過
                    var t_where = "where=^^ cno = '" + $('#txtCno').val() + "' and bdate<='" + $('#txtDatea').val() + "' and edate>='" + $('#txtDatea').val()//判斷發票的日期
                    + "' and '" + $('#txtNoa').val() + "' not in (select noa from vcca ) and len(binvono)=len('" + $('#txtNoa').val() + "') ^^";
                    //判斷是否已存在與長度是否正確
                    q_gt('vccar', t_where, 0, 0, 0, "", r_accy);
                } else {
                    wrServer($('#txtNoa').val());
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('vcca_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function bbsAssign() {/// 表身運算式
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtMount_' + j).change(function() {
                            sum();
                        });
                        $('#txtPrice_' + j).change(function() {
                            sum();
                        });
                        $('#txtMoney_' + j).change(function() {
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                curData.copy();
                _btnIns();
                curData.paste();

                //發票號碼+1
                var t_noa = trim($('#txtNoa').val());
                var str = '00000000' + (parseInt(t_noa.substring(2, 10)) + 1);
                str = str.substring(str.length - 8, str.length);
                t_noa = t_noa.substring(0, 2) + str;
                $('#txtNoa').val(t_noa);

                $('#cmbTaxtype').val(1);
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('#txtNoa').attr('readonly', true);
                //讓發票號碼不可修改

            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
                if (!as['productno'] && !as['product']) {//不存檔條件
                    as[bbsKey[1]] = '';
                    /// no2 為空，不存檔
                    return;
                }

                q_nowf();

                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                $('#txtTax').attr('readonly', 'readonly');
                var t_mounts, t_prices, t_moneys, t_mount = 0, t_money = 0, t_taxrate, t_tax, t_total;

                for (var k = 0; k < q_bbsCount; k++) {
                    t_mounts = q_float('txtMount_' + k);
                    t_prices = q_float('txtPrice_' + k);
                    t_moneys = round(t_mounts * t_prices, 0);
                    $('#txtMoney_' + k).val(t_moneys);
                    t_money += t_moneys;
                    t_mount += t_mounts;
                }

                t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
                switch ($('#cmbTaxtype').val()) {
                    case '1':
                        // 應稅
                        t_tax = round(t_money * t_taxrate, 0);
                        t_total = t_money + t_tax;
                        break;
                    case '2':
                        //零稅率
                        t_tax = 0;
                        t_total = t_money + t_tax;
                        break;
                    case '3':
                        // 內含
                        t_tax = round(t_money / (1 + t_taxrate) * t_taxrate, 0);
                        t_total = t_money;
                        t_money = t_total - t_tax;
                        break;
                    case '4':
                        // 免稅
                        t_tax = 0;
                        t_total = t_money + t_tax;
                        break;
                    case '5':
                        // 自定
                        $('#txtTax').removeAttr('readonly');
                        t_tax = round(q_float('txtTax'), 0);
                        t_total = t_money + t_tax;
                        break;
                    case '6':
                        // 作廢-清空資料
                        $('#txtCustno').val('');
                        //銷貨客戶
                        $('#txtCustno').attr('readonly', true);
                        $('#txtComp').val('');
                        $('#txtComp').attr('readonly', true);
                        $('#txtSerial').val('');
                        //統一編號
                        $('#txtSerial').attr('readonly', true);
                        $('#txtMoney').val(0);
                        //產品金額
                        $('#txtMoney').attr('readonly', true);
                        $('#txtMon').val('');
                        //帳款月份
                        $('#txtMon').attr('readonly', true);
                        $('#txtTax').val(0);
                        //營業稅
                        $('#txtTax').attr('readonly', true);
                        $('#txtTotal').val(0);
                        //總計
                        $('#txtTotal').attr('readonly', true);
                        $('#txtChkno').val('');
                        //檢查號碼
                        $('#txtChkno').attr('readonly', true);
                        $('#txtAccno').val('');
                        //轉會計傳票編號
                        $('#txtAccno').attr('readonly', true);
                        $('#txtBuyerno').val('');
                        //買受人
                        $('#txtBuyerno').attr('readonly', true);
                        $('#txtBuyer').val('');
                        //
                        $('#txtBuyer').attr('readonly', true);
                        $('#txtMemo').val('');
                        //發票備註
                        break;
                    default:
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
                $('#txtNoa').attr('readonly', 'readonly');
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
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 1080px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
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
                width: 1080px;
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
                width: 1080px;
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
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNick'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTax'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTotal'> </a></td>
						<td align="center" style="width:200px; color:black;"><a id='vewMemo'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='nick' style="text-align: left;">~nick</td>
						<td id='money,0,1' style="text-align: right;">~money,0,1</td>
						<td id='tax,0,1' style="text-align: right;">~tax,0,1</td>
						<td id='total,0,1' style="text-align: right;">~total,0,1</td>
						<td id='memo' style="text-align: left;">~memo</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td><td><td><td><td><td><td><td><td><td><td><td><td><td><td><td><td class="tdZ"><td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCno" type="text" style="float:left; width:15%;">
						<input id="txtComp2" type="text" style="float:left; width:85%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td>
						<input id="txtMon"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCustno" type="text" style="float:left; width:30%;">
						<input id="txtComp" type="text" style="float:left; width:70%;"/>
						<input id="txtNick" type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddress' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip" type="text" style="float:left; width:10%;"/>
							<input id="txtAddress" type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td>
						<input id="txtMoney"  type="text"  class="txt num c1"/>
						</td>
						<td><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
						<td><select id="cmbTaxtype" class="txt c1" ></select></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
						<input id="txtTax"  type="text"  class="txt num c1"/>
						</td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td>
						<input id="txtTotal"  type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td>
						<input id="txtSerial" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblBuyer' class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtBuyerno"  type="text"  style="float:left; width:30%;"/>
						<input id="txtBuyer" type="text"  style="float:left; width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan='5'>
						<input id="txtMemo"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblChkno' class="lbl"> </a></td>
						<td>
						<input id="txtChkno"  type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblAccno' class="lbl"> </a></td>
						<td>
						<input id="txtAccno"  type="text" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:80px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProduct'> </a></td>
					<td align="center" style="width:30px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotals'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemos'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
					<input id="txtProductno.*" type="text" style="float:left;width: 80%;"/>
					<input id="btnProductno.*" type="button" value=".." style="float:left;width: 15%;"/>
					</td>
					<td>
					<input id="txtProduct.*" type="text" style="float:left;width: 95%;"/>
					</td>
					<td>
					<input id="txtUnit.*" type="text" style="float:left;width: 95%;"/>
					</td>
					<td>
					<input id="txtMount.*" type="text" style="float:left;width: 95%; text-align: right;"/>
					</td>
					<td>
					<input id="txtPrice.*" type="text" style="float:left;width: 95%; text-align: right;"/>
					</td>
					<td>
					<input id="txtMoney.*" type="text" style="float:left;width: 95%; text-align: right;"/>
					</td>
					<td>
					<input id="txtMemo.*" type="text" style="float:left;width: 95%;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>