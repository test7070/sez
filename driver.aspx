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
            var bbmMask = [['txtZip_home','999-99'],['txtIndate', '999/99/99'],['txtZip_conn','999-99'],['txtBirthday','999/99/99'],['txtTakeofficedate','999/99/99'],['txtLeaveofficedate','999/99/99'],['txtStrdate','999/99/99'],['txtEnddate','999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            //q_alias = 'a';
            aPop = new Array(['txtInsurerno', 'lblInsurer', 'insurer', 'noa,comp', 'txtInsurerno,txtInsurer', 'Insurer_b.aspx'],
            ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'Cardeal_b.aspx'],
            ['txtBankno2', 'lblBank2', 'bank', 'noa,bank', 'txtBankno2,txtBank2', 'Bank_b.aspx'],
            ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtComp', 'acomp_b.aspx'])

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
                $('#btnLabase').click(function (e) {
		            q_box("labase.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'labase', "95%", "95%", q_getMsg("popLabase"));
		        });
		        $('#btnFamily').click(function (e) {
		            q_box("labases_b.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'labases', "95%", "95%", q_getMsg("popLabases"));
		        });
		        $('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
                    		q_gt('driver', t_where, 0, 0, 0, "checkDriverno_change", r_accy);
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
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
                	case 'checkDriverno_change':
                		var as = _q_appendData("driver", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].namea);
                        }
                		break;
                	case 'checkDriverno_btnOk':
                		var as = _q_appendData("driver", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].namea);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
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
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtNoa').attr('readonly','readonly');
                $('#txtNamea').focus();
            }

            function btnPrint() {
				q_box('z_driver.aspx' + "?;;;;" + r_accy, '', "90%", "600px", q_getMsg("popPrint"));
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
            	/*$('#txtBirthday').val($.trim($('#txtBirthday').val()));
                if (checkId($('#txtBirthday').val())==0){
                	alert(q_getMsg('lblBirthday')+'錯誤。');
                	return;
            	}
            	$('#txtTakeofficedate').val($.trim($('#txtTakeofficedate').val()));
                if (checkId($('#txtTakeofficedate').val())==0){
                	alert(q_getMsg('lblTakeofficedate')+'錯誤。');
                	return;
            	}
            	$('#txtLeaveofficedate').val($.trim($('#txtLeaveofficedate').val()));
                if (checkId($('#txtLeaveofficedate').val())==0){
                	alert(q_getMsg('lblLeaveofficedate')+'錯誤。');
                	return;
            	}
            	$('#txtStrdate').val($.trim($('#txtStrdate').val()));
                if (checkId($('#txtStrdate').val())==0){
                	alert(q_getMsg('lblStrdate')+'錯誤。');
                	return;
            	}
            	$('#txtEnddate').val($.trim($('#txtEnddate').val()));
                if (checkId($('#txtEnddate').val())==0){
                	alert(q_getMsg('lblEnddate')+'錯誤。');
                	return;
            	}*/
            	if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('driver', t_where, 0, 0, 0, "checkDriverno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }               
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
                    var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
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
						<td class="td1"><span> </span><a id='lblIndate' class="lbl" style="display: none;"></a></td>
						<td class="td2"><input id="txtIndate" type="text" class="txt c1" style="display: none;"/></td>
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
					<tr style="display:none;" title="改由LABASE抓資料">
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
					<tr style="display:none;" title="改由LABASE抓資料">
						<td class="td1"><span> </span><a id='lblHealth_bdate' class="lbl"></a></td>
						<td class="td2"><input id="txtHealth_bdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblHealth_edate' class="lbl"></a></td>
						<td class="td4"><input id="txtHealth_edate" type="text" class="txt c1"/></td>
						<td class="td1"><span> </span><a id='lblLabor1_bdate' class="lbl"></a></td>
						<td class="td2"><input id="txtLabor1_bdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblLabor1_edate' class="lbl"></a></td>
						<td class="td4"><input id="txtLabor1_edate" type="text" class="txt c1"/></td>
					</tr>
					<tr style="display:none;" title="改由LABASE抓資料">
						<td class="td1"><span> </span><a id='lblLabor2_bdate' class="lbl"></a></td>
						<td class="td2"><input id="txtLabor2_bdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblLabor2_edate' class="lbl"></a></td>
						<td class="td4"><input id="txtLabor2_edate" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblMoney" class="lbl"></a></td>
						<td class="td6">
						<input id="txtMoney" type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSalmoney" class="lbl"></a></td>
						<td><input id="txtSalmoney" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAcomp' class="lbl btn" ></a></td>
						<td class="td2" colspan="3">
							<input id="txtCno"type="text" class="txt c2" style="width: 30%"/>
							<input id="txtComp"  type="text"  class="txt c3" style="width: 69%"/>
						</td>
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
						<td class="td7"><input id='btnFamily' type="button" /></td>
						<td class="td8"><input id='btnLabase' type="button" /></td>
					</tr>
					<tr class="tr15">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
						<td class="td2" colspan='7'><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<input id="q_sys" type="hidden" />
	</body>
</html>
