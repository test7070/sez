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

			var q_name = "gqb";
			var q_readonly = [];
			var bbmNum = [['txtMoney', 10, 0]];
			var bbmMask = [['txtDatea', '999/99/99'], ['txtIndate', '999/99/99'], ['txtTdate', '999/99/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//ajaxPath = ""; //  execute in Root
			aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
			 ['txtTcompno', 'lblTcomp', 'cust', 'noa,comp', 'txtTcompno,txtTcomp', 'cust_b.aspx'],
			 ['txtCompno', 'lblComp', 'tgg', 'noa,comp', 'txtCompno,txtComp', 'tgg_b.aspx'],
			 ['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx'],
			 ['txtTbankno', 'lblTbank', 'bank', 'noa,bank', 'txtTbankno,txtTbank', 'bank_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_desc = 1;
				q_gt(q_name, q_content, q_sqlCount, 1)
				$('#txtNoa').focus
			});

			//////////////////   end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
				// 1=Last  0=Top
			}///  end Main()

			var gqbno = [];
			var t_gqbno = '';
			function mainPost() {
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('gqb.typea'));
				$("#cmbTypea").focus(function() {
					var len = $("#cmbTypea").children().length > 0 ? $("#cmbTypea").children().length : 1;
					$("#cmbTypea").attr('size', len + "");
				}).blur(function() {
					$("#cmbTypea").attr('size', '1');
				});
				//判斷支票編號是否重複
				$('#txtGqbno').change(function() {
					var t_where = "where=^^ gqbno = '" + $('#txtGqbno').val() + "' ^^";
					q_gt('gqb', t_where, 0, 0, 0, "", r_accy);
				});

			}

			function txtCopy(dest, source) {
				var adest = dest.split(',');
				var asource = source.split(',');
				$('#' + adest[0]).focus(function() {
					if (trim($(this).val()).length == 0)
						$(this).val(q_getMsg('msgCopy'));
				});
				$('#' + adest[0]).focusout(function() {
					var t_copy = ($(this).val().substr(0, 1) == '=');
					var t_clear = ($(this).val().substr(0, 2) == ' =');
					for (var i = 0; i < adest.length; i++) { {
							if (t_copy)
								$('#' + adest[i]).val($('#' + asource[i]).val());

							if (t_clear)
								$('#' + adest[i]).val('');
						}
					}
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}   /// end Switch
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();

						gqbno = _q_appendData("gqb", "", true);
						if (q_cur == 1) {
							if (gqbno[0] != undefined) {
								alert("票據號碼已重複輸入");
								$('#txtGqbno').focus();
							}
							//q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);
						}
						if (q_cur == 2) {
							if (gqbno[0] != undefined && t_gqbno != $('#txtGqbno').val()) {
								alert("票據號碼已重複輸入");
								$('#txtGqbno').focus();
							}
							//q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);
						}
						break;
				}  /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('gqb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
				var cmb = document.getElementById("combPay")
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPay').val(cmb.value);
				cmb.value = '';
			}

			function btnIns() {
				var  t_curgqbno  =  $('#txtGqbno').val();
				_btnIns();
				var patt=new RegExp(/[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/);
				var n  =  0;
				if(t_curgqbno.length=9  && patt.test(t_curgqbno)){
					n = ""+(parseInt(t_curgqbno.substring(2,9))+1);
					for(var i=7-n.length;i>0;i--)
						n =  "0"+n;
					$('#txtGqbno').val(t_curgqbno.substring(0,2)+n);
				}
				$('#txtGqbno').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				$('#txtGqbno').focus();
				t_gqbno = $('#txtGqbno').val();
			}

			function btnPrint() {
				q_box('z_gqbp.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtGqbno').val()), '', "800px", "600px", q_getMsg("popPrint"));
			}

			function btnOk() {
				if (emp($('#txtGqbno').val())) {
					alert("請輸入票據號碼");
					$('#txtGqbno').focus();
					return;
				}

				if (q_cur == 1) {
					if (gqbno[0] != undefined) {
						alert("票據號碼已重複輸入");
						$('#txtGqbno').focus();
						return;
					}
				}
				if (q_cur == 2) {
					if (gqbno[0] != undefined && t_gqbno != $('#txtGqbno').val()) {
						alert("票據號碼已重複輸入");
						$('#txtGqbno').focus();
						return;
					}
				}
				if (emp($('#txtIndate').val())) {
					alert("請輸入到期日");
					$('#txtIndate').focus();
					return;
				}

				var t_date = trim($('#txtIndate').val());
				var tt_gqbno = trim($('#txtGqbno').val());
				var t_noa = trim($('#txtNoa').val());
				
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(t_date.replace(/\//g, '') + (9 - dec( $('#cmbTypea').val() )) + (tt_gqbno.length > 4 ? tt_gqbno.substring(0, 2) + tt_gqbno.substring(tt_gqbno.length - 3, 3) : tt_gqbno), '/', ''));
				else
					wrServer(t_noa);
			}

			function q_stPost() {
		        if (!(q_cur == 1 || q_cur == 2))
		            return false;
				var s2= xmlString.split(';');
				abbm[q_recno]['noa'] = s2[0];
		        abbm[q_recno]['accno'] = s2[1];
		        $('#txtAccno').val(s2[0]);
		    }
			
			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)/// popSave
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
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
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
				width: 50%;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbm textarea {
				font-size: medium;
			}

			input[type="text"], input[type="button"] {
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
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewGqbno'></a></td>
						<td align="center" style="width:40%"><a id='vewIndate'></a></td>
						<td align="center" style="width:25%"><a id='vewType'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='gqbno'>~gqbno</td>
						<td align="center" id='indate'>~indate</td>
						<td align="center" id='typea=gqb.typea'>~typea=gqb.typea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td><a id="lblGqb"  style="color: #104E8B ;font-weight:bolder;font-size: 18px; text-align: left;"></a></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblGqbno' class="lbl"></a></td>
						<td class="td2" colspan="2">
						<input id="txtNoa"  type="hidden"  class="txt c1"/>
						<input id="txtGqbno"  type="text"  class="txt c1"/>
						</td>
						<td class="td4"><span> </span><a id='lblType' class="lbl"></a></td>
						<td class="td5"><select id="cmbTypea" class="txt c1"></select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAccount' class="lbl"></a></td>
						<td class="td2" colspan="2">
						<input id="txtAccount" type="text" class="txt c1" />
						</td>
						<td class="td4"><span> </span><a id="lblAcomp" class="lbl btn"></a></td>
						<td class="td5">
						<input id="txtCno" type="text" class="txt c2" />
						<input id="txtAcomp" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblBank" class="lbl btn" ></a></td>
						<td class="td2" colspan="2">
						<input id="txtBankno" type="text" class="txt c2"/>
						<input id="txtBank" type="text" class="txt c3"/>
						</td>
						<td class="td4"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td2" colspan="2">
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td class="td4"><span> </span><a id='lblIndate' class="lbl"></a></td>
						<td class="td5">
						<input id="txtIndate"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
						<td class="td2" colspan="2">
						<input id="txtMoney"  type="text" class="txt num c1"/>
						</td>
						<td class="td4"><span> </span><a id='lblAccno' class="lbl"></a></td>
						<td class="td5">
						<input id="txtAccno"  type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblTcomp" class="lbl btn" ></a></td>
						<td class="td2" colspan="3">
						<input id="txtTcompno"  type="text" class="txt" style="width:30%;" />
						<input id="txtTcomp"  type="text" class="txt" style="width:70%;"/>
						</td>
						<td class="td4"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblComp" class="lbl btn"></a></td>
						<td class="td2" colspan="3">
						<input id="txtCompno"  type="text" class="txt" style="width:30%;"/>
						<input id="txtComp"  type="text" class="txt" style="width:70%;"/>
						</td>
						<td class="td3"></td>
					</tr>
					<tr>
						<td><a id="lblGqbs" style="color: #104E8B ;font-weight:bolder;font-size: 18px; text-align: left;"></a></td>
					</tr>

					<tr>
						<td class="td1"><span> </span><a id='lblTdate' class="lbl"></a></td>
						<td class="td2"  colspan="2">
						<input id="txtTdate" type="text" class="txt c1" />
						</td>
						<td class="td4"><span> </span><a id='lblEnda' class="lbl"></a></td>
						<td class="td5">
						<input id="txtEnda"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblTbank" class="lbl btn" ></a></td>
						<td class="td2" colspan="2">
						<input id="txtTbankno"  type="text" class="txt c2" />
						<input id="txtTbank"  type="text" class="txt c3" />
						</td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblUsage" class="lbl"></a></td>
						<td class="td2" colspan="4">
						<input id="txtUsage"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan="4">						<textarea id="txtMemo"  rows='5' cols='10' style="width:98%; height: 50px;"></textarea></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTacc1' class="lbl"></a></td>
						<td class="td2" colspan="2" >
						<input id="txtTacc1"  type="text" class="txt c1" />
						</td>
						<td class="td4"><span> </span><a id='lblEndaccno' class="lbl"></a></td>
						<td class="td5">
						<input id="txtEndaccno"  type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAcc1' class="lbl"></a></td>
						<td class="td2" colspan="2">
						<input id="txtAcc1"  type="text" class="txt c1" />
						</td>
						<td class="td4"><span> </span><a id='lblBkaccno' class="lbl"></a></td>
						<td class="td5">
						<input id="txtBkaccno"  type="text" class="txt c1" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
