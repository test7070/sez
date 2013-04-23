<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			q_tables = 's';
            var q_name = "cicar";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
           aPop = new Array(['txtInsurerno', 'lblInsurer', 'ciinsu', 'noa,insurer', 'txtInsurerno,txtInsurer', 'ciinsu_b.aspx'],
            ['txtSalesno', 'lblSales', 'cisale', 'noa,namea', 'txtSalesno,txtSales', 'cisale_b.aspx'],
            ['txtInsutypeno_', 'btnInsutypeno_', 'ciinsutype', 'noa,insutype', 'txtInsutypeno_,txtInsutype_', 'ciinsutype_b.aspx'],
           	['txtCarno', 'lblCarno', 'cicust', 'noa,carowner,cardeal,usera,tel1,mobile,serial,birthday,zip_addr,addr,years,carbrand,cartype,passdate,cc,engineno', 'txtCarno,txtCarowner,txtCardeal,txtUsera,txtTelcar,txtMobilecar,txtSerialcar,txtBirthday,txtZipcar,txtAddrcar,txtYearscar,txtCarbrand,txtCartype,txtPassdate,txtCc,txtEngineno', 'ciinsu_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
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
                bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd],['txtEdate', r_picd],['txtBirthday', r_picd],['txtPassdate', r_picm]];
            	q_mask(bbmMask);
            	 $(".carcust").hide();
                
               $("#btnCarcust").val("＋");
				$("#btnCarcust").toggle(function(e) {
					$(".carcust").show();
					$("#btnCarcust").val("－");
				}, function(e) {
					$(".carcust").hide();
					$("#btnCarcust").val("＋");
				});
				
				$("#btnCaredit").val("車主新增/修改");
				$('#btnCaredit').click(function(e) {
					if(emp($('#txtCarno').val()))
						q_box("cicust.aspx?;;;;", 'cicust', "90%", "600px", q_getMsg("popCicust"));
					else
						q_box("cicust.aspx?;;;noa='" + $('#txtCarno').val() + "'", 'cicust', "90%", "600px", q_getMsg("popCicust"));
				});
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
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            
            function btnOk() {
				if(q_cur==1)
	           	$('#txtWorker').val(r_name);
	        else
	           	$('#txtWorker2').val(r_name);
	           	sum();
				t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
               
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll('F' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                    q_box('cicar_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
            }
           
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
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
             
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    }
                
                }
                _bbsAssign();
            }

            function bbsSave(as) {
                if (!as['insutypeno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                
                return true;
            }

            function sum() {
            var t1 = 0,t_cost = 0, t_total = 0;
            for (var j = 0; j < q_bbsCount; j++) {
				t_cost+=dec($('#txtCost_'+j).val());
				t_total+=dec($('#txtTotal_'+j).val());
            }  // j
			q_tr('txtTotal',t_cost);
			q_tr('txtPay',t_total);
            	if(!(q_cur==1 || q_cur==2))
					return;
					
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
                width: 30%;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
                width: 100%;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 25%;
                float: left;
            }
            .txt.c3 {
                width: 75%;
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
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
                width: 100%;
            }
			.carcust{
				background: #FFBB73;
			}
            .num {
                text-align: right;
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
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px;color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:100px;color:black;"><a id='vewCardno'> </a></td>
						<td align="center" style="width:100px;color:black;"><a id='vewInsurancenum'> </a></td>
						<td align="center" style="width:100px;color:black;"><a id='vewInsurer'> </a></td>
						<td align="center" style="width:100px;color:black;"><a id='vewSales'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="cardno" style="text-align: center;">~cardno</td>
						<td id="insurancenum" style="text-align: center;">~insurancenum</td>
						<td id="insurer" style="text-align: center;">~insurer</td>
						<td id="sales" style="text-align: center;">~sales</td>
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
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtNoa" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtDatea" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtCarno" class="txt c1"/>	</td>
						<td style="text-align: center;"><input id="btnCarcust" type="button" style="width:50%;"/></td>
						<td style="text-align: center;"><input id="btnCaredit" type="button" /></td>
					</tr>
					<tr class="carcust">
						<td class="td1"><span> </span><a id='lblCarowner_car' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtCarowner" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblCardeal_car' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtCardeal" class="txt c1"/>	</td>
						<td class="td5"><span> </span><a id='lblUsera_car' class="lbl"> </a></td>
						<td class="td6"><input type="text" id="txtUsera" class="txt c1"/>	</td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="carcust">
						<td class="td1"><span> </span><a id='lblTel_car' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtTelcar" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblMobile_car' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtMobilecar" class="txt c1"/>	</td>
						<td class="td1"><span> </span><a id='lblSerial_car' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtSerialcar" class="txt c1"/>	</td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="carcust">
						<td class="td1"><span> </span><a id='lblBirthday_car' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtBirthday" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblAddr_car' class="lbl"> </a></td>
						<td class="td4" colspan="3"><input type="text" id="txtZipcar" class="txt c2"/>
						<input type="text" id="txtAddrcar" class="txt c3"/>	</td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="carcust">
						<td class="td1"><span> </span><a id='lblYears_car' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtYearscar" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblCarbrand_car' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtCarbrand" class="txt c1"/>	</td>
						<td class="td5"><span> </span><a id='lblCartype_car' class="lbl"> </a></td>
						<td class="td6"><input type="text" id="txtCartype" class="txt c1"/>	</td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="carcust">
						<td class="td1"><span> </span><a id='lblPassdate_car' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtPassdate" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblCc_car' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtCc" class="txt c1"/>	</td>
						<td class="td5"><span> </span><a id='lblEngineno_car' class="lbl"> </a></td>
						<td class="td6"><input type="text" id="txtEngineno" class="txt c1"/>	</td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblInsurer' class="lbl btn"> </a></td>
						<td class="td2" colspan="2"><input type="text" id="txtInsurerno" class="txt c2"/>
						<input type="text" id="txtInsurer" class="txt c3"/>	</td>
						<td class="td3"><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td class="td4" colspan="2"><input type="text" id="txtSalesno" class="txt c2"/>	
						<input type="text" id="txtSales" class="txt c3"/>	</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCardno' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtCardno" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblInsurancenum' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtInsurancenum" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtBdate" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblEdate' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtEdate" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtTotal" class="txt num c1"/>	</td>
						<td class="td3"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtMoney" class="txt num c1"/>	</td>
						<td class="td5"><span> </span><a id='lblPay' class="lbl"> </a></td>
						<td class="td6"><input type="text" id="txtPay" class="txt num c1"/>	</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="5"><input type="text" id="txtMemo" class="txt c1"/>	</td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtWorker" class="txt c1"/></td>
						<td class="td1"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtWorker2" class="txt c1"/></td>	
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:2%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:8%;"><a id='lblInsutypeno_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblInsutype_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblCoda_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblCost_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblDiscount_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblPlus_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input id="btnInsutypeno.*" type="button" value="." style="float:left;width: 20%;"/>
						<input id="txtInsutypeno.*" type="text" style="width: 75%;"/></td>
					<td><input id="txtInsutype.*" type="text" class="txt c1"/></td>
					<td><input id="txtCoda.*" type="text" class="txt num c1"/></td>
					<td><input id="txtCost.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDiscount.*" type="text" class="txt num c1"/></td>
					<td><input id="txtTotal.*" type="text" class="txt num c1"/></td>
					<td><input id="txtPlus.*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
