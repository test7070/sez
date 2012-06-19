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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "caraccident";
            var q_readonly = [];
            var bbmNum = [['txtClaimmoney', 10, 0], ['txtConciliatorymoney', 10, 0]];
            var bbmMask = [['txtDatea','999/99/99'],['txtClaimdate','999/99/99'],['txtEnddate','999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa,noq';
            //ajaxPath = ""; //  execute in Root
            aPop = [['txtInsurerno', 'lblInsurer', 'insurer', 'noa,comp', 'txtInsurerno,txtInsurer', 'insurer_b.aspx'],
                    ['txtDriverno', 'lblDriver', 'driver',  'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']];

            $(document).ready(function() {
            	if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='001-M9'";
                    return;
                }
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }///  end Main()

            function mainPost() {
            	q_mask(bbmMask);
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
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
//                q_changeFill(t_name);

                switch (t_name) {
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('caraccident_s.aspx', q_name + '_s', "500px", "340px", q_getMsg("popSeek"));
            }

            function btnIns() {
            	if(q_getId()[3].length>0){
            		var t_noa = $.trim(q_getId()[3].replace(/[noa='*']/g,""));
            		_btnIns();
            		if(t_noa.length>0){
            			$('#txtNoa').val(t_noa);
            			$('#txtDatea').focus(); 
        			}else{
        				$('#txtNoa').focus(); 
        			}
            	}else{
            		_btnIns();
               		$('#txtNoa').focus(); 	
            	} 
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtDatea').focus();
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
            .tview {
                font-size: 16px;
                color: blue;
                background: #FFCC00;
                padding: 3px;
                text-align: center;
            }
            .tbbm {
                font-size: 16px;
                color: blue;
                text-align: left;
                border-color: white;
                width: 100%;
                border-collapse: collapse;
                background: #cad3ff;
            }
            .tbbm tr {
                height: 35px;
            }
            .td1, .td2, .td3, .td4, .td5, .td6 {
                width: 85px;
            }
            .label {
                float: right;
            }
            .lookup {
                text-decoration: underline;
            }
            .lookup:hover {
                color: red;
                font-weight: bolder;
                cursor: pointer;
            }
            .popDiv {
                position: absolute;
                z-index: 3;
                background: #4297D7;
                height: 400px;
                width: 500px;
                border: 2px #EEEEEE solid;
                border-radius: 5px;
                padding-top: 10px;
            }
            .popDiv .block {
                border: 1px #CCD9F2 solid;
                border-radius: 5px;
            }
            .popDiv .block .col {
                display: block;
                width: 600px;
                height: 30px;
                margin-top: 5px;
                margin-left: 5px;
            }
            .btnLbl {
                background: #cad3ff;
                border-radius: 5px;
                display: block;
                width: 80px;
                height: 25px;
                float: left;
                /*border: 1px #EEEEEE solid;*/
                cursor: default;
            }
            .btnLbl.tb {
                float: right;
            }
            .btnLbl.button {
                cursor: pointer;
                background: #76A2FE;
            }
            .btnLbl.button.close {
                background: #cad3ff;
            }
            .btnLbl.button:hover {
                background: #FF8F19;
            }
            .btnLbl a {
                color: blue;
                font-size: 16px;
                height: 25px;
                line-height: 25px;
                display: block;
                text-align: center;
            }
            .btnLbl.button a {
                color: #000000;
            }
            .btnLbl.close a {
                color: red;
                font-size: 16px;
                height: 25px;
                line-height: 25px;
                display: block;
                text-align: center;
            }
		</style>
	</head>
	<body>
		<form id="form1" style="height: 100%;" action="">
			<!--#include file="../inc/toolbar.inc"-->
			<div id='dmain' style="overflow:hidden;">
				<div class="dview" id="dview" style="float: left;  width:220px;"  >
					<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
						<tr>
							<td align="center" style="width:5%"><a id='vewChk'></a></td>
							<td align="center" style="width:25%"><a id='vewNoa'></a></td>
							<td align="center" style="width:25%"><a id='vewDatea'></a></td>
							<td align="center" style="width:25%"><a id='vewDriver'></a></td>
						</tr>
						<tr>
							<td >
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td align="center" id='noa'>~noa</td>
							<td align="center" id='datea'>~datea</td>
							<td align="center" id='driver'>~driver</td>
						</tr>
					</table>
				</div>
				<div class='dbbm' style="width: 500px;float: left;">
					<div style="border: 1px solid #000000;border-radius: 5px;">
						<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
							<tr class="tr1">
								<td class="td1" >
								<div class='btnLbl tb'>
									<a id='lblNoa'></a>
								</div></td>
								<td class="td2" colspan='2'>
								<input id="txtNoa" type="text"  style='width:60%; '/>
								<input id="txtNoq" type="text"  style='width:30%; '/>
								</td>
								<td class="td4" >
								<div class='btnLbl tb'>
									<a id='lblDatea'></a>
								</div></td>
								<td class="td5">
								<input id="txtDatea" type="text"  style='width:95%; '/>
								</td>
								<td class="td6"></td>
							</tr>
							<tr class="tr2">
								<td class="td1" >
								<div class='btnLbl tb'>
									<a id='lblTimeplace'></a>
								</div></td>
								<td class="td2" colspan='3'>
								<input id="txtTimeplace" type="text"  style='width:95%; '/></td>
							</tr>
							<tr class="tr3">
								<td class="td1">
								<div class='btnLbl tb button'>
									<a id='lblDriver'></a>
								</div></td>
								<td class="td2" colspan='2'>
								<input id="txtDriverno" type="text"  style='width:30%; float:left;'/>
								<input id="txtDriver" type="text"  style='width:63%; float:left;'/>
								</td>
								<td class="td4" >
								<div class='btnLbl tb'>
									<a id='lblPolice'></a>
								</div></td>
								<td class="td5">
								<input id="txtPolice" type="text"  style='width:95%; '/>
								</td>
							</tr>
							<tr class="tr4">
								<td class="td1">
								<div class='btnLbl tb button'>
									<a id='lblInsurer'></a>
								</div></td>
								<td class="td2" colspan='2'>
								<input id="txtInsurerno" type="text"  style='width:30%; float:left;'/>
								<input id="txtInsurer" type="text"  style='width:63%; float:left;'/>
								</td>
								<td class="td4" >
								<div class='btnLbl tb'>
									<a id='lblInsurertel'></a>
								</div></td>
								<td class="td5">
								<input id="txtInsurertel" type="text"  style='width:95%; '/>
								</td>
							</tr>
							<tr class="tr4">
								<td class="td1" >
								<div class='btnLbl tb'>
									<a id='lblClaimno'></a>
								</div></td>
								<td class="td2">
								<input id="txtClaimno" type="text"  style='width:95%; '/>
								</td>
								<td class="td3" >
								<div class='btnLbl tb'>
									<a id='lblClaimdate'></a>
								</div></td>
								<td class="td4">
								<input id="txtClaimdate" type="text"  style='width:95%; '/>
								</td>
								<td class="td5" >
								<div class='btnLbl tb'>
									<a id='lblEnddate'></a>
								</div></td>
								<td class="td6">
								<input id="txtEnddate" type="text"  style='width:95%; '/>
								</td>
							</tr>
							<tr class="tr5">
								<td class="td1" >
								<div class='btnLbl tb'>
									<a id='lblClaimmoney'></a>
								</div></td>
								<td class="td2">
								<input id="txtClaimmoney" type="text"  style='width:95%; text-align: right;'/>
								</td>
								<td class="td3" >
								<div class='btnLbl tb'>
									<a id='lblConciliatorymoney'></a>
								</div></td>
								<td class="td4">
								<input id="txtConciliatorymoney" type="text"  style='width:95%; text-align: right;'/>
								</td>
								<td class="td5" >
								<div class='btnLbl tb'>
									<a id='lblAdversary'></a>
								</div></td>
								<td class="td6">
								<input id="txtAdversary" type="text"  style='width:95%; '/>
								</td>
							</tr>
							<tr class="tr6">
								<td class="td1" >
								<div class='btnLbl tb'>
									<a id='lblMemo'></a>
								</div></td>
								<td class="td2" colspan='5'><textarea id="txtMemo" rows="5" cols="10" style="width:95%; height: 50px;">
									</textarea></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<input id="q_sys" type="hidden" />
		</form>
	</body>
</html>
