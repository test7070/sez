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

            var q_name = "dmess";
            var q_readonly = ['txtDatea','txtTime','txtSender','txtOk','txtTeam'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array();

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                
                q_content = "where=^^sender='" + r_userno + "'^^";

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
            	q_getFormat();
                bbmMask = [];
                q_mask(bbmMask);
                $('#lblReceiver').click(function () {
	            	q_box("sss_b2.aspx", 'sss', "510px", "", q_getMsg("lblReceiver"));
	        	});
	        	
	        	$('#btnModi').hide();
	        	$('#btnDele').hide();
	        	$('#btnSeek').hide();
	        	$('#btnPrint').hide();
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'sss':
                        ret = getb_ret();
                        if(q_cur > 0 && q_cur < 4){
	                        if(ret[0]!=undefined){
	                        	for (var i = 0; i < ret.length; i++) {
	                        		if($('#txtReceiver').val().length>0){
		                            	var temp=$('#txtReceiver').val();
		                            	$('#txtReceiver').val(temp+','+ret[i].namea);
		                            }else{
		                            	$('#txtReceiver').val(ret[i].namea);
		                            } 
	                        	}
	                        }
						}
                        break;
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
                q_box('dmess_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtDatea').val(q_date());
                var t_time = new Date();
                $('#txtTime').val(t_time.getHours()+':'+('00'+t_time.getMinutes()).substr(-2));
                $('#txtSender').val(r_userno);
                $('#txtMessage').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtMessage').focus();
            }

            function btnPrint() {

            }

            function btnOk() {
            	
                q_gtnoa(q_name, replaceAll(r_userno+q_date(), '/', ''));
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
                width: 100%;
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
                width: 99%;
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
		</style>
	</head>
	<body>
		<form id="form1" style="height: 100%;" action="">
			<!--#include file="../inc/toolbar.inc"-->
			<div id='dmain' style="overflow:hidden;">
				<div class="dview" id="dview">
					<table class="tview" id="tview">
						<tr>
							<td style="width:5%"><a id='vewChk'></a></td>
							<td style="width:25%"><a id='vewDatea'></a></td>
							<td style="width:40%"><a id='vewReceiver'></a></td>
						</tr>
						<tr>
							<td>
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td id='datea'>~datea</td>
							<td id='receiver'>~receiver</td>
						</tr>
					</table>
				</div>
				<div class='dbbm'>
					<table class="tbbm"  id="tbbm">
						<tr class="tr1">
							<td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
							<td class="td2">
								<input id="txtNoa"  type="hidden"/><input id="txtSender"  type="hidden" class="txt c1"/>
								<input id="txtDatea"  type="text" class="txt c1"/>
							</td>
							<td class="td3"><span> </span><a id='lblTime' class="lbl"></a></td>
							<td class="td4"><input id="txtTime"  type="text" class="txt c1"/></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
						<tr class="tr2">
							<td class="td1"><span> </span><a id='lblReceiver' class="lbl btn"></a></td>
							<td class="td2" colspan="5">
							<input id="txtReceiver"  type="text" class="txt c1"/>
							</td>
						</tr>
						<tr class="tr3">
							<td class="td1"><span> </span><a id='lblMessage' class="lbl"></a></td>
							<td class="td2" colspan="5">
								<textarea id="txtMessage" cols="10" rows="5" style="width: 99%; height: 50px;"></textarea>
							</td>
						</tr>
						<tr class="tr4">
							<td class="td1"><span> </span><a id='lblOk' class="lbl"></a></td>
							<td class="td2"><input id="txtOk"  type="text" class="txt c1"/></td>
							<td class="td3"><span> </span><a id='lblTeam' class="lbl"></a></td>
							<td class="td4"><input id="txtTeam"  type="text" class="txt c1"/></td>
						</tr>
					</table>
				</div>
			</div>
			<input id="q_sys" type="hidden" />
		</form>
	</body>
</html>
