<%@ Page Language="C#" AutoEventWireup="true" %>
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
		<script src="//59.125.143.170/jquery/js/qtran.js" type="text/javascript"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var decbbm = ['mount', 'weight'];
            var q_name = "tranvcce";
            // var q_name = "trans";
            var q_readonly = [];
            var bbmNum = new Array();
            var bbmMask = new Array();
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            aPop = new Array();
            $(document).ready(function() {
                bbmKey = ['noa'];

                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                q_mask(bbmMask);
                mainForm(0);

            }

            function q_funcPost(t_func, result) {
                if(result.substr(0, 5) == '<Data') {
                    switch(t_func) {
                        case 'tranvcce.getItem1':
                            var tmp = _q_appendData('tranvcce_t1', '', true);
                            $("#t1").refresh(tmp);
                            break;
                        case 'tranvcce.getItem2':
                            var tmp = _q_appendData('tranvcce_t2', '', true);
                            $("#t2").refresh(tmp);
                            break;
                        case 'tranvcce.getItem3':
                            var tmp = _q_appendData('tranvcce_t3', '', true);
                            $("#t3").refresh(tmp);
                            break;
                    }
                } else
                    alert('Error!' + '\r' + t_func + '\r' + result);
            }

            function mainPost() {
                var tmp = q_getPara('tranvcce.typea').split(',');
                for( i = 0; i < tmp.length; i++) {
                    tmpStr = '<option><';
                    tmpStr += '/option>';
                    $("#cmbTypea_condition").append(tmpStr);
                    $("#cmbTypea_condition").children().last().val(tmp[i].split('@')[0]).text(tmp[i].split('@')[1]);
                }
                $("#cmbTypea_condition").change(function() {
                    var obj = $('#condition')
                    if($('#condition').children('tbody').length > 0)
                        obj = $('#condition').children('tbody').eq(0);
                    obj.children().hide();
                    obj.children('tr[name="scheme"]').show();
                    obj.children('tr[name="action"]').show();

                    switch($(this).val()) {
                        case '1':
                            obj.children('tr.type1').show();
                            break;
                        case '2':
                            obj.children('tr.type2').show();
                            break;
                        case '3':
                            obj.children('tr.type3').show();
                            break;
                    }
                });
                $("#cmbTypea_condition").change();
                $("#btnLookup_condition").click(function(e) {
                    $("#t1").hide();
                    $("#t2").hide();
                    $("#t3").hide();
                    switch($("#cmbTypea_condition").val()) {
                        case '1':
                            q_func('tranvcce.getItem1', '1,2,3');
                            $("#t1").show();
                            break;
                        case '2':
                            q_func('tranvcce.getItem2', '1,2,3');
                            $("#t2").show();
                            break;
                        case '3':
                            q_func('tranvcce.getItem3', '1,2,3');
                            $("#t3").show();
                            break;
                    }
                });
            }

            function sum() {
            }

            function txtCopy(dest, source) {
                var adest = dest.split(',');
                var asource = source.split(',');
                $('#' + adest[0]).focus(function() {
                    if(trim($(this).val()).length == 0)
                        $(this).val(q_getMsg('msgCopy'));
                });
                $('#' + adest[0]).focusout(function() {
                    var t_copy = ($(this).val().substr(0, 1) == '=');
                    var t_clear = ($(this).val().substr(0, 2) == ' =');
                    for(var i = 0; i < adest.length; i++) { {
                            if(t_copy)
                                $('#' + adest[i]).val($('#' + asource[i]).val());

                            if(t_clear)
                                $('#' + adest[i]).val('');
                        }
                    }
                });
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
                        if(q_cur == 4)
                            q_Seek_gtPost();

                        if(q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)
                    return;
            }

            function btnIns() {
                _btnIns();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);

                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());

                if(t_noa.length == 0)
                    q_gtnoa(q_name, t_noa);
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
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
                if(q_tables == 's')
                    bbsAssign();
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
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: 16px;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 73%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                /*border: 1px white double;
                 border-spacing: 0;
                 border-collapse: collapse;*/
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr .td1, .tbbm tr .td3, .tbbm tr .td5, .tbbm tr .td7 {
                width: 10%;
            }
            .tbbm tr .td2, .tbbm tr .td4, .tbbm tr .td6, .tbbm tr .td8 {
                width: 10%;
            }
            .tbbm tr .td9 {
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
                font-size: 16px;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
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
            .txt.num {
                text-align: right;
            }
            td {
                margin: 0px -1px;
                padding: 0;
            }
            td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            #condition {
                width: 100%;
                background: #E0EEEE;
            }
            #condition tr[name="actioon"] {
                background-color: #EE9A00;
            }
            #condition tr[name="header"] {
                background-color: #EE9A00;
                display: none;
            }
            #condition tr[name="data"] {
                display: none;
            }
            #t1, #t2, #t3 {
                width: 100%;
                background: #DCDCDC;
                display: none;
            }
            #t1 tr[name="header"], #t2 tr[name="header"], #t3 tr[name="header"] {
                background-color: #5CACEE;
            }
            #t1 tr[name="template"], #t2 tr[name="template"], #t3 tr[name="template"] {
                display: none;
            }
            #condition tr td, #t1 tr td, #t2 tr td, #t3 tr td {
                text-align: center;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%;"><a id='vewChk'></a></td>
						<td align="center" style="width:20%;"><a id='vewNoa'></a></td>
						<td align="center" style="width:20%;"><a id='vewComp'></a></td>
						<td align="center" style="width:15%;"><a id='vewCarno'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='comp,4'>~comp,4</td>
						<td align="center" id='carno'>~carno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm" >
					<tr class="tr1">
						<td class="td1" ><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtNoa" type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
						<td class="td5" ></td>
						<td class="td6" ></td>
						<td class="td7" ></td>
						<td class="td8" ></td>
						<td class="td9" ></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblCust" class="lbl"></a></td>
						<td class="td2">
						<input id="txtCustno" type="text"  class="txt c1"/>
						</td>
						<td class="td1"><span> </span><a id="lblCarno" class="lbl"></a></td>
						<td class="td2">
						<input id="txtCustno" type="text"  class="txt c1"/>
						</td>

					</tr>

				</table>
			</div>
		</div>
		<table id="condition">
			<tr name="scheme">
				<td class="td1" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td2" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td3" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td4" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td5" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td6" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td7" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td8" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td9" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdA" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdB" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdC" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdD" style="width:7%"><span style="display: block; width:95%; height:0px;"> </span></td>
			</tr>
			<tr name="action">
				<td class="td1" colspan="14" style="text-align: left;"><span style="display: block; width:20px; height:10px; float:left;"> </span><select id="cmbTypea_condition"  style="width:100px;"></select>
				<input type="button" id="btnLookup_condition"/>
				<input type="button" id="btnVcce_condition"/>
				</td>
			</tr>
			<tr name="header" class="type1">
				<td class="td1" id='lblCust_type1'></td>
				<td class="td2" id='lblStradd_type1'></td>
				<td class="td3" id="lblEndadd_type1"></td>
				<td class="td4" id="lblProduct_type1"></td>
				<td class="td5" id="lblOrdeno_type1"></td>
				<td class="td6" id="lblCarno_type1"></td>
				<td class="td7" id="lblMount_type1"></td>
				<td class="td8" id="lblWeight_type1"></td>
				<td class="td9" id="lblTime_type1"></td>
			</tr>
			<tr name="data" class="type1">
				<td class="td1">
				<input type="text" style="width: 35%;" id="txtCustno_type1"/>
				<input type="text" style="width: 60%;" id="txtCust_type1"/>
				</td>
				<td class="td2">
				<input type="text" style="width: 35%;" id="txtStraddno_type1"/>
				<input type="text" style="width: 60%;" id="txtStradd_type1"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 35%;" id="txtEndaddno_type1"/>
				<input type="text" style="width: 60%;" id="txtEndadd_type1"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 35%;" id="txtProductno_type1"/>
				<input type="text" style="width: 60%;" id="txtProduct_type1"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 95%;" id="txtOrdeno_type1"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 95%;" id="txtCarno_type1"/>
				</td>
				<td class="td7">
				<input type="text" style="width: 95%;" id="txtMount_type1"/>
				</td>
				<td class="td8">
				<input type="text" style="width: 95%;" id="txtWeight_type1"/>
				</td>
				<td class="td9">
				<input type="text" style="width: 95%;" id="txtTime_type1"/>
				</td>
			</tr>
			<tr name="header" class="type2">
				<td class="td1" id='lblCust_type2'></td>
				<td class="td2" id='lblStradd_type2'></td>
				<td class="td3" id="lblEndadd_type2"></td>
				<td class="td4" id="lblCaseno_type2"></td>
				<td class="td5" id="lblPo_type2"></td>
				<td class="td6" id="lblTraceno_type2"></td>
				<td class="td7" id="lblCaseno2_type2"></td>
				<td class="td8" id="lblIsdisplay_type2" style="font-size: 14px;"></td>
				<td class="td9" id="lblCarno_type2"></td>
				<td class="tdA" id="lblDatea_type2"></td>
				<td class="tdB" id="lblPlat_type2"></td>
				<td class="tdC" id="lblIsempty_type2"></td>
				<td class="tdD" id="lblOrdeno_type2"></td>
			</tr>
			<tr name="data" class="type2">
				<td class="td1">
				<input type="text" style="width: 35%;" id="txtCustno_type2"/>
				<input type="text" style="width: 60%;" id="txtCust_type2"/>
				</td>
				<td class="td2">
				<input type="text" style="width: 35%;" id="txtStraddno_type2"/>
				<input type="text" style="width: 60%;" id="txtStradd_type2"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 35%;" id="txtEndaddno_type3"/>
				<input type="text" style="width: 60%;" id="txtEndadd_type3"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 95%;" id="txtCaseno_type2"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 95%;" id="txtPo_type2"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 95%;" id="txtTraceno_type2"/>
				</td>
				<td class="td7">
				<input type="text" style="width: 95%;" id="txtCaseno2_type2"/>
				</td>
				<td class="td8">
				<input type="checkbox" id="txtIsdisplay_type2"/>
				</td>
				<td class="td9">
				<input type="text" style="width: 95%;" id="txtCarno_type2"/>
				</td>
				<td class="tdA">
				<input type="text" style="width: 95%;" id="txtDatea_type2"/>
				</td>
				<td class="tdB">
				<input type="text" style="width: 95%;" id="txtPlat_type2"/>
				</td>
				<td class="tdC">
				<input type="checkbox" id="txtIsempty_type2"/>
				</td>
				<td class="tdD">
				<input type="text" style="width: 95%;" id="txtOrdeno_type2"/>
				</td>
			</tr>
			<tr name="header" class="type3">
				<td class="td1" id='lblCust_type3'></td>
				<td class="td2" id='lblStradd_type3'></td>
				<td class="td3" id="lblEndadd_type3"></td>
				<td class="td4" id="lblShipno_type3"></td>
				<td class="td5" id="lblSo_type3"></td>
				<td class="td6" id="lblCldate_type3"></td>
				<td class="td7" id="lblCaseno_type3"></td>
				<td class="td8" id="lblIsdisplay_type3" style="font-size: 14px;"></td>
				<td class="td9" id="lblCarno_type3"></td>
				<td class="tdA" id="lblDatea_type3"></td>
				<td class="tdB" id="lblPlat_type3"></td>
				<td class="tdC" id="lblIsempty_type3"></td>
				<td class="tdD" id="lblOrdeno_type3"></td>
			</tr>
			<tr name="data" class="type3">
				<td class="td1">
				<input type="text" style="width: 35%;" id="txtCustno_type3"/>
				<input type="text" style="width: 60%;" id="txtCust_type3"/>
				</td>
				<td class="td2">
				<input type="text" style="width: 35%;" id="txtStraddno_type3"/>
				<input type="text" style="width: 60%;" id="txtStradd_type3"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 35%;" id="txtEndaddno_type3"/>
				<input type="text" style="width: 60%;" id="txtEndadd_type3"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 95%;" id="txtShipno_type3"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 95%;" id="txtSo_type3"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 95%;" id="txtCldate_type3"/>
				</td>
				<td class="td7">
				<input type="text" style="width: 95%;" id="txtCaseno_type3"/>
				</td>
				<td class="td8">
				<input type="checkbox" id="txtIsdisplay_type3"/>
				</td>
				<td class="td9">
				<input type="text" style="width: 95%;" id="txtCarno_type3"/>
				</td>
				<td class="tdA">
				<input type="text" style="width: 95%;" id="txtDatea_type3"/>
				</td>
				<td class="tdB">
				<input type="text" style="width: 95%;" id="txtPlat_type3"/>
				</td>
				<td class="tdC">
				<input type="checkbox" id="txtIsempty_type3"/>
				</td>
				<td class="tdD">
				<input type="text" style="width: 95%;" id="txtOrdeno_type3"/>
				</td>
			</tr>
		</table>
		<div style="width: 100%; display: block; height:20px;">
			<p>
				&nbsp;
			</p>
		</div>
		<table id="t1">
			<tr name="scheme">
				<td class="td1" style="width:5%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td2" style="width:10%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td3" style="width:5%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td4" style="width:5%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td5" style="width:15%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td6" style="width:8%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td7" style="width:8%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td8" style="width:5%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td9" style="width:8%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdA" style="width:5%;"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdB" style="width:8%;"><span style="display: block; width:95%; height:0px;"> </span></td>
			</tr>
			<tr name="header">
				<td class="td1" id="lblChk_t1"></td>
				<td class="td2" id="lblCust_t1"></td>
				<td class="td3" id="lblCarno_t1"></td>
				<td class="td4" id="lblDatea_t1"></td>
				<td class="td5" id="lblProduct_t1"></td>
				<td class="td6" id="lblStradd_t1"></td>
				<td class="td7" id="lblEndadd_t1"></td>
				<td class="td8" id="lblWeight_t1"></td>
				<td class="td9" id="lblOrdeno_t1"></td>
				<td class="tdA" id="lblNotv_t1"></td>
				<td class="tdB" id="lblPlat_t1"></td>
			</tr>
			<tr name="template">
				<td class="td1">
				<input type="checkbox"/>
				</td>
				<td class="td2">
				<input type="text" style="width: 35%;" value="custno"/>
				<input type="text" style="width: 60%;" value="cust"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 95%;" value="carno"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 95%;" value="datea"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 35%;" value="productno"/>
				<input type="text" style="width: 60%;" value="product"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 35%;" value="straddno"/>
				<input type="text" style="width: 60%;" value="stradd"/>
				</td>
				<td class="td7">
				<input type="text" style="width: 35%;" value="endaddno"/>
				<input type="text" style="width: 60%;" value="endadd"/>
				</td>
				<td class="td8">
				<input type="text" style="width: 95%;" value="weight"/>
				</td>
				<td class="td91">
				<input type="text" style="width: 95%;" value="ordeno"/>
				</td>
				<td class="tdA">
				<input type="text" style="width: 95%;" value="notv"/>
				</td>
				<td class="tdB">
				<input type="text" style="width: 95%;" value="plat"/>
				</td>
			</tr>
		</table>
		<table id="t2">
			<tr name="scheme">
				<td class="td1" style="width:5%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td2" style="width:10%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td3" style="width:5%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td4" style="width:5%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td5" style="width:15%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td6" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td7" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td8" style="width:5%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="td9" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdA" style="width:5%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdB" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdC" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdD" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
				<td class="tdE" style="width:8%"><span style="display: block; width:95%; height:0px;"> </span></td>
			</tr>
			<tr name="header">
				<td class="td1" id="lblChk_t1"></td>
				<td class="td2" id="lblCust_t1"></td>
				<td class="td3" id="lblCarno_t1"></td>
				<td class="td4" id="lblDatea_t1"></td>
				<td class="td5" id="lblProduct_t1"></td>
				<td class="td6" id="lblStradd_t1"></td>
				<td class="td7" id="lblEndadd_t1"></td>
				<td class="td8" id="lblWeight_t1"></td>
				<td class="td9" id="lblOrdeno_t1"></td>
				<td class="tdA" id="lblNotv_t1"></td>
				<td class="tdB" id="lblPlat_t1"></td>
			</tr>

		</table>
		<table id="t3"></table>

		<input id="q_sys" type="hidden" />
	</body>
</html>
