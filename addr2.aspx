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
		var q_name="addr2";
		var q_readonly = [];
		var bbmNum = []; 
		var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwCount2=10; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
		//ajaxPath = ""; //  execute in Root
		
		$(document).ready(function () {
			bbmKey = ['noa'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1);
			$('#txtNoa').focus();
		});

		//////////////////	end Ready
		function main() {
			if (dataErr)	
			{
				dataErr = false;
				return;
			}
			mainForm(0); // 1=Last  0=Top
		}  ///  end Main()


		function mainPost() { 
			q_mask(bbmMask);
			$('#txtNoa').change(function(e){
					$(this).val($.trim($(this).val()).toUpperCase());		
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
							q_gt('addr2', t_where, 0, 0, 0, "checkAddr2_change", r_accy);
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
			});
		}
		
		function q_boxClose(s2) { 
			 var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///	q_boxClose 3/4
						break;
			}	/// end Switch
		}


		function q_gtPost(t_name) {  
			switch (t_name) {
				case 'checkAddr2_change':
						var as = _q_appendData("addr2", "", true);
						if (as[0] != undefined){
							alert('已存在 '+as[0].noa+' '+as[0].post);
						}
						break;
				case 'checkAddr2_btnOk':
						var as = _q_appendData("addr2", "", true);
						if (as[0] != undefined){
							alert('已存在 '+as[0].noa+' '+as[0].post);
							Unlock();
							return;
						}else{
							wrServer($('#txtNoa').val());
						}
						break;
				case q_name: if (q_cur == 4)	
						q_Seek_gtPost();
					break;
			}  /// end switch
		}
		
		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
			q_box('addr2_s.aspx', q_name + '_s', "500px", "300px", q_getMsg( "popSeek"));
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
			$('#txtPost').focus();
		}

		function btnPrint() {
 
		}
		function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
		}
		function btnOk() {
			Lock(); 
			$('#txtNoa').val($.trim($('#txtNoa').val()));		
				if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
			}else{
				alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
				Unlock();
				return;
			} 
			if(q_cur==1){
					t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
					q_gt('addr2', t_where, 0, 0, 0, "checkAddr2_btnOk", r_accy);
				}else{
					wrServer($('#txtNoa').val());
				}
		 }

		function wrServer( key_value) {
			var i;
			xmlSql = '';
			if (q_cur == 2)	
				xmlSql = q_preXml();

			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			_btnOk(key_value, bbmKey[0], '','',2);
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
				
				if(q_db.substring(0,2).toUpperCase()=='ST' || q_getPara('sys.project').toUpperCase()=='DC'){
                    $('.isST').show();
                }
			}

		function readonly(t_para, empty) {
			_readonly(t_para, empty);
			if(q_db.substring(0,2).toUpperCase()=='DC' && q_getPara('sys.project').toUpperCase()!='DC'){
                    $('#lblPost').text('地點');
                    $('#vewPost').text('地點');
            }
            if(q_getPara('sys.project').toUpperCase()=='PA'){
                    $('.isPA').show();
                    $('.isNPA').hide();
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

		function btnSeek(){
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
			.txt.c1 {
				width: 98%;
				float: left;
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
			 input[type="text"],input[type="button"] {	 
				font-size: medium;
			}
	</style>
</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:35%;"  >
				<table class="tview" id="tview"	border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>				
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:25%"><a id='vewPost'> </a></td>
						<td align="center" style="width:25%;display: none" class='isST'><a id='vewP_post'> </a></td>
					</tr>
					 <tr>
							<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
							<td align="center" id='noa'>~noa</td>
							<td align="center" id='post'>~post</td>
							<td align="center" id='p_post' class='isST' style="display: none">~p_post</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 63%;float: left;">
				<table class="tbbm"  id="tbbm"	border="0" cellpadding='2'  cellspacing='5'>
		 			<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td class="td3"></td>
						<td class="td4"></td>
					</tr>
					<tr class="isNPA">
						<td class="td1"><span> </span><a id='lblPost' class="lbl"></a></td>
						<td class="td2"><input id="txtPost"  type="text" class="txt c1"/></td>
					</tr>
					<tr class="isST" style="display: none">
						<td class="td1"><span> </span><a id='lblP_post' class="lbl"></a></td>
						<td class="td2"><input id="txtP_post"  type="text" class="txt c1" /></td>
					</tr>
					<tr class="isPA" style="display: none">
                        <td class="td1"><span> </span><a id='lblAddr' class="lbl">地點</a></td>
                        <td class="td2"><input id="txtAddr"  type="text" class="txt c1" /></td>
                    </tr>
					<tr class="isPA" style="display: none">
                        <td class="td1"><span> </span><a id='lblConn' class="lbl">聯絡人</a></td>
                        <td class="td2"><input id="txtConn"  type="text" class="txt c1" /></td>
                    </tr>
                    <tr class="isPA" style="display: none">
                        <td class="td1"><span> </span><a id='lblTel' class="lbl">電話</a></td>
                        <td class="td2"><input id="txtTel"  type="text" class="txt c1" /></td>
                    </tr>
                    <tr class="isPA" style="display: none">
                        <td class="td1"><span> </span><a id='lblAddress' class="lbl">地址</a></td>
                        <td class="td2" colspan="2"><input id="txtAddress"  type="text" class="txt c1" /></td>
                    </tr>
				</table>
			</div>
		</div> 
		<input id="q_sys" type="hidden" />	
	</body>
</html>