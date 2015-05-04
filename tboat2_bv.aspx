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
			var q_name = "tboat2";
			var q_readonly = ['txtDatea','txtWorker','txtWorker2','txtCustno','txtCust','txtIsPrint'];
			var q_readonlys = [];
			var bbmNum = new Array(['txtMount',10,0,1]);
			var bbmMask = new Array(['txtDatea', '999/99/99']);
			var bbsNum = [];
			var bbsMask = new Array();
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_alias = '';
			q_desc = 1;
			brwCount2 = 15;
			aPop = new Array(
				['txtPost', 'lblPost', 'addr2', 'noa,memo,siteno,site', 'txtPost,txtBoatname,txtMemo', 'addr2_b.aspx']
			);

			$(document).ready(function() {
				var t_where = '';
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
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
					case 'qtxt.query.tboat2':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if(as[0]=='success')
		        				alert('轉口資料更新完成!!');
		        			else
		        				alert('轉口資料更新失敗!!');
		        		}else{
		        			alert('資料更新執行錯誤!!');
		        		}
		        	break;
				}
			}

			function mainPost() {
				q_mask(bbmMask);
				document.title='3.3轉聯運作業'
				$("#lblCustno").text('客戶編號');
				$("#lblDatea").text('登錄日期');
				
				$('#txtCode').change(function() {
					var t_where = "where=^^ boatname='"+$(this).val()+"' ^^";
					q_gt('view_transef', t_where, 0, 0, 0, "");
				});
				
				$('#txtPost').change(function() {
					var t_where = "where=^^ noa='"+$(this).val()+"' ^^";
					q_gt('addr2', t_where, 0, 0, 0, "");
				});
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
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'transef96':
                		var as = _q_appendData("view_transef", "", true);
                		if (as[0] != undefined)
                			$('#txtShip').val('96'+('0000000'+(dec(as[0].po.substr(2,7))+1)).substr(-7)+((dec(as[0].po.substr(2,7))+1)%7))
                		else
                			$('#txtShip').val('9600000011');
                		btnOk();
                		break;   
					case 'view_transef':
						var as = _q_appendData("view_transef", "", true);
                		if (as[0] != undefined) {
                			$('#txtCustno').val(as[0].custno);
                			$('#txtCust').val(as[0].comp);
                			$('#txtNick').val(as[0].nick);
                			$('#txtShip').val(as[0].po);
                			if(as[0].custno!=''){
                				var t_where = "where=^^ noa='"+as[0].custno+"' ^^";
								q_gt('cust', t_where, 0, 0, 0, "");
							}
                		}else{
                			alert('客戶資料載入錯誤!!');
                		}
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
                		if (as[0] != undefined) {
                			$('#txtNamea').val(as[0].boss);
                			$('#txtTel').val(as[0].tel);
                			$('#txtPost').val(as[0].zip_comp);
                			$('#txtBoatname').val(as[0].addr_comp);
                			$('#txtMemo').val(as[0].zip_fact);
						}
						break;
					case 'addr2':
						var as = _q_appendData("addr2", "", true);
                		if (as[0] != undefined) {
                			$('#txtMemo').val(as[0].siteno);
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
				q_box('tboat2_bv_s.aspx', q_name + '_s', "500px", "250px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtCode').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box("z_tboat2_bv.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({bnoa:trim($('#txtShip').val()),enoa:trim($('#txtShip').val())}) + ";" + r_accy + "_" + r_cno, 'tboat2', "95%", "95%", m_print);
			}

			function btnOk() {
				Lock();
				var t_err = '';
				t_err = q_chkEmpField([['txtCode', '97編碼']]);
				if (t_err.length > 0) {
					alert(t_err);
					Unlock();
					return;
				}
				
				if(emp($('#txtMemo').val()) && emp($('#txtShip').val())){
					//產生96條碼
			        var t_where = "where=^^ po=(select Max(po) from view_transef) ^^";
					q_gt('view_transef', t_where, 0, 0, 0, "transef96");
					return;
				}
				
				if(q_cur ==1){
					$('#txtWorker').val(r_name);
				}else if(q_cur ==2){
					$('#txtWorker2').val(r_name);
				}else{
					alert("error: btnok!");
				}
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tboat2') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
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
				q_func('qtxt.query.tboat2', 'tboat.txt,tboat2,' + encodeURI($('#txtCode').val()));
				Unlock();
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
		</script>
		<style type="text/css">
			#dmain {
				width:1250px;
				overflow: auto;
			}
			.dview {
				float: left;
				width: 320px;
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
				background-color: #FFEA00;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 850px;
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
				width: 12%;
			}
			.tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
				background-color: #FFEC8B;
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
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a>登錄日期</a></td>
						<td align="center" style="width:120px; color:black;"><a>聯運件數</a></td>
						<td align="center" style="width:120px; color:black;"><a>操作者</a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='mount,0,1' style="text-align: right;">~mount,0,1</td>
						<td id='worker' style="text-align: center;">~worker</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">97條碼</a></td>
						<td><input type="text" id="txtCode" class="txt c1"/>
							<input type="text" id="txtNoa" class="txt c1" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
					</tr>
					<tr>
						<td> <span> </span><a id='lblCustno' class="lbl"> </a></td>
						<td><input type="text" id="txtCustno" class="txt c1" /> </td>
						<td colspan="3">
							<input type="text" id="txtCust" class="txt c1"/>
							<input type="hidden" id="txtNick" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">姓名</a></td>
						<td><input type="text" id="txtNamea" class="txt c1 "/></td>
						<td><span> </span><a class="lbl">電話</a></td>
						<td colspan="2"><input type="text" id="txtTel" class="txt c1 "/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPost' class="lbl">郵遞區號</a></td>
						<td><input type="text" id="txtPost" class="txt c1 "/></td>
						<td><span> </span><a class="lbl">地址</a></td>
						<td colspan="2"><input type="text" id="txtBoatname" class="txt c1 "/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">聯運件數</a></td>
						<td><input type="text"id="txtMount" class="txt num c1"> </td>
						<td><span> </span><a class="lbl">到著站</a></td>
						<td><input type="text"id="txtMemo" class="txt c1"> </td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">96編碼</a></td>
						<td><input type="text" id="txtShip" class="txt c1"/> </td>
						<td><span> </span><a class="lbl">條碼</a></td>
						<td><input type="text" id="txtIsPrint" class="txt c1"/> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input type="text" id="txtWorker" class="txt c1 "/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input type="text" id="txtWorker2" class="txt c1 "/></td>
					</tr>
				</table>
		</div>
	</body>
</html>
