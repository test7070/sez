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

            q_desc = 1
            q_tables = 's';
            var q_name = "bccinx";
            var q_readonly = ['txtNoa', 'txtWorker','txtWorker2'];
            var q_readonlys = ['txtMech','txtPart','txtStore'];
            var bbmNum = [];
            var bbsNum = [['txtMount', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 7;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(
             ['txtBccno_', 'btnBccno_', 'bcc', 'noa,product,unit', 'txtBccno_,txtBccname_,txtUnit_', 'bcc_b.aspx']
             ,['txtPartno_', 'btnPartno_', 'part', 'noa,part', 'txtPartno_,txtPart_', 'part_b.aspx']
             ,['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
             ,['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx']
            );
            
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
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
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
                if(q_cur==1)
                	$('#txtWorker').val(r_name);
                else
                	$('#txtWorker2').val(r_name);
                	
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
               	var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_bccinx')  + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('bccinx_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }
            
            function bbsAssign() {           
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')){
                    	
                    } 
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
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
                //q_box('z_bccin.aspx', '', "95%", "650px", q_getMsg("popPrint"));
                q_box("z_bccinx.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'bccin', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if ( !as['bccname']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['storeno'] = abbm2['storeno'];
                as['datea'] = abbm2['datea'];
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
						<td align="center" style="width:30%; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:39%; color:black;"><a id='vewNoa'> </a></td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
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
					<td align="center" style="width:1%;"> </td>
					<td align="center" style="width: 7%;"><a id='lblTypea'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblContract'> </a></td>
					<td align="center" style="width: 7%;"><a id='lblBccno'> </a></td>
					<td align="center" style="width: 13%;"><a id='lblBccname'> </a></td>
					<td align="center" style="width: 7%;"><a id='lblMount'> </a></td>
					<td align="center" style="width: 4%;"><a id='lblUnit'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblPart'> </a></td>
					<td align="center" style="width: 8%;"><a id='lblSource'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblMech'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblStore'> </a></td>
					<td align="center"><a id='lblMemos'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;width:1%;" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtTypea.*" type="text" style="width: 95%;" /></td>
					<td><input id="txtContract.*" type="text" style="width: 95%;" /></td>
					<td>
						<input id="btnBccno.*" type="button" value="." style="float:left;width: 20%;"/>
						<input id="txtBccno.*" type="text" style="float:left;width: 75%;" />
					</td>
					<td><input id="txtBccname.*" type="text" style="width: 95%;" /></td>
					<td><input id="txtMount.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtUnit.*" type="text" style="width: 95%;"/></td>
					<td>
						<input id="btnPartno.*" type="button" value="." style="float:left;width: 20%;"/>
						<input id="txtPartno.*" type="text" style="float:left;width: 75%;" />
						<input id="txtPart.*" type="text" style="float:left;width: 95%;" />
					</td>
					<td><input id="txtSource.*" type="text" style="width: 95%;"/></td>
					<td><input id="btnMechno.*" type="button" value="." style="float:left;width: 20%;"/>
						<input id="txtMechno.*" type="text" style="float:left;width: 75%;" />
						<input id="txtMech.*" type="text" style="float:left;width: 95%;" /></td>
					<td>
						<input id="btnStoreno.*" type="button" value="." style="float:left;width: 20%;"/>
						<input id="txtStoreno.*" type="text" style="float:left;width: 75%;" />
						<input id="txtStore.*" type="text" style="float:left;width: 95%;" />
					</td>
					<td><input id="txtMemo.*"type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
