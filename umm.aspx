<%@ Page Language="C#" AutoEventWireup="true" %>
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
			q_desc = 1
            q_tables = 's';
            var q_name = "umm";
            var q_readonly = ['txtComp', 'txtAcomp', 'txtTotal', 'txtTotalus'];
            var q_readonlys = [];
            var bbmNum = [['txtFloata', 7, 2], ['txtTotalus', 12, 2], ['txtPaysaleus', 12, 2], ['txtUnpayus', 12, 2], ['txtTotal', 10, 0], ['txtPaysale', 10, 0], ['txtUnpay', 10, 0]];
            var bbsNum = [];
            bbmMask = [];
            bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            //ajaxPath = "";

            aPop = new Array (['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], ['txtAcomp', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtVbdate', r_picd], ['txtVedate', r_picd],['txtMon',r_picm]];
                q_mask(bbmMask);
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                q_cmbParse("cmbTypea", q_getPara('umm.typea'));
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'ordes':
                        if(q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if(!b_ret || b_ret.length == 0)
                                return;
                            var i, j = 0;
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2', b_ret.length, b_ret, 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2', 'txtProductno,txtProduct,txtSpec');
                            bbsAssign();

                            for( i = 0; i < ret.length; i++) {
                                k = ret[i];
                                if(!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
                                    $('#txtMount_' + k).val(b_ret[i]['notv']);
                                    $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
                                } else {
                                    $('#txtWeight_' + k).val(b_ret[i]['notv']);
                                    $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv'], b_ret[i]['weight']));
                                }

                            }  /// for i
                        }
                        break;

                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
				$('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
           		}
				$('#txtVbdate').val($.trim($('#txtVbdate').val()));
                if (checkId($('#txtVbdate').val())==0){
                	alert(q_getMsg('lblVdate')+'錯誤。');
                	return;
           		}
				$('#txtVedate').val($.trim($('#txtVedate').val()));
                if (checkId($('#txtVedate').val())==0){
                	alert(q_getMsg('lblVdate')+'錯誤。');
                	return;
           		}
           		$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');   
					return;
				}         	
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);
                // 檢查空白
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                $('#txtWorker').val(r_name)
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('Q' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('umm_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                _bbsAssign();
                for(var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {

                } //j
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtCno').val('1');
                $('#txtAcomp').val(r_comp.substr(0, 2));
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['mon']) {
                    return;
                }

                q_nowf();
                as['typea'] = abbm2['typea'];
                as['mon'] = abbm2['mon'];
                as['noa'] = abbm2['noa'];
                as['datea'] = abbm2['datea'];
                as['custno'] = abbm2['custno'];

                /*t_err = '';
                 if(as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
                 t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';
                 if(as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
                 t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';
                 if(t_err) {
                 alert(t_err)
                 return false;
                 }*/

                return true;
            }

            function sum() {
                /*   var t1 = 0, t_unit, t_mount, t_weight = 0;
                var t_float = dec($('#txtFloata').val());
                t_float = (emp(t_float) ? 1 : t_float);
                for(var j = 0; j < q_bbsCount; j++) {
                t_unit = $('#txtUnit_' + j).val();
                t_mount = (!t_unit || emp(t_unit) || trim(t_unit).toLowerCase() == 'kg' ? $('#txtWeight_' + j).val() : $('#txtMount_' + j).val());
                t_weight = t_weight + dec($('#txtWeight_' + j).val());
                $('#txtTotal_' + j).val(round($('#txtPrice_' + j).val() * dec(t_mount) * t_float, 0));
                t1 = t1 + dec($('#txtTotal_' + j).val());
                }// j

                $('#txtMoney').val(round(t1, 0));
                if(!emp($('#txtPrice').val()))
                $('#txtTranmoney').val(round(t_weight * dec($('#txtPrice').val()), 0));

                $('#txtWeight').val(round(t_weight, 0));
                //$('#txtTotal').val(t1 + dec($('#txtTax').val()));
                calTax();*/

                //   format();
            }

            function refresh(recno) {
                _refresh(recno);

            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
		 #dmain{overflow:hidden;}
		 .dview{float:left;width:25%;}
		 .tview{margin:0;padding:2px;border:1px black double;border-spacing:0;font-size:medium;background-color:#FFFF66;color:blue;}
		 .tview td{padding:2px;text-align:center;border:1px black solid;}
		 .dbbm{float:left;width:73%;margin:-1px;border:1px black solid;border-radius:5px;}
		 .tbbm{padding:0px;border:1px white double;border-spacing:0;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
		 .tbbm tr{height:35px;}
		 .td1{width: 11%;}
		 .td3, .td5, .td7{width: 10%;}
		 .td2, .td4, .td6, .td8{width: 10%;}
		 .tbbm tr td span{float:right;display:block;width:8px;height:10px;}
		 .tbbm tr td .lbl{float:right;color:blue;font-size:medium;}
		 .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
		 .tbbm tr td .txt.c1{width:98%;float:left;}
		 .tbbm tr td .txt.c2{width:48%;float:left;}
		 .tbbm tr td .txt.c3{width:46%;float:left;}
		 .tbbm tr td .txt.c4{width:52%;float:left;}
		 .tbbm tr td .txt.c5{width:32%;float:left;}
		 .tbbm tr td .txt.c6{width:64%;float:left;}
		 .tbbm tr td .txt.num{text-align:right;}
		 .txt.c7{width:96%;text-align: right;}
		 .txt.c8{width:98%;}
		
		 .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
		
		 
		 .tbbm tr td{margin:0px -1px;padding:0;}
		  input[type="text"], input[type="button"] {
                font-size: medium;
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
                font-size: medium;
            }
		 
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewDatea'></a></td>
						<td align="center" style="width:40%"><a id='vewComp'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='custno comp,4'>~custno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td class="td4" >
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblMon" class="lbl"></a></td>
						<td class="td6">
						<input id="txtMon"  type="text"  class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblWorker"  class="lbl"></a></td>
						<td class="td8">
						<input id="txtWorker" type="text" class="txt c8"/>
						</td>
						
					</tr>
					<tr class="tr2">
						<td class="td1" ><span> </span>
						<a id="lblAcomp" class="lbl btn" ></a>
						</td>
						<td class="td2" colspan="3">
						<input id="txtCno"  type="text" class="txt c5"/>
						<input id="txtAcomp" type="text" class="txt c6"/>
						</td>
						<td class="td5"><span> </span><a id="lblFloata" class="lbl"></a></td>
						<td class="td6"><select id="cmbCoin" class="txt c4"></select>
						<input id="txtFloata" type="text" class="txt num c3" />
						</td>
						<td class="td7"><span> </span><a id="lblTypea" class="lbl"></a></td>
						<td class="td8"><select id="cmbTypea" ></select></td>
						
					</tr>

					<tr class="tr3">
						<td class="td1"><span> </span>
						<a id="lblCust" class="lbl btn" ></a>
						</td>
						<td class="td2" colspan="3">
						<input id="txtCustno" type="text" class="txt c5"/>
						<input id="txtComp"  type="text" class="txt c6"/>
						</td>
						<td class="td5"><span> </span><a id='lblPayc' class="lbl"></a></td>
						<td class="td6" >
						<input id="txtPayc" type="text" class="txt c1"/>
						</td>
						
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblVdate" class="lbl"></a></td>
						<td class="td2"><input id="txtVbdate" type="text" class="txt c1"/></td>
						<td class="td3" align="center"><span> </span><a id="lblSymbol" style="font-weight: bolder;font-size: 20px;"></a></td>
						<td class="td4"><input id="txtVedate" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblCno2" class="lbl"></a></td>
						<td class="td6"><input id="txtCno2" type="text" class="txt c2"/>
						<input id="txtAccno2" type="text"  class="txt c2"/></td>
						<td class="td7"><span> </span><a id="lblAccno" class="lbl"></a></td>
						<td class="td8"><input id="txtAccno" type="text" class="txt c8"/></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblTotalus" class="lbl"></a></td>
						<td class="td2">
						<input id="txtTotalus" type="text" class="txt num c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblPaysaleus" class="lbl"></a></td>
						<td class="td4">
						<input id="txtPaysaleus" type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblUnpayus" class="lbl"></a></td>
						<td class="td6">
						<input id="txtUnpayus" type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblTotal" class="lbl"></a></td>
						<td class="td2">
						<input id="txtTotal" type="text"  class="txt num c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblPaysale" class="lbl"></a></td>
						<td  class="td4">
						<input id="txtPaysale" type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblUnpay" class="lbl"></a></td>
						<td class="td6">
						<input id="txtUnpay"  type="text"  class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id="lblApv" class="lbl"></a></td>
						<td class="td8"><input id="txtApv" type="text" class="txt c1" disabled = "disabled"/></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
						<td class="td2" colspan='7' ><textarea  id="txtMemo" cols="10" rows="5" style="width: 99%; height: 50px;" ></textarea></td>
					</tr>
				</table>
			</div>
		</div>

		<div class='dbbs' >
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center"><a id='lblMoney'></a></td>
					<td align="center"><a id='lblChgs'></a></td>
					<td align="center"><a id='lblPaysales'></a></td>
					<td align="center"><a id='lblMons'></a></td>
					<td align="center"><a id='lblCheckno'></a></td>
					<td align="center"><a id='lblAccount'></a></td>
					<td align="center"><a id='lblBankno'></a></td>
					<td align="center"><a id='lblBank'></a></td>
					<td align="center"><a id='lblIndate'></a></td>
					<td align="center"><a id='lblMemos'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>

					<td style="width:6%;">
					<input class="txt c7" id="txtMoney.*" type="text" />
					<input class="txt c7" id="txtMoneyus.*" type="text" />
					</td>
					<td style="width:5%;">
					<input class="txt c7" id="txtChgs.*" type="text"  />
					<input class="txt c7" id="txtChgsus.*" type="text" />
					</td>
					<td style="width:6%;">
					<input class="txt c7" id="txtPaysale.*" type="text" />
					<input class="txt c7" id="txtPaysaleus.*" type="text" />
					</td>
					<td style="width:5%;">
					<input class="txt c8" id="txtMon.*" type="text" />
					</td>
					<td style="width:8%;">
					<input class="txt c8" id="txtCheckno.*"  />
					</td>
					<td style="width:8%;">
					<input class="txt c8" id="txtAccount.*" type="text" />
					</td>
					<td style="width:6%;">
					<input class="txt c8" id="txtBankno.*" type="text" />
					</td>
					<td style="width:18%;">
					<input class="txt c8" id="txtBank.*" type="text" />
					</td>
					<td style="width:7%;">
					<input class="txt c8" id="txtIndate.*" type="text" />
					</td>
					<td style="width:12%;">
					<input class="txt c8" id="txtMemo.*" type="text" />
					<input id="txtNoq.*" type="hidden" />
					<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
