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
		var q_readonly = ['txtNoa'];
		var bbmNum = [['txtSaleprice',10,2,1],['txtInprice',10,2,1]];	
		var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
		//ajaxPath = ""; //	execute in Root
		aPop = new Array(['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);
		
		$(document).ready(function () {
			bbmKey = ['noa'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1);
			$('#txtNoa').focus();
			q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
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
			$('#txtNoa').focus();
		}	///	end Main()


		function mainPost() { 
			q_cmbParse("cmbTypea", q_getPara('ucc.typea'));	// 需在 main_form() 後執行，才會載入 系統參數
			q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
			//q_cmbParse("cmbCoin", q_getPara('sys.coin'));	
			
			q_gt('uccga', '', 0, 0, 0, "");
			q_gt('uccgb', '', 0, 0, 0, "");
			q_gt('uccgc', '', 0, 0, 0, "");
			
			if(q_getPara('sys.comp').indexOf('永勝')>-1){
				$('#lblInprice').val('健保價');
				$('#lblType').val('分類');
				$('#lblTggno').val('原廠');
				$('#lblSaleprice').val('建議售價');
			}
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
				case 'getmaxuno'://找編號最大值
					var as = _q_appendData("ucc", "", true);
					var maxnumber=0;//目前最大值
					var autonumber='000';//流水編號
					if (as[0] != undefined) {
						for ( var i = 0; i < as.length; i++) {
							if(maxnumber<parseInt(as[i].noa.substring(as[i].noa.length-autonumber.length,as[i].noa.length)))
								maxnumber=as[i].noa.substring(as[i].noa.length-autonumber.length,as[i].noa.length);
						}
					}
					
					maxnumber=autonumber+(parseInt(maxnumber)+1);
					maxnumber=maxnumber.substring(maxnumber.length-autonumber.length,maxnumber.length);
					
					$('#txtNoa').val(($('#cmbGroupano').val()=='N'?'D':$('#cmbGroupano').val())+maxnumber);
					wrServer(($('#cmbGroupano').val()=='N'?'D':$('#cmbGroupano').val())+maxnumber);
					
					break;
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
					var as = _q_appendData("uccgb", "", true);
					if (as[0] != undefined) {
						as.sort(function(x,y){return x.noa-y.noa;});
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
					var as = _q_appendData("uccgc", "", true);
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
				case 'flors_coin':
					var as = _q_appendData("flors", "", true);
					var z_coin='';
					for ( i = 0; i < as.length; i++) {
						z_coin+=','+as[i].coin;
					}
					if(z_coin.length==0) z_coin=' ';
					
					q_cmbParse("cmbCoin", z_coin);
					if(abbm[q_recno])
						$('#cmbCoin').val(abbm[q_recno].coin);
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
			
			$('#txtNoa').val('AUTO').focus();
		}

		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;
			_btnModi();
		}

		function btnPrint() {
			q_box("z_uccp_uu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa=" + $('#txtNoa').val() + ";" + r_accy, 'sss', "95%", "95%", q_getMsg('popSss'));
		}
		
		function btnOk() {
			var t_err = '';

			t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);

			if (t_err.length > 0) {
				alert(t_err);
				return;
			}
			
			$('#txtWorker' ).val(  r_name); 
			var t_uno = trim($('#txtNoa').val());
			if (t_uno.length == 0 || t_uno=='AUTO'){
				//自動編號-找該類別最大數值
				q_gt('ucc', "where=^^ left(noa,1)='"+($('#cmbGroupano').val()=='N'?'D':$('#cmbGroupano').val())+"'^^", 0, 0, 0, 'getmaxuno', r_accy);
			}else{
				$('#txtNoa').val(t_uno);
				wrServer(t_uno);
			}
			
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
                width: 98%;
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
			<td align="center" style="width:15%"><a id='vewNoa'> </a></td>
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
			<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
			<td class="td2">
				<input id="txtNoa"  type="text" class="txt c1" />
			</td>
			<td class="td3"><input id="Copy" type="checkbox" /> <span> </span><a id="lblCopy"></a></td>
			<td class="td4"> </td>
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
			<td class="td1"><span> </span><a id='lblTggno' class="lbl btn"> </a></td>
			<td class="td1"><input id="txtTggno"  type="text" class="txt c1" /></td>
			<td class="td2" colspan='2'><input id="txtTgg"  type="text" class="txt c1" /></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblUnit' class="lbl"> </a></td>
			<td class="td2"><input id="txtUnit"  type="text" class="txt c1" /></td>
			<td class="td1"><span> </span><a id='lblInprice' class="lbl"> </a></td>
			<td class="td2"><input id="txtInprice"  type="text" class="txt num c1" /></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblSafemount' class="lbl"> </a></td>
			<td class="td2"><input id="txtSafemount"  type="text" class="txt c1" /></td>
			<td class="td1"><span> </span><a id='lblSaleprice' class="lbl"> </a></td>
			<td class="td2"><input id="txtSaleprice"  type="text" class="txt num c1" /></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblUweight' class="lbl"> </a></td>
			<td class="td2"><input id="txtUweight"  type="text" class="txt num c1" /></td>
			<td class="td1"><span> </span><a id='lblCoin' class="lbl"> </a></td>
			<td class="td2"><select id="cmbCoin" class="txt c1"> </select></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblType' class="lbl"> </a></td>
			<td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
			<td class="td1"><span> </span><a id='lblDays' class="lbl"> </a></td>
			<td class="td2"><input id="txtDays"  type="text" class="txt c1" /></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblArea' class="lbl"> </a></td>
			<td class="td2"><input id="txtArea"  type="text" class="txt num c1" /></td>
			<td class="td1"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
			<td class="td2"><select id="cmbTrantype" class="txt c1"> </select></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblRc2acc' class="lbl"> </a></td>
			<td class="td2"><input id="txtRc2acc"  type="text" class="txt c1" /></td>
			<td class="td1"><span> </span><a id='lblVccacc' class="lbl"> </a></td>
			<td class="td2"><input id="txtVccacc"  type="text" class="txt c1" /></td>
		</tr>
		
		<tr>
			<td class="td1"><span> </span><a id='lblDate2' class="lbl"> </a></td>
			<td class="td2"><input id="txtDate2"  type="text" class="txt c1" /></td>
			<td class="td1"><span> </span><a id='lblHealthno' class="lbl"> </a></td>
			<td class="td2"><input id="txtHealthno"  type="text" class="txt c1" /></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblGroupano' class="lbl"> </a></td>
			<td class="td2"><select id="cmbGroupano" class="txt c1"> </select></td>
			<td class="td1"><span> </span><a id='lblGroupbno' class="lbl"> </a></td>
			<td class="td2"><select id="cmbGroupbno" class="txt c1"> </select></td>
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblGroupcno' class="lbl"> </a></td>
			<td class="td2"><select id="cmbGroupcno" class="txt c1"> </select></td>
			<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
			<td class="td2"><input id="txtWorker"  type="text" class="txt c1" /></td>
			
		</tr>
		<tr>
			<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
			<td class="td2" colspan='3'><input id="txtMemo"  type="text" class="txt c1" /></td>
		</tr>
	</table>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>
