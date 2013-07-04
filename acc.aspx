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

            var decbbm = [];
            var q_name = "acc";
            var q_readonly = [];
            var bbmNum = new Array(['txtBeginmoney', 10, 0]);
            var bbmMask = [];

            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'acc1';

            $(document).ready(function() {
                bbmKey = ['acc1'];
                brwCount2 = 20
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy + '_' + r_cno)
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
                //bbmMask = [['txtAcc1', '9999.********']];
                q_mask(bbmMask);

                $('#txtAcc1').keyup(function() {
                	if((/^(\d{4})$/g).test($(this).val())){
                		$(this).val($(this).val().replace(/^(\d{4})$/g,"$1."));
                	}else if((/^(\d{4})(\.+)([^\.,.]*)$/g).test($(this).val())){
                		$(this).val($(this).val().replace(/^(\d{4})(\.+)([^\.,.]*)$/g,"$1.$3"));
                	}else{
                		$(this).val($(this).val().replace(/^(\d{4})([^\.,.]*)$/g,"$1.$2"));
                	}
                }).change(function(){
                	if((/^(\d{4})$/g).test($(this).val())){
                		$(this).val($(this).val().replace(/^(\d{4})$/g,"$1."));
                	}else if((/^(\d{4})(\.+)([^\.,.]*)$/g).test($(this).val())){
                		$(this).val($(this).val().replace(/^(\d{4})(\.+)([^\.,.]*)$/g,"$1.$3"));
                	}else{
                		$(this).val($(this).val().replace(/^(\d{4})([^\.,.]*)$/g,"$1.$2"));
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

            var accdb = true;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        if (q_cur == 1 || q_cur == 2) {
                            if (accdb) {
                                acc1 = _q_appendData(t_name, "", true);
                                if (acc1[0] != undefined) {
                                    alert("科目編號重複");
                                    $('#txtAcc1').focus();
                                } else {
                                    var t_where = "where=^^ acc1='" + $('#txtAcc1').val().substr(0, 5) + "' ^^";
                                    q_gt(q_name, t_where, 0, 1, 0, "", r_accy + '_' + r_cno);
                                    accdb = false;
                                }
                            } else {
                                var as = _q_appendData(t_name, "", true);
                                if (as[0] != undefined) {
                                    $('#txtAcc2').val(as[0].acc2);
                                    $('#txtBeginmoney').val(as[0].beginmoney);
                                    $('#txtOacc').val(as[0].oacc);
                                    $('#txtLok').val(as[0].lok);
                                }
                                accdb = true;
                            }

                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);
                        }
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('acc_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtAcc1').focus();
            }

            function btnModi() {
                if (emp($('#txtAcc1').val()))
                    return;
                _btnModi();
                $('#txtAcc2').focus();
            }

            function btnPrint() {

            }

            var acc1 = [];
            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField(['txtAcc1', q_getMsg('lblAcc1')]);

                if (acc1[0] != undefined) {
                    alert("科目編號重複");
                    return;
                }

                var t_acc1 = trim($('#txtAcc1').val());

                if (t_acc1.length == 0)
                    q_gtacc1(q_name, t_acc1);
                else
                    wrServer(t_acc1);
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
                if(q_cur==1){
                	$('#txtAcc1').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');           
                }else{
                	$('#txtAcc1').removeAttr('readonly').css('color','black').css('background','white');  
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 500px;
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
                width: 450px;
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
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'></a></td>
						<td align="center" style="width:180px; color:black;"><a id='vewAcc1'></a></td>
						<td align="center" style="width:300px; color:black;"><a id='vewAcc2'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='acc1' style="text-align: center;">~acc1</td>
						<td id='acc2' style="text-align: left;">~acc2</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcc1" class="lbl"> </a></td>
						<td>
						<input id="txtAcc1" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcc2" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtAcc2" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBeginmoney" class="lbl"> </a></td>
						<td>
						<input id="txtBeginmoney" type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOacc" class="lbl"> </a></td>
						<td>
						<input id="txtOacc" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblLok" class="lbl"> </a></td>
						<td>
						<input id="txtLok" type="text" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
