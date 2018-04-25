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
            var q_name = "tranorde";
            var q_readonly = ['txtNoa', 'txtWeight','txtTotal', 'txtWorker', 'txtWorker2'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            q_desc = 1;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 13;
            aPop = new Array(['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
                , ['txtAddrno', 'lblAddrno_ay', 'addr', 'noa,addr', 'txtAddrno,txtAddr', 'addr_b.aspx']
                , ['txtCbno', 'lblCbno_ay',  'addr', 'noa,addr', 'txtCbno,txtCaddr', 'addr_b.aspx']
                , ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
            );

            $(document).ready(function() {
                var t_where = '';
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

            function sum() {
            }

            function mainPost() {
                bbmMask = [['txtDatea', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
                q_cmbParse("cmbDldate",',北部,中部,南部,回頭車');
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                case q_name + '_s':
                    q_boxClose2(s2);
                    break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                case q_name:
                    if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
                }
            }

            function q_popPost(s1) {
            }

            function btnOk() {
            	sum();
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tranorde_ay_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txttrandate').val(q_date());
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            	//q_box('z_tran_sh.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function refresh(recno) {
                _refresh(recno);
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
                overflow: auto;
            }
            .dview {
                float: left;
                width: 400px;
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
                width: 630px;
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
                width: 12%;
            }
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            .font1 {
                font-family: "細明體", Arial, sans-serif;
            }
            #tableTranordet tr td input[type="text"] {
                width: 80px;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"> </a></td>
						<td align="center" style="display:none;"><a> </a></td>
						<td align="center" style="width:20%"><a>單據</a></td>
						<td align="center" style="width:30%"><a>客戶</a></td>
						<td align="center" style="width:30%"><a>地區</a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='comp'>~comp</td>
						<td align="center" id='dldate'>~dldate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa_ay" class="lbl" >單據</a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea_ay" class="lbl" >日期</a></td>
						<td><input id="txtDatea" type="text" class="txt c1" /></td>
					</tr>
					<tr>
                        <td><span> </span><a id="lblCno" class="lbl btn" >貨運公司</a></td>
                        <td colspan="3"><input id="txtCno" type="text" class="txt c1" style="width: 40%;"/>
                            <input id="txtAcomp" type="text" class="txt c1" style="width: 60%;"/></td>
                    </tr>
					<tr>
                        <td><span> </span><a id="lblCust" class="lbl btn" > </a></td>
                        <td colspan="3"><input id="txtCustno" type="text" class="txt c1" style="width: 40%;"/>
                            <input id="txtComp" type="text" class="txt c1" style="width: 60%;"/>
                            <input id="txtNick" type="text" class="txt c1" style="display: none;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblStype_ay" class="lbl" >地區</a></td>
                        <td><select id="cmbDldate" class="txt c1"> </select></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAddrno_ay" class="lbl btn" >起運點</a></td>
                        <td colspan="3"><input id="txtAddrno" type="text" class="txt c1" style="width: 40%;"/>
                            <input id="txtAddr" type="text" class="txt c1" style="width: 60%;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCbno_ay" class="lbl btn" >卸貨點</a></td>
                        <td colspan="3"><input id="txtCbno" type="text" class="txt c1" style="width: 40%;"/>
                            <input id="txtCaddr" type="text" class="txt c1" style="width: 60%;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblOption01_ay" class="lbl" >數量</a></td>
                        <td><input id="txtOption01" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblOption02_ay" class="lbl" >材積</a></td>
                        <td><input id="txtOption02" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id="lblCtweight2_ay" class="lbl" >重量</a></td>
                        <td><input id="txtCtweight2" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl" > </a></td>
                        <td colspan="3"><textarea id="txtMemo" style="height:60px;" class="txt c1"> </textarea></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo2_ay" class="lbl" >備註二</a></td>
                        <td colspan="3"><textarea id="txtMemo2" style="height:60px;" class="txt c1"> </textarea></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker_ay" class="lbl" >經手人</a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td></td>
                        <td><input id="chkEnda" type="checkbox"/>
                            <span> </span><a id='lblEnda_wj'>結案</a>
                        </td>
                    </tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden"/>
	</body>
</html>