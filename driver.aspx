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

            var decbbm = ['labor','health','pensionfund','dependents','money'];
            var q_name = "driver";
            var q_readonly = [];
            var bbmNum = [['txtLabor',10,0],['txtHealth',10,0],['txtPensionfund',10,0],['txtDependents',2,0],['txtMoney',10,0]];
            var bbmMask = [['txtZip_home','999-99'],['txtZip_conn','999-99'],['txtBirthday','999/99/99'],['txtTakeofficedate','999/99/99'],['txtLeaveofficedate','999/99/99'],['txtStrdate','999/99/99'],['txtEnddate','999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            //q_alias = 'a';
            aPop = [];

            $(document).ready(function() {
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

                q_mask(bbmMask);

                mainForm(0);
                // 1=Last  0=Top

                $('#txtCarno').focus();

            }///  end Main()

            function mainPost() {
            	q_cmbParse("cmbSex",q_getPara('sys.sex'));
            	q_cmbParse("cmbCartype",q_getPara('driver.cartype'));
                fbbm[fbbm.length] = 'txtMemo';
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
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        if(q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('sss_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
            .tview {
                font-size: 12pt;
                color: blue;
                background: #FFCC00;
                padding: 3px;
                text-align: center;
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
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left;  width:32%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:20%"><a id='vewNoa'></a></td>
						<td align="center" style="width:20%"><a id='vewNamea'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='namea'>~namea</td>
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
						<td class="td3"><a id="lblNamea" class="label"></a></td>
						<td class="td4">
						<input id="txtNamea" type="text" class="txt c1"/>
						</td>
						<td class="td5"><a id="lblSex" class="label"></a></td>
						<td class="td6">
						<select id="cmbSex" style="width: 50px;"></select>
						</td>
						<td class="td7"><a id="lblIdno" class="label"></a></td>
						<td class="td8">
						<input id="txtIdno" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><a id="lblBirthday" class="label"></a></td>
						<td class="td2">
						<input id="txtBirthday" type="text" class="txt c1"/>
						</td>
						<td class="td3"><a id="lblTel" class="label"></a></td>
						<td class="td4">
						<input id="txtTel" type="text" class="txt c1"/>
						</td>
						<td class="td5"><a id="lblMobile" class="label"></a></td>
						<td class="td6">
						<input id="txtMobile" type="text" class="txt c1"/>
						</td>
						<td class="td7"></td>
						<td class="td8"></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><a id="lblAddr_home" class="label"></a></td>
						<td class="td2" colspan="7">
							<input id="txtZip_home" type="text" class="txt c4"/>
							<input id="txtAddr_home" type="text" class="txt c5"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><a id="lblAddr_conn" class="label"></a></td>
						<td class="td2" colspan="7">
							<input id="txtZip_conn" type="text" class="txt c4"/>
							<input id="txtAddr_conn" type="text" class="txt c5"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1" ><a id="lblMemo" class="label"></a></td>
						<td class="td2" colspan='7'><textarea id="txtMemo" style="width:95%; height: 127px;"></textarea></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><a id="lblTakeofficedate" class="label"></a></td>
						<td class="td2">
						<input id="txtTakeofficedate" type="text" class="txt c1"/>
						</td>
						<td class="td3"><a id="lblLeaveofficedate" class="label"></a></td>
						<td class="td4">
						<input id="txtLeaveofficedate" type="text" class="txt c1"/>
						</td>
						<td class="td5"><a id="lblCartype" class="label"></a></td>
						<td class="td6"><select id="cmbCartype" class="txt c1"></select></td>
						<td class="td7"></td>
						<td class="td8"></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><a id="lblLabor" class="label"></a></td>
						<td class="td2">
						<input id="txtLabor" type="text" class="txt c1" style="text-align: right;"/>
						</td>
						<td class="td3"><a id="lblHealth" class="label"></a></td>
						<td class="td4">
						<input id="txtHealth" type="text" class="txt c1" style="text-align: right;"/>
						</td> 
						<td class="td5"><a id="lblPensionfund" class="label"></a></td>
						<td class="td6">
						<input id="txtPensionfund" type="text" class="txt c1" style="text-align: right;"/>
						</td>
						<td class="td7"><a id="lblDependents" class="label"></a></td>
						<td class="td8">
						<input id="txtDependents" type="text" class="txt" style="text-align: right; width:15%;"/>
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1"><a id="lblStrdate" class="label"></a></td>
						<td class="td2">
						<input id="txtStrdate" type="text" class="txt c1" style="text-align: center;"/>
						</td>
						<td class="td3"><a id="lblEnddate" class="label"></a></td>
						<td class="td4">
						<input id="txtEnddate" type="text" class="txt c1" style="text-align: center;"/>
						</td> 
						<td class="td5"><a id="lblMoney" class="label"></a></td>
						<td class="td6">
						<input id="txtMoney" type="text" class="txt c1" style="text-align: right;"/>
						</td>
						<td class="td7"></td>
						<td class="td8"></td>
					</tr>
					<tr class="tr9">
						<td class="td1"><a id="lblAccount" class="label"></a></td>
						<td class="td2">
						<input id="txtAccount" type="text" class="txt c1"/>
						</td>
						<td class="td3"><a id="lblAccountname" class="label"></a></td>
						<td class="td4">
						<input id="txtAccountname" type="text" class="txt c1"/>
						</td> 
						<td class="td5"><a id="lblMark" class="label"></a></td>
						<td class="td6">
						<input id="txtMark" type="text" class="txt" style="text-align: center; width:10%;"/>
						</td>
						<td class="td7"></td>
						<td class="td8"></td>
					</tr>
					<tr class="tr9">
                        <td class="td1"><a id="lblGuild" class="label"></a></td>
                        <td class="td2">
                        <input id="txtGuild" type="text" class="txt c1"/>
                        </td>
                        <td class="td3"><input id="btnInsurer" type="button"/></td>
                        <td class="td4">
                        <input id="txtInsurerno" type="text" class="txt c1"/>
                        </td> 
                        <td class="td5" colspan="3"><input id="txtInsurer" type="text" class="txt c1"/></td>                     
                        <td class="td8"></td>
                    </tr>
				</table>
			</div>
			<input id="q_sys" type="hidden" />
	</body>
</html>
