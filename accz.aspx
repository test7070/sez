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
		var q_name="accz";
		var q_readonly = ['txtNoa'];
		var bbmNum = [['txtMount',10, 0, 1],['txtEcount',10, 0, 1],['txtRate',3, 2, 1],['txtMoney',14, 0, 1],['txtFixmoney',14, 0, 1],['txtAccumulat',14, 0, 1],['txtEndvalue',14, 0, 1]]; 
		//var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'acc1';
		//ajaxPath = ""; //  execute in Root
		aPop = new Array(
			['txtDepl_ac', 'lblAcc', 'acc', 'acc1,acc2', 'txtDepl_ac,txtNamea2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
			['txtPartno', 'lblPartno', 'acpart', 'noa,part', 'txtPartno,txtPart', "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
		$(document).ready(function () {
			bbmKey = ['noa'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy + "_" + r_cno );
			$('#txtNoa').focus();
		});
		//////////////////   end Ready
		function currentData() {}
		currentData.prototype = {
			data : [],
			/*新增時複製的欄位*/
			include : ['txtAcc1', 'txtDepl_ac','txtNamea2','txtPartno','txtPart','txtMount','txtUnit'],
			/*記錄當前的資料*/
			copy : function() {
				this.data = new Array();
				for (var i in fbbm) {
					var isInclude = false;
					for (var j in this.include) {
						if (fbbm[i] == this.include[j]) {
							isInclude = true;
							break;
						}
					}
					if (isInclude) {
						this.data.push({
							field : fbbm[i],
							value : $('#' + fbbm[i]).val()
						});
					}
				}
			},
			/*貼上資料*/
			paste : function() {
				for (var i in this.data) {
					if(this.data[i].field == 'txtAcc1' && (this.data[i].value).length>5)
						$('#' + this.data[i].field).val((this.data[i].value).substring(0,5));
					else
						$('#' + this.data[i].field).val(this.data[i].value);
				}
			}
		};
		var curData = new currentData();
		function main() {
			if (dataErr){
				dataErr = false;
				return;
			}
			mainForm(0); // 1=Last  0=Top
		}  ///  end Main()

		function mainPost() { 
			q_getFormat();
			bbmMask = [['txtIndate', r_picd],['txtFixdate', r_picd],['txtDatea', r_picd],['textMon', r_picm]];
			q_mask(bbmMask);
			$('#btnAcczt').click(function () {
				var t_where = "acc1='" + $('#txtAcc1').val() + "'";
				q_box("acczt.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+ t_where + ";" +  r_accy , '', "95%", "650px", q_getMsg('popAcczt'));
			})
			$('#btnTurncut').click(function(){
				$('#Changeaccno').toggle();
			});
			$('#btnChangeaccno').click(function(){
				var mon = $('#textMon').val();
				q_func( 'accz.gen', mon+','+r_name);
				$('#btnChangeaccno').attr('disabled','disabled');
			});
			$('#btnCloseaccno').click(function(){
				$('#Changeaccno').toggle();
			});
			$('#btnAccza').click(function() {
				q_box("accza_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";", 'accza', "40%", "430px", q_getMsg('popAccza'));
			});
			$('#btnAcczs').click(function () {
				q_box("acczs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";acczno='" + $('#txtNoa').val() + "';" +  r_accy , '', "95%", "95%", q_getMsg('popAcczs'));
			})
			$('#btnAccz').click(function () {
				q_box('z_accz.aspx' + "?;;;;" + r_accy, '', '95%', '95%', q_getMsg("popAccz"));
			})
			$('#btnZ_acczs').click(function () {
				q_box('z_acczs.aspx' + "?;;;;" + r_accy, '', '95%', '95%', q_getMsg("popAcczs"));
			})
			$('#txtAcc1').change(function(){
				var s1 = trim($(this).val());
				if(s1.length > 4 && s1.indexOf('.') <0)
					$(this).val(s1.substr(0,4) + '.' + s1.substr(4));
				if(s1.length == 4)
					$(this).val(s1 + '.');
			});
			$('#txtDepl_ac').change(function(){
				var s1 = trim($(this).val());
				if(s1.length > 4 && s1.indexOf('.') <0)
					$(this).val(s1.substr(0,4) + '.' + s1.substr(4));
				if(s1.length == 4)
					$(this).val(s1 + '.');
			})
			$('#txtMoney').change(function(){
				if(q_float('txtMoney') != 0 && q_float('txtFixmoney') > 0 )
					alert(q_getMsg('lblMoney') + ' ' + q_getMsg('lblFixmoney') + '不可同時存在。');
				sum();
			})
			$('#txtFixmoney').change(function(){
				if(q_float('txtFixmoney') !=0 && q_float('txtMoney') > 0)
					alert(q_getMsg('lblMoney') + ' ' + q_getMsg('lblFixmoney') + '不可同時存在。');
				sum();
			})
			$('#txtAccumulat').change(function(){
				sum();
			})
			$('#txtYear').change(function(){
				sum();
			})
			$('#txtEndvalue').change(function(){
				sum();
			})
			$('#txtRate').change(function(){
				var rate = trim($(this).val().valueOf());
				if(rate >=0 && rate <= 1){
					if(rate.indexOf('.') < 0)
						$(this).val(rate + '.00');
					else{
						if(rate.length == 3)
							$(this).val(rate + '0');
						else if(rate.length <3)
							$(this).val(rate + '00');
					}
				}else{
					alert(q_getMsg('lblRate') + '提撥率應介於 0 ~ 1 之間');
					$(this).val('1.00');
				}
			})
			$('#txtEndvalue').blur(function() {
					$('#txtMemo').focus();
				}).keydown(function(e) {
			 		if ( e.keyCode=='13' ){
			 			event.returnValue= false;
							event.keyCode= 9;
				  	}
				});
			$('#chkNscrapvalue').click(function(){
				if($('#chkNscrapvalue').is(':checked'))
					$('#txtEndvalue').val(0).attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
				else
					$('#txtEndvalue').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
			});
		}
		function q_funcPost(t_func, result) {
			switch(t_func) {
				case 'accz.gen':
					alert(result);
					$('#btnChangeaccno').removeAttr('disabled', 'disabled');
					$('#btnCloseaccno').click();
					
				break;
			}
		}
		function OpenAccnoWindows(noaKey){
			if(!emp(noaKey.length)){
				b_window = false;
				q_box("accc.aspx?;;;accc3='" + noaKey + "';"+r_accy+"_1", 'accc', "95%", "95%", q_getMsg("popAccc"));
			}
		}
		
		function sum(){
			var endvalue = 0;
			var money = q_float('txtMoney');
			var fixmoney = q_float('txtFixmoney');
			var year = q_float('txtYear');
			if(year > 0 && !($('#chkIsdepl')[0].checked==true)){
				if($('#chkNscrapvalue')[0].checked==true){
					endvalue = 0;
				}else{
					if($('#chkIsendmodi')[0].checked==true){
						endvalue = dec($('#txtEndvalue').val());
					}else{
						endvalue = (money + fixmoney)/(year+1);
					}
				}
			}else{
				endvalue = 0;
			}
			$('#txtEndvalue').val(dec(endvalue));
		}
		function q_boxClose( s2) {
			var ret; 
			switch (b_pop) {
				case q_name + '_s':
					q_boxClose2(s2); ///   q_boxClose 3/4
					break;
			}   /// end Switch
		}
		function q_gtPost(t_name) {  
			switch (t_name) {
				 case 'NewAcc1': 
					if(q_cur==1 || q_cur==2){
						var MaxAcc1Noq = '0000',k = 0;
						var NewAs = new Array;
						var as = _q_appendData(q_name, "", true);
						for(var i = 0;i < as.length;i++){
							if(as[i].acc1.length > 5){
								NewAs[k] = (as[i].acc1).substring(5);
								k++;
							}
						}
						if(NewAs.length == 0){
							MaxAcc1Noq = '0001';
						}else{
							MaxAcc1Noq = Math.max.apply(Math,NewAs)+1;
							MaxAcc1Noq = padL(MaxAcc1Noq,'0',4);//左方補0
						}
						$('#txtAcc1').val($.trim($('#txtAcc1').val()) + MaxAcc1Noq);
						key_value = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val($('#txtAcc1').val());
						_btnOk(key_value, bbmKey[0], '','',2);
					}
				 case q_name: 
				 	if (q_cur == 4)  
						q_Seek_gtPost();
					break;
			}  /// end switch
		}
		
		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
			q_box('accz_s.aspx', q_name + '_s', "500px", "400px", q_getMsg( "popSeek"));
		}

		function btnIns() {
			curData.copy();
			_btnIns();
			curData.paste();
			if($('#chkNscrapvalue').is(':checked'))
				$('#txtEndvalue').val(0).attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
			else
				$('#txtEndvalue').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
			$('#txtNoa').focus();
			$('#txtDatea').val(q_date());
			$('#txtIndate').val(q_date());
			$('#txtRate').val('1.00');
		}

		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;
			_btnModi();
			$('#txtNoa').attr('disabled', 'disabled');
			if($('#chkNscrapvalue').is(':checked'))
				$('#txtEndvalue').val(0).attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
			else
				$('#txtEndvalue').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
			$('#txtNamea').focus();
		}

		function btnPrint() {
			q_box('z_accz.aspx' + "?;;;;" + r_accy, '', '95%', '95%', q_getMsg("popPrint"));
		}
		function btnOk() {
			sum();
	   		var t_acc1 = $.trim($('#txtAcc1').val());
			var t_noa = trim($('#txtNoa').val());
			var t_date = trim($('#txtDatea').val());
			if(t_acc1.length < 5 || (q_cur==1 && t_acc1.substr(t_acc1.length-1,1) != '.')){
				alert('新增時只需輸入前四碼(主科目) ex: 1451');
				$('#txtAcc1').focus();
				return;
			};
			if(q_cur == 1 && (dec($('#txtEcount').val()) == 0))
				$('#txtEcount').val($('#txtMount').val());
			wrServer( t_noa);
		}

		function wrServer(key_value) {
			var i;
			xmlSql = '';
			if (q_cur == 2)   /// popSave
				xmlSql = q_preXml();
			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			var t_acc1 = $.trim($('#txtAcc1').val());
			if(t_acc1.length == 5 && t_acc1.substr(t_acc1.length-1,1) == '.' && (q_cur==1 || q_cur==2)){
				t_where = "where=^^ left(acc1,5) = '" + $('#txtAcc1').val() + "'^^";
				q_gt(q_name,t_where , 0, 0, 0, "NewAcc1",r_accy+'_'+r_cno);
			}else{
				_btnOk(key_value, bbmKey[0], '','',2);
			}
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
			width: 38%;
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
			width: 60%;
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
			width: 38%;
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
		
		 input[type="text"],input[type="button"] {	 
			font-size: medium;
		}
		#Changeaccno{
			display:none;
			width:20%;
			background-color: #cad3ff;
			border: 5px solid gray;
			position: absolute;
			z-index: 50;
		}
	</style>
</head>
<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"-->
	<div id='dmain' style="overflow:hidden;">
		<div class="dview" id="dview" style="float: left;  width:25%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk'></a></td>
					<td align="center" style="width:25%"><a id='vewAcc1'></a></td>
					<td align="center" style="width:40%"><a id='vewNamea'></a></td>
					<td align="center" style="width:40%"><a id='vewDepl_ac'></a></td>
				</tr>
				<tr>
					<td><input id="chkBrow.*" type="checkbox" style=''/></td>
					<td align="center" id='acc1'>~acc1</td>
					<td align="center" id='namea'>~namea</td>
					<td align="center" id='depl_ac'>~depl_ac</td>
				</tr>
			</table>
		</div>
		<div class='dbbm' style="width: 73%;float: left;">
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
				<tr style="height:1px;">
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td> </td>
					<td class="tdZ"> </td>
				</tr>
				<tr style="display: none;">
					<td class="td1" ><span> </span><a id='lblNoa' class="lbl"></a></td>
					<td class="td2" ><input id="txtNoa" type="text" class="txt c1"/></td>
				</tr>
				<tr>
					<td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
					<td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
					<td class="td3"></td>
					<td class="td4"></td>
					<td class="td5"></td>
					<td class="td6"></td>			  
				</tr>
				<tr>
					<td class="td1"><span> </span><a id='lblAcc1' class="lbl"></a></td>
					<td class="td2"><input id="txtAcc1" type="text" class="txt c1"/></td>
					<td class="td3" align="right"><input id="chkIsdepl" type="checkbox" /></td>
					<td class="td4"><a id="lblDepl_ac"></a></td>
				</tr>
				<tr>
					<td class="td1"><span> </span><a id="lblNamea" class="lbl"></a></td>
					<td class="td2"><input id="txtNamea"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id='lblIndate' class="lbl"></a></td>
					<td class="td4"><input id="txtIndate"  type="text" class="txt c1" /></td>
					<td class="td5"></td>
					<td class="td6"></td>
				</tr>			
				<tr>
					<td class="td1"><span> </span><a id='lblAcc' class="lbl btn"></a></td>
					<td class="td2"><input id="txtDepl_ac"  type="text" class="txt c2"/><input id="txtNamea2"  type="text" class="txt c3"/></td>
					<td class="td3"><span> </span><a id="lblPartno" class="lbl btn"></a></td>
					<td class="td4">
						<input id="txtPartno"  type="text"  class="txt c2"/>
							<input id="txtPart"  type="text"  class="txt c3"/>
					</td>
				</tr>
				<tr>
					<td class="td1"><span> </span><a id='lblMount' class="lbl"></a></td>
					<td class="td2"><input id="txtMount"  type="text" class="txt num c1"/></td>
					<td class="td3"><span> </span><a id='lblUnit' class="lbl"></a></td>
					<td class="td4"><input id="txtUnit"  type="text" class="txt c1" /></td>
					<td class="td5"><span> </span><a id='lblEcount' class="lbl"></a></td>
					<td class="td6"><input id="txtEcount"  type="text"  class="txt num c1" /></td>
				</tr>
				<tr>
					<td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
					<td class="td2"><input id="txtMoney"  type="text" class="txt num c1" /></td>
					<td class="td3"><span> </span><a id='lblYear' class="lbl"></a></td>
					<td class="td4"><input id="txtYear"  type="text" class="txt num c1"/></td>
					<td class="td5"></td>
					<td class="td6"></td>
				</tr>
				<tr>
					<td class="td1"><span> </span><a id='lblFixmoney' class="lbl"></a></td>
					<td class="td2"><input id="txtFixmoney"  type="text" class="txt num c1" /></td>
					<td class="td3"><span> </span><a id='lblFixdate' class="lbl"></a></td>
					<td class="td4"><input id="txtFixdate"  type="text" class="txt c1" /></td>
					<td class="td5"></td>
					<td class="td6"></td>
				</tr>
				<tr>
					<td class="td1"><span> </span><a id='lblAccumulat' class="lbl"></a></td>
					<td class="td2"><input id="txtAccumulat"  type="text" class="txt num c1" /></td>
					<td class="td3"></td>
					<td class="td4">
						<div id="Changeaccno">
							<table>
								<tr>
									<td style="width:30%;"><span> </span>月份</td>
									<td style="width:70%;"><input id="textMon" type="text" class="txt c1"/></td>
								</tr>
								<tr>
									<td colspan="2" align="center">
									<input id="btnChangeaccno" type="button" value="轉切傳票">
									<input id="btnCloseaccno" type="button" value="關閉視窗">
									</td>
								</tr>
							</table>
						</div>
						<input id="btnTurncut" type="button"  />
					</td>
					<td class="td5"><input id="btnAcczs" type="button" /></td>
					<td class="td6"></td>
				</tr>
				<tr>
					<td class="td1"><span> </span><a id='lblEndvalue' class="lbl"></a></td>
					<td class="td2"><input id="txtEndvalue"  type="text" class="txt num c1" /></td>
					<td class="td3">
						<input id="chkIsendmodi" type="checkbox" />
						<span> </span><a id="lblIsendmodi"></a>
					</td>
					<td class="td4"><input id="btnAcczt" type="button" /></td>
					<td class="td5"><input id="btnZ_acczs" type="button" /></td>
					<td class="td6"></td>
				</tr>
				<tr>
					<td class="td1"><span> </span><a id='lblRate' class="lbl"></a></td>
					<td class="td2"><input id="txtRate" type="text" class="txt num c1" /></td>
					<td class="td3">
						<input id="chkNscrapvalue" type="checkbox" class="txt"/>
						<span> </span><a id="lblNscrapvalue" class="txt"></a>
					</td>
					<td class="td4"><input id="btnAccza" type="button"  /></td>
					<td class="td5" ></td>
					<td class="td6"></td>
				</tr>
				<tr>
					<td class="td1"></td>
					<td class="td2"></td>
					<td class="td3"></td>
					<td class="td4"><input id="btnAccz" type="button"  /></td>
					<td class="td5"></td>
					<td class="td6"></td>
				</tr> 
				<tr>
					<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
					<td class="td2" colspan="5"><textarea id="txtMemo" rows="5" cols="10" style="width: 98%; height: 50px;"></textarea></td>
				</tr>
			</table>
		</div>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>
			