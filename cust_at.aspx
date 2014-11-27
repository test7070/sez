<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "cust";
            var q_readonly = ['txtWorker','txtWorker2'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 15;
            aPop = new Array(['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                q_cmbParse("cmbTypea",' ,'+q_getMsg('at.typea').replace(/\^/g,','));
                
                $('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						//if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
                    		q_gt('cust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
						/*}else{
							Lock(1,{opacity:0});
							alert('編號只允許 英文(A-Z)、數字(0-9)及連字號(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock(1);
						}*/
					}
                });
                $('#txtSerial').change(function() {
                	$(this).val($.trim($(this).val()).toUpperCase());
                	if ($(this).val().length > 0 && checkId($(this).val())!=2){
                		Lock(1,{opacity:0});
	            		alert(q_getMsg('lblSerial')+'錯誤。');
	            		Unlock(1);
	            	}
                });
                $('#btnConn').click(function() {
                    t_where = "noa='" + $('#txtNoa').val() + "'";
                    q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('btnConn'));
                });
                $('#btnDetail').click(function() {
                    t_where = "noa='" + $('#txtNoa').val() + "'";
                    q_box("custdetail_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'custdetail', "95%", "650px", q_getMsg('btnDetail'));
                });
                $('#txtUacc1').change(function(e){
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
                });
                $('#txtUacc2').change(function(e){
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
                });
                $('#txtUacc3').change(function(e){
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
                });
                $('#txtUacc4').change(function(e){
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
                });
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }  
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
                            Unlock(1);
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	break;
                } 
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('cust_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
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
                q_box('z_cust_ds.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.cust':
                        break;
                    
                    default:
                    	break;
                }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                if(q_getPara('sys.comp').substring(0,2)=='菱揚')
                	q_func('qtxt.query.cust', 'cust.txt,cust_tgg,' + encodeURI($('#txtNoa').val()) ); 	
                Unlock(1);
            }
            function btnOk() {    
            	Lock(1,{opacity:0}); 
            	$('#txtNoa').val($.trim($('#txtNoa').val()));   	
            	/*if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
				}else{
					alert('編號只允許 英文(A-Z)、數字(0-9)及連字號(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
					Unlock(1);
					return;
				}*/
            	if ($('#txtSerial').val().length > 0 && checkId($('#txtSerial').val())!=2){
            		alert(q_getMsg('lblSerial')+'錯誤。');
            		Unlock(1);
            		return;
            	}
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!")
                }
                //------------------------------------
                if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('cust', t_where, 0, 0, 0, "checkCustno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
            }

            function wrServer(key_value) {
                var i;
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
                if (q_tables == 's')
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
                width: 250px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 700px;
                /*margin: -1px;        
                border: 1px black solid;*/
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewNoa"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewNick"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="nick" style="text-align: center;">~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSerial" class="lbl"> </a></td>
						<td><input id="txtSerial"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblTypea" class="lbl" > </a></td>
						<td><select id="cmbTypea"  class="txt c1" > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblComp" class="lbl"> </a></td>
						<td colspan="3"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNick" class="lbl"> </a></td>
						<td><input id="txtNick" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBoss" class="lbl"> </a></td>
						<td><input id="txtboss" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblHead" class="lbl"> </a></td>
						<td><input id="txthead" type="text" class="txt c1"/></td>
						<td><input id="btnDetail" type="button" style="display:none;"/></td>
						<td><input id="btnConn" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTel" class="lbl"> </a></td>
						<td colspan="2"><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblFax" class="lbl"> </a></td>
						<td colspan="2"><input id="txtFax" type="text" class="txt c1"/></td>
						
					</tr>
					<tr>
						<td><span> </span><a id="lblMobile" class="lbl"> </a></td>
						<td colspan="2"><input id="txtMobile" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblEmail" class="lbl"> </a></td>
						<td colspan="2"><input id="txtEmail" type="text" class="txt c1"/></td>
					</tr>
					<tr>						
						<td><span> </span><a id="lblSales" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" style="float:left; width:40%;"/>
							<input id="txtSales" type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_fact" class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_fact" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_fact"  type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_comp" class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_comp" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_comp"  type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_invo" class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_invo" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_invo"  type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_home" class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip_home" type="text" style="float:left; width:10%;"/>
							<input id="txtAddr_home"  type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id="lblUacc4" class="lbl"> </a></td>
						<td><input id="txtUacc4" type="text" class="txt c1"/></td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id="lblUacc1" class="lbl"> </a></td>
						<td><input id="txtUacc1"    type="text" class="txt c1"/></td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id="lblUacc2" class="lbl"> </a></td>
						<td><input id="txtUacc2" type="text" class="txt c1"/></td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id="lblUacc3" class="lbl"> </a></td>
						<td><input id="txtUacc3"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><textarea id="txtMemo" style="width:100%; height:100px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
