<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "cust";
            var q_readonly = ['txtSales', 'txtGrpname', 'txtUacc1', 'txtUacc2', 'txtUacc3'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 20;
            
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
            , ['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx']
            , ['txtGrpno', 'lblGrp', 'team', 'noa,team', 'txtGrpno,txtGrpname', 'team_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];

                xmlTable = 'conn';
                xmlKey = [['noa', 'noq']];
                xmlDec = [];
                q_popSave(xmlTable);
                // for conn_b.aspx
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)

                $('#txtNoa').focus
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }///  end Main()

            function mainPost() {
            	bbmMask = [['txtChkdate', r_picd], ['txtDuedate', r_picd], ['txtGetdate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('cust.typea'));
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
                q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));
                
                $('#btnUcam').click(function() {
                    t_where = "noa='" + $('#txtNoa').val() + "'";
                    q_box("ucam_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucam', "95%", "95%", q_getMsg('btnUcam'));
             	});
                
				 $('#btnConn').click(function() {
                    t_where = "noa='" + $('#txtNoa').val() + "'";
                    q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('btnConn'));
                });
                /*$('#lblConn').click(function() {
                    t_where = "noa='" + $('#txtNoa').val() + "'";
                    q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('lblConn'));
                });*/
				
				$('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
                    		q_gt('cust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
                });
				
                //txtCopy('txtPost_comp,txtAddr_comp', 'txtPost_fact,txtAddr_fact');
                //txtCopy('txtPost_invo,txtAddr_invo', 'txtPost_comp,txtAddr_comp');
                //txtCopy('txtPost_home,txtAddr_home', 'txtPost_invo,txtAddr_invo');

                $('#txtUacc4').change(function() {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');

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
 					case 'checkCustno_change':
                		var as = _q_appendData("cust", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].comp);
                        }
                		break;
                	case 'checkCustno_btnOk':
                		var as = _q_appendData("cust", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].comp);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
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

                q_box('cust_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPaytype_chg() {
                var cmb = document.getElementById("combPaytype")
                if (!q_cur)
                    cmb.value = '';
                else
                    $('#txtPaytype').val(cmb.value);
                cmb.value = '';
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                refreshBbm();
                $('#txtComp').focus();
            }

            function btnPrint() {

            }
			 function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
            function btnOk() {
				Lock(); 
            	$('#txtNoa').val($.trim($('#txtNoa').val()));   	
            	if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
				}else{
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
					Unlock();
					return;
				}
				
                if (dec($('#txtCredit').val()) > 9999999999)
                    t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

                if (dec($('#txtStartn').val()) > 31)
                    t_err = t_err + q_getMsg("lblStartn") + q_getMsg("msgErr") + '\r';
                if (dec($('#txtGetdate').val()) > 31)
                    t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r'

                 $('#txtWorker' ).val(r_name);
                if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('cust', t_where, 0, 0, 0, "checkCustno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
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
                refreshBbm();
            }
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
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
			function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
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
            .tbbm select {
                font-size: medium;
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
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 49%;
                float: left;
            }
            .txt.c7 {
                width: 99%;
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
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewNoa'></a></td>
						<td align="center" style="width:40%"><a id='vewComp'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblSerial' class="lbl"></a></td>
						<td class="td4">
						<input id="txtSerial" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td class="td6">
						<input id="txtKeyin" type="text" class="txt c6"/>
						<input id="txtWorker" type="text"  class="txt c6"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblComp' class="lbl"></a></td>
						<td class="td2" colspan='3'>
						<input id="txtComp" type="text" class="txt c7"/>
						</td>
						<td class="td3"><span> </span><a id='lblNick' class="lbl"></a></td>
						<td class="td4">
						<input id="txtNick" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblBoss' class="lbl"></a></td>
						<td class="td2">
						<input id="txtboss" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblHead' class="lbl"></a></td>
						<td class="td4">
						<input id="txthead" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblStatus' class="lbl"></a></td>
						<td class="td6">
						<input id="txtStatus"   type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td3"><span> </span><a id='lblType' class="lbl"></a></td>
						<td class="td4"><select id="cmbTypea" class="txt c1"></select></td>
						<td class="td5"><span> </span><a id='lblTeam' class="lbl"></a></td>
						<td class="td6">
						<input id="txtTeam"   type="text"  class="txt c1"/>
						</td>
						<td><input id="btnConn" type="button" /></td>
					</tr>
					<tr class="tr5">
						<td><span> </span><a id="lblGrp"  class="lbl btn"> </a></td>
						<td>
							<input id="txtGrpno" type="text" style="float:left; width:40%;"/>
							<input id="txtGrpname" type="text" style="float:left; width:60%;"/>
						</td>
						<td><span> </span><a id='lblTeampaytype' class="lbl"> </a></td>
						<td><input id="txtTeampaytype" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id='lblTel' class="lbl"></a></td>
						<td class="td2" colspan='5' >
						<input id="txtTel" type="text"  class="txt c7"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblFax' class="lbl"></a></td>
						<td class="td2" colspan='3' >
						<input id="txtFax" type="text" class="txt c7"/>
						</td>
						<td class="td5"><span> </span><a id='lblMobile' class="lbl"></a></td>
						<td class="td6">
						<input id="txtMobile" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblAddr_fact' class="lbl"></a></td>
						<td class="td2">
						<input id="txtZip_fact" type="text"  class="txt c1">
						</td>
						<td class="td3" colspan='4' >
						<input id="txtAddr_fact"  type="text" class="txt c7"/>
						</td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblAddr_comp' class="lbl"></a></td>
						<td class="td2" >
						<input id="txtZip_comp" type="text" class="txt c1"/>
						</td>
						<td class="td3" colspan='4' >
						<input id="txtAddr_comp"  type="text" class="txt c7"/>
						</td>
					</tr>
					<tr class="tr10">
						<td class="td1"><span> </span><a id='lblAddr_invo' class="lbl"></a></td>
						<td class="td2" >
						<input id="txtZip_invo" type="text" class="txt c1"/>
						</td>
						<td class="td3" colspan='4' >
						<input id="txtAddr_invo"  type="text" class="txt c7"/>
						</td>
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id='lblAddr_home' class="lbl"></a></td>
						<td class="td2">
						<input id="txtZip_home" type="text" class="txt c1"/>
						</td>
						<td class="td3" colspan='4'>
						<input id="txtAddr_home"  type="text" class="txt c7"/>
						</td>
					</tr>
					<tr class="tr12">
						<td class="td1"><span> </span><a class="lbl">E-mail</a></td>
						<td class="td2" colspan='5'>
						<input id="txtEmail"  type="text"  class="txt c7"/>
						</td>
					</tr>
					<tr class="tr13">
						<td class="td1"><span> </span><a id="lblCredit" class="lbl btn" ></a></td>
						<td class="td2">
						<input id="txtCredit" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblSales" class="lbl btn"></a></td>
						<td class="td4">
						<input id="txtSalesno" type="text" class="txt c6"/>
						<input id="txtSales"    type="text" class="txt c6"/>
						</td>
						<td class="td5"><input id="btnUcam" type="button"  /></td>
					</tr>
					<tr class="tr14">
						<td class="td1"><span> </span><a id='lblChkstatus' class="lbl"></a></td>
						<td class="td2" colspan='3'>
						<input id="txtChkstatus"  type="text"  class="txt c7" />
						</td>
						<td class="td5"><span> </span><a id='lblUacc4' class="lbl"></a></td>
						<td class="td6">
						<input id="txtUacc4"    type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr15">
						<td class="td1"><span> </span><a id='lblChkdate' class="lbl"></a></td>
						<td class="td2">
						<input id="txtChkdate" type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblStartdate' class="lbl"> </a></td>
						<td><input id="txtStartdate" type="text" class="txt c1" />	</td>
						<td class="td5"><span> </span><a id='lblUacc1' class="lbl"></a></td>
						<td class="td6">
						<input id="txtUacc1" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr16">
						<td><span> </span><a id='lblDueday' class="lbl"> </a></td>
						<td><input id="txtDueday" type="text" class="txt num c1"/>	</td>
						<td class="td3"><span> </span><a id='lblGetdate' class="lbl"></a></td>
						<td class="td4">
						<input id="txtGetdate" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblUacc2' class="lbl"></a></td>
						<td class="td6">
						<input id="txtUacc2" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr17">
						<td class="td1"><span> </span><a id='lblTrantype' class="lbl"></a></td>
						<td class="td2"><select id="cmbTrantype" class="txt c1"></select></td>
						<td class="td3"><span> </span><a id='lblPaytype' class="lbl"></a></td>
						<td class="td4">
						<input id="txtPaytype" type="text" class="txt c6"/>
						<select id="combPaytype" class="txt c6" onchange='combPaytype_chg()'></select></td>
						<td class="td5"><span> </span><a id='lblUacc3' class="lbl"></a></td>
						<td class="td6">
						<input id="txtUacc3" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr18">
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan='5'>						<textarea id="txtMemo"  rows='5' cols='10' style="width:99%; height: 50px;"></textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
