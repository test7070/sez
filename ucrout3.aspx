<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
			var q_name = "ucrout3";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 8;
			q_copy=1;
			aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtComp,txtNick', 'tgg_b.aspx'],
				['txtProductno', 'lblProductno', 'ucr2', 'noa,product,unit', 'txtProductno,txtProduct,txtUnit', 'ucr2_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,spec,unit', 'txtProductno_,txtProduct_,txtSpec_,txtUnit_', 'ucc_b.aspx']
			);

			$(document).ready(function() {
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
				q_mask(bbmMask);
				mainForm(0);
				$('#txtNoa').focus();
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea',r_picd]]
            	bbmNum = [['txtMount', 15, q_getPara('rc2.mountPrecision'), 1]];//, ['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1]
            	bbsNum = [['txtMount', 15, q_getPara('rc2.mountPrecision'), 1], ['txtWeight', 15, q_getPara('rc2.weightPrecision'), 1]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('ucrout3.typea'));
				
				$('#btnUcr2s').click(function() {
					if((q_cur==1 || q_cur==2) && !emp($('#txtProductno').val())){
						q_gt('ucr2', "where=^^noa='" + $('#txtProductno').val() + "'^^", 0, 0, 0, "getucr2s",1);
						var as = _q_appendData("ucr2", "", true);
                        if (as[0] != undefined) {
                        	var ass = _q_appendData("ucr2s", "", true);
                        	if (ass[0] != undefined) {
                        		for (var i = 0; i < ass.length; i++) {
                        			ass[i].mount=round(q_add(q_mul(dec(ass[i].mount),dec($('#txtMount').val())),q_div(q_mul(q_mul(dec(ass[i].mount),dec($('#txtMount').val())),dec(ass[i].loss)),100)),q_getPara('vcc.mountPrecision'));
                        			ass[i].weight=round(q_add(q_mul(dec(ass[i].weight),dec($('#txtWeight').val())),q_div(q_mul(q_mul(dec(ass[i].weight),dec($('#txtWeight').val())),dec(ass[i].loss)),100)),q_getPara('vcc.weightPrecision'));
                        		}
                        		for (var j = 0; j < q_bbsCount; j++) {
                        			$('#btnMinus_'+j).click();
                        		}
                        		q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtMount,txtWeight', ass.length, ass
	                        	, 'productno,product,spec,unit,mount,weight','');
                        		
                        	}else{
                        		alert('No data !!');
                        	}
                        }else{
                        	alert(q_getMsg('lblProductno')+' error !!');
                        }
					}
				});
				
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
					case q_name:
						if (q_cur == 4){
							q_Seek_gtPost();
						}
						break;
				}
			}

			function btnOk() {
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')], ['txtTggno', q_getMsg('lblTgg')], ['txtCno', q_getMsg('lblAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
					
				//sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ucrout3') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ucrout3_s.aspx', q_name + '_s', "500px", "350px", $('#btnSeek').val());
			}
			
			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						
						$('#btnMinus_'+j).bind('contextmenu',function(e) {
							e.preventDefault();
	                    	if(e.button==2){
								////////////控制顯示位置
								$('#div_row').css('top', e.pageY);
								$('#div_row').css('left', e.pageX);
								//////////////
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$('#div_row').show();
								//顯示選單
								row_b_seq = b_seq;
								//儲存選取的row
								row_bbsbbt = 'bbs';
								//儲存要新增的地方
							}
                    	});
						
					}
				}
				_bbsAssign();
			}

			var assm_row = 0;
			function q_funcPost(t_func, result) {
				switch(t_func) {
					
				}
			};

			function btnIns() {
				_btnIns();
				 $('#txtNoa').val('AUTO');
                $('#txtDatea').focus();
                $('#txtDatea').val(q_date());
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				 $('#txtDatea').focus();
			}

			function btnPrint() {
				//q_box("z_ucroutp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "' and product='" + $('#txtProduct').val() + "';" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				t_err = '';
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				if (t_err) {
					alert(t_err);
					return false;
				}

				return true;
			}

			function sum() {

			}
			
			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
				} else {
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}

			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
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
				width: 30%;
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
				width: 68%;
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
				/*width: 9%;*/
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
			.txt.c5 {
				width: 75%;
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
				/*float: left;*/
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbs select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbs a {
				font-size: medium;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
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
				width: 1415px;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
			
			#div_row {
				display: none;
				width: 750px;
				background-color: #ffffff;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
			.table_row tr td .lbl.btn {
				color: #000000;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
			.table_row tr td .lbl.btn:hover {
				color: #FF8F19;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id='dmain' style="overflow:hidden; width: 1260px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left; width:400px;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:40px"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px"><a id='vewDatea'> </a></td>
						<td align="center" style="width:150px"><a id='vewNoa'> </a></td>
						<td align="center" style="width:210px"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 850px;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0' >
					<tr style="height: 1px;">
						<td style="width: 100px;"> </td>
						<td style="width: 160px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 160px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 160px;"> </td>
						<td style="width: 20px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1" style="font-size: medium;"> </select></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td><input id="txtTggno" type="text" class="txt c1" /></td>
						<td colspan="4">
							<input id="txtComp" type="text" class="txt c1"/>
							<input id="txtNick" type="hidden" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProductno' class="lbl btn"> </a></td>
						<td><input id="txtProductno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblProduct' class="lbl"> </a></td>
						<td colspan="3"><input id="txtProduct" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUnit' class="lbl"> </a></td>
						<td><input id="txtUnit" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt num c1" /></td>
						<!--<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt num c1" /></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='5'><input id="txtMemo" type="text" class="txt c1" style="width: 99%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="btnUcr2s" type="button" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1260px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" /></td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:180px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblSpec_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:280px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;float: left;" />
						<input id="txtProductno.*" type="text" class="txt c1" style="width: 83%;"/>
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtSpec.*" type="text" class="txt c1" /></td>
					<td><input id="txtUnit.*" type="text" class="txt c1" /></td>
					<td><input id="txtMount.*" type="text" class="txt num c1" /></td>
					<td><input id="txtWeight.*" type="text" class="txt num c1" /></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>