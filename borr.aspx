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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;

            q_tables = 't';
            var q_name = "borr";
            var q_readonly = ['txtNoa', 'txtCash', 'txtChecka', 'txtVccno' , 'txtMoney', 'txtInterest', 'txtTotal', 'txtPay', 'txtUnpay', 'txtWorker','txtAccno'];
            var q_readonlys = [];
            var q_readonlyt = ['txtVccno','txtAccno'];
            var bbmNum = [['txtCash', 10, 0],['txtFixmoney', 10, 0], ['txtChecka', 10, 0], ['txtMoney', 10, 0], ['txtInterest', 10, 0], ['txtTotal', 10, 0], ['txtPay', 10, 0], ['txtUnpay', 10, 0]];
            var bbsNum = [['txtMoney', 10, 0, 1]];
            var bbtNum = [['txtMoney', 10, 0, 1]];
            var bbmMask = [['txtDatea', '999/99/99'], ['txtBegindate', '999/99/99'], ['txtEnddate', '999/99/99']];
            var bbsMask = [['txtDatea', '999/99/99'], ['txtIndate', '999/99/99']];
            var bbtMask = [['txtMon', '999/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 20;

            aPop = new Array(
								['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtCust,txtCustnick', 'cust_b.aspx'],
								['txtBankno_', '', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'],
								['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
							);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#txtBegindate').datepicker();
                $('#txtEnddate').datepicker();
                q_cmbParse("cmbTypea", q_getPara('borr.typea'), 's');

                $("#txtBegindate").change(function() {
                    calcDay();
                });
                $("#txtEnddate").change(function() {
                    calcDay();
                });
                $("#txtCash").change(function() {
                    sum();
                });
                $("#txtChecka").change(function() {
                    sum();
                });
                $("#txtRate").change(function() {
                    sum();
                });
				$('#lblVccno').click(function() {
					t_where = "noa='" + $('#txtVccno').val() + "'";
					q_pop('txtVccno', "vcctran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+ t_where +";" + r_accy + '_' + r_cno, 'vcc', 'noa', 'datea', "95%", "95%", q_getMsg('popVcc'), true);
				});
                
                $('#lblAccno').click(function() {
                	if($('#txtDatea').val().substring(0,3).length>0)
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3)+ '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        if (q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);
                        break;
                }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
				var s2 = xmlString.split(';');
                abbm[q_recno]['accno'] = s2[0];
                abbm[q_recno]['vccno'] = s2[1];
               	$('#txtAccno').val(s2[0]);
               	$('#txtVccno').val(s2[1]);
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
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('borr_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box('z_borr.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
            	if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
                }
                sum();
                $('#txtWorker').val(r_name);
               
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_borr') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['money']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                if (q_cur > 0 && q_cur < 4)
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
            }

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $('#txtMoney_' + i).change(function() {
                            sum();
                        });
                        $('#txtCheckno_' + i).change(function() {
                            sum();
                        });
                        $('#cmbTypea_' + i).change(function() {
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                        $('#txtMoney__' + i).change(function() {
                            sum();
                        });
                    }
                }
                _bbtAssign();
            }

            function calcDay() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var t_days = 0;
                var t_date1 = $('#txtBegindate').val();
                var t_date2 = $('#txtEnddate').val();
                t_date1 = new Date(dec(t_date1.substr(0, 3)) + 1911, dec(t_date1.substring(4, 6)) - 1, dec(t_date1.substring(7, 9)));
                t_date2 = new Date(dec(t_date2.substr(0, 3)) + 1911, dec(t_date2.substring(4, 6)) - 1, dec(t_date2.substring(7, 9)));
                t_days = Math.abs(t_date2 - t_date1) / (1000 * 60 * 60 * 24) + 1;
                $('#txtDays').val(t_days);
                sum();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var t_days = 0, t_money = 0, t_cash = 0, t_checka = 0, t_interest = 0, t_pay = 0;
                t_days = q_float('txtDays');
                for (var i = 0; i < q_bbsCount; i++) {
                    if ($('#cmbTypea_' + i).val() == '1')
                        if ($.trim($('#txtCheckno_' + i).val()).length > 0)
                            t_checka += q_float('txtMoney_' + i);
                        else
                            t_cash += q_float('txtMoney_' + i);
                    else
                        t_pay += q_float('txtMoney_' + i);
                }
                $('#txtCash').val(t_cash);
                $('#txtChecka').val(t_checka);
                t_money = t_cash + t_checka;
                $('#txtMoney').val(t_money);
                t_interest = round(t_money * t_days / 30 * q_float('txtRate') / 100, 0);
                $('#txtInterest').val(t_interest);
                $('#txtTotal').val(t_money + t_interest);
                $('#txtPay').val(t_pay);
                $('#txtUnpay').val(t_money + t_interest - t_pay);
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

            function q_popPost(id) {
                switch (id) {
                    default:
                        break;
                }
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 950px;
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
                width: 950px;
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
                width: 9%;
            }
            .tbbm .tdZ {
                width: 1%;
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
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 130%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 950px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 600px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:80px; color:black;"><a id='vewCust'> </a></td>
						<td style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td style="width:80px; color:black;"><a id='vewInterest'> </a></td>
						<td style="width:80px; color:black;"><a id='vewTotal'> </a></td>
						<td style="width:80px; color:black;"><a id='vewPay'> </a></td>
						<td style="width:80px; color:black;"><a id='vewUnpay'> </a></td>
						<td style="width:300px; color:black;"><a id='vewMemo'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='custnick' style="text-align: center;">~custnick</td>
						<td id='money,0,1' style="text-align: right;">~money,0,1</td>
						<td id='interest,0,1' style="text-align: right;">~interest,0,1</td>
						<td id='total,0,1' style="text-align: right;">~total,0,1</td>
						<td id='pay,0,1' style="text-align: right;">~pay,0,1</td>
						<td id='unpay,0,1' style="text-align: right;">~unpay,0,1</td>
						<td id='memo' style="text-align: left;">~memo</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCustno"  type="text" style="width:25%; float:left;"/>
							<input id="txtCust"  type="text" style="width:75%; float:left;"/>
							<input id="txtCustnick"  type="text" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSalesno" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtSalesno"  type="text" style="width:25%; float:left;"/>
							<input id="txtSales"  type="text" style="width:75%; float:left;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCash" class="lbl"> </a></td>
						<td>
						<input id="txtCash"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblChecka" class="lbl"> </a></td>
						<td>
						<input id="txtChecka"  type="text" class="txt c1 num" />
						</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td>
						<input id="txtMoney" type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBegindate" class="lbl"> </a></td>
						<td>
						<input id="txtBegindate" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblEnddate" class="lbl"> </a></td>
						<td>
						<input id="txtEnddate" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDays" class="lbl"> </a></td>
						<td>
						<input id="txtDays"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblRate" class="lbl"> </a></td>
						<td>
						<input id="txtRate" type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblInterest" class="lbl"> </a></td>
						<td>
						<input id="txtInterest" type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblRatemon" class="lbl"> </a></td>
						<td>
							<input id="txtRatemon" type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblFixmoney" class="lbl"> </a></td>
						<td>
							<input id="txtFixmoney" type="text" class="txt c1 num"/>
						</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td>
						<input id="txtTotal" type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6">
						<input id="txtMemo" type="text" class="txt c1"/>
						</td>
						<td></td>
						<td><span> </span><a id="lblPay" class="lbl"> </a></td>
						<td>
						<input id="txtPay" type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td>
							<span> </span><a id="lblWorker" class="lbl"> </a>
						</td>
						<td>
							<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td>
							<span> </span><a id="lblAccno" class="lbl btn"> </a>
						</td>
						<td>
							<input id="txtAccno" type="text" class="txt c1"/>
						</td>
						<td>
							<span> </span><a id="lblVccno" class="lbl btn"> </a>
						</td>
						<td>
							<input id="txtVccno" type="text" class="txt c2"/>
						</td>
						<td colspan="2"> </td>
						<td><span> </span><a id="lblUnpay" class="lbl"> </a></td>
						<td>
						<input id="txtUnpay" type="text" class="txt c1 num"/>
						</td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:80px;"><a id='lbl_typea'> </a></td>
						<td style="width:80px;"><a id='lbl_datea'> </a></td>
						<td style="width:80px;"><a id='lbl_money'> </a></td>
						<td style="width:150px;"><a id='lbl_checkno'> </a></td>
						<td style="width:80px;"><a id='lbl_indate'> </a></td>
						<td style="width:80px;"><a id='lbl_bankno'> </a></td>
						<td style="width:80px;"><a id='lbl_bank'> </a></td>
						<td style="width:150px;"><a id='lbl_account'> </a></td>
						<td style="width:150px;"><a id='lbl_memo'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><select id="cmbTypea.*" style="width:95%; text-align: center;"> </select></td>
						<td>
						<input class="txt" id="txtDatea.*" type="text" style="width:95%; text-align: center;"/>
						</td>
						<td>
						<input class="txt" id="txtMoney.*" type="text" style="width:95%; text-align: right;"/>
						</td>
						<td>
						<input class="txt" id="txtCheckno.*" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtIndate.*" type="text" style="width:95%; text-align: center;"/>
						</td>
						<td>
						<input class="txt" id="txtBankno.*" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtBank.*" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtAccount.*" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%; text-align: left;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:100px; text-align: center;">請款月份</td>
						<td style="width:100px; text-align: center;">金額</td>
						<td style="width:350px; text-align: center;">備註</td>
						<td style="width:150px; text-align: center;">請款單號</td>
						<td style="width:150px; text-align: center;">傳票號碼</td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold; width:90%;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtMon..*" type="text" style="width:95%;"/></td>
						<td><input id="txtMoney..*"  type="text" style="width:95%; text-align: right;"/></td>
						<td><input id="txtMemo..*"  type="text" style="width:95%; text-align: left;"/></td>
						<td><input id="txtVccno..*" type="text" class="txt c1"/></td>
						<td><input id="txtAccno..*"  type="text" class="txt c1"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
