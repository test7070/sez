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

			var q_name = "trans";
			var q_readonly = ['txtMiles','txtNoa'];
			var bbmNum = [['txtMount',10,3,1]];
			var bbmMask = [['txtDatea','999/99/99'],['txtTrandate','999/99/99'],['txtMon','999/99'],['txtMon2','999/99'],['txtLtime','99:99'],['txtAdd3','99:99'],['txtAdd4','99:99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
            //q_xchg = 1;
            brwCount2 = 10;
            //不能彈出瀏覽視窗
            aPop = new Array(['txtTrdno', 'lblSerial', 'cust', 'serial,noa,comp,nick,boss,tel,addr_comp,addr_fact,sales', 'txtTrdno,txtCustno,txtComp,txtNick,txtShip,txtPo,txtStraddr,txtOrdeno,txtBoat', 'cust_b.aspx']);
            	
			$(document).ready(function() {
				bbmKey = ['noa'];
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

			function mainPost() {
				$("#lblDatea").text('資料時間');
				$("#lblTrandate").text('讀取時間');
				$("#lblNoa").text('單據編號');
				$("#lblSerial").text('統一編碼');
				$("#lblCust").text('公司名稱');
				$("#lblStraddr").text('地址');
				$("#lblMount").text('件數');
				$("#lblPo").text('電話');
				$("#lblOrdeno").text('發送局');
				$("#lblShip").text('聯絡人');
				$("#lblBoat").text('宅配員');
				
				document.title='派遣作業';

				q_mask(bbmMask);
			}

			function sum() {
				if(q_cur!=1 && q_cur!=2)
					return;
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
				}
			}
			function q_popPost(id) {
				switch(id) {
					
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('trans_bv_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtDatea').val(q_date());
				var timeDate= new Date();
				var tHours = timeDate.getHours();
				var tMinutes = timeDate.getMinutes();
	            $('#txtAdd3').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
				$('#txtNoa').val('AUTO');
				$('#txtNoq').val('001');
				$('#txtDatea').focus();
			}
			
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNamea').focus();
			}
			
			function btnPrint() {
				q_box('z_trans_bv.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}
			
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            
			function btnOk() {
				Lock(1,{opacity:0});
				//日期檢查
				if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if ($('#txtTrdno').val().length > 0 && checkId($('#txtTrdno').val())!=2){
         			alert(q_getMsg('lblSerial')+'錯誤。');
         			Unlock();
         			return;
				}

        		sum();
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (q_cur ==1)
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);		
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				var now_page=Math.floor((dec($('#pageNow').val())/brwCount));
				for (var i = 0; i < brwCount; i++) {
                	$('#vtkey_'+i).text((now_page*brwCount)+i+1);
                }
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#txtDatea').datepicker( 'destroy' );
					
				} else {
					$('#txtDatea').removeClass('hasDatepicker')
					$('#txtDatea').datepicker();
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
				if(!emp($('#txtCardno').val())){
					alert('由客戶派遣單轉來禁止刪除。');
				}
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
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
                width: 100%; 
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
                width: 950px;
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
						<td align="center" style="width:50px; color:black;"><a> 序號 </a></td>
						<td align="center" style="width:70px; color:black;"><a> 資料時間 </a></td>
						<td align="center" style="width:80px; color:black;"><a> 統一編號 </a></td>
						<td align="center" style="width:110px; color:black;"><a> 單據編號 </a></td>
						<td align="center" style="width:80px; color:black;"><a> 公司名稱 </a></td>
						<td align="center" style="width:80px; color:black;"><a> 聯絡人 </a></td>
						<td align="center" style="width:80px; color:black;"><a> 電話 </a></td>
						<td align="center" style="width:180px; color:black;"><a> 地址 </a></td>
						<td align="center" style="width:70px; color:black;"><a> 讀取時間 </a></td>
						<td align="center" style="width:120px; color:black;"><a> 發送局 </a></td>
						<td align="center" style="width:80px; color:black;"><a> 宅配員 </a></td>
						<td align="center" style="width:60px; color:black;"><a> 件數</a></td>
						<td align="center" style="width:120px; color:black;"><a> 備註 </a></td>
						
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="key" style="text-align: center;"></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="trdno" style="text-align: center;">~trdno</td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="ship" style="text-align: center;">~ship</td>
						<td id="po" style="text-align: center;">~po</td>
						<td id="straddr" style="text-align: center;">~straddr</td>
						<td id="trandate" style="text-align: center;">~trandate</td>
						<td id="ordeno" style="text-align: center;">~ordeno</td>
						<td id="boat" style="text-align: center;">~boat</td>
						<td id="mount" style="text-align: right;">~mount</td>
						<td id="memo" style="text-align: center;">~memo</td>
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
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtDatea"  type="text" class="txt c1" style="float:left;width:40%;"/>
						    <input id="txtAdd3"   type="text" class="txt c1" style="float:left;width:40%;"/>
						</td>
						<td> </td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblSerial' class="lbl btn"> </a></td>
						<td><input id="txtTrdno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>
							<input id="txtNoa"  type="text" class="txt c1"/>
							<input id="txtNoq"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtTrandate"  type="text" class="txt c1" style="float:left;width:40%;"/>
						    <input id="txtAdd4"   type="text" class="txt c1" style="float:left;width:40%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="float:left;width:30%;"/>
							<input id="txtComp"  type="text" style="float:left;width:69%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td colspan="3"><input id="txtOrdeno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblShip" class="lbl"> </a></td>
						<td><input id="txtShip" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td><input id="txtPo"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblBoat" class="lbl"> </a></td>
						<td><input id="txtBoat" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount"  type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStraddr" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtStraddr"  type="text" style="float:left;width:100%;"/>
						</td>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtMemo"  type="text" class="txt c1"/>
							<input id="txtCardno"  type="hidden" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
