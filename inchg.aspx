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

            q_desc = 1;
            q_tables = 's';
            var q_name = "inchg";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
            //,['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
                bbsNum = [['txtUsprice', 15, q_getPara('rc2.pricePrecision'), 1],['txtFloata', 15, 4, 1],['txtContainer', 10, 0, 1],['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1]
            					,['txtWorker', 15, 0, 1],['txtDocn', 15, 0, 1],['txtArrange', 15, 0, 1],['txtInsurance', 15, 0, 1],['txtCustoms', 15, 0, 1],['txtTranmoney', 15, 0, 1],['txtImport', 15, 0, 1]
            					,['txtCheckn', 15, 0, 1],['txtTrans', 15, 0, 1],['txtHang', 15, 0, 1],['txtErele', 15, 0, 1],['txtLch', 15, 0, 1],['txtInterest', 15, 0, 1],['txtCoolie', 15, 0, 1]
            					,['txtCommission', 15, 0, 1],['txtTax', 15, 0, 1],['txtTotal', 15, 0, 1]];//,['txtDocn2', 15, 0, 1]
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('inchg.typea'));
                /* 若非本會計年度則無法存檔 */
                /*$('#txtDatea').focusout(function() {
                    if ($(this).val().substr(0, 3) != r_accy) {
                        $('#btnOk').attr('disabled', 'disabled');
                        alert(q_getMsg('lblDatea') + '非本會計年度。');
                    } else {
                        $('#btnOk').removeAttr('disabled');
                    }
                });*/

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

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                $('#txtWorker').val(r_name)
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('IC' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('inchg_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
            	for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {	
						$('#txtWorker_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtDocn_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtArrange_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtInsurance_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtCustoms_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtTranmoney_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtImport_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtCheckn_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtTrans_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtHang_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtErele_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtLch_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtInterest_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtCoolie_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtCommission_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
						$('#txtTax_' + j).change(function () {t_IdSeq = -1; q_bodyId($(this).attr('id')); b_seq = t_IdSeq; s_sum(b_seq)});
					}
				}
            	
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['invono']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['datea'] = abbm2['datea'];

                return true;
            }
			
			function s_sum(b_seq) {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
                t1=q_add(q_float('txtWorker_'+b_seq),q_float('txtDocn_'+b_seq));
                t1=q_add(t1,q_float('txtArrange_'+b_seq));
                t1=q_add(t1,q_float('txtInsurance_'+b_seq));
				t1=q_add(t1,q_float('txtCustoms_'+b_seq));
				t1=q_add(t1,q_float('txtTranmoney_'+b_seq));
				t1=q_add(t1,q_float('txtImport_'+b_seq));
				t1=q_add(t1,q_float('txtCheckn_'+b_seq));
				t1=q_add(t1,q_float('txtTrans_'+b_seq));
				t1=q_add(t1,q_float('txtHang_'+b_seq));
				t1=q_add(t1,q_float('txtErele_'+b_seq));
				t1=q_add(t1,q_float('txtLch_'+b_seq));
				t1=q_add(t1,q_float('txtInterest_'+b_seq));
				t1=q_add(t1,q_float('txtCoolie_'+b_seq));
				t1=q_add(t1,q_float('txtCommission_'+b_seq));
				t1=q_add(t1,q_float('txtTax_'+b_seq));
				q_tr('txtTotal_'+b_seq,t1);
            }
			
            function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                	
                } // j
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
                /*width: 9%;*/
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
                width: 50%;
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
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1px;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
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
			<div class="dview" id="dview" style="float: left;  width:25%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:20%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tgg'>~tgg</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr>
						<td class='td1' style="width: 10%;"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class='td2' style="width: 23%;"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class='td3' style="width: 10%;"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class='td4' style="width: 23%;"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td class='td6'><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtTggno"  type="text" class="txt c2"/>
							<input  id="txtTgg"  type="text"  class="txt c3"/>
						</td>
						<td class='td3'><span> </span><a id="lblPay" class="lbl "> </a></td>
						<td class="td4"><input id="txtPay"  type="text"  class="txt c1"/></td>
						<!--<td class='td5' style="width: 10%;"><span> </span><a id="lblDate" class="lbl" > </a></td>
						<td class='td6' style="width: 23%;">
							<input id="txtBdate" type="text" style='width:40%;'/>
							<a style="font-size: 25px;float: left;">&sim;</a>
							<input id="txtEdate" type="text" style='width:40%;float: left;'/>
						</td>-->
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblBcomp" class="lbl" > </a></td>
						<td class="td2"><input id="txtBcomp" type="text"  class="txt c1"/></td>
						<td class='td3'><span> </span><a id="lblBoat" class="lbl"> </a></td>
						<td class="td4" colspan="2">
							<!--<input id="txtBoatno" type="text" class="txt c2"/>-->
							<input id="txtBoat" type="text" class="txt c3"/>
						</td>
						<!--<td class="td5"><input id="btnIndata" type="button"/></td>-->
						<!--<td class="td5"><input id="btnDelet" type="button"/></td>-->
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="5">
							<textarea id="txtMemo" cols="10" rows="5" style="width: 95%;height: 50px;"> </textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 2500px;">
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width: 150px;"><a id='lblInvono'> </a></td>
					<td align="center" ><a id='lblDate2'> </a></td>
					<td align="center" ><a id='lblUsprice'> </a></td>
					<td align="center" ><a id='lblFloata'> </a></td>
					<td align="center" ><a id='lblContainer'> </a></td>
					<td align="center" ><a id='lblWeight'> </a></td>
					<td align="center" ><a id='lblWorker'> </a></td>
					<td align="center" ><a id='lblDocn'> </a></td>
					<td align="center" ><a id='lblArrange'> </a></td>
					<td align="center" ><a id='lblInsurance'> </a></td>
					<td align="center" ><a id='lblCustoms'> </a></td>
					<td align="center" ><a id='lblTranmoney'> </a></td>
					<td align="center" ><a id='lblImport'> </a></td>
					<td align="center" ><a id='lblCheckn'> </a></td>
					<td align="center" ><a id='lblTrans'> </a></td>
					<td align="center" ><a id='lblHang'> </a></td>
					<td align="center" ><a id='lblErele'> </a></td>
					<!--<td align="center" ><a id='lblDocn2'> </a></td>-->
					<td align="center" ><a id='lblLch'> </a></td>
					<td align="center" ><a id='lblInterest'> </a></td>
					<td align="center" ><a id='lblCoolie'> </a></td>
					<td align="center" ><a id='lblCommission'> </a></td>
					<td align="center" ><a id='lblTax'> </a></td>
					<td align="center" ><a id='lblTotal'> </a></td>
					</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
					<td >
						<input class="txt c1" id="txtInvono.*" type="text" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td ><input class="txt c1" id="txtDate2.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtUsprice.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtFloata.*"type="text"  /></td>
					<td ><input class="txt num c1" id="txtContainer.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtWeight.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtWorker.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtDocn.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtArrange.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtInsurance.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtCustoms.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtTranmoney.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtImport.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtCheckn.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtTrans.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtHang.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtErele.*" type="text" /></td>
					<!--<td ><input class="txt num c1" id="txtDocn2.*" type="text" /></td>-->
					<td ><input class="txt num c1" id="txtLch.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtInterest.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtCoolie.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtCommission.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtTax.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtTotal.*" type="text" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
