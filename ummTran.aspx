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
            var q_name = "umm";
            var q_readonly = ['txtNoa','txtWorker'];
            var q_readonlys = [];
            var bbmNum = [['txtTotal', 10, 3]];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], ['txtCustno', 'btnCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], ['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx']);

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
                mainForm(1);
            }

            function mainPost() {

                fbbm[fbbm.length] = 'txtMemo';
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);

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
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                $('#txtWorker').val(r_name)
                sum();

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('cng_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
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
                if(!as['type']) {
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

                }  // j

            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
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
                /// 表身運算式
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
                width: 23%;
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
                width: 75%;
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
                font-size: 16px;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 150%;
            }
            .tbbs a {
                font-size: 14px;
            }
            .tbbs input[type="text"] {
                font-size: 14px;
            }
            .num {
                text-align: right;
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
						<td align="center" style="width:25%"><a id='vewDatea'></a></td>
						<td align="center" style="width:40%"><a id='vewComp'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='cno acomp'>~cno ~acomp</td>
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
						<td class="td1" ><span> </span><a id='lblAcomp' class="lbl"></a></td>
						<td class="td2" colspan="2">
						<input id="txtCno"  type="text" class="txt c4"/>
						<input id="txtAcomp"    type="text" class="txt c5"/>
						</td>
						<td class="td4"><span> </span><a id='lblCust' class="lbl"></a></td>
						<td class="td5" colspan="2">
						<input id="txtCustno" type="text" class="txt c4"/>
						<input id="txtComp"  type="text" class="txt c5"/>
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
						<td class="td1"><span> </span><a id='lblOpay' class="lbl"></a></td>
						<td class="td2">
						<input id="txtOpay"  type="text" class="txt num c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblUnopay' class="lbl"></a></td>
						<td class="td4">
						<input id="txtUnopay"  type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblAccno' class="lbl"></a></td>
						<td class="td6">
						<input id="txtAccno"  type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td class="td8" >
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan='6' >						<textarea id="txtMemo" style="width: 99%; height: 50px;" ></textarea></td>
					</tr>
				</table>
			</div>

			<div class='dbbs' >
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td align="center">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" class="td3"><a id='lblTypea'></a></td>
						<td align="center" class="td2"><a id='lblMoney'></a></td>
						<td align="center" class="td2"><a id='lblChgs'></a></td>
						<td align="center" class="td2"><a id='lblPaysales'></a></td>
						<td align="center" class="td1"><a id='lblMons'></a></td>
						<td align="center" class="td3"><a id='lblPart'></a></td>
						<td align="center" class="td2"><a id='lblUmmbno'></a></td>
						<td align="center" class="td3"><a id='lblUmmb'></a></td>
						<td align="center" class="td3"><a id='lblCheckno'></a></td>
						<td align="center" class="td3"><a id='lblAccount'></a></td>
						<td align="center" class="td3"><a id='lblBankno'></a></td>
						<td align="center" style="width: 12%;"><a id='lblBank'></a></td>
						<td align="center" class="td2"><a id='lblIndate'></a></td>
						<td align="center"><a id='lblMemos'></a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td>
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td>
						<input class="txt c8"  id="txtTypea.*" type="text" />
						</td>
						<td>
						<input class="txt c7" id="txtMoney.*" type="text" />
						</td>
						<td>
						<input class="txt c7" id="txtChgs.*" type="text" />
						</td>
						<td>
						<input class="txt c7" id="txtPaysale.*" type="text" />
						</td>
						<td>
						<input class="txt c8" id="txtMon.*" type="text" />
						</td>
						<td>
						<input  id="txtPartno.*" type="text"  style="width: 30%;"/>
						<input id="txtPart.*" type="text" style="width: 55%;"/>
						</td>
						<td>
						<input class="txt c8" id="txtUmmbno.*" type="text" />
						</td>
						<td>
						<input class="txt c8" id="txtUmmb.*" type="text"  />
						</td>
						<td>
						<input class="txt c8" id="txtCheckno.*" type="text" />
						</td>
						<td>
						<input class="txt c8" id="txtAccount.*" type="text" />
						</td>
						<td>
						<input class="txt c6" id="txtBankno.*" type="text" />
						<input id="btnBankno.*" type="button" value="." />
						</td>
						<td>
						<input class="txt c8" id="txtBank.*" type="text"  />
						</td>
						<td>
						<input class="txt c8" id="txtIndate.*" type="text"  />
						</td>
						<td>
						<input class="txt c8" id="txtMemo.*" type="text"  />
						<input id="txtNoq.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
