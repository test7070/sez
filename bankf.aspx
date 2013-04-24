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

            var q_name = "bankf";

            var q_readonly = ['txtNoa', 'txtAccno', 'txtDatea', 'txtWorker', 'txtWorker2'];

            var bbmNum = [['txtMoney', 11, 2, 1], ['txtMoney2', 11, 2, 1], ['txtInterestrate', 6, 3, 1]];
            var bbmMask = [];
            var compArr = new Array();
            var CheckLcno//有重複為true 無重複為false
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 16;
            if (q_cur == 1)
                CheckLcno = true;
            else
                CheckLcno = false;
            aPop = new Array(['txtPayacc1', 'lblPayacc', 'acc', 'acc1,acc2', 'txtPayacc1,txtPayacc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', "bank_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtBank2no', 'lblBank2', 'bank', 'noa,bank', 'txtBank2no,txtBank2', 'bank_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
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
                bbmMask = [['txtIndate', r_picd], ['txtEnddate', r_picd], ['txtUndate', r_picd], ['txtPaydate', r_picd], ['txtDatea', r_picd]];
                q_mask(bbmMask);

                q_cmbParse("cmbType", ('').concat(new Array('', '一個月', '二個月', '三個月', '四個月', '五個月', '六個月', '七個月', '八個月', '九個月', '十個月', '十一個月')));
                q_cmbParse("cmbTypeyear", ('').concat(new Array('', '一年', '二年', '三年')));
                q_cmbParse("cmbPayitype", ('').concat(new Array('到期付息', '每月付息', '到期入本金')));
                q_cmbParse("cmbMoneytype", ('').concat(new Array('台幣', '美元', '日幣', '港幣', '人民幣', '歐元', '英鎊', '新加坡幣')));

                q_cmbParse("cmbRate", ('').concat(new Array('固定利率', '機動利率')));
                q_gt('acomp', '', 0, 0, 0, "");
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('btnAccc'), true);
                });
                $('#txtAcc1').change(function(e) {
					var patt = /(\d{4})([^\.,.]*)$/g;
					$(this).val($(this).val().replace(patt,"$1.$2"));
        		});
                $("#cmbCno").change(function() {
                    var selectVal = $('#cmbCno').val();
                    $('#txtNick').val(compArr[selectVal].nick);
                });
                $('#txtLcno').change(function() {
                    $('#btnOk').attr('disabled', 'disabled');
                    var t_where = "where=^^ lcno='" + $('#txtLcno').val() + "' ^^";
                    q_gt('bankf', t_where, 0, 0, 0, "");
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
                            var t_item = "@";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                                compArr[as[i].noa] = new Array();
                                compArr[as[i].noa].cno = as[i].cno;
                                compArr[as[i].noa].acomp = as[i].acomp;
                                compArr[as[i].noa].nick = as[i].nick;
                            }
                            q_cmbParse("cmbCno", t_item);
                            if (abbm[q_recno])
                                $("#cmbCno").val(abbm[q_recno].cno);
                            $('#txtNick').val(compArr[abbm[q_recno].cno].nick);
                        }
                        break;
                    case 'bankf':
                        if (q_cur != 0 && q_cur != 4) {
				            if (q_cur == 1)
				                CheckLcno = true;
				            else
				                CheckLcno = false;
                            var as = _q_appendData("bankf", "", true);
                            if (as[0] != undefined) {
                                if (q_cur == 2 && abbm[q_recno].lcno == as[0].lcno)
                                    CheckLcno = false;
                                else
                                    CheckLcno = true;
                            } else {
                                CheckLcno = false;
                            }
                        }
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        $('#btnOk').removeAttr('disabled');
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('bankf_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtLcno').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtNoa').attr('disabled', 'disabled')
                $('#txtLcno').focus();
            }

            function btnPrint() {
                q_box('z_bankf.aspx' + "?;;;;" + r_accy + ";", '', "95%", "95%", m_print);
            }

            function btnOk() {
                $('#txtAcomp').val($('#cmbCno').find(":selected").text());
                if (!q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;

                }
                if (CheckLcno) {
                    alert(q_getMsg('lblLcno') + '重複。');
                    return;
                }
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else if (q_cur == 2) {
                    $('#txtWorker2').val(r_name);
                } else {
                    alert("error: btnok!")
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_bankf') + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (q_cur != 1 && q_cur != 2) {
                    $('#btnInput').attr('disabled', 'disabled');
                } else {
                    $('#btnInput').removeAttr('disabled');
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
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 550px;
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
                width: 650px;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
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
            }
            .tbbs input[type="text"] {
                width: 98%;
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
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewNick'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewIndate'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewType'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewBank'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMoneytype'> </a></td>

					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='nick' style="text-align: left;">~nick</td>
						<td id='indate' style="text-align: center;">~indate</td>
						<td id='typeyear type' style="text-align: left;">~typeyear ~type</td>
						<td id='bank' style="text-align: left;">~bank</td>
						<td id='money,2,1' style="text-align: right;">~money,2,1</td>
						<td id='moneytype' style="text-align: left;">~moneytype</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
						<input id="txtNoa"  type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea"  type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td colspan="2"><select id="cmbCno" class="txt c1"></select>
						<input id="txtAcomp" type="text" style="display:none;"/>
						<input id="txtNick" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLcno' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtLcno"  type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypeyear" class="txt c1"></select></td>
						<td><select id="cmbType" class="txt c1"></select></td>
						<td>
						<input id="chkAuto" type="checkbox" style=' '/>
						<span> </span><a id="lblAuto"> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBank' class="lbl btn"> </a></td>
						<td>
						<input id="txtBankno" type="text" class="txt c1" />
						</td>
						<td>
						<input id="txtBank" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccount' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtAccount"  type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoneytype' class="lbl"> </a></td>
						<td><select id="cmbMoneytype"  class="txt c1" ></select></td>

					</tr>
					<tr>
						<td><span> </span><a id='lblRate' class="lbl"> </a></td>
						<td><select id="cmbRate"  class="txt c1" ></select></td>
						<td>
						<input id="txtInterestrate"  type="text" class="txt num c2" />
						%</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPayitype' class="lbl"> </a></td>
						<td><select id="cmbPayitype" class="txt c1"></select></td>
					</tr>
					<tr style="display: none;">
						<td align="right"><span> </span>
						<input id="btnInput" type="button"/>
						</td>
						<td colspan="2">
						<input id="txtInput" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td>
						<input id="txtIndate" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td>
						<input id="txtEnddate" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td>
						<input id="txtMoney"  type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUndate' class="lbl"> </a></td>
						<td>
						<input id="txtUndate" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney2' class="lbl"> </a></td>
						<td>
						<input id="txtMoney2" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcc' class="lbl"> </a></td>
						<td>
						<input id="txtAcc1" type="text" class="txt c1" />
						</td>
						<td>
						<input id="txtAcc2" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCheckno' class="lbl"> </a></td>
						<td>
						<input id="txtCheckno" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td>
						<input id="txtPaydate" type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBank2' class="lbl"> </a></td>
						<td>
						<input id="txtBank2no" type="text" class="txt c1" />
						</td>
						<td>
						<input id="txtBank2" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3" >						<textarea id="txtMemo"  style="width:100%; height: 60px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td>
						<input id="txtWorker2" type="text" class="txt c1" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
