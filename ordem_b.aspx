<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'ordem', t_bbsTag = 'tbbs', t_bbtTag = 'tbbt', t_content = " ", afilter = [], t_count = 0, as, brwCount2=15;
			var t_sqlname = ''; t_postname = q_name ; 
			var isBott = false;  /// 是否已按過 最後一頁
			var afield, t_htm;
			var i, s1;
			var q_readonly = [];
			var q_readonlys = [];
			var q_readonlyt = [];
			var bbmNum = []; 
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			var bbmKey = ['noa'];
			var bbsKey = ['noa', 'noq'];
			var bbtKey = ['noa', 'noq'];
			q_tables = 't';
			$(document).ready(function () {
				if (!q_paraChk())
					return;
				main();
			});			/// end ready

			function main() {
				if (dataErr)  /// 載入資料錯誤
				{
					dataErr = false;
					return;
				}
				q_getId();
				mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
			}

			function mainPost(){
				q_cmbParse("combUsage", q_getPara('ordem.usage'));
			}

			function bbsAssign() {  /// 表身運算式
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					$('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
				}
				_bbsAssign();
			}
			
			function bbtAssign() {
				for (var j = 0; j < (q_bbtCount == 0 ? 1 : q_bbtCount); j++) {
					$('#btnMinus__' + j).click(function () { btnMinus($(this).attr('id'), '__'); });
				} //j

				_bbtAssign();
			 }

			function btnOk() {
				t_key = q_getHref();
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}
			
			function bbsSave(as,table) {
				var t_key = bbmKey[0];
				var t_noa = $('#txtNoa').val();
				switch (table) {
					case 'ordemt':
						if (!as['pack']) {  // Dont Save Condition
							as[t_key] = '';   /// noa  empty --> dont save
							return false;
							break;
						}
						as[t_key] = t_noa;
						break;
					default:
						if (!as['manu']) {  // Dont Save Condition
							as[t_key] = '';   /// noa  empty --> dont save
							return false;
							break;
						}
						as[t_key] = t_noa;
				}
				return true;
			}
/*
			function btnModi() {
				_btnModi();
			}
*/
			function q_gtPost(t_postname) {
			}

			function combUsage_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
				var cmb = document.getElementById("combUsage")
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtUsage').val(cmb.value);

				cmb.value = '';
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

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }
			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
			}

</script>
<style type="text/css">
	.seek_tr
	{color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
			.column1
		{		   width: 18%;		}
		.column2
		{			width: 15%;		}	  
		.column3
		{			width: 33%;		}   
		.label1
		{			width: 10%;text-align:right;		}	   
		.label2
		{			width: 10%;text-align:right;		}
		.label3
		{			width: 10%;text-align:right;		}
</style>
</head>
<body>
<div class='dbbm' style="width: 68%;float: left;">
<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
	<tr>
		<td class="lable1"  align="right"><a id='lblUsage'></a></td>
		<td class="column1" ><input id="txtUsage" maxlength='30' type="text"  style='width:50%;'/><select id="combUsage" style='width:45%;'  onchange='combUsage_chg()' /></td>
		<td class="label2" align="right" ><a id='lblProductno'></a></td>
		<td class="column2"><input id="txtProductno" maxlength='30' type="text"  style='width:100%;'/></td>
		<td class="label3" align="right"><a id='lblOrdcno'></a></td>
		<td class="column3" ><input id="txtOrdcno"   type="text"  maxlength='30'   style='width:85%;'/></td> 
	</tr>
	<tr>
		<td class="label1"  align="right"><a id='lblModel'></a></td>
		<td class="column1" ><input id="txtModel" maxlength='30' type="text"  style='width:100%;'/></td>
		<td class="label2" align="right" ><a id='lblRdate'></a></td>
		<td class="column2"><input id="txtRdate" maxlength='30' type="text"  style='width:100%;'/></td>
		<td class="label3" align="right"><a id='lblPacks'></a></td>
		<td class="column3" ><input id="txtPacks"   type="text"  maxlength='30'   style='width:85%;'/>
		 <input id="txtNoa" type="text"  style='visibility: hidden;width:5%;'/></td>
	</tr>
</table>
</div>
<div  id="dbbs"  style="float: left;  width:45%;"  >
		<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100% '  >
			<tr style='color:White; background:#003366;' >
				<td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;" /> </td>
				<td align="center"><a id='lblManuno'></a></td>
				<td align="center"><a id='lblManu'></a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold; "  /></td>
				<td style="width:6%;"><input class="txt"  id="txtManuno.*" maxlength='30'type="text" style="width:98%;"   /></td>
				<td style="width:6%;"><input class="txt" id="txtManu.*" type="text" maxlength='90' style="width:98%;"   />
				<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
			</tr>
		</table>
</div>
<div  id="dbbt"  style="float: left;  width:45%;"  >
		<table id="tbbt" class='tbbt'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
			<tr  style='color:White; background:#009999;' >
				<td align="center"><input class="btn"  id="btnPlut" type="button" value='＋' style="font-weight: bold;"  /> </td>
				<td align="center"><a id='lblPackno'></a></td>
				<td align="center"><a id='lblPack'></a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td style="width:1%;"><input class="btn"  id="btnMinut..*" type="button" value='－' style="font-weight: bold; "  /></td>
				<td style="width:6%;"><input class="txt"  id="txtPackno..*" maxlength='30'type="text" style="width:98%;"  /></td>
				<td style="width:6%;"><input class="txt" id="txtPack..*" type="text" maxlength='90' style="width:98%;" />
				<input id="txtNoq..*" type="hidden" /><input id="recno..*" type="hidden" /></td>
			</tr>
		</table>
</div>

<!--#include file="../inc/pop_modi.inc"--> 

<input id="q_sys" type="hidden" />
</body>
</html>

