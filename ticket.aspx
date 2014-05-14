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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            var q_name = "ticket";
            var q_readonly = ['txtNoa','txtWorker'];
            var bbmNum = [['txtMoney', 10, 0], ['txtComppay', 10, 0], ['txtDriverpay', 10, 0]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
            q_desc = 1;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });
            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }///  end Main()

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtTicketdate', r_picd], ['txtAppeardate', r_picd], ['txtPaydate', r_picd],['txtBmon',r_picm],['txtEmon',r_picm]];
                q_mask(bbmMask);
                
                $('#txtMoney').change(function() {
                	if(!emp($('#txtMoney').val()) || !emp($('#txtDriverpay').val())){
                		if(!emp($('#txtBmon').val()) || !emp($('#txtEmon').val())){
                			var year_mon=(dec($('#txtEmon').val().substr(0,3))-dec($('#txtBmon').val().substr(0,3)))*12
                			var t_mon=dec($('#txtEmon').val().slice(-2))-dec($('#txtBmon').val().slice(-2))+1;
                			q_tr('txtComppay',(q_float('txtMoney')/(year_mon+t_mon))-q_float('txtDriverpay'));
                		}else{
                			q_tr('txtComppay',q_float('txtMoney')-q_float('txtDriverpay'));
                		}
                	}
                });
                $('#txtDriverpay').change(function() {
                	if(!emp($('#txtMoney').val()) || !emp($('#txtDriverpay').val())){
                		if(!emp($('#txtBmon').val()) || !emp($('#txtEmon').val())){
                			var year_mon=(dec($('#txtEmon').val().substr(0,3))-dec($('#txtBmon').val().substr(0,3)))*12
                			var t_mon=dec($('#txtEmon').val().slice(-2))-dec($('#txtBmon').val().slice(-2))+1;
                			q_tr('txtComppay',(q_float('txtMoney')/(year_mon+t_mon))-q_float('txtDriverpay'));
                		}else{
                			q_tr('txtComppay',q_float('txtMoney')-q_float('txtDriverpay'));
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
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('ticket_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {

            }

            function btnOk() {
                
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                $('#txtWorker').val(r_name);
                
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ticket') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
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
            
			
			if(navigator.appName=="Microsoft Internet Explorer"){
            	window.onbeforeunload = function(e){
					 if(window.parent.q_name=='cara'){
						 var wParent = window.parent.document;
						 var b_seq= wParent.getElementById("text_Noq").value
						 wParent.getElementById("txtMemo_"+b_seq).value=$('#txtCarno').val()+' '+$('#txtIrregularities').val()+' '+$('#txtTicketno').val();
						 wParent.getElementById("txtOutmoney_"+b_seq).value=$('#txtComppay').val();
					 }
				}
            }else{
            	window.onunload = function(e){
					  if(window.parent.q_name=='cara'){
						 var wParent = window.parent.document;
						 var b_seq= wParent.getElementById("text_Noq").value
						 wParent.getElementById("txtMemo_"+b_seq).value=$('#txtCarno').val()+' '+$('#txtIrregularities').val()+' '+$('#txtTicketno').val();
						 wParent.getElementById("txtOutmoney_"+b_seq).value=$('#txtComppay').val();
					 }
				}
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
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
                width: 95%;
                float: left;
            }
            .txt.c2 {
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
            }
            .txt.c7 {
                width: 95%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:20%"><a id='vewDatea'></a></td>
						<td align="center" style="width:25%"><a id='vewTicketno'></a></td>
						<td align="center" style="width:25%"><a id='vewCarno'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='ticketno'>~ticketno</td>
						<td align="center" id='carno'>~carno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1" ><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtNoa"  type="text"   class="txt c1"/>
						</td>
						<td class="td4" ><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td5">
						<input id="txtDatea" type="text"   class="txt c1"/>
						</td>
						<td>  </td>
						<td>  </td>
						<td  class="tdZ">  </td>
					</tr>
					<tr class="tr2">
						<td class="td1" ><span> </span><a id='lblTicketno' class="lbl"> </a></td>
						<td class="td2"><input id="txtTicketno" type="text"  class="txt c1"/></td>
						<td class="td3" ><span> </span><a id='lblTicketdate' class="lbl"> </a></td>
						<td class="td4"><input id="txtTicketdate" type="text"  class="txt c1"/></td>
						<td>  </td>
						<td>  </td>
						<td>  </td>
						<td  class="tdZ">  </td>
					</tr>
					<tr class="tr3">
						<td class="td1" ><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td class="td2"><input id="txtCarno" type="text"   class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblDriver' class="lbl btn" > </a></td>
						<td class="td4" colspan="2">
							<input id="txtDriverno" type="text"  class="txt c2"/>
							<input id="txtDriver" type="text"  class="txt c3"/>
						</td>
						<td class="td6" ><span> </span><a id='lblId' class="lbl"> </a></td>
						<td class="td7" colspan="2"><input id="txtId" type="text"   class="txt c1"/></td>
					</tr>
					<tr class="tr4">
						<td class="td1" ><span> </span><a id='lblAppeardate' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtAppeardate" type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td class="td4">
						<input id="txtPaydate"  type="text"   class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1" ><span> </span><a id='lblIrregularities' class="lbl"> </a></td>
						<td class="td2" colspan='7'><input id="txtIrregularities" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblBmon' class="lbl" ></a></td>
						<td class="td2" >
						<input id="txtBmon" type="text"  class="txt c1"/>
						</td>
						<td class="td3" align="center"><a id='lblEmon' style="font-weight: bolder;font-size: 20px;" ></a></td>
						<td class="td4" >
						<input id="txtEmon" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1" ><span> </span><a id='lblMoney' class="lbl"></a></td>
						<td class="td2">
						<input id="txtMoney"  type="text"   class="txt num c1"/>
						</td>
						<td class="td3" ><span> </span><a id='lblDriverpay' class="lbl"></a></td>
						<td class="td4">
						<input id="txtDriverpay"  type="text"   class="txt num c1"/>
						</td>
						<td class="td5" ><span> </span><a id='lblComppay' class="lbl"></a></td>
						<td class="td6">
						<input id="txtComppay"  type="text"   class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td7" ><span> </span><a id='lblWorker' class="lbl" ></a></td>
						<td class="td8">
						<input id="txtWorker" type="text"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
