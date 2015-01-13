<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
            var q_name = "dmess";
            var q_readonly = ['txtDatea', 'txtTime', 'txtSender', 'txtOk', 'txtTeam','txtFilenamea'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 10;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array();
			
			var t_file = new Array();
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_content = "where=^^sender='" + r_userno + "'^^";
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
                q_getFormat();
                bbmMask = [];
                q_mask(bbmMask);
                $('#lblReceiver').click(function() {
                    q_box("sss_b2.aspx", 'sss', "510px", "", q_getMsg("lblReceiver"));
                });
				
                $('#btnModi').hide();
                $('#btnDele').hide();
                $('#btnSeek').hide();
                $('#btnPrint').hide();
                
				if(window.FileReader) {
				 
				} else {
					$('#btnFile').attr('disabled','disabled');
				   	alert( q_getPara("sys.filereader"));
				}	
                $('#btnFile').change(function(e){
					event.stopPropagation(); 
				    event.preventDefault();
					file = $('#btnFile')[0].files[0];
					if(file){
						fr = new FileReader();
						fr.fileName = file.name;
					    fr.readAsDataURL(file);
					    fr.onprogress = function(e){
					    	 if ( e.lengthComputable ) { 
		                        var per = Math.round( (e.loaded * 100) / e.total) ; 
		                        $('#FileList').children().last().find('progress').eq(0).attr('value',per);
		                    }; 
					    }
					    fr.onloadstart = function(e){
					    	$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
					    	$('#btnFile').attr('disabled','disabled');
					    }
					    fr.onloadend = function(e){
					    	$('#FileList').children().last().find('progress').eq(0).attr('value',100);
					    	
							console.log(fr.fileName+':'+fr.result.length);
					    	var oReq = new XMLHttpRequest();
					    	
					    	oReq.upload.addEventListener("progress",function(e) {
						    	if (e.lengthComputable) {
							    	percentComplete = Math.round((e.loaded / e.total) * 100,0);
							     	$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
							    }
							}, false);
					    	oReq.upload.addEventListener("load",function(e) {
							    $('#btnFile').val('');
							    $('#btnFile').removeAttr('disabled');
							    t_file.push(fr.fileName);
							}, false);

							oReq.open("POST", 'dmess_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
						    oReq.timeout = 60000;
						    oReq.ontimeout = function () { alert("Timed out!!!"); }
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);
					    };
					}
				});
            }
            
            function uploadInit(){
            	t_file = new Array();
            	$('#FileList').html('');
            }
			function q_stPost(){
				uploadInit();
			}
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'sss':
                        ret = getb_ret();
                        if (q_cur > 0 && q_cur < 4) {
                            if (ret[0] != undefined) {
                                for (var i = 0; i < ret.length; i++) {
                                    if ($('#txtReceiver').val().length > 0) {
                                        var temp = $('#txtReceiver').val();
                                        $('#txtReceiver').val(temp + ',' + ret[i].namea);
                                    } else {
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
                $('#txtTime').val(t_time.getHours() + ':' + ('00' + t_time.getMinutes()).slice(-2));
                $('#txtSender').val(r_userno);
                $('#txtMessage').focus();
                uploadInit();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtMessage').focus();
                uploadInit();
            }

            function btnPrint() {

            }

            function btnOk() {
            	$('#txtFilenamea').val(t_file.toString());
                q_gtnoa(q_name, replaceAll(r_userno + q_date(), '/', ''));
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
				if (t_para) {
					if(window.FileReader) {
					   $('#btnFile').attr('disabled','disabled');
					} else {
					   //the browser doesn't support the FileReader Object, so do this
					}
                    
                } else {
                	if(window.FileReader) {
					  $('#btnFile').removeAttr('disabled');
					} else {
					   //the browser doesn't support the FileReader Object, so do this
					}	
                }
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
                uploadInit();
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                /*float: left;*/
                width: 800px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                /*float: left;*/
                width: 800px;
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
                width: 15%;
            }
            .tbbm .tdZ {
                width: 1%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1360px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 1700px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:2%"><a id='vewChk'></a></td>
						<td style="width:10%"><a id='vewDatea'></a></td>
						<td style="width:20%"><a id='vewReceiver'></a></td>
						<td class="style1"><a id='vewMessage'></a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea'>~datea</td>
						<td id='receiver'>~receiver</td>
						<td id='message,25' class="style1">~message,25</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td>
						<input id="txtNoa" style="display:none;"/>
						<input id="txtSender" style="display:none;"/>
						<input id="txtDatea"  type="text" class="txt" style="width:50%;"/>
						<input id="txtTime"  type="text" class="txt" style="width:50%;"/>
						</td>
						<td><span> </span><a id='lblSdate' class="lbl"></a></td>
						<td>
						<input id="txtSdate"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblDays' class="lbl"></a></td>
						<td>
						<input id="txtDays"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr >
						<td><span> </span><a id='lblReceiver' class="lbl btn"></a></td>
						<td colspan="5">
						<input id="txtReceiver"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMessage' class="lbl"></a></td>
						<td colspan="5">						<textarea id="txtMessage" cols="10" rows="5" style="width: 100%; height: 50px;"></textarea></td>
					</tr>
					<tr >
						<td><span> </span><a id='lblFilenamea' class="lbl">檔案</a></td>
						<td colspan="5"><input id="txtFilenamea"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="5"><input type="file" id="btnFile" value="上傳"/></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="5" id="FileList"> </td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />

	</body>
</html>

