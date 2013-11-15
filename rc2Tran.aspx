<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            q_desc = 1;
            var q_name = "rc2";
            var q_readonly = ['txtNoa','txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtOrdeno','txtWorker'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 10, 0], ['txtTax', 10, 0], ['txtTotal', 10, 0]];
            var bbsNum = [['txtPrice', 12, 3], ['txtMount', 9, 2], ['txtTotal', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';

            aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
             ['txtTggno', 'lblTgg', 'tgg', 'noa,comp,tel,zip_invo,addr_invo', 'txtTggno,txtComp,txtTel,txtZipcode,txtAddr', 'cust_b.aspx'], 
             ['txtPartno2', 'lblPart2', 'part', 'noa,part', 'txtPartno2,txtPart2', 'part_b.aspx'],
             ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx'],
             ['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'], 
             ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], 
             ['txtProductno_', 'btnProductno_', 'uccdc', 'noa,item', 'txtProductno_,txtProduct_', 'uccdc_b.aspx']);

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

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('rc2.typea'));
                q_cmbParse("cmbStype", q_getPara('rc2.stype'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                q_cmbParse("combPay", q_getPara('rc2.pay'));
                q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
               $('#btnAccc').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
		        });

                $('#cmbTaxtype').change(function(e) {
                    sum();
                });
                $('#txtTaxrate').change(function(e) {
                    sum();
                });
                $('#txtTax').change(function(e) {
                    sum();
                });
				/* 若非本會計年度則無法存檔 */
				$('#txtDatea').focusout(function () {
					if($(this).val().substr( 0,3)!= r_accy){
				        	$('#btnOk').attr('disabled','disabled');
				        	alert(q_getMsg('lblDatea') + '非本會計年度。');
					}else{
				       		$('#btnOk').removeAttr('disabled');
					}
				});
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
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2,txtPrice', b_ret.length, b_ret, 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2,price', 'txtProductno,txtProduct,txtSpec');
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
                            }
                        }
                        break;

                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
			 function q_stPost() {
		        if (!(q_cur == 1 || q_cur == 2))
		            return false;
		        abbm[q_recno]['accno'] = xmlString;
		        $('#txtAccno').val(xmlString);
		    }
            function btnOrdes() {
                var t_custno = trim($('#txtCustno').val());
                var t_where = '';
                if(t_custno.length > 0) {
                    t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");
                    t_where = t_where;
                } else {
                    alert(q_getMsg('msgCustEmp'));
                    return;
                }
                q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
            }

            function btnOk() {
				$('#txtMon').val($.trim($('#txtMon').val()));
					if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
						alert(q_getMsg('lblMon')+'錯誤。');   
						return;
				} 
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_rc2tran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)
                    return;

                q_box('vcc_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
                var cmb = document.getElementById("combPay")
                if(!q_cur)
                    cmb.value = '';
                else
                    $('#txtPay').val(cmb.value);
                cmb.value = '';
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                ;
            }

            function btnPrint() {
			q_box("z_rc2p.aspx?" , '', "95%", "650px", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsAssign() {
                _bbsAssign();
                for(var i = 0; i < q_bbsCount; i++) {
                    /*Mount*/
                    if( typeof ($('#txtMount_' + i).data('info')) == 'undefined')
                        $('#txtMount_' + i).data('info', {
                            isSetChange : false
                        });
                    if( typeof ($('#txtMount_' + i).data('info').isSetChange) == 'undefined')
                        $('#txtMount_' + i).data('info').isSetChange = false;
                    if(!$('#txtMount_' + i).data('info').isSetChange) {
                        $('#txtMount_' + i).data('info').isSetChange = true;
                        $('#txtMount_' + i).change(function(e) {
                            sum();
                        });
                    }
                    /*Price*/
                    if( typeof ($('#txtPrice_' + i).data('info')) == 'undefined')
                        $('#txtPrice_' + i).data('info', {
                            isSetChange : false
                        });
                    if( typeof ($('#txtPrice_' + i).data('info').isSetChange) == 'undefined')
                        $('#txtPrice_' + i).data('info').isSetChange = false;
                    if(!$('#txtPrice_' + i).data('info').isSetChange) {
                        $('#txtPrice_' + i).data('info').isSetChange = true;
                        $('#txtPrice_' + i).change(function(e) {
                            sum();
                        });
                    }
                    /*Total*/
                    if( typeof ($('#txtTotal_' + i).data('info')) == 'undefined')
                        $('#txtTotal_' + i).data('info', {
                            isSetChange : false
                        });
                    if( typeof ($('#txtTotal_' + i).data('info').isSetChange) == 'undefined')
                        $('#txtTotal_' + i).data('info').isSetChange = false;

                    if(!$('#txtTotal_' + i).data('info').isSetChange) {
                        $('#txtTotal_' + i).data('info').isSetChange = true;
                        $('#txtTotal_' + i).change(function(e) {
                            sum();
                        });
                    }
                    /*Memo*/
                    if( typeof ($('#txtMemo_' + i).data('info')) == 'undefined')
                        $('#txtMemo_' + i).data('info', {
                            index : i,
                            isSetChange : false
                        });
                    if( typeof ($('#txtMemo_' + i).data('info').index) == 'undefined')
                        $('#txtMemo_' + i).data('info').index = i;
                    if( typeof ($('#txtMemo_' + i).data('info').isSetChange) == 'undefined')
                        $('#txtMemo_' + i).data('info').isSetChange = false;
                    if(!$('#txtMemo_' + i).data('info').isSetChange) {
                        $('#txtMemo_' + i).data('info').isSetChange = true;
                        $('#txtMemo_' + i).change(function(e) {
                            if($.trim($(this).val()).substring(0, 1) == '.')
                                $('#txtTotal_' + $(this).data('info').index).removeAttr('readonly');
                            else
                                $('#txtTotal_' + $(this).data('info').index).attr('readonly', 'readonly');
                            sum();
                        });
                    }
                    $('#txtMemo_' + i).change();
                }
            }

            function bbsSave(as) {
                if(!as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                if(t_err) {
                    alert(t_err)
                    return false;
                }
                return true;
            }

            function sum() {
                var t_money = 0, t_rate = 0, t_tax = 0, t_total = 0;
                var t1, t2;
                for( i = 0; i < q_bbsCount; i++) {
                    if($.trim($('#txtMemo_' + i).val()).substring(0, 1) != '.') {
                        t1 = parseInt($.trim($('#txtMount_' + i).val()).length == 0 ? '0' : $('#txtMount_' + i).val(), 10);
                        t2 = parseInt($.trim($('#txtPrice_' + i).val()).length == 0 ? '0' : $('#txtPrice_' + i).val(), 10);
                        $('#txtTotal_' + i).val(Math.round(t1 * t2, 0));
                    }
                    if($.trim($('#txtTotal_' + i).val()).length != 0)
                        t_money += parseInt($('#txtTotal_' + i).val(), 10);
                }
                t_rate = parseInt($.trim($('#txtTaxrate').val()).length == 0 ? '0' : $('#txtTaxrate').val(), 10);
                switch($('#cmbTaxtype').val()) {
                    case '1':
                        t_tax = Math.round(t_money * t_rate / 100);
                        t_total = t_money + t_tax;
                        break;
                    case '3':
                        t_total = t_money;
                        t_money = Math.round(t_total / (1 + t_rate / 100), 0);
                        t_tax = t_total - t_money;
                        break;
                    case '5':
                        t_tax = parseInt($.trim($('#txtTax').val()).length == 0 ? '0' : $('#txtTax').val(), 10);
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

            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                for(var i = 0; i < q_bbsCount; i++) {
                    if($.trim($('#txtMemo_' + i).val()).substring(0, 1) == '.')
                        $('#txtTotal_' + $('#txtMemo_' + i).data('info').index).removeAttr('readonly');
                    else
                        $('#txtTotal_' + $('#txtMemo_' + i).data('info').index).attr('readonly', 'readonly');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if(q_tables == 's')
                    bbsAssign();
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
                width: 25%;
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
                float: right;
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
                font-size: 16px;
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
                font-size: 16px;
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
                width: 35%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 48%;
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
                font-size: medium;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs input[type="text"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .tbbs input[readonly="readonly"] {
                color: green;
            }
             input[type="text"], input[type="button"] {
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
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:5%"><a id='vewTypea'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='typea=rc2.typea'>~typea=rc2.typea</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='tggno comp,4'>~tggno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2">
						<input type="text" id="txtNoa" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblDatea'class="lbl"> </a></td>
						<td class="td4">
						<input type="text" id="txtDatea" class="txt c1"/>
						</td>
						<td class="td5" ><span> </span><a id='lblType' class="lbl"> </a></td>
						<td class="td6"><select id="cmbTypea" class="txt c1"> </select></td>
						
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td class="td2">
						<input type="text" id="txtCno" style="float:left;width:30%;"/>
						<input type="text" id="txtAcomp" style="float:left;width:70%;"/>
						</td>
						<td class="td3"><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td class="td4">
						<input type="text" id="txtMon" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td class="td6">
						<input type="text" id="txtInvo" class="txt c1"/>
						</td>
					</tr>

					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td class="td2">
						<input type="text" id="txtTggno" style="float:left;width:30%;"/>
						<input type="text" id="txtComp" style="float:left;width:70%;"/>
						</td>
						<td class="td3"><span> </span><a id='lblPay' class="lbl"> </a></td>
						<td class="td4">
						<input id="txtPay" type="text" class="txt c4"/>
						<select id="combPay" class="txt c4" > </select></td>
						<td class="td5" align="right"><span> </span><input id='btnAccc'  type="button"/> </td>
						<td class="td6">
						<input type="text" id="txtAccno" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblTel' class="lbl"></a></td>
						<td class="td2">
						<input type="text" id="txtTel" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblTrantype' class="lbl"></a></td>
						<td class="td4"><select id="cmbTrantype" class="txt c1"></select></td>
						<td class="td5"><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td class="td6">
						<input type="text" id="txtWorker" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
						<td class="td2" colspan='5'>
						<input type="text" id="txtZipcode" style="float:left;width:10%;"/>
						<input type="text" id="txtAddr" style="float:left;width:90%;"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblPart' class="lbl btn"></a></td>
						<td class="td2">
						<input type="text" id="txtPartno" style="float:left;width:30%;"/>
						<input type="text" id="txtPart" style="float:left;width:70%;"/>
						</td>
						<td class="td1"><span> </span><a id='lblSales' class="lbl btn"></a></td>
						<td class="td4">
						<input type="text" id="txtSalesno" class="txt c2"/>
						<input type="text" id="txtSales" class="txt c3"/>
						</td>
						<td class="td5"><span> </span><a id='lblTranmoney' class="lbl"></a></td>
						<td class="td6">
						<input type="text" id="txtTranmoney" class="txt num c1" />
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblPart2' class="lbl btn"></a></td>
						<td class="td2">
						<input type="text" id="txtPartno2" style="float:left;width:30%;"/>
						<input type="text" id="txtPart2" style="float:left;width:70%;"/>
						</td>
						<td class="td3"><span> </span><a id='lblSales2' class="lbl btn"></a></td>
						<td class="td4">
						<input type="text" id="txtSalesno2" class="txt c2"/>
						<input type="text" id="txtSales2" class="txt c3"/>
						</td>
						<td class="td5"><span> </span><a id="lblTotal" class="lbl"></a></td>
						<td class="td6">
						<input id="txtTotal" type="text" class="txt c1 num" />
						</td>
					</tr>
					<tr class="tr9">
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
						
					</tr>
					<tr class="tr10">
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
						<td  class="td2" colspan='7' >
						<input id="txtMemo"  type="text" style="width: 99%;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width: 1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:30%;"><a id='lblProduct_s'></a></td>
					<td align="center" style="width: 5%;"><a id='lblUnit_s'></a></td>
					<td align="center" style="width: 8%;"><a id='lblMount_s'></a></td>
					<td align="center" style="width: 8%;"><a id='lblPrice_s'></a></td>
					<td align="center" style="width: 8%;"><a id='lblTotal_s'></a></td>
					<td align="center" style="width:30%;"><a id='lblMemo_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td>
					<input  id="txtProductno.*"type="text" style="float:left;width: 20%;"/>
					<input id="txtProduct.*" type="text" style="float:left;width: 70%;"/>
					<input id="btnProductno.*" type="button" value=".." style="float:left;width:8%;"/>
					</td>
					<td>
					<input id="txtUnit.*" type="text" style="width: 95%;"/>
					</td>
					<td>
					<input id="txtMount.*" type="text" style="width: 95%;text-align: right;"/>
					</td>
					<td style="width:6%;">
					<input  id="txtPrice.*" type="text" style="width: 95%;text-align: right;"/>
					</td>
					<td style="width:8%;">
					<input  id="txtTotal.*" type="text" style="width: 95%;text-align: right;"/>
					</td>
					<td style="width:12%;">
					<input id="txtMemo.*" type="text" style="width: 95%;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
