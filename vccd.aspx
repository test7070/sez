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
            var q_name = "vccd";
            var q_readonly = ['txtNoa','txtInno','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [['txtWeight', 10, 3, 1],['txtPrice', 10, 3, 1],['txtTranmoney', 10, 3, 1]];
            var bbsNum = [['txtDime', 10, 3, 1],['txtWidth', 10, 3, 1],['txtLengthb', 10, 3, 1],['txtInmount', 10, 3, 1],
            			  ['txtInweight', 10, 3, 1],['txtMount', 10, 3, 1],['txtWeight', 10, 3, 1],['txtPrice', 10, 3, 1],
            			  ['txtTotal', 10, 3, 1],['txtTheory', 10, 3, 1],['txtRadius', 10, 3, 1]
            			 ];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 8;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
			var aPop = new Array(
				['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtMechno', 'lblMech', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'],
				['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtUno_', 'btnUno_', 'uccc', 'view_uccc', 'txtUno_', 'uccc_seek_b.aspx','95%','60%'],
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']
			);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1,0,'',r_accy);
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
                bbmMask = [['txtDatea', r_picd],['txtVdate', r_picd],['txtUdate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('sys.stktype'));
                q_cmbParse("cmbTrana", q_getPara('sys.tran'));
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
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
					case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

			function btnOk() {
            	if($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
                }
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vccd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
            }

            function bbsAssign() {
            	for (var j = 0; j < q_bbsCount; j++) {
                	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                		$('#txtMount_'+j).change(function(){sum();});
                		$('#txtPrice_'+j).change(function(){sum();});
                		$('#txtTotal_'+j).change(function(){sum();});
                	}
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
                $('#txtDatea').focus();
                sum();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['ordeno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
                var t_mount,t_price,t_money;
                for (var j = 0; j < q_bbsCount; j++) {
					t_mount = dec($('#txtMount_'+j).val());
					t_price = dec($('#txtPrice_'+j).val());
					t_money = round(t_mount * t_price,0);
					$('#txtTotal_'+j).val(t_money);
                } 
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
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                width: 250px;
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
                width: 950px;
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
                font-size: medium;
            }
            .dbbs {
                width: 250%;
                float:left;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs input[type="text"] {
                width: 95%;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"], select {
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
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="noa" style="text-align: center;">~noa</td>
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
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCno' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCno"type="text" class="txt" style="width: 30%"/>
							<input id="txtAcomp"  type="text"  class="txt" style="width: 70%"/>
						</td>
						<td><span> </span><a id='lblMech' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtMechno" type="text" style="float:left; width:30%;"/>
							<input id="txtMech" type="text" style="float:left; width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno" type="text" style="float:left; width:30%;"/>
							<input id="txtCust" type="text" style="float:left; width:70%;"/>
						</td>
						<td><span> </span><a id='lblBkaddr' class="lbl"> </a></td>
						<td><input id="txtBkaddr"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSalesno" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno"  type="text" style="width:30%; float:left;"/>
							<input id="txtSales"  type="text" style="width:70%; float:left;"/>
						</td>
						<td><span> </span><a id='lblVdate' class="lbl"> </a></td>
						<td><input id="txtVdate"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblUdate' class="lbl"> </a></td>
						<td><input id="txtUdate"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo"  class="lbl"> </a></td>
						<td colspan="6"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCar' class="lbl"> </a></td>
						<td><input id="txtCar"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td><input id="txtCarno"  type="text" class="txt c1"/></td>
						<td><select id="cmbTrana" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr"  class="lbl"> </a></td>
						<td colspan="6"><input id="txtAddr"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td><input id="txtTranmoney"  type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInno' class="lbl"> </a></td>
						<td><input id="txtInno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:6%;"><a id='lblUno_s'> </a></td>
					<td align="center" style="width:6%;"><a id='lblOrdeno_s'> </a></td>
					<td align="center" style="width:5%;"><a id='lblSize_s'> </a></td>
					<td align="center" style="width:5%;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:5%;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:5%;"><a id='lblSpec_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblDime_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblWidth_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblLengthb_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblInmount_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblInweight_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:2%;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:6%;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:2%;"><a id='lblUsecoil_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblTheory_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblStyle_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblRadius_s'> </a></td>
					<td align="center" style="width:6%;"><a id='lblUno2_s'> </a></td>
					<td align="center" style="width:5%;"><a id='lblStoreno_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblClass_s'> </a></td>
					<td align="center" style="width:2%;"><a id='lblWaste_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblClass2_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*"  style="display:none;"/>
					</td>
					<td><input class="txt c1" id="txtUno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnUno.*" type="button" value='.' style="width:1%;"/></td>
					<td >
						<input  id="txtOrdeno.*" type="text" class="txt" style="width: 70%;"/>
                		<input  id="txtNo2.*" type="text" class="txt" style="width: 20%;"/>
                	</td>
					<td><input id="txtSize.*" type="text" class="txt c1"/></td>
					<td>
						<input id="btnProductno.*" type="button" value="." style="width: 10%; font-size: medium;" />
						<input  id="txtProductno.*" type="text" style="width: 70%;"/>
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtSpec.*" type="text" class="txt c1"/></td>
					<td><input id="txtDime.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWidth.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtInmount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtInweight.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtTotal.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
					<td><input id="txtUsecoil.*" type="text" class="txt c1"/></td>
					<td><input id="txtTheory.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtStyle.*" type="text" class="txt c1"/></td>
					<td><input id="txtRadius.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUno2.*" type="text" class="txt c1"/></td>
					<td><input id="txtStoreno.*" type="text" class="txt c1"/></td>
					<td><input id="txtClass.*" type="text" class="txt c1"/></td>
					<td><input id="txtWaste.*" type="text" class="txt c1"/></td>
					<td><input id="txtClass2.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
