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

            q_tables = 's';
            var q_name = "invo";
            var q_readonly = ['txtTotal', 'txtAmount'];
            var q_readonlys = [];
            var bbmNum = [['txtTotal', 15, 3, 1], ['txtAmount', 15, 2, 1], ['txtFloata', 15, 4, 1]];
            var bbsNum = [['txtQuantity', 15, 3, 1], ['txtPrice', 15, 2, 1], ['txtWeight', 15, 2, 1], ['txtAmount', 15, 2, 1]];
            var bbmMask = [];
            var bbsMask = [];

            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp,addr_home', 'txtCustno,txtComp,txtAddr', 'cust_b.aspx'], ['txtCno', 'lblCno', 'acomp', 'noa,acomp,ename', 'txtCno', 'acomp_b.aspx'], ['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,engpro,unit', 'txtProductno_,txtDescription_,txtUnit_,txtMarks_', 'ucaucc_b.aspx']
            //['txtOrdeno', '', 'orde', 'noa,comp,addr2,taxtype', 'txtOrdeno,txtComp,txtAddr,cmbTaxtype', '']
            //['txtOrdeno', '', 'orde', 'noa,comp,addr2,taxtype,tax,money,total,coin,floata,totalus', 'txtOrdeno,txtComp,txtAddr,cmbTaxtype,txtTax,txtMoney,txtTotal,cmbCoin,txtFloata,txtTotalus', '']
            );
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
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
                q_getFormat();
                bbmMask = [['txtDatea', '9999/99/99'], ['txtEtd', '9999/99/99'], ['txtEta', '9999/99/99']];
                q_mask(bbmMask);
                //q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                /*$('#btnInvo').click(function(){
	                 t_where = '';
	                 t_noa = $('#txtNoa').val();
	                 if(t_noa.length > 0){
		                 t_where = "noa='" + t_noa + "'";
		                 q_box("invo_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('popInvo'));
	                 }
                 });*/

                if (q_getPara('sys.project').toUpperCase() == 'GU') {
					$('#btnPack').hide();
					$('.isgenvcc').hide();
                }
                
                $('#btnPack').click(function() {
                    t_where = '';
                    t_noa = $('#txtNoa').val();
                    if (t_noa.length > 0) {
                        t_where = "noa='" + t_noa + "'";
                        q_box("packing_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack', "95%", "95%", $('#btnPack').val());
                    }
                });

                $('#txtNoa').change(function() {
                    t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    q_gt('invo', t_where, 0, 0, 0, "check_Noa", r_accy);
                });

                $('#txtVccno').click(function() {
                    t_where = '';
                    t_noa = $('#txtVccno').val();
                    if (t_noa.length > 0 && q_cur != 1 && q_cur != 2) {
                        t_where = "noa='" + t_noa + "'";
                        q_box("vcc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + (dec($('#txtDatea').val().substr(0, 4)) - 1911), 'vcc', "95%", "95%", '');
                    }
                }).change(function() {
                	if (q_getPara('sys.project').toUpperCase() == 'GU' && !emp($('#txtVccno').val())) {
                		t_where = "where=^^ noa='" + $('#txtVccno').val() + "'^^";
                    	q_gt('view_vcc', t_where, 0, 0, 0, "getvcc", r_accy);
                	}
				});
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'flors_coin':
                        var as = _q_appendData("flors", "", true);
                        var z_coin = '';
                        for ( i = 0; i < as.length; i++) {
                            z_coin += ',' + as[i].coin;
                        }
                        if (z_coin.length == 0)
                            z_coin = ' ';

                        q_cmbParse("cmbCoin", z_coin);
                        if (abbm[q_recno])
                            $('#cmbCoin').val(abbm[q_recno].coin);

                        break;
                    case 'flors':
                        var as = _q_appendData("flors", "", true);
                        if (as[0] != undefined) {
                            q_tr('txtFloata', as[0].floata);
                            sum();
                        }
                        break;
                    case 'check_Noa':
                        var as = _q_appendData("invo", "", true);
                        if (as[0] != undefined) {
                            alert(q_getMsg('lblNoa') + '已存在!!');
                            return;
                        }
                        break;
                    case 'check_btnOk':
                        var as = _q_appendData("invo", "", true);
                        if (as[0] != undefined) {
                            alert(q_getMsg('lblNoa') + '已存在!!');
                            return;
                        } else {
                            wrServer($('#txtNoa').val());
                        }
                        break;
					case 'getvcc':
						var as = _q_appendData("view_vcc", "", true);
                        if (as[0] != undefined) {
                        	$('#txtCustno').val(as[0].custno);
                        	$('#txtComp').val(as[0].comp);
                        	if(as[0].addr2.length>0)
                        		$('#txtAddr').val(as[0].addr2);
                        	else
                        		$('#txtAddr').val(as[0].addr);
                        		
                        	$('#txtShipped').val(as[0].acomp);
                        		
                        	if(as[0].trantype=='海運')
                        		$('#txtPer').val('sea freight');	
                        	if(as[0].trantype=='空運')
                        		$('#txtPer').val('air freight');
                        	if(as[0].trantype=='快遞')
                        		$('#txtPer').val('express');	
                        	
                        	$('#txtCno').val(as[0].cno);
                        	$('#txtPno').val(as[0].ordeno);	
                        	$('#cmbCoin').val(as[0].coin);
                        	$('#txtFloata').val(as[0].floata);
                        	
	                        t_where = "where=^^ noa='" + $('#txtVccno').val() + "'^^";
	                    	q_gt('boaj', t_where, 0, 0, 0, "getboaj", r_accy);
	                    	
	                    	t_where = "where=^^ noa='" + as[0].ordeno + "'^^";
	                    	q_gt('view_orde', t_where, 0, 0, 0, "getorde", r_accy);	
                        }
						break;
					case 'getboaj':
						var as = _q_appendData("boaj", "", true);
                        if (as[0] != undefined) {
                        	$('#txtSailing').val(as[0].saildate);
                        	$('#txtClosing').val(as[0].cldate);
                        	$('#txtFroma').val(as[0].bdock);
                        	$('#txtToa').val(as[0].edock);
                        	$('#txtEtd').val(as[0].etd);
                        	$('#txtEta').val(as[0].eta);
                        }
						break;
					case 'getorde':
						var as = _q_appendData("view_orde", "", true);
                        if (as[0] != undefined) {
							$('#txtContract').val(as[0].contract);
							t_where = "where=^^ noa='" + as[0].noa + "'^^";
	                    	q_gt('view_ordes', t_where, 0, 0, 0, "getordes", r_accy);	
							
							t_where = "where=^^ noa='" + as[0].noa + "'^^";
	                    	q_gt('ordei', t_where, 0, 0, 0, "getordei", as[0].accy);
						}
						break;
					case 'getordes':
						var as = _q_appendData("view_ordes", "", true);
                        
						q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtDescription,txtUnit,txtQuantity,txtPrice,txtAmount,txtMemo'
						, as.length, as, 'productno,product,unit,mount,price,total,memo', 'txtProductno,txtProduct');
						break;
					case 'getordei':
						var as = _q_appendData("ordei", "", true);
                        if (as[0] != undefined) {
							$('#txtLcno').val(as[0].lcno);
							$('#txtAttn').val(as[0].conn);
						}
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function coin_chg() {
                var t_where = "where=^^ ('" + (dec($('#txtDatea').val().substr(0, 4)) - 1911) + '/' + $('#txtDatea').val().substr(5) + "' between bdate and edate) and coin='" + $('#cmbCoin').find("option:selected").text() + "' ^^";
                q_gt('flors', t_where, 0, 0, 0, "");
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('invo_s.aspx', q_name + '_s', "500px", "500px", $('#btnSeek').val());
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                var t_date, t_year, t_month, t_day;
                t_date = new Date();
                t_year = t_date.getUTCFullYear();
                t_month = t_date.getUTCMonth() + 1;
                t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                $('#txtDatea').val(t_year + '/' + t_month + '/' + t_day);
                $('#btnPack').attr('disabled', 'disabled');
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
            }

            function btnPrint() {
            	if (q_getPara('sys.project').toUpperCase() == 'GU') {
            		q_box('z_invop_gu.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", $('#btnPrint').val());
            	}else
                	q_box('z_invop.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", $('#btnPrint').val());
            }

            function bbsSave(as) {
                if (!as['description'] && !as['marks']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtQuantity_' + j).change(function() {
                            sum()
                        });
                        $('#txtPrice_' + j).change(function() {
                            sum()
                        });
                        $('#txtAmount_' + j).change(function() {
                            sum()
                        });
                    }
                }
                _bbsAssign();
            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();

                if (q_cur == 1) {
                    t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    q_gt('invo', t_where, 0, 0, 0, "check_btnOk", r_accy);
                } else
                    wrServer($('#txtNoa').val());
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                //修改出貨單號
                if (q_getPara('sys.project').toUpperCase() == 'GU') {
                	q_func('qtxt.query.u2', 'invo.txt,changvccinvo,' + encodeURI(r_accy)+';'+ encodeURI($('#txtNoa').val()) );
                }else{
                	if(q_cur == 2 && !emp($('#txtVccno').val()))
	                	q_func('vcc_post.post.modi', (dec($('#txtDatea').val().substr(0, 4)) - 1911) + ',' + $('#txtVccno').val() + ',0');
					else                	
	                    q_func('qtxt.query.u2', 'invo.txt,post,' + encodeURI($('#txtNoa').val()) + ';1;' + q_getPara('sys.key_vcc') + ';' + q_getPara('vcc.pricePrecision') + ';' + r_userno + ';' + r_name + ';' + q_getPara('sys.dateformat'));
                }
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'vcc_post.post.modi':
                		q_func('qtxt.query.u1', 'invo.txt,post,' + encodeURI($('#txtNoa').val()) + ';0;' + q_getPara('sys.key_vcc') + ';' + q_getPara('vcc.pricePrecision') + ';' + r_userno + ';' + r_name + ';' + q_getPara('sys.dateformat'));
                		break;
                    case 'qtxt.query.u1':
                        q_func('qtxt.query.u2', 'invo.txt,post,' + encodeURI($('#txtNoa').val()) + ';1;' + q_getPara('sys.key_vcc') + ';' + q_getPara('vcc.pricePrecision') + ';' + r_userno + ';' + r_name + ';' + q_getPara('sys.dateformat'));
                        break;
                    case 'qtxt.query.u2':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            abbm[q_recno]['vccno'] = as[0].vccno;
                            $('#txtVccno').val(as[0].vccno);

                            if (as[0].vccno.length > 0) {
                                q_func('vcc_post.post', (dec($('#txtDatea').val().substr(0, 4)) - 1911) + ',' + as[0].vccno + ',1');
                            }
                        }
                        break;
					case 'vcc_post.post.dele':
						q_func('qtxt.query.u3', 'invo.txt,post,' + encodeURI($('#txtNoa').val()) + ';0;' + q_getPara('sys.key_vcc') + ';' + q_getPara('vcc.pricePrecision') + ';' + r_userno + ';' + r_name + ';' + q_getPara('sys.dateformat'));
						break;
                    case 'qtxt.query.u3':
                        _btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
                        break;
                }
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
                $('#btnInvo').removeAttr('disabled');
                $('#btnPack').removeAttr('disabled');
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
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
                if (q_tables == 's')
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
                //_btnDele();
                //刪除
                if (!confirm(mess_dele))
                    return;
                q_cur = 3;
                if ($('#txtVccno').val().length > 0) {
					q_func('vcc_post.post.dele', (dec($('#txtDatea').val().substr(0, 4)) - 1911) + ',' + $('#txtVccno').val() + ',0');
				}
            }

            function btnCancel() {
                _btnCancel();
                $('#btnInvo').removeAttr('disabled');
                $('#btnPack').removeAttr('disabled');
            }

            function sum() {
                var t1 = 0, t2 = 0, t_unit, t_mount, t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_mount = dec($('#txtQuantity_' + j).val());
                    // 計價量
                    t2 = q_add(t2, t_mount);
                    q_tr('txtAmount_' + j, round(q_mul(dec($('#txtPrice_' + j).val()), dec(t_mount)), 2));
                    t1 = q_add(t1, dec($('#txtAmount_' + j).val()));
                }// j

                $('#txtTotal').val(round(t2, 2));
                $('#txtAmount').val(round(t1, 2));
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
                float: left;
                width: 73%;
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
                margin: 0px -1px;
                padding: 0;
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .txt.c1 {
                width: 99%;
                float: left;
            }
            .txt.c2 {
                width: 45%;
                float: left;
            }
            .txt.c3 {
                width: 30%;
                float: left;
            }
            .txt.c4 {
                width: 50%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .num {
                text-align: right;
            }
            .tbbm tr td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1270px;
            }
            .tbbs a {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1270px;">
			<div class="dview" id="dview" style="float: left;  width:25%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk' class="lbl"> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa' class="lbl"> </a></td>
						<td align="center" style="width:40%"><a id='vewVccno' class="lbl"> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='vccno'>~vccno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing=''>
					<tr class="tr0" style="height: 0px;">
						<td style="width:100px;"> </td>
						<td style="width:200px;"> </td>
						<td style="width:150px;"> </td>
						<td style="width:150px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:200px;"> </td>
					</tr>
					<tr>
						<td ><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblVccno" class="lbl"> </a></td>
						<td><input id="txtVccno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td ><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
						<td><input id="txtCustno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan="3"><input id="txtComp"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddress' class="lbl"> </a></td>
						<td colspan="3"><input id="txtAddr"  type="text" class="txt c1" /></td>
						<td ><span> </span><a id='lblAttn' class="lbl"> </a></td>
						<td><input id="txtAttn"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblShipped' class="lbl"> </a></td>
						<td colspan="2"><input id="txtShipped"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblSailing' class="lbl"> </a></td>
						<td colspan="2"><input id="txtSailing"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPer' class="lbl"> </a></td>
						<td colspan="2"><input id="txtPer"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblClosing' class="lbl"> </a></td>
						<td colspan="2"><input id="txtClosing"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td ><span> </span><a id='lblFroma' class="lbl"> </a></td>
						<td colspan="2"><input id="txtFroma"  type="text"  class="txt c1"/></td>
						<td ><span> </span><a id='lblToa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtToa"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCommodity' class="lbl"> </a></td>
						<td colspan="2"><input id="txtCommodity"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td colspan="2"><input id="txtContract"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td ><span> </span><a id='lblEtd' class="lbl"> </a></td>
						<td><input id="txtEtd"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblEta" class="lbl"> </a></td>
						<td><input id="txtEta" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblLcno" class="lbl"> </a></td>
						<td><input id="txtLcno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td ><span> </span><a id='lblPno' class="lbl"> </a></td>
						<td><input id="txtPno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblCno" class="lbl"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1" /></td>
						<td ><span> </span><a id='lblCoin' class="lbl"> </a></td>
						<td>
							<select id="cmbCoin" class="txt c2" onchange='coin_chg()'> </select>
							<input id="txtFloata" type="text" class="txt num c2" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblAmount" class="lbl"> </a></td>
						<td><input id="txtAmount" type="text" class="txt c1 num" /></td>
						<td><input id="btnPack" type="button"/></td>
						<td class="isgenvcc"><span style="float: left;"> </span>
							<input id="chkIsgenvcc" type="checkbox" style="float: left;"/>
							<a id='lblIsgenvcc' class="lbl" style="float: left;"> </a>
						</td>
					</tr>
					<tr class="tr9">
						<td><span> </span><a id='lblTitle' class="lbl"> </a></td>
						<td colspan="5"><input id="txtTitle" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr10">
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><textarea id="txtMemo"  style="width:99%; height: 60px;"> </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:9%;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:9%;"><a id='lblMarks_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblDescription_s'> </a></td>
					<td align="center" style="width:2%;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:5%;"><a id='lblQuantity_s'> </a></td>
					<td align="center" style="width:5%;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:5%;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:5%;"><a id='lblAmount_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblUno_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td>
						<input id="txtProductno.*"  type="text"  class="txt c5"/>
						<input class="btn" id="btnProductno.*" type="button" value='.' style="font-weight: bold;" />
					</td>
					<td><input id="txtMarks.*"  type="text"  class="txt c1"/></td>
					<td><input id="txtDescription.*"  type="text"  class="txt c1"/></td>
					<td><input id="txtUnit.*"  type="text"  class="txt c1"/></td>
					<td><input id="txtQuantity.*"  type="text"  class="txt c1 num"/></td>
					<td><input id="txtWeight.*"  type="text"  class="txt c1 num"/></td>
					<td><input id="txtPrice.*"  type="text"  class="txt c1 num"/></td>
					<td><input id="txtAmount.*"  type="text"  class="txt c1 num"/></td>
					<td><input id="txtMemo.*"  type="text"  class="txt c1"/></td>
					<td><input id="txtUno.*"  type="text"  class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>