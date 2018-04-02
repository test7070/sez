<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script src="http://59.125.143.170/t_link/js/test.js" type="text/javascript"></script>
		<link href="http://59.125.143.170/t_link/css/test.css" rel="stylesheet" type="text/css" />
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();" >
		<!--#include file="../inc/toolbar.inc"-->
		<div id="divImport" style="position:absolute; top:100px; left:400px; display:none; width:400px; height:170px; background-color: pink; border: 5px solid gray;">
			<table style="width:100%;">
				<tr style="height:1px;">
					<td style="width:80px;"></td>
					<td style="width:220px;"></td>
					<td style="width:40px;"></td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblPrint_d" style="float:right; color: blue; font-size: medium;"> </a></td>
					<td colspan="4">
						<select id="combPrint" style="font-size: medium;width:80%;">
							<option value="barfe1-1.bat">白色、紫色</option>
							<option value="barfe1-2.bat">綠色</option>
							<option value="barfe1-3.bat">黃色、膚色</option>
							<option value="barfe1-4.bat">藍色、桃紅色</option>
							<option value="barfe2-1.bat">條碼2</option>
						</select>
					</td>
					<td></td>
					<td><input id="btnPrint_d" type="button" value="列印"/></td>
				</tr>
				<tr style="height:20px;">
					<td colspan="6"><a style="color:darkred;">&nbsp;&nbsp;&nbsp;&nbsp;【列印】有勾、【品名】有輸入的才會印。</a></td>
					<td><input id="btnCancel_d" type="button" value="關閉"/></td>
				</tr>
				<tr style="height:20px;"><td colspan="7"><a style="font-size:8px; color:darkblue;">Chrome 若無看見確認視窗</a></td></tr>
				<tr style="height:20px;"><td colspan="7"><a style="font-size:8px; color:darkblue;">請至【設定】->【隱私權】(內容設定)->【彈出視窗】(管理例外情況)</a></td></tr>
			</table>
		</div>
		<div id="divChk" style="position:absolute; top:100px; left:400px; display:none; width:400px; height:80px; background-color: pink; border: 5px solid gray;">
			<table style="width:100%;">
				<tr style="height:1px;">
					<td style="width:80px;"></td>
					<td style="width:220px;"></td>
					<td style="width:40px;"></td>
				</tr>
				<tr style="height:20px;">
					<td><span> </span><a id="lblChecker" class="lbl">複檢人</a></td>
					<td><input id="textChecker" type="text" class="txt c1"/></td>
					<td><input id="btnCancel_c" type="button" value="關閉"/></td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewCust'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:100px; color:black;"><a id='vewOdate'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='odate' style="text-align: center;">~odate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblOdate" class="lbl"> </a></td>
						<td><input id="txtOdate"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtCustno"  type="text"  class="txt" style="width:45%;float:left;"/>
							<input id="txtCust"  type="text"  class="txt" style="width:55%;float:left;"/>
							<input id="txtNick"  type="text"  class="txt" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblTrantype" class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1"></select></td>
						<td><select id="cmbTrantype1" class="txt c1"></select></td>
						<td><select id="cmbTrantype2" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSite" class="lbl"> </a></td>
						<td colspan="2"><input id="txtSite"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblTagcolor" class="lbl"> </a></td>
						<td><select id="cmbTagcolor" class="txt c1"></select></td>
						<td><span> </span><a id="lblTolerance" class="lbl"> </a></td>
						<td><input id="txtTolerance"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="2" rowspan="2"><textarea id="txtMemo" class="txt c1" rows="3"></textarea></td>
						<td><span> </span><a id="lblChktype" class="lbl"> </a></td>
						<td><input id="txtChktype"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount"  type="text"  class="num txt c1"/></td>
					</tr>
					<tr>
						<td></td>
						<td style="text-align: center;"><input type="button" id="btnBarcode" value="條碼列印" /></td>
						<td>
							<input type="button" id="btnChecker" value="複檢人" />
							<input id="txtChecker" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text"  class="num txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><input type="button" id="btnCont" value="合約匯入" /></td>
						<td><span> </span><a id="lblOrdeno" class="lbl btn"> </a></td>
						<td>
							<input id="txtOrdeno"  type="text"  class="txt c1"/>
							<input id="txtOrdeaccy"  type="text"  style="display:none;"/>
							<input type="button" id="btnOrde" value="轉訂單" style="display:none;"/>
						</td>
					</tr>				
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:20px;">列印<input class="checkAll" type="checkbox" onclick="checkAll()"/></td>
					<td style="width:380px;"><a id='lbl_product'>品名</a><br><a id='lbl_memo'>備註</a></td>
					<td style="width:80px;"><a id='lbl_pic'>位置</a></td>
					<td style="width:170px;"><a id='lbl_pic'>形狀</a></td>
					<td style="width:80px;"><a id='lbl_picno'>形狀<br>編號</a></td>
					<td style="width:60px;"><a id='lbl_imgparaa'>參數A</a></td>
					<td style="width:60px;"><a id='lbl_imgparab'>參數B</a></td>
					<td style="width:60px;"><a id='lbl_imgparac'>參數C</a></td>
					<td style="width:60px;"><a id='lbl_imgparad'>參數D</a></td>
					<td style="width:60px;"><a id='lbl_imgparae'>參數E</a></td>
					<td style="width:60px;"><a id='lbl_imgparaf'>參數F</a></td>
					<td style="width:80px;"><a id='lbl_lengthb'>長度</a><br><a id='lbl_monnt'>數量</a><br><a id='lbl_weight'>重量</a></td>
					<td style="width:150px;"><a id='lbl_mech'>機台</a></td>
					<td style="width:100px;"><a id='lbl_place'>儲位</a></td>
					<td style="width:180px;"><a id='lbl_timea'>加工時間</a></td>
					<td style="width:100px;"><a id='lbl_worker'>入庫人員</a></td>
					<td style="width:180px;"><a id='lbl_cont'>合約單號</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td align="center"><input id="checkIsprint.*" class="justPrint" type="checkbox"/></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:35%; float:left;"/>
						<input class="txt" id="txtProduct.*" type="text" style="width:60%;float:left;"/>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%;" title="備註輸入 * ，單支長可手動輸入。"/>
						<input class="txt" id="txtCmount.*" type="text" style="display:none;"/>
						<input class="txt" id="txtCweight.*" type="text" style="display:none;"/>
						<input id="btnProduct.*" type="button" style="display:none;">
					</td>
					<td><input class="txt" id="txtPlace.*" type="text" style="width:95%;" title=""/></td>
					<td>
						<img id="imgPic.*" src="" style="width:150px;height:50px;"/>
						<textarea id="txtImgdata.*" style="display:none;"> </textarea>
					</td>
					<td>
						<input class="txt" id="txtPicno.*" type="text" style="width:95%;"/>
						<input class="txt" id="txtPara.*" type="text" style="display:none;"/>
						<input id="btnPicno.*" type="button" style="display:none;">
					</td>
					<td style="background-color: burlywood;"><input class="txt" id="txtParaa.*" type="text" style="width:95%;text-align: right;"/></td>
					<td style="background-color: burlywood;"><input class="txt" id="txtParab.*" type="text" style="width:95%;text-align: right;"/></td>
					<td style="background-color: burlywood;"><input class="txt" id="txtParac.*" type="text" style="width:95%;text-align: right;"/></td>
					<td style="background-color: burlywood;"><input class="txt" id="txtParad.*" type="text" style="width:95%;text-align: right;"/></td>
					<td style="background-color: burlywood;"><input class="txt" id="txtParae.*" type="text" style="width:95%;text-align: right;"/></td>
					<td style="background-color: burlywood;"><input class="txt" id="txtParaf.*" type="text" style="width:95%;text-align: right;"/></td>
					<td><input class="txt" id="txtLengthb.*" type="text" style="width:95%;text-align: right;" title="備註輸入 * ，單支長可手動輸入。"/>
						<input class="txt" id="txtMount.*" type="text" style="width:95%;text-align: right;"/>
						<input class="txt" id="txtWeight.*" type="text" style="width:95%;text-align: right;"/>
					</td>
					<td>
						<select id="cmbMech1.*" style="width:95%; height:28px;"> </select>
						<select id="cmbMech2.*" style="width:95%; height:28px;"> </select>
						<select id="cmbMech3.*" style="width:95%; height:28px;"> </select>
						<select id="cmbMech4.*" style="width:95%; height:28px;"> </select>
						<select id="cmbMech5.*" style="width:95%; height:28px;"> </select>
					</td>
					<td>
						<input class="txt" id="txtPlace1.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtPlace2.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtPlace3.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtPlace4.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtPlace5.*" type="text" style="width:95%;padding: 0px;"/>
					</td>
					<td>
						<input class="txt" id="txtTime1.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtTime2.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtTime3.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtTime4.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtTime5.*" type="text" style="width:95%;padding: 0px;"/>
					</td>
					<td>
						<input class="txt" id="txtWorker1.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtWorker2.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtWorker3.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtWorker4.*" type="text" style="width:95%;padding: 0px;"/>
						<input class="txt" id="txtWorker5.*" type="text" style="width:95%;padding: 0px;"/>
					</td>
					<td>
						<input class="txt" id="txtContno.*" type="text" style="float:left;width:120px;"/>
						<input class="txt" id="txtContnoq.*" type="text" style="float:left;width:35px;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="display:noxne;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:20px;"> </td>
						<td style="width:20px;">列印<input class="checkAll2" type="checkbox" onclick="checkAll2()"/></td>
						<td style="width:200px; text-align: center;">批號</td>
						<td style="width:200px; text-align: center;">品名</td>
						<td style="width:100px; text-align: center;">數量</td>
						<td style="width:100px; text-align: center;">重量</td>
						<td style="width:200px; text-align: center;">餘料批號</td>
						<td style="width:80px; text-align: center;">長度</td>
						<td style="width:100px; text-align: center;">餘料數量</td>
						<td style="width:100px; text-align: center;">餘料重量</td>
						<td style="width:100px; text-align: center;">儲位</td>
						<td style="width:200px; text-align: center;">備註/爐號</td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td align="center"><input id="checkIsprint..*" class="justPrint2" type="checkbox"/></td>
						<td>
							<input class="txt" id="txtUno..*" type="text" style="width:95%;"/>
							<input id="btnUno..*" type="button" style="display:none;">
						</td>
						<td>
							<input class="txt" id="txtProductno..*" type="text" style="width:45%;float:left;"/>
							<input class="txt" id="txtProduct..*" type="text" style="width:45%;float:left;"/>
							<input id="btnProduct..*" type="button" style="display:none;">
						</td>
						<td><input class="txt" id="txtGmount..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtGweight..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtBno..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtLengthb..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtMount..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtWeight..*" type="text" style="width:95%;text-align: right;"/></td>
						<td>
							<input class="txt" id="txtPlace..*" type="text" style="width:95%;" />
							<input class="txt" id="txtStoreno..*" type="text" style="display:none;"/>
							<input class="txt" id="txtStore..*" type="text" style="display:none;"/>
							<input id="btnStore..*" type="button" style="display:none;">
						</td>
						<td><input class="txt" id="txtMemo..*" type="text" style="width:95%;" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>