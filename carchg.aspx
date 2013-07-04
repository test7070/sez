<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			var q_name = "carchg";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtTreno'];
			var bbmNum = new Array(['txtMinusmoney', 10, 0], ['txtPlusmoney', 10, 0]);
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			//ajaxPath = ""; //  execute in Root
			aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
			, ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
			, ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx']
			, ['txtMinusitemno', 'lblMinusitem', 'chgitem', 'noa,item,acc1,acc2', 'txtMinusitemno,txtMinusitem,txtAcc1,txtAcc2', 'chgitem_b.aspx']
			, ['txtPlusitemno', 'lblPlusitem', 'chgitem', 'noa,item,acc1,acc2', 'txtPlusitemno,txtPlusitem,txtAcc1,txtAcc2', 'chgitem_b.aspx']
			, ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
			q_xchg = 1;
            brwCount2 = 20;
            
			function currentData() {}
			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				include : ['txtDatea','txtCustno','txtCust','cmbCarteamno','txtMinusitemno','txtMinusitem','txtMinusmoney'
					,'txtPlusitemno','txtPlusitem','txtPlusmoney','txtAcc1','txtAcc2','txtMemo'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in curData.include) {
							if (fbbm[i] == curData.include[j]) {
								isInclude = true;
								break;
							}
						}
						if (isInclude) {
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
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)
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

			function mainPost() {
				q_modiDay= q_getPara('sys.modiday2');  /// 若未指定， d4=  q_getPara('sys.modiday'); 
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_gt('carteam', '', 0, 0, 0, "");

				$('input[type="text"]').focus(function() {
					$(this).addClass('focus_b');
				}).blur(function() {
					$(this).removeClass('focus_b');
				});

				$('#txtAcc1').change(function() {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');
                });

				$("#cmbCarteamno").focus(function() {
					var len = $("#cmbCarteamno").children().length > 0 ? $("#cmbCarteamno").children().length : 1;
					$("#cmbCarteamno").attr('size', len + "");
				}).blur(function() {
					$("#cmbCarteamno").attr('size', '1');
				});
				
				$('#txtMinusitemno').blur(function(e) {
					$('#txtMinusitem').focus();
				});
				$('#txtPlusitemno').blur(function(e) {
					$('#txtPlusitem').focus();
				});
				$('#lblAccno').click(function () {
	            	q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
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
					case 'car2':
						var as = _q_appendData("car2", "", true);
						if (as[0] != undefined) {
							/*var now_acc1 = $('#txtAcc1').val();
							var now_acc2 = $('#txtAcc2').val();
							$('#txtAcc1').val(now_acc1 + as[0].carownerno);
							$('#txtAcc2').val(now_acc2 + '-' + as[0].carowner);*/
							var t_acc1 = '1123.'+as[0].carownerno
							$('#txtAcc1').val(t_acc1);
							var t_where = "where=^^ acc1='"+t_acc1+"' ^^"
							q_gt('acc', t_where , 0, 0, 0, "", r_accy+'_1');
						}						
						break;
					case 'acc':
						var as = _q_appendData("acc", "", true);
						if (as[0] != undefined) {
							$('#txtAcc2').val(as[0].acc2);
						}						
						break;
					case 'carteam':
						var as = _q_appendData("carteam", "", true);
						var t_item = "@";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						q_cmbParse("cmbCarteamno", t_item);
						$("#cmbCarteamno").val(abbm[q_recno].carteamno);
						q_gridv('tview', browHtm, fbrow, abbm, aindex, brwNowPage, brwCount);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();

						if (q_cur == 1 || q_cur == 2)
							q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

						break;
				}  /// end switch
			}
			function q_popPost(id) {
				switch(id) {
					case 'txtCarno':
						if((q_cur==1 || q_cur==2) && ($('#txtMinusitem').val() == '監理部扣款')){
							t_where = '';
							if($('#txtCarno').val() != ''){
								t_where = "where=^^ carno='"+$('#txtCarno').val()+"' ^^";
								q_gt('car2', t_where , 0, 0, 0, "", r_accy);
							}
							$('#txtDriverno').focus();
						}
						break;
					case 'txtMinusitemno':
						if((q_cur==1 || q_cur==2) && ($('#txtMinusitem').val() == '監理部扣款')){
							t_where = '';
							if($('#txtCarno').val() != ''){
								t_where = "where=^^ carno='"+$('#txtCarno').val()+"' ^^";
								q_gt('car2', t_where , 0, 0, 0, "", r_accy);
							}
							$('#txtMinusitem').focus();
						}
						break;
					case 'txtPlusitemno':
						if(q_cur==1 || q_cur==2){
							$('#txtPlusitem').focus();
						}
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('carchg_s.aspx', q_name + '_s', "530px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				curData.copy();
                _btnIns();
                curData.paste();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				if (q_chkClose())
             		    return;
				_btnModi();
				$('#txtDatea').focus();
				sum();
			}

			function btnPrint() {
				q_box('z_carchg.aspx?;;;'+r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				$('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
                }
				$('#txtWorker').val(r_name);
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_carchg') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function sum() {
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
				if (q_chkClose())
             		return;
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}
			function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 1000px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 1000px;
                /*margin: -1px;        
                border: 1px black solid;*/
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
			.tbbm td {
				width: 10%;
			}
			.tbbm .tdZ {
				width: 1%;
			}
			td .schema {
				display: block;
				width: 95%;
				height: 0px;
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
				font-size: 16px;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.tbbm tr td .txt.c1 {
				width: 100%;
				float: left;
			}
			.tbbm tr td .txt.c2 {
				width: 45%;
				float: left;
			}
			.tbbm tr td .txt.c3 {
				width: 55%;
				float: left;
			}
			.tbbm tr td .txt.c4 {
				width: 60%;
				float: left;
			}
			.tbbm tr td .txt.c5 {
				width: 40%;
				float: left;
			}
			.tbbm tr td .txt.num {
				text-align: right;
			}

			.txt.num {
				text-align: right;
			}
			td {
				margin: 0px -1px;
				padding: 0;
			}
			td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			input[readonly="readonly"]#txtMiles {
				color: green;
			}
			.focus_b {
				border-width: 3px;
				border-color: #FF7F24;
				border-style: double;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCarteam'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:250px; color:black;"><a id='vewItem'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMinusmoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewPlusmoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewTreno'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="carteamno=cmbCarteamno" style="text-align: center;">~carteamno=cmbCarteamno</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="driver" style="text-align: left;">~driver</td>
						<td id="minusitem plusitem" style="text-align: left;">~minusitem ~plusitem</td>
						<td id="minusmoney,0,1" style="text-align: right;">~minusmoney,0,1</td>
						<td id="plusmoney,0,1" style="text-align: right;">~plusmoney,0,1</td>
						<td id="treno" style="text-align: left;">~treno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm" >
					<tr name="schema" style="height:1px;">
						<td class="td1"><span class="schema"> </span></td>
						<td class="td2"><span class="schema"> </span></td>
						<td class="td3"><span class="schema"> </span></td>
						<td class="td4"><span class="schema"> </span></td>
						<td class="td5"><span class="schema"> </span></td>
						<td class="td6"><span class="schema"> </span></td>
						<td class="td7"><span class="schema"> </span></td>
						<td class="tdZ"><span class="schema"> </span></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn" > </a></td>
						<td colspan="3">
						<input id="txtCustno"  type="text"  class="txt" style="width:30%; float: left;"/>
						<input id="txtCust"  type="text"  class="txt" style="width:70%;  float: left;"/>
						</td>
						<td><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td><select id="cmbCarteamno" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td><input id="txtCarno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl btn" > </a></td>
						<td colspan="3">
						<input id="txtDriverno"  type="text" class="txt c2" />
						<input id="txtDriver"  type="text" class="txt  c3"  />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMinusitem" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtMinusitemno"  type="text"  class="txt c2"/>
						<input id="txtMinusitem"  type="text"  class="txt c3"/>
						</td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td><input id="txtMinusmoney"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPlusitem" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtPlusitemno"  type="text" class="txt c2"/>
						<input id="txtPlusitem"  type="text"  class="txt c3"/>
						</td>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td><input id="txtPlusmoney"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcc1" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtAcc1"  type="text" class="txt c2"/>
						<input id="txtAcc2"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='5'><input id="txtMemo"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker"  type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblTreno' class="lbl"> </a></td>
						<td><input id="txtTreno"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

