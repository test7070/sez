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

            q_desc = 1
            q_tables = 's';
            var q_name = "bccin";
            var q_readonly = ['txtNoa', 'txtWorker'];
            var q_readonlys = [];
            var bbmNum = [['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtDiscount', 10, 0, 1]];
            var bbsNum = [['txtMount', 10, 0, 1], ['txtMount2', 10, 0, 1], ['txtPrice', 15, 3, 1], ['txtDiscount', 15, 0, 1], ['txtMoney', 15, 0, 1], ['txtTotal', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 5;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
            , ['txtBccno_', 'btnBccno_', 'bcc', 'noa,product,unit', 'txtBccno_,txtBccname_,txtUnit_', 'bcc_b.aspx']);
            
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
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];

                q_mask(bbmMask);
                q_gt('store', '', 0, 0, 0, "");
                q_gt('part', '', 0, 0, 0, "");
                q_gt('acomp', '', 0, 0, 0, "");
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

                $('#txtInvono').change(function() {
                    if (!emp($('#txtInvono').val()) && $('#txtInvono').val().length != 10) {
                        alert('發票號碼錯誤!!');
                        $('#txtInvono').focus();
                    }
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'acomp':
		                var as = _q_appendData("acomp", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
		                    }
							q_cmbParse("cmbCno", t_item);
		                    $("#cmbCno").val(abbm[q_recno].cno);
		                }
		                break;
                    case 'part':
		                var as = _q_appendData("part", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
		                    }
							q_cmbParse("cmbPartno", t_item);
		                    $("#cmbPartno").val(abbm[q_recno].partno);
		                }
		                break;
                    case 'store':
		                var as = _q_appendData("store", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].store;
		                    }
		                    q_cmbParse("cmbStoreno", t_item, 's');
		                    refresh(q_recno);  /// 第一次需要重新載入
		                }
		                break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
            	$('#txtAcomp').val($('#cmbCno').find(":selected").text());
            	$('#txtPart').val($('#cmbPartno').find(":selected").text());
                $('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
                    alert(q_getMsg('lblMon') + '錯誤。');
                    return;
                }
                if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                sum();
                $('#txtWorker').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
               	var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll('A' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('bccin_s.aspx', q_name + '_s', "500px", "340px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
                _bbsAssign();
                for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                    $('#lblNo_' + j).text(j + 1);
                    $('#btnMinus_' + j).click(function() {
                        btnMinus($(this).attr('id'));
                    });
                    $('#btnProductno_' + j).click(function() {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        pop('ucc');
                    });
                    $('#txtProductno_' + j).change(function() {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        q_change($(this), 'ucc', 'noa', 'noa,product,unit');
                        /// ?? q_gtPost()
                    });

                    $('#txtMount_' + j).change(function() {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        if (!emp($('#txtMount_' + b_seq).val()))
                            q_tr('txtMount2_' + b_seq, dec($('#txtMount_' + b_seq).val()));
                        sum();
                    });
                    $('#txtMount2_' + j).change(function() {
                        sum();
                    });
                    $('#txtPrice_' + j).change(function() {
                        sum();
                    });

                } //j
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtMon').val(q_date().substr(0, 6));
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
            }

            function btnPrint() {
                q_box('z_bccin.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['bccno'] && !as['bccname']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0, t_money = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!emp($('#txtMount2_' + j).val()) && !emp($('#txtPrice_' + j).val())) {
                        q_tr('txtTotal_' + j, dec($('#txtMount2_' + j).val()) * dec($('#txtPrice_' + j).val()));

                        if (!emp($('#txtBccno_' + j).val()))
                            t_money += dec($('#txtTotal_' + j).val())
                    }
                }// j
                q_tr('txtMoney', t_money);
                calTax();
                q_tr('txtTotal', dec($('#txtMoney').val()) + dec($('#txtTax').val()) - dec($('#txtDiscount').val()));
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
                } else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 3;
                } else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
                    str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 4
                }
                return 0;
                //錯誤
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 300px;
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
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"],select {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewInvono'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTotal'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="invono" style="text-align: center;">~invono</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno"  type="text" style="float:left; width:30%;"/>
							<input id="txtTgg"  type="text" style="float:left; width:70%;"/>
						</td>
						<td><span> </span><a id="lblPart" class="lbl"> </a></td>
						<td>
							<select id="cmbPartno" class="txt c1"> </select>
							<input id="txtPart" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td><input id="txtInvono"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td colspan="2">
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
						<td><select id="cmbTaxtype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDiscount' class="lbl"> </a></td>
						<td><input id="txtDiscount"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:1%;"> </td>
					<td align="center" style="width:5%;"><a id='lblStoreno'> </a></td>
					<td align="center" style="width: 5%;"><a id='lblBccno'> </a></td>
					<td align="center" style="width: 18%;"><a id='lblBccname'> </a></td>
					<td align="center" style="width: 5%;"><a id='lblUnit'> </a></td>
					<td align="center" style="width: 5%;"><a id='lblMount'> </a></td>
					<td align="center" style="width: 5%;"><a id='lblMount2'> </a></td>	
					<td align="center" style="width: 5%;"><a id='lblPrice'> </a></td>
					<td align="center" style="width: 5%;"><a id='lblTotals'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblUno'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblMemos'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><select id="cmbStoreno.*" class="txt c1"> </select></td>
					<td>
						<input id="btnBccno.*" type="button" value="." style="float:left;width: 20%;"/>
						<input id="txtBccno.*" type="text" style="float:left;width: 75%;" />
					</td>
					<td><input id="txtBccname.*" type="text" style="width: 95%;" /></td>
					<td><input id="txtUnit.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMount.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtMount2.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtPrice.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtTotal.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtUno.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMemo.*"type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
