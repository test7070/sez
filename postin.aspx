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

            var q_name = "postin";
            var q_readonly = ['txtNoa'];
            var bbmNum = [['txtTotal', 14, 1, 1], ['txtP20', 14, 0, 1], ['txtP35', 14, 0, 1], ['txtP50', 14, 0, 1], ['txtP100', 14, 0, 1], ['txtP120', 14, 0, 1], ['txtP130', 14, 0, 1], ['txtP150', 14, 0, 1], ['txtP200', 14, 0, 1], ['txtP250', 14, 0, 1], ['txtP320', 14, 0, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'], ['txtSssno', 'lblSss', 'sss', 'noa,namea,partno,part', 'txtSssno,txtNamea,txtPartno,txtPart', 'sss_b.aspx'], ['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                $('#txtP20').change(function() {
                    sum();
                });
                $('#txtP35').change(function() {
                    sum();
                });
                $('#txtP50').change(function() {
                    sum();
                });
                $('#txtP100').change(function() {
                    sum();
                });
                $('#txtP120').change(function() {
                    sum();
                });
                $('#txtP130').change(function() {
                    sum();
                });
                $('#txtP150').change(function() {
                    sum();
                });
                $('#txtP200').change(function() {
                    sum();
                });
                $('#txtP250').change(function() {
                    sum();
                });
                $('#txtP320').change(function() {
                    sum();
                });
            }

            function txtCopy(dest, source) {
                var adest = dest.split(',');
                var asource = source.split(',');
                $('#' + adest[0]).focus(function() {
                    if (trim($(this).val()).length == 0)
                        $(this).val(q_getMsg('msgCopy'));
                });
                $('#' + adest[0]).focusout(function() {
                    var t_copy = ($(this).val().substr(0, 1) == '=');
                    var t_clear = ($(this).val().substr(0, 2) == ' =');
                    for (var i = 0; i < adest.length; i++) { {
                            if (t_copy)
                                $('#' + adest[i]).val($('#' + asource[i]).val());

                            if (t_clear)
                                $('#' + adest[i]).val('');
                        }
                    }
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'conn':

                        break;

                    case 'sss':
                        ret = getb_ret();
                        if (q_cur > 0 && q_cur < 4)
                            q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                        break;

                    case 'sss':
                        ret = getb_ret();
                        if (q_cur > 0 && q_cur < 4)
                            q_browFill('txtGrpno,txtGrpname', ret, 'noa,comp');
                        break;

                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'sss':
                        q_changeFill(t_name, ['txtSalesno', 'txtSales'], ['noa', 'namea']);
                        break;

                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        if (q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('postin_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            /*function combPay_chg() {
             var cmb = document.getElementById("combPay")
             if (!q_cur)
             cmb.value = '';
             else
             $('#txtPay').val(cmb.value);
             cmb.value = '';
             }*/

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
            }

            function btnPrint() {
                q_box('z_postinp.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }

            function btnOk() {
                var t_err = '';

                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('P' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function sum() {
                q_tr('txtTotal', Math.round((q_float('txtP20') * 2) + (q_float('txtP35') * 3.5) + (q_float('txtP50') * 5) + (q_float('txtP100') * 10) + (q_float('txtP120') * 12) + (q_float('txtP130') * 13) + (q_float('txtP150') * 15) + (q_float('txtP200') * 20) + (q_float('txtP250') * 25) + (q_float('txtP320') * 32)));
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
                width: 98%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
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
                width: 98%;
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
                width: 10%;
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
                width: 35%;
                float: left;
            }
            .txt.c3 {
                width: 63%;
                float: left;
            }
            .txt.c4 {
                width: 25%;
                float: left;
            }
            .txt.c5 {
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
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:25%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:40%"><a id='vewNamea'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='namea'>~namea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 75%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td> </td>
						<td class="td3"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblSss" class="lbl btn" > </a></td>
						<td class="td2" colspan="2">
							<input id="txtSssno"  type="text"  class="txt c2"/>
							<input id="txtNamea"  type="text"  class="txt c3"/>
						</td>
						<td class="td4" ><span> </span><a id="lblPart" class="lbl btn"> </a></td>
						<td class="td5" colspan="2">
							<input id="txtPartno"  type="text"  class="txt c2"/>
							<input id="txtPart" type="text"  class="txt c3"/>
						</td>
						<td class="td1" ><span> </span><a id="lblStore" class="lbl btn"> </a></td>
						<td class="td1" ><input id="txtStoreno" type="text" class="txt c1"/></td>
						<td class="td1" ><input id="txtStore" type="text" class="txt c1"/></td>
						<!--<td class="td7"><span> </span><a id="lblChgcashno" class="lbl btn"></a></td>
						<td class="td8"><input id="txtChgcashno" type="text" class="txt c1" /></td>-->
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblPosts" class="lbl"> </a></td>
						<td class="td2"><span> </span><a id="lblP20" class="lbl"> </a></td>
						<td class="td3"><input id="txtP20" type="text"  class="txt num c3" /></td>
						<td class="td4"><span> </span><a id="lblP35" class="lbl"> </a></td>
						<td class="td5"><input id="txtP35" type="text"  class="txt num c3" /></td>
						<td class="td6"><span> </span><a id="lblP50" class="lbl"> </a></td>
						<td class="td7"><input id="txtP50" type="text" class="txt num c3" /></td>
						<td class="td8"><span> </span><a id="lblP100" class="lbl"> </a></td>
						<td class="td9"><input id="txtP100" type="text" class="txt num c3" /></td>
					</tr>
					<tr class="tr4">
						<td class="td1"> </td>
						<td class="td2"><span> </span><a id="lblP120" class="lbl"> </a></td>
						<td class="td3"><input id="txtP120" type="text" class="txt num c3" /></td>
						<td class="td4"><span> </span><a id="lblP130" class="lbl"> </a></td>
						<td class="td5"><input id="txtP130" type="text" class="txt num c3" /></td>
						<td class="td6"><span> </span><a id="lblP150" class="lbl"> </a></td>
						<td class="td7"><input id="txtP150" type="text" class="txt num c3" /></td>
						<td class="td8"><span> </span><a id="lblP200" class="lbl"> </a></td>
						<td class="td9"><input id="txtP200" type="text" class="txt num c3" /></td>
					</tr>
					<tr class="tr5">
						<td class="td1"> </td>
						<td class="td2"><span> </span><a id="lblP250" class="lbl"> </a></td>
						<td class="td3"><input id="txtP250" type="text" class="txt num c3" /></td>
						<td class="td4"><span> </span><a id="lblP320" class="lbl"> </a></td>
						<td class="td5"><input id="txtP320" type="text" class="txt num c3" /></td>
						<td class="td6"> </td>
						<td class="td7"> </td>
						<td class="td8"><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td class="td9"><input id="txtTotal" type="text" class="txt num c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
