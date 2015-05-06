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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 's';
			var q_name = "tboat";
			var q_readonly = ['txtNoa','txtCust','txtDatea','txtInvodate'];
			var q_readonlys = [];
			var bbmNum = [['txtMount',10,0,1]];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_alias = '';
			q_desc = 1;
			brwCount2 = 15;
			aPop = new Array(
				['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick,boss', 'txtCustno,txtCust,txtNick,txtWorker', 'cust_b.aspx']
			);

			$(document).ready(function() {
				var t_where = '';
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				
				 if (r_outs==1)
					q_content = "where=^^invono='2' and custno='" + r_userno + "'^^";
				else
					q_content = " invono='2' ";
				
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}

				mainForm(0);
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					/*case 'qtxt.query.tboat1':
		        		alert('派遣成功!!!');
		           	break;*/
				}
			}

			function mainPost() {
				q_mask(bbmMask);
				document.title='5.2 派遣功能_CS'
				$("#lblCustno").text('客戶編號').hide();
				$('#lblCust').text('客戶編號').hide();
				$("#lblMount").text('件數');
				$("#lblDatea").text('登錄日期');
				
				//$("#btnModi").hide();
				//$("#btnDele").hide();
				$("#btnPrint").hide();
				if(r_outs==0){
					$("#lblCustno").show()
					$("#btnPrint").show();
				}else{
					q_readonly.push('txtCustno');
					$("#lblCust").show()
				}
			}
			
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
                    }
				}
				_bbsAssign();
			}
			function bbsSave(as) {
				if (!as['caseno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			
			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						s2[1]=replaceAll(replaceAll(s2[1],'where=^^',''),'^^','');
						s2[1]="where=^^ "+s2[1]+" and invono='2' ^^"
						
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'cust':
						var as = _q_appendData("cust", "", true);
                		if (as[0] != undefined) {
                			$('#txtCustno').val(as[0].noa);
                			$('#txtCust').val(as[0].comp);
                			$('#txtNick').val(as[0].nick);
                			$('#txtWorker').val(as[0].boss);
                		}else{
                			alert('客戶資料載入錯誤!!');
                			$('#btnCancel').val();
                		}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				if (r_outs==1)
					q_box('tboat_bv_s.aspx', q_name + '_s', "500px", "250px", q_getMsg("popSeek"));
				else
					q_box('tboat_bv_s.aspx', q_name + '_s', "500px", "320px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				var timeDate= new Date();
				var tHours = timeDate.getHours();
				var tMinutes = timeDate.getMinutes();
				$('#txtInvodate').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
				$('#txtWorker').focus();
				
				if(r_outs==1){
					var t_where = "where=^^ noa='"+r_userno+"' ^^";
					q_gt('cust', t_where, 0, 0, 0, "");
				}
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box('z_tboat_bv.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				var t_err = '';
				t_err = q_chkEmpField([['txtCustno', q_getMsg('lblCustno')], ['txtWorker', '聯絡人'], ['txtMount', q_getMsg('lblMount')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				//判斷重哪個作業寫入
				if(q_cur==1)
					$('#txtInvono').val('2');
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tboat') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				/*if(q_cur==1)
					q_func('qtxt.query.tboat1', 'tboat.txt,tboat1,' + encodeURI($('#txtNoa').val()));*/
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

			function q_popPost(id) {
				switch(id){
				}
			}

		</script>
		<style type="text/css">
			#dmain {
				width:1250px;
				overflow: auto;
			}
			.dview {
				float: left;
				width: 580px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
				width: 100%;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFEA00;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 650px;
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
				/*width: 12%;*/
			}
			.tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
				background-color: #FFEC8B;
			}
			.tbbm .tdZ {
				/*width: 1%;*/
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
			.tbbm .trX {
				background-color: #FFEC8B;
			}
			.tbbm .trY {
				background-color: pink;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 40%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
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
			.dbbs {
				width: 950px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}
			.font1 {
				font-family: "細明體", Arial, sans-serif;
			}
			#tableTranordet tr td input[type="text"]{
				width:80px;
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
		</style>
	</head>
	<body 
	ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'></a></td>
						<td align="center" style="width:85px; color:black;"><a>登錄日期</a></td>
						<td align="center" style="width:85px; color:black;"><a>時間</a></td>
						<td align="center" style="width:120px; color:black;"><a>單據編號</a></td>
						<td align="center" style="width:120px; color:black;"><a>聯絡人</a></td>
						<td align="center" style="width:100px; color:black;"><a>件數</a></td>
						<td align="center" style="width:100px; color:black;"><a>CS</a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='invodate' style="text-align: center;">~invodate</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='worker' style="text-align: center;">~worker</td>
						<td id='mount' style="text-align: right;">~mount</td>
						<td id='taxtype' style="text-align: center;">~taxtype</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td style="width:130px; "> </td>
						<td style="width:170px; "> </td>
						<td style="width:130px; "> </td>
						<td style="width:170px; "> </td>
						<td style="width:10px; "> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">單據編號</a></td>
						<td><input type="text" id="txtNoa" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
							<input type="text" id="txtDatea" class="txt c1" style="width: 49%;"/>
							<input type="text" id="txtInvodate" class="txt c1" style="width: 49%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span>
							<a id="lblCustno" class="lbl btn"> </a>
							<a id="lblCust" class="lbl"> </a>
						</td>
						<td><input type="text" id="txtCustno" class="txt c1"/></td>
						<td colspan="2">
							<input type="text" id="txtCust" class="txt c1"/>
							<input type="hidden" id="txtNick" class="txt c1"/>
						</td>
					</tr>
					<tr class="trans" style="display: none;">
						<td><span> </span><a class="lbl">統一編號</a></td>
						<td><input type="text" id="txtSerial" class="txt c1 "/></td>
						<td><span> </span><a id="lblTel" class="lbl">電話</a></td>
						<td><input type="text" id="txtTel" class="txt c1"/></td>
					</tr>
					<tr class="trans" style="display: none;">
						<td><span> </span><a id="lblAddr" class="lbl">地址</a></td>
						<td colspan="3"><input type="text" id="txtAddr" class="txt c1 "/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">聯絡人</a></td>
						<td><input type="text" id="txtWorker" class="txt c1 "/></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input type="text" id="txtMount" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">CS</a></td>
						<td><input type="text" id="txtTaxtype" class="txt c1 "/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input type="text" id="txtMemo" class="txt c1"></td>
					</tr>
					<tr class="trans" style="display: none;">
						<td><span> </span><a id="lblRdate" class="lbl">讀取時間</a></td>
						<td>
							<input type="text" id="txtRdate" class="txt c1" style="width: 49%;"/>
							<input type="text" id="txtRtime" class="txt c1" style="width: 49%;"/>
							<input type="hidden" id="txtInvono"/>
						</td>
					</tr>
					<tr class="trans" style="display: none;">
						<td><span> </span><a class="lbl">發送局</a></td>
						<td><input type="text" id="txtTypea" class="txt c1 "/></td>
						<td><span> </span><a class="lbl">宅配員</a></td>
						<td><input type="text" id="txtWorker2" class="txt c1 "/></td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
