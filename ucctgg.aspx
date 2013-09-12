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
            var q_name = "ucctgg";
            var q_readonly = ['txtNoa','txtWorker', 'txtWorker2','txtPredate','txtMount','txtPrice'];
            var q_readonlys = ['txtTotal'];
            var bbmNum = [['txtMinmount', 10, 0, 1], ['txtMount', 10, 2, 1], ['txtPrice', 15, 2, 1]];
            var bbsNum = [['txtMount', 10, 0, 1], ['txtPrice', 15, 3, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 7;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
            ,['txtProductno', 'lblProduct', 'ucc', 'noa,product,unit', 'txtProductno,txtProduct,txtUnit', 'ucc_b.aspx']
            );
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
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
                bbmMask = [['txtPredate', r_picd],['txtPricedate', r_picd]];
                q_mask(bbmMask);
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
                }  /// end switch
            }

            function btnOk() {
            	                	
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if(q_cur==1)
                	$('#txtWorker').val(r_name);
                else
                	$('#txtWorker2').val(r_name);
                	
                var t_noa = trim($('#txtNoa').val());
               	var t_porductno = trim($('#txtPorductno').val());
		        var t_tggno = trim($('#txtTggno').val());
		        if (t_noa.length == 0)
		            q_gtnoa(q_name, t_porductno+'-'+t_tggno);
		        else
		            wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('ucctgg_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }
            function bbsAssign() {           
                for (var j = 0; j < q_bbsCount; j++) {
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            	$('#txtPricedate').val(q_date());
            	
            	if(window.parent.q_name=='ucc'){
					var wParent = window.parent.document;
					var t_productno= wParent.getElementById("txtNoa").value
					var t_product= wParent.getElementById("txtProduct").value
					var t_unit= wParent.getElementById("txtUnit").value
					$('#txtProductno').val(t_productno);
					$('#txtProduct').val(t_product);
					$('#txtUnit').val(t_unit);
           		}
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                sum();
            }

            function btnPrint() {
                q_box("z_ucctgg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'bccin', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['mount']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                
                return true;
            }

            function sum() {
                var t_mount, t_price = 0;
                for (var j = 0; j < q_bbsCount; j++) {
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
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"],select {
                font-size: medium;
            }
            .num {
                text-align: right;
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
						<td align="center" style="width:1%; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:34%; color:black;"><a id='vewTgg'> </a></td>
						<td align="center" style="width:65%; color:black;"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="tgg" style="text-align: center;">~tgg</td>
						<td id="product" style="text-align: center;">~product</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td><input id="txtNoa"  type="hidden" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtProductno"  type="text" style="float:left; width:30%;"/>
							<input id="txtProduct"  type="text" style="float:left; width:70%;"/>
						</td>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtTggno"  type="text" style="float:left; width:30%;"/>
							<input id="txtTgg"  type="text" style="float:left; width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMinmount' class="lbl"> </a></td>
						<td><input id="txtMinmount"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblPricedate' class="lbl"> </a></td>
						<td><input id="txtPricedate"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblUnit' class="lbl"> </a></td>
						<td><input id="txtUnit"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPredate' class="lbl"> </a></td>
						<td><input id="txtPredate"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td><input id="txtMount"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width: 10%;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblPrice_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;width:1%;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input id="txtMount.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtPrice.*" type="text" style="width: 95%;text-align: right;" /></td>
					<td><input id="txtMemo.*"type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
