<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'quatc', t_content = ' ', bbsKey = ['quatno,no3'], as;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			var q_readonly = [
				'textComp','textMemo_datea','chkMemo_isproj','textMemo_paytype',
				'textMemo_coin','textMemo_floata','textMemo_salesno','textMemo_sales',
				'textMemo_addr2','textMemo_dispasser','textMemo_memo',
				'textMemo_checker','cmbMemo_trantype'
			];
			var q_readonlys = [
				'txtNick','txtOdate','txtQuatno','txtNo3',
				'txtProductno','txtProduct','txtSpec','txtClass',
				'txtSize','txtMount','txtWeight','chkIsproj','txtPrice',
				'txtUnit','txtDatea','chkEnda','chkCancel','txtChecker'
			];
			brwCount = -1;
			brwCount2 = 0;
			aPop = new Array(['textCustno', '', 'cust', 'noa,comp', 'textCustno,textComp', 'cust_b.aspx']);
			isLoadGt = 0;
			var fbbm = [];
			$(document).ready(function() {
				t_content += ' where=^^ ' + SeekStr() + ' ^^';
				main();
				$('#btnToSeek').click(function() {
					seekData(SeekStr());
					Lock();
				});
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content);
			}

			function DoFunc(DoName){
				DoName = $.trim(DoName);
				var t_workerno = encodeURI($.trim(r_userno.toUpperCase()));
				var t_worker = encodeURI($.trim(r_name));
				var t_dispass = encodeURI($.trim($('#textMemo_dispass').val()));
				var t_dispasser = encodeURI($.trim($('#textMemo_dispasser').val()));
				var t_checkpass = encodeURI($.trim($('#textMemo_checkpass').val()));
				var t_checkpasser = encodeURI($.trim($('#textMemo_checker').val()));
				var t_quatno = [];
				for(var k=0;k<q_bbsCount;k++){
					if($('#checkSel_'+k).prop('checked')){
						var thisQuatno = $.trim($('#txtQuatno_'+k).val());
						var thisNo3 = $.trim($('#txtNo3_'+k).val());
						if(thisQuatno.length > 0){
							t_quatno.push(thisQuatno+'-'+thisNo3);
						}
					}
				}
				if(t_quatno.length==0){
					alert('請選擇報價單');
					return;
				}else{
					var t_quatnoStr = $.trim(t_quatno.toString());
					t_quatnoStr = t_quatnoStr.replace(/\,/g, "^^");
					Lock();
					q_func('qtxt.query.quatc.'+DoName, 'quatc.txt,'+DoName+',' + t_workerno + ';' +
																		 t_worker + ';' +
																		 t_dispass + ';' +
																		 t_dispasser + ';' +
																		 t_checkpass + ';' +
																		 t_checkpasser + ';' +
																		 encodeURI(t_quatnoStr) + ';'
					);
				}
			}
			
			var SeekF = new Array();
			function mainPost() {
				q_getFormat();
				$('#textBdate').mask(r_picd);
				$('#textEdate').mask(r_picd);
				q_cmbParse("combTypea", q_getPara('sys.stktype'));
				q_cmbParse("cmbMemo_trantype", q_getPara('sys.tran'));
				$('#textCustno').focus(function() {
					q_cur = 2;
				}).blur(function() {
					q_cur = 0;
				});
				$('#seekTable td').children("input:text").each(function() {
					SeekF.push($(this).attr('id'));
					fbbm.push($(this).attr('id'));
				});
				SeekF.push('btnToSeek');
				$('#seekTable td').children("input:text").each(function() {
					$(this).bind('keydown', function(event) {
						keypress_bbm(event, $(this), SeekF, 'btnToSeek');
					});
				});
				$('#btnMemo_disapv').click(function(){
					DoFunc('dis_apv');
				});
				$('#btnMemo_disunapv').click(function(){
					DoFunc('dis_unapv');
				});
				$('#btnMemo_checkapv').click(function(){
					DoFunc('checker_apv');
				});
				$('#btnMemo_checkunapv').click(function(){
					DoFunc('checker_unapv');
				});
			}

			function q_funcPost(t_func, result) {
				switch(t_func){
					default:
						var as = _q_appendData("tmp0", "", true, true);
						var ShowMsg = '';
						console.log(as);
						if(as.length == 0){
							alert('執行完畢!!');
						}else{
							for(var k=0;k<as.length;k++){
								var thisMemo = $.trim(as[k].memo).split(':');
								if(thisMemo[0]=='ERROR'){
									ShowMsg += thisMemo[1] + '\n';
								}
							}
							if(ShowMsg.length > 0){
								alert(ShowMsg);
							}else{
								switch(t_func){
									case 'qtxt.query.quatc.dis_apv':
									case 'qtxt.query.quatc.dis_unapv':
										$('#textMemo_dispasser').val(r_name);
										break;
									case 'qtxt.query.quatc.checker_apv':
									case 'qtxt.query.quatc.checker_unapv':
										$('#textMemo_checker').val(r_name);
										break;
								}
							}
						}
						break;
				}
				seekData(LastSearchStr);
				Lock();
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (isLoadGt == 1) {
							abbs = _q_appendData(q_name, "", true);
							$('#textMemo_datea').val('');
							$("#chkMemo_isproj").attr('checked',false);
							$('#cmbMemo_trantype').val('');
							$('#textMemo_paytype').val('');
							$('#textMemo_coin').val('');
							$('#textMemo_floata').val(0);
							$('#textMemo_salesno').val('');
							$('#textMemo_sales').val('');
							$('#textMemo_addr2').val('');
							$('#textMemo_memo').val('');
							isLoadGt = 0;
							refresh();
						}
						break;
				}
			}

			function seekData(seekStr) {
				isLoadGt = 1;
				q_gt(q_name, 'where=^^ ' + seekStr + ' ^^', 0, 0, 0, "", r_accy);
			}

			function bbsAssign() {
				for(var j=0;j<q_bbsCount;j++){
					$('#checkSel_'+j).change(function(){
						if(!$(this).is(':checked')){
							$('#checkAllCheckbox').attr('checked', false);
						}
					});
					$('#radioSel_'+j).click(function(){
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
						if(abbs.length >= (dec(n)+1)){
							$('#textMemo_datea').val(abbs[n].datea);
							$("#chkMemo_isproj").attr('checked',(((abbs[n].isproj).toLowerCase()=="true") || abbs[n].isproj==true || abbs[n].isproj==1));
							$('#cmbMemo_trantype').val(abbs[n].trantype);
							$('#textMemo_paytype').val(abbs[n].paytype);
							$('#textMemo_coin').val(abbs[n].coin);
							$('#textMemo_floata').val(abbs[n].floata);
							$('#textMemo_salesno').val(abbs[n].salesno);
							$('#textMemo_sales').val(abbs[n].sales);
							$('#textMemo_addr2').val(abbs[n].addr2);
							$('#textMemo_memo').val(abbs[n].memo);
						}
					});
				}
			}
			var LastSearchStr = '';
			function SeekStr() {
				var t_typea = $.trim($('#combTypea').val());
				var t_bdate = $.trim($('#textBdate').val());
				var t_edate = $.trim($('#textEdate').val());
				var t_custno = $.trim($('#textCustno').val());
				var t_showLow = ($('#checkShow1').prop('checked')?1:0);
				var t_showDis = ($('#checkShow2').prop('checked')?1:0);
				var t_showApv = ($('#checkShow3').prop('checked')?1:0);
				var t_quatno = $.trim($('#textQuatno').val());
				if(t_edate.length == ''){
					t_edate = '999/99/99';
				}
				var t_where = " 1=1 ";
				t_where += " and (b.kind=N'"+t_typea+"') and (b.odate between N'"+t_bdate+"' and N'"+t_edate+"' ) ";
				if(t_custno.length > 0){
					t_where += " and (b.costno=N'"+t_custno+"')";
				}
				if(t_quatno.length > 0){
					t_where += " and (b.noa=N'"+t_quatno+"')";
				}
				if(t_showApv == 1){
					t_where += " and (len(a.checker)>0)";
				}
				if(t_showDis == 1){
					t_where += " and (len(a.diser)>0)";
				}
				LastSearchStr = t_where;
				return t_where;
			}

			var maxAbbsCount = 0;
			function refresh() {
				_refresh();
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=checkSel]').each(function() {
						$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
				q_bbsCount = (abbs.length==0?1:abbs.length);
				_readonly(false);
				Unlock();
			}
			function readonly(t_para, empty) {
				_readonly(false);
			}
		</script>
		<style type="text/css">
			#seekForm,#MemoForm {
				margin-left: auto;
				margin-right: auto;
				width: 100%;
			}
			#seekTable,#MemoTable {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			#seekTable tr,,#MemoTable tr {
				height: 35px;
			}
			.txt.c1 {
				width: 98%;
			}
			.txt.c2 {
				width: 95%;
			}
			.lbl {
				float: right;
			}
			span {
				margin-right: 5px;
			}
			td {
				width: 4%;
			}
			#MemoTable td{
				width: 1%;
			}
			.num {
				text-align: right;
			}
			input[type="text"],input[type="button"],select {
				font-size: medium;
			}
			.StrX {
				margin-right: -2px;
				margin-left: -2px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="seekForm">
			<table id="seekTable" border="0" cellpadding='0' cellspacing='0'>
				<tr>
					<td><span class="lbl">類別</span></td>
					<td><select id="combTypea" class="txt c1"></select></td>
					<td><span class="lbl">起始日期</span></td>
					<td><input id="textBdate" type="text" class="txt c1"/></td>
					<td><span class="lbl">終止日期</span></td>
					<td><input id="textEdate" type="text" class="txt c1"/></td>
					<td><span class="lbl">客戶編號</span></td>
					<td colspan="3">
						<input id="textCustno" type="text" style="width:25%"/>
						<input id="textComp" type="text" style="width:73%"/>
					</td>
					<td align="center">
						<input type="button" id="btnToSeek" value="匯入">
					</td>
				</tr>
				<tr>
					<td colspan="6" align="center">
						<input id="checkShow1" type="checkbox" class="txt"/>
						<span class="txt">僅秀低盤</span>
						<input id="checkShow2" type="checkbox" class="txt"/>
						<span class="txt">已折扣</span>
						<input id="checkShow3" type="checkbox" class="txt"/>
						<span class="txt">取消報價 僅秀已核准</span>
					</td>
					<td><span class="lbl">報價單號</span></td>
					<td colspan="2"><input id="textQuatno" type="text" class="txt c1"/></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<div id="q_acDiv" style="display: none;">
				<div></div>
			</div>
		</div>
		<div id="dbbs" style="width:100%;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:1850px;' >
				<tr style='color:White; background:#003366;' >
					<th align="center" style="width:40px;" >
					</th>
					<th align="center" style="width:40px;" >
						<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<td align="center" style="width:130px;"><a id='lblNick'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOdate'> </a></td>
					<td align="center" style="width:150px;"><a id='lblQuatno'> </a></td>
					<td align="center" style="width:40px;"><a id='lblNo3'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct'> </a></td>
					<td align="center" style="width:80px;"><a id='lblSpec'> </a></td>
					<td align="center" style="width:80px;"><a id='lblClass'> </a></td>
					<td align="center" style="width:180px;"><a id='lblSize'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeight'> </a></td>
					<td align="center" style="width:40px;"><a id='lblIsproj'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDatea'> </a></td>
					<td align="center" style="width:40px;"><a id='lblEnda'> </a></td>
					<td align="center" style="width:40px;"><a id='lblCancel'> </a></td>
					<td align="center" style="width:100px;"><a id='lblChecker'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center" style="width:40px;">
						<input id="radioSel.*" type="radio" name="radioSel"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="checkSel.*" type="checkbox" name="checkSel"/>
					</td>
					<td align="center" style="width:130px;">
						<input id="txtNick.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:100px;">
						<input id="txtOdate.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:150px;">
						<input id="txtQuatno.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="txtNo3.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:200px;">
						<input id="txtProductno.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:200px;">
						<input id="txtProduct.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtSpec.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtClass.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:180px;">
						<input id="txtSize.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtMount.*" type="text" class="txt c2 num" readonly="readonly"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtWeight.*" type="text" class="txt c2 num" readonly="readonly"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="chkIsproj.*" type="checkbox" class="txt"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtPrice.*" type="text" class="txt c2 num" readonly="readonly"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="txtUnit.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:100px;">
						<input id="txtDatea.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="chkEnda.*" type="checkbox" class="txt"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="chkCancel.*" type="checkbox" class="txt"/>
					</td>
					<td align="center" style="width:100px;">
						<input id="txtChecker.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
				</tr>
			</table>
		</div>
		<div id="MemoForm">
			<table id="MemoTable" border="0" cellpadding='0' cellspacing='0'>
				<tr>
					<td><span class="lbl">有效日期</span></td>
					<td><input id="textMemo_datea" type="text" class="txt c1"/></td>
					<td>
						<input id="chkMemo_isproj" type="checkbox" class="txt" style="float: left;"/>
						<span class="lbl" style="float:left;">專案</span>
					</td>
					<td><span class="lbl">交運方式</span></td>
					<td><select id="cmbMemo_trantype" class="txt c1"></select></td>
					<td><span class="lbl">付款方式</span></td>
					<td><input id="textMemo_paytype" type="text" class="txt c1"/></td>
				</tr>
				<tr>
					<td><span class="lbl">匯率</span></td>
					<td colspan="2">
						<input id="textMemo_coin" type="text" class="txt" style="width:45%;"/>
						<input id="textMemo_floata" type="text" class="txt" style="width:50%;"/>
					</td>
					<td></td>
					<td></td>
					<td><span class="lbl">業務員</span></td>
					<td colspan="2">
						<input id="textMemo_salesno" type="text" class="txt" style="width:45%;"/>
						<input id="textMemo_sales" type="text" class="txt" style="width:50%;"/>
					</td>
				</tr>
				<tr>
					<td><span class="lbl">送貨地址</span></td>
					<td colspan="4"><input id="textMemo_addr2" type="text" class="txt c1"/></td>
					<td><span class="lbl">折扣密碼</span></td>
					<td colspan="2">
						<input id="textMemo_dispass" type="password" class="txt" style="width:45%;"/>
						<input id="textMemo_dispasser" type="text" class="txt" style="width:50%;"/>
					</td>
					<td colspan="2">
						<input id="btnMemo_disapv" type="button" class="txt c1" value="核准" style="width:45%;"/>
						<input id="btnMemo_disunapv" type="button" class="txt c1" value="取消核准" style="width:45%;"/>
					</td>
				</tr>
				<tr>
					<td><span class="lbl">備註</span></td>
					<td colspan="4"><input id="textMemo_memo" type="text" class="txt c1"/></td>
					<td><span class="lbl">核准密碼</span></td>
					<td colspan="2">
						<input id="textMemo_checkpass" type="password" class="txt" style="width:45%;"/>
						<input id="textMemo_checker" type="text" class="txt" style="width:50%;"/>
					</td>
					<td colspan="2">
						<input id="btnMemo_checkapv" type="button" class="txt" value="核准" style="width:45%;"/>
						<input id="btnMemo_checkunapv" type="button" class="txt" value="取消核准" style="width:45%;"/>
					</td>
				</tr>
			</table>
			<div id="q_acDiv" style="display: none;">
				<div></div>
			</div>
		</div>
	</body>
</html>