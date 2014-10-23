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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			var q_name = "cust2";
			var q_readonly = ['txtWorker', 'txtKdate', 'txtSales', 'txtGrpname', 'txtUacc1', 'txtUacc2', 'txtUacc3'];
			var bbmNum = [['txtCredit', 10, 0, 1],['txtProfit', 10, 2, 1]];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 25;
			//ajaxPath = ""; // execute in Root
			aPop = new Array(
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx'],
				['txtGrpno', 'lblGrp', 'cust', 'noa,comp', 'txtGrpno,txtGrpname', 'cust_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				xmlTable = 'conn';
				xmlKey = [['noa', 'noq']];
				xmlDec = [];
				q_popSave(xmlTable);
				// for conn_b.aspx
				q_brwCount();
				var t_where = "where=^^ noa='" + r_userno + "' ^^";
				q_gt('sss', t_where, 0, 0, 0, "", r_accy);
				$('#txtNoa').focus();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				bbmMask = [
					['txtChkdate', r_picd], ['txtDueday', '999'], ['txtStartdate', '99'],
					['txtGetdate', '99']
				];
				q_mask(bbmMask);
				q_gt('custtype', '', 0, 0, 0, "custtype");
				
				if (q_getPara('sys.comp').indexOf('裕承隆') > -1){
					aPop = new Array(
						['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
						['txtAddr_fact', '', 'view_road', 'memo,zipcode', '0txtAddr_fact,txtZip_fact', 'road_b.aspx'],
						['txtAddr_comp', '', 'view_road', 'memo,zipcode', '0txtAddr_comp,txtZip_comp', 'road_b.aspx'],
						['txtAddr_invo', '', 'view_road', 'memo,zipcode', '0txtAddr_invo,txtZip_invo', 'road_b.aspx'],
						['txtAddr_home', '', 'view_road', 'memo,zipcode', '0txtAddr_home,txtZip_home', 'road_b.aspx'],
						['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx'],
						['txtGrpno', 'lblGrp', 'cust', 'noa,comp', 'txtGrpno,txtGrpname', 'cust_b.aspx']
					);
				}
				/*
				if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1){
					q_cmbParse("cmbTypea", q_getPara('cust.typea_it'));
				}else if (q_getPara('sys.project').toUpperCase() == 'RA') {
					q_cmbParse("cmbTypea", q_getPara('cust.typea_ra'));
				}else if (q_getPara('sys.project').toUpperCase() == 'TN') {
					q_cmbParse("cmbTypea", q_getPara('cust.typea_tn'));
				} else
					q_cmbParse("cmbTypea", q_getPara('cust.typea'));
				*/
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbStatus", q_getPara('cust.status'));

				//後面有需要的公司在顯示
				$('.btnUcam').hide();
				// 嘜頭

				$('#btnUcam').click(function() {
					t_where = "custno='" + $('#txtNoa').val() + "'";
					q_box("ucam_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucam', "95%", "95%", q_getMsg('btnUcam'));
				});
				$('#btnConn').click(function() {
					if (q_cur == 1) {
						return;
					} else {
						t_where = "noa='" + $('#txtNoa').val() + "'";
						q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('btnConn'));
					}
				});
				$('#txtNoa').change(function(e) {
					$(this).val($.trim($(this).val()).toUpperCase());
					if ($(this).val().length > 0) {
						if ((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())) {
							t_where = "where=^^ noa='" + $(this).val() + "'^^";
							q_gt('cust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
						} else {
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
							Unlock();
						}
					}
				});
				$('#txtUacc4').change(function() {
					var s1 = trim($(this).val());
					if (s1.length > 4 && s1.indexOf('.') < 0)
						$(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
					if (s1.length == 4)
						$(this).val(s1 + '.');

				});
				$('#btnUsecrd').click(function(){
					var t_custno = $.trim($('#txtNoa').val());
					if((t_custno.length > 0) && (t_custno.toUpperCase() != 'AUTO')){
						var t_where = "noa='" + t_custno + "'";
						q_box("usecrd.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'usecrd', "95%", "450px", q_getMsg('btnUsecrd'));
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
					case 'custtype':
						var as = _q_appendData("custtype", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
							q_cmbParse("cmbTypea", t_item);
							if(abbm[q_recno])
								$("#cmbTypea").val(abbm[q_recno].typea);
						}
						break;
					case 'checkCustno_change':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
						}
						break;
					case 'checkCustno_btnOk':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							alert('已存在 ' + as[0].noa + ' ' + as[0].comp);
							Unlock();
							return;
						} else {
							wrServer($('#txtNoa').val());
						}
						break;
					case 'sss':
						var as = _q_appendData("sss", "", true);
						if (as[0] == undefined || (as[0].issales == 'false') || (as[0].issales == false)) {
							q_gt(q_name, q_content, q_sqlCount, 1);
						} else {
							q_content = "where=^^ salesno='" + r_userno + "'^^";
							q_gt(q_name, q_content, q_sqlCount, 1);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				} /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cust_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}

			function btnIns() {
				if ($('#Copy').is(':checked')) {
					curData.copy();
				}
				_btnIns();
				if ($('#Copy').is(':checked')) {
					curData.paste();
				}
				refreshBbm();
				$('#txtNoa').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				refreshBbm();
				$('#txtComp').focus();
			}

			function btnPrint() {
				q_box("z_label.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";cust=" + $('#txtNoa').val() + ";" + r_accy, 'z_label', "95%", "95%", q_getMsg('popZ_label'));
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock();
			}

			function btnOk() {
				Lock();
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				if ((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())) {
				} else {
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
					Unlock();
					return;
				}

				if ($('#txtStartdate').val() > '31') {
					alert(q_getMsg("lblStartdate") + '最大天數為31日');
					Unlock();
					return;
				}
				if ($('#txtGetdate').val() > '31') {
					alert(q_getMsg("lblGetdate") + '最大天數為31日');
					Unlock();
					return;
				}

				if (dec($('#txtCredit').val()) > 9999999999)
					t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

				if (dec($('#txtGetdate').val()) > 31)
					t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r';
					
				if(q_cur==1)
					$('#txtKdate').val(q_date());
					
				$('#txtWorker').val(r_name);
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('#txtConntel').val($('#textConn').val());
					$('#txtBillmemo').val($('#textTrantime').val());
					var t_invomemo=$('#textIsvcc').val()+'##'+$('#textIsinvo').val()+'##'+$('#textIstax').val()+'##'+$('#textCheckvcc').val();
					$('#txtInvomemo').val(t_invomemo);
				}
				
				if (q_cur == 1) {
					t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
					q_gt('cust', t_where, 0, 0, 0, "checkCustno_btnOk", r_accy);
				} else {
					wrServer($('#txtNoa').val());
				}
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
				refreshBbm();
				if (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)
					$('.it').css('text-align', 'left');
				if (q_getPara('sys.menu').substring(0,3)=='qfe'){
					$('.isFe').show();
				}else{
					$('.isFe').hide();
				}
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('.isXY').show();
				}else{
					$('.isXY').hide();
				}
			}

			function refreshBbm() {
				if (q_cur == 1) {
					$('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
				} else {
					$('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				}
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					var t_invomemo=$('#txtInvomemo').val().split('##');
					if (q_cur == 1 || q_cur==2) {
						$('#textConn').css('color', 'black').css('background', 'white').removeAttr('readonly').val($('#txtConntel').val());
						$('#textTrantime').css('color', 'black').css('background', 'white').removeAttr('readonly').val($('#txtBillmemo').val());
						$('#textIsvcc').css('color', 'black').css('background', 'white').removeAttr('readonly').val(t_invomemo[0]);
						$('#textIsinvo').css('color', 'black').css('background', 'white').removeAttr('readonly').val(t_invomemo[1]);
						$('#textIstax').css('color', 'black').css('background', 'white').removeAttr('readonly').val(t_invomemo[2]);
						$('#textCheckvcc').css('color', 'black').css('background', 'white').removeAttr('readonly').val(t_invomemo[3]);
					} else {
						$('#textConn').css('color', 'black').css('background', 'RGB(237,237,238)').attr('readonly', 'readonly').val($('#txtConntel').val());
						$('#textTrantime').css('color', 'black').css('background', 'RGB(237,237,238)').attr('readonly', 'readonly').val($('#txtBillmemo').val());
						$('#textIsvcc').css('color', 'black').css('background', 'RGB(237,237,238)').attr('readonly', 'readonly').val(t_invomemo[0]);
						$('#textIsinvo').css('color', 'black').css('background', 'RGB(237,237,238)').attr('readonly', 'readonly').val(t_invomemo[1]);
						$('#textIstax').css('color', 'black').css('background', 'RGB(237,237,238)').attr('readonly', 'readonly').val(t_invomemo[2]);
						$('#textCheckvcc').css('color', 'black').css('background', 'RGB(237,237,238)').attr('readonly', 'readonly').val(t_invomemo[3]);
					}
				}
			}

			var vccitopen = true;
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (vccitopen && t_para && window.parent.q_name == 'vcc' && (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)) {
					btnIns();
					vccitopen = false;
					$('#txtNoa').val(window.parent.post_custno);
				}
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

			function returnparent() {
				if (window.parent.q_name == 'vcc' && (q_getPara('sys.comp').indexOf('英特瑞') > -1 || q_getPara('sys.comp').indexOf('安美得') > -1)) {
					var wParent = window.parent.document;
					wParent.getElementById("txtCustno").value = $('#txtNoa').val();
					wParent.getElementById("txtComp").value = $('#txtComp').val();
					wParent.getElementById("txtPaytype").value = $('#txtPaytype').val();
					wParent.getElementById("txtTel").value = $('#txtTel').val();
					wParent.getElementById("txtFax").value = $('#txtFax').val();
					wParent.getElementById("cmbTrantype").value = $('#cmbTrantype').val();
					wParent.getElementById("txtZipcode").value = $('#txtZip_comp').val();
					wParent.getElementById("txtAddr").value = $('#txtAddr_comp').val();
					wParent.getElementById("txtSalesno").value = $('#txtSalesno').val();
					wParent.getElementById("txtSales").value = $('#txtSales').val();
					wParent.getElementById("txtSalesno2").value = $('#txtSalesno').val();
					wParent.getElementById("txtSales2").value = $('#txtSales').val();
				}
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 200px;
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
                width: 600px;
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
            .tbbm tr td {
                width: 10%;
            }
            .tbbm .trX {
                background-color: #FFEC8B;
            }
            .tbbm .trY {
                background-color: #DAA520;
            }
            .tbbm .tdZ {
                width: 1%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            }
            .dbbs {
                width: 1200px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }

        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                	<tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id="vewNoa"> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id="vewNick"> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox"/></td>
                        <td id="noa" style="text-align: center;">~noa</td>
                        <td id="nick" style="text-align: center;">~nick</td>
                    </tr>
				</table>
			</div>
			<div class="dbbm">
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan='3'><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNick' class="lbl"> </a></td>
						<td><input id="txtNick" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBoss' class="lbl"> </a></td>
						<td><input id="txtboss" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblHead' class="lbl"> </a></td>
						<td><input id="txthead" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td><select id="cmbStatus" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTeam' class="lbl"> </a></td>
						<td><input id="txtTeam" type="text" class="txt c1"/></td>
						<td><input id="btnConn" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblGrp" class="lbl btn"> </a></td>
						<td>
							<input id="txtGrpno" type="text" style="float:left; width:40%;"/>
							<input id="txtGrpname" type="text" style="float:left; width:60%;"/>
						</td>
						<td><span> </span><a id='lblTeampaytype' class="lbl"> </a></td>
						<td><input id="txtTeampaytype" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblProfit' class="lbl"> </a></td>
						<td><input id="txtProfit" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan='5'><input id="txtTel" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan='3'><input id="txtFax" type="text" class="txt c7"/></td>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td><input id="txtMobile" type="text" class="txt c1"/></td>
					</tr>
					<tr class="isXY">
						<td><span> </span><a class="lbl isXY">連絡人員</a></td>
						<td colspan='3'><input id="textConn" type="text" class="txt c7 isXY "/></td>
						<td><span> </span><a class="lbl isXY">交貨時間</a></td>
						<td><input id="textTrantime" type="text" class="txt c1 isXY"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInvoicetitle' class="lbl"> </a></td>
						<td colspan='3'><input id="txtInvoicetitle" type="text" class="txt c7"/></td>
						<td><span> </span><a class="lbl isXY">發票開立</a></td>
						<td><input id="textIsinvo" type="text" class="txt c1 isXY"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_fact' class="lbl"> </a></td>
						<td><input id="txtZip_fact" type="text" class="txt c1"></td>
						<td colspan='4'><input id="txtAddr_fact" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_comp' class="lbl"> </a></td>
						<td><input id="txtZip_comp" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_comp" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_invo' class="lbl"> </a></td>
						<td><input id="txtZip_invo" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_invo" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_home' class="lbl"> </a></td>
						<td><input id="txtZip_home" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr_home" type="text" class="txt c7"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">E-mail</a></td>
						<td colspan='5'><input id="txtEmail" type="text" class="txt c7"/></td>
					</tr>

					
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='5'>
							<textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>