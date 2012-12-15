<%@ Page Language="C#" AutoEventWireup="true" %>
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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			isEditTotal = false;
            q_tables = 's';
            var q_name = "chgcash";
            var q_readonly = ['txtChgitem', 'txtPart', 'txtChgpart', 'txtOrg', 'txtNamea', 'txtComp', 'txtChgaccno', 'txtNoa','txtWorker'];
            var q_readonlys = ['txtAcc2'];
            var bbmNum = [['txtOrg', 12, 0, 1]];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            aPop = new Array(
            ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver','txtCarno', 'car2_b.aspx'],
            ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], 
            ['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'], 
            ['txtChgpartno', 'lblChgpart', 'chgpart', 'noa,part', 'txtChgpartno,txtChgpart', 'chgpart_b.aspx'], 
            ['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx'], 
            ['txtChgitemno', 'lblChgitem', 'chgitem', 'noa,item', 'txtChgitemno,txtChgitem', 'chgitem_b.aspx'], 
            ['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], 
            ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], 
            ['txtMemo', '', 'qphr', 'code,phr', 'txtMemo,txtMemo', "qPhr_b.aspx", 'txtAcc1']);

            brwCount2 = 4;

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                bbmMask = [['txtTime', '99:99'], ['txtDatea', r_picd]];
                q_mask(bbmMask);
                //------------------------------------------------
                //零用金下拉式與TXT輸入
                q_cmbParse("cmbDc", q_getPara('chgcash.typea'));
                q_gt('carteam', '', 0, 0, 0, "");

                $("#cmbDc").focus(function() {
					var len = $("#cmbDc").children().length > 0 ? $("#cmbDc").children().length : 1;
					$("#cmbDc").attr('size', len + "");
				}).blur(function() {
					$("#cmbDc").attr('size', '1');
				});

                $('#txtAcc1').change(function() {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');
                });
                $("#cmbCarteamno").focus(function() {
                    var len = $("#cmbCarteamno").children().length > 0 ? $("#cmbCarteamno").children().length : 1;
                    $("#cmbCarteamno").attr('size', len + "");
                }).blur(function() {
                    $("#cmbCarteamno").attr('size', '1');
                });
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }

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
                	case 'chgcashorg':
                        var as = _q_appendData("chgcash", "", true);
                        if (as[0] != undefined)
                            $('#txtOrg').val(as[0].total);
                        break;
                    case 'carteam':
                        var as = _q_appendData("carteam", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                            }
                            q_cmbParse("cmbCarteamno", t_item);
                            $("#cmbCarteamno").val(t_item);
                        }
                        break;
                	default:
                        break;
                }
            }

            function btnOk() {
                $('#txtWorker').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll('C' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)
                    return;

                q_box('chgcash_s.aspx', q_name + '_s', "500px", "340px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                _bbsAssign();
                for(var ix = 0; ix < q_bbsCount; ix++) {
                	$('#lblNo_'+ix).text(ix+1);	
                }            
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                //申請日期與時間
                var now = new Date();
                $('#txtDatea').val(q_date());
                $('#txtTime').val((now.getHours()<10?'0':'')+now.getHours() + ':' + (now.getMinutes()<10?'0':'') + now.getMinutes());

                //申請金額初始
                $('#txtMoney').val(0);

                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
            	q_box('z_chgcash.aspx'+ "?;;;;"+r_accy+";noa="+trim($('#txtNoa').val()), '', "90%", "600px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
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
                cashorg();
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
             function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
                $('#txtAccno').val(xmlString);
            }
            //...........................................零用金餘額查詢
            function cashorg() {
                var t_where = "where=^^ partno='" + $('#txtPartno').val() + "'^^";
                q_gt('chgcashorg', t_where, 0, 0, 0, "", r_accy);
            }
            //..........................................................
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 1080px; 
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
                width: 1080px;
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
            .tbbm .tr1{
                background-color: #FFEC8B;
            }
            .tbbm .tr_carchg {
				background-color: #DAA520;
			}
            .tbbm .tdZ {
                width: 2%;
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
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 50%;
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
                width: 2400px;
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
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNamea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewChecker'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewApprv'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewApprove'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
						<td id="namea" style="text-align: center;">~namea</td>
						<td id="checker" style="text-align: left;">~checker</td>
						<td id="apprv" style="text-align: left;">~apprv</td>
						<td id="approve" style="text-align: left;">~approve</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr name="schema" style="height:1px;">
						<td class="td1"><span class="schema"> </span></td>
						<td class="td2"><span class="schema"> </span></td>
						<td class="td3"><span class="schema"> </span></td>
						<td class="td4"><span class="schema"> </span></td>
						<td class="td5"><span class="schema"> </span></td>
						<td class="td6"><span class="schema"> </span></td>
						<td class="td7"><span class="schema"> </span></td>
						<td class="td8"><span class="schema"> </span></td>
						<td class="tdZ"><span class="schema"> </span></td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblTime" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtTime"  type="text"  class="txt c1"/>
						</td>
						<td class="td5"></td>
						<td class="td6"></td>
						<td class="td7"></td>
						<td class="td8"></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblPart" class="lbl btn"> </a></td>
						<td class="td2">
						<input id="txtPartno"  type="text"  class="txt c2"/>
						<input id="txtPart"  type="text"  class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id="lblSss" class="lbl btn"> </a></td>
						<td class="td4">
						<input id="txtSssno"  type="text"  class="txt c4"/>
						<input id="txtNamea" type="text"  class="txt c4"/>
						</td>
						<td class="td5"><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td class="td6">
						<input id="txtDriverno"  type="text"  class="txt c4"/>
						<input id="txtDriver" type="text"  class="txt c4"/>
						</td>
						<td class="td7"><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
						<td class="td8">
						<input id="txtCarno" type="text" class="txt c1" />
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblChgpart" class="lbl btn"> </a></td>
						<td class="td2">
						<input id="txtChgpartno"  type="text"  class="txt c2"/>
						<input id="txtChgpart"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblMoney" class="lbl"></a></td>
						<td class="td2">
						<input id="txtMoney" type="text" class="txt num c1"/>
						</td>
						<td class="td3"><span > </span><a id="lblDc" class="lbl"> </a></td>
						<td class="td4"><select id="cmbDc" class="txt c1"> </select></td>
						<td class="td5"><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td class="td6"><select id="cmbCarteamno" class="txt c1"></select></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
						<td class="td2">
						<input id="txtCustno"  type="text"  class="txt c1"/>
						</td>
						<td class="td3" colspan="2">
						<input id="txtComp"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtPo"  type="text" class="txt num c1" />
						</td>
						<td class="td3"><span> </span><a id="lblCustchgno" class="lbl"> </a>
						<input id="chkCustchg" type="checkbox" style="float: right;"/>
						<input id="txtCustchgno"  type="hidden" />
						</td>
						<td class="td4"><span> </span><a id="lblCarchgno" class="lbl"> </a>
						<input id="chkCarchg" type="checkbox" style="float: right;"/>
						<input id="txtCarchgno"  type="hidden" />
						</td>
						<td class="td5"><span> </span><a id="lblChecker" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtChecker"  type="text" class="txt c1" />
						</td>
						<td class="td7" colspan="2">
						<input id="txtCheckmemo"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id="lblOrg" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtOrg"  type="text" class="txt num c1" />
						</td>
						<td class="td3"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtNoa"  type="text"  class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblApprv" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtApprv"  type="text" class="txt c1"/>
						</td>
						<td class="td7"colspan="2">
						<input id="txtApprvmemo"  type="text" class="txt c1" />
						</td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblChgaccno" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtChgaccno"  type="text"  class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblApprove" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtApprove"  type="text" class="txt c1" />
						</td>
						<td class="td7" colspan="2">
						<input id="txtApprovememo"  type="text" class="txt c1" />
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
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:200px;"><a id='lblAcc_s'> </a></td>
					<td align="center" style="width:400px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					<input type="text" id="txtAcc1.*"  style="width:35%;"/>
					<input type="text" id="txtAcc2.*"  style="width:45%;"/>
					</td>
					<td ><input type="text" id="txtMemo.*" style="width:95%;" /></td>
					<td><input type="text" id="txtMoney.*" style="width:95%;text-align: right;" /></td>
					
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>