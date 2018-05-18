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
			var q_name = "costchg";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			aPop = new Array(['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx']);
			$(document).ready(function () {
				bbmKey = ['noa'];
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
                bbmMask = [['txtDatea',r_picd],['txtBdate',r_picd],['txtEdate',r_picd]];
                q_mask(bbmMask);
                $('#btnCostchg').click(function(){
                	//t_where = "1=1 and (datea between '' and char(255)) and noa = '製令單號' and ordeno='訂單編號' and no2 = '定序'"
                	var t_productno = trim($('#txtProductno').val());
                	var t_bdate = encodeURI(trim($('#txtBdate').val()));
                	var t_edate = encodeURI((emp(trim($('#txtEdate').val()))?'999/99/99':trim($('#txtEdate').val())));
					var t_price = encodeURI(dec($('#txtPrice').val()));
					var t_wages = encodeURI(dec($('#txtWages').val()));
					var t_makes = encodeURI(dec($('#txtMakes').val()));
					var UseUrl = '';
					var t_where = ' 1=1 '
					t_where += "and (datea between '" + t_bdate + "' and '" + t_edate + "') ";
					t_where += (emp(trim($('#txtWorkno').val()))?'':"and noa='" + trim($('#txtWorkno').val()) + "' ");
					t_where += (emp(trim($('#txtOrdeno').val()))?'':"and ordeno='" + trim($('#txtOrdeno').val()) + "' ");
					t_where += (emp(trim($('#txtNo2').val()))?'':"and no2='" + trim($('#txtNo2').val()) + "' ");
					q_func('qtxt.query.costchg','costchg.txt,costchg,'+r_accy + ';' + t_productno + ';' + t_price + ';' + t_wages + ';' + t_makes + ';' + t_where + ';' + r_name);
                });
			}
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.costchg':
						alert('作業完畢');
					break;
				}
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {   
					case q_name + '_s':
						  q_boxClose2(s2); ///   q_boxClose 3/4
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
	
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date()).focus();
			}
	
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}
	
			function btnPrint() {
	
			}

			function btnOk() {
				var t_err = '';
				t_err = q_chkEmpField(['txtNoa', q_getMsg('lblNoa')]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				if(q_cur==1)
                	$('#txtWorker').val(r_name);
                else
                	$('#txtWorker2').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")   
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_costchg') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
	
			function refresh(recno) {
				_refresh(recno);
			}
	
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(q_cur == 0 && !emp($('#txtNoa').val()))
					$('#btnCostchg').removeAttr('disabled');
				else
					$('#btnCostchg').attr('disabled','disabled');
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
				_btnDele();
			}
	
			function btnCancel() {
				_btnCancel();
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
			width:95%;
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
    </style>
</head>
	</head>
<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
>
<!--#include file="../inc/toolbar.inc"-->
	<div id='dmain' style="overflow:hidden;">
		<div class="dview" id="dview" style="float: left;  width:25%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk' class="lbl"> </a></td>
					<td align="center" style="width:40%"><a id='vewNoa' class="lbl"> </a></td>
					<td align="center" style="width:25%"><a id='vewDatea' class="lbl"> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='datea'>~datea</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing=''>
				<tr>
					<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
					<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
					<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
					<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td><span> </span><a id="lblBdate" class="lbl"> </a></td>
					<td colspan="2">
						<input id="txtBdate" class="txt" type="text" style="width:45%;"/>
						<span style="float:left; display:block; width:20px;"><a> ～ </a></span>
						<input id="txtEdate" class="txt" type="text" style="width:45%;"/>
					</td>
				</tr>
				<tr>
					<td><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
					<td colspan="2">
						<input id="txtOrdeno"  type="text" class="txt" style="width:70%;"/>
						<input id="txtNo2"  type="text" class="txt" style="width:25%;"/>
					</td>
					<td><span> </span><a id='lblWorkno' class="lbl"> </a></td>
					<td><input id="txtWorkno"  type="text" class="txt c1" /></td>
				</tr>  
				<tr>
					<td><span> </span><a id='lblProductno' class="lbl btn"> </a></td>
					<td colspan="2">
						<input id="txtProductno"  type="text" class="txt" style="width:30%;"/>
						<input id="txtProduct"  type="text" class="txt" style="width:65%;"/>
					</td>
				</tr>  
				<tr>
					<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
					<td><input id="txtPrice"  type="text" class="txt c1 num" /></td>
					<td><span> </span><a id='lblWages' class="lbl"> </a></td>
					<td><input id="txtWages"  type="text" class="txt c1 num" /></td>
					<td><span> </span><a id='lblMakes' class="lbl"> </a></td>
					<td><input id="txtMakes"  type="text" class="txt c1 num" /></td>
				</tr>
				<tr>
					<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
					<td><input id="txtWorker"  type="text" class="txt c1" /></td>
					<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
					<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
					<td><input id="btnCostchg"  type="button"/></td>
				</tr>
			</table>
        </div>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>