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
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "pay";
            var decbbs = ['money', 'paysale', 'chgs', 'moneyus', 'paysaleus', 'chgsus'];
            var decbbm = ['sale', 'paysale', 'nextsale', 'total', 'floata', 'opay', 'unopay', 'totalus', 'paysaleus', 'nextsaleus', 'outsource'];
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
            //ajaxPath = "";
            aPop = new Array(['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], ['txtTggno', 'btnTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'], ['txtItemno_', 'btnItemno_', 'chgitem', 'noa,item', 'txtItemno_,txtItem_', 'chgitem_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);

            }///  end Main()

            function pop(form) {
                b_pop = form;
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                fbbm[fbbm.length] = 'txtMemo';

            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('A' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('worka_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProductno').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['typea']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for(var j = 0; j < q_bbsCount; j++) {

                }// j
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
						<td class="td3"><span> </span><a id='lblTgg' class="lbl btn"></a></td>
						<td class="td4" colspan="2">
						<input id="txtTggno" type="text" class="txt c4"/>
						<input id="txtComp"  type="text" class="txt c5"/>
						</td>
						<td class="7">
						<input type="button" id="btnTre" class="txt c1 " />
						</td>
						<td class="8">
						<input type="button" id="btnRc2tran" class="txt c1 " />
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
						<td class="td7"><span> </span><a id='lblNextsale' class="lbl"></a></td>
						<td class="td8">
						<input id="txtNextsale"  type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblAccno' class="lbl"></a></td>
						<td class="td2">
						<input id="txtAccno"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblPayc' class="lbl"></a></td>
						<td class="td4">
						<input id="txtPayc"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1" ><span> </span><a id="lblApprv" class="lbl"></a></td>
						<td class="td2" colspan="2">
							<input id="txtApprv"  type="text" style="float: left; width:30%;"/>
							<input id="txtApprvmemo"  type="text" style="float: left; width:50%;"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1" ><span> </span><a id="lblChecker" class="lbl"></a></td>
						<td class="td2" colspan="2">
							<input id="txtChecker"  type="text" style="float: left; width:30%;"/>
							<input id="txtCheckermemo"  type="text" style="float: left; width:50%;"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1" ><span> </span><a id="lblApprove" class="lbl"></a></td>
						<td class="td2" colspan="2">
							<input id="txtApprove"  type="text" style="float: left; width:30%;"/>
							<input id="txtApprovememo"  type="text" style="float: left; width:50%;"/>
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1" ><span> </span><a id="lblApprove2" class="lbl"></a></td>
						<td class="td2" colspan="2">
							<input id="txtApprove2"  type="text" style="float: left; width:30%;"/>
							<input id="txtApprove2memo"  type="text" style="float: left; width:50%;"/>
						</td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan='5' >						<textarea id="txtMemo" style="width: 99%; height: 50px;" ></textarea></td>
						<td class="td7"><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td class="td8" >
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
			<div class='dbbs' >
				<%--style="overflow-x:  hidden; overflow-y: scroll; height:200px;"  --%>
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 100%;">
					<tr style='color:White; background:#003366;' >
						<td align="center">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" class="td1"><a id='lblType'></a></td>
						<td align="center" class="td2"><a id='lblMoney'></a></td>
						<td align="center" class="td2"><a id='lblChgs'></a></td>
						<td align="center" class="td2"><a id='lblPaysales'></a></td>
						<td align="center" class="td1"><a id='lblMons'></a></td>
						<td align="center" class="td3"><a id='lblPart'></a></td>
						<td align="center" class="td3"><a id='lblItemno'></a></td>
						<td align="center" class="td3"><a id='lblItem'></a></td>
						<td align="center" class="td3"><a id='lblCheckno'></a></td>
						<td align="center" class="td3"><a id='lblAccount'></a></td>
						<td align="center" class="td2"><a id='lblBankno'></a></td>
						<td align="center" style="width:12%;"><a id='lblBank'></a></td>
						<td align="center" style="width:7%;"><a id='lblIndate'></a></td>
						<td align="center"><a id='lblMemos'></a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td >
						<input class="txt c1"  id="txtTypea.*" type="text" />
						</td>
						<td >
						<input class="txt c1" id="txtMoney.*" type="text" style="text-align: right;" />
						</td>
						<td >
						<input class="txt c1" id="txtChgs.*" type="text" style="text-align: right;" />
						</td>
						<td >
						<input class="txt c1" id="txtPaysale.*" type="text" style="text-align: right;"/>
						</td>
						<td >
						<input class="txt c1" id="txtMon.*" type="text" />
						</td>
						<td >
						<input id="txtPartno.*" type="text" style="width: 30%;" />
						<input id="txtPart.*" type="text" style="width: 55%;"/>
						</td>
						<td >
						<input id="txtItemno.*" type="text" style="width: 75%;"/>
						<input id="btnItemno.*" type="button" value=".." style="width: 15%;"/>
						</td>
						<td >
						<input class="txt c1" id="txtItem.*" type="text" />
						</td>
						<td >
						<input class="txt c1" id="txtCheckno.*" type="text" />
						</td>
						<td >
						<input class="txt c1" id="txtAccount.*" type="text"  />
						</td>
						<td >
						<input class="txt c1" id="txtBankno.*" type="text" />
						</td>
						<td >
						<input class="txt c1" id="txtBank.*" type="text" />
						</td>
						<td >
						<input class="txt c1" id="txtIndate.*" type="text" />
						</td>
						<td >
						<input class="txt c1" id="txtMemo.*" type="text" />
						<input id="txtNoq.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
