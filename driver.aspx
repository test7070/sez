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
		<script src="//59.125.143.170/jquery/js/qtran.js" type="text/javascript"> </script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            var q_name = "driver";
            var q_readonly = [];
            var bbmNum = [['txtSalmoney',10,0],['txtLabor',10,0],['txtHealth',10,0],['txtPensionfund',10,0],['txtDependents',10,0],['txtMoney',10,0],['txtEo',10,0]];
            var bbmMask = [['txtZip_home','999-99'],['txtZip_conn','999-99'],['txtBirthday','999/99/99'],['txtTakeofficedate','999/99/99'],['txtLeaveofficedate','999/99/99'],['txtStrdate','999/99/99'],['txtEnddate','999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            //q_alias = 'a';
            aPop = new Array(['txtInsurerno', 'lblInsurer', 'insurer', 'noa,comp', 'txtInsurerno,txtInsurer', 'Insurer_b.aspx'],
            ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'Cardeal_b.aspx'],
            ['txtBankno2', 'lblBank2', 'bank', 'noa,bank', 'txtBankno2,txtBank2', 'Bank_b.aspx'])

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });
           
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }///  end Main()

            function mainPost() {
            	q_cmbParse("cmbSex",q_getPara('sys.sex'));
            	q_cmbParse("cmbCartype",q_getPara('driver.cartype'));
            	q_cmbParse("cmbRate",q_getPara('driver.rate'));
                q_mask(bbmMask);
                $('#btnFamily').click(function (e) {
		            q_box("labases_b.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'family', "850px", "600px", q_getMsg("popFamily"));
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

                q_box('driver_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
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
				q_box('z_driver.aspx' + "?;;;;" + r_accy, '', "90%", "600px", q_getMsg("popPrint"));
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
             #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 38%;
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
                width: 60%;
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
            .td6
            {
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
                font-size: 15px;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 15%;
                float: left;
            }
            .txt.c5 {
                width: 85%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .txt.cen {
                text-align: center;
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
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
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
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblNamea" class="lbl"></a></td>
						<td class="td4">
						<input id="txtNamea" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblSex" class="lbl"></a></td>
						<td class="td6">
						<select id="cmbSex" class="txt c6"></select>
						</td>
						<td class="td5"><span> </span><a id="lblRate" class="lbl"></a></td>
						<td class="td6">
						<select id="cmbRate" class="txt c6"></select>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblIdno" class="lbl"></a></td>
						<td class="td2"  colspan="3">
						<input id="txtIdno" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblBirthday" class="lbl"></a></td>
						<td class="td6">
						<input id="txtBirthday" type="text" class="txt c1"/>
						</td>
						
						
					</tr>
					<tr  class="tr3">
						<td class="td1" ><span> </span><a id="lblTel" class="lbl"></a></td>
						<td class="td2" colspan="3">
						<input id="txtTel" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblMobile" class="lbl"></a></td>
						<td class="td6"  colspan="3">
						<input id="txtMobile" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblAddr_home" class="lbl"></a></td>
						<td class="td2" colspan="7">
							<input id="txtZip_home" type="text" class="txt c4"/>
							<input id="txtAddr_home" type="text" class="txt c5"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblAddr_conn" class="lbl"></a></td>
						<td class="td2" colspan="7">
							<input id="txtZip_conn" type="text" class="txt c4"/>
							<input id="txtAddr_conn" type="text" class="txt c5"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
						<td class="td2" colspan='7'><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblTakeofficedate" class="lbl"></a></td>
						<td class="td2">
						<input id="txtTakeofficedate" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblLeaveofficedate" class="lbl"></a></td>
						<td class="td4">
						<input id="txtLeaveofficedate" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblCartype" class="lbl"></a></td>
						<td class="td6"><select id="cmbCartype" class="txt c1"></select></td>
						<td><span> </span><a id="lblEo" class="lbl"></a></td>
						<td>
						<input id="txtEo" type="text" class="txt num c1" />
						</td> 
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id="lblLabor" class="lbl"></a></td>
						<td class="td2">
						<input id="txtLabor" type="text" class="txt num c1" />
						</td>
						<td class="td3"><span> </span><a id="lblHealth" class="lbl"></a></td>
						<td class="td4">
						<input id="txtHealth" type="text" class="txt num c1" />
						</td> 
						<td class="td5"><a id="lblPensionfund" class="lbl"></a></td>
						<td class="td6">
						<input id="txtPensionfund" type="text" class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblDependents" class="lbl"></a></td>
						<td class="td8">
						<input id="txtDependents" type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id="lblStrdate" class="lbl"></a></td>
						<td class="td2">
						<input id="txtStrdate" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblEnddate" class="lbl"></a></td>
						<td class="td4">
						<input id="txtEnddate" type="text" class="txt c1"/>
						</td> 
						<td class="td5"><span> </span><a id="lblMoney" class="lbl"></a></td>
						<td class="td6">
						<input id="txtMoney" type="text" class="txt num c1"/>
						</td>
						<td><span> </span><a id="lblSalmoney" class="lbl"></a></td>
						<td><input id="txtSalmoney" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr10">
						<td class="td1"><span> </span><a id="lblAccount" class="lbl"></a></td>
						<td class="td2" colspan="3">
						<input id="txtAccount" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblAccountname" class="lbl"></a></td>
						<td class="td6">
						<input id="txtAccountname" type="text" class="txt c1"/>
						</td> 
						<td class="td7"><span> </span><a id="lblMark" class="lbl"></a></td>
						<td class="td8">
						<input id="txtMark" type="text" class="txt cen c4" />
						</td>
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id="lblBank2" class="lbl btn"></a></td>
						<td class="td2" colspan="3">
						<input id="txtBankno2" type="text" class="txt c2"/>
						<input id="txtBank2" type="text" class="txt c3"/></td> 
					</tr>
					<tr class="tr12">
						<td class="td1"><span> </span><a id="lblAccount2" class="lbl"></a></td>
						<td class="td2" colspan="3">
						<input id="txtAccount2" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblAccountname2" class="lbl"></a></td>
						<td class="td6">
						<input id="txtAccountname2" type="text" class="txt c1"/>
						</td> 
						<td class="td7"><span> </span><a id="lblId2" class="lbl"></a></td>
						<td class="td8">
						<input id="txtId2" type="text" class="txt c1" />
						</td>
					</tr>
					<tr class="tr13">
                        <td class="td1"><span> </span><a id="lblGuild" class="lbl"></a></td>
                        <td class="td2">
                        <input id="txtGuild" type="text" class="txt c1"/>
                        </td>
                        <td class="td3"><span> </span><a id="lblCardeal" class="lbl btn" ></a></td>
                        <td class="td4">
                        <input id="txtCardealno" type="text" class="txt c1"/>
                        </td> 
                        <td class="td5" colspan="4"><input id="txtCardeal" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr14">
						<td class="td1"><span> </span><a id="lblUacc1" class="lbl" style="font-size: 14px;"></a></td>
						<td class="td2">
						<input id="txtUacc1" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblUacc2" class="lbl" style="font-size: 14px;"></a></td>
						<td class="td4">
						<input id="txtUacc2" type="text" class="txt c1"/>
						</td> 
						<td class="td5"><span> </span><a id="lblUacc3" class="lbl" style="font-size: 14px;"></a></td>
						<td class="td6">
						<input id="txtUacc3" type="text" class="txt c1" />
						</td>
						<td class="td7"></td>
						<td class="td8"><input id='btnFamily' type="button" /></td>
					</tr>
				</table>
			</div>
			<input id="q_sys" type="hidden" />
	</body>
</html>
