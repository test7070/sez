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

            q_tables = 't';
            var q_name = "cuw";
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
            brwCount2 = 10;

            aPop = new Array(
            	['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx'],
            	['txtSalesno__', 'btnSalesno__', 'sss', 'noa,namea', 'txtSalesno__,txtSales__', 'sss_b.aspx'],
            	['txtMechno__', 'btnMechno__', 'mech', 'noa,mech', 'txtMechno__,txtMech__', 'mech_b.aspx']
            );

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy );
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
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
            
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
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
                q_box('cuw_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
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
                //q_box('z_borr.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

			function btnOk() {
	            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
	            if (t_err.length > 0) {
	                alert(t_err);
	                return;
	            }
	
	            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
	            if (s1.length == 0 || s1 == "AUTO")   
	                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cuw') + q_date(), '/', ''));
	            else
	                wrServer(s1);
			}

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
              if (!as['mechno'] && !as['mech'] ) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
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
                width: 300px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                width: 100%;
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
                width: 650px;
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
                width: 100%;
                float: left;
            }
            
            .txt.c2 {
                width: 130%;
                float: left;
            }
            .txt.c3 {
                width: 95%;
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
                width: 100%;
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
                width: 950px;
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
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
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
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='noa' style="text-align: center;">~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td><input id="txtCheckno"  type="text" style="display:none;"/></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:150px;"><a id='lblMech_s'> </a></td>
						<td style="width:80px;"><a id='lblBorntime_s'> </a></td>
						<td style="width:80px;"><a id='lblAddtime_s'> </a></td>
						<td style="width:80px;"><a id='lblChgfre_s'> </a></td>
						<td style="width:80px;"><a id='lblChgtime_s'> </a></td>
						<td style="width:80px;"><a id='lblFaulttime_s'> </a></td>
						<td style="width:80px;"><a id='lblDelaytime_s'> </a></td>
						<td style="width:80px;"><a id='lblWaittime_s'> </a></td>
						<td style="width:80px;"><a id='lblWaitfedtime_s'> </a></td>
						<td style="width:80px;"><a id='lblLacksss_s'> </a></td>
						<td style="width:80px;"><a id='lblClassk_s'> </a></td>
						<td style="width:150px;"><a id='lblMemo_s'> </a></td>
						<td style="width:80px;"><a id='lblAddmount_s'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td>
							<input id="btnMechno.*" type="button" value="." style="font-size: medium; font-weight: bold;" />
							<input id="txtMechno.*" type="text" style="width: 75%;"/>
							<input class="txt c3" id="txtMech.*" type="text" />
						</td>
						<td>
						<input class="txt num c3" id="txtBorntime.*" type="text" />
						</td>
						<td>
						<input class="txt num c3" id="txtAddtime.*" type="text" />
						</td>
						<td >
						<input id="txtChgfre.*" type="text" class="txt num c3" />
						</td>
						<td>
						<input class="txt num c3" id="txtChgtime.*" type="text" />
						</td>
						<td>
						<input class="txt num c3" id="txtFaulttime.*" type="text" />
						</td>
						<td>
						<input class="txt num c3" id="txtDelaytime.*" type="text" />
						</td>
						<td>
						<input class="txt num c3" id="txtWaittime.*" type="text" />
						</td>
						<td>
						<input class="txt num c3" id="txtWaitfedtime.*" type="text" />
						</td>
						<td>
						<input class="txt num c3" id="txtLacksss.*" type="text" />
						</td>
						<td>
						<input class="txt num c3" id="txtClassk.*"  type="text" />
						</td>
						<td>
						<input class="txt c3" id="txtMemo.*"  type="text" />
						</td>
						<td>
						<input class="txt num c3" id="txtAddmount.*" type="text" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:60px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td colspan="2" style="width:100px; text-align: center;"><a id='lblMech_t'> </a></td>
						<td colspan="2" style="width:100px; text-align: center;"><a id='lblSales_t'> </a></td>
						<td style="width:120px; text-align: center;"><a id='lblHours_t'> </a></td>
						<td style="width:120px; text-align: center;"><a id='lblAddhours_t'> </a></td>
					</tr>
					<tr>
						<td><input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<!--	<span> </span><a id="lblCancel_t" class="lbl"> </a>
						<input id="chkCancel..*" type="checkbox"/>-->
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td>
							<input id="btnMechno..*" type="button" value="." style="font-size: medium; font-weight: bold;" />
							<input id="txtMechno..*" type="text" style="width: 75%;"/>
						</td>
						<td><input class="txt c3" id="txtMech..*" type="text" /></td>
						<td>
							<input id="btnSalesno..*" type="button" value="." style="font-size: medium; font-weight: bold;" />
							<input id="txtSalesno..*" type="text" style="width: 75%;"/>
						</td>
						<td><input class="txt c3" id="txtSales..*" type="text" /></td>
						<td>
						<input id="txtHours..*"  type="text" class="txt num c3"/>
						</td>
						<td>
						<input id="txtAddhours..*"  type="text" class="txt num c3"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
