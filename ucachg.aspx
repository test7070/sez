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
			var q_name = "ucachg";
			var q_readonly = ['txtNoa','txtKdate','txtWorker','txtWorker2','txtApv','txtRev'];
			var q_readonlys = ['txtOrgproductno','txtOrgproduct','txtOrgprocessno','txtOrgprocess','txtOrgspec','txtOrgunit','txtOrgmount','cmbOrgmtype','txtOrgloss','txtOrgdividea','txtOrgmul','txtOrgmemo'];
			var bbmNum = [];
			var bbmMask = [];
			var bbsNum = [['txtOrgmount', 15, 2, 1],['txtOrgloss', 15, 2, 1],['txtOrgdividea', 15, 0, 1],['txtOrgmul', 15, 2, 1],
									['txtMount', 15, 2, 1],['txtLoss', 15, 2, 1],['txtDividea', 15, 0, 1],['txtMul', 15, 2, 1]];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			aPop = new Array(
	        	['txtProductno', 'lblProductno', 'uca', 'noa,product', 'txtProductno,txtProduct', 'uca_b.aspx'],
	        	['txtProcessno_', 'btnProcessno_', 'process', 'noa,process', 'txtProcessno_,txtProcess_', 'process_b.aspx'],
	        	['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,spec,unit', 'txtProductno_,txtProduct_,txtSpec_,txtUnit_,txtProcessno_', 'ucaucc_b.aspx']
			);
			$(document).ready(function () {
				bbmKey = ['noa'];
				bbsKey = ['noa','noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1);
			});

			//////////////////   end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0); // 1=Last  0=Top
			}  ///  end Main()
	
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea',r_picd],['txtKdate',r_picd]];
				bbsMask = [];
				q_mask(bbmMask);
				q_cmbParse("cmbMtype", '@,'+q_getPara('uca.mtype'),'s');
				q_cmbParse("cmbOrgmtype", '@,'+q_getPara('uca.mtype'),'s');
				q_cmbParse("cmbTypea", ('').concat(new Array('', '1@新增物料','2@修改物料','3@刪除物料')),'s');
				
				$('#btnUcachgDo').click(function(){
                	//var t_noa = trim($('#txtNoa').val());
					//q_func('qtxt.query.ucachg','ucachg.txt,ucachg,'+r_accy + ';' + t_noa + ';'+ r_name);
				});
				
				$('#txtProductno').change(function(){
                	//清空表身資料
					for (var i = 0; i < q_bbsCount; i++) {
						$('#btnMinus_' + i).click();
						$('#cmbTypea_' + i).val('');
						$('#cmbOrgmtype_' + i).val('');
						$('#cmbMtype_' + i).val('');
					}
				});
			}
			function q_funcPost(t_func, result) {
				switch(t_func) {
					/*case 'qtxt.query.ucachg':
						alert('作業完畢');
					break;
					case 'qtxt.query.u1':
						//呼叫workf.post
						q_func('qtxt.query.u2', 'ucachg.txt,post,' + encodeURI($('#txtNoa').val()) + ';1');//新增,修改
						break;
					case 'qtxt.query.u3':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;
					*/
				}
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				/*if(q_cur == 2)
					q_func('qtxt.query.u1', 'ucachg.txt,post,' + encodeURI($('#txtNoa').val()) + ';0');//修改
				else
					q_func('qtxt.query.u2', 'ucachg.txt,post,' + encodeURI($('#txtNoa').val()) + ';1');//新增,修改
				*/
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'ucas':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							//寫入資料
							$('#txtOrgproductno_'+b_seq).val(b_ret[0].productno);
							$('#txtOrgproduct_'+b_seq).val(b_ret[0].product);
							$('#txtOrgspec_'+b_seq).val(b_ret[0].spec);
							$('#txtOrgprocessno_'+b_seq).val(b_ret[0].processno);
							$('#txtOrgprocess_'+b_seq).val(b_ret[0].process);
							$('#txtOrgunit_'+b_seq).val(b_ret[0].unit);
							$('#txtOrgmount_'+b_seq).val(b_ret[0].mount);
							$('#cmbOrgmtype_'+b_seq).val(b_ret[0].mtype);
							$('#txtOrgloss_'+b_seq).val(b_ret[0].loss);
							$('#txtOrgdividea_'+b_seq).val(b_ret[0].dividea);
							$('#txtOrgmul_'+b_seq).val(b_ret[0].mul);
							$('#txtOrgmemo_'+b_seq).val(b_ret[0].memo);
							$('#txtUcanoq_'+b_seq).val(b_ret[0].noq);
							//紀錄當時ucas的資料
							var t_orgdata=b_ret[0].noa+'&&'+b_ret[0].noq+'&&'+b_ret[0].productno+'&&'+b_ret[0].product+'&&'
							+b_ret[0].spec+'&&'+b_ret[0].processno+'&&'+b_ret[0].process+'&&'+b_ret[0].unit+'&&'+b_ret[0].mount+'&&'
							+b_ret[0].mtype+'&&'+b_ret[0].loss+'&&'+b_ret[0].dividea+'&&'+b_ret[0].mul+'&&'+b_ret[0].memo;
							$('#txtOrgdata_'+b_seq).val(t_orgdata);
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2); ///   q_boxClose 3/4
						break;
				}
				b_pop = '';
			}
			
			function q_gtPost(t_name) { 
				switch (t_name) {
					case 'ucasnoq':
                        var as = _q_appendData("ucas", "", true);
                        if (as[0] != undefined) {
                            $('#txtOrgproductno_'+b_seq).val(as[0].productno);
							$('#txtOrgproduct_'+b_seq).val(as[0].product);
							$('#txtOrgspec_'+b_seq).val(as[0].spec);
							$('#txtOrgprocessno_'+b_seq).val(as[0].processno);
							$('#txtOrgprocess_'+b_seq).val(as[0].process);
							$('#txtOrgunit_'+b_seq).val(as[0].unit);
							$('#txtOrgmount_'+b_seq).val(as[0].mount);
							$('#cmbOrgmtype_'+b_seq).val(as[0].mtype);
							$('#txtOrgloss_'+b_seq).val(as[0].loss);
							$('#txtOrgdividea_'+b_seq).val(as[0].dividea);
							$('#txtOrgmul_'+b_seq).val(as[0].mul);
							$('#txtOrgmemo_'+b_seq).val(as[0].memo);
							$('#txtUcanoq_'+b_seq).val(as[0].noq);
							//紀錄當時ucas的資料
							var t_orgdata=as[0].noa+'&&'+as[0].noq+'&&'+as[0].productno+'&&'+as[0].product+'&&'
							+as[0].spec+'&&'+as[0].processno+'&&'+as[0].process+'&&'+as[0].unit+'&&'+as[0].mount+'&&'
							+as[0].mtype+'&&'+as[0].loss+'&&'+as[0].dividea+'&&'+as[0].mul+'&&'+as[0].memo;
							$('#txtOrgdata_'+b_seq).val(t_orgdata);
                        }else{
                        	alert(q_getMsg('lblUcanoq_s')+' '+$('#txtUcanoq_'+b_seq).val()+' 不存在!!');
                        	$('#txtOrgproductno_'+b_seq).val('');
							$('#txtOrgproduct_'+b_seq).val('');
							$('#txtOrgspec_'+b_seq).val('');
							$('#txtOrgprocessno_'+b_seq).val('');
							$('#txtOrgprocess_'+b_seq).val('');
							$('#txtOrgunit_'+b_seq).val('');
							$('#txtOrgmount_'+b_seq).val('');
							$('#cmbOrgmtype_'+b_seq).val('');
							$('#txtOrgloss_'+b_seq).val('');
							$('#txtOrgdividea_'+b_seq).val('');
							$('#txtOrgmul_'+b_seq).val('');
							$('#txtOrgmemo_'+b_seq).val('');
							$('#txtOrgdata_'+b_seq).val('');
                        	$('#txtUcanoq_'+b_seq).val('').focus();
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
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtKdate').val(q_date());
				$('#txtDatea').val(q_date()).focus();
			}
	
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				if(!emp($('#txtRev').val())){
					alert('變更單已完成變更，禁止修改!!!');
					return;
				}
				_btnModi();
				$('#txtDatea').focus();
			}
	
			function btnPrint() {
	
			}

			function btnOk() {
				var t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtProductno', q_getMsg('lblProductno')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				for(var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtUcanoq_'+i).val())){
						for(var j = i+1; j < q_bbsCount; j++) {
							if($('#txtUcanoq_'+i).val()==$('#txtUcanoq_'+j).val() && !emp($('#txtUcanoq_'+j).val())){
								t_err=$('#txtUcanoq_'+i).val();
								break;
							}
						}
					}
					if(t_err.length>0)
						break;
				}
				if (t_err.length > 0) {
					alert('項次【'+t_err+'】重複!!');
					return;
				}
				
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				var t_noa = trim($('#txtNoa').val());
				var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")   
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ucachg') + $('#txtKdate').val(), '/', ''));
				else
					wrServer(s1);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function bbsAssign() {  /// 表身運算式
				for(var i = 0; i < q_bbsCount; i++) {
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#cmbTypea_'+i).change(function() {field_change();});
						$('#txtUcanoq_' + i).change(function(){
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_err = '';
							t_err = q_chkEmpField([['txtProductno', q_getMsg('lblProductno')],['cmbTypea_'+b_seq, q_getMsg('lblTypea_s')]]);
							if (t_err.length > 0) {
								alert(t_err);
								$('#txtUcanoq_'+b_seq).val('');
								return;
							}
							var t_where = ' 1=1 ';
							var t_productno = trim($('#txtProductno').val());
							var t_noq = trim($('#txtUcanoq_'+b_seq).val());
							t_where += " and noa='"+t_productno+"' and noq='"+t_noq+"'";
							t_where = "where=^^ "+t_where+" ^^";
                        	q_gt('ucas', t_where, 0, 0, 0, "ucasnoq", r_accy);
						});
						$('#btnUcanoq_' + i).click(function(){
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_err = '';
							t_err = q_chkEmpField([['txtProductno', q_getMsg('lblProductno')],['cmbTypea_'+b_seq, q_getMsg('lblTypea_s')]]);
							if (t_err.length > 0) {
								alert(t_err);
								return;
							}
							var t_where = ' 1=1 ';
							var t_productno = trim($('#txtProductno').val());
							t_where += " and noa='"+t_productno+"'";
							q_box("ucas_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucas', "95%", "80%", q_getMsg('popUcas'));
						});
					}
				}
				_bbsAssign();
				field_change();
			}

			function bbsSave(as) {
				if(!as['typea']){
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
			}
	
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				/*if(q_cur == 0 && !emp($('#txtNoa').val()))
					$('#btnUcachgDo').removeAttr('disabled');
				else
					$('#btnUcachgDo').attr('disabled','disabled');
				*/
				for(var i = 0; i < q_bbsCount; i++) {
					$('#cmbOrgmtype_'+i).attr('disabled','disabled');
				}
				if(!t_para)
					field_change();
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
				if(!emp($('#txtRev').val())){
					alert('變更單已完成變更，禁止刪除!!!');
					return;
				}
				_btnDele();
				/*if (!confirm(mess_dele))
					return;
				q_cur = 3;
				//處理workc內容
				q_func('qtxt.query.u3', 'ucachg.txt,post,' + encodeURI($('#txtNoa').val()) + ';0');//刪除*/
			}
	
			function btnCancel() {
				_btnCancel();
			}
			function field_change() {
				for(var i = 0; i < q_bbsCount; i++) {
					if($('#cmbTypea_'+i).val()=='1'){
						$('#txtUcanoq_'+i).attr('disabled','disabled').val('');
						$('#btnUcanoq_'+i).attr('disabled','disabled');
					}else{
						$('#txtUcanoq_'+i).removeAttr('disabled');
						$('#btnUcanoq_'+i).removeAttr('disabled');
					}
					if($('#cmbTypea_'+i).val()=='3'){
						$('#txtProductno_'+i).attr('disabled','disabled').val('');
						$('#btnProductno_'+i).attr('disabled','disabled');
						$('#txtProduct_'+i).attr('disabled','disabled').val('');
						$('#txtSpec_'+i).attr('disabled','disabled').val('');
						$('#txtProcessno_'+i).attr('disabled','disabled').val('');
						$('#btnProcessno_'+i).attr('disabled','disabled');
						$('#txtProcess_'+i).attr('disabled','disabled').val('');
						$('#txtUnit_'+i).attr('disabled','disabled').val('');
						$('#txtMount_'+i).attr('disabled','disabled').val('');
						$('#cmbMtype_'+i).attr('disabled','disabled').val('');
						$('#txtLoss_'+i).attr('disabled','disabled').val('');
						$('#txtDividea_'+i).attr('disabled','disabled').val('');
						$('#txtMul_'+i).attr('disabled','disabled').val('');
						$('#txtMemo_'+i).attr('disabled','disabled').val('');
					}else{
						$('#txtProductno_'+i).removeAttr('disabled');
						$('#btnProductno_'+i).removeAttr('disabled');
						$('#txtProduct_'+i).removeAttr('disabled');
						$('#txtSpec_'+i).removeAttr('disabled');
						$('#txtProcessno_'+i).removeAttr('disabled');
						$('#btnProcessno_'+i).removeAttr('disabled');
						$('#txtProcess_'+i).removeAttr('disabled');
						$('#txtUnit_'+i).removeAttr('disabled');
						$('#txtMount_'+i).removeAttr('disabled');
						$('#cmbMtype_'+i).removeAttr('disabled');
						$('#txtLoss_'+i).removeAttr('disabled');
						$('#txtDividea_'+i).removeAttr('disabled');
						$('#txtMul_'+i).removeAttr('disabled');
						$('#txtMemo_'+i).removeAttr('disabled');
					}
				}
			}
		</script>
		<style type="text/css">
			#dmain{
				/*overflow:hidden;*/
			}
			.dview{
				float:left;
				width:25%;
			}
			.tview{
				margin:0;
				padding:2px;
				border:1px black double;
				border-spacing:0;
				font-size:16px;
				background-color:#FFFF66;
				color:blue;
			}
			.tview td{
				padding:2px;
				text-align:center;
				border:1px black solid;
			}
			.dbbm{
				float:left;
				width:70%;
				margin:-1px;
				border:1px black solid;
				border-radius:5px;
			}
			.tbbm{
				padding:0px;
				border:1px white double;
				border-spacing:0;
				border-collapse:collapse;
				font-size: medium;
				color:blue;
				background:#cad3ff;
				width:100%;
			}
			.tbbm tr{
				height:35px;
			}
			.tbbm tr td {
				margin:0px -1px;
				padding:0;
				width: 10%;
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
			.tbbm tr td .lbl.btn{
				color:#4297D7;
				font-weight:bolder;
			}
			.tbbm tr td .lbl.btn:hover{
				color:#FF8F19;
			}
			.txt {
				float:left;
			}
			.txt.c1{
				width:96%;
			}
			.num{
				text-align:right;
			}
			.tbbm tr td input[type="text"]{
				border-width:1px;
				padding:0px;
				margin:-1px;
			}
			.dbbs {
				float:left;
				width: 1640px;
			}
			.tbbs {
				width:100%;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
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
			<div class="dview" id="dview" style="float: left;  width:25%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk' class="lbl"> </a></td>
						<td align="center" style="width:40%"><a id='vewProductno' class="lbl"> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea' class="lbl"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
						<td align="center" id='productno'>~productno</td>
						<td align="center" id='datea'>~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing=''>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblKdate" class="lbl"> </a></td>
						<td><input id="txtKdate"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProductno' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtProductno"  type="text" class="txt" style="width:30%;"/>
							<input id="txtProduct"  type="text" class="txt" style="width:68%;"/>
						</td>
						<td><span> </span><a id="lblRev" class="lbl"> </a></td>
						<td><input id="txtRev"  type="text"  class="txt c1"/></td>
					</tr>  
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text" class="txt" style="width: 98%;" /></td>
						<!--<td><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td><input id="txtApv"  type="text"  class="txt c1"/></td>-->
						<!--<td><input id="btnUcachgDo"  type="button"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
					</tr>
				</table>
	        </div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
					<tr style='color:White; background:#003366;' >
						<td align="center" style="width:1%;"><input class="txt btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
						<td align="center" style="width:6.5%;"><a id='lblTypea_s'> </a></td>
						<td align="center" style="width:5%;"><a id='lblUcanoq_s'> </a></td>
						<td align="center" style="width:10%;"><a id='lblOrgproductno_s'> </a><br><a id='lblProductno_s'> </a></td>
						<td align="center" style="width:10%;"><a id='lblOrgproduct_s'> </a><br><a id='lblProduct_s'> </a></td>
						<td align="center" style="width:10%;"><a id='lblOrgspec_s'> </a><br><a id='lblSpec_s'> </a></td>
						<td align="center" style="width:10%;"><a id='lblOrgprocessno_s'> </a><br><a id='lblProcessno_s'> </a></td>
						<td align="center" style="width:10%;"><a id='lblOrgprocess_s'> </a><br><a id='lblProcess_s'> </a></td>
						<td align="center" style="width:4%;"><a id='lblOrgunit_s'> </a><br><a id='lblUnit_s'> </a></td>
						<td align="center" style="width:5%;"><a id='lblOrgmount_s'> </a><br><a id='lblMount_s'> </a></td>
						<td align="center" style="width:6.5%;"><a id='lblOrgmtype_s'> </a><br><a id='lblMtype_s'> </a></td>
						<td align="center" style="width:5%;"><a id='lblOrgloss_s'> </a><br><a id='lblLoss_s'> </a></td>
						<td align="center" style="width:5%;"><a id='lblOrgdividea_s'> </a><br><a id='lblDividea_s'> </a></td>
						<td align="center" style="width:5%;"><a id='lblOrgmul_s'> </a><br><a id='lblMul_s'> </a></td>
						<td align="center" ><a id='lblOrgmemo_s'> </a><br><a id='lblMemo_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
						<td><select id="cmbTypea.*" class="txt c1"> </select></td>
						<td>
							<input id="txtUcanoq.*" type="text" class="txt c1" style="width: 65%;"/>
							<input class="btn" id="btnUcanoq.*" type="button" value='.' style=" font-weight: bold;" />
						</td>
						<td>
							<input id="txtOrgproductno.*" type="text" class="txt c1"/>
							<input id="txtProductno.*" type="text" class="txt" style="width: 83%;"/>
							<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
						</td>
						<td>
							<input id="txtOrgproduct.*" type="text" class="txt c1"/>
							<input id="txtProduct.*" type="text" class="txt c1"/>
						</td>
						<td>
							<input id="txtOrgspec.*" type="text" class="txt c1"/>
							<input id="txtSpec.*" type="text" class="txt c1"/>
						</td>
						<td>
							<input id="txtOrgprocessno.*" type="text" class="txt c1"/>
							<input id="txtProcessno.*" type="text" class="txt" style="width: 83%;"/>
							<input class="btn" id="btnProcessno.*" type="button" value='.' style=" font-weight: bold;" />
						</td>
						<td>
							<input id="txtOrgprocess.*" type="text" class="txt c1"/>
							<input id="txtProcess.*" type="text" class="txt c1"/>
						</td>
						<td>
							<input id="txtOrgunit.*" type="text" class="txt c1"/>
							<input id="txtUnit.*" type="text" class="txt c1"/>
						</td>
						<td>
							<input id="txtOrgmount.*" type="text" class="txt num c1" />
							<input id="txtMount.*" type="text" class="txt num c1" />
						</td>
						<td>
							<select id="cmbOrgmtype.*" class="txt c1"> </select>
							<select id="cmbMtype.*" class="txt c1"> </select>
						</td>
						<td>
							<input id="txtOrgloss.*" type="text" class="txt num c1" />
							<input id="txtLoss.*" type="text" class="txt num c1" />
						</td>
						<td>
							<input id="txtOrgdividea.*" type="text" class="txt num c1" />
							<input id="txtDividea.*" type="text" class="txt num c1" />
						</td>
						<td>
							<input id="txtOrgmul.*" type="text" class="txt num c1" />
							<input id="txtMul.*" type="text" class="txt num c1" />
						</td>
						<td>
							<input id="txtOrgmemo.*" type="text" class="txt c1"/>
							<input id="txtMemo.*" type="text" class="txt c1"/>
							<input id="txtOrgdata.*" type="hidden"/>
							<input id="txtNoq.*" type="hidden" />
							<input id="recno.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>