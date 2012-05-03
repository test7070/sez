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

            q_tables = 's';
            var q_name = "borr";
            var decbbm = ['payc', 'taxrate', 'tax', 'cash', 'checka', 'money', 'rate', 'inteis', 'bwmoney', 'pay'];
            var decbbs = ['money'];
            var q_readonly = ['txtBwmoney', 'txtPay'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['money', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtDriverno', 'btnDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtCustno', 'btnCust', 'cust', 'noa,nick', 'txtCustno,txtCust', 'cust_b.aspx'])

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }

                q_mask(bbmMask);

                mainForm(0);
            }///  end Main()

            function mainPost() {
                fbbm[fbbm.length] = 'txtMemo';
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                q_cmbParse("cmbTypea", q_getPara('borr.typea'), 's');

                $("#txtPayc").change(function() {
                    sum();
                });
                $("#cmbTaxtype").change(function() {
                    sum();
                });
                $("#txtTaxrate").change(function() {
                    sum();
                });
            }

            function pop(form, seq) {
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

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
            }

            function btnIns() {
                _btnIns();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            }

            function btnOk() {
                var t_err = '';

                //  t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);
                var t_noa = $.trim($('#txtNoa').val());
                //  alert(t_noa+'  '+t_noa.length);
                //  if(t_noa.length == 0)
                //    q_gtnoa(q_name, t_noa);
                //else

                wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
                if(!as['checkno']) {//不存檔條件
                    as[bbsKey[1]] = '';
                    /// noq 為空，不存檔
                    return;
                }

                q_nowf();
                as['noa'] = abbm2['noa'];

                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                if(q_cur > 0 && q_cur < 4)
                    sum();
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

            function bbsAssign() {
                _bbsAssign();

                for(var j = 0; j < q_bbsCount; j++) {
                    $("#txtMoney_" + j).change(function(e) {
                        sum();
                    });
                }
            }

            function sum() {
                switch($("#cmbTaxtype").val()) {
                    case '1':
                        //extra
                        $("#txtTax").val(Math.round($("#txtPayc").val() * $("#txtTaxrate").val() / 100, 0));
                        break;
                    case '3':
                        //include  
                        $("#txtTax").val($("#txtPayc").val() - Math.round($("#txtPayc").val() / (1 + $("#txtTaxrate").val() / 100), 0));
                        break;
                    case '5':
                        //custom
                        $("#txtTaxrate").val(0);
                        break;
                    default:
                        $("#txtTax").val(0);
                }

                var inMoney = 0;
                var outMoney = 0;
                for(var i = 0; i < q_bbsCount; i++) {
                    if($("#cmbTypea_" + i).val() == '1')
                        outMoney += $("#txtMoney_" + i).val();
                    else
                        inMoney += $("#txtMoney_" + i).val();
                }
                $("#txtBwmoney").val(outMoney);
                $("#txtPay").val(inMoney);
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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
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
            .tbbm tr .td1, .tbbm tr .td3, .tbbm tr .td5, .tbbm tr .td7 {
                width: 10%;
            }
            .tbbm tr .td2, .tbbm tr .td4, .tbbm tr .td6, .tbbm tr .td8 {
                width: 10%;
            }
            .tbbm tr .td9 {
                width: 3%;
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
            .tbbm tr td .txt.num {
                text-align: right;
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
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td{
            	text-align: center;
                border: 2px lightgrey double;
            }

            .dbbm input[type="button"] {
                float: right;
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
            
            .tbbm tr td select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewDatea'></a></td>
						<td align="center" style="width:25%"><a id='vewCarno'></a></td>
						<td align="center" style="width:25%"><a id='vewCust'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='carno'>~carno</td>
						<td align="center" id='cust'>~cust</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1" ><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td class="td2">
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td4">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td class="td5"></td>
						<td class="td6"></td>
						<td class="td9"></td>
					</tr>
					<tr class="tr2">
						<td class="td1" ><span> </span><a id="lblCarno" class="lbl"></a></td>
						<td class="td2">
						<input id="txtCarno"  type="text" class="txt c1"/>
						</td>
						<td class="td3" >
						<input id="btnDriver" type="button"/>
						</td>
						<td class="td4">
						<input id="txtDriverno"  type="text"  class="txt c2"/>
						<input id="txtDriver"  type="text"  class="txt c3"/>
						</td>
						<td class="td5" >
						<input id="btnCust" type="button"/>
						</td>
						<td class="td6">
						<input id="txtCustno"  type="text"  class="txt c2"/>
						<input id="txtCust"  type="text" class="txt c3"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1" ><span> </span><a id="lblPayc" class="lbl"></a></td>
						<td class="td2">
						<input id="txtPayc"  type="text"  class="txt c1 num"/>
						</td>
						<td class="td3" ><span> </span><a id="lblTaxtype" class="lbl"></a></td>
						<td class="td4"><a id="lblTaxrate" style="float: right; width:10%;"></a><select id="cmbTaxtype"  class="txt c2"></select>
						<input id="txtTaxrate"  type="text"  class="txt c2 num"/>
						</td>
						<td class="td5" ><span> </span><a id="lblTax" class="lbl"></a></td>
						<td class="td6">
						<input id="txtTax"  type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblCash" class="lbl"></a></td>
						<td class="td2">
						<input id="txtCash"  type="text" class="txt c1 num" />
						</td>
						<td class="td3"><span> </span><a id="lblChecka" class="lbl"></a></td>
						<td class="td4">
						<input id="txtChecka"  type="text" class="txt c1 num" />
						</td>
						<td class="td5" ><span> </span><a id="lblMoney" class="lbl"></a></td>
						<td class="td6">
						<input id="txtMoney" type="text" class="txt c1 num" />
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblBegindate" class="lbl"></a></td>
						<td class="td2">
						<input id="txtBegindate" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblEnddate" class="lbl"></a></td>
						<td class="td4">
						<input id="txtEnddate" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblRate" class="lbl"></a></td>
						<td class="td6">
						<input id="txtRate" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblDays" class="lbl"></a></td>
						<td class="td2">
						<input id="txtDays"  type="text" class="txt c1" />
						</td>
						<td class="td3" ><span> </span><a id="lblInteis" class="lbl"></a></td>
						<td class="td4">
						<input id="txtInteis" type="text" class="txt c1 num" />
						</td>
						<td class="td5" >
						<input id="btnBorrowt" type="button" class="btn"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblBwmoney" class="lbl"></a></td>
						<td class="td2">
						<input id="txtBwmoney"  type="text" class="txt c1 num" />
						</td>
						<td class="td3"><span> </span><a id="lblPaydate" class="lbl"></a></td>
						<td class="td4">
						<input id="txtPaydate"  type="text" class="txt c1" />
						</td>
						<td class="td5"><span> </span><a id="lblPay" class="lbl"></a></td>
						<td class="td6">
						<input id="txtPay" type="text" class="txt c1 num" />
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1" ><span> </span><a id="lblMemo" class="lbl"></a></td>
						<td class="column1" colspan="5"><textarea id="txtMemo" style="width:100%; height: 127px;"></textarea></td>
					</tr>

				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td align="center" style="width:3%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" style="width:5%;"><a id='lbl_typea'></a></td>
						<td align="center" style="width:15%;"><a id='lbl_checkno'></a></td>
						<td align="center" style="width:8%;"><a id='lbl_bankno'></a></td>
						<td align="center" style="width:15%;"><a id='lbl_account'></a></td>
						<td align="center" style="width:10%;"><a id='lbl_bank'></a></td>
						<td align="center" style="width:10%;"><a id='lbl_money'></a></td>
						<td align="center" style="width:8%;"><a id='lbl_indate'></a></td>

					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input class="txt" id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><select id="cmbTypea.*" style="width:95%; text-align: center;"></select></td>
						<td>
						<input class="txt" id="txtCheckno.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtBankno.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtAccount.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtBank.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtMoney.*" type="text" style="width:95%;  text-align: right;"/>
						</td>
						<td>
						<input class="txt" id="txtIndate.*" type="text" style="width:95%; text-align: center;"/>
						</td>

					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

