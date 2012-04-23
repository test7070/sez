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
            var q_name = "cardeal";
            var q_readonly = [];
            var bbmNum = [];
            var bbmNum_comma = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';

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
            }

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
                q_box('sss_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtComp').focus();
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
            .dview {
                float: left;
                width: 20%;
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
            }
            .tbbm {
                margin: 0;
                padding: 2px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr{
            	height: 35px;
            }
            .td1, .td3, .td5, .td7{
            	width:9%;
            	text-align: right;
            }
            .td2, .td4, .td6, .td8{
            	width:12%;
            }
            .label{
            	
            }
            .txt{
            	width:95%;
            }
		</style>
	</head>
	<body>
		<form id="form1" style="height: 100%;" action="">
			<!--#include file="../inc/toolbar.inc"-->
			<div id='dmain' style="overflow:hidden;">
				<div class="dview" id="dview">
					<table class="tview" id="tview">
						<tr>
							<td style="width:5%"><a id='vewChk'></a></td>
							<td style="width:25%"><a id='vewNoa'></a></td>
							<td style="width:40%"><a id='vewNick'></a></td>
						</tr>
						<tr>
							<td>
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td id='noa'>~noa</td>
							<td id='nick'>~nick</td>
						</tr>
					</table>
				</div>
				<div class='dbbm'>
					<table class="tbbm"  id="tbbm">
						<tr class="tr1">
							<td class="td1" ><a id='lblNoa' class="label"></a></td>
							<td class="td2" >
							<input id="txtNoa"  type="text" class="txt"/>
							</td>
							<td class="td3"></td>
							<td class="td4"></td>
							<td class="td5"></td>
							<td class="td6"></td>
							<td class="td7"></td>
							<td class="td8"></td>
						</tr>
						<tr class="tr2">
							<td class="td1" ><a id='lblComp' class="label"></a></td>
							<td class="td2" colspan="3">
							<input id="txtComp"  type="text" class="txt"/>
							</td>
						</tr>
						<tr class="tr3">
							<td class="td1" ><a id='lblNick' class="label"></a></td>
							<td class="td2" >
							<input id="txtNick"  type="text" class="txt"/>
							</td>
						</tr>
						<tr class="tr4">
							<td class="td1" ><a id='lblBoss' class="label"></a></td>
							<td class="td2" >
							<input id="txtBoss"  type="text" class="txt"/>
							</td>
						</tr>
						<tr class="tr5">
							<td class="td1" ><a id='lblTel1' class="label"></a></td>
							<td class="td2" >
							<input id="txtTel1"  type="text" class="txt"/>
							</td>
						</tr>
						<tr class="tr6">
							<td class="td1" ><a id='lblSerial' class="label"></a></td>
							<td class="td2" >
							<input id="txtSerial"  type="text" class="txt"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<input id="q_sys" type="hidden" />
		</form>
	</body>
</html>
