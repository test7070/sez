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
            var q_name = "ticket";
            var q_readonly = [];
            var bbmNum = [['txtMoney', 10, 0], ['txtComppay', 10, 0], ['txtDriverpay', 10, 0], ['txtInstallment', 10, 0]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
       
            $(document).ready(function() {
                bbmKey = ['noa'];
                /*xmlTable = 'conn';
                xmlKey = [['noa', 'noq']];
                xmlDec = [];
                q_popSave(xmlTable);*/
                // for conn_b.aspx

                q_brwCount();

                q_gt(q_name, q_content, q_sqlCount, 1)

                // $('.tr0').hide();
                $('#txtDatea').mask('999/99/99');
                $('#txtAppeardate').mask('999/99/99');
                $('#txtPaydate').mask('999/99/99');
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
            	fbbm[fbbm.length] = 'txtIrregularities';
                /*when the data is changed*/
                $('#txtDriverno').change(function(e) {
                    q_change($(this), 'driver', 'noa', 'noa,namea');
                });
                /*----------------------------*/
                $('#lblDriver').click(function(e) {
                    pop('driver');
                });
                /*  txtCopy('txtPost_comp,txtAddr_comp', 'txtPost_fact,txtAddr_fact');
                 txtCopy('txtPost_invo,txtAddr_invo', 'txtPost_comp,txtAddr_comp');
                 txtCopy('txtPost_home,txtAddr_home', 'txtPost_invo,txtAddr_invo');*/
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

            function pop(form, seq) {
                b_seq = ( seq ? seq : '');
                b_pop = form;
                switch (form) {
                    case 'driver':
                        q_pop('txtDriverno', 'driver_b.aspx', 'driver', 'noa', 'namea', "60%", "650px", q_getMsg('popDriver'));
                        break;
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'driver':
                        ret = getb_ret();
                        if(q_cur > 0 && q_cur < 4)
                            q_browFill('txtDriverno,txtDriver', ret, 'noa,namea');
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'driver':
                        q_changeFill(t_name, ['txtDriverno', 'txtDriver'], ['noa', 'namea']);
                        break;
                }
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('ticket_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtCarno').focus();
            }

            function btnPrint() {

            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);

                /* if(dec($('#txtCredit').val()) > 9999999999)
                 t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

                 if(dec($('#txtStartn').val()) > 31)
                 t_err = t_err + q_getMsg("lblStartn") + q_getMsg("msgErr") + '\r';
                 if(dec($('#txtGetdate').val()) > 31)
                 t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r'
                 if(t_err.length > 0) {
                 alert(t_err);
                 return;
                 }*/
                var t_noa = $('#txtNoa').val();
                /* if(emp($('#txtUacc1').val()))
                 $('#txtUacc1').val('1123.' + t_noa);
                 if(emp($('#txtUacc2').val()))
                 $('#txtUacc2').val('1121.' + t_noa);
                 if(emp($('#txtUacc3').val()))
                 $('#txtUacc3').val('2131.' + t_noa);

                 if(t_noa.length == 1)
                 q_gtnoa(q_name, t_noa);
                 else*/
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
                font-size: medium;
                color: blue;
                background: #FFCC00;
                padding: 3px;
                text-align: center;
            }
            .tbbm {
                font-size: medium;
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
            .td1, .td3, .td5, .td7 {
                width: 13%;
            }
            .td2, .td4, .td6, .td8 {
                width: 9%;
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
                width: 90px;
                height: 25px;
                float: left;
                /*border: 1px #EEEEEE solid;*/
                cursor: default;
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
                font-size: medium;
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
                font-size: medium;
                height: 25px;
                line-height: 25px;
                display: block;
                text-align: center;
            }
            .txt .c1
            {
            	width: 95%;
            }
            .txt .c2
            {
            	width: 90%;
            }
            .txt .num
            {
            	text-align:right;
            	}
		</style>
	</head>
	<body>
			<!--#include file="../inc/toolbar.inc"-->
			<div id='dmain' style="overflow:hidden;">
				<div class="dview" id="dview" style="float: left;  width:25%;"  >
					<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
						<tr>
							<td align="center" style="width:5%"><a id='vewChk'></a></td>
							<td align="center" style="width:20%"><a id='vewNoa'></a></td>
							<td align="center" style="width:25%"><a id='vewTicketno'></a></td>
							<td align="center" style="width:25%"><a id='vewDatea'></a></td>
							<td align="center" style="width:25%"><a id='vewCarno'></a></td>
						</tr>
						<tr>
							<td >
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td align="center" id='noa'>~noa</td>
							<td align="center" id='ticketno'>~ticketno</td>
							<td align="center" id='datea'>~datea</td>
							<td align="center" id='carno'>~carno</td>
						</tr>
					</table>
				</div>
				<div class='dbbm' style="width: 75%;float: left;">
						<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
							<tr class="tr1">
								<td class="td1" >
								<span> </span>
									<a id='lblTicketno' class="lbl"></a>
								</td>
								<td class="td2">
								<input id="txtTicketno" type="text"  class="txt c1"/>
								</td>
								<td class="td3" >
								<span> </span>
									<a id='lblDatea' class="lbl"></a>
								</td>
								<td class="td4">
								<input id="txtDatea" type="text"   class="txt c1"/>
								</td>
								<td class="td5" >
								<span> </span>
									<a id='lblCarno' class="lbl"></a>
								</td>
								<td class="td6">
								<input id="txtCarno" type="text"   class="txt c1"/>
								</td>
								<td class="td7" >
								<span> </span>
									<a id='lblNoa' class="lbl"></a>
								</td>
								<td class="td8">
								<input id="txtNoa"  type="text"   class="txt c2"/>
								</td>
							</tr>
							<tr class="tr2">
								<td class="td1">
								<div class='btnLbl tb button'>
									<a id='lblDriver'></a>
								</div></td>
								<td class="td2" colspan="3">
								<input id="txtDriverno" type="text"  style='width:20%; float:left;'/>
								<input id="txtDriver" type="text"  style='width:73%; float:left;'/>
								</td>
								<td class="td5" >
								<span> </span>
									<a id='lblAppeardate' class="lbl"></a>
								</td>
								<td class="td6">
								<input id="txtAppeardate" type="text"  class="txt c1"/>
								</td>
								<td class="td7" >
								<span> </span>
									<a id='lblPaydate' class="lbl"></a>
								</td>
								<td class="td8">
								<input id="txtPaydate"  type="text"   class="txt c2"/>
								</td>
							</tr>
							<tr class="tr3">
								<td class="td1" >
								<span> </span>
									<a id='lblIrregularities' class="lbl"></a>
								</td>
								<td class="td2" colspan='7'><textarea id="txtIrregularities" rows="5" cols="10" style="width:98%; height: 50px;">
									</textarea></td>
							</tr>
							<tr class="tr4">
								<td class="td1" >
								<span> </span>
									<a id='lblMoney' class="lbl"></a>
								</td>
								<td class="td2">
								<input id="txtMoney"  type="text"   class="txt num c1"/>
								</td>
								<td class="td3" >
								<span> </span>
									<a id='lblComppay' class="lbl"></a>
								</td>
								<td class="td4">
								<input id="txtComppay"  type="text"   class="txt num c1"/>
								</td>
								<td class="td5" >
								<span> </span>
									<a id='lblDriverpay' class="lbl"></a>
								</td>
								<td class="td6">
								<input id="txtDriverpay"  type="text"   class="txt num c1"/>
								</td>
								<td class="td7" >
								<span> </span>
									<a id='lblInstallment' class="lbl"></a>
								</td>
								<td class="td8">
								<input id="txtInstallment" type="text"  class="txt num c2"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
			<input id="q_sys" type="hidden" />
	</body>
</html>
