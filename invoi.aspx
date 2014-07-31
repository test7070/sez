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
			var q_name = "invoi";
			var q_readonly = ['txtTotal','txtAmount'];
			var q_readonlys = [];
			var bbmNum = [['txtTotal', 15, 3, 1],['txtAmount', 15, 2, 1],['txtFloata', 15, 4, 1]];
			var bbsNum = [['txtQuantity', 15, 3, 1],['txtPrice', 15, 2, 1],['txtWeight', 15, 2, 1],['txtAmount', 15, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp,addr_home', 'txtTggno,txtTgg,txtAddr', 'tgg_b.aspx']
			,['txtCno', 'lblCno', 'acomp', 'noa,acomp,ename', 'txtCno','acomp_b.aspx']
			,['txtProductno_', 'btnProductno_', 'ucc', 'noa,engpro,unit', 'txtProductno_,txtDescription_,txtUnit_,txtMarks_', 'ucc_b.aspx']);
			
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
                bbmMask = [['txtDatea','9999/99/99'],['txtEtd','9999/99/99'],['txtEta','9999/99/99']];
                q_mask(bbmMask);
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                
                $('#btnPack').click(function(){
                	t_where = '';
                	t_noa = $('#txtNoa').val();
                	if(t_noa.length > 0){
                		t_where = "noa='" + t_noa + "'";
                		q_box("packingi_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack', "95%", "95%", $('#btnPack').val());
                	}
                });
                
                $('#txtNoa').change(function() {
					t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                	q_gt('invoi', t_where, 0, 0, 0, "check_Noa", r_accy);
				});
				
				$('#txtRc2no').click(function() {
					t_where = '';
                	t_noa = $('#txtRc2no').val();
                	if(t_noa.length > 0 && q_cur!=1 &&q_cur!=2 ){
                		t_where = "noa='" + t_noa + "'";
                		q_box("rc2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+(dec($('#txtDatea').val().substr(0,4))-1911), 'rc2', "95%", "95%",'');
                	}
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
					case 'check_Noa':
                		var as = _q_appendData("invoi", "", true);
                        if (as[0] != undefined){
                        	alert(q_getMsg('lblNoa')+'已存在!!');
                            return;
                        }
                		break;
                	case 'check_btnOk':
                		var as = _q_appendData("invoi", "", true);
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
				q_box('invoi_s.aspx', q_name + '_s', "500px", "500px", $('#btnSeek').val());
			}

			function btnIns() {
				_btnIns();
				refreshBbm();
				var t_date,t_year,t_month,t_day;
				t_date = new Date();
				t_year = t_date.getUTCFullYear();
				t_month = t_date.getUTCMonth()+1;
				t_month = t_month>9?t_month+'':'0'+t_month;
				t_day = t_date.getUTCDate();
				t_day = t_day>9?t_day+'':'0'+t_day;
				$('#txtDatea').val(t_year+'/'+t_month+'/'+t_day);
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
				q_box('z_invoi.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", $('#btnPrint').val());
			}
			
			function bbsSave(as) {
				if (!as['description']&&!as['marks']) {
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
						$('#txtAmount_' + j).change(function () {sum()});
					}
				}
				_bbsAssign();
			}

			function btnOk() {
				var t_err = '';
	
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')]]);

				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				sum();
				if(q_cur==1){
					t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                	q_gt('invoi', t_where, 0, 0, 0, "check_btnOk", r_accy);
				}else
					wrServer($('#txtNoa').val());
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				if(q_cur != 2)
					q_func('qtxt.query.u2', 'invoi.txt,post,' + encodeURI($('#txtNoa').val()) + ';1;'+q_getPara('sys.key_rc2')+';'+q_getPara('rc2.pricePrecision')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat'));//新增,修改
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.u1':
						//呼叫workf.post
						q_func('qtxt.query.u2', 'invoi.txt,post,' + encodeURI($('#txtNoa').val()) + ';1;'+q_getPara('sys.key_rc2')+';'+q_getPara('rc2.pricePrecision')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat'));//新增,修改
						break;
					case 'qtxt.query.u2':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['rc2no'] = as[0].rc2no;
							$('#txtRc2no').val(as[0].rc2no);
							
							if(as[0].rc2no.length>0){
								q_func('rc2_post.post' ,(dec($('#txtDatea').val().substr(0,4))-1911)+','+as[0].rc2no+',0');
								q_func('rc2_post.post' ,(dec($('#txtDatea').val().substr(0,4))-1911)+','+as[0].rc2no+',1');
							}
						}
						break;
					case 'qtxt.query.u3':
						if($('#txtRc2no').val().length>0){
							q_func('rc2_post.post' ,(dec($('#txtDatea').val().substr(0,4))-1911)+','+$('#txtRc2no').val()+',0');
						}
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;
				}
			}
	
			function wrServer(key_value) {
				var i;
	
				xmlSql = '';
				if (q_cur == 2) 
					xmlSql = q_preXml();
					
				if(q_cur == 2)
					q_func('qtxt.query.u1', 'invoi.txt,post,' + encodeURI($('#txtNoa').val()) + ';0;'+q_getPara('sys.key_rc2')+';'+q_getPara('rc2.pricePrecision')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat'));
	
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
				
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
				//_btnDele();
				
				if (!confirm(mess_dele))
					return;
				q_cur = 3;
				q_func('qtxt.query.u3', 'invoi.txt,post,' + encodeURI($('#txtNoa').val()) + ';0;'+q_getPara('sys.key_rc2')+';'+q_getPara('rc2.pricePrecision')+';'+r_userno+';'+r_name+';'+q_getPara('sys.dateformat'));//刪除				
			}
	
			function btnCancel() {
				_btnCancel();
				$('#btnPack').removeAttr('disabled');
			}
			
			function sum() {
	            var t1 = 0,t2=0, t_unit, t_mount, t_weight = 0;
	            for (var j = 0; j < q_bbsCount; j++) {
	                t_mount = dec($('#txtQuantity_' + j).val());  // 計價量
	                t2=q_add(t2,t_mount);
					q_tr('txtAmount_'+j ,round(q_mul(dec($('#txtPrice_' + j).val()),dec( t_mount)), 2));
	                t1 = q_add(t1 , dec($('#txtAmount_' + j).val()));
	            }  // j
	
	            $('#txtTotal').val(round(t2, 2));
	            $('#txtAmount').val(round(t1, 2));
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
			width:73%;
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
			width:99%;
			float:left;
		}
		.txt.c2{
			width:45%;
			float:left;
		}
		.txt.c3{
			width:30%;
			float:left;
		}
		.txt.c4{
			width:50%;
			float:left;
		}
		.txt.c5{
			width:80%;
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
			width: 1270px;
		}
		.tbbs a {
			font-size: medium;
		}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
	<div id='dmain' style="overflow:hidden;width: 1270px;">
		<div class="dview" id="dview" style="float: left;  width:25%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk' class="lbl"> </a></td>
					<td align="center" style="width:25%"><a id='vewNoa' class="lbl"> </a></td>
					<td align="center" style="width:40%"><a id='vewRc2no' class="lbl"> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='rc2no'>~rc2no</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing=''>
				<tr class="tr0" style="height: 0px;">
					<td class="td1" style="width:100px;"> </td>
					<td class="td2" style="width:200px;"> </td>
					<td class="td3" style="width:100px;"> </td>
					<td class="td4" style="width:200px;"> </td>
					<td class="td5" style="width:100px;"> </td>
					<td class="td6" style="width:200px;"> </td>
				</tr>
				<tr class="tr1">
					<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
					<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id='lblDatea' class="lbl"> </a></td>
					<td class="td4"><input id="txtDatea" type="text" class="txt c1" /></td>
					<td class="td5"><span> </span><a id="lblRc2no" class="lbl"> </a></td>
					<td class="td6"><input id="txtRc2no" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr2">
					<td class="td1" ><span> </span><a id='lblTggno' class="lbl btn"> </a></td>
					<td class="td2"><input id="txtTggno"  type="text"  class="txt c1"/></td>
					<td class="td1"><span> </span><a id='lblTgg' class="lbl"> </a></td>
					<td class="td2" colspan="3"><input id="txtTgg"  type="text" class="txt c1" /></td>
				</tr>  
				<tr class="tr3">
					<td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
					<td class="td2" colspan="3"><input id="txtAddr"  type="text" class="txt c1" /></td>
					<td class="td5" ><span> </span><a id='lblAttn' class="lbl"> </a></td>
					<td class="td6"><input id="txtAttn"  type="text"  class="txt c1"/></td>
				</tr>
				<tr class="tr4">
					<td class="td1"><span> </span><a id='lblShipped' class="lbl"> </a></td>
					<td class="td2" colspan="2"><input id="txtShipped"  type="text" class="txt c1" /></td>
					<td class="td4"><span> </span><a id='lblSailing' class="lbl"> </a></td>
					<td class="td5" colspan="2"><input id="txtSailing"  type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr4">
					<td class="td1"><span> </span><a id='lblPer' class="lbl"> </a></td>
					<td class="td2" colspan="2"><input id="txtPer"  type="text" class="txt c1" /></td>
					<td class="td4"><span> </span><a id='lblClosing' class="lbl"> </a></td>
					<td class="td5" colspan="2"><input id="txtClosing"  type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr5">
					<td class="td1" ><span> </span><a id='lblFroma' class="lbl"> </a></td>
					<td class="td2" colspan="2"><input id="txtFroma"  type="text"  class="txt c1"/></td>
					<td class="td1" ><span> </span><a id='lblToa' class="lbl"> </a></td>
					<td class="td2" colspan="2"><input id="txtToa"  type="text"  class="txt c1"/></td>
				</tr>
				<tr class="tr4">
					<td class="td1"><span> </span><a id='lblCommodity' class="lbl"> </a></td>
         			<td class="td2" colspan="2"><input id="txtCommodity"  type="text" class="txt c1" /></td>
         			<td class="td1"><span> </span><a id='lblContract' class="lbl"> </a></td>
         			<td class="td2" colspan="2"><input id="txtContract"  type="text" class="txt c1" /></td>
				</tr>                                                         
				<tr class="tr6">
					<td class="td1" ><span> </span><a id='lblEtd' class="lbl"> </a></td>
					<td class="td2"><input id="txtEtd"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblEta" class="lbl"> </a></td>
					<td class="td4"><input id="txtEta" type="text" class="txt c1" /></td>
					<td class="td5"><span> </span><a id="lblLcno" class="lbl"> </a></td>
					<td class="td6"><input id="txtLcno" type="text" class="txt c1" /></td>
				</tr>
		       <tr class="tr7">
					<td class="td1" ><span> </span><a id='lblPno' class="lbl"> </a></td>
					<td class="td2"><input id="txtPno"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id="lblCno" class="lbl"> </a></td>
					<td class="td4"><input id="txtCno" type="text" class="txt c1" /></td>
					<td class="td5" ><span> </span><a id='lblCoin' class="lbl"> </a></td>
					<td class="td6">
						<select id="cmbCoin" class="txt c2"> </select>
						<input id="txtFloata" type="text" class="txt num c2" />
					</td>
				</tr>
				<tr class="tr8">
					<td class="td1"><span> </span><a id="lblTotal" class="lbl"> </a></td>
					<td class="td2"><input id="txtTotal" type="text" class="txt c1 num" /></td>
					<td class="td3"><span> </span><a id="lblAmount" class="lbl"> </a></td>
					<td class="td4"><input id="txtAmount" type="text" class="txt c1 num" /></td>
					<td class="td5" align="center"><input id="btnPack" type="button"/> </td>
					<td class="td6" >
						<span style="float: left;"> </span>
						<input id="chkIsgenrc2" type="checkbox" style="float: left;"/>
						<a id='lblIsgenrc2' class="lbl" style="float: left;"> </a>
					</td>
				</tr> 
				<tr class="tr9">
					<td class="td1"><span> </span><a id='lblTitle' class="lbl"> </a></td>
					<td class="td2" colspan="5"><input id="txtTitle" type="text" class="txt c1" /></td>
				</tr>
				<tr class="tr10">
					<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
					<td class="td2" colspan="5"><textarea id="txtMemo"  style="width:99%; height: 60px;"> </textarea></td>
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
				<td align="center" style="width:9%;"><a id='lblProductno_s'> </a></td>
				<td align="center" style="width:9%;"><a id='lblMarks_s'> </a></td>
				<td align="center" style="width:15%;"><a id='lblDescription_s'> </a></td>
				<td align="center" style="width:2%;"><a id='lblUnit_s'> </a></td>
				<td align="center" style="width:5%;"><a id='lblQuantity_s'> </a></td>
				<td align="center" style="width:5%;"><a id='lblWeight_s'> </a></td>
				<td align="center" style="width:5%;"><a id='lblPrice_s'> </a></td>
				<td align="center" style="width:5%;"><a id='lblAmount_s'> </a></td>
				<td align="center" style="width:7%;"><a id='lblMemo_s'> </a></td>
				<td align="center" style="width:7%;"><a id='lblUno_s'> </a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
				</td>
				<td>
					<input id="txtProductno.*"  type="text"  class="txt c5"/>
					<input class="btn" id="btnProductno.*" type="button" value='.' style="font-weight: bold;" />
				</td>
				<td><input id="txtMarks.*"  type="text"  class="txt c1"/></td>
				<td><input id="txtDescription.*"  type="text"  class="txt c1"/></td>
				<td><input id="txtUnit.*"  type="text"  class="txt c1"/></td>
				<td><input id="txtQuantity.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtWeight.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtPrice.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtAmount.*"  type="text"  class="txt c1 num"/></td>
				<td><input id="txtMemo.*"  type="text"  class="txt c1"/></td>
				<td><input id="txtUno.*"  type="text"  class="txt c1"/></td>
			</tr>
		</table>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>