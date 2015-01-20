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
			var q_name = "shiporder";
			var q_readonly = [];
			var q_readonlys = ['txtInvono','txtCustno','txtComp','txtVccno'];
			var bbmNum = [];
			var bbsNum = [['txtWeight', 15, 2, 1],['txtCuft', 15, 2, 1],['txtMount', 15, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
					['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
		 			['txtCno','lblCno','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],
		 			['txtTranno','lblTranno','tgg','noa,comp','txtTranno,txtTrancomp','tgg_b.aspx'],
					['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx'],
					['txtVcceno_', '', 'vcce', 'noa,custno,comp', 'txtVcceno_,txtCustno_,txtComp_', '']
			);
			$(document).ready(function () {
				bbmKey = ['noa'];
				bbsKey = ['noa','noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)
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
                bbmMask = [['txtDatea',r_picd]];
                q_mask(bbmMask);
                
                
                $('#txtNoa').change(function() {
					t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                	q_gt('shiporder', t_where, 0, 0, 0, "check_Noa", r_accy);
				});
				
			}

			function q_boxClose(s2) { ///   q_boxClose 2/4 
				var ret;
				switch (b_pop) { 
					case q_name + '_s':
						  q_boxClose2(s2); ///   q_boxClose 3/4
						  break;
				}   /// end Switch
			}
			
			function refreshBbm(){
				if(q_cur==1){
	            	$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
	            }else{
	            	$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
	            }
			}
			function q_gtPost(t_name) { 
				switch (t_name) {
					case 'invo':
						var as = _q_appendData("invo", "", true);
						if(as[0] != undefined)
							$('#txtInvono_'+b_seq).val(as[0].noa);
						break;
					case 'packing':
						var as = _q_appendData("packing", "", true);
						var t_weight=0,t_cuft=0,mount=0;
						for( i = 0; i < as.length; i++) {
							t_weight+=dec(as[i].gweight);
							t_cuft+=dec(as[i].cuft);
							mount+=dec(as[i].mount);
						}
							q_tr('txtWeight_'+b_seq,t_weight);
							q_tr('txtCuft_'+b_seq,t_cuft);
							q_tr('txtMount_'+b_seq,mount);
						break;
					case 'check_Noa':
                		var as = _q_appendData("shiporder", "", true);
                        if (as[0] != undefined){
                        	alert(q_getMsg('lblNoa')+'已存在!!');
                            return;
                        }
                		break;
                	case 'check_btnOk':
                		var as = _q_appendData("shiporder", "", true);
                        if (as[0] != undefined){
                        	alert(q_getMsg('lblNoa')+'已存在!!');
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
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
				refreshBbm();
				$('#txtDatea').val(q_date());
				$('#btnInvo').attr('disabled','disabled');
				$('#btnPack').attr('disabled','disabled');
				$('#txtNoa').focus();
			}
	
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				refreshBbm();
			}
	
			function btnPrint() {
	
			}
			
			function bbsSave(as) {
				if (!as['vcceno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();     
				return true;
			}
			
			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {	
						$('#txtVcceno_' + j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
		                    
		                    var t_where="where=^^ vcceno='"+$('#txtVcceno_'+b_seq).val()+"'^^";
                			q_gt('invo', t_where, 0, 0, 0, "", r_accy);
                			t_where="where=^^ noa='"+$('#txtVcceno_'+b_seq).val()+"'^^";
                			q_gt('packing', t_where, 0, 0, 0, "", r_accy);
						});
					}
				}
				_bbsAssign();
			}
			

			function btnOk() {
				var t_err = '';
	
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);

				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				if(q_cur==1){
					t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                	q_gt('shiporder', t_where, 0, 0, 0, "check_btnOk", r_accy);
				}else
					wrServer($('#txtNoa').val());
			}
	
			function wrServer(key_value) {
				var i;
	
				xmlSql = '';
				if (q_cur == 2) 
					xmlSql = q_preXml();
	
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
	
			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
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
				_btnDele();
			}
	
			function btnCancel() {
				_btnCancel();
			}
			
			function sum() {
	            var t1 = 0, t_unit, t_mount, t_weight = 0;
	            for (var j = 0; j < q_bbsCount; j++) {
	            }  // j
	        }
	        function q_popPost(s1) {
		    	switch (s1) {
			        case 'txtVcceno_':
		    			var t_where="where=^^ vcceno='"+$('#txtVcceno_'+b_seq).val()+"'^^";
                		q_gt('invo', t_where, 0, 0, 0, "", r_accy);
                		t_where="where=^^ noa='"+$('#txtVcceno_'+b_seq).val()+"'^^";
                		q_gt('packing', t_where, 0, 0, 0, "", r_accy);
			        break;
		    	}
			}
	</script>
	<style type="text/css">
		#dmain{
			overflow:hidden;
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
			.tbbm tr td{
				width: 9%;
			}
			.tbbm .tdZ {
				width: 3%;
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
		.txt.c1{
			width:98%;
			float:left;
		}
		.txt.c2{
			width:35%;
			float:left;
		}
		.txt.c3{
			width:63%;
			float:left;
		}
		.txt.c4{
			width:30%;
			float:left;
		}
		.txt.c5{
			width:55%;
			float:left;
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
			.tbbm td input[type="button"] {
				float: left;
				width: auto;
			}
			.tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
			.dbbs {
				width: 100%;
			}
			.tbbs a {
				font-size: medium;
			}

			.num {
				text-align: right;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		.tbbs
		{
			FONT-SIZE: medium;
			COLOR: blue ;
			TEXT-ALIGN: left;
			 BORDER:1PX LIGHTGREY SOLID;
			 width:100% ; height:98% ;  
		}  
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
	<div id='dmain' style="overflow:hidden;">
		<div class="dview" id="dview" style="float: left;  width:25%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk' class="lbl"> </a></td>
					<td align="center" style="width:25%"><a id='vewNoa' class="lbl"> </a></td>
					<td align="center" style="width:40%"><a id='vewTrancomp' class="lbl"> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='trancomp'>~trancomp</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr class="tr1">
					<td class="td1" ><span> </span><a id='lblNoa' class="lbl"> </a></td>
					<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblDatea" class="lbl"> </a></td>
					<td class="td4"><input id="txtDatea" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr2">
					<td class="td1"><span> </span><a id="lblTranno" class="lbl btn"> </a></td>
            		<td class="td2">
            			<input id="txtTranno" type="text" class="txt c2" />
            			<input id="txtTrancomp" type="text" class="txt c3" />
            		</td>
					<td class="td3"><span> </span><a id="lblShip" class="lbl"> </a></td>
            		<td class="td4"><input id="txtShip" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr3">
					<td class="td1"><span> </span><a id="lblBoatname" class="lbl"> </a></td>
					<td class="td2"><input id="txtBoatname" type="text" class="txt c1" /></td>
            		<td class="td3"><span> </span><a id="lblSize" class="lbl"> </a></td>
            		<td class="td4"><input id="txtSize" type="text" class="txt c1" /></td>
            		<td class="td5"><span> </span><a id="lblCaseyard" class="lbl"> </a></td>
            		<td class="td6"><input id="txtCaseyard" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr4">
					<td class="td1"><span> </span><a id='lblCno' class="lbl btn"> </a></td>
					<td class="td2" colspan="3">
						<input id="txtCno"  type="text" class="txt c2" />
						<input id="txtAcomp"  type="text" class="txt c3" />
					</td>
					<td class="td5"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
            		<td class="td6">
            			<input id="txtSalesno" type="text" class="txt c2" />
            			<input id="txtSales" type="text" class="txt c3" />
            		</td>
				</tr>
				<tr class="tr5">
					<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
					<td class="td2" colspan="5"><textarea id="txtMemo"  style="width:95%; height: 60px;"> </textarea></td>
				</tr>
			</table>
        </div>
	</div>
	<div class='dbbs'>
		<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' >
			<tr style='color:white; background:#003366;' >
				<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
				</td>
				<td align="center" style="width:9%;"><a id='lblVcceno_s'> </a></td>
				<td align="center" style="width:9%;"><a id='lblInvono_s'> </a></td>
				<td align="center" style="width:18%;"><a id='lblCust_s'> </a></td>
				<td align="center" style="width:8%;"><a id='lblWeight_s'> </a></td>
				<td align="center" style="width:8%;"><a id='lblCuft_s'> </a></td>
				<td align="center" style="width:8%;"><a id='lblMount_s'> </a></td>
				<td align="center" ><a id='lblMemo_s'> </a></td>
				<td align="center" style="width:9%;"><a id='lblVccno_s'> </a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
				</td>
				<td><input id="txtVcceno.*"  type="text"  class="txt c1"/></td>
				<td><input id="txtInvono.*"  type="text"  class="txt c1"/></td>
				<td>
					<input id="txtCustno.*"  type="text"  class="txt c4"/>
					<!--<input class="btn"  id="btnCustno.*" type="button" value='.' style="width:1%;font-weight: bold;" />-->
					<input id="txtComp.*"  type="text"  class="txt c5"/>
				</td>
				<td><input id="txtWeight.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtCuft.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtMount.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtMemo.*"  type="text"  class="txt c1"/></td>
				<td><input id="txtVccno.*"  type="text"  class="txt c1"/></td>
			</tr>
		</table>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>