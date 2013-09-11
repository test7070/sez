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

			var q_name = "oilbase";
			var q_readonly = [];
			var bbmNum = [['txtPrice1', 10, 3], ['txtPrice2', 10, 3], ['txtPrice3', 10, 3], ['txtPrice4', 10, 3], ['txtPrice5', 10, 3], ['txtPrice', 10, 3]];
			var bbmMask = [['txtNoa', '999/99'],['txtMon', '999/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc  =  1;
			brwCount2 = 12;
			//ajaxPath = ""; //  execute in Root

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

				q_box('oilbase_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNoa').focus();
			}

			function btnPrint() {
				q_box('z_oil.aspx' + "?;;;;" + r_accy, '', "95%", "600px", q_getMsg("popPrint"));
			}

			function btnOk() {
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				if ($('#txtNoa').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtNoa').val())){
					alert(q_getMsg('lblNoa')+'錯誤。');   
					return;
				} 
				var t_n=0,t_price1=0,t_price2=0,t_price3=0,t_price4=0,t_price5=0,t_price=0;
				t_price1 = parseFloat($.trim($('#txtPrice1').val()).length == 0 ? '0' : $('#txtPrice1').val().replace(/,/g,''));
				t_price2 = parseFloat($.trim($('#txtPrice2').val()).length == 0 ? '0' : $('#txtPrice2').val().replace(/,/g,''));
				t_price3 = parseFloat($.trim($('#txtPrice3').val()).length == 0 ? '0' : $('#txtPrice3').val().replace(/,/g,''));
				t_price4 = parseFloat($.trim($('#txtPrice4').val()).length == 0 ? '0' : $('#txtPrice4').val().replace(/,/g,''));
				t_price5 = parseFloat($.trim($('#txtPrice5').val()).length == 0 ? '0' : $('#txtPrice5').val().replace(/,/g,''));
				
				t_n =  (t_price1==0?0:1)+(t_price2==0?0:1)+(t_price3==0?0:1)+(t_price4==0?0:1)+(t_price5==0?0:1)
				if(t_n>0)
					t_price=round((t_price1+t_price2+t_price3+t_price4+t_price5)/t_n,3);
	
				$('#txtPrice').val(t_price);
				
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				$('#txtMon').val($('#txtNoa').val());
				var t_noa = $('#txtNoa').val();
				if(t_noa.length>0)
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
                width: 500px; 
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
                width: 450px;
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
                width: 15%;
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
                width: 98%;
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
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>			
						<td align="center" style="width:60px; color:black;"><a id='vewMon'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewPrice1'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewPrice2'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewPrice3'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewPrice4'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewPrice5'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewPrice'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='price1' style="text-align: right;">~price1</td>
						<td id='price2' style="text-align: right;">~price2</td>
						<td id='price3' style="text-align: right;">~price3</td>
						<td id='price4' style="text-align: right;">~price4</td>
						<td id='price5' style="text-align: right;">~price5</td>
						<td id='price' style="text-align: right;">~price</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td>
							<input id="txtNoa"  type="text"  class="txt c1"/>
							<input id="txtMon"  type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice1' class="lbl"> </a></td>
						<td><input id="txtPrice1"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice2' class="lbl"> </a></td>
						<td><input id="txtPrice2"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice3' class="lbl"> </a></td>
						<td><input id="txtPrice3"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice4' class="lbl"> </a></td>
						<td><input id="txtPrice4"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice5' class="lbl"> </a></td>
						<td><input id="txtPrice5"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice"  type="text"  class="txt num c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
