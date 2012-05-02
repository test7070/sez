<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
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

            var decbbm = [];
            var q_name = "carbrand";
            var q_readonly = [];
            var bbmNum = [];
            var bbmNum_comma = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = [];

            $(document).ready(function() {
                bbmKey = ['noa'];

                q_brwCount();

                if(!q_gt(q_name, q_content, q_sqlCount, 1))
                    return;
            });
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                q_mask(bbmMask);
                mainForm(0);

            }///  end Main()

            function mainPost() {
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
            }

            function q_gtPost(t_name) {
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
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

                var t_noa = $('#txtNoa').val();

                wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if(q_cur == 2)/// popSave
                    xmlSql = q_preXml();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function format() {
                var i;

                q_format(bbmNum_comma, bbmNum);
                q_init = 0;
            }

            function refresh(recno) {
                _refresh(recno);

                format();
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
                dataErr = !_q_appendData(t_Table);
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
            .tview {
                font-size: 12pt;
                color: blue;
                background: #FFCC00;
                padding: 3px;
                text-align: center
            }
            .tbbm {
                font-size: 12pt;
                color: blue;
                text-align: left;
                border-color: white;
                width: 100%;
                border-collapse: collapse;
                background: #cad3ff;
            }
            .td1, .td3, .td5, .td7 {
                width: 10%;
            }
            .td2, .td4, .td6, .td8 {
                width: 15%;
            }
            td a.label {
                float: right;
            }
            td a.label.button {
                color: #1D1BA3;
                font-weight: bold;
            }
            td a.label.button:hover {
                color: #FF0000;
            }
            .txt.c1 {
                width: 95%;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 7%;
                float: left;
            }
            .txt.c5 {
                width: 85%;
                float: left;
            }
		</style>
	</head>
	<body>
		<form id="form1" style="height: 100%;" action="">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left;  width:32%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:20%"><a id='vewNoa'></a></td>
						<td align="center" style="width:20%"><a id='vewBrand'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='brand'>~brand</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr class="tr1">
						<td class="td1"><a id="lblNoa" class="label"></a></td>
						<td class="td2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td3"></td>	
						<td class="td4"></td>	
						<td class="td5"></td>	
						<td class="td6"></td>	
						<td class="td7"></td>	
						<td class="td8"></td>	
					</tr>
					<tr class="tr2">
						<td class="td1"><a id="lblBrand" class="label"></a></td>
						<td class="td2">
						<input id="txtBrand" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3"><td style="height:400px;"></td></tr>
				</table>
			</div>
			<input id="q_sys" type="hidden" />
		</form>
	</body>
</html>
