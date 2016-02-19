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

            var q_name = "quser";
            var q_readonly = ['txtAuthno'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
			
			aPop = new Array(['txtSno', '', 'nhpe', 'noa,namea', '0txtSno,txtNamea', 'nhpe_b.aspx']);
			brwCount2 = 35;
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
                $('#txtNoa').focus();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }

            function mainPost() {
            	q_getFormat();
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd], ['txtBtime', '99:99'],['txtEtime', '99:99']];
                q_mask(bbmMask);
				
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
						break;
                }
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
                q_box(q_name+'_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('.chkday').prop('checked',true);
                $('#txtBtime').val('00:00');
                $('#txtEtime').val('23:59');
                refreshBbm();
                $('#txtNoa').focus();
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

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
            	if((emp($('#txtSno').val()) && emp($('#txtIp').val())) || (!emp($('#txtSno').val()) && !emp($('#txtIp').val())) ){
            		alert(q_getMsg('lblSno')+'或'+q_getMsg('lblIp')+'請擇一填選!!');
            		return;
            	}
            	//判斷帳號是否重覆
            	if(!emp($('#txtSno').val()) && q_cur==1){
            		var t_where = "where=^^ sno='" + $('#txtSno').val() + "' and isnull(sno,'')!='' ^^";
					q_gt(q_name, t_where, 0, 0, 0, "repsno", r_accy, 1);
					var as = _q_appendData(q_name, "", true);
					if (as[0] != undefined) {
						alert(q_getMsg('lblSno')+'禁止重複!!');
						return;
					}
            	}
            	
            	var isdate=false;
            	var isday=false;
            	if(!emp($('#txtBdate').val())  || !emp($('#txtEdate').val())){
            		if(emp($('#txtBdate').val())){
            			alert('請填選起始日!!');
            		}
            		if(emp($('#txtEdate').val())){
            			alert('請填選迄止日!!');
            		}
            		
            		isdate=true;
            	}
            	if( $('#chkD1').prop('checked') || $('#chkD2').prop('checked') || $('#chkD3').prop('checked') || $('#chkD4').prop('checked')
            	|| $('#chkD5').prop('checked') || $('#chkD6').prop('checked') || $('#chkD7').prop('checked')){
            		isday=true;
            	}
            	if((!isdate && !isday)){
            		alert(q_getMsg('lblBdate')+'或'+q_getMsg('lblDays')+'請填選!!');
            		return;
            	}
            	
            	if(emp($('#txtBtime').val()) || emp($('#txtEtime').val())){
            		alert('請填選'+q_getMsg('lblBtime')+'!!');
            		return;
            	}else if(emp($('#txtBtime').val())){
            		alert('請填選起始時間!!');
            		return;
            	}else if(emp($('#txtEtime').val())){
            		alert('請填選迄止時間!!');
            		return;
            	}else if ($('#txtBtime').val()>'24:00' || $('#txtEtime').val()>'24:00' || $('#txtBtime').val().substr(3,2)>'59' ||$('#txtEtime').val().substr(3,2)>'59' ){
            		alert('請輸入正確的時間!!');
            		return;
            	}
            	
            	if (q_cur==1){
            		var datetime=replaceAll(q_date(),'/','')+padL(new Date().getHours(), '0', 2)+padL(new Date().getMinutes(),'0',2)+padL(new Date().getSeconds(),'0',2);
                	$('#txtNoa').val($.trim($('#txtSno').val()+replaceAll($('#txtIp').val(),'.','')+datetime));
               }
                
                if($('#txtNoa').val().length>0)
                	wrServer($('#txtNoa').val());
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
            }

            function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtSno').css('color', 'black').css('background', 'white').removeAttr('readonly');
                    $('#txtIp').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtSno').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                    $('#txtIp').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
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
                width: 45%;
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
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:35%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewSno'> </a></td>
						<td align="center" style="width:30%"><a id='vewNamea'> </a></td>
						<td align="center" style="width:30%"><a id='vewIp'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='sno'>~sno</td>
						<td align="center" id='namea'>~namea</td>
						<td align="center" id='ip'>~ip</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 63%;float: left;width: 600px;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5' >
					<tr>
						<td class="td1"><span> </span><a id='lblSno' class="lbl"> </a></td>
						<td class="td2"><input id="txtSno"  type="text" class="txt c1" /></td>
						<td class="td3"><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td class="td4"><input id="txtNamea"  type="text" class="txt c1"/></td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblIp' class="lbl"> </a></td>
						<td class="td2"><input id="txtIp"  type="text" class="txt c1"/></td>
						<td class="td3"> </td>
						<td class="td4"><input id="txtNoa"  type="hidden" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDays' class="lbl"> </a></td>
						<td class="td2" colspan="3">
							<input id="chkD1"  type="checkbox" class="chkday" /><a>一</a>
							<input id="chkD2"  type="checkbox" class="chkday" /><a>二</a>
							<input id="chkD3"  type="checkbox" class="chkday" /><a>三</a>
							<input id="chkD4"  type="checkbox" class="chkday" /><a>四</a>
							<input id="chkD5"  type="checkbox" class="chkday" /><a>五</a>
							<input id="chkD6"  type="checkbox" class="chkday" /><a>六</a>
							<input id="chkD7"  type="checkbox" class="chkday" /><a>日</a>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtBdate"  type="text" class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtEdate"  type="text" class="txt c2"/>
						</td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblBtime' class="lbl"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtBtime"  type="text" class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtEtime"  type="text" class="txt c2"/>
						</td>
						<td class="td4"> </td>
					</tr>
					<tr style="display: none;">
						<td class="td1"><span> </span><a id='lblAuthno' class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtAuthno"  type="text" class="txt c1"/></td>
						<td class="td4"> </td>
					</tr>
					<tr>
						<td class="td2" colspan="5" style="color: red;">
							　　注意事項　1.必填：IP 或 帳號擇一控管<BR>
							　　　　　　　2.必填：起迄日或工作日(週一~日)，可同時輸入<BR>
							　　　　　　　3.必填：登入時間<BR>
						</td>
					</tr>
					<tr style="height: 5px;">
						<td class="td1"> </td>
						<td class="td2"> </td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
