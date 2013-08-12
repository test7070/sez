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
			var q_name = "invo";
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [['txtTotal', 15, 0, 1],['txtMoney', 15, 0, 1],['txtTax', 15, 0, 1],['txtFloata', 15, 2, 1],['txtTotalus', 15, 0, 1]];
			var bbsNum = [['txtQuantity', 15, 2, 1],['txtPrice', 15, 2, 1],['txtAmount', 15, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(
				['txtOrdeno', '', 'orde', 'noa,comp,addr2,taxtype', 'txtOrdeno,txtComp,txtAddr,cmbTaxtype', '']
				//['txtOrdeno', '', 'orde', 'noa,comp,addr2,taxtype,tax,money,total,coin,floata,totalus', 'txtOrdeno,txtComp,txtAddr,cmbTaxtype,txtTax,txtMoney,txtTotal,cmbCoin,txtFloata,txtTotalus', '']				
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
                bbmMask = [['txtDatea',r_picd],['txtClosing',r_picd],['txtEtd',r_picd],['txtEta',r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('invo.typea'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                $('#btnInvo').click(function(){
                	t_where = '';
                	t_noa = $('#txtNoa').val();
                	if(t_noa.length > 0){
                		t_where = "noa='" + t_noa + "'";
                		q_box("invo_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('popInvo'));
                	}
                });
                /*$('#btnPack').click(function(){
                	t_where = '';
                	t_noa = $('#txtNoa').val();
                	if(t_noa.length > 0){
                		t_where = "noa='" + t_noa + "'";
                		q_box("packing_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack', "95%", "95%", q_getMsg('popPack'));
                	}
                });*/
                
                $('#txtNoa').change(function() {
					t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                	q_gt('invo', t_where, 0, 0, 0, "check_Noa", r_accy);
				});
				
				$('#lblOrdeno').click(function(){
					var ordeno = $('#txtOrdeno').val();
					var t_where = ' 1=1 ';
					if(ordeno.length > 0)
						t_where += " and noa='" + ordeno + "'";
						q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'orde', "95%", "95%", q_getMsg('popOrde'));
				});
				$('#txtFloata').change(function () {sum2();});
				$('#txtTotal').change(function () {sum2();});
			}

			function q_boxClose(s2) { ///   q_boxClose 2/4 
				var ret;
				switch (b_pop) { 
					case 'orde':
						if (q_cur > 0 && q_cur < 4) {
							if (!b_ret || b_ret.length == 0)
								return;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtItemno,txtDescription,txtUnit,txtQuantity,txtPrice,txtAmount', b_ret.length, b_ret,
													 'productno,product,unit,mount,price,total','txtDescription');   /// 最後 aEmpField 不可以有【數字欄位】
							sum()
						}
						break;  
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
					case 'check_Noa':
                		var as = _q_appendData("invo", "", true);
                        if (as[0] != undefined){
                        	alert(q_getMsg('lblNoa')+'已存在!!');
                            return;
                        }
                		break;
                	case 'check_btnOk':
                		var as = _q_appendData("invo", "", true);
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
				if (!as['description']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();     
				return true;
			}
			
			
			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {	
						$('#txtQuantity_' + j).change(function () {sum()});
						$('#txtPrice_' + j).change(function () {sum()});	 
						$('#txtAmount_' + j).change(function () {sum2()});	 
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
				
				if(window.parent.q_name=='vcce'){
						 var wParent = window.parent.document;
						 var t_vcceno= wParent.getElementById("txtNoa").value;
						 $('#txtVcceno').val(t_vcceno);
				}
				
				if(q_cur==1){
					t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                	q_gt('invo', t_where, 0, 0, 0, "check_btnOk", r_accy);
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
				$('#btnInvo').removeAttr('disabled');
				$('#btnPack').removeAttr('disabled');
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
				$('#btnInvo').removeAttr('disabled');
				$('#btnPack').removeAttr('disabled');
			}
			
			function sum() {
	            var t1 = 0, t_unit, t_mount, t_weight = 0;
	            for (var j = 0; j < q_bbsCount; j++) {
	                t_mount = $('#txtQuantity_' + j).val();  // 計價量
					q_tr('txtAmount_'+j ,round(dec($('#txtPrice_' + j).val()) * dec( t_mount), 0));
	                t1 = t1 + dec($('#txtAmount_' + j).val());
	            }  // j
	
	            $('#txtMoney').val(round(t1, 0));
	            calTax();
	            q_tr('txtTotalus',q_float('txtTotal')*q_float('txtFloata'));
	        }
	        
	        function sum2() {
	            var t1 = 0, t_unit, t_mount, t_weight = 0;
	            for (var j = 0; j < q_bbsCount; j++) {
	                t1 = t1 + dec($('#txtAmount_' + j).val());
	            }  // j
	
	            $('#txtMoney').val(round(t1, 0));
	            calTax();
	            q_tr('txtTotalus',q_float('txtTotal')*q_float('txtFloata'));
	        }
	</script>
	<style type="text/css">
		#dmain{
			overflow:hidden;
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
		.tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
		.txt.c1{
			width:95%;
			float:left;
		}
		.txt.c2{
			width:45%;
			float:left;
		}
		.num{
			text-align:right;
		}
		.tbbm tr td input[type="text"]{
			border-width:1px;
			padding:0px;
			margin:-1px;
		}
		input[type="text"], input[type="button"] {
			font-size: medium;
		}
		.dbbs {
			width: 100%;
		}
		.tbbs a {
			font-size: medium;
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
					<td align="center" style="width:40%"><a id='vewVccno' class="lbl"> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='vccno'>~vccno</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing=''>
				<tr class="tr1">
					<td class="td1" ><span> </span><a id='lblNoa' class="lbl"> </a></td>
					<td class="td2">
						<input id="txtNoa"  type="text"  class="txt c1"/>
						<input id="txtVcceno" type="hidden" class="txt c1" />
					</td>
					<td class="td3"><span> </span><a id="lblDatea" class="lbl"> </a></td>
					<td class="td4"><input id="txtDatea" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr1">
					<td class="td1"><span> </span><a id="lblVat" class="lbl"> </a></td>
					<td class="td2"><input id="txtVat" type="text" class="txt c1" /></td>
					<td class="td3"><span> </span><a id="lblTypea" class="lbl"> </a></td>
            		<td class="td4"><select id="cmbTypea" class="txt c1"> </select></td>
				</tr>
				<tr class="tr1">
					<td class="td1"><span> </span><a id="lblVccno" class="lbl"> </a></td>
					<td class="td2"><input id="txtVccno" type="text" class="txt c1" /></td>
					<td class="td3"><span> </span><a id="lblOrdeno" class="lbl btn"> </a></td>
            		<td class="td4"><input id="txtOrdeno" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr2">
					<td class="td1"><span> </span><a id='lblComp' class="lbl"> </a></td>
					<td class="td2" colspan="3"><input id="txtComp"  type="text" class="txt c1" /></td>
				</tr>  
				<tr class="tr3">
					<td class="td1"><span> </span><a id='lblAddress' class="lbl"> </a></td>
					<td class="td2" colspan="3"><input id="txtAddr"  type="text" class="txt c1" /></td>
				</tr>
				<!--<tr class="tr4">
					<td class="td1"><span> </span><a id='lblShipped' class="lbl"> </a></td>
					<td class="td2"><input id="txtShipped"  type="text" class="txt c1" /></td>
					<td class="td3"><span> </span><a id='lblClosing' class="lbl"> </a></td>
					<td class="td4"><input id="txtClosing"  type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr4">
					<td class="td1"><span> </span><a id='lblCommodity'> </a></td>
         			<td class="td2" colspan="2"><input id="txtCommodity"  type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr5">
					<td class="td1" ><span> </span><a id='lblFroma' class="lbl"> </a></td>
					<td class="td2" colspan="3"><input id="txtFroma"  type="text"  class="txt c1"/></td>
				</tr>                               
				<tr class="tr6">
					<td class="td1" ><span> </span><a id='lblToa' class="lbl"> </a></td>
					<td class="td2" colspan="3"><input id="txtToa"  type="text"  class="txt c1"/></td>
				</tr>                               
				<tr class="tr7">
					<td class="td1" ><span> </span><a id='lblEtd' class="lbl"> </a></td>
					<td class="td2"><input id="txtEtd"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblEta" class="lbl"> </a></td>
					<td class="td4"><input id="txtEta" type="text" class="txt c1" /></td>
				</tr>
			
		       <tr class="tr8">
					<td class="td1" ><span> </span><a id='lblPno' class="lbl"> </a></td>
					<td class="td2"><input id="txtPno"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblCno" class="lbl"> </a></td>
					<td class="td4"><input id="txtCno" type="text" class="txt c1" /></td>
					<td class="td5"><span> </span><a id="lblLcno" class="lbl"> </a></td>
					<td class="td6"><input id="txtLcno" type="text" class="txt c1" /></td>
				</tr>-->
				<tr class="tr1">
					<td class="td1"><span> </span><a id="lblTaxtype" class="lbl"> </a></td>
            		<td class="td2"><select id="cmbTaxtype" class="txt c1" onchange='calTax()'> </select></td>
            		<td class="td1"><span> </span><a id="lblTax" class="lbl"> </a></td>
					<td class="td2"><input id="txtTax" type="text" class="txt num c1" /></td>
				</tr>
				<tr class="tr8">
					<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
                	<td class="td2"><input id="txtMoney" type="text" class="txt num c1"/></td> 
					<td class="td1"><span> </span><a id="lblTotal" class="lbl"> </a></td>
					<td class="td2"><input id="txtTotal" type="text" class="txt c1 num" /></td>
				</tr> 
				<tr class="tr8">
					<td class="td1"><span> </span><a id='lblFloata' class="lbl"> </a></td>
					<td class="td2"><select id="cmbCoin"class="txt c2"> </select><input id="txtFloata" type="text" class="txt num c2" /></td>                 
					<td class="td3"><span> </span><a id='lblTotalus' class="lbl"></a></td>
                	<td class="td4" ><input id="txtTotalus" type="text" class="txt num c1"/></td> 
				</tr> 
				<tr class="tr10">
					<td class="td1"><span> </span><a id='lblTitle' class="lbl"> </a></td>
					<td class="td2" colspan="5"><input id="txtTitle"  type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr11">
					<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
					<td class="td2" colspan="5"><textarea id="txtMemo"  style="width:95%; height: 60px;"> </textarea></td>
				</tr>
			</table>
        </div>
	</div>
	<div class='dbbs'>
		<table id="tbbs" class='tbbs'>
			<tr style='color:white; background:#003366;' >
				<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
				</td>
				<td align="center" style="width:5%;"><a id='lblItemno_s'></a></td>
				<td align="center" style="width:5%;"><a id='lblDescription_s'></a></td>
				<td align="center" style="width:2%;"><a id='lblUnit_s'></a></td>
				<td align="center" style="width:5%;"><a id='lblQuantity_s'></a></td>
				<td align="center" style="width:5%;"><a id='lblPrice_s'></a></td>
				<td align="center" style="width:5%;"><a id='lblAmount_s'></a></td>
				<td align="center" style="width:5%;"><a id='lblMemo_s'></a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
				</td>
				<td><input id="txtItemno.*"  type="text"  class="txt c1"/></td>
				<td><input id="txtDescription.*"  type="text"  class="txt c1"/></td>
				<td><input id="txtUnit.*"  type="text"  class="txt c1"/></td>
				<td><input id="txtQuantity.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtPrice.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtAmount.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtMemo.*"  type="text"  class="txt c1"/></td>
			</tr>
		</table>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>