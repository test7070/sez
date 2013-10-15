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
			q_desc=1;
            var q_name = "custsss";
            var q_readonly = ['txtNoa', 'txtNamea','txtDatea', 'txtWorker', 'txtWorker2', 'txtBcomp', 'txtEcomp'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(
            	['txtSssno', 'lblSssno', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']
            	, ['txtBcustno', '', 'cust', 'noa,comp', 'txtBcustno,txtBcomp', 'cust_b.aspx']
            	, ['txtEcustno', '', 'cust', 'noa,comp', 'txtEcustno,txtEcomp', 'cust_b.aspx']
            );
            brwCount2 = 8;

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                
                $('#btnChange').click(function() {
                	var r=confirm("你確定要執行嗎?");
                	if (r==true){
                		alert("確定執行");
	                	if(!emp($('#txtNoa').val())&&!emp($('#txtSssno').val()))
							q_func('custsss.change', $('#txtSssno').val()+','+$('#txtBcustno').val()+','+$('#txtEcustno').val())
							q_func('qtxt.query','custsss.txt,custsss,'+encodeURI($('#txtSssno').val()) + ';' + encodeURI($('#txtBcustno').val()) + ';' + encodeURI($('#txtEcustno').val()));
					}else{
						alert("取消執行");
					}
				});
                
            }
            
            function q_funcPost(t_func, result) {	//後端傳回
				alert('業務更新完畢');
		    }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {/// 重要：不可以直接 return ，最後需執行 originalClose();
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)// 查詢
                            q_Seek_gtPost();
                        break;
                }
            }
						
            function btnOk() {
                $('#txtWorker').val(r_name);
                
                var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_custsss')+(t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('custsss_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }


            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtSssno').focus();
            }

            function btnModi() {
                 if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
            }

            function refresh(recno) {
                _refresh(recno);                
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if ((q_cur == 1 || q_cur == 2)) {
					$('#btnChange').attr('disabled', 'disabled');
		        }
		        else {
		        	$('#btnChange').removeAttr('disabled');
		        }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
            	visibility:hidden;
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
            	visibility:hidden;
                width: 950px;
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
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:130px; color:black;"><a id='vewSss'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='namea'>~namea</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td colspan="2"><input id="txtDatea"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSssno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSssno"  type="text" style="float:left; width:40%;"/>
							<input id="txtNamea"  type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr id="hiddenCust">
						<td><span> </span><a id='lblCustno' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtBcustno"  type="text" style="float:left; width:18%;"/>
							<input id="txtBcomp"  type="text" style="float:left; width:30%;"/>
							<a style="float: left;">~</a>
							<input id="txtEcustno"  type="text" style="float:left; width:18%;"/>
							<input id="txtEcomp"  type="text" style="float:left; width:30%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
						<td><input id="btnChange" type="button" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
