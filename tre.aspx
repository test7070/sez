<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
			isEditTotal = false;
            q_tables = 's';
            var q_name = "tre";
            var q_readonly = ['txtNoa', 'txtMoney', 'txtTotal','txtWorker'];
            var q_readonlys = ['txtOrdeno', 'txtTranno', 'txtTrannoq'];
            var bbmNum = [['txtMoney', 10, 0],['txtTaxrate', 10, 1],['txtTax', 10, 0],['txtTotal', 10, 0]];
            var bbsNum = [['txtMount', 10, 3],['txtPrice', 10, 3],['txtDiscount', 10, 3],['txtMoney', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            aPop = new Array(['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'],
            ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
            ['txtBdriverno', '', 'driver', 'noa,namea', 'txtBdriverno', 'driver_b.aspx'],
            ['txtEdriverno', '', 'driver', 'noa,namea', 'txtEdriverno', 'driver_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtDate2', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtPaydate', r_picd]];
                q_mask(bbmMask);
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				$('#lblAccno').parent().click(function(e) {
                    q_box("accc.aspx?" + $('#txtAccno').val() + "'", 'accc', "850px", "600px", q_getMsg("popAccc"));
                });

                $('#cmbTaxtype').change(function(e) {
                    sum();
                }).focus(function(){
                	var len = $("#cmbTaxtype").children().length>0?$("#cmbTaxtype").children().length:1;
                	$("#cmbTaxtype").attr('size',len+"");
                }).blur(function(){
                	$("#cmbTaxtype").attr('size','1');
                	sum();
                }); 
                $('#txtTaxrate').change(function(e) {
                    sum();
                });
                $('#txtTax').change(function(e) {
                    sum();
                });
                $('#btnTrans').click(function(e) {
                	q_func('tre.import',r_accy+','+$('#txtBdriverno').val()+','+$('#txtEdriverno').val()+','+$('#txtBdate').val()+','+$('#txtEdate').val()+','+$('#txtDate2').val()+','+r_name);
                });
                $('#txtMemo').change(function(){
                	if(isEditTotal && $.trim($('#txtMemo').val()).substring(0, 1) == '.'){
	                	$('#txtTotal').removeAttr('readonly').css('background-color','white').css('color','black');
                	}else{
                		$('#txtTotal').attr('readonly','readonly').css('background-color','rgb(237, 237, 238)').css('color','green');
                		sum();
                	}
                });
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'tre.import':
						if(result.length==0)
							alert('No data!');
						else
							location.reload();
                        break;
                }

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
                    case 'trans':
                        var as = _q_appendData("trans", "", true);

                        q_gridAddRow(bbsHtm, 'tbbs', 'txtTranno,txtOrdeno,txtTrandate', as.length, as, 'tranno,ordeno,trandate', '', '');

                        /*while(as.length > q_bbsCount) {
                         $('#btnPlus').click();
                         }*/
                        for( i = 0; i < q_bbsCount; i++) {
                            _btnMinus("btnMinus_" + i);
                            if(i < as.length) {
                                $('#txtOrdeno_' + i).val(as[i].ordeno);
                                $('#txtTranno_' + i).val(as[i].noa);
                                $('#txtTrannoq_' + i).val(as[i].noq);
                                $('#txtTrandate_' + i).val(as[i].trandate);
                                $('#txtCarno_' + i).val(as[i].carno);
                                $('#txtRs_' + i).val();
                                $('#txtStraddr_' + i).val(as[i].straddr);
                                $('#txtEndaddr_' + i).val(as[i.endaddr]);
                                $('#txtMoney_' + i).val(as[i].total2);
                                $('#txtPaymemo_' + i).val();
                                $('#txtFill_' + i).val(as[i].fill);
                                $('#txtCasetype_' + i).val(as[i].csetype);
                                $('#txtCaseno_' + i).val(as[i].caseno);
                                $('#txtCaseno2_' + i).val(as[i].caseno2);
                                $('#txtBoat_' + i).val();
                                $('#txtBoatname_' + i).val();
                                $('#txtMemo_' + i).val();
                                $('#txtOverweightcost_' + i).val();
                                $('#txtOthercost_' + i).val();
                            }
                        }
                        sum();
                        break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
            	 $('#txtWorker').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tre') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)
                    return;

                q_box('tre_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
                for(var i = 0; i < q_bbsCount; i++) {
                    if( typeof ($('#txtMoney_' + i).data('info')) == 'undefined')
                        $('#txtMoney_' + i).data('info', {
                            isSetChange : false
                        });

                    if( typeof ($('#txtMoney_' + i).data('info').isSetChange) == 'undefined') {
                        $('#txtMoney_' + i).data('info').isSetChange = false;

                    }
                    if(!$('#txtMoney_' + i).data('info').isSetChange) {
                        $('#txtMoney_' + i).data('info').isSetChange = true;
                        $('#txtMoney_' + i).change(function(e) {
                            sum();
                        });
                    }
                }
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

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['ordeno'] && !as['tranno'] && !as['trannoq']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }

            function sum() {
            	if(isEditTotal && $.trim($('#txtMemo').val()).substring(0, 1) == '.')
            		return;
                var t_money = 0, t_rate = 0, t_tax = 0, t_total = 0;
                for( i = 0; i < q_bbsCount; i++) {
                	t_money += parseInt($.trim($('#txtMoney_' + i).val()).length == 0 ? '0' : $('#txtMoney_' + i).val().replace(/,/g,''), 10);
                }
                t_rate = parseInt($.trim($('#txtTaxrate').val()).length == 0 ? '0' : $('#txtTaxrate').val().replace(/,/g,''), 10);
                switch($('#cmbTaxtype').val()) {
                    case '1':
                        t_tax = Math.round(t_money * t_rate / 100);
                        t_total = t_money + t_tax;
                        break;
                    case '3':
                        t_total = Math.round(t_money / (1 + t_rate / 100), 0);
                        t_tax = t_money - t_total;
                        break;
                    case '5':
                        t_tax = parseInt($.trim($('#txtTax').val()).length == 0 ? '0' : $('#txtTax').val().replace(/,/g,''), 10);
                        t_total = t_money + t_tax;
                        break;
                    default:
                        t_total = t_money;
                }
                $('#txtMoney').val(t_money);
                $('#txtTax').val(t_tax);
                $('#txtTotal').val(t_total);
            }

            function refresh(recno) {
                _refresh(recno);
                if(isEditTotal && (q_cur==1 || q_cur==2) && $.trim($('#txtMemo').val()).substring(0, 1) == '.'){
                	$('#txtTotal').removeAttr('readonly').css('background-color','white').css('color','black');
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur == 1 || q_cur == 2) {
                	$('#txtDate2').attr('readonly','readonly');
                	$('#txtBdate').attr('readonly','readonly');
                	$('#txtEdate').attr('readonly','readonly');
                	$('#txtBdriverno').attr('readonly','readonly');
                	$('#txtEdriverno').attr('readonly','readonly');
                	$('.tr1').hide();
                }else{
                	$('#txtDate2').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
                	$('#txtBdate').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
                	$('#txtEdate').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
                	$('#txtBdriverno').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
                	$('#txtEdriverno').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
                	$('.tr1').show();
                }
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 23%;
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
                width: 75%;
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
                width: 9%;
            }
            .tbbm .tr1{
                background-color: #FFEC8B;
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
                font-size:medium;
            }
            .dbbs {
                width: 2400px;
            }
            .tbbs a {
                font-size: medium;
            }
            
            .num {
                text-align: right;
            }
			input[type="text"],input[type="button"] {
                font-size:medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewDriverno'> </a></td>
						<td align="center" style="width:20%"><a id='vewDriver'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='driverno'>~driverno</td>
						<td align="center" id='driver'>~driver</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr name="schema" style="height:0px;">
						<td class="td1"><span class="schema"> </span></td>
						<td class="td2"><span class="schema"> </span></td>
						<td class="td3"><span class="schema"> </span></td>
						<td class="td4"><span class="schema"> </span></td>
						<td class="td5"><span class="schema"> </span></td>
						<td class="td6"><span class="schema"> </span></td>
						<td class="td7"><span class="schema"> </span></td>
						<td class="td8"><span class="schema"> </span></td>
						<td class="td9"><span class="schema"> </span></td>
						<td class="tdA"><span class="schema"> </span></td>
						<td class="tdZ"><span class="schema"> </span></td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblDate2" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtDate2" type="text"  class="txt c1" />
						</td>
						<td class="td3"><span> </span><a id="lblDate3" class="lbl"> </a></td>
						<td class="td4" colspan="2">
						<input id="txtBdate" type="text"  class="txt c2"/>
						<span style="float:left;display: block;width:20px;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
						<input id="txtEdate" type="text"  class="txt c2"/>
						</td>
						<td class="td6"><span> </span><a id="lblDriver2" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtBdriverno" type="text"  class="txt c2"/>
						<span style="float:left;display: block;width:20px;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
						<input id="txtEdriverno" type="text"  class="txt c2"/>
						</td>
						<td class="tdA">
						<input type="button" id="btnTrans" class="txt c1"/>
						</td>
						<td class="tdz"> </td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td4"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td5">
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
					</tr>
					
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtDriverno" type="text"  class="txt c2"/>
						<input id="txtDriver" type="text"  class="txt c3"/>
						</td>
						<td class="td4"><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td class="td5" colspan="2">
						<input id="txtCardealno" type="text"  class="txt c2"/>
						<input id="txtCardeal" type="text"  class="txt c3"/>
						</td>
						<td class="td7"><span> </span><a id="lblPaydate" class="lbl"> </a></td>
						<td class="td8">
						<input id="txtPaydate" type="text" class="txt c1" />
						</td>
						<td class="td9"><span> </span><a id="lblRc2ano" class="lbl"> </a></td>
						<td class="tdA">
						<input id="txtRc2ano" type="text" class="txt c1" />
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblMoney" class="lbl"></a></td>
						<td class="td2">
						<input id="txtMoney" type="text"  class="txt c1 num"/>
						</td>
						<td class="td3"><span> </span><a id="lblTaxrate" class="lbl"></a></td>
						<td class="td4"><select id="cmbTaxtype" class="txt c3"></select>
						<input id="txtTaxrate" type="text"  class="txt c2 num"/>
						</td>
						<td class="td5"><span> </span><a id="lblTax" class="lbl"></a></td>
						<td class="td6">
						<input id="txtTax" type="text" class="txt c1 num"/>
						</td>
						<td class="td7"><span> </span><a id="lblTotal" class="lbl"></a></td>
						<td class="td8">
						<input id="txtTotal" type="text" class="txt c1 num" />
						</td>
						<td class="td9"><span> </span><a id="lblAccno" class="lbl btn"></a></td>
						<td class="tdA">
						<input id="txtAccno" type="text"  class="txt c1"/>
						</td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="6"><input id="txtMemo" type="text" class="txt c1" /></td>
						<td class="td8"> </td>
						<td class="td9"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="tdA"><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:100px;"><a id='lblTrandate_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblCarno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblStraddr_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDiscount_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:170px;"><a id='lblTranno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblRs_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPaymemo_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblFill_s'> </a></td>
					<td align="center" style="width:100px"><a id='lblCasetype_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCaseno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCaseno2_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblBoat_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblBoatname_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblShip_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOverweightcost_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOthercost_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblOrdeno_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td >
					<input type="text" id="txtTrandate.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCarno.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtStraddr.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtMount.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtPrice.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtDiscount.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtMoney.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtMemo.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtTranno.*" style="float:left; width: 70%;"/>
					<input type="text" id="txtTrannoq.*" style="float:left; width: 20%;"/>
					</td>
					<td >
					<input type="text" id="txtRs.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtPaymemo.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtFill.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCasetype.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCaseno.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCaseno2.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtBoat.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtBoatname.*" style="width:95%;"/>
					</td>
					<td >
					<input type="text" id="txtShip.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtOverweightcost.*" style="width:95%;text-align: right;"/>
					</td>
					<td >
					<input type="text" id="txtOthercost.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtOrdeno.*" style="width:95%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
