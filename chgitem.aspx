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

			var q_name = "chgitem";
			var q_readonly = ['txtWorker'];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//ajaxPath = ""; //  execute in Root
			aPop = new Array(['txtAcc1', 'lblAcc', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
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
			    q_mask(bbmMask);
			    
                $('#txtAcc1').change(function () {
			        var s1 = trim($(this).val());
			        if (s1.length > 4 && s1.indexOf('.') < 0)
			            $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
			        if (s1.length == 4)
			            $(this).val(s1 + '.');
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

						if (q_cur == 1 || q_cur == 2)
							q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

						break;
				}  /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('chgitem_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtAcc1').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;

				_btnModi();
				$('#txtNoa').attr('readonly',true);
				$('#txtAcc1').focus();
			}

			function btnPrint() {

			}

			function btnOk() {
				$('#txtWorker').val(r_name);	
				var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				var t_noa = trim($('#txtNoa').val());
				
				if (t_noa.length == 0)
					return;
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
                width: 35%;
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
                width: 60%;
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
						<td align="center" style="width:7%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:25%"><a id='vewItem'> </a></td>
						<td align="center" style="width:25%"><a id='vewAcc2'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td align="center" id='noa'>~noa</td>
						<td id='item' style="text-align:left;">~item</td>
						<td id='acc2' style="text-align:left;">~acc2</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl">  </a></td>
						<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td class="td3"> </td>
						<td class="td4"> </td>
						<td class="td5"> </td>
						<td class="td6"> </td>
						<td class="td7"> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td class="td3"><span> </span><a id="lblAcc" class="lbl btn" >  </a></td>
						<td class="td4"  colspan="3">
						<input id="txtAcc1" type="text"  class="txt c2"/>
						<input id="txtAcc2"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblItem' class="lbl">  </a></td>
						<td class="td2"  colspan="2"><input id="txtItem" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblPrice' class="lbl">  </a></td>
						<td class="td2">
						<input id="txtPrice" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td class="td3"><span> </span><a id="lblPricepay" class="lbl">  </a></td>
						<td class="td4">
						<input id="txtPricepay" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td class="td5"><span> </span><a id="vewIsfix"  class="lbl">  </a></td>
						<td class="td6"><input id="chkIsfix" type="checkbox" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblMemo" class="lbl">  </a></td>
						<td class="td2" colspan='5'><input id="txtMemo"  type="text" class="txt c1" /></td>
						
					</tr>
					<tr> 
						<td class="td5"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td6"><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
					<tr> </tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
