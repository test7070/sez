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
            var q_name = "bankex";
            var q_readonly = ['txtWorker', 'txtInmoney','txtCashout', 'txtNoa', 'txtAccno'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 15, 0, 1], ['txtCashout', 15, 0, 1], ['txtCashin', 15, 0, 1], ['txtInmoney', 15, 0, 1]];
            var bbsNum = [['txtMoney', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 4;
            brwCount = 4;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtAcc1_', 'btnAcc1_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtPart', 'lblPart', 'part', 'part,noa', 'txtPart,txtPartno', 'part_b.aspx'], ['txtPart_', 'btnPart_', 'part', 'part,noa', 'txtPart_,txtPartno_', 'part_b.aspx']);

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
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);

                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('btnAccc'), true);
                });
				$('#txtCashin').change(function(e){
					sum();
				});
				$('#txtMoney').change(function(e){
					sum();
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

            function btnOk() {
                $('#txtWorker').val(r_name);
                var t_cashout, t_cashin, t_money;
                t_inmoney = dec($('#txtInmoney').val());
                t_cashin = dec($('#txtCashin').val());
                t_money = dec($('#txtMoney').val());
                if (t_inmoney != (t_cashin + t_money)) {
                    alert(t_cashin + ' + ' + t_money + ' 不等於 ' + t_inmoney);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_bankex') + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('bankex_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#txtMoney_' + i).change(function() {
                        sum();
                    });
                }
                _bbsAssign();
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
            		return;
                var total = 0;
                for (var i = 0; i < q_bbsCount; i++) {
                    total += dec($('#txtMoney_' + i).val());
                }
                $('#txtCashout').val(total);
                
                $("#txtInmoney").val(dec($('#txtCashin').val())+dec($('#txtMoney' ).val()));
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
                if (q_chkClose())
             		    return;
                _btnModi();
                $('#txtDatea').focus();
                sum();
            }

            function btnPrint() {
				q_box('z_bankex.aspx'+ "?;;;;"+r_accy+";", '', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

           function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
               	$('#txtAccno').val(xmlString);
            }

            function bbsSave(as) {
                if (!as['acc1']) {
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
            	if (q_chkClose())
             	return;
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
                width: 450px;
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
                width: 500px;
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
            .tbbm tr td .lbl.col {
                color: #FF73B7;
                font-weight: bolder;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 30%;
                float: left;
            }
            .txt.c3 {
                width: 68%;
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

            .tbbs a {
                font-size: medium;
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
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewAcc1'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewCashout'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewCashin'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMoney'></a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" />
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='acc2' style="text-align: center;">~acc2</td>
						<td id='cashout,0,1' style="text-align:right;">~cashout,0,1</td>
						<td id='cashin,0,1' style="text-align:right;">~cashin,0,1</td>
						<td id='money,0,1' style="text-align:right;">~money,0,1</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
						<input id="txtNoa" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcc1' class="lbl btn"> </a></td>
						<td><input id="txtAcc1" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcc2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPart" class="lbl btn"> </a></td>
						<td>
							<input id="txtPart" type="text" class="txt c1"/>
							<input id="txtPartno" type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblCashin" class="lbl" > </a></td>
						<td><input id="txtCashin" type="text" class="txt num c1" />
					</tr>
					
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblMoney" class="lbl" > </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td> 
						<td><span> </span><a id="lblInmoney" class="lbl "> </a></td>
						<td><input id="txtInmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblCashout" class="lbl"> </a></td>
						<td><input id="txtCashout" type="text" class="txt num c1" /></td>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtMemo" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno" type="text" class="txt c1" />
						</td>
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
					<td align="center" style="width:150px;"><a id='lblAcc1_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblPart_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td >
					<input class="btn"  id="btnAcc1.*" type="button" value='.' style=" font-weight: bold;width:1%;float: left;" />
					<input id="txtAcc1.*" type="text" class="txt c1" style="float:left;width:30%;"/>
					<input id="txtAcc2.*" type="text" class="txt c1" style="float:left;width:58%;"/>
					</td>
					<td>
					<input type="text" id="txtMoney.*" style="width:95%;text-align:right;" />
					</td>

					<td>
					<input class="btn"  id="btnPart.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
					<input type="text" id="txtPart.*"  style="width:78%; float:left;"/>
					<input id="txtPartno.*" type="text" style="display: none;" />
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
