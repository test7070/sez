<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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

			var q_name = "fixb";
			var q_readonly = ['txtNoa','txtWorker'];
			var bbmNum = [['txtMile',10,0],['txtLmile',10,0],['txtNmile',10,0]];
			var bbmMask = [['txtDatea','999/99/99'],['txtLdate','999/99/99'],['txtNdate','999/99/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc=1;
			aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa', 'txtCarno', 'car2_b.aspx']);

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
				bbmMask = [['txtDatea', r_picd],['txtLdate', r_picd],['txtNdate', r_picd]];
				q_mask(bbmMask);
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
						break;
				}  /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('fixb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
			}

			function btnModi() {
				if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
			}

			function btnPrint() {
				q_box('z_fixb.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {	
				$('#txtWorker').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll('FIB'+(t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
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
                width: 60%;
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
                width: 10%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
            .tbbs input[type="text"] {
                width: 95%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:15%"><a id='vewCarno'></a></td>
						<td align="center" style="width:15%"><a id='vewMile'></a></td>
						<td align="center" style="width:15%"><a id='vewDatea'></a></td>
						<td align="center" style="width:50%"><a id='vewItem'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='carno'>~carno</td>
						<td align="center" id='mile'>~mile</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='item'>~item</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td colspan="2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id='lblCarno' class="lbl"></a></td>
						<td colspan="2">
						<input id="txtCarno"  type="text"  class="txt c1"/>
						</td>
					</tr>
					
					<tr>
						<td colspan="2"><span> </span><a id="lblItemno" class="lbl"></a></td>
						<td colspan="2">
						<input id="txtItemno"  type="text"  class="txt c1"/>
						</td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblItem" class="lbl"></a></td>
						<td colspan="2">
						<input id="txtItem"  type="text"  class="txt c1"/>
						</td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblMile" class="lbl"></a></td>
						<td>
						<input id="txtMile"  type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblLdate" class="lbl"></a></td>
						<td>
						<input id="txtLdate"  type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblLmile" class="lbl"></a></td>
						<td>
						<input id="txtLmile"  type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblNdate" class="lbl"></a></td>
						<td>
						<input id="txtNdate"  type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id='lblNmile' class="lbl"></a></td>
						<td class="td2">
						<input id="txtNmile"  type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblWorker" class="lbl"></a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
