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

            var q_name = "contdc";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtApv', 'txtWorker2'];
            var bbmNum = new Array(['txtOilbase', 5, 2, 1]);
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            aPop = new Array(['txtCustno', 'lblCust', 'custtgg', 'noa,comp,nick,conn', 'txtCustno,txtComp,txtNick', 'custtgg_b.aspx']
				            , ['txtSales', 'lblSales', 'sss', 'namea,noa', 'txtSales,txtSalesno', 'sss_b.aspx']
				            , ['txtAssigner', 'lblAssigner', 'sss', 'namea,noa', 'txtAssigner,txtAssignerno', 'sss_b.aspx']
				            , ['txtAssistant', 'lblAssistant', 'sss', 'namea,noa', 'txtAssistant,txtAssistantno', 'sss_b.aspx']
				            , ['txtCar_conn', 'lblCar_conn', 'sss', 'namea,noa', 'txtCar_conn,txtCar_connno', 'sss_b.aspx']
				            , ['txtBankno', 'lblBankno', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }///  end Main()

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtEnddate', r_picd],['txtDatea', r_picd], ['txtPledgedate', r_picd], ['txtPaydate', r_picd], ['txtBcontdate', r_picd], ['txtEcontdate', r_picd], ['txtChangecontdate', r_picd]];
                q_mask(bbmMask);
                // q_cmbParse("cmbStype", q_getPara('cont.stype'));
                q_cmbParse("cmbEnsuretype", ('').concat(new Array('', '定存單質押', '不可撤銷保證', '銀行本票質押', '商業本票質押', '現金質押')));
                q_cmbParse("cmbEtype", ('').concat(new Array('','存入', '存出')));
                q_gt('conttype', '', 0, 0, 0, "");
                q_gt('acomp', '', 0, 0, 0, "");

                $('#btnConn_cust').click(function() {
                    t_where = "noa='" + $('#txtCustno').val() + "'";
                    //+cust2sql;
                    q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'Conn_cust', "95%", "650px", q_getMsg('lblConn'));
                });
                $('#lblStype').click(function(e) {
                    q_box("conttype.aspx", 'conttype', "90%", "600px", q_getMsg("popConttype"));
                });

                $('#lblCust2').click(function(e) {
                    q_box("cust_b2.aspx", 'cust', "90%", "600px", q_getMsg("popCust"));
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'conttype':
                        //q_gt('conttype', '', 0, 0, 0, "");
                        location.href = (location.origin == undefined ? '' : location.origin) + location.pathname + "?" + r_userno + ";" + r_name + ";" + q_id + ";;" + r_accy;
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);

                        break;
                }/// end Switch
                b_pop = '';
            }

            var xstype = '';
            var stypenumber = 0;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'conttype':
                        var as = _q_appendData("conttype", "", true);
                        stypenumber = as.length;
                        xstype += "<table style='width:100%;'>"
                        for (var i = 0; i < as.length; i++) {
                            if (i % 4 == 0)
                                xstype += "<tr style='height: 20px;'>";
                            xstype += "<td><input id='checkStype" + i + "' type='checkbox' style='float: left;' value='" + as[i].noa + "' disabled='disabled'/><a class='lbl'  id='stypeno" + i + "' style='float: left;'>" + as[i].typea + "</a></td>"
                            if (i % 4 == 3)
                                xstype += "</tr>";
                        }
                        xstype += "</table>"
                        $('#stype').append(xstype);
                        if (abbm[q_recno]) {
                            //更新勾選
                            var xstypeno = abbm[q_recno].stype.split(',');
                            for (var j = 0; j < stypenumber; j++) {
                                for (var i = 0; i < xstypeno.length; i++) {
                                    if ($('#checkStype' + j).val() == xstypeno[i]) {
                                        $('#checkStype'+j)[0].checked = true;
                                        break;
                                    } else {
                                        $('#checkStype'+j)[0].checked = false;
                                    }
                                }
                            }
                        }
                        /*var t_item = " @ ";
                         for ( i = 0; i < as.length; i++) {
                         t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].typea;
                         }
                         q_cmbParse("cmbStype", t_item);
                         if(abbm[q_recno])
                         $("#cmbStype").val(abbm[q_recno].stype);*/
                        break;
                    case 'acomp':
                    var as = _q_appendData("acomp", "", true);
                    	var t_item = " @ ";
                    	var t_item2 = " @ ";
                         for ( i = 0; i < as.length; i++) {
                         	t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                         	t_item2 = t_item2 + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
                         }
                         q_cmbParse("cmbCno", t_item);
                         q_cmbParse("cmbCnonick", t_item2);
                         q_cmbParse("cmbGuarantorno", t_item);
                         if(abbm[q_recno]){
                         	$("#cmbCno").val(abbm[q_recno].cno);
                         	$("#cmbCnonick").val(abbm[q_recno].cno);
                         	$("#cmbGuarantorno").val(abbm[q_recno].guarantorno);
                         }
                    	break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('contdc_s.aspx', q_name + '_s', "500px", "650px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('#txtTotal').val('0');

                //清除勾選
                for (var j = 0; j < stypenumber; j++) {
                    $('#checkStype'+j)[0].checked = false;
                }
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box('z_contdc.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                var stypeno = '';
                for (var i = 0; i < stypenumber; i++) {
                    if ($('#checkStype'+i)[0].checked) {
                        stypeno += "," + $('#checkStype' + i).val();
                    }
                }
                stypeno = stypeno.substr(1, stypeno.length);

                $('#txtStype').val(stypeno);
                
                $('#txtAcomp').val($('#cmbCno').find(":selected").text());
                $('#cmbCnonick').val($('#cmbCno').val());
                $('#txtAcompnick').val($('#cmbCnonick').find(":selected").text());
                $('#txtGuarantor').val($('#cmbGuarantorno').find(":selected").text());
                
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll('C' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);

                //清除勾選
                for (var j = 0; j < stypenumber; j++) {
                    $('#checkStype'+j)[0].checked = false;
                }
                if (abbm[q_recno]) {
                    //更新勾選
                    var xstypeno = abbm[q_recno].stype.split(',');
                    for (var j = 0; j < stypenumber; j++) {
                        for (var i = 0; i < xstypeno.length; i++) {
                            if ($('#checkStype' + j).val() == xstypeno[i]) {
                                $('#checkStype'+j)[0].checked = true;
                                break;
                            } else {
                                $('#checkStype'+j)[0].checked = false;
                            }
                        }
                    }
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    for (var i = 0; i < stypenumber; i++) {
                        $('#checkStype' + i).attr('disabled', 'disabled');
                    }
                } else {
                    for (var i = 0; i < stypenumber; i++) {
                        $('#checkStype' + i).removeAttr('disabled');
                    }
                }
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

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                } // j
            }

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 350px;
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
                width: 850px;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .tbbm tr td .txt.c1 {
                width: 100%;
                float: left;
            }
            .tbbm tr td .txt.c2 {
                width: 45%;
                float: left;
            }
            .tbbm tr td .txt.c3 {
                width: 55%;
                float: left;
            }
            .tbbm tr td .txt.c4 {
                width: 60%;
                float: left;
            }
            .tbbm tr td .txt.c5 {
                width: 40%;
                float: left;
            }
            .tbbm tr td .txt.num {
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
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .trX{
            	background: pink;
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
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewEcontdate'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
						<td align="center" id='econtdate'>~econtdate</td>
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
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span></span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td><input id="txtEnddate" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOilbase' class="lbl"> </a></td>
						<td><input id="txtOilbase" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id='lblOildate' class="lbl"> </a></td>
						<td><input id="txtOildate" type="text"  class="txt c1"/></td>
						<td class="td3"></td>
                		<td class="td4"><input id="chkEnda"  type="checkbox" />
                						<span> </span><a id='lblEnda'> </a></td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblStype" class="lbl btn"> </a>
						<input id="txtStype"  type="hidden"  class="txt c1"/>
						</td>
						<td class="td2" colspan="5" id="stype"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" class="txt" style="width:30%; float: left;"/>
							<input id="txtComp"  type="text" class="txt" style="width:70%; float: left;"/>
							<input id="txtNick"  type="text" style="display: none;"/>
						</td>
						<td><input id="btnConn_cust" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td colspan="2"><input id="txtContract"  type="text"  class="txt c1"/></td>
						<td ><span> </span><a id='lblBcontract' class="lbl" style="font-size: 14px"> </a></td>
						<td colspan="2"><input id="txtBcontract"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td3"><span> </span><a id='lblBcontdate' class="lbl"> </a></td>
						<td class="td4">
						<input id="txtBcontdate" type="text"  class="txt c1"/>
						</td>
						<td align="center"><a id="lblEcontdate"> </a></td>
						<td class="td6">
						<input id="txtEcontdate" type="text"  class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblChangecontdate' class="lbl"> </a></td>
						<td class="td8">
						<input id="txtChangecontdate" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblContitem' class="lbl"> </a></td>
						<td class="td2" colspan="7">
						<input id="txtContitem" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td colspan="3">
							<select id="cmbCno" class="txt c1"> </select>
							<select id="cmbCnonick" class="txt c1" style="display:none;"> </select>
							<!--<input id="txtCno"  type="text" class="txt" style="width:20%; float: left;"/>-->
							<input id="txtAcomp"  type="hidden" class="txt" style="width:80%; float: left;"/>
							<input id="txtAcompnick"  type="hidden" style="display: none;"/>
						</td>
						<td ><span> </span><a id="lblGuarantor" class="lbl"> </a></td>
						<td  colspan="3">
							<select id="cmbGuarantorno" class="txt c1">
							<input id="txtGuarantor"  type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn"></a></td>
						<td>
							<input id="txtSalesno" type="text" class="txt" style="display: none;"/>
							<input id="txtSales" type="text" class="txt c1">
						</td>
						<td><span> </span><a id='lblAssigner' class="lbl btn"> </a></td>
						<td>
							<input id="txtAssignerno" type="text" class="txt" style="display: none;"/>
							<input id="txtAssigner" type="text" class="txt c1">
						</td>
						<td><span> </span><a id="lblAssistant" class="lbl btn"> </a></td>
						<td>
							<input id="txtAssistantno" type="text" class="txt" style="display: none;"/>
							<input id="txtAssistant" type="text" class="txt c1">
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCar_conn" class="lbl btn"> </a></td>
						<td>
							<input id="txtCar_connno" type="text" class="txt" style="display: none;"/>
							<input id="txtCar_conn"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDisatcher" class="lbl"> </a></td>
						<td><input id="txtDisatcher"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td colspan="8" class="trX"><span> </span><a style=" color:brown; font-size: 18px; font-weight: bolder;">&nbsp;&nbsp;&nbsp;&nbsp;保&nbsp;&nbsp;證&nbsp;&nbsp;金</a></td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id='lblEtype' class="lbl"> </a></td>
						<td class="trX"><select id="cmbEtype" class="txt c1"> </select></td>
						<td class="trX"><span> </span><a id='lblEnsuretype' class="lbl"> </a></td>
						<td class="trX"><select id="cmbEnsuretype" class="txt c1"> </select></td>
						<td class="trX"><span> </span><a id='lblEarnest' class="lbl"> </a></td>
						<td class="trX"><input id="txtEarnest" type="text"  class="txt c1 num"/></td>
						<td class="trX" colspan="2"> </td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id="lblBankno" class="lbl btn"> </a></td>
						<td class="trX" colspan="3">
							<input id="txtBankno" type="text" style="width:30%; float: left;"/>
							<input id="txtBank"  type="text"  style="width:70%; float: left;"/>
						</td>
						<td class="trX"><span> </span><a id='lblCheckno' class="lbl"> </a></td>
						<td class="trX" colspan="3"><input id="txtCheckno" type="text"  class="txt c1"/></td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td class="trX"><span> </span><a id='lblPledgedate' class="lbl"> </a></td>
						<td class="trX"><input id="txtPledgedate" type="text"  class="txt c1"/></td>
						<td class="trX"><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td class="trX"><input id="txtPaydate" type="text"  class="txt c1"/></td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
						<td class="tdZ trX"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><textarea id="txtMemo" rows="5" cols="10" type="text" class="txt c1"></textarea></td>
					</tr>
					<tr class="tr13">
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtWorker"  type="text" class="txt c1" />
						</td>
						<td class="td1"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtWorker2"  type="text" class="txt c1" />
						</td>
						<td class="td3"><span> </span><a id='lblApv' class="lbl"> </a></td>
						<td class="td4">
						<input id="txtApv"  type="text" class="txt c1" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
