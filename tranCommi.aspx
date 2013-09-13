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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            isEditTotal = false;
            q_tables = 's';
            var q_name = "trancommi";
            var q_readonly = ['txtNoa','txtWorker'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtInprice1', 15, 3, 1],['txtInprice2', 15, 3, 1],['txtOutprice1', 15, 3, 1],['txtOutprice2', 15, 3, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 4;
            brwCount = 4;
            brwCount2 = 4;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
			aPop = new Array(
								['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'], 
								['txtAddrno', 'lblAddr', 'addr', 'noa,addr', 'txtAddrno,txtAddr', 'addr_b.aspx'], 
								['txtSalesno', 'lblSales', 'cust', 'noa,comp', 'txtSalesno,txtSales', 'cust_b.aspx']
								/*['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']*/
							);

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
                mainForm(0);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea',r_picd]];
                q_mask(bbmMask);
                bbsMask = [['txtDatea',r_picd]];
                q_mask(bbsMask);
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

            function btnOk() {
            	$('#txtWorker').val(r_name);
                var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll('Z'+(t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('trancommi_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                }
                _bbsAssign();
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
                $('#txttrancommi').focus();
            }

            function btnPrint() {
                q_box('z_trancommi.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
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
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 260px; 
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
                width: 690px;
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
                width: 20%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                font-size:medium;
            }
            .dbbs {
                width: 950px;
            }
            .tbbs a {
                font-size: medium;
            }
            
            .num {
                text-align: right;
            }
			input[type="text"],input[type="button"] {
                font-size:medium;
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
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNick'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewAddr'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='addr' style="text-align: center;">~addr</td>
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
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtCustno" type="text" style="float:left; width:40%;"/>
							<input id="txtComp" type="text" style="float:left; width:60%;"/>
							<input id="txtNick" type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtAddrno" type="text" style="float:left; width:40%;"/>
							<input id="txtAddr" type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" style="float:left; width:40%;"/>
							<input id="txtSales" type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:50px;"><a id='lblDatea_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblInprice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblOutprice_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td >
						<input type="text" id="txtDatea.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtInprice1.*" style="width:45%;text-align:right;" />
						<input type="text" id="txtInprice2.*" style="width:45%;text-align:right;" />
					</td>
					<td>
						<input type="text" id="txtOutprice1.*" style="width:45%;text-align:right;" />
						<input type="text" id="txtOutprice2.*" style="width:45%;text-align:right;" />
					</td>
					<td>
						<input type="text" id="txtMemo.*" style="width:95%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
