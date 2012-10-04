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
		    q_desc = 1
		    q_tables = 's';
		    var q_name = "pay";
		    var q_readonly = ['txtNoa', 'txtWorker', 'txtAccno'];
		    var q_readonlys = ['txtRc2no', 'txtUnpay', 'txtUnpayorg', 'txtAcc2', 'txtPart2'];
		    var bbmNum = new Array(['txtSale', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtOpay', 10, 0, 1], ['txtUnopay', 10, 0, 1], ['textOpay', 10, 0, 1]);
		    var bbsNum = [['txtMoney', 10, 0, 1], ['txtChgs', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtUnpayorg', 10, 0, 1]];
		    var bbmMask = [];
		    var bbsMask = [];

		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'Datea';
		    aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
            ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
             ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2,acc7', 'txtAcc1_,txtAcc2_,txtMemo_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
             ['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'],
             ['txtUmmaccno_', '', 'payacc', 'noa,typea', 'txtUmmaccno_,txtTypea_', 'payacc_b.aspx'],
             ['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
             ['txtPartno_', '', 'part', 'noa,part', 'txtPartno_,txtPart_', 'part_b.aspx']);

		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();
		        q_gt(q_name, q_content, q_sqlCount, 1);
		    });
		    function main() {
		        mainForm(1);
		    }

		    var t_Saving;
		    function mainPost() {
		        q_getFormat();
		        bbmMask = [['txtDatea', r_picd]];
		        q_mask(bbmMask);
		        bbsMask = [['txtIndate', r_picd]];
		        
		        $('#btnGqbPrint').click(function (e) {
		            var t_noa = '', t_max, t_min;
		            for (var i = 0; i < q_bbsCount; i++) {
		                t_noa = $.trim($('#txtCheckno_' + i).val())
		                if (t_noa.length > 0) {
		                    break;
		                }
		            }
		            q_box('z_gqba.aspx' + "?;;;;" + r_accy + ";noa=" + t_noa, '', "900px", "600px", m_print);
		        });

		        $('#btnAccc').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
		        });

		        $('#txtTggno').change(function () { getOpay(); });

		        $('#txtOpay').change(function () { sum(); });
		        $('#txtUnopay').change(function () { sum(); });
				
				//1003暫時不先開啟視窗選擇要匯入的立帳單
		        $('#btnVcc').click(function (e) {
		            pay_tre();
		        });
		        $('#btnRc2no').click(function (e) {
		            var t_where = "where=^^ unpay<0 ^^"; 
		            q_gt('payb', t_where, 0, 0, 0, "", r_accy);
		        });
		        
		        //1003將立帳單匯入與自動沖帳分開
		        /*$('#btnAuto').click(function (e) {
		            t_Saving = true;
		            pay_tre();
		        });*/
		         $('#btnAuto').click(function (e) {
		         	t_Saving = true;
		        		/// 自動沖帳
		               $('#txtOpay').val(0);
		               $('#txtUnopay').val(0);
		               var t_money = 0;
		               for (var i = 0; i < q_bbsCount; i++) {
		               		if($('#txtAcc2_'+i).val().indexOf('其他收入') == 0 || $('#txtAcc2_'+i).val().indexOf('應付票據') == 0)
		               			t_money -= q_float('txtMoney_' + i);
		               		else
		               			t_money += q_float('txtMoney_' + i);
		               }

		               var t_unpay, t_pay=0;
		               for (var i = 0; i < q_bbsCount; i++) {
		               		if (q_float('txtUnpay_' + i) != 0) {
								t_unpay=q_float('txtUnpayorg_' + i)
		                        if (t_money >= t_unpay) {
		                            q_tr('txtPaysale_' + i, t_unpay);
		                            $('#txtUnpay_' + i).val(0);
		                            t_money = t_money - t_unpay;
		                        }
		                        else {
		                            q_tr('txtPaysale_' + i, t_money);
		                            q_tr('txtUnpay_' + i, t_unpay - t_money);
		                             t_money = 0;
		                        }
		                    }
		                }
		                if (t_money > 0)
		                    q_tr('txtOpay', t_money);
		                    
		                sum();
		                /*for (var i = 0; i < q_bbsCount; i++) {
		               		t_pay += q_float('txtPaysale_' + i);
		               	}
		               	q_tr('txtPaysale', t_pay);	  
		               	q_tr('txtUnpay', t_money - t_pay);*/
		         });
		    }

		    function pay_tre() {
		        if (q_cur == 1 || q_cur == 2) {
		            if ($.trim($('#txtTggno').val()) == 0) {  
		                alert('Empty=' + q_getMsg('lblTgg'));
		                return false;
		            }
		            var t_tggno = $.trim($('#txtTggno').val());
		            var t_driverno = ""; 
		            var t_where = "where=^^ tggno='" + t_tggno + "'" + (t_tggno.length == 0 ? " and 1=0 " : "") + " and unpay>0 ";   /// for payb
		            var t_where1 = " where[1]=^^ noa!='" + $('#txtNoa').val() + "'";  // for pays
		            var t_where2 = " where[2]=^^ 1=0 and  driverno='" + t_driverno + "'" + (t_driverno.length == 0 ? " and 1=0 " : "") + " and unpay!=0 ";  // for tre
		            var j = 0, s2 = '', s1 = '';
		            for (var i = 0; i < q_bbsCount; i++) {
		                if ($.trim($('#txtRc2no_' + i).val()).length > 0) {
		                    s2 = s2 + (j == 0 ? "" : " or ") + " noa='" + $('#txtRc2no_' + i).val() + "'";
		                    s1 = s1 + (j == 0 ? "" : " or ") + " rc2no='" + $('#txtRc2no_' + i).val() + "'";
		                    j++;
		                }
		            }
		            t_where = t_where + (s2.length > 0 ? " or (" + s2 + ")" : '') + "^^";
		            t_where2 = t_where2 + (s2.length > 0 ? " or (" + s2 + ")" : '') + "^^";
		            t_where1 = t_where1 + (s1.length > 0 ? " or (" + s2 + ")" : '') + "^^";
		            q_gt('pay_tre', t_where + t_where1 + t_where2, 0, 0, 0, "", r_accy);
		        }
		    }

		    function getOpay() {
		        var t_tggno = $('#txtTggno').val();
		        var s2 = (q_cur == 2 ? " and noa!='" + $('#txtNoa').val() + "'" : '');
		        var t_where = "where=^^tggno='" + t_tggno + "'" + s2 + "^^";
		        q_gt("pay_opay", t_where, 1, 1, 0, '', r_accy);
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
		        	case 'payb':
		        		var as = _q_appendData('paybs', '', true);
		        		if(as[0]!=undefined)
		        			$('#txtRc2no').val(as[0].rc2no+';'+as[0].total);
		        	break;
		            case 'pay_opay':
		                var as = _q_appendData('pay', '', true);
		                var s1 = q_trv((as.length > 0 ? round(as[0].total, 0) : 0));

		                $('#textOpay').val(s1);
		                $('#textOpayOrg').val(s1);

		                break;
		            case 'pay_tre':
		                for (var i = 0; i < q_bbsCount; i++) {
		                    if ($('#txtRc2no_' + i).val().length > 0) {
		                        $('#txtRc2no_' + i).val('');
		                        $('#txtPaysale_' + i).val('');
		                        $('#txtUnpay_' + i).val('');
		                        $('#txtPart2_' + i).val('');
		                        $('#txtUnpayorg_' + i).val('');
		                    }
		                }
		                var as = _q_appendData("tre", "", true);
		                for (var i = 0; i < as.length; i++) {
		                    if (as[i].total - as[i].paysale == 0) {
		                        as.splice(i, 1);
		                        i--;
		                    } else {
		                        as[i]._unpay = (as[i].total - as[i].paysale).toString();
		                        as[i].paysale = 0;
		                    }
		                }

		                if (!t_Saving) 
		                    q_gridAddRow(bbsHtm, 'tbbs', 'txtRc2no,txtPaysale,txtUnpay,txtUnpayorg,txtPart2', as.length, as, 'noa,paysale,_unpay,_unpay,part2', 'txtRc2no', '');
		                else {/// 自動沖帳
		                   /* $('#txtOpay').val(0);
		                    $('#txtUnopay').val(0);
		                    var t_money = 0;
		                    for (var i = 0; i < q_bbsCount; i++) {
		                        t_money += q_float('txtMoney_' + i) + q_float('txtChgs_' + i);
		                    }

		                    var t_unpay, t_pay;
		                    for (var i = 0; i < q_bbsCount; i++) {
		                        if (i < as.length && as[i].total - as[i].paysale != 0) {
		                            $('#txtRc2no_' + i).val(as[i].noa);
		                            $('#txtPart2_' + i).val(as[i].part2);
		                            t_unpay = as[i]._unpay;

		                            q_tr('txtUnpayorg_' + i, t_unpay);

		                            if (t_money >= t_unpay) {
		                                q_tr('txtPaysale_' + i, t_unpay);
		                                $('#txtUnpay_' + i).val(0);
		                                t_money = t_money - t_unpay;
		                            }
		                            else {
		                                q_tr('txtPaysale_' + i, t_money);
		                                q_tr('txtUnpay_' + i, t_unpay - t_money);
		                                t_money = 0;
		                            }
		                        }
		                        else {
		                            $('#txtRc2no_' + i).val('');
		                            $('#txtPaysale_' + i).val('');
		                            $('#txtUnpay_' + i).val('');
		                        }
		                    }

		                    if (t_money > 0)
		                        q_tr('txtOpay', t_money);

		                    sum();
		                */}

		                t_Saving = false;
		                sum();

		                break;
		            case q_name:
		                if (q_cur == 4)
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

		    function sum() {
		        var t_money = 0, t_pay = 0,t_sale=0;
		        for (var j = 0; j < q_bbsCount; j++) {
		            if($('#txtAcc2_'+j).val().indexOf('其他收入') == 0 || $('#txtAcc2_'+j).val().indexOf('應收票據') == 0)
		               	t_money -= q_float('txtMoney_' + j);
		            else
		               	t_money += q_float('txtMoney_' + j);
		            
		            t_sale += q_float('txtUnpayorg_' + j);
		            t_pay += q_float('txtPaysale_' + j);
		        }
		        q_tr('txtSale', t_sale);
		        q_tr('txtTotal', t_money);
		        q_tr('txtPaysale', t_pay + q_float('txtUnopay'));
		        q_tr('txtUnpay', q_float('txtSale') - q_float('txtPaysale'));
		        q_tr('textOpay', q_float('textOpayOrg') + q_float('txtOpay') - q_float('txtUnopay'));
		    }

		    function btnOk() {
		        var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
		        if (t_err.length > 0) {
		            alert(t_err);
		            return;
		        }
		        
		        var t_money=0;
		        for (var j = 0; j < q_bbsCount; j++) {
		        	t_money+=q_float('txtMoney_' + j);
		        }
		        if((Math.abs(q_float('txtOpay')-t_money)/t_money)>0.05)
		        {
		        	alert('預付與付款金額總額差異過大');
		            return;
		        }
		        
		        if ($.trim($('#txtTggno').val()) == 0) {
		            alert(m_empty + q_getMsg('lblTgg'));
		            return false;
		        }

		        $('#txtWorker').val(r_name);
		        var t_money = 0, t_chgs = 0, t_paysale,t_mon='';
		        for (var i = 0; i < q_bbsCount; i++) {
		            t_money = q_float('txtMoney_' + i);
		            t_chgs = q_float('txtChgs_' + i);

                    if ($.trim($('#txtAcc1_' + i).val()).length == 0 && t_money + t_chgs > 0) {
		                    t_err = true;
		                    break;
		            }

		           if (t_money != 0 || i == 0)
		                t_mon = $('#txtRc2no_' + i).val();
		        }

		        $('#txtMon').val(t_mon.substr(1,r_len)+'/'+t_mon.substr( r_len+1,2));

		        sum();
		        if (t_err) {
		            alert(m_empty + q_getMsg('lblAcc1') + q_trv(t_money + t_chgs));
		            return false;
		        }

		        var t_opay = q_float('txtOpay');
		        var t_unopay = q_float('txtUnopay');
		        var t1 = q_float('txtPaysale') + q_float('txtOpay') - q_float('txtUnopay');
		        var t2 = q_float('txtTotal');
		        if (t1 != t2) {
		            alert('付款金額  ＋ 費用 ＝' + q_trv(t2) + '\r 【不等於】 沖帳金額 ＋ 預付 －　預付沖帳 ＝' + q_trv(t1) + '\r【差額】=' + Math.abs(t1 - t2));
		            return false;
		        }
		        //alert(sum_paysale + " --" + (sum_money + sum_chgs));
		        $('#txtWorker').val(r_name);


		        var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_paytran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;

		        q_box('pay_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
		    }

		    function combPay_chg() {
		    }

		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            if ($('#btnMinus_' + i).hasClass('isAssign'))    /// 重要
		                continue;

		            $('#txtMoney_' + i).change(function (e) {
		                sum();
		            });

		            $('#txtChgs_' + i).change(function (e) {
		                sum();
		            });

		            $('#txtAcc1_' + i).change(function () {
		                t_IdSeq = -1;
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;

		                var s1 = trim($(this).val());
		                if (s1.length > 4 && s1.indexOf('.') < 0)
		                    $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
		                if (s1.length == 4)
		                    $(this).val(s1 + '.');
		            });

		            $('#txtPaysale_' + i).change(function (e) {
		                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;

		                var t_unpay = dec($('#txtUnpayorg_' + b_seq).val()) - dec($('#txtPaysale_' + b_seq).val());
		                q_tr('txtUnpay_' + b_seq, t_unpay);
		                sum();
		            });
		        }

		        _bbsAssign();
		    }

		    function btnIns() {
		        _btnIns();
		        $('#txtDatea').focus();
		        $('#txtNoa').val('AUTO');
		        $('#txtDatea').val(q_date());
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
		            return;
		        _btnModi();
		        $('#textOpayOrg').val(q_float('textOpay') + q_float('txtUnopay') - q_float('txtOpay'));
		    }

		    function btnPrint() {
		        q_box("z_pay.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'pay', "95%", "650px", m_print);
		    }

		    function wrServer(key_value) {
		        var i;

		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);

		    }

		    function bbsSave(as) {
		        if (!as['acc1'] && !as['paysale']) {
		            as[bbsKey[1]] = '';
		            return;
		        }

		        q_nowf();

		        return true;
		    }


		    function refresh(recno) {
		        _refresh(recno);
		        getOpay();
		        //		        var t_tggno = $('#txtTggno').val();
		        //		        q_gt("pay_opay", "where=^^tggno='" + t_tggno + "'^^", 1, 1, 0, '', r_accy);
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 20%;
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
                width: 80%;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 48%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
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
            .tbbm td input[type="button"] {
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
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
						<td align="center" style="width:18%"><a id='vewDatea'></a></td>
						<td align="center" style="width:28%"><a id='vewComp'></a></td>
                        <td align="center" style="width:28%"><a id='vewDriver'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp,4'>~comp,4</td>
                        <td align="center" id='driver'>~driver</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1" ><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2" >
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td4" >
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td class="td1" ><span> </span><a id='lblAcomp' class="lbl btn"></a></td>
						<td class="td2" >
						<input id="txtCno"  type="text" class="txt c4"/>
						<input id="txtAcomp"    type="text" class="txt c5"/>
						</td>
						<td class="td7"><span> </span><a id='lblPayc' class="lbl"></a></td>
						<td class="td8">
						<input id="txtPayc" type="text" class="txt c1"/>
						</td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr2">
                        <td class="td1" ><span> </span><a id='lblTgg' class="lbl btn"></a></td>
						<td class="td2" >
                        <input id="txtTggno" type="text" class="txt"/>
						</td>
						<td class="td3" colspan="2"><input id="txtComp"  type="text" class="txt" style="width:100%" /></td>
						<td class="td4">
							<input type="button" id="btnRc2no" class="txt c1 " />
						</td>
						<td class="6">
						<input type="button" id="btnVcc" class="txt c1 " />
						</td>
						<td class="td7"><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td8" >
						<input id="txtMon"  type="text" class="txt"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblSale' class="lbl"></a></td>
						<td class="td2">
						<input id="txtSale"  type="text" class="txt num c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblTotal' class="lbl"></a></td>
						<td class="td4">
						<input id="txtTotal" type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblPaysale' class="lbl"></a></td>
						<td class="td6">
						<input id="txtPaysale"  type="text" class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblUnpay' class="lbl"></a></td>
						<td class="td8">
						<input id="txtUnpay"  type="text" class="txt num c1"/>
						</td>
					</tr>  
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblOpay' class="lbl"></a></td>
						<td class="td2">
						<input id="txtOpay"  type="text" class="txt num c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblUnopay' class="lbl"></a></td>
						<td class="td4">
						<input id="txtUnopay"  type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblTextopay' class="lbl"></a></td>
						<td class="td6">
						<input id="textOpay"  type="text" class="txt num c1"/>
                        <input type='hidden' id="textOpayOrg" />
						</td>
						<td class="td7"><input type="button" id="btnAccc" class="txt c1 " /></td>
						<td class="td8">
						<input id="txtAccno"  type="text" class="txt c1"/>
						</td>

					</tr>
					<tr class="tr5">
						<td class="td1"> <a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan='3' ><textarea id="txtMemo"  rows='3' cols='3' style="width: 99%; height: 50px;" ></textarea></td>
						<td class="td5" >
							<a id='lblRc2no' class="lbl"></a>
							<p style="height:1%;"></p>
							<a id='lblWorker' class="lbl"></a>
						</td>
						<td class="td6" >
							<input id="txtRc2no"  type="text" class="txt c1"/>
							<p style="height:1%;"></p>
							<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td class="td7"><input type="button" id="btnAuto" class="txt c1 "  style="color:Red"/>
                        <input type="button" id="btnGqbPrint" class="txt c1 "/></td>
						<td class="td8" ></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblChecker" class="lbl"></a></td>
						<td class="td2">
						<input id="txtchecker" type="text" class="txt c2"/>
						<input id="txtCheckermemo"  type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id="lblApprov" class="lbl"></a></td>
						<td class="td4">
						<input id="txtApprov"  type="text" class="txt c2"/>
						<input id="txtApprovmemo"  type="text" class="txt c3"/>
						</td>
						<td class="td5"><span> </span><a id="lblApprove"class="lbl"></a></td>
						<td class="td6">
						<input id="txtApprove"  type="text" class="txt c2"/>
						<input id="txtApprovememo"  type="text" class="txt c3"/>
						</td>
						<td class="td7"><span> </span><a id="lblApprove2"class="lbl"></a></td>
						<td class="td8">
						<input id="txtApprove2"  type="text" class="txt c2"/>
						<input id="txtApprove2memo"  type="text" class="txt c3"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:8%;"><a id='lblAcc1'></a></td>
					<td align="center" style="width:3%;"><a id='lblMoney'></a></td>
					<td align="center" style="width:3%;"><a id='lblChgsTran'></a></td>
					<td align="center" style="width:4%;"><a id='lblCheckno'></a></td>
					<td align="center" style="width:4%;"><a id='lblAccount'></a></td>
					<td align="center" style="width:8%;"><a id='lblBank'></a></td>
					<td align="center" style="width:3%;"><a id='lblIndate'></a></td>
					<td align="center" style="width:5%;"><a id='lblMemos'></a></td>
					<td align="center" style="width:3%;"><a id='lblPaysales'></a></td>
					<td align="center" style="width:3%;"><a id='lblUnpay_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input type="button" id="btnMinus.*"  value='-' style=" font-weight: bold;" />
					<input type="text" id="txtNoq.*" style="display:none;" />
					</td>
					<td>
						<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
                        <input type="text" id="txtAcc1.*"  style="width:35%;"/>
						<input type="text" id="txtAcc2.*"  style="width:45%;"/>
					</td>
					<td>
					<input type="text" id="txtMoney.*" style="text-align:right;width:95%;"/>
					</td>
					<td>
					<input type="text" id="txtChgs.*" style="text-align:right;width:95%;"/>
					<input type="text" id="txtPartno.*"  style="float:left;width:25%;" /><input type="text" id="txtPart.*" style="float:left;width:57%;"/>
					</td>
					<td>
					<input type="text" id="txtCheckno.*"  style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtAccount.*"  style="width:95%;" />
                     </td>
					<td>
					<input type="button" id="btnBankno.*"  style="float:left;width:7%;" value="."/>
					<input type="text" id="txtBankno.*"  style="float:left;width:35%;" />
					<input type="text" id="txtBank.*" style="float:left;width:47%;"/>
					</td>
					<td>
					<input type="text" id="txtIndate.*" style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtMemo.*" style="width:95%;"/>
                    <input type="text" id="txtRc2no.*" style="width:95%;" />
					</td>
  					<td>
					<input type="text" id="txtPaysale.*" style="text-align:right;width:95%;"/>
					<input type="text" id="txtUnpayorg.*" style="text-align:right;width:95%;"/>
					</td>
					<td>
					<input type="text" id="txtUnpay.*"  style="width:95%; text-align: right;" />
					<input type="text" id="txtPart2.*"  style="float:left;width: 95%;"/>
					</td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
