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

			q_tables = 's';
			var q_name = "salb";
			var q_readonly = ['txtNoa','txtMoney','txtTax'];
			var q_readonlys = ['txtNamea','txtId'];
			var bbmNum = [['txtMoney',15,0,1],['txtTax',15,0,1]];
			var bbsNum = [
				['txtMount',10,0,1],['txtAd_money',15,0,1],['txtCh_meal',15,0,1],
				['txtMoney',15,0,1],['txtRetire',15,0,1],['txtTax',15,0,1],['txtTax2',15,0,1]
			];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			
			aPop = new Array(
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtSssno_', 'btnSssno_', 'sss', 'noa,namea,sex', 'txtSssno_,txtNamea_,cmbSex_,txtMount_', 'sss_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)
				q_gf('PAYFORM.txt', '');
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
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbSex", q_getPara('sss.sex'),'s');
				$('#btnIndata').click(function(){
					var t_mon = $.trim($('#txtMon').val());
					var t_where = "where=^^ (typea=N'薪資') and (mon=N'"+t_mon+"')";
					q_gt('salary', t_where, 0, 0, 0, "");
				});
			}
			
			var t_typea='',c_typea=' @ ',t_typeb='',c_typeb=' @ ',t_typec='',c_typec=' @ ';
			function q_gfPost() {
				if (q_gfTxt=='PAYFORM.txt'){
					t_typea = xmlString.split('\r\n');
					//處理內容
					for (i=0;i<t_typea.length;i++){
						var typea=replaceAll(t_typea[i],' ','').split(';')[0];
						c_typea=c_typea+','+typea.split('.')[0]+"@"+typea;
					}
					
					q_cmbParse("cmbTypea", c_typea, 's');
					q_gf('PAYREMARK.txt', '');
				}else if (q_gfTxt=='PAYREMARK.txt'){
					t_typeb = xmlString.split('\r\n');
					q_gf('PAYMARK.txt', '');
				}else if (q_gfTxt=='PAYMARK.txt'){
					t_typec = xmlString.split('\r\n');
				}
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
			var ret;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'salary':
						var as = _q_appendData("salarys", "", true);
						var t_mon = $.trim($('#txtMon').val());
						if(as.length == 0){
							alert(t_mon+'尚未建立[薪資作業]');
						}else{
							for(var k=0;k<as.length;k++){
								var s_money = dec(as[k].total5)-0-dec(as[k].addmoney);
								as[k]['tmp_money'] = s_money;
								as[k]['tmp_food_money'] = 0;
							}
							for(var j=0;j<q_bbsCount;j++){
								$('#btnMinus_'+j).click();
							}
							ret = q_gridAddRow(bbsHtm, 'tbbs','txtSssno,txtNamea,txtMount,txtAd_money,txtMoney,txtCh_meal',as.length, as,'sno,namea,raise_num,addmoney,tmp_money,tmp_food_money','txtSssno');
							var SssArray = [];
							for(var i=0;i<ret.length;i++){
								var thisSssno = $.trim($('#txtSssno_'+ret[i]).val());
								SssArray.push("'"+thisSssno+"'");
							}
							if(SssArray.length > 0){
								var t_where = "where=^^ noa in (" + SssArray.toString() + ")";
								q_gt('sss', t_where, 0, 0, 0, "salaryGetSSS");
							}
						}
						break;
					case 'salaryGetSSS':
						var as = _q_appendData("sss", "", true);
						for(var j=0;j<as.length;j++){
							var sss_noa = $.trim(as[j].noa);
							for(var k=0;k<ret.length;k++){
								var ret_sss = $.trim($('#txtSssno_'+ret[k]).val());
								if(sss_noa==ret_sss){
									//$('#txtId_'+ret[k]).val($.trim(as[j].id));
									$('#cmbSex_'+ret[k]).val($.trim(as[j].sex));
									//$('#txtAddr_'+ret[k]).val(($.trim(as[j].addr_conn)=='同上'?$.trim(as[j].addr_home):$.trim(as[j].addr_conn)));
									break;
								}
							}
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnOk() {
				$('#txtMon').val($.trim($('#txtMon').val()));
				sum();
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtMon', q_getMsg('lblMon')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				$('#txtWorker').val(r_name)
				sum();
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				var t_mon = $.trim($('#txtMon').val());
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_salb') + t_mon, '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('salb_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
			}

			function bbsAssign() {
				_bbsAssign();
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#btnMinus_' + j).click(function() {
						btnMinus($(this).attr('id'));
					});
					$('#txtMoney_'+j).change(function(){
						sum();
					});
					$('#txtTax_'+j).change(function(){
						sum();
					});
					
					$('#cmbTypea_'+j).change(function(){
						t_IdSeq = -1;
	                    q_bodyId($(this).attr('id'));
	                    b_seq = t_IdSeq;
						if(q_cur==1 || q_cur==2){
							//處理內容
							c_typeb=' @ ';
							for (i=0;i<t_typeb.length;i++){
								var typeb=t_typeb[i].split('	');
								if(typeb[1]==$('#cmbTypea_'+b_seq).val())
									c_typeb=c_typeb+','+typeb[2]+"@"+typeb[3];
							}
							$('#cmbTypeb_'+b_seq).text('');
							$('#cmbTypec_'+b_seq).text('');
							q_cmbParse("cmbTypeb_"+b_seq, c_typeb);
							
							//處理內容
							c_typec=' @ ';
							for (i=0;i<t_typec.length;i++){
								var typec=t_typec[i].split('	');
								if(typec[0]==$('#cmbTypea_'+b_seq).val()){
									var item=typec[1].split('.');
									c_typec=c_typec+','+item[0]+"@"+typec[1];
								}
							}
							q_cmbParse("cmbTypec_"+b_seq, c_typec);
						}
					});
					/*$('#cmbTypeb_'+j).change(function(){
						t_IdSeq = -1;
	                    q_bodyId($(this).attr('id'));
	                    b_seq = t_IdSeq;
						q_gf('PAYMARK.txt', '');
					});*/
				}
				btnTypechange();
			}

			function btnIns() {
				_btnIns();
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
				q_box('z_salb.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['namea']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['date'] = abbm2['date'];
				as['custno'] = abbm2['custno'];
				return true;
			}

			function sum() {
				var t_money = 0,t_mi_money = 0;
				var t_moneys = 0,t_mi_moneys = 0;
				for (var j = 0; j < q_bbsCount; j++) {
					var t_moneys = dec($('#txtMoney_'+j).val());
					var t_mi_moneys = dec($('#txtTax_'+j).val());
					t_money = q_add(t_money,t_moneys);
					t_mi_money = q_add(t_mi_money,t_mi_moneys);
				}
				$('#txtMoney').val(t_money);
				$('#txtTax').val(t_mi_money);
			}

			function refresh(recno) {
				_refresh(recno);
				//btnTypechange();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
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
			
			var typebbs=false;
			
			function btnTypechange() {
				//if((q_cur>2 || q_cur<1)){
					for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
						if($('#cmbTypea_'+j).val()!=''){
							c_typeb=' @ ';
							for (i=0;i<t_typeb.length;i++){
								var typeb=t_typeb[i].split('	');
								if(typeb[1]==$('#cmbTypea_'+j).val())
									c_typeb=c_typeb+','+typeb[2]+"@"+typeb[3];
							}
							$('#cmbTypeb_'+j).text('');
							$('#cmbTypec_'+j).text('');
							q_cmbParse("cmbTypeb_"+j, c_typeb);
							if(abbs[0]!=undefined)
								$('#cmbTypeb_'+j).val(abbs[j].typeb);
							
							c_typec=' @ ';
							for (i=0;i<t_typec.length;i++){
								var typec=t_typec[i].split('	');
								if(typec[0]==$('#cmbTypea_'+j).val()){
									var item=typec[1].split('.');
									c_typec=c_typec+','+item[0]+"@"+typec[1];
								}
							}
							$('#cmbTypec_'+j).text('');
							q_cmbParse("cmbTypec_"+j, c_typec);
							if(abbs[0]!=undefined)
								$('#cmbTypec_'+j).val(abbs[j].typec);
						}
					}
				//}
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 28%;
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
				width: 70%;
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
			.tbbm td input[type="button"] {
				float: left;
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.dbbs {
				width: 1500px;
			}
			.tbbs a {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
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
			<div class="dview" id="dview" style="float: left; width:32%;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewMon'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='mon'>~mon</td>
						<td align="center" id='datea'>~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0'>
					<tr>
						<td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class='td3'><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td class="td4"><input id="txtCno" type="text" class="txt c1" /></td>
						<td class='td5'colspan="2"><input id="txtAcomp" type="text" class="txt c1" /></td>
						<td class="td6"> </td>
					</tr>
					<tr>
						<td class='td1'><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td class="td2"><input id="txtMon" type="text" class="txt c1"/></td>
						<td class='td3'><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class='td5'><span> </span><a id="lblTitle" class="lbl"> </a></td>
						<td class="td6"><input id="txtTitle" class="txt c1" type="text" /></td>
						<td class='td7'><input id="btnIndata" type="button"/></td>
						<td class="td8"> </td>
					</tr>
					<tr>
						<td class='td1'> </td>
						<td class="td2">
							<!--<input id="btnEnd" type="button" />-->
							<input id="btnMedia" type="button" />
						</td>
						<td class='td3'><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td class="td4"><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td class='td5'><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td class="td6"><input id="txtTax" type="text" class="txt num c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center"><a id='lblSssno'> </a></td>
					<td align="center"><a id='lblNamea'> </a></td>
					<!--<td align="center"><a id='lblId'> </a></td>-->
					<td align="center" style="width: 90px;"><a id='lblTypea'> </a></td>
					<td align="center" style="width: 90px;"><a id='lblTypeb'> </a></td>
					<td align="center" style="width: 90px;"><a id='lblTypec'> </a></td>
					<!--<td align="center"><a id='lblWtno'> </a></td>-->
					<td align="center" style="width: 20px;"><a id='vewIsclerk'> </a></td>
					<td align="center"><a id='lblMount'> </a></td>
					<td align="center"><a id='lblAd_money'> </a></td>
					<td align="center"><a id='lblCh_meal'> </a></td>
					<td align="center"><a id='lblMoneys'> </a></td>
					<td align="center"><a id='lblRetire'> </a></td>
					<!--<td align="center"><a id='lblRate'> </a></td>-->
					<td align="center"><a id='lblTaxs'> </a></td>
					<td align="center"><a id='lblTax2s'> </a></td>
					<!--<td align="center"><a id='lblMi_moneys'> </a></td>-->
					<td align="center" style="width: 40px;"><a id='lblSex'> </a></td>
					<td align="center"><a id='lblComp'> </a></td>
					<!--<td align="center" ><a id='lblAddr'> </a></td>-->
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:1%;">
						<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>
					<td>
						<input id="btnSssno.*" type="button" style="width:10%;" value="." />
						<input id="txtSssno.*" type="text" class="txt" style="width:70%;"/>
					</td>
					<td><input id="txtNamea.*" type="text" class="txt c1"/></td>
					<!--<td><input id="txtId.*" type="text" class="txt c1"/></td>-->
					<td><select id="cmbTypea.*" class="txt c1"> </select></td>
					<td><select id="cmbTypeb.*" class="txt c1"> </select></td>
					<td><select id="cmbTypec.*" class="txt c1"> </select></td>
					<!--<td><input id="txtWtno.*" type="text" class="txt c1"/></td>-->
					<td><input id="chkIsclerk.*" type="checkbox"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1" /></td>
					<td><input id="txtAd_money.*" type="text" class="txt num c1" /></td>
					<td><input id="txtCh_meal.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMoney.*" type="text" class="txt num c1" /></td>
					<td><input id="txtRetire.*" type="text" class="txt num c1" /></td>
					<!--<td><input id="txtRate.*" type="text" class="txt num c1" /></td>-->
					<td><input id="txtTax.*" type="text" class="txt num c1" /></td>
					<td><input id="txtTax2.*" type="text" class="txt num c1" /></td>
					<!--<td><input id="txtMi_money.*" type="text" class="txt num c1"/></td>-->
					<td><select id="cmbSex.*" class="txt c1"> </select></td>
					<td>
						<input id="txtCno.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
					</td>
					<!--<td><input id="txtAddr.*" type="text" class="txt c1"/></td>-->
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>