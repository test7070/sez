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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 's';
            var q_name = "cng";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [['txtTax', 10, 0, 1], ['txtMoney', 15, 0, 1], ['txtPrice', 10, 2, 1], ['txtWeight', 15, 2, 1], ['txtTotal', 15, 0, 1]];
            var bbsNum = [['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1], ['txtMount', 10, 0, 1], ['txtWeight', 15, 2, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'], ['txtStorinno', 'lblStorein', 'store', 'noa,store', 'txtStorinno,txtStorin', 'store_b.aspx'], ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,class,product,unit,radius,width,dime,lengthb,spec', 'txtUno_,txtProductno_,txtClass_,txtProduct_,txtUnit_,txtRadius_,txtWidth_,txtDime_,txtLengthb_,txtSpec_', 'uccc_seek_b.aspx', '95%', '60%'], ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

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
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('cng.typea'));
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                q_cmbParse("cmbKind", q_getPara('sys.stktype'));
                $('#cmbKind').change(function() {
                    size_change();
                });

            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtUno_':
                        size_change();
                        break;
                }

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                //日期檢查
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtDatea').val().substring(0, 3) != r_accy) {
                    alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
                    Unlock(1);
                    return;
                }
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cng') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('cng_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        //將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
                        $('#textSize1_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;

                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtDime_' + b_seq, q_float('textSize1_' + b_seq));
                                //厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtRadius_' + b_seq, q_float('textSize1_' + b_seq));
                                //短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());
                            }

                        });
                        $('#textSize2_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;

                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtWidth_' + b_seq, q_float('textSize2_' + b_seq));
                                //寬度$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtWidth_' + b_seq, q_float('textSize2_' + b_seq));
                                //長徑$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());
                            }

                        });
                        $('#textSize3_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;

                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtLengthb_' + b_seq, q_float('textSize3_' + b_seq));
                                //長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtDime_' + b_seq, q_float('textSize3_' + b_seq));
                                //厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());
                            } else {//鋼筋、胚
                                q_tr('txtLengthb_' + b_seq, q_float('textSize3_' + b_seq));
                            }

                        });
                        $('#textSize4_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;

                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtRadius_' + b_seq, q_float('textSize4_' + b_seq));
                                //短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtLengthb_' + b_seq, q_float('textSize4_' + b_seq));
                                //長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());
                            }

                        });
                        //-------------------------------------------------------------------------------------
                    }
                }
                _bbsAssign();
                size_change();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('#cmbKind').val(q_getPara('vcc.kind'));
                size_change();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
            }

            function btnPrint() {
                q_box('z_cngst.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['uno'] && !as['productno'] && !as['product'] && !as['spec']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                size_change();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                size_change();
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                size_change();
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

            function size_change() {
                if (q_cur == 1 || q_cur == 2) {
                    $('input[id*="textSize"]').removeAttr('disabled');
                } else {
                    $('input[id*="textSize"]').attr('disabled', 'disabled');
                }
                if ($('#cmbKind').val().substr(0, 1) == 'A') {
                    $('#lblSize_help').text(q_getPara('sys.lblSizea'));
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).show();
                        $('#textSize2_' + j).show();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).hide();
                        $('#x1_' + j).show();
                        $('#x2_' + j).show();
                        $('#x3_' + j).hide();
                        $('#Size').css('width', '222px');
                        $('#textSize1_' + j).val($('#txtDime_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0);
                    }
                } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                    $('#lblSize_help').text(q_getPara('sys.lblSizeb'));
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).show();
                        $('#textSize2_' + j).show();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).show();
                        $('#x1_' + j).show();
                        $('#x2_' + j).show();
                        $('#x3_' + j).show();
                        $('#Size').css('width', '297px');
                        $('#textSize1_' + j).val($('#txtRadius_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtDime_' + j).val());
                        $('#textSize4_' + j).val($('#txtLengthb_' + j).val());
                    }
                } else {//鋼筋和鋼胚
                    $('#lblSize_help').text(q_getPara('sys.lblSizec'));
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).hide();
                        $('#textSize2_' + j).hide();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).hide();
                        $('#x1_' + j).hide();
                        $('#x2_' + j).hide();
                        $('#x3_' + j).hide();
                        $('#Size').css('width', '70px');
                        $('#textSize1_' + j).val(0);
                        $('#txtDime_' + j).val(0);
                        $('#textSize2_' + j).val(0);
                        $('#txtWidth_' + j).val(0);
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0);
                    }
                }
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
                        return 4;
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
                width: 98%;
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
                width: 98%;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .tbbm select {
                font-size: medium;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
            .txt.c6 {
                width: 49%;
                float: left;
            }
            .txt.c7 {
                float: left;
                width: 20%;
            }
            .txt.c8 {
                float: left;
                width: 65px;
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
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
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
		<div class="dview" id="dview" style="float: left;  width:32%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk'> </a></td>
					<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
					<td align="center" style="width:20%"><a id='vewStore'> </a></td>
					<td align="center" style="width:20%"><a id='vewStorin'> </a></td>
				</tr>
				<tr>
					<td >
					<input id="chkBrow.*" type="checkbox" style=' '/>
					</td>
					<td align="center" id='datea'>~datea</td>
					<td align="center" id='store'>~store</td>
					<td align="center" id='storin'>~storin</td>
				</tr>
			</table>
		</div>
		<div class='dbbm' style="width: 68%;float:left">
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr class="tr1">
					<td class='td1'><span> </span><a id="lblType" class="lbl" > </a></td>
					<td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
					<td class='td3'><span> </span><a id="lblDatea" class="lbl" > </a></td>
					<td class="td4">
					<input id="txtDatea" type="text" class="txt c1"/>
					</td>
					<td class='td5'><span> </span><a id="lblNoa" class="lbl" > </a></td>
					<td class="td6">
					<input id="txtNoa"   type="text" class="txt c1"/>
					</td>
				</tr>
				<tr class="tr2">
					<td class='td1'><span> </span><a id="lblKind" class="lbl" > </a></td>
					<td class="td2"><select id="cmbKind" class="txt c1"></select></td>
					<td class='td3'><span> </span><a id="lblStore" class="lbl btn"> </a></td>
					<td class="td4">
					<input id="txtStoreno" type="text"  class="txt c6"/>
					<input id="txtStore" type="text" class="txt c6"/>
					</td>
					<td class="td5"><span> </span><a id="lblStorein" class="lbl btn"> </a></td>
					<td class="td6">
					<input id="txtStorinno" type="text" class="txt c6"/>
					<input id="txtStorin" type="text" class="txt c6"/>
					</td>
				</tr>
				<tr class="tr3">
					<td class='td1'><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
					<td class="td2" colspan="3">
					<input id="txtTggno" type="text"  class="txt c4"/>
					<input id="txtTgg" type="text"  class="txt c5"/>
					</td>
					<td class='td5'><span> </span><a id="lblTrantype" class="lbl" > </a></td>
					<td class="td6"><select id="cmbTrantype" class="txt c1"></select></td>
				</tr>
				<tr class="tr4">
					<td class='td1'><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
					<td class="td2" colspan="3">
					<input id="txtCardealno" type="text"  class="txt c4"/>
					<input id="txtCardeal" type="text"  class="txt c5"/>
					</td>
					<td class='td5'><span> </span><a id="lblCarno" class="lbl" > </a></td>
					<td class="td6">
					<input id="txtCarno" type="text" class="txt c1"/>
					</td>
				</tr>
				<tr class="tr5">
					<td class='td1'><span> </span><a id="lblTax" class="lbl" > </a></td>
					<td class="td2">
					<input id="txtTax" type="text" class="txt c1 num"/>
					</td>
					<td class='td3'><span> </span><a id="lblMoney" class="lbl" > </a></td>
					<td class="td4">
					<input id="txtMoney" type="text" class="txt c1 num"/>
					</td>
					<td class='td5'><span> </span><a id="lblPrice" class="lbl" > </a></td>
					<td class="td6">
					<input id="txtPrice"   type="text" class="txt c1 num"/>
					</td>
				</tr>
				<tr class="tr6">
					<td class='td1'><span> </span><a id="lblWeight" class="lbl" > </a></td>
					<td class="td2">
					<input id="txtWeight"   type="text" class="txt c1 num"/>
					</td>
					<td class='td3'><span> </span><a id="lblTotal" class="lbl" > </a></td>
					<td class="td4">
					<input id="txtTotal"   type="text" class="txt c1 num"/>
					</td>
				</tr>
				<tr class="tr7">
					<td class='td1'><span> </span><a id="lblMemo" class="lbl"> </a></td>
					<td class="td2" colspan='3'>					<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
					<td class='td3'>
						<span> </span><a id="lblWorker" class="lbl"> </a>
					</td>
					<td class="td4">
						<input id="txtWorker" type="text" style="float:left;width:50%"/>
						<input id="txtWorker2" type="text" style="float:left;width:50%"/>
					</td>
				</tr>
			</table>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width: 12%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width: 12%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width: 4%;"><a id='lblUnit_st'> </a></td>
					<!--<td align="center" style="width: 6%;"><a id='lblSpec_st'> </a></td>-->
					<td align="center" id='Size'><a id='lblSize_st'> </a>
					<BR>
					<a id='lblSize_help'> </a></td>
					<td align="center" style="width: 9%;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width: 9%;"><a id='lblWeight_st'> </a></td>
					<!--<td align="center" style="width: 6%;"><a id='lblStoreno_st'> </a></td>-->
					<td align="center" ><a id='lblMemo_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
					</td>
					<td>
					<input class="btn"  id="btnUno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
					<input id="txtUno.*" type="text" style="width:83%;"/>
					</td>
					<td >
					<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
					<input id="txtProductno.*" type="text" style="width:80%;" />
					<input id="txtClass.*" type="text" style="width: 95%;"/>
					</td>
					<td >
					<input class="txt c1" id="txtProduct.*" type="text"/>
					</td>
					<td>
					<input class="txt c1" id="txtUnit.*" type="text" />
					</td>
					<!--<td><input class="txt c1" id="txtSpec.*" type="text"/></td>-->
					<td>
					<input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/>
					<div id="x1.*" style="float: left">
						x
					</div>
					<input class="txt num c8" id="textSize2.*" type="text" disabled="disabled"/>
					<div id="x2.*" style="float: left">
						x
					</div>
					<input class="txt num c8" id="textSize3.*" type="text" disabled="disabled"/>
					<div id="x3.*" style="float: left">
						x
					</div>
					<input class="txt num c8" id="textSize4.*" type="text" disabled="disabled"/>
					<!--上為虛擬下為實際-->
					<input id="txtRadius.*" type="hidden"/>
					<input  id="txtWidth.*" type="hidden"/>
					<input  id="txtDime.*" type="hidden"/>
					<input id="txtLengthb.*" type="hidden"/>
					<input class="txt c1" id="txtSpec.*" type="text"/>
					</td>
					<td>
					<input class="txt num c1" id="txtMount.*" type="text"/>
					</td>
					<td>
					<input class="txt num c1" id="txtWeight.*" type="text" />
					</td>
					<!--<td><input class="txt c1" id="txtStoreno.*" type="text" /></td>-->
					<td>
					<input class="txt c1" id="txtMemo.*" type="text"/>
					<input id="txtNoq.*" type="hidden" />
					<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
