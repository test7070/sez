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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 's';
            var q_name = "vcc";
            var decbbs = ['money', 'total', 'weight', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'weight2'];
            var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney', 'totalus'];
            var q_readonly = ['txtNoa', 'txtAccno', 'txtWorker', 'txtWorker2', 'txtOrdeno', 'txtMoney', 'txtTax', 'txtTotal', 'txtWeight','txtTotalus','txtTranmoney'];
            var q_readonlys = ['txtTotal','txtOrdeno','txtNo2'];
            var bbmNum = [['txtFloata',10,2,1],['txtTotalus', 10, 2, 1], ['txtPrice', 10, 3, 1], ['txtTranmoney', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtWeight', 10, 0, 1]];
            var bbsNum = [['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1], ['txtRadius', 10, 3, 1], ['txtWidth', 10, 2, 1], ['txtDime', 10, 3, 1], ['txtLengthb', 10, 2, 1], ['txtMount', 10, 2, 1], ['txtWeight', 10, 1, 1], ['txtPrice', 10, 2, 1], ['txtTotal', 10, 0, 1], ['txtGweight', 10, 1, 1]];
            var bbmMask = [];
            var bbsMask = [['txtStyle', 'A']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
            //ajaxPath = "";
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,tel,zip_fact,addr_fact,paytype', 'txtCustno,txtComp,txtTel,txtPost,txtAddr,txtPaytype', 'cust_b.aspx']
            , ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            , ['txtUno_', 'btnUno_', 'view_uccc', 'uno,productno,class,spec,style,product,radius,width,dime,lengthb', 'txtUno_,txtProductno_,txtClass_,txtSpec_,txtStyle_,txtProduct_,txtRadius_,txtWidth_,txtDime_,txtLengthb_', 'uccc_seek_b.aspx', '95%', '60%']
            , ['txtStoreno2_', 'btnStoreno2_', 'store', 'noa,store', 'txtStoreno2_,txtStore2_', 'store_b.aspx']
            , ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('style', '', 0, 0, 0, '');
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
                // 1=最後一筆  0=第一筆

            }///  end Main()

            var
            t_spec;
            //儲存spec陣列
            function mainPost() {// 載入資料完，未 refresh 前
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
                //q_cmbParse("cmbStype", q_getPara('rc2.stype'));
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                q_cmbParse("combPaytype", q_getPara('rc2.paytype'));
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                q_cmbParse("cmbKind", q_getPara('sys.stktype'));
                q_gt('spec', '', 0, 0, 0, "", r_accy);
                //=======================================================
                $("#cmbTypea").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#cmbKind").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                }).click(function(e) {
                    size_change();
                });
                $("#cmbTrantype").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#cmbTaxtype").change(function(e) {
                    sum();
                });
                $("#combPaytype").change(function(e) {
                    if (q_cur == 1 || q_cur == 2)
                        $('#txtPaytype').val($('#combPaytype').find(":selected").text());
                });
                $("#txtPaytype").focus(function(e) {
                    var n = $(this).val().match(/[0-9]+/g);
                    var input = document.getElementById("txtPaytype");
                    if ( typeof (input.selectionStart) != 'undefined' && n != null) {
                        input.selectionStart = $(this).val().indexOf(n);
                        input.selectionEnd = $(this).val().indexOf(n) + n.length + 1;
                    }
                }).click(function(e) {
                    var n = $(this).val().match(/[0-9]+/g);
                    var input = document.getElementById("txtPaytype");
                    if ( typeof (input.selectionStart) != 'undefined' && n != null) {
                        input.selectionStart = $(this).val().indexOf(n);
                        input.selectionEnd = $(this).val().indexOf(n) + n.length + 1;
                    }
                });
                //=====================================================================
                /* 若非本會計年度則無法存檔 */
                $('#txtDatea').focusout(function() {
                    if ($(this).val().substr(0, 3) != r_accy) {
                        $('#btnOk').attr('disabled', 'disabled');
                        alert(q_getMsg('lblDatea') + '非本會計年度。');
                    } else {
                        $('#btnOk').removeAttr('disabled');
                    }
                });
                $('#lblOrdes').click(function() {
                    btnOrdes();
                });
                $('#lblAccc').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
                });

                $('#lblInvono').click(function() {
                    t_where = '';
                    t_invo = $('#txtInvono').val();
                    if (t_invo.length > 0) {
                        t_where = "noa='" + t_invo + "'";
                        q_box("invoice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('popInvo'));
                    }
                });
                $('#btnImportVcce').click(function() {
                    if (q_cur == 1 || q_cur == 2) {
                        var t_carno = $('#txtCarno').val();
                        if (emp(t_carno)) {
                            alert('請輸入 : 【' + q_getMsg('lblCarno') + '】');
                        } else {
                            t_where = "where=^^ carno='" + t_carno + "' ^^";
                            q_gt('vcce', t_where, 0, 0, 0, "", r_accy);
                        }
                    }
                });
                $('#txtFloata').change(function() {
                    sum();
                });
                $('#txtTax').change(function() {
                    sum();
                });
                $('#txtAddr').change(function() {
                    var t_custno = trim($(this).val());
                    if (!emp(t_custno)) {
                        focus_addr = $(this).attr('id');
                        var t_where = "where=^^ noa='" + t_custno + "' ^^";
                        q_gt('cust', t_where, 0, 0, 0, "");
                    }
                });
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case 'ordes':
                        if (q_cur > 0 && q_cur < 4) {//  q_cur： 0 = 瀏覽狀態  1=新增  2=修改 3=刪除  4=查詢
                            b_ret = getb_ret();
                            ///  q_box() 執行後，選取的資料
                            if (!b_ret || b_ret.length == 0)
                                return;
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2,txtPrice,txtStyle,txtClass,txtUno,txtMount', b_ret.length, b_ret, 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2,price,style,class,uno,mount', 'txtProductno,txtProduct,txtSpec');
                            /// 最後 aEmpField 不可以有【數字欄位】
                        }
                        for (var i = 0; i < ret.length; i++) {
                            $('#txtMount_' + i).change();
                        }
                        sum();
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            var focus_addr = '';
            var StyleList = '';
            function q_gtPost(t_name) {/// 資料下載後 ...
                switch (t_name) {
                    case 'spec':
                        t_spec = _q_appendData("spec", "", true);
                        break;
                    case 'style' :
                        var as = _q_appendData("style", "", true);
                        StyleList = new Array();
                        StyleList = as;
                        break;
                    case 'cust':
                        var as = _q_appendData("cust", "", true);
                        if (as[0] != undefined && focus_addr != '') {
                            $('#' + focus_addr).val(as[0].addr_fact);
                            focus_addr = '';
                        }
                        break;
                    case 'vcce':
                        var as = _q_appendData("vcces", "", true);
                        if (as[0] != undefined) {
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtSpec,textSize1,textSize2,textSize3,txtDime,txtWidth,txtLengthb,txtMount,txtWeight,txtPrice', as.length, as, 'uno,productno,product,spec,dime,width,lengthb,dime,width,lengthb,mount,weight,price', 'txtUno');
                        }
                        sum();
                        break;
                    case q_name:
                        if (q_cur == 4)// 查詢
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOrdes() {
                var t_custno = trim($('#txtCustno').val());
                var t_where = '';
                if (t_custno.length > 0) {
                    t_where = "enda='0' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");
                    ////  sql AND 語法，請用 &&
                    t_where = t_where;
                } else {
                    alert(q_getMsg('msgCustEmp'));
                    return;
                }
                q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
            }/// q_box()  開 視窗

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtMon').val().length == 0)
                    $('#txtMon').val($('#txtDatea').val().substring(0, 6));
                if (!q_cd($('#txtMon').val() + '/01')) {
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtDatea').val().substring(0, 3) != r_accy) {
                    alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
                    Unlock(1);
                    return;
                }
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
                $('#txtAccno').val(xmlString);
                Unlock(1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('vccst_s.aspx', q_name + '_s', "500px", "530px", q_getMsg("popSeek"));
            }

            function getTheory(b_seq) {
                t_Radius = dec($('#txtRadius_' + b_seq).val());
                t_Width = dec($('#txtWidth_' + b_seq).val());
                t_Dime = dec($('#txtDime_' + b_seq).val());
                t_Lengthb = dec($('#txtLengthb_' + b_seq).val());
                t_Mount = dec($('#txtMount_' + b_seq).val());
                t_Style = $('#txtStyle_' + b_seq).val();
                if ($('#cmbKind').val().substr(1, 1) == '4') {//鋼胚
                    q_tr('txtTheory_' + b_seq, round(t_Mount * theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), t_Dime, t_Width, t_Lengthb), 0));
                } else {
                    q_tr('txtTheory_' + b_seq, theory_st(StyleList, t_Radius, t_Width, t_Dime, t_Lengthb, t_Mount, t_Style));
                }
            }

            function bbsAssign() {/// 表身運算式
                for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {

                        $('#btnMinus_' + j).click(function() {
                            btnMinus($(this).attr('id'));
                        });
                        $('#txtStyle_' + j).blur(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            ProductAddStyle(b_seq);
                            getTheory(b_seq);
                        });
                        //將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
                        $('#textSize1_' + j).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtDime_' + b_seq, q_float('textSize1_' + b_seq));
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtRadius_' + b_seq, q_float('textSize1_' + b_seq));
                            }
                            getTheory(b_seq);
                        });
                        $('#textSize2_' + j).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtWidth_' + b_seq, q_float('textSize2_' + b_seq));
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtWidth_' + b_seq, q_float('textSize2_' + b_seq));
                            }
                            getTheory(b_seq);
                        });
                        $('#textSize3_' + j).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtLengthb_' + b_seq, q_float('textSize3_' + b_seq));
                                //$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtDime_' + b_seq, q_float('textSize3_' + b_seq));
                                //$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());
                            } else {//鋼筋、胚
                                q_tr('txtLengthb_' + b_seq, q_float('textSize3_' + b_seq));
                            }
                            getTheory(b_seq);
                        });
                        $('#textSize4_' + j).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtRadius_' + b_seq, q_float('textSize4_' + b_seq));
                                // $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtLengthb_' + b_seq, q_float('textSize4_' + b_seq));
                                //$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());
                            }
                            getTheory(b_seq);
                        });
                        $('#txtMount_' + j).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            getTheory(b_seq);
                        });
                        //-------------------------------------------------
                        $('#txtSpec_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;

                            if ($('#cmbKind').val().substr(1, 1) == '4') {//鋼胚
                                q_tr('txtTheory_' + b_seq, theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), dec($('#txtDime_' + b_seq).val()), dec($('#txtWidth_' + b_seq).val()), dec($('#txtLengthb_' + b_seq).val())));
                            }
                        });
                        $('#txtUnit_' + j).focusout(function() {
                            sum();
                        });
                        $('#txtWeight_' + j).focusout(function() {
                            sum();
                        });
                        $('#txtPrice_' + j).focusout(function() {
                            sum();
                        });
                        $('#txtMount_' + j).focusout(function() {
                            sum();
                        });
                        $('#txtTotal_' + j).focusout(function() {
                            sum();
                        });
                    }
                }//j
                _bbsAssign();
                size_change();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtMon').val(q_date().substring(0, 6));
                $('#txtDatea').focus();
                size_change();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtDatea').focus();
                size_change();
                sum();
            }

            function btnPrint() {
                q_box('z_vccst.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(null, bbmKey[0], bbsKey[1], '', 2);
                // key_value
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {//不存檔條件
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['type'] = abbm2['type'];
                as['mon'] = abbm2['mon'];
                as['noa'] = abbm2['noa'];
                as['datea'] = abbm2['datea'];
                as['tggno'] = abbm2['tggno'];
                as['kind'] = abbm2['kind'];
                if (abbm2['storeno'])
                    as['storeno'] = abbm2['storeno'];

                t_err = '';
                if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
                    t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';

                if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
                    t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

                if (t_err) {
                    alert(t_err);
                    return false;
                }

                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                $('#txtMoney').attr('readonly', true);
                $('#txtTax').attr('readonly', true);
                $('#txtTotal').attr('readonly', true);
                $('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

                var t_mount = 0, t_price = 0, t_money = 0, t_weight = 0, t_total = 0, t_tax = 0;
                var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
                var t_float = q_float('txtFloata');
                for (var j = 0; j < q_bbsCount; j++) {
                    t_weights = q_float('txtWeight_' + j);
                    t_prices = q_float('txtPrice_' + j);
                    t_mounts = q_float('txtMount_' + j);
                    t_moneys = t_prices.mul(t_mounts).round(0);

                    t_weight = t_weight.add(t_weights);
                    t_mount = t_mount.add(t_mounts);
                    t_money = t_money.add(t_moneys);

                    $('#txtTotal_' + j).val(FormatNumber(t_money));
                }
                t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
                switch ($('#cmbTaxtype').val()) {
                    case '1':
                        // 應稅
                        t_tax = round(t_money * t_taxrate, 0);
                        t_total = t_money + t_tax;
                        break;
                    case '2':
                        //零稅率
                        t_tax = 0;
                        t_total = t_money + t_tax;
                        break;
                    case '3':
                        // 內含
                        t_tax = round(t_money / (1 + t_taxrate) * t_taxrate, 0);
                        t_total = t_money;
                        t_money = t_total - t_tax;
                        break;
                    case '4':
                        // 免稅
                        t_tax = 0;
                        t_total = t_money + t_tax;
                        break;
                    case '5':
                        // 自定
                        $('#txtTax').attr('readonly', false);
                        $('#txtTax').css('background-color', 'white').css('color', 'black');
                        t_tax = round(q_float('txtTax'), 0);
                        t_total = t_money + t_tax;
                        break;
                    case '6':
                        // 作廢-清空資料
                        t_money = 0, t_tax = 0, t_total = 0;
                        break;
                    default:
                }
                t_price = q_float('txtPrice');
                if (t_price != 0) {
                    $('#txtTranmoney').val(FormatNumber(t_weight.mul(t_price).round(0)));
                }
                $('#txtWeight').val(FormatNumber(t_weight));

                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtTax').val(FormatNumber(t_tax));
                $('#txtTotal').val(FormatNumber(t_total));
                $('#txtTotalus').val(FormatNumber(Math.round(q_float('txtTotal').mul(q_float('txtFloata'),2))));
            }

            function refresh(recno) {
                _refresh(recno);
                size_change();
                $('input[id*="txtProduct_"]').each(function() {
                    t_IdSeq = -1;
                    /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    OldValue = $(this).val();
                    nowStyle = $('#txtStyle_' + b_seq).val();
                    if (!emp(nowStyle) && (StyleList[0] != undefined)) {
                        for (var i = 0; i < StyleList.length; i++) {
                            if (StyleList[i].noa.toUpperCase() == nowStyle) {
                                styleProduct = StyleList[i].product;
                                if (OldValue.substr(OldValue.length - styleProduct.length) == styleProduct) {
                                    OldValue = OldValue.substr(0, OldValue.length - styleProduct.length);
                                }
                            }
                        }
                    }
                    $(this).attr('OldValue', OldValue);
                });
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtProductno_':
                        $('input[id*="txtProduct_"]').each(function() {
                            $(this).attr('OldValue', $(this).val());
                        });
                        ProductAddStyle(b_seq);
                        $('#txtStyle_' + b_seq).focus();
                        break;
                    case 'txtUno_':
                        size_change();
                        break;
                }

            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                size_change();
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                size_change();
                if (q_tables == 's')
                    bbsAssign();
            }

            function q_appendData(t_Table) {
                dataErr = !_q_appendData(t_Table);
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

            function size_change() {
                if (q_cur == 1 || q_cur == 2) {
                    $('input[id*="textSize"]').removeAttr('disabled');
                } else {
                    $('input[id*="textSize"]').attr('disabled', 'disabled');
                }
                if ($('#cmbKind').val().substr(0, 1) == 'A') {
                    $('#lblSize_help').text("厚度x寬度x長度");
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).show();
                        $('#textSize2_' + j).show();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).hide();
                        $('#x1_' + j).show();
                        $('#x2_' + j).show();
                        $('#x3_' + j).hide();
                        $('#Size').css('width', '230px');
                        $('#txtSpec_' + j).css('width', '229px');
                        $('#textSize1_' + j).val($('#txtDime_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0);
                    }
                } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                    $('#lblSize_help').text("短徑x長徑x厚度x長度");
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).show();
                        $('#textSize2_' + j).show();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).show();
                        $('#x1_' + j).show();
                        $('#x2_' + j).show();
                        $('#x3_' + j).show();
                        $('#Size').css('width', '313px');
                        $('#txtSpec_' + j).css('width', '311px');
                        $('#textSize1_' + j).val($('#txtRadius_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtDime_' + j).val());
                        $('#textSize4_' + j).val($('#txtLengthb_' + j).val());
                    }
                } else {//鋼筋和鋼胚
                    $('#lblSize_help').text("長度");
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).hide();
                        $('#textSize2_' + j).hide();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).hide();
                        $('#x1_' + j).hide();
                        $('#x2_' + j).hide();
                        $('#x3_' + j).hide();
                        $('#Size').css('width', '65px');
                        $('#txtSpec_' + j).css('width', '60px');
                        $('#textSize1_' + j).val(0);
                        $('#txtDime_' + j).val(0);
                        $('#textSize2_' + j).val(0);
                        $('#txtWidth_' + j).val(0);
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0);
                    }
                }
            }

            function FormatNumber(n) {
                var xx = "";
                if (n < 0) {
                    n = Math.abs(n);
                    xx = "-";
                }
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }


            Number.prototype.round = function(arg) {
                return Math.round(this.mul(Math.pow(10, arg))).div(Math.pow(10, arg));
            };
            Number.prototype.div = function(arg) {
                return accDiv(this, arg);
            };
            function accDiv(arg1, arg2) {
                var t1 = 0, t2 = 0, r1, r2;
                try {
                    t1 = arg1.toString().split(".")[1].length;
                } catch (e) {
                }
                try {
                    t2 = arg2.toString().split(".")[1].length;
                } catch (e) {
                }
                with (Math) {
                    r1 = Number(arg1.toString().replace(".", ""));
                    r2 = Number(arg2.toString().replace(".", ""));
                    return (r1 / r2) * pow(10, t2 - t1);
                }
            }


            Number.prototype.mul = function(arg) {
                return accMul(arg, this);
            };
            function accMul(arg1, arg2) {
                var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
                try {
                    m += s1.split(".")[1].length;
                } catch (e) {
                }
                try {
                    m += s2.split(".")[1].length;
                } catch (e) {
                }
                return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
            }


            Number.prototype.add = function(arg) {
                return accAdd(arg, this);
            };
            function accAdd(arg1, arg2) {
                var r1, r2, m;
                try {
                    r1 = arg1.toString().split(".")[1].length;
                } catch (e) {
                    r1 = 0;
                }
                try {
                    r2 = arg2.toString().split(".")[1].length;
                } catch (e) {
                    r2 = 0;
                }
                m = Math.pow(10, Math.max(r1, r2));
                return (Math.round(arg1 * m) + Math.round(arg2 * m)) / m;
            }


            Number.prototype.sub = function(arg) {
                return accSub(this, arg);
            };
            function accSub(arg1, arg2) {
                var r1, r2, m, n;
                try {
                    r1 = arg1.toString().split(".")[1].length;
                } catch (e) {
                    r1 = 0;
                }
                try {
                    r2 = arg2.toString().split(".")[1].length;
                } catch (e) {
                    r2 = 0;
                }
                m = Math.pow(10, Math.max(r1, r2));
                n = (r1 >= r2) ? r1 : r2;
                return parseFloat(((Math.round(arg1 * m) - Math.round(arg2 * m)) / m).toFixed(n));
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 300px;
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
                width: 750px;
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
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
            .dbbs {
                width: 1800px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
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
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:40px; color:black;"><a id="veTypea"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewComp"> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td id="typea=vcc.typea" style="text-align: center;">~typea=vcc.typea</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="nick" style="text-align: center;">~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
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
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td>
						<input id="txtMon" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblOrdes' class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtOrdeno"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCno" type="text" style="float:left;width:20%;"/>
						<input id="txtAcomp" type="text" style="float:left;width:80%;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtPaytype" type="text" style="float:left; width:120px;"/>
						<select id="combPaytype" style="float:left; width:20px;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCustno" type="text" style="float:left;width:35%;"/>
						<input id="txtComp" type="text" style="float:left;width:65%;"/>
						<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtInvono"  type="text" class="txt c1"/>
						</td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtPost" type="text" style="float:left;width:20%;"/>
						<input id="txtAddr" type="text" style="float:left;width:80%;"/>
						</td>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td>
						<input id="txtTel" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCardeal' class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCardealno" type="text" style="float:left;width:50%;"/>
						<input id="txtCardeal" type="text" style="float:left;width:50%;"/>
						</td>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td>
						<input id="txtCarno"	type="text" class="txt c1"/>
						</td>
						<td>
						<input id="btnImportVcce" type="button" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td>
						<input id="txtWeight" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td>
						<input id="txtPrice"  type="text" class="txt num c1" />
						</td>
						<td></td>
						<td><span> </span><a id="lblTranmoney" class="lbl"> </a></td>
						<td>
						<input id="txtTranmoney" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td>
						<input id="txtMoney" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
						<input id="txtTax" type="text" class="txt num c1" />
						</td>
						<td><span style="float:left;display:block;width:10px;"></span> 
							<select id="cmbTaxtype" style="float:left;width:80px;" ></select>
						</td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td>
						<input id="txtTotal" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" ></select></td>
						<td>
						<input id="txtFloata" type="text" class="txt c1 num" />
						</td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td>
						<input id="txtTotalus" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7">
						<input id="txtMemo" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td>
						<input id="txtWorker2"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno" type="text" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:150px;"><a id="lblUno_st" > </a></td>
					<td align="center" style="width:120px;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:70px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblProduct_st'> </a></td>
					<td align="center" id="Size"><a id='lblSize_help'> </a>
					<BR>
					<a id='lblSize_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblSizea_st'></a></td>
					<td align="center" style="width:80px;"><a id='lblMount_st'></a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_st'></a></td>
					<td align="center" style="width:80px;"><a id='lblPrices_st'></a></td>
					<td align="center" style="width:80px;"><a id='lblTotals_st'></a></td>
					<td align="center" style="width:80px;"><a id='lblGweight_st'></a></td>
					<td align="center" style="width:60px;">寄Y
					<BR>
					代Z</td>
					<td align="center" style="width:80px;"><a id='lblStore2_st'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMemos_st'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input class="btn" id="btnUno.*" type="button" value='.' style="width:5%;"/>
					<input id="txtUno.*" type="text" style="width:80%;"/>
					</td>
					<td>
					<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
					<input  id="txtProductno.*" type="text" style="width:83%;" />
					<input id="txtClass.*" type="text" style='width: 83%;'/>
					</td>
					<td>
					<input type="text" id="txtStyle.*" style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtProduct.*" style="width:95%;" />
					</td>
					<!--<td><input class="txt c1" id="txtSpec.*" type="text"/></td>-->
					<td>
					<input class="txt num" id="textSize1.*" type="text" style="float: left;width:60px;" disabled="disabled"/>
					<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >
						X
					</div>
					<input class="txt num" id="textSize2.*" type="text" style="float: left;width:60px;"  disabled="disabled"/>
					<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">
						X
					</div>
					<input class="txt num" id="textSize3.*" type="text" style="float: left;width:60px;" disabled="disabled"/>
					<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">
						X
					</div>
					<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:60px;" disabled="disabled"/>
					<!--上為虛擬下為實際-->
					<input id="txtRadius.*" type="text" style="display:none;"/>
					<input id="txtWidth.*" type="text" style="display:none;"/>
					<input id="txtDime.*" type="text" style="display:none;"/>
					<input id="txtLengthb.*" type="text" style="display:none;"/>
					<input id="txtSpec.*" type="text" style="float:left;"/>
					</td>
					<td>
					<input id="txtSize.*" type="text" style="width:95%;" />
					</td>
					<td>
					<input id="txtMount.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtPrice.*" type="text"  class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtTotal.*" type="text" class="txt num" style="width:95%;"/>
					<input id="txtTheory.*" type="text" class="txt num" style="width:95%;"/>
					</td>
					<td>
					<input id="txtGweight.*" type="text"  class="txt num" style="width:95%;"/>
					</td>
					<td >
					<input class="txt" id="txtUsecoil.*" type="text" style="text-align:center;width:95%;"/>
					</td>
					<td >
					<input class="btn"  id="btnStoreno2.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;display:none;" />
					<input  id="txtStoreno2.*" type="text" style="width:95%;" />
					<input id="txtStore2.*" type="text" style='width: 95%;'/>
					</td>
					<td>
					<input id="txtMemo.*" type="text" class="txt" style="width:95%;"/>
					<input id="txtOrdeno.*" type="text" style="width:65%;" />
					<input id="txtNo2.*" type="text" style="width:25%;" />
					<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
