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

            qBoxNo3id = -1;
            q_desc = 1;
            q_tables = 't';
            var q_name = "orde";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtWeight', 'txtSales'];
            var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3', 'txtTheory', 'txtC1', 'txtNotv'];
            var q_readonlyt = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3', 'txtTheory'];
            var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtTotalus', 10, 2, 1], ['txtWeight', 10, 2, 1], ['txtFloata', 10, 4, 1]];
            // 允許 key 小數
            var bbsNum = [['txtPrice', 12, 2, 1], ['txtTotal', 12, 2, 1, 1], ['txtWeight', 10, 2, 1], ['txtMount', 10, 2, 1],['txtTheory',10,2,1]];
            var bbtNum = [['txtMount', 10, 2, 1], ['txtWeight', 10, 2, 1]];
            var bbmMask = [];
            var bbsMask = [['txtStyle', 'A']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; // 只在根目錄執行，才需設定
            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], ['txtUno_', 'btnUno_', 'view_uccc', 'uno,class,spec,unit', 'txtUno_,txtClass_,txtSpec_,txtUnit_', 'uccc_seek_b.aspx', '95%', '60%'], ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,paytype,trantype,tel,fax,zip_comp,addr_fact', 'txtCustno,txtComp,txtNick,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx'], ['txtUno__', 'btnUno__', 'view_uccc', 'uno', 'txtUno__', 'uccc_seek_b.aspx', '95%', '60%'], ['txtProductno__', 'btnProductno__', 'assignproduct', 'noa,product', 'txtProductno__,txtProduct__', 'ucc_b.aspx']);
            brwCount2 = 10;
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no2'];
                bbtKey = ['noa', 'no2'];
                /*$('#btnBBTShow').click(function() {
                 $('#dbbt').toggle();
                 });*/

                q_brwCount();
                // 計算 合適  brwCount
                q_gt('style', '', 0, 0, 0, '');
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                // q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
                $('#txtOdate').focus();
            });

            function main() {
                if (dataErr)// 載入資料錯誤
                {
                    dataErr = false;
                    return;
                }
                mainForm(1);
                // 1=最後一筆  0=第一筆
            }//  end Main()

            var t_spec;
            //儲存spec陣列
            function mainPost() {// 載入資料完，未 refresh 前
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
                bbsMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbKind", q_getPara('sys.stktype'));
                q_cmbParse("cmbStype", q_getPara('orde.stype'));
                // 需在 main_form() 後執行，才會載入 系統參數
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                /// q_cmbParse 會加入 fbbm
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
                // comb 未連結資料庫
                q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                $('#btnOrdei').hide();
                //外銷訂單按鈕隱藏
				
                q_gt('spec', '', 0, 0, 0, "", r_accy);
                $('#lblQuat').click(function() {
                    btnQuat();
                });
                $('#btnOrdem').click(function() {
                    q_box("ordem_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';" + r_accy + ";" + q_cur, 'ordem', "95%", "95%", q_getMsg('popOrdem'));
                });
                $('#cmbKind').change(function() {
                    size_change();
                    sum();
                });
                $("#combPaytype").change(function(e) {
                    if (q_cur == 1 || q_cur == 2)
                        $('#txtPaytype').val($('#combPaytype').find(":selected").text());
                });
                $('#cmbStype').change(function() {
                    if ($('#cmbStype').find("option:selected").text() == '外銷')
                        $('#btnOrdei').show();
                    else
                        $('#btnOrdei').hide();
                });
                $("#txtPaytype").focus(function(e) {
                    var n = $(this).val().match(/[0-9]+/g);
                    var input = document.getElementById("txtPaytype");
                    if ( typeof (input.selectionStart) != 'undefined' && n != null) {
                        input.selectionStart = $(this).val().indexOf(n);
                        input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
                    }
                }).click(function(e) {
                    var n = $(this).val().match(/[0-9]+/g);
                    var input = document.getElementById("txtPaytype");
                    if ( typeof (input.selectionStart) != 'undefined' && n != null) {
                        input.selectionStart = $(this).val().indexOf(n);
                        input.selectionEnd = $(this).val().indexOf(n) + (n + "").length;
                    }
                });

                $('#btnOrdei').click(function() {
                    q_box("ordei.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';" + r_accy + ";" + q_cur, 'ordei', "95%", "95%", q_getMsg('popOrdei'));
                });

                $('#txtFloata').change(function() {
                    sum();
                });
                $("#cmbTaxtype").change(function(e) {
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
                $('#txtAddr2').change(function() {
                    var t_custno = trim($(this).val());
                    if (!emp(t_custno)) {
                        focus_addr = $(this).attr('id');
                        var t_where = "where=^^ noa='" + t_custno + "' ^^";
                        q_gt('cust', t_where, 0, 0, 0, "");
                    }
                });
            }

            function q_boxClose(s2) {///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、訂單視窗  關閉時執行
                var
                ret;
                switch (b_pop) {/// 重要：不可以直接 return ，最後需執行 originalClose();
                    case 'quats':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                return;
                            var i, j = 0;
                            for(var i=0;i<q_bbsCount;i++){$('#btnMinus_'+i).click();}
                            $('#txtQuatno').val(b_ret[0].noa);
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtQuatno,txtNo3,txtPrice,txtMount,txtWeight,txtClass,txtTheory', b_ret.length, b_ret, 'productno,product,spec,size,dime,width,lengthb,unit,noa,no3,price,mount,weight,class,theory', 'txtProductno,txtProduct,txtSpec');
                            /// 最後 aEmpField 不可以有【數字欄位】
                            bbsAssign();
                            sum();
                        }
                        break;
                    case 'uccc':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                return;
                            for (var j = 0; j < b_ret.length; j++) {
                                for (var i = 0; i < q_bbtCount; i++) {
                                    var t_uno = $('#txtUno__' + i).val();
                                    if (b_ret[j] && b_ret[j].uno == t_uno) {
                                        b_ret.splice(j, 1);
                                    }
                                }
                            }
                            if (b_ret[0] != undefined) {
                                ret = q_gridAddRow(bbtHtm, 'tbbt', 'txtUno,txtProduct,txtProductno,txtDime,txtWidth,txtLengthb,txtMount,txtWeight,txtSource', b_ret.length, b_ret, 'uno,product,productno,dime,width,lengthb,mount,weight,source', 'txtUno,txtProduct,txtProductno', '__');
                                /// 最後 aEmpField 不可以有【數字欄位】
                                if (qBoxNo3id != -1) {
                                    for (var i = 0; i < ret.length; i++) {
                                        $('#txtNo3__' + ret[i]).val(padL($('#lblNo_' + qBoxNo3id).text(), '0', 3));
                                    }
                                }
                                qBoxNo3id = -1;
                            }
                            bbsAssign();
                            sum();
                        }
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
            var t_uccArray = new Array;
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
                    case q_name:
                    	t_uccArray = _q_appendData("ucc", "", true);
                        if (q_cur == 4)// 查詢
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnQuat() {
                var t_custno = trim($('#txtCustno').val());
                var t_where = '';
                if (t_custno.length > 0) {
                    t_where = (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");
                    ////  sql AND 語法，請用 &&
                    t_where = t_where;
                } else {
                    alert(q_getMsg('msgCustEmp'));
                    return;
                }
                q_box("quatst_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy, 'quats', "95%", "95%", q_getMsg('popQuats'));
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                if ($('#txtOdate').val().length == 0 || !q_cd($('#txtOdate').val())) {
                    alert(q_getMsg('lblOdate') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")/// 自動產生編號
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orde') + $('#txtOdate').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('ordest_s.aspx', q_name + '_s', "550px", "500px", q_getMsg("popSeek"));
            }

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                }
                _bbtAssign();
            }

            function getTheory(b_seq) {
                t_Radius = dec($('#txtRadius_' + b_seq).val());
                t_Width = dec($('#txtWidth_' + b_seq).val());
                t_Dime = dec($('#txtDime_' + b_seq).val());
                t_Lengthb = dec($('#txtLengthb_' + b_seq).val());
                t_Mount = dec($('#txtMount_' + b_seq).val());
                t_Style = $('#txtStyle_' + b_seq).val();
                t_Stype = ($('#cmbStype').find("option:selected").text() == '外銷' ? 1 : 0);
                t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting={
					calc:StyleList,
					ucc:t_uccArray,
					radius:t_Radius,
					width:t_Width,
					dime:t_Dime,
					lengthb:t_Lengthb,
					mount:t_Mount,
					style:t_Style,
					stype:t_Stype,
					productno:t_Productno
				};
                if ($('#cmbKind').val().substr(1, 1) == '4') {//鋼胚
                    q_tr('txtTheory_' + b_seq, round(t_Mount * theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), t_Dime, t_Width, t_Lengthb), 0));
                } else {
                    q_tr('txtTheory_' + b_seq, theory_st(theory_setting));
                }
            }

            function bbsAssign() {/// 表身運算式
				$('input[id*="btnOrdet_"]').each(function(){
					$(this).val($('#lblOrdet_st').text());
				});
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
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
                        $('#btnBorn_' + j).click(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            t_noa = trim($('#txtNoa').val());
                            if (t_noa.length == 0 || t_noa.toUpperCase() == 'AUTO') {
                                return;
                            } else {
                                t_where = "noa='" + $('#txtNoa').val() + "' and no2='" + $('#txtNo2_' + b_seq).val() + "'";
                                q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn'));
                            }
                        });
                        $('#txtStyle_' + j).blur(function() {
                            var n = $(this).attr('id').replace('txtStyle_', '');
                            ProductAddStyle(n);
                        });
                        //計算理論重
                        $('#textSize1_' + j).change(function() {
                            sum();
                        });
                        $('#textSize2_' + j).change(function() {
                            sum();
                        });
                        $('#textSize3_' + j).change(function() {
                            sum();
                        });
                        $('#textSize4_' + j).change(function() {
                            sum();
                        });

                        $('#txtSpec_' + j).change(function() {
                            sum();
                        });
                        $('#txtC1_' + j).change(function() {
                            sum();
                        });
                        $('#btnOrdet_' + j).click(function() {
                            var b_seq = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                            var t_productno = trim($('#txtProductno_' + b_seq).val());
                            //var t_uno = trim($('#txtUno_' + b_seq).val());
                            var t_lengthb = dec(trim($('#txtLengthb_' + b_seq).val()));
                            var t_dime = dec(trim($('#txtDime_' + b_seq).val()));
                            var t_width = dec(trim($('#txtWidth_' + b_seq).val()));
                            var t_radius = dec(trim($('#txtRadius_' + b_seq).val()));
                            var t_unit = trim($('#txtUnit_' + b_seq).val());
                            var t_where = ' 1=1 ' + q_sqlPara2("productno", t_productno)
                            // +    q_sqlPara2("noa", t_uno)
                            + (t_lengthb > 0 ? ' and lengthb >= ' + t_lengthb : '') + (t_width > 0 ? ' and width >= ' + t_width : '') + (t_radius > 0 ? ' and radius >= ' + t_radius : '');
                            //+ q_sqlPara2("unit", t_unit);
                            if ($('#cmbKind').val().substr(0, 1) == 'B')
                                t_where += q_sqlPara2('dime', (t_dime - 0.1), (t_dime + 0.1));
                            else
								t_where += q_sqlPara2('dime', (t_dime * 0.93), (t_dime * 1.07));
                            qBoxNo3id = b_seq;
                            q_box("uccc_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'uccc', "95%", "80%", q_getMsg('popOrdet'));
                        });
                    }
                }
                _bbsAssign();
                size_change();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#cmbKind').val(q_getPara('vcc.kind'));
                size_change();
                $('#txtOdate').val(q_date());
                $('#txtOdate').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                size_change();
                $('#txtOdate').focus();
            }

            function btnPrint() {
                t_where = "noa='" + $('#txtNoa').val() + "'";
                q_box("z_ordestp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbtSave(as) {
                if (!as['uno']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
                if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {//不存檔條件
                    as[bbsKey[1]] = '';
                    /// no2 為空，不存檔
                    return;
                }
                q_nowf();
                as['type'] = abbm2['type'];
                as['mon'] = abbm2['mon'];
                as['noa'] = abbm2['noa'];
                as['odate'] = abbm2['odate'];
                if (!emp(abbm2['datea']))/// 預交日
                    as['datea'] = abbm2['datea'];
                as['custno'] = abbm2['custno'];
                if (!as['enda'])
                    as['enda'] = '0';
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

                var t_mount = 0, t_price = 0, t_money = 0, t_moneyus=0, t_weight = 0, t_total = 0, t_tax = 0;
                var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
                var t_unit = '';
                var t_float = q_float('txtFloata');

                for (var j = 0; j < q_bbsCount; j++) {
                    t_unit = $.trim($('#txtUnit_' + j).val()).toUpperCase();
                    //---------------------------------------
                    if ($('#cmbKind').val().substr(0, 1) == 'A') {
                        q_tr('txtDime_' + j, q_float('textSize1_' + j));
                        q_tr('txtWidth_' + j, q_float('textSize2_' + j));
                        q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
                        q_tr('txtRadius_' + j, q_float('textSize4_' + j));
                    } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                        q_tr('txtRadius_' + j, q_float('textSize1_' + j));
                        q_tr('txtWidth_' + j, q_float('textSize2_' + j));
                        q_tr('txtDime_' + j, q_float('textSize3_' + j));
                        q_tr('txtLengthb_' + j, q_float('textSize4_' + j));
                    } else {//鋼筋、胚
                        q_tr('txtLengthb_' + j, q_float('textSize3_' + j));
                    }
                    getTheory(j);
                    //---------------------------------------
                    t_weights = q_float('txtWeight_' + j);
                    t_prices = q_float('txtPrice_' + j);
                    t_mounts = q_float('txtMount_' + j);
                    if(t_unit.length==0 ||t_unit=='KG' || t_unit=='M2' || t_unit=='M' || t_unit=='批' || t_unit=='公斤' || t_unit=='噸' || t_unit=='頓'){
                    	t_moneys = t_prices.mul(t_weights);
                    }else{
                    	t_moneys = t_prices.mul(t_mounts);
                    }
                    if(t_float==0){
                    	t_moneys = t_moneys.round(0);
                    }else{
                    	t_moneyus = t_moneyus.add(t_moneys.round(2));
                    	t_moneys = t_moneys.mul(t_float).round(0);
                    }
                    t_weight = t_weight.add(t_weights);
                    t_mount = t_mount.add(t_mounts);
                    t_money = t_money.add(t_moneys);
                    $('#txtTotal_' + j).val(FormatNumber(t_moneys));
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
                if(t_float==0)
                	$('#txtTotalus').val(0);
                else
                	$('#txtTotalus').val(FormatNumber(t_moneyus));
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
                if ($('#cmbStype').find("option:selected").text() == '外銷')
                    $('#btnOrdei').show();
                else
                    $('#btnOrdei').hide();
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
                var ret;
                switch (s1) {
                    case 'txtUno_':
                        ret = getb_ret();
                        if (!ret || ret.length == 0)
                            return;
                        if (ret.length > 0 && ret[0] != undefined) {
                            if (emp($('#txtRadius_' + b_seq).val()) || $('#txtRadius_' + b_seq).val() == 0)
                                $('#txtRadius_' + b_seq).val(ret[0].radius);
                            if (emp($('#txtWidth_' + b_seq).val()) || $('#txtWidth_' + b_seq).val() == 0)
                                $('#txtWidth_' + b_seq).val(ret[0].width);
                            if (emp($('#txtLengthb_' + b_seq).val()) || $('#txtLengthb_' + b_seq).val() == 0)
                                $('#txtLengthb_' + b_seq).val(ret[0].lengthb);
                            if (emp($('#txtDime_' + b_seq).val()) || $('#txtDime_' + b_seq).val() == 0)
                                $('#txtDime_' + b_seq).val(ret[0].dime);
                            size_change();
                            $('#textSize1_' + b_seq).change();
                        }
                        break;
                    case 'txtProductno_':
                        $('input[id*="txtProduct_"]').each(function() {
                            $(this).attr('OldValue', $(this).val());
                        });
                        ProductAddStyle(b_seq);
                        $('#txtStyle_' + b_seq).focus();
                        break;
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                size_change();

                if (t_para)
                    $('#btnOrdei').removeAttr('disabled');
                else
                    $('#btnOrdei').attr('disabled', 'disabled');

                if (q_cur == 1)
                    $('#btnOrdem').attr('disabled', 'disabled');
                else
                    $('#btnOrdem').removeAttr('disabled');
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                size_change();
            }

            function btnPlut(org_htm, dest_tag, afield) {
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

            function size_change() {
                if (q_cur == 1 || q_cur == 2) {
                    $('input[id*="textSize"]').removeAttr('disabled');
                } else {
                    $('input[id*="textSize"]').attr('disabled', 'disabled');
                }
                if ($('#cmbKind').val().substr(0, 1) == 'A') {
                    $('#lblSize_help').text(q_getPara('sys.lblSizea'));
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
                    $('#lblSize_help').text(q_getPara('sys.lblSizeb'));
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
                    $('#lblSize_help').text(q_getPara('sys.lblSizec'));
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).hide();
                        $('#textSize2_' + j).hide();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).hide();
                        $('#x1_' + j).hide();
                        $('#x2_' + j).hide();
                        $('#x3_' + j).hide();
                        $('#Size').css('width', '230px');
                        $('#txtSpec_' + j).css('width', '200px');
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
                /*overflow: hidden;*/
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
                width: 800px;
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
                width: 1550px;
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
            #dbbt {
                width: 1550px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewOdate"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewNoa"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewNick"> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td id="odate" style="text-align: center;">~odate</td>
						<td id="noa" style="text-align: center;">~noa</td>
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
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td>
						<input id="txtOdate"  type="text"  class="txt c1"/>
						</td>
						<td><select id="cmbStype" class="txt c1"></select></td>
						
						<td><input id="btnOrdei" type="button" /></td>
						<td align="center">
						<input id="btnBBTShow" type="button" STYLE="display: none;" />
						<input id="btnOrdem" type="button"/>
						</td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtCno" type="text" style="float:left;width:25%;"/>
						<input id="txtAcomp" type="text" style="float:left;width:75%;"/>
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"   type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtCustno" type="text" style="float:left;width:25%;"/>
						<input id="txtComp" type="text" style="float:left;width:75%;"/>
						<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtContract"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan='4'>
						<input id="txtTel" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblQuat"  class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtQuatno" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtFax" type="text" class="txt c1" />
						</td>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
						<input id="txtSales" type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="4">
							<input id="txtPost"  type="text" style="float:left;width:25%;"/>
							<input id="txtAddr"  type="text" style="float:left;width:75%;" />
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td colspan="4">
							<input id="txtPost2"  type="text" style="float:left;width:25%;"/>
							<input id="txtAddr2"  type="text" style="float:left;width:75%;" />
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtPaytype" type="text" style="float:left; width:165px;"/>
						<select id="combPaytype" style="float:left; width:20px;"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td>
						<input id="txtTotalus" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td>
						<input id="txtFloata" type="text" class="txt num c1" />
						</td>
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbCoin" style="float:left;width:80px;" > </select></td>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td>
						<input id="txtWeight"  type="text" class="txt num c1"/>
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
						<td><span style="float:left;display:block;width:10px;"></span><select id="cmbTaxtype" style="float:left;width:80px;" > </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td>
						<input id="txtTotal" type="text" class="txt num c1" />
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
						<td><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td>
						<input id="txtApv" type="text"  class="txt c1" disabled="disabled"/>
						</td>
						<td><span> </span><a id='lblEnd' class="lbl"> </a></td>
						<td><input id="chkEnda" type="checkbox"/></td>
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
					<td align="center" style="width:120px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:35px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:140px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblClasss'> </a></td>
					<td align="center" id='Size'><a id='lblSize_help'> </a>
					<BR>
					<a id='lblSize_st'> </a></td>
					<td align="center" style="width:50px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeights'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotals'> </a><br><a id='lblTheorys'> </a></td>
					<td align="center" style="width:50px;"><a id='lblOrdet_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblGemounts'> </a><br><a id='lblNotv'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDateas'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMemos'> </a></td>
					<td align="center" style="width:40px;"><a id='lblssale_st'> </a></td>
					<td align="center" style="width:40px;"><a id='lblscut_st'> </a></td>
					<td align="center" style="width:80px;"><a id='lblSizea_st'> </a></td>
					<td align="center" style="width:40px;"><a id='lblBorn'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNo2.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input class="btn"  id="btnProduct.*" type="button" value='' style=" font-weight: bold;width:15px;height:25px;float:left;" />
					<input type="text" id="txtProductno.*"  style="width:75px; float:left;"/>
					</td>
					<td>
					<input id="txtStyle.*" type="text" style="width:90%;text-align:center;"/>
					</td>
					<td><span style="width:20px;height:1px;display:block;float:left;"> </span>
					<input id="txtProduct.*" type="text" style="float:left;width:100px;"/>
					<input class="btn" id="btnUno.*" type="button" value='' style="display:none;float:left;width:20px;height:25px;"/>
					<input id="txtUno.*" type="text" style="display:none;float:left;width:100px;" />
					</td><td >
					<input id="txtClass.*" type="text" style="width:90%;text-align:center;"/>
					</td><td>
					<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
					<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >
						x
					</div>
					<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
					<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">
						x
					</div>
					<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
					<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">
						x
					</div>
					<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
					<!--上為虛擬下為實際-->
					<input id="txtRadius.*" type="text" style="display:none;"/>
					<input id="txtWidth.*" type="text" style="display:none;"/>
					<input id="txtDime.*" type="text" style="display:none;"/>
					<input id="txtLengthb.*" type="text" style="display:none;"/>
					<input id="txtSpec.*" type="text" style="float:left;"/>
					</td>
					<td >
					<input  id="txtUnit.*" type="text" style="width:90%;"/>
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
					<td align="center">
						<input id="btnOrdet.*" type="button"/>
					</td>
					<td>
					<input class="txt num " id="txtC1.*" type="text" style="width:95%;"/>
					<input class="txt num " id="txtNotv.*" type="text" style="width:95%;"/>
					</td>
					<td >
					<input class="txt " id="txtDatea.*" type="text" style="width:95%;"/>
					</td>
					<td >
					<input id="txtMemo.*" type="text" style="width:110px; float:left;"/>
					<input id="txtQuatno.*" type="text"  style="width:80px;float:left;"/>
					<input id="txtNo3.*" type="text"  style="width:20px;float:left;"/>
					</td>
					<td align="center">
					<input id="chkIssale.*" type="checkbox"/>
					</td>
					<td align="center">
					<input id="chkIscut.*" type="checkbox"/>
					</td>
					<td>
					<input class="txt " id="txtSize.*" type="text" style="width:95%;"/>
					</td>
					<td align="center">
					<input class="btn"  id="btnBorn.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
				</tr>
			</table>
		</div>
		<div id="dbbt">
			<table id="tbbt" class='tbbt'  border="2"  cellpadding='2' cellspacing='1'>
				<tr style='color:white; background:#003366;' >
					<input class="txt c1"  id="txtNoa..*" type="hidden"  />
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlut" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td class="td2" align="center" style="width:15%;"><a id='lblUno_t'></a></td>
					<td class="td3" align="center" style="width:15%;"><a id='lblProduct_t'></a></td>
					<td class="td4" align="center" style="width:10%;"><a id='lblProductno_t'></a></td>
					<td class="td5" align="center" style="width:8%;"><a id='lblDime_t'></a></td>
					<td class="td6" align="center" style="width:8%;"><a id='lblWidth_t'></a></td>
					<td class="td7" align="center" style="width:8%;"><a id='lblLengthb_t'></a></td>
					<td class="td8" align="center" style="width:8%;"><a id='lblMount_t'></a></td>
					<td class="td9" align="center" style="width:8%;"><a id='lblWeight_t'></a></td>
					<td class="td9" align="center" style="width:2%;"><a id='lblIssale_t'></a></td>
					<td class="td10" align="center" style="width:10%;"><a id='lblSource_t'></a></td>
					<td class="td11" align="center" style="width:8%;"><a id='lblNo2_t'></a></td>
				</tr>
				<tr>
					<td class="td1" align="center">
					<input class="btn"  id="btnMinut..*" type="button" value='-' style="font-weight: bold; "  />
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td class="td2">
					<input class="btn" id="btnUno..*" type="button" value='.' style="float:left;width:1%;"/>
					<input class="txt c1" id="txtUno..*" type="text" style="float:left;width:85%;" />
					</td>
					<td class="td3">
					<input type="button" id="btnProductno..*" value="." style="width:1%;">
					<input class="txt" id="txtProduct..*" type="text" style="width:85%;"  />
					</td>
					<td class="td4">
					<input class="txt" id="txtProductno..*" type="text" style="width:95%;"  />
					</td>
					<td class="td5">
					<input class="txt" id="txtDime..*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td6">
					<input class="txt" id="txtWidth..*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td7">
					<input class="txt" id="txtLengthb..*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td8">
					<input class="txt" id="txtMount..*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td9">
					<input class="txt" id="txtWeight..*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td align="center">
					<input id="chkIssale..*" type="checkbox"/>
					</td>
					<td class="td10">
					<input class="txt" id="txtSource..*" type="text" style="width:95%;"  />
					</td>
					<td class="td11">
					<input class="txt" id="txtNo3..*" type="text" style="width:95%;"  />
					<input class="txt" id="txtNo2..*" type="text" style="display:none;"  />
					</td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
