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
            var q_name = "cara";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';

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
            }

          /*  aPop = [['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'], ['txtStoreno2', 'btnStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx', "60%", "650px", q_getMsg('popStore')], ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];*/

            function mainPost() {
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
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                $('#txtWorker').val(r_name)
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('cara_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['date'] = abbm2['date'];

                return true;
            }

            function sum() {
                var total = 0;
                for(var j = 0; j < q_bbsCount; j++) {
                    total = $('#txtInmoney_' + j).val() - $('#txtOutmoney_' + j).val();
                }
                $("#txtTotal").val(total);
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
            }
            .dbbm div {
                border: 1px solid #000000;
                border-radius: 5px;
            }
            .tbbm {
                margin: 0;
                padding: 2px;
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
            .tbbm .td1, .tbbm .td3, .tbbm .td5, .tbbm .td7,.tbbm .td9 {
                width: 9%;
                text-align: right;
            }
            .tbbm .td2, .tbbm  .td4, .tbbm  .td6, .tbbm .td8,.tbbm .td10 {
                width: 11%;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .lbl {
                float: right;
                color: blue;
                font-size: 16px;
            }
            .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 95%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.num{
            	text-align: right;
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
            .tbbm tr td input[type="button"] {
                width: auto;
                font-size: medium;
            }
            .tbbm tr td select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
             .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbs .ch1
            {
            	width: 10%;
            }
            .tbbs .ch2
            {
            	width: 7%;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width: 25%;"><a id='vewDatea'></a></td>
						<td align="center" style="width: 50%;"><a id='vewCarno'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea '>~datea</td>
						<td align="center" id='carno '>~carno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr=1">
						<td class="td1" ><span> </span><a id="lblCarno" ></a></td>
						<td class="td2">
						<input id="txtCarno"  type="text"  style='width:43%;'/>
						<input id="txtBoss"  type="text" style='width:43%;'/>
						</td>
						<td class="td3"><span> </span><a id='lblIprev'></a></td>
						<td class="td4"><input id="txtIprev" type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblIset'></a></td>
						<td class="td6"><input id="txtIset"  type="text" class="txt num c1"/></td>
						<td class="td7" style="font-size: 12px;"><span> </span><a id='lblBprev'></a></td>
						<td class="td8">
						<input id="txtBprev"  type="text" class="txt num c1"/>
						</td>
						<td class="td9"><span> </span><a id='lblCarseek'></a></td>
						<td class="td10">
						<input id="txtCarseek"  type="text" class="txt c2"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblMon'></a></td>
						<td class="td2">
						<input id="txtMon"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblInterest'></a></td>
						<td class="td4">
						<input id="txtInterest"  type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblIsource'></a></td>
						<td class="td6">
						<input id="txtIsource"  type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblBin' style="font-size: 12px;"></a></td>
						<td class="td8">
						<input id="txtBin" type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblPdate'></a></td>
						<td class="td2">
						<input id="txtPdate"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblItotal'></a></td>
						<td class="td4">
						<input id="txtItotal"  type="text" class="txt num c1"/>
						</td>
						<td class="td5"></td>
						<td class="td6"></td>
						<td class="td7"><span> </span><a id='lblBtotal' style="font-size: 12px;"></a></td>
						<td class="td8">
						<input id="txtBtotal"  type="text" class="txt num c1"/>
						</td>
						<td class="td9"><span> </span><a id='lblLastmon'></a></td>
						<td class="td10">
						<input id="txtLastmon"  type="text" class="txt c2"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblTotal'></a></td>
						<td class="td2">
						<input id="txtTotal"  type="text" class="txt num c1">
						</td>
						<td class="td3"></td>
						<td class="td4">
						<input id="btnNextmon" type="button" />
						</td>
						<td class="td5"><span> </span><a id='lblDatea'></a></td>
						<td class="td6">
						<input id="txtDatea"  type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblNoa'></a></td>
						<td class="td8">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>

			<div class='dbbs'>
				<table id="tbbs" class='tbbs' >
					<tr style='color:White; background:#003366;' >
						<td align="center">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" class="ch2"><a id='lblDateas'></a></td>
						<td align="center" class="ch2"><a id='lblNoq'></a></td>
						<td align="center" class="ch2"><a id='lblCaritemno'></a></td>
						<td align="center" class="ch1"><a id='lblCaritem'></a></td>
						<td align="center" class="ch1"><a id='lblOutmoney'></a></td>
						<td align="center" class="ch1"><a id='lblInmoney'></a></td>
						<td align="center"><a id='lblMemo'></a></td>
						<td align="center" class="ch2"><a id='lblPay'></a></td>
						<td align="center" class="ch2"><a id='lblAcc1'></a></td>
						<td align="center" class="ch1"><a id='lblAcc2'></a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td >
						<input id="txtDatea.*" type="text" class="txt c1" />
						<input id="recno.*" type="hidden" />
						</td>
						<td >
						<input id="txtNoq.*" type="text" class="txt c1"/>
						</td>
						<td >
						<input id="txtCaritemno.*" type="text" class="txt c1"/>
						</td>
						<td >
						<input id="txtCaritem.*" type="text" class="txt c1"/>
						</td>
						<td >
						<input id="txtOutmoney.*" type="text" class="txt num c1"/>
						</td>
						<td >
						<input id="txtInmoney.*" type="text" class="txt num c1"/>
						</td>
						<td >
						<input id="txtMemo.*" type="text" class="txt c1"/>
						</td>
						<td >
						<input id="txtPay.*" type="text" class="txt num c1"/>
						</td>
						<td >
						<input id="txtAcc1.*" type="text"class="txt c1"/>
						</td>
						<td >
						<input id="txtAcc2.*" type="text" class="txt c1"/>
						</td>

					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
