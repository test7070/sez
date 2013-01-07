<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            var q_name = "stampuse";
            var q_readonly = ['txtNoa'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc=1;
            //ajaxPath = ""; //  execute in Root
			 aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea,partno,part', 'txtSssno,txtNamea,txtPartno,txtPart', 'sss_b.aspx'],
			 ['txtStampno', 'lblStamp', 'stamp', 'noa,namea,typea', 'txtStampno,txtStamp,cmbTypea', 'stamp_b.aspx'],
			 ['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
			 ['txtTsssno', 'lblTsss', 'sss', 'noa,namea', 'txtTsssno,txtTnamea', 'sss_b.aspx'],
			 ['txtTsssno2', 'lblTsss2', 'sss', 'noa,namea', 'txtTsssno2,txtTnamea2', 'sss_b.aspx'],
			 ['txtTsssno3', 'lblTsss3', 'sss', 'noa,namea', 'txtTsssno3,txtTnamea3', 'sss_b.aspx'],
			 ['txtTsssno4', 'lblTsss4', 'sss', 'noa,namea', 'txtTsssno4,txtTnamea4', 'sss_b.aspx'],
			 ['txtTsssno5', 'lblTsss5', 'sss', 'noa,namea', 'txtTsssno5,txtTnamea5', 'sss_b.aspx'],
			 ['txtRsssno', 'lblRsss', 'sss', 'noa,namea', 'txtRsssno,txtRnamea', 'sss_b.aspx']);
			 
            $(document).ready(function() {
               bbmKey = ['noa'];
	            q_brwCount();
	           	q_gt(q_name, q_content, q_sqlCount, 1)
	            $('#txtNoa').focus
        	});

            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }///  end Main()
            
            function mainPost() {
            	q_getFormat();
            	bbmMask = [['txtDatea', r_picd],['txtTdate', r_picd],['txtTdate2', r_picd],['txtTdate3', r_picd],['txtTdate4', r_picd],['txtTdate5', r_picd],['txtRdate', r_picd]];
				q_mask(bbmMask);
				
				q_cmbParse("cmbTypea", q_getPara('stamp.typea'));
	            $("#cmbTypea").focus(function() {
					var len = $("#cmbTypea").children().length > 0 ? $("#cmbTypea").children().length : 1;
					$("#cmbTypea").attr('size', len + "");
				}).blur(function() {
					$("#cmbTypea").attr('size', '1');
				});
				
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
                    for( i = 0; i < adest.length; i++) {
                        if(t_copy)
                            $('#' + adest[i]).val($('#' + asource[i]).val());

                        if(t_clear)
                           $('#' + adest[i]).val('');

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
                        break;
                }  /// end switch
            }
            
            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
            q_box('stampuse_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
            }
			
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                if (!emp($('#txtRdate').val())&&!emp($('#txtRsssno').val())){
		            	$('#txtDatea').attr('disabled', 'disabled');
		            	$('#txtSssno').attr('disabled', 'disabled');
		            	$('#txtNamea').attr('disabled', 'disabled');
		            	$('#txtPartno').attr('disabled', 'disabled');
		            	$('#txtPart').attr('disabled', 'disabled');
		            	$('#txtStampno').attr('disabled', 'disabled');
		            	$('#txtStamp').attr('disabled', 'disabled');
		            	$('#cmbTypea').attr('disabled', 'disabled');
		            	$('#cmbTypea').css('background', t_background2);
		            	$('#txtTdate').attr('disabled', 'disabled');
		            	$('#txtTsssno').attr('disabled', 'disabled');
		            	$('#txtTnamea').attr('disabled', 'disabled');
		            	$('#txtTdate2').attr('disabled', 'disabled');
		            	$('#txtTsssno2').attr('disabled', 'disabled');
		            	$('#txtTnamea2').attr('disabled', 'disabled');
		            	$('#txtTdate3').attr('disabled', 'disabled');
		            	$('#txtTsssno3').attr('disabled', 'disabled');
		            	$('#txtTnamea3').attr('disabled', 'disabled');
		            	$('#txtTdate4').attr('disabled', 'disabled');
		            	$('#txtTsssno4').attr('disabled', 'disabled');
		            	$('#txtTnamea4').attr('disabled', 'disabled');
		            	$('#txtTdate5').attr('disabled', 'disabled');
		            	$('#txtTsssno5').attr('disabled', 'disabled');
		            	$('#txtTnamea5').attr('disabled', 'disabled');
		            	$('#txtRdate').attr('disabled', 'disabled');
		            	$('#txtRsssno').attr('disabled', 'disabled');
		            	$('#txtRnamea').attr('disabled', 'disabled');
            	}else{
            			$('#txtDatea').attr('disabled', 'disabled');
		            	$('#txtSssno').attr('disabled', 'disabled');
		            	$('#txtNamea').attr('disabled', 'disabled');
		            	$('#txtPartno').attr('disabled', 'disabled');
		            	$('#txtPart').attr('disabled', 'disabled');
		            	$('#txtStampno').attr('disabled', 'disabled');
		            	$('#txtStamp').attr('disabled', 'disabled');
		            	$('#cmbTypea').attr('disabled', 'disabled');
		            	$('#cmbTypea').css('background', t_background2);
            	}
            }

            function btnPrint() {

            }

            function btnOk() {
 				$('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
           		}
 				$('#txtTdate').val($.trim($('#txtTdate').val()));
                if (checkId($('#txtTdate').val())==0){
                	alert(q_getMsg('lblTdate')+'錯誤。');
                	return;
           		}
 				$('#txtTdate2').val($.trim($('#txtTdate2').val()));
                if (checkId($('#txtTdate2').val())==0){
                	alert(q_getMsg('lblTdate2')+'錯誤。');
                	return;
           		}
 				$('#txtTdate3').val($.trim($('#txtTdate3').val()));
                if (checkId($('#txtTdate3').val())==0){
                	alert(q_getMsg('lblTdate3')+'錯誤。');
                	return;
           		}
 				$('#txtTdate4').val($.trim($('#txtTdate4').val()));
                if (checkId($('#txtTdate4').val())==0){
                	alert(q_getMsg('lblTdate4')+'錯誤。');
                	return;
           		}
 				$('#txtTdate5').val($.trim($('#txtTdate5').val()));
                if (checkId($('#txtTdate5').val())==0){
                	alert(q_getMsg('lblTdate5')+'錯誤。');
                	return;
           		}
 				$('#txtRdate').val($.trim($('#txtRdate').val()));
                if (checkId($('#txtRdate').val())==0){
                	alert(q_getMsg('lblRdate')+'錯誤。');
                	return;
           		}
           		var t_err = '';
                t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')],['txtSssno', q_getMsg('lblSss')]]);

                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                
                var t_noa = trim($('#txtNoa').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll( 'S'+$('#txtDatea').val(), '/', ''));
				else
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
                width: 98%;
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
                width: 25%;
                
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
				<div class="dview" id="dview" style="float: left;  width:25%;"  >
					<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
						<tr>
							<td align="center" style="width:5%"><a id='vewChk'></a></td>
							<td align="center" style="width:25%"><a id='vewDatea'></a></td>
							<td align="center" style="width:40%"><a id='vewNamea'></a></td>
						</tr>
						<tr>
							<td >
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td align="center" id='datea'>~datea</td>
							<td align="center" id='namea'>~namea</td>
						</tr>
					</table>
				</div>
				<div class='dbbm' style="width: 73%;float: left;">
					<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
						<tr>
							<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
							<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
							<td class="td3" ></td>
							<td class="td4"></td>
							<td class="td5" ></td>
						</tr>
						<tr>
							<td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
							<td class="td2"><input id="txtDatea"  type="text" class="txt c1" /></td>
							<td class="td3" ></td>
							<td class="td4"></td>
							<td class="td5" ></td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblSss' class="lbl btn"></a></td>
							<td class="td2">
								<input id="txtSssno"  type="text"  class="txt c2"/>
								<input id="txtNamea"  type="text"  class="txt c3"/>
							</td>
							<td class="td3" ><span> </span>	<a id='lblPart' class="lbl btn"></a></td>
							<td class="td4">
								<input id="txtPartno"  type="text"  class="txt c2"/>
								<input id="txtPart"  type="text"  class="txt c3"/>
							</td>
							<td class="td5"></td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblStamp' class="lbl btn"></a></td>
							<td class="td2" colspan="2">
								<input id="txtStampno"  type="text"  class="txt" style="width: 18%;float: left;"/>
								<input id="txtStamp"  type="text"  class="txt" style="width: 80%;float: left;"/>
							</td>
							<td class="td4"><select id="cmbTypea" class="txt c1" style="font-size: medium;"></select></td>
							<td class="td5"></td>
						</tr>
						<tr>
							<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
							<td class="td2" colspan="3"><input id="txtMemo"  type="text" class="txt c1"/></td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblTdate' class="lbl"></a></td>
							<td class="td2"><input id="txtTdate"  type="text" class="txt c1" /></td>
							<td class="td3" ><span> </span>	<a id='lblTsss' class="lbl btn"></a></td>
							<td class="td4">
								<input id="txtTsssno"  type="text"  class="txt c2"/>
								<input id="txtTnamea"  type="text"  class="txt c3"/>
							</td>
							<td class="td5"></td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblTdate2' class="lbl"></a></td>
							<td class="td2"><input id="txtTdate2"  type="text" class="txt c1" /></td>
							<td class="td3" ><span> </span>	<a id='lblTsss2' class="lbl btn"></a></td>
							<td class="td4">
								<input id="txtTsssno2"  type="text"  class="txt c2"/>
								<input id="txtTnamea2"  type="text"  class="txt c3"/>
							</td>
							<td class="td5"></td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblTdate3' class="lbl"></a></td>
							<td class="td2"><input id="txtTdate3"  type="text" class="txt c1" /></td>
							<td class="td3" ><span> </span>	<a id='lblTsss3' class="lbl btn"></a></td>
							<td class="td4">
								<input id="txtTsssno3"  type="text"  class="txt c2"/>
								<input id="txtTnamea3"  type="text"  class="txt c3"/>
							</td>
							<td class="td5"></td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblTdate4' class="lbl"></a></td>
							<td class="td2"><input id="txtTdate4"  type="text" class="txt c1" /></td>
							<td class="td3" ><span> </span>	<a id='lblTsss4' class="lbl btn"></a></td>
							<td class="td4">
								<input id="txtTsssno4"  type="text"  class="txt c2"/>
								<input id="txtTnamea4"  type="text"  class="txt c3"/>
							</td>
							<td class="td5"></td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblTdate5' class="lbl"></a></td>
							<td class="td2"><input id="txtTdate5"  type="text" class="txt c1" /></td>
							<td class="td3" ><span> </span>	<a id='lblTsss5' class="lbl btn"></a></td>
							<td class="td4">
								<input id="txtTsssno5"  type="text"  class="txt c2"/>
								<input id="txtTnamea5"  type="text"  class="txt c3"/>
							</td>
							<td class="td5"></td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblRdate' class="lbl"></a></td>
							<td class="td2"><input id="txtRdate"  type="text" class="txt c1" /></td>
							<td class="td3" ><span> </span>	<a id='lblRsss' class="lbl btn"></a></td>
							<td class="td4">
								<input id="txtRsssno"  type="text"  class="txt c2"/>
								<input id="txtRnamea"  type="text"  class="txt c3"/>
							</td>
							<td class="td5"></td>
						</tr>
			</table>
			</div>
			</div>
			<input id="q_sys" type="hidden" />
	</body>
</html>
