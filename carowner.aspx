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

            var q_name = "carowner";
            var q_readonly = [];
            var bbmNum = [];
            var bbmMask = [['txtZip_home', '999-99'], ['txtZip_conn', '999-99'], ['txtBirthday', '999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtComp', 'acomp_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();

                q_gt(q_name, q_content, q_sqlCount, 1);
            });
            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(0);
            }

            function mainPost() {
                bbmMask = [['txtBirthday', r_picd], ['txtIndate', r_picd], ['txtHealth_bdate', r_picd], ['txtHealth_edate', r_picd], ['txtLabor1_bdate', r_picd], ['txtLabor1_edate', r_picd], ['txtLabor2_bdate', r_picd], ['txtLabor2_edate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbSex", q_getPara('sys.sex'));
                
                if(q_getPara('sys.project').toUpperCase()!="DC"){
                	$("#divBalance").hide();
                	$("#divCarlender").hide();
                	$("#divLabase").hide();
                }
                
                $('#lblBalance').parent().click(function(e) {
                    q_box("balance.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'balance', "95%", "95%", q_getMsg("popBalance"));
                });
                $('#lblCarlender').parent().click(function(e) {
                    q_box("carlender.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'carlender', "95%", "95%", q_getMsg("popCarlender"));
                });
                $('#lblLabase').parent().click(function(e) {
                    q_box("labase.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'labase', "95%", "95%", q_getMsg("popLabase"));
                });
                
                $('#txtNoa').change(function() {
                    var t_where = "where=^^ noa ='"+$('#txtNoa').val()+"' ^^";
					q_gt('carowner', t_where, 0, 0, 0, "changenoa");
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
                	case 'changenoa':
                		var as = _q_appendData("carowner", "", true);
                		 if (as[0] != undefined) {
                		 	alert($('#txtNoa').val()+'車主編號重覆!!');
                		 	$('#txtNoa').val('');
							$('#txtNoa').focus();
                		 }
                		break;
                    case q_name:
                        if (q_cur == 1) {
                            var as = _q_appendData("carowner", "", true);
                            if (as[0] != undefined) {
                                $('#txtNoa').val(as[0].noa.substr(0, 1) + (dec(as[0].noa.substr(1)) + 1));
                            }else{
                            	$('#txtNoa').val('H001');
                            }
                        }

                        if (q_cur == 4)
                            q_Seek_gtPost();

                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('carowner_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNamea').focus();
                var t_where = "where=^^ noa=(select MAX(noa) from carOwner) ^^";
                q_gt('carowner', t_where, 0, 0, 0, "", r_accy);
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                refreshBbm();
                $('#txtNamea').focus();
            }

            function btnPrint() {

            }

            function btnOk() {
                if ($('#txtBirthday').val().length > 0 && checkId($('#txtBirthday').val()) != 4) {
                    alert(q_getMsg('lblBirthday') + '錯誤。');
                    return;
                }
                /*if ($('#txtIdno').val().length > 0 && checkId($('#txtIdno').val()) != 1) {
                    alert(q_getMsg('lblIdno') + '錯誤。');
                    return;
                }*/
               if(emp($('#txtNoa').val())){
               		alert(q_getMsg('lblNoa')+'請填寫!!');
               		return;
               }
               
                var t_noa = $('#txtNoa').val();
                wrServer(t_noa);
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
                } else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 3;
                } else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
                    str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 4
                }
                return 0;
                //錯誤
            }

            function returnparent() {
                if (window.parent.q_name == 'car2') {
                    var wParent = window.parent.document;
                    wParent.getElementById("txtCarownerno").value = $('#txtNoa').val();
                    wParent.getElementById("txtCarowner").value = $('#txtNamea').val();
                    wParent.getElementById("cmbSex").value = $('#cmbSex').val();
                    wParent.getElementById("txtIdno").value = $('#txtIdno').val();
                    wParent.getElementById("txtBirthday").value = $('#txtBirthday').val();
                    wParent.getElementById("txtTel1").value = $('#txtTel1').val();
                    wParent.getElementById("txtTel2").value = $('#txtTel2').val();
                    wParent.getElementById("txtMobile").value = $('#txtMobile').val();
                    wParent.getElementById("txtFax").value = $('#txtFax').val();
                    wParent.getElementById("txtAddr_conn").value = $('#txtAddr_conn').val();
                    wParent.getElementById("txtAddr_home").value = $('#txtAddr_home').val();
                }
            }
            
            function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
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
                width: 73%;
                margin: -1px;
                /*border: 1px black solid;*/
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
                width: 8%;
                float: left;
            }
            .txt.c5 {
                width: 90%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
            .popDiv {
                position: absolute;
                z-index: 99;
                background: #4297D7;
                height: 370px;
                width: 500px;
                border: 2px #EEEEEE solid;
                border-radius: 5px;
                padding-top: 10px;
                display: none;/*default*/
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
                width: 95px;
                height: 25px;
                float: left;
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
                font-size: 16px;
                height: 25px;
                line-height: 25px;
                display: block;
                text-align: center;
            }
		</style>
	</head>
	<body onunload='returnparent()'>
		<form id="form1" style="height: 100%;" action="">
			<!--#include file="../inc/toolbar.inc"-->
			<div id='dmain' style="overflow:hidden;">
				<div class="dview" id="dview">
					<table class="tview" id="tview">
						<tr>
							<td style="width:5%"><a id='vewChk'></a></td>
							<td style="width:25%"><a id='vewNoa'></a></td>
							<td style="width:40%"><a id='vewNamea'></a></td>
						</tr>
						<tr>
							<td>
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td id='noa'>~noa</td>
							<td id='namea'>~namea</td>
						</tr>
					</table>
				</div>
				<div class='dbbm'>
					<table class="tbbm"  id="tbbm">
						<tr class="tr1">
							<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
							<td class="td2">
							<input id="txtNoa"  type="text" class="txt c1"/>
							</td>
							<td class="td3"><span> </span><a id='lblNamea' class="lbl"></a></td>
							<td class="td4">
							<input id="txtNamea"  type="text" class="txt c1"/>
							</td>
							<td class="td5"><span> </span><a id='lblSpouse' class="lbl"></a></td>
							<td class="td6">
							<input id="txtSpouse"  type="text" class="txt c1"/>
							</td>
						</tr>
						<tr class="tr2">
							<td class="td1"><span> </span><a id='lblBirthday' class="lbl"></a></td>
							<td class="td2">
							<input id="txtBirthday"  type="text" class="txt c1"/>
							</td>
							<td class="td3"><span> </span><a id='lblIdno' class="lbl"></a></td>
							<td class="td4">
							<input id="txtIdno"  type="text" class="txt c1"/>
							</td>
							<td class="td5" ><span> </span><a id='lblSex' class="lbl"></a></td>
							<td class="td6" ><select id="cmbSex" class="txt c6"></select></td>
						</tr>
						<tr class="tr3">
							<td class="td1"><span> </span><a id='lblTel1' class="lbl"></a></td>
							<td class="td2">
							<input id="txtTel1"  type="text" class="txt c1"/>
							</td>
							<td class="td3"><span> </span><a id='lblTel2' class="lbl"></a></td>
							<td class="td4">
							<input id="txtTel2"  type="text" class="txt c1"/>
							</td>
						</tr>
						<tr class="tr4">
							<td class="td1"><span> </span><a id='lblMobile' class="lbl"></a></td>
							<td class="td2">
							<input id="txtMobile"  type="text"class="txt c1"/>
							</td>
							<td class="td3"><span> </span><a id='lblFax' class="lbl"></a></td>
							<td class="td4">
							<input id="txtFax"  type="text" class="txt c1"/>
							</td>
						</tr>
						<tr>
							<td class="td1"><span> </span><a id='lblIndate' class="lbl"></a></td>
							<td class="td2">
							<input id="txtIndate" type="text" class="txt c1"/>
							</td>
						</tr>
						<!--<tr>
						<td class="td1"><span> </span><a id='lblHealth_bdate' class="lbl"></a></td>
						<td class="td2"><input id="txtHealth_bdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblHealth_edate' class="lbl"></a></td>
						<td class="td4"><input id="txtHealth_edate" type="text" class="txt c1"/></td>
						</tr>
						<tr>
						<td class="td1"><span> </span><a id='lblLabor1_bdate' class="lbl"></a></td>
						<td class="td2"><input id="txtLabor1_bdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblLabor1_edate' class="lbl"></a></td>
						<td class="td4"><input id="txtLabor1_edate" type="text" class="txt c1"/></td>
						</tr>
						<tr>
						<td class="td1"><span> </span><a id='lblLabor2_bdate' class="lbl"></a></td>
						<td class="td2"><input id="txtLabor2_bdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblLabor2_edate' class="lbl"></a></td>
						<td class="td4"><input id="txtLabor2_edate" type="text" class="txt c1"/></td>
						</tr>
						<tr>
						<td class="td1"><span> </span><a id='lblAcomp' class="lbl btn" ></a></td>
						<td class="td2" colspan="3">
						<input id="txtCno"type="text" class="txt c2" style="width: 30%"/>
						<input id="txtComp"  type="text"  class="txt c3" style="width: 69%"/>
						</td>
						</tr>-->
						<tr class="tr5">
							<td class="td1"><span> </span><a id='lblAddr_home' class="lbl"></a></td>
							<td class="td2" colspan="5">
							<input id="txtZip_home" type="text" class="txt c4"/>
							<input id="txtAddr_home" type="text" class="txt c5"/>
							</td>
						</tr>
						<tr class="tr6">
							<td class="td1"><span> </span><a id='lblAddr_conn' class="lbl"></a></td>
							<td class="td2" colspan="5">
							<input id="txtZip_conn" type="text" class="txt c4"/>
							<input id="txtAddr_conn" type="text" class="txt c5"/>
							</td>
						</tr>
						<tr class="tr7">
							<td class="td1"><span> </span><a id='lblMemo2' class="lbl"></a></td>
							<td class="td2" colspan="5">
							<input id="txtMemo2" type="text" class="txt c1"/>
							</td>
						</tr>
						<tr class="tr8">
							<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
							<td class="td2" colspan="5">							<textarea id="txtMemo" cols="10" rows="5" style="width: 93%; height: 50px;"></textarea></td>
						</tr>
					</table>
					<div style="border-radius: 5px; height:30px; padding: 5px 0 0 5px; ">
						<div id='divBalance' class='btnLbl button'>
							<a id='lblBalance'></a>
						</div>
						<div id='divCarlender' class='btnLbl button'>
							<a id='lblCarlender'></a>
						</div>
						<div id='divLabase' class='btnLbl button'>
							<a id='lblLabase'></a>
						</div>
					</div>
				</div>
			</div>
			<input id="q_sys" type="hidden" />
		</form>
	</body>
</html>
