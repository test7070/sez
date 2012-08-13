<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			var q_name = "traneprice";
			var q_readonly = ['txtNoa','txtWorker'];
			var bbmNum = [['txtMoney',10,0]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//ajaxPath = ""; //  execute in Root
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
			['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'],
			['txtStraddrno', 'lblStraddr', 'addr', 'noa,addr', 'txtStraddrno,txtStraddr', 'addr_b.aspx']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1)
				$('#txtNoa').focus
			});

			//////////////////   end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				// 1=Last  0=Top
			}///  end Main()

			function mainPost() {
				bbmMask = new Array(['txtDatea',r_picd],['txtMon',r_picm]);
				q_mask(bbmMask);
				bbmMask2 = new Array(['txtBdate',r_picd],['txtEdate',r_picd]);
				q_mask(bbmMask2);
				q_cmbParse("cmbCarteamno", q_getPara('.taxtype'));
				q_gt('carteam', '', 0, 0, 0, "");
				$("#cmbCarteamno").focus(function(){
                	var len = $("#cmbCarteamno").children().length>0?$("#cmbCarteamno").children().length:1;
                	$("#cmbCarteamno").attr('size',len+"");
                }).blur(function(){
                	$("#cmbCarteamno").attr('size','1');
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
					case 'carteam':
                        var as = _q_appendData("carteam", "", true);
						var t_item = "";
                        for( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length>0?',':'') + as[i].noa +'@' + as[i].team;
                        }
                        q_cmbParse("cmbCarteamno", t_item); 
                        $("#cmbCarteamno").val( abbm[q_recno].carteamno);                  
                        break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();

						if (q_cur == 1 || q_cur == 2)
							q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);
					
						break;
				}  /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('traneprice_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
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
				$('#txtWorker').val(r_name);			
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_carborr') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
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
                width: 20%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: 16px;
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
                width: 58%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                /*border: 1px white double;
                 border-spacing: 0;
                 border-collapse: collapse;*/
                font-size: 16px;
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
                width: 2%;
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
                width: 40%;
                float: left;
            }
            .tbbm tr td .txt.c3 {
                width: 55%;
                float: left;
            }
            .tbbm tr td .txt.c4 {
                width: 19%;
                float: left;
            }
            .tbbm tr td .txt.c5 {
                width: 81%;
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
                font-size:medium;
            }
            input[type="text"],input[type="button"] {
                font-size:medium;
            }
            input[readonly="readonly"]#txtMiles{
            	color:green;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewComp'> </a></td>
						<td align="center" style="width:20%"><a id='vewOutprice'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp'>~comp</td>
						<td align="center" id='outprice'>~outprice</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl">  </a></td>
						<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblDatea' class="lbl">  </a></td>
						<td class="td4"><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td class="td5"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblBdate' class="lbl">  </a></td>
						<td class="td2"><input id="txtBdate" type="text"  class="txt c1"/></td>
						<td align="center"><a id="lblSymbol"  style="font-weight: bold;font-size: 24px;"> </a></td>
						<td class="td4"><input id="txtEdate" type="text"  class="txt c1"/> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblCust" class="lbl btn" >  </a></td>
						<td class="td2"  colspan="3">
						<input id="txtCustno" type="text"  class="txt c4"/>
						<input id="txtComp"  type="text"  class="txt c5"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblDriver" class="lbl btn" >  </a></td>
						<td class="td2"  colspan="3">
						<input id="txtDriverno" type="text"  class="txt c4"/>
						<input id="txtDriver"  type="text"  class="txt c5"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCarno' class="lbl">  </a></td>
						<td class="td2"><input id="txtCarno" type="text"  class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td class="td4"><select id="cmbCarteamno" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td class="td1" ><span> </span><a id="lblStraddr" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtStraddrno" type="text"  class="txt c4"/>
						<input id="txtStraddr" type="text"  class="txt c5"/>
						</td>
					</tr>
					<tr>
						<td class="td1" ><span> </span><a id="lblInprice" class="lbl"> </a></td>
						<td class="td2" ><input id="txtInprice" type="text"  class="txt c1"/></td>
						<td class="td3" ><input id="btnChinprice" type="button" /></td>
					</tr>
					<tr>
						<td class="td1" ><span> </span><a id="lblOutprice" class="lbl"> </a></td>
						<td class="td2" ><input id="txtOutprice" type="text"  class="txt c1"/></td>
						<td class="td3" ><input id="btnChoutprice" type="button" /></td>
					</tr>
					<tr>
						<td class="td1" ><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2"colspan="3"><textarea id="txtMemo" cols="10" rows="5" style="width: 98%; height: 50px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
