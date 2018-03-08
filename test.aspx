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
		<script src="http://59.125.143.170/t_link/js/test.js" type="text/javascript"></script>
		<link href="http://59.125.143.170/t_link/css/test.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
            <table id="table_stk" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
                <tr>
                    <td style="background-color: #f8d463;" align="center"><span> </span><a id="lblProductno"></a></td>
                    <td style="background-color: #f8d463;" colspan="2" id='stk_productno'> </td>
                </tr>
                <tr>
                    <td style="background-color: #f8d463;" align="center"><span> </span><a id="lblProduct"></a></td>
                    <td style="background-color: #f8d463;" colspan="2" id='stk_product'> </td>
                </tr>
                <tr id='stk_top'>
                    <td align="center" style="width: 30%;"><span> </span><a id="lblStoreno"></a></td>
                    <td align="center" style="width: 45%;"><span> </span><a id="lblStore1"></a></td>
                    <td align="center" style="width: 25%;"><span> </span><a id="lblStoremount"></a></td>
                </tr>
                <tr id='stk_close'>
                    <td align="center" colspan='3'>
                        <input id="btnClose_div_stk" type="button" value="關閉視窗">
                    </td>
                </tr>
            </table>
        </div>
        <div id="dmain" style="width: 1400px;" ><!--#include file="../inc/toolbar.inc"-->
            <div class="dview" id="dview" >
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td align="center" style="width:5%"><a id='vewType'> </a></td>
                        <td align="center" style="width:24%"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:25%"><a id='vewNoa'> </a></td>
                        <td align="center" style="width:30%"><a id='vewComp'> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='typea=vcc.typea'>~typea=vcc.typea</td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='noa'>~noa</td>
                        <td align="center" id='nick'>~nick</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'><!--- style="width: 900px;"--->
                <table class="tbbm" id="tbbm" style="width:1000px;height: 362px;" border="2">
                    <tr>
                        <td width="70%">
                            <table border="0" >
                                <tr>
                                    <td colspan="10">
										<span> </span><font size="6"><b><a id="lblFromname"></b></font>
											<input style="float: right;" class="btn" id="btnvcctype" onClick="btnvcctype()" type="button" value='退貨' />
										<hr>
									</td>
                                </tr>
                                <tr>
                                    <td width="115px"></td>
                                    <td width="200px"></td>
                                    <td width="150px"></td>
                                    <td width="100px"></td>
                                    <td width="100px"></td>
                                    <td width="80px"></td>
                                    <td width="70px"></td>
                                    <td width="70px"></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                                    <td><input id="txtNoa" type="text" class="txt c1" /></td>
                                    <td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                                    <td><input id="txtDatea" type="text" class="txt c1" style="width: 80px;float: left;"/></td>
                                    <td><span> </span><a id="lblMon" class="lbl"> </a></td>
                                    <td><input id="txtMon" type="text" class="txt c1" style="width: 75px;float: left;"/></td>
                                    <td><span> </span><a id="lblType" class="lbl"> </a></td>
                                    <td><select id="cmbTypea"> </select></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
                                    <td><input id="txtCno" type="text" class="txt c1"/></td>
                                    <td colspan="6"><input id="txtAcomp" type="text" class="txt c1"/></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
                                    <td><input id="txtCustno" type="text" class="txt c1"/></td>
                                    <td colspan="4">
                                        <input id="txtComp" type="text" class="txt c1" style="width:65%;" placeholder="客戶名稱"/>
                                        <input id="txtNick" type="text" class="txt c1" style="width:35%;" placeholder="客戶簡稱"/>
                                    </td>
                                    <td colspan="2"><input id="txtTel" type="text" class="txt c1" placeholder="客戶電話"/></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
                                    <td><input id="txtSalesno" type="text" class="txt c1"/></td>
                                    <td><input id="txtSales" type="text" class="txt c1"/></td>
                                    <td><span> </span><a id="lblStore" class="lbl btn"> </a></td>
                                    <td colspan="2">
                                        <input id="txtStoreno" type="text" class="txt c1" style="width:49%;"/>
                                        <input id="txtStore" type="text" class="txt c1" style="width:49%;"/>
                                    </td>
                                    <td colspan="2">　</td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblMemo" class="lbl"> </a></td>
                                    <td colspan="7"><textarea id="txtMemo" cols="10" rows="5" style="width:99%;height:50px;"> </textarea></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblOrdeno" class="lbl"></a></td>
                                    <td><input id="txtOrdeno" type="text" class="txt c1" placeholder="AUTO" /></td>
                                    <td><span> </span><a id="lblWorker" class="lbl"></a></td>
                                    <td><input id="txtWorker" type="text" class="txt c1" /></td>
                                    <td><input id="txtWorker2" type="text" class="txt c1" /></td>
                                    <td>　</td>
                                    <td>　</td>
                                    <td>　</td>
                                </tr>
                            </table>
                        </td>
                        <td width="30%">
                            <table border="0">
                                <tr>
									<td>　　　　　　　</td>
									<td></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
										<input id="chkIsgenvcca" type="checkbox" checked class="lbl" style="float:left;" />
										<a id="lblIsgenvcca" class="lbl1"> </a>
									</td>
                                </tr>
                                <tr>
                                    <td width="30%"><a id="lblInvono" class="lbl btn vcca"> </a></td>
                                    <td><input id="txtInvono" type="text" class="txt c1 vcca" style="width:55%;"/></td>
                                </tr>
                                
                                <tr>
                                    <td><span> </span><a id="lblPay" class="lbl"> </a></td>
                                    <td>
                                        <input id="txtPaytype" type="text" class="txt c1" style="width:30%;"/>
                                        <select id="combPay" style="width:12%;" onchange="combPay_chg()"> </select>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td><span> </span><a id="lblTranmoney" class="lbl"> </a></td>
                                    <td><input id="txtTranmoney" type="text" class="txt num c1" style="width:50%;"/></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblMoney" class="lbl"> </a></td>
                                    <td><input id="txtMoney" type="text" class="txt num c1" style="width:50%;"/></td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblTax" class="lbl"> </a></td>
                                    <td>
                                        <input id="txtTax" type="text" class="txt num c1 istax" style="width: 40%;"/>
                                        <select id="cmbTaxtype" style="width:40%;" onchange="calTax();"> </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span> </span><a id="lblTotal" class="lbl istax"> </a></td>
                                    <td><input id="txtTotal" type="text" class="txt num c1 istax" style="width:50%;"/></td>
                                </tr>
                                <tr>
                                    <td><a class="lbl" id="lblType1"></a></td>
                                    <td><input id="txtZipname" type="text" class="txt c1" style="width:30%;"/>
										<select id="cmbStatus" style="width: 12%;" onchange="combStatus_chg();"></select>
									</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs' style="width: 1350px;">
            <table id="tbbs" class='tbbs'>
                <tr style='color:White; background:#003366;' >
                    <td align="center" style="width:40px;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;width:" /></td>
                    <td align="center" style="width:139px"><a id='lblProductno_s'> </a></td>
                    <td align="center" style="width:350px;"><a id='lblProduct_s'> </a></td>
                    <td align="center" style="width:95px;" class="isStyle"><a id='lblStyle_s'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblTotal_s'> </a></td>
                    <td align="center" style="display: none;"><a id='lblStore_s'> </a></td>
                    <td align="center" style="width:100px;" class="isRack"><a id='lblRackno_s'> </a></td>
                    <td align="center" ><a id='lblMemo_s'> </a></td>
                    <td align="center" style="width:40px;"><a id='lblStk_s'> </a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                    <td align="center">
                        <input class="txt c1"  id="txtProductno.*" type="text" />
                        <input id="txtNoq.*" type="text" class="txt c6"/>
                        <input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
                    </td>
                    <td>
                        <input id="txtProduct.*" type="text" class="txt c1" />
                        <input id="txtSpec.*" type="text" class="txt c1 isSpec" />
                    </td>
                    <td class="isStyle"><input id="txtStyle.*" type="text" class="txt c1"/></td>
                    <td><input id="txtMount.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtPrice.*" type="text" class="txt num c1"/></td>
                    <td><input id="txtTotal.*" type="text" class="txt num c1"/></td>
                    <td style="display: none;">
                        <input id="txtStoreno.*" type="text" class="txt c1" style="width: 75%"/>
                        <input class="btn" id="btnStoreno.*" type="button" style=" font-weight: bold;" />
                        <input id="txtStore.*" type="text" class="txt c1"/>
                    </td>
                    <td class="isRack">
                        <input class="btn"  id="btnRackno.*" type="button" value='.' style="float:left;" />
                        <input id="txtRackno.*" type="text" class="txt c1" style="width: 70%"/>
                    </td>
                    <td>
                        <input id="txtMemo.*" type="text" class="txt c1"/>
                        <select id="combOrdelist.*" style="width: 10%;"> </select>
                        <input id="txtNo2.*" type="text" class="txt" style="width:18%;"/>
                    </td>
                    <td align="center"><input class="btn" id="btnStk.*" type="button" value='.' style="width:1%;"/></td>
                </tr>
            </table>
        </div><input id="q_sys" type="hidden" />
    </body>
</html>