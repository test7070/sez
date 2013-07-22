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
			//sea
            q_tables = 't';
            var q_name = "cub";
            var q_readonly = ['txtNoa'];
            var q_readonlys = [];
            var q_readonlyt = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 5;

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
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
            	bbmMask = [['txtDatea',r_picd]];
            	bbtMask = [['txtDate2',r_picd],['txtDate3',r_picd]]
                q_mask(bbmMask);
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
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
                //if (q_cur > 0 && q_cur < 4)
                //    sum();
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
                    }
                }
                _bbsAssign();
            }

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    }
                }
                _bbtAssign();
            }

            function sum() {
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
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
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
                width: 70%;
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
                width: 95%;
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
                width: 130%;
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
                width: 230%;
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
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>
							<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
							<input id="txtDatea"  type="text" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:80px;"><a id='lbl_uno'> </a></td>
						<td style="width:80px;"><a id='lbl_productno'> </a></td>
						<td style="width:80px;"><a id='lbl_spec'> </a></td>
						<td style="width:80px;"><a id='lbl_dime'> </a></td>
						<td style="width:80px;"><a id='lbl_width'> </a></td>
 						<td style="width:80px;"><a id='lbl_lengthb'> </a></td>
						<td style="width:80px;"><a id='lbl_weight'> </a></td>
						<td style="width:30px;"><a id='lbl_sale'> </a></td>
						<td style="width:30px;"><a id='lbl_ordc'> </a></td>
						<td style="width:30px;"><a id='lbl_lget'> </a></td>
						<td style="width:30px;"><a id='lbl_jget'> </a></td>
						<td style="width:80px;"><a id='lbl_oth'> </a></td>
						<td style="width:80px;"><a id='lbl_source'> </a></td>
						<td style="width:80px;"><a id='lbl_ordcno'> </a></td>
						<td style="width:80px;"><a id='lbl_storeno'> </a></td>
						<td style="width:80px;"><a id='lbl_store'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input class="txt c1" id="txtUno.*" type="text"/></td>
						<td><input class="txt c1" id="txtProductno.*" type="text"/></td>
						<td><input class="txt c1" id="txtSpec.*" type="text"/></td>
						<td><input class="txt c1 num" id="txtDime.*" type="text"/></td>
						<td><input class="txt c1 num" id="txtWidth.*" type="text"/></td>
						<td><input class="txt c1 num" id="txtLengthb.*" type="text"/></td>
						<td><input class="txt c1 num" id="txtWeight.*" type="text"/></td>
						<td><input id="chkSale.*" type="checkbox"/></td>
						<td><input id="chkOrdc.*" type="checkbox"/></td>
						<td><input id="chkLget.*" type="checkbox"/></td>
						<td><input id="chkJget.*" type="checkbox"/></td>
						<td><input class="txt c1" id="txtOth.*" type="text"/></td>
						<td><input class="txt c1" id="txtSource.*" type="text"/></td>
						<td><input class="txt c1" id="txtOrdcno.*" type="text"/></td>
						<td><input class="txt c1" id="txtStoreno.*" type="text"/></td>
						<td><input class="txt c1" id="txtStore.*" type="text"/></td>
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
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:120px; text-align: center;">訂購單編號</td>
						<td style="width:120px; text-align: center;">預交日期</td>
						<td style="width:120px; text-align: center;">客戶編號</td>
						<td style="width:120px; text-align: center;">客戶名稱</td>
						<td style="width:120px; text-align: center;">品名編號</td>
						<td style="width:120px; text-align: center;">品名</td>
						<td style="width:120px; text-align: center;">規格</td>
						<td style="width:120px; text-align: center;">預定出貨日期</td>
						<td style="width:80px; text-align: center;">厚度</td>
						<td style="width:80px; text-align: center;">寬度</td>
						<td style="width:80px; text-align: center;">長度</td>
						<td style="width:80px; text-align: center;">重量</td>
						<td style="width:80px; text-align: center;">數量</td>
						<td style="width:80px; text-align: center;">單價</td>
						<td style="width:60px; text-align: center;">等級</td>
						<td style="width:80px; text-align: center;">小計</td>
						<td style="width:80px; text-align: center;">硬度</td>
						<td style="width:120px; text-align: center;">表色</td>
						<td style="width:120px; text-align: center;">底色</td>
						<td style="width:120px; text-align: center;">結案</td>
						<td style="width:120px; text-align: center;">取消</td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtOrdeno..*" type="text" class="txt c1"/></td>
						<td><input id="txtDate2..*" type="text" class="txt c1"/></td>
						<td><input id="txtCustno..*" type="text" class="txt c1"/></td>
						<td><input id="txtComp..*" type="text" class="txt c1"/></td>
						<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
						<td><input id="txtProduct..*" type="text" class="txt c1"/></td>
						<td><input id="txtSpec..*" type="text" class="txt c1"/></td>
						<td><input id="txtDate3..*" type="text" class="txt c1"/></td>
						<td><input id="txtDime..*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWidth..*" type="text" class="txt c1 num"/></td>
						<td><input id="txtLength..*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWeight..*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMount..*" type="text" class="txt c1 num"/></td>
						<td><input id="txtPrice..*" type="text" class="txt c1 num"/></td>
						<td><input id="txtClass..*" type="text" class="txt c1"/></td>
						<td><input id="txtTotal..*" type="text" class="txt c1 num"/></td>
						<td><input id="txtHard..*" type="text" class="txt c1 num"/></td>
						<td><input id="txtScolor..*" type="text" class="txt c1"/></td>
						<td><input id="txtUcolor..*" type="text" class="txt c1"/></td>
						<td><input id="txtEnda..*" type="text" class="txt c1"/></td>
						<td><input id="txtCancel..*" type="text" class="txt c1"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
