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
            var q_name = "salary";
            var q_readonly = ['txtNoa', 'txtWorker','txtDatea','txtTotal5'];
            var q_readonlys = [];
            var bbmNum = [['txtTotal5', 15, 0, 1]];
            var bbsNum = [['txtTotal5', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            //brwCount = 6;
            brwCount2 = 5;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtSno_', 'lblSno', 'sss', 'noa,namea', 'txtSno_,txtNamea_', 'sss_b.aspx']);
            q_desc = 1;
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                
                q_gt('acomp', '', 0, 0, 0, "");

                $('#txtDatea').focusout(function() {
                    q_cd($(this).val(), $(this));
                });

                $('#txtMon').blur(function() {
                    if ($('#txtMon').val().length != 6 || $('#txtMon').val().indexOf('/') != 3) {
                        if ($('#txtMon').val().length == 5 && $('#txtMon').val().indexOf('/') == -1)
                            $('#txtMon').val($('#txtMon').val().substr(0, 3) + '/' + $('#txtMon').val().substr(3, 2));
                        else {
                            alert('月份欄位錯誤請，重新輸入!!!');
                            $('#txtMon').focus();
                            return;
                        }
                    }
                });
			}

            
            function q_funcPost(t_func, result) {
            	
            }//endfunction

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'acomp':
		                var as = _q_appendData("acomp", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
		                    }
		                    q_cmbParse("cmbCno", t_item);
		                    if(abbm[q_recno])
		                    	$("#cmbCno").val(abbm[q_recno].cno);
		                }
		                break;
                	case 'cno_salary':
                		var as = _q_appendData("salary", "", true);
                        if (as[0] != undefined){
                            alert('該公司當月的薪資作業已做過!!!');
                        }else{
							insed = false;
							btnOk();
						}
	                	break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
			
			var insed=true;
            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtMon', q_getMsg('lblMon')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
				if(insed){
					var t_where = "where=^^ mon='" + $('#txtMon').val() + "' and cno='" + $('#cmbCno').val() + "' ^^";
                    q_gt('salary', t_where, 0, 0, 0, "cno_salary", r_accy);
                    return;
				}
				insed = true;
				
				$('#txtComp').val($('#cmbCno').find("option:selected").text());

                $('#txtWorker').val(r_name);
                
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('S' + $('#txtMon').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('salary_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtMon').val(q_date().substr(0, 6));
                $('#txtMon').focus();
                $('#txtWorker').val(r_name);
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
                //q_box('z_salary.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['sno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['mon'] = abbm2['mon'];
                return true;
            }

            function sum() {
                //bbs計算
                var t_total5=0;
                for (var j = 0; j < q_bbsCount; j++) {
                   //實發金額
                    t_total5 += dec($('#txtTotal5_' + j).val());
                }

                //實發金額
                q_tr('txtTotal5', Math.round(t_total5));
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
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
                margin: -1px;
                border: 1px black solid;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 70%;
                float: right;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
            }
            .txt.c7 {
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
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
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbs {
                FONT-SIZE: medium;
                COLOR: blue;
                TEXT-ALIGN: left;
                BORDER: 1PX LIGHTGREY SOLID;
                width: 100%;
                height: 98%;
            }
            .tbbs tr.chksel {
                background: #FA0300;
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
			<div class="dview" id="dview" style="float: left;  width:20%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewComp'> </a></td>
						<td align="center" style="width:20%"><a id='vewMon'> </a></td>
					</tr>
					<tr>
						<td>	<input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='comp'>~comp</td>
						<td align="center" id='mon'>~mon</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width:58%;float:left">
				<table class="tbbm"  id="tbbm"  border="0" cellpadding='2'  cellspacing='0'>
					<tr>
						<td class="td1"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td4"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<!--<td class="td11"><input id="btnInput" type="button" style="width: auto;font-size: medium;"/></td>-->
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td class="td2"><input id="txtMon"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblTotal5_tn" class="lbl"> </a></td>
						<td class="td4"><input id="txtTotal5"  type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblCno" class="lbl"> </a></td>
						<td class="td2">
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtComp"  type="text" class="txt c1" style="display: none;"/>
						</td>
						<td class="td3"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 550px;background:#cad3ff;">
				<tr style='color:White; background:#003366;' >
					<td align="center" class="td1" style="width: 28px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;font-size: 16px;"  />
					</td>
					<td align="center" class="td1" style="width: 80px;"><a id='lblSno'></a></td>
					<td align="center" class="td2" style="width: 100px;"><a id='lblNamea'></a></td>
					<td align="center" class="td2" style="width: 100px;"><a id='lblTotal5s_tn'></a></td>
					<td align="center" class="td2" style="width: 200px;"><a id='lblMemo'></a></td>
				</tr>
				<tr  id="trSel.*">
					<td ><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;font-size: 16px;float: center;" /></td>
					<td >
						<input class="txt c1" id="txtSno.*" type="text" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td ><input class="txt c1" id="txtNamea.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtTotal5.*" type="text" /></td>
					<td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
