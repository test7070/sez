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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script src="http://59.125.143.170/t_link/js/test.js"></script>
		<link href="http://59.125.143.170/t_link/css/test.css" rel="stylesheet" type="text/css" />
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm" id="tbbm">
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
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td>
							<select id="cmbTypea" class="txt" style="width:40%;"> </select>
							<select id="cmbStype" class="txt" style="width:60%;" onChange="return showdiv(this)"> </select>
						</td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td> </td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="tdZ">
							<input type="button" id="btnTip" value="?" style="float:right;" onclick="tipShow()"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td colspan="2">
							<input type="checkbox" id="chkIsgenvcca" style="float:left;"/>
							<a id='lblIsgenvcca' class="lbl" style="float:left;"> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCno" type="text" style="float:left;width:25%;"/>
							<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<td><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
						<td colspan="2"><input id="txtInvono" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCustno" type="text" style="float:left;width:25%;"/>
							<input id="txtComp" type="text" style="float:left;width:75%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtOrdeno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="4"><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
							<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost" type="text" style="float:left; width:70px;"/>
							<input id="txtAddr" type="text" style="float:left; width:369px;"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="4" >
							<input id="txtPost2" type="text" style="float:left; width:70px;"/>
							<input id="txtAddr2" type="text" style="float:left; width:347px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtPaytype" type="text" style="float:left; width:87%;"/>
							<select id="combPaytype" style="float:left; width:26px;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCardealno" type="text" style="float:left;width:25%;"/>
							<input id="txtCardeal" type="text" style="float:left;width:75%;" />
						</td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtCarno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td><input id="txtTotalus" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td>
							<span style="float:left;display:block;width:10px;"> </span>
							<select id="cmbCoin" style="float:left;width:80px;" onchange='coin_chg()'> </select>
						</td>
						<td><input id="btnOrdeno" type="button" class="lbl"/></td>
						<td colspan="2">
							<input id="btnImportVcce" type="button"/>
							<input id="btnVcceImport" type="button" title="cut cubu"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
							<input id="txtTax" type="text" class="txt num c1" />
							<input id="txtVccatax" type="text" class="txt num c1 istax" style="display:none;" />
						</td>
						<td>
							<span style="float:left;display:block;width:10px;"> </span>
							<select id="cmbTaxtype" style="float:left;width:80px;" onchange="calTax();"> </select>
						</td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1 " /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblPrices' class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
						<td><input id="txtTranmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1"/></td>
						<td class="benifit" style="display: none;"><span> </span><a id="lblBenifit" class="lbl"> </a></td>
						<td class="benifit" style="display: none;"><input id="txtBenifit" type="text" class="txt num c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:230px;"><a id="lblUno_st" > </a></td>
					<td align="center" style="width:120px;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProduct_st'> </a></td>
					<td align="center" id="Size" class="SizeA"><a id='lblSize_help'> </a><BR><a id='lblSize_st'> </a></td>
					<td align="center" style="width:400px;" class="rs_hide"><a id='lblSizea_st'> </a></td>
					<td align="center" style="width:30px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWeight_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrices_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotal_s'> </a><br><a id='lblTheory'> </a></td>
					<td align="center" style="width:100px;"><a id='lblGweight_st'> </a></td>
					<td align="center" style="width:60px;">寄Y<BR>代Z</td>
					<td align="center" style="width:80px;"><a id='lblStore2_st'> </a></td>
					<td align="center" style="width:230px;"><a id='lblMemos_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn" id="btnUno.*" type="button" value='.' style="width:10%;"/>
						<input id="txtUno.*" type="text" style="width:80%;"/>
					</td>
					<td>
						<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:15px;float:left;" />
						<input id="txtProductno.*" type="text" style="width:85px;" />
						<span style="display:block;width:15px;"> </span>
						<input id="txtClass.*" type="text" style='width: 85px;'/>
					</td>
					<td><input type="text" id="txtStyle.*" style="width:85%;text-align:center;" /></td>
					<td><input type="text" id="txtProduct.*" style="width:95%;" /></td>
					<!--<td><input class="txt c1" id="txtSpec.*" type="text"/></td>-->
					<td class="SizeA"  id="Sizes" >
						<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >x</div>
						<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize4.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="text" style="display:none;"/>
						<input id="txtWidth.*" type="text" style="display:none;"/>
						<input id="txtDime.*" type="text" style="display:none;"/>
						<input id="txtLengthb.*" type="text" style="display:none;"/>
						<input id="txtSpec.*" type="text" style="float:left;"/>
					</td>
					<td class="rs_hide"><input id="txtSize.*" type="text" style="width:95%;" /></td>
					<td><input id="txtUnit.*" type="text" class="txt num" style="width:95%;text-align: center;"/></td>
					<td><input id="txtMount.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input id="txtPrice.*" type="text" class="txt num" style="width:95%;"/></td>
					<td>
						<input id="txtTotal.*" type="text" class="txt num" style="width:95%;"/>
						<input id="txtTheory.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td><input id="txtGweight.*" type="text" class="txt num" style="width:95%;"/></td>
					<td><input class="txt" id="txtUsecoil.*" type="text" style="text-align:center;width:95%;"/></td>
					<td>
						<input class="btn" id="btnStoreno2.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;display:none;" />
						<input id="txtStoreno2.*" type="text" style="width:95%;" />
						<input id="txtStore2.*" type="text" style='width: 95%;'/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" class="txt" style="width:95%;"/>
						<input id="txtOrdeno.*" type="text" style="width:65%;" />
						<input id="txtNo2.*" type="text" style="width:20%;" />
						<input id="recno.*" type="hidden" />
						<input id="txtNoq.*" type="text" style='display: none;'/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>