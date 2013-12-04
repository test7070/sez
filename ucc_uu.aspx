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
		var decbbm = ['inprice', 'saleprice', 'reserve', 'beginmount','uweight','beginmoney','drcr','price2','days','stkmount','safemount','stkmoney'];
		var q_name = "ucc";
		var q_readonly = ['textUccprice','textStk','textSaleprice','textInprice','textCosta','textOrdemount','textPlanmount','textIntmount','textAvaistk'];
		var bbmNum = [['txtSaleprice',10,2,1],['txtInprice',10,2,1]];	
		var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'uno';
		//ajaxPath = ""; //	execute in Root
		aPop = new Array();
		//['txtTggno', 'btnTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
		
		$(document).ready(function () {
			bbmKey = ['uno'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1);
			$('#txtUno').focus();
			
		});
		function currentData() {
		}
		currentData.prototype = {
			data : [],
			/*排除的欄位,新增時不複製*/
			exclude : [],
			/*記錄當前的資料*/
			copy : function() {
				curData.data = new Array();
				for (var i in fbbm) {
					var isExclude = false;
					for (var j in curData.exclude) {
						if (fbbm[i] == curData.exclude[j]) {
							isExclude = true;
							break;
						}
					}
					if (!isExclude) {
						curData.data.push({
							field : fbbm[i],
							value : $('#' + fbbm[i]).val()
						});
					}
				}
			},
			/*貼上資料*/
			paste : function() {
				for (var i in curData.data) {
					$('#' + curData.data[i].field).val(curData.data[i].value);
				}
			}
		};
		var curData = new currentData();
		//////////////////	end Ready
		function main() {
			if (dataErr) {
				dataErr = false;
				return;
			}
			q_mask(bbmMask);
			mainForm(0); // 1=Last	0=Top
			$('#txtUno').focus();
		}	///	end Main()


		function mainPost() { 
			q_cmbParse("cmbTypea", q_getPara('ucc.typea'));	// 需在 main_form() 後執行，才會載入 系統參數
			q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
			q_cmbParse("cmbCoin", q_getPara('sys.coin'));	
			
			q_gt('uccga', '', 0, 0, 0, "");
			q_gt('uccgb', '', 0, 0, 0, "");
			q_gt('uccgc', '', 0, 0, 0, "");
		}

		function q_boxClose(s2) { 
			var ret;
			switch (b_pop) {	
				case q_name + '_s':
					q_boxClose2(s2); ///	q_boxClose 3/4
					break;
			}	/// end Switch
		}
		
		function q_gtPost(t_name) {	
			switch (t_name) {
				case 'uccga'://大類
					var as = _q_appendData("uccga", "", true);
					if (as[0] != undefined) {
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+' . '+as[i].namea;
						}
						q_cmbParse("cmbGroupano", t_item);
						if (abbm[q_recno] != undefined) {
							$("#cmbGroupano").val(abbm[q_recno].groupano);
						}
					}
					break;
				case 'uccgb'://中類
					var as = _q_appendData("uccga", "", true);
					if (as[0] != undefined) {
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+' . '+as[i].namea;
						}
						q_cmbParse("cmbGroupbno", t_item);
						if (abbm[q_recno] != undefined) {
							$("#cmbGroupbno").val(abbm[q_recno].groupbno);
						}
					}
					break;
				case 'uccgc'://小類
					var as = _q_appendData("uccga", "", true);
					if (as[0] != undefined) {
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa+' . '+as[i].namea;
						}
						q_cmbParse("cmbGroupcno", t_item);
						if (abbm[q_recno] != undefined) {
							$("#cmbGroupcno").val(abbm[q_recno].groupcno);
						}
					}
					break;
				case q_name: 
					if (q_cur == 4)	
						q_Seek_gtPost();
					break;
			}	/// end switch
		}

		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)	// 1-3
				return;

			q_box('ucc_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
		}

		function btnIns() {
			if($('#Copy').is(':checked')){
				curData.copy();
			}
			_btnIns();
			if($('#Copy').is(':checked')){
				curData.paste();
			}
			$('#txtUno').focus();
		}

		function btnModi() {
			if (emp($('#txtUno').val()))
				return;
			_btnModi();
		}

		function btnPrint() {

		}
		function btnOk() {
			var t_err = '';

			t_err = q_chkEmpField([['txtUno', q_getMsg('lblUno')]]);

			if (t_err.length > 0) {
				alert(t_err);
				return;
			}
			var t_uno = trim($('#txtUno').val());
			$('#txtNoa').val(t_uno);

			if (t_uno.length == 0)	
				q_gtnoa(q_name, t_uno);
			else
				wrServer(t_uno);
		}

		function wrServer(key_value) {
			var i;

			xmlSql = '';
			if (q_cur == 2)	/// popSave
				xmlSql = q_preXml();

			$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			_btnOk(key_value, bbmKey[0], '', '', 2);
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
		#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
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
                width: 98%;
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
                width: 95%;
                float: left;
            }
            .txt.c2 {
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
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
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
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
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
	</style>
</head>
<body>
	<!--#include file="../inc/toolbar.inc"-->
	<div class="dview" id="dview" style="float: left;	width:32%;"	>
		<table class="tview" id="tview"	border="1" cellpadding='2'	cellspacing='0' style="background-color: #FFFF66;">
		<tr>
			<td align="center" style="width:2%"><a id='vewChk'> </a></td>
			<td align="center" style="width:15%"><a id='vewUno'> </a></td>
			<td align="center" style="width:25%"><a id='vewProduct'> </a></td>
		</tr>
		<tr>
			<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
			<td align="center" id='noa'>~noa</td>
			<td align="center" id='product spec'>~product ~spec</td>
		</tr>
	</table>
	</div>
	<div class='dbbm' style="width: 68%;float: left;">
	<table class="tbbm"	id="tbbm"	border="0" cellpadding='2'	cellspacing='0'>
		<tr>
			<td class="td1"><span> </span><a id='lblUno' class="lbl"> </a></td>
			<td class="td2">
				<input id="txtUno"  type="text" class="txt c1" />
				<input id="txtNoa"  type="text" class="txt c1" style="display:none;" />
			</td>
			<td class="td3"><input id="Copy" type="checkbox" /> <span> </span><a id="lblCopy"></a></td>
			<td class="td4"> </td>
			<td class="td5"> </td>
			<td class="td6"> </td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblProduct' class="lbl"> </a></td>
			<td class="td2" colspan='3'><input id="txtProduct"  type="text" class="txt c1" /></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblEngpro' class="lbl"> </a></td>
			<td class="td2" colspan='3'><input id="txtEngpro"  type="text" class="txt c1" /></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblSpec' class="lbl"> </a></td>
			<td class="td2" colspan='3'><input id="txtSpec"  type="text" class="txt c1" /></td>
		</tr>
		<tr>
			<td class="label1"><a id='lblUnit'> </a></td>
			<td><input	type="text" id="txtUnit" class="txt c1"/></td>
			<td class="label2"><a id='lblInprice'> </a></td>
			<td><input	type="text" id="txtInprice" class="txt num c2"/></td>			
		</tr>
		<tr>
			<td class="label1"><a id='lblSafemount'> </a></td>
			<td><input	type="text" id="txtSafemount" class="txt num c1"/></td>
			<td class="label2"><a id='lblSaleprice'> </a></td>
			<td><input	type="text" id="txtSaleprice"	class="txt num c2"/></td>
		</tr>
		<tr>
			<td class="label1"><a id='lblUweight'> </a></td>
			<td><input	type="text" id="txtUweight"	class="txt num c1"/></td>
			<td class="label2"><a id='lblCoin'> </a></td>
			<td><select id="cmbCoin" class="txt c2"> </select></td>
		</tr>
		<tr>
			<td class="label1"><a id='lblType'> </a></td>
			<td><select id="cmbTypea" class="txt c1"> </select></td>
			<td class="label2"><a id='lblDays'> </a></td>
			<td><input	type="text" id="txtDays" class="txt c2"/></td> 
		</tr>
		<tr>
			<td class="label1"><a id='lblArea'> </a></td>
			<td><input	type="text" id="txtArea"	class="txt c1"/></td>
			<td class="label2"><a id='lblTrantype'> </a></td>
			<td><select id="cmbTrantype" class="txt c2"> </select></td> 
		</tr>
		<tr>
			<td class="label1"><a id='lblRc2acc'> </a></td>
			<td><input	type="text" id="txtRc2acc" class="txt c1"/></td>
			<td class="label2"><a id='lblVccacc'> </a></td>
			<td><input	type="text" id="txtVccacc" class="txt c2"/></td>
		</tr>
		<tr>
			<td class='label1'><a id='lblDate2'> </a></td>
			<td class='column3'><input type="text" id="txtDate2" class="txt c1"/></td>
			<td class="label2"><a id='lblWorker'> </a></td>
			<td ><input id="txtWorker" type="text" class="txt c2" style='text-align:center;'/></td> 
		</tr>
		<tr>
			<td class="label1"><a id='lblGroupano'> </a></td>
			<td><select id="cmbGroupano" class="txt c2"> </select></td> 
		</tr>
		<tr>
			<td class="label1"><a id='lblMemo'> </a></td>
			<td colspan='3'><textarea id="txtMemo" cols="10" rows="5" style="width: 98%;height: 127px;"> </textarea></td>
		</tr>
	</table>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>
