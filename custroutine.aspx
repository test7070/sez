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
            q_desc=1;
			q_tables = 's';
            var q_name = "custroutine";
            var q_readonly = ['txtNoa','txtPartno','txtPart'];
			var q_readonlys = ['txtMoney'];
            var bbmNum = [];
		    var bbsNum = [['txtPrice', 10, 1, 1], ['txtMount', 10, 1, 1], ['txtMoney', 10, 0, 1]];
            var bbmMask = [];
		    var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 7;//15
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtSalesno', 'lblSales', 'sss', 'noa,namea,partno,part', 'txtSalesno,txtSales,txtPartno,txtPart', 'sss_b.aspx']
            , ['txtProductno', 'lblProductno', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx']
            ,['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx']
            ,['txtCno_', 'btnCno_', 'acomp', 'noa,acomp', 'txtCno_,txtAcomp_', 'acomp_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
                // 1=Last  0=Top
            }

            function mainPost() {
                q_mask(bbmMask);
        		bbsMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbsMask);
                q_cmbParse("cmbTypea", ','+q_getPara('lab_accc.typea'));
                $('#cmbTypea').change(function(){
                	cmbTypea_chg();
                })
            }
			function cmbTypea_chg(){
               	for(var j = 0;j < q_bbsCount;j++){
		               if($('#cmbTypea').val().substr(0,2) == '發票'){
	                		$('#txtCno_' + j).removeAttr('disabled');
	           				$('#txtAcomp_' + j).removeAttr('disabled');
	           				$('#btnCno_' + j).removeAttr('disabled');
	           				$('#txtTaxrate_' + j).removeAttr('disabled');
		               		$('#txtMount_' + j).attr('disabled','disabled');
		               		$('#txtPrice_' + j).attr('disabled','disabled');	                		
	                	}else if($('#cmbTypea').val().substr(0,2) == '會計'){
               				$('#txtCno_' + j).attr('disabled','disabled');
               				$('#txtAcomp_' + j).attr('disabled','disabled');
               				$('#btnCno_' + j).attr('disabled','disabled');
               				$('#txtTaxrate_' + j).attr('disabled','disabled');
	                		$('#txtMount_' + j).removeAttr('disabled');
	                		$('#txtPrice_' + j).removeAttr('disabled');                		
	                	}else{
	                		$('#txtMount_' + j).removeAttr('disabled');
	                		$('#txtPrice_' + j).removeAttr('disabled'); 
	                		$('#txtCno_' + j).removeAttr('disabled');
	           				$('#txtAcomp_' + j).removeAttr('disabled');
	           				$('#btnCno_' + j).removeAttr('disabled');
	           				$('#txtTaxrate_' + j).removeAttr('disabled');  
	                	}
	           }
			}
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);                      
                        break;
                }  
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('custroutine_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtSalesno').focus();
                cmbTypea_chg();
            }
            
	        function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           				$('#txtMount_' + j).change(function() {
           					t_IdSeq = -1;
                        	q_bodyId($(this).attr('id'));
                        	b_seq = t_IdSeq;
							$('#txtMoney_' + b_seq).val($('#txtMount_' + b_seq).val() * $('#txtPrice_' + b_seq).val());  
						});
           				$('#txtPrice_' + j).change(function() {
           					t_IdSeq = -1;
                        	q_bodyId($(this).attr('id'));
                        	b_seq = t_IdSeq;
							$('#txtMoney_' + b_seq).val($('#txtMount_' + b_seq).val() * $('#txtPrice_' + b_seq).val());  
						});
           			}
            	}
	            _bbsAssign();
	            cmbTypea_chg();
	        }
	       
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtSalesno').focus();
                cmbTypea_chg();
            }

            function btnPrint() {

            }

            function btnOk() {
                var t_noa = trim($('#txtNoa').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
                else
                    wrServer(t_noa);
            }
			
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }
            
	        function bbsSave(as) {
	        	/*
	            if (!as['custno'] ) {  
	                as[bbsKey[1]] = '';   
	                return;
	            }
	            */
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
                width: 25%; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
                width: 100%;

            }
            .tview tr {
                height: 32px;
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
                width: 75%;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewSales'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='sales' style="text-align: center;">~sales</td>
						<td id='product' style="text-align: left;">~product</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" style="float:left;"/>
						</td>	
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td>
							<input id="txtSalesno" type="text" style="float:left; width:40%;"/>
							<input id="txtSales" type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPartno" class="lbl"> </a></td>
						<td>
							<input id="txtPartno" type="text" style="display:none;"/>
							<input id="txtPart" type="text" class="txt c1"/>
						</td>

					</tr>
					<tr>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>						
					</tr>
					<tr>
						<td><span> </span><a id="lblProductno" class="lbl btn"> </a></td>
						<td>
							<input id="txtProductno" type="text" style="float:left; width:30%;"/>
							<input id="txtProduct" type="text" style="float:left; width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="2"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" style="width:18%"><a id='lblCustnos'></a></td>
                <td align="center" style="width:7%"><a id='lblMounts'></a></td>
                <td align="center" style="width:7%"><a id='lblPrices'></a></td>
                <td align="center" style="width:7%"><a id='lblMoneys'></a></td>
                <td align="center" style="width:18%"><a id='lblCnos'></a></td>
                <td align="center" style="width:7%"><a id='lblTaxrates'></a></td>
                <td align="center" style="width:15%"><a id='lblMemos'></a></td>
                <td align="center" style="width:7%"><a id='lblBdate'></a></td>
                <td align="center" style="width:7%"><a id='lblEdate'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td >
					<input class="txt" id="txtCustno.*" type="text" style="width:25%;"/>
					<input class="txt" id="txtComp.*"type="text" style="width:55%;"/>
					<input id="btnCustno.*" type="button" value="." style="width: 10%;" />
                </td>
                <td ><input id="txtMount.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtPrice.*" type="text" class="txt num c1"/></td>
                <td ><input id="txtMoney.*" type="text" class="txt num c1"/></td>
                <td >
					<input class="txt" id="txtCno.*" type="text" style="width:25%;"/>
					<input class="txt" id="txtAcomp.*"type="text" style="width:55%;"/>
					<input id="btnCno.*" type="button" value="." style="width: 10%;" />
                </td>
                <td ><input id="txtTaxrate.*" type="text" class="txt num c1"/></td>
                <td >
                	<input  id="txtMemo.*" type="text" class="txt c1"/>
                	<input id="txtNoq.*" type="hidden" />
                </td>
                <td><input id="txtBdate.*" type="text" class="txt c1"/></td>
                <td><input id="txtEdate.*" type="text" class="txt c1"/></td>
                
            </tr>
        </table>
        </div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
