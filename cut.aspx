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

            q_tables = 's';
            var q_name = "cut";
            var q_readonly = ['txtNoa', 'txtProductno', 'txtProduct', 'txtSpec', 'txtDime', 'txtWidth', 'txtLengthb', 'txtRadius', 'txtOweight', 'txtEweight', 'txtTotalout', 'txtTheyout', 'txtWorker'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 15;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'], ['txtUno', 'lblUno', 'view_uccc', 'uno,productno,product,spec,dime,width,lengthb,radius,weight,eweight', 'txtUno,txtProductno,txtProduct,txtSpec,txtDime,txtWidth,txtLengthb,txtRadius,txtOweight,txtEweight', 'uccc_seek_b.aspx', '95%', '60%'], ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'], ['txtCustno_', 'btnCust_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx'], ['txtMechno', 'lblMech', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']);
            q_desc = 1;
            brwCount2 = 12;
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
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('cut.typea'));
                q_cmbParse("cmbType2", q_getPara('cut.type2'));
                q_cmbParse("cmbKind", q_getPara('sys.stktype'));
                //q_cmbParse("cmbKind", q_getPara('cut.kind'));

                //重新計算理論重
                $('#cmbTypea').change(function() {
                    for (var j = 0; j < q_bbsCount; j++) {
                        getTheory(j);
                    }
                    cut_save_db();
                });
                $('#cmbType2').change(function() {
                    for (var j = 0; j < q_bbsCount; j++) {
                        getTheory(j);
                    }
                    cut_save_db();
                });
                $('#txtGweight').change(function() {
                    for (var j = 0; j < q_bbsCount; j++) {
                        getTheory(j);
                    }
                    cut_save_db();
                });
                //變動尺寸欄位
                $('#cmbKind').change(function() {
                    size_change();
                });
                $('#btnOrdesImport').click(function() {
                    if (q_cur == 1 || q_cur == 2) {
                        var t_bdime = dec($('#txtBdime').val()) - 0.5;
                        var t_edime = dec($('#txtEdime').val());
                        var t_width = dec($('#txtWidth').val()) + 11;
                        var t_productno = trim($('#txtProductno').val());
                        var t_custno = trim($('#txtCustno').val());
                        t_edime = (t_edime == 0 ? 999 : t_edime);
                        var t_where = ' 1=1 ';
                        t_where += q_sqlPara2('dime', t_bdime, t_edime) + q_sqlPara2('width', 0, t_width) + q_sqlPara2('productno', t_productno);
                        if (!emp(t_custno))
                            t_where += q_sqlPara2('custno', t_custno);
                        q_box("ordests_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrde'));
                    }
                });
            }

            var w_ret = new Array;
            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case 'ordes':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                return;
                            for (var i = 0; i < q_bbsCount; i++) {
                                $('#btnMinus_' + i).click();
                            }
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtCust,txtStyle,txtRadius,txtWidth,txtDime,txtLengthb,txtMount,txtWeight,txtMemo,txtProductno,txtSpec,txtOrdeno,txtNo2,txtClass', b_ret.length, b_ret, 'custno,comp,style,radius,width,dime,lengthb,mount,weight,memo,productno,spec,noa,no2,class', '');
                            sum();
                            for (var j = 0; j < q_bbsCount; j++) {
                                getTheory(j);
                            }
                            //產生編號
                            var t_noa = trim($('#txtUno').val());
                            if (t_noa.length > 0) {
                                var t_where = "where=^^ left(uno," + t_noa.length + ")='" + t_noa + "' ^^";
                                w_ret = ret;
                                q_gt('view_uccb', t_where, 0, 0, 0, "view_uccb", r_accy);
                            }
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function bbsClear() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#btnMinus_' + i).click();
                }
            }

            var StyleList = '';
            var unoArray = new Array;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'ordes':
                        ordes = _q_appendData("ordes", "", true);
                        if (ordes[0] == undefined)
                            alert("訂單不存在");
                        break;
                    case 'style' :
                        var as = _q_appendData("style", "", true);
                        StyleList = new Array();
                        StyleList = as;
                        break;
                    case 'uccb':
                        i_uno = 1;
                        uccb = _q_appendData("uccb", "", true);
                        //取得餘料編號
                        if (uccb[uccb.length - 1] != undefined) {
                            if (uccb[uccb.length - 1].noa.indexOf('-') > -1)//取-之後的數字
                            {
                                i_uno = parseInt(uccb[uccb.length - 1].noa.slice(uccb[uccb.length - 1].noa.indexOf('-') + 1).toString(10)) + 1;
                            }
                        }
                        //判斷已有領用
                        if (uccb[0] != undefined) {
                            for (var i = 0; i < uccb.length; i++) {
                                if ($('#txtUno').val() == uccb[i].noa) {
                                    uccb_gweight = uccb[i].gweight;
                                }
                            }
                        }
                        break;
                    case 'deleUccy':
                        var as = _q_appendData("uccy", "", true);
                        var err_str = '';
                        if (as[0] != undefined) {
                            for (var i = 0; i < as.length; i++) {
                                if (dec(as[i].gweight) > 0) {
                                    err_str += as[i].uno + '已領料，不能刪除!!\n';
                                }
                            }
                            if (trim(err_str).length > 0) {
                                alert(err_str);
                                return;
                            } else {
                                _btnDele();
                            }
                        } else {
                            _btnDele();
                        }
                        break;
                    case q_name:
                        if (q_cur == 1)
                            cuts = _q_appendData("cut", "", true);
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    case 'view_uccb':
                        var as = _q_appendData("view_uccb", "", true);
                        for (var i = 0; i < as.length; i++) {
                            unoArray.push(as[i].uno);
                        }
                        for (var i = 0; i < w_ret.length; i++) {
                            setNewBno(unoArray, w_ret[i]);
                        }
                        break;
                    default:
                        if (t_name.substring(0, 9) == 'checkUno_') {
                            var n = t_name.split('_')[1];
                            var as = _q_appendData("view_uccb", "", true);
                            if (as[0] != undefined) {
                                var t_uno = $('#txtBno_' + n).val();
                                alert(t_uno + ' 此批號已存在!!\n【' + as[0].action + '】單號：' + as[0].noa);
                                $('#txtUno_' + n).focus();
                            }
                        } else if (t_name.substring(0, 14) == 'btnOkcheckUno_') {
                            var n = parseInt(t_name.split('_')[1]);
                            var as = _q_appendData("view_uccb", "", true);
                            if (as[0] != undefined) {
                                var t_uno = $('#txtBno_' + n).val();
                                alert(t_uno + ' 此批號已存在!!\n【' + as[0].action + '】單號：' + as[0].noa);
                                Unlock(1);
                                return;
                            } else {
                                btnOk_checkUno(n - 1);
                            }
                        }
                        break;
                }  /// end switch
            }

            function setNewBno(w_unoArray, idno, IndexNum, IndexEng) {
                var newIndexNum = (dec(IndexNum) > 0 ? dec(IndexNum) + 1 : 1);
                var newIndexEng = (dec(IndexEng) > 0 ? dec(IndexEng) : 65);
                if (newIndexNum > 9) {
                    newIndexNum = 1;
                    newIndexEng = dec(IndexEng) + 1;
                }
                var newBno = trim($('#txtUno').val()) + newIndexNum + String.fromCharCode(newIndexEng);
                if (w_unoArray.indexOf(newBno) == -1) {
                    $('#txtBno_' + idno).val(newBno);
                    unoArray.push(newBno);
                } else {
                    setNewBno(unoArray, idno, newIndexNum, newIndexEng);
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var s1 = xmlString.split(';');
                Unlock(1);
            }

            var i_uno = 1;
            //餘料編號初始值
            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                //日期檢查
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtDatea').val().substring(0, 3) != r_accy) {
                    alert('年度異常錯誤，請切換到【' + $('#txtDatea').val().substring(0, 3) + '】年度再作業。');
                    Unlock(1);
                    return;
                }

                //參考cut_save
                if (emp($('#txtUno').val()) && dec($('#txtGweight').val()) > 0) {
                    alert("批號不可為空白");
                    Unlock(1);
                    return;
                }
                if (dec($('#txtTheyout').val()) > dec($('#txtGweight').val())) {
                    alert("產出實際重 > 領料重");
                    Unlock(1);
                    return;
                }
                if (dec($('#txtTheyout').val()) > 0 && dec($('#txtGweight').val()) > 0 && ((Math.abs(dec($('#txtTheyout').val()) - dec($('#txtGweight').val()))) / dec($('#txtGweight').val())) > 0.05) {
                    alert("產出實際重、領料重，差異過大");
                    Unlock(1);
                    return;
                }
                if (emp($('#txtTggno').val()) && $('#cmbTypea').find("option:selected").text().indexOf('委') > -1) {
                    alert("委外廠商不可為空白");
                    Unlock(1);
                    return;
                } else {
                    if (emp($('#txtMechno').val()) && !($('#cmbTypea').find("option:selected").text().indexOf('委') > -1 || !emp($('#txtTggno').val()))) {
                        alert("機台不可為空白");
                        Unlock(1);
                        return;
                    }
                }
                if (q_cur > 0 && dec($('#txtPrice').val()) > 0)
                    $('#txtTranmoney').val(dec($('#txtPrice').val()) * dec($('#txtTheyout').val()));
                if ($('#cmbTypea').find("option:selected").text().indexOf('條') > -1) {
                    if (cuts[0] != undefined && cuts[0].typea == $('#cmbTypea').val() && dec($('#txtTheyout').val()) == 0) {
                        alert("不可重覆分條");
                        Unlock(1);
                        return;
                    }
                }
                if (dec($('#txtTheyout').val()) != 0 && dec($('#txtGweight').val()) == 0) {
                    alert("領料重為零");
                    Unlock(1);
                    return;
                }
                if (dec($('#txtTheyout').val()) != 0 && dec($('#txtGmount').val()) == 0) {
                    alert("領料數為零");
                    Unlock(1);
                    return;
                }
                if ($('#cmbTypea').find("option:selected").text().indexOf('委') == -1) {
                    for (var j = 0; j < q_bbsCount; j++) {
                        if (emp($('#txtBno_' + j).val()) && $('#txtWaste_' + j).val() >= 'X') {
                            $('#txtBno_' + j).val($('#txtWaste_' + j).val() + '001');
                        }
                        if (emp($('#txtStyle_' + j).val()) && !emp($('#txtBno_' + j).val())) {
                            alert("無型別,請檢查");
                            Unlock(1);
                            return;
                        }
                        if ($('#txtStyle_' + j).val() == 'c' && trim($('#txtBno_' + j).val()).length > 12) {
                            alert("批號異常，清空批號再重新產生，並確認是否已有領料");
                            Unlock(1);
                            return;
                        }
                    }
                }

                for (var j = 0; j < q_bbsCount; j++) {
                    if (!emp($('#txtOrdeno_' + j).val()) && emp($('#txtNo2_' + j).val())) {
                        alert("訂序為空");
                        Unlock(1);
                        return;
                    }
                    if (dec($('#txtWeight_' + j).val()) > 0 && emp($('#txtDatea').val())) {
                        alert("表身有重量,日期為空");
                        Unlock(1);
                        return;
                    }
                    if (dec($('#txtWeight_' + j).val()) > 0 && emp($('#txtWidth_' + j).val())) {
                        alert("表身重量或寬度小於零");
                        Unlock(1);
                        return;
                    }
                    if ($('#cmbTypea').find("option:selected").text().indexOf('委') > -1 && $('#txtWaste_' + j).val() >= 'X') {
                        $('#txtBno_' + j).val($('#txtWaste_' + j).val() + '001');
                    }
                    if (dec($('#txtDime_' + j).val()) == dec($('#txtWidth_' + j).val()) && dec($('#txtWidth_' + j).val()) > 0) {
                        alert("表身尺寸異常");
                        Unlock(1);
                        return;
                    }
                }
                //判斷已領用
                if (uccb_gweight > 0)//dec($('#txtGweight').val())>uccb_gweight
                {
                    alert("已有領用");
                    return;
                }

                //------------參考cut_save

                //--------------自動產生餘料編號
                for (var j = 0; j < q_bbsCount; j++) {
                    var tmp_uno = trim($('#txtUno').val());
                    if (!($('#txtUno').val().indexOf('-') > -1))
                        tmp_uno = tmp_uno + '-';

                    if (!emp($('#txtWeight_' + j).val()) && emp($('#txtBno_' + j).val()))//有入庫重自動產生餘料編號
                    {
                        $('#txtBno_' + j).val(tmp_uno + i_uno.toString(16).toUpperCase());
                        i_uno++;
                    }
                }
                //------------------------------------------
                /*//判斷餘料編號是否重複
                for (var i = 0; i < q_bbsCount; i++) {
                for (var j = 0; j < q_bbsCount; j++) {
                if (i != j && !emp($('#txtBno_' + i).val()) && !emp($('#txtBno_' + j).val()) && $('#txtBno_' + i).val() == $('#txtBno_' + j).val()) {
                alert("表身餘料編號重複");
                return;
                }
                }
                }*/
                //----------------------------
                //檢查批號
                for (var i = 0; i < q_bbsCount; i++) {
                    for (var j = i + 1; j < q_bbsCount; j++) {
                        if ($.trim($('#txtBno_' + i).val()).length > 0 && $.trim($('#txtBno_' + i).val()) == $.trim($('#txtBno_' + j).val())) {
                            alert('【' + $.trim($('#txtBno_' + i).val()) + '】' + q_getMsg('lblBno') + '重覆。\n' + (i + 1) + ', ' + (j + 1));
                            Unlock(1);
                            return;
                        }
                    }
                }
                btnOk_checkUno(q_bbsCount - 1);
            }

            function btnOk_checkUno(n) {
                if (n < 0) {
                    if (q_cur == 1)
                        $('#txtWorker').val(r_name);
                    else
                        $('#txtWorker2').val(r_name);
                    sum();
                    var t_noa = trim($('#txtNoa').val());
                    var t_date = trim($('#txtDatea').val());
                    if (t_noa.length == 0 || t_noa == "AUTO")
                        q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cut') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                    else
                        wrServer(t_noa);
                } else {
                    if ($('#txtWaste_' + n).val().length == 0) {
                        var t_uno = $.trim($('#txtBno_' + n).val());
                        var t_noa = $.trim($('#txtNoa').val());
                        q_gt('view_uccb', "where=^^uno='" + t_uno + "' and not(accy='" + r_accy + "' and tablea='cuts' and noa='" + t_noa + "')^^", 0, 0, 0, 'btnOkcheckUno_' + n);
                    } else {
                        btnOk_checkUno(n - 1);
                    }
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('cut_s.aspx', q_name + '_s', "500px", "530px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtTheory_'+j).change(function(e){sum();});
                    	$('#txtWeight_'+j).change(function(e){sum();});
                        $('#txtBno_' + j).change(function() {
                            var n = $(this).attr('id').replace('txtBno_', '');
                            var t_uno = $.trim($(this).val());
                            var t_noa = $.trim($('#txtNoa').val());
                            if ($('#txtWaste_' + n).val().length == 0) {
                                q_gt('view_uccb', "where=^^uno='" + t_uno + "' and not(accy='" + r_accy + "' and tablea='cuts' and noa='" + t_noa + "')^^", 0, 0, 0, 'checkUno_' + n);
                            }
                        });
                        //將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
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
                        //計算理論重
                        $('#txtRadius_' + j).change(function() {
                            sum();
                        });
                        $('#txtDivide_' + j).change(function() {
                            sum();
                        });
                        $('#txtWidth_' + j).change(function() {
                            sum();
                        });
                        $('#txtMount_' + j).change(function() {
                            sum();
                        });
                        $('#txtDime_' + j).change(function() {
                            sum();
                        });
                        $('#txtLengthb_' + j).change(function() {
                            sum();
                        });
                        //判斷訂單是否存在
                        $('#txtOrdeno_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if (!emp($('#txtOrdeno_' + b_seq)) && !emp($('#txtOrdeno_' + b_seq))) {
                                var t_where = "where=^^ noa = '" + $('#txtOrdeno_' + b_seq).val() + "' and no2 = '" + $('#txtNo2_' + b_seq).val() + "' ^^";
                                q_gt('ordes', t_where, 0, 0, 0, "", r_accy);
                            }
                        });
                        $('#txtNo2_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if (!emp($('#txtOrdeno_' + b_seq)) && !emp($('#txtOrdeno_' + b_seq))) {
                                var t_where = "where=^^ noa = '" + $('#txtOrdeno_' + b_seq).val() + "' and no2 = '" + $('#txtNo2_' + b_seq).val() + "' ^^";
                                q_gt('ordes', t_where, 0, 0, 0, "", r_accy);
                            }
                        });
                    }
                }
                _bbsAssign();
                size_change();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
                size_change();
                //取得餘料編號
                t_where = "where=^^ noa like '%" + $('#txtUno').val() + "%' ^^";
                q_gt('uccb', t_where, 0, 0, 0, "", r_accy);
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['bno'] && !as['productno'] && !as['product'] && !as['spec'] && parseFloat(as['mount'].length==0?"0":as['mount'])==0) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['datea'] = abbm2['datea'];
                return true;
            }

            function sum() {
                var t_theyout = 0,t_totalout=0;
                var t_weights,t_theorys;
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
                	t_weights = q_float('txtWeight_'+j);
                	t_theorys = q_float('txtTheory_'+j);
                	t_theyout = t_theyout.add(t_weights);
                	t_totalout = t_totalout.add(t_theorys);  
                }
                $('#txtTheyout').val(FormatNumber(t_theyout));
                $('#txtTotalout').val(FormatNumber(t_totalout));
            }

            function refresh(recno) {
                _refresh(recno);
                size_change();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (q_cur == 2) {
                    $('#txtUno').attr('readonly', 'readonly').css('background-color', t_background2);
                }
                size_change();
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                size_change();
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
                var t_where = 'where=^^ uno in(' + getBBSWhere('Bno') + ') ^^';
                q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }

            function getTheory(b_seq) {
                t_Radius = dec($('#txtRadius_' + b_seq).val());
                t_Width = dec($('#txtWidth_' + b_seq).val());
                t_Dime = dec($('#txtDime_' + b_seq).val());
                t_Lengthb = dec($('#txtLengthb_' + b_seq).val());
                t_Mount = dec($('#txtMount_' + b_seq).val());
                t_Style = $('#txtStyle_' + b_seq).val();
                t_spec = $('#txtSpec_' + b_seq).val();
                t_Divide = dec($('#txtDivide_' + b_seq).val());
                var zz ={ radius: t_Radius
                	,width:t_Width
                	,dime:t_Dime 
                	,lengthb:t_Lengthb
                	,mount:t_Mount
                	,style:t_Style
                	,stype:t_spec
                	//,round
                	,calc:StyleList
                	//,ucc
                };
                if (dec(t_Divide) == 0)
                    t_Divide = 1;
                if ($('#cmbKind').val().substr(1, 1) == '4') {//鋼胚
                    q_tr('txtTheory_' + b_seq, round(t_Mount * theory_bi(t_spec, $('#txtSpec_' + b_seq).val(), t_Dime, t_Width, t_Lengthb), 0));
                } else {
                    //q_tr('txtTheory_' + b_seq, theory_st(StyleList, t_Radius, t_Width, t_Dime, t_Lengthb, t_Mount, t_Style) / t_Divide);
                    q_tr('txtTheory_' + b_seq, theory_st(zz) / t_Divide);
                }
                if (dec($('#txtRadius_' + b_seq).val()) != 0) {
                    $('#txtWeight_' + b_seq).val($('#txtTheory_' + b_seq).val());
                }
            }

            function distinct(arr1) {
                for (var i = 0; i < arr1.length; i++) {
                    if ((arr1.indexOf(arr1[i]) != arr1.lastIndexOf(arr1[i])) || arr1[i] == '') {
                        arr1.splice(i, 1);
                        i--;
                    }
                }
                return arr1;
            }

            function getBBSWhere(objname) {
                var tempArray = new Array();
                for (var j = 0; j < q_bbsCount; j++) {
                    tempArray.push($('#txt' + objname + '_' + j).val());
                }
                var TmpStr = distinct(tempArray).sort();
                TmpStr = TmpStr.toString().replace(/,/g, "','").replace(/^/, "'").replace(/$/, "'");
                return TmpStr;
            }

            var ordes = [];
            //ordes資料內容
            var uccb = [];
            //uccb資料內容
            var uccb_gweight = 0;
            var cuts = [];
            //cut資料內容
            function cut_save_db() {
                //取得品名的密度-計算理論重
                var t_where = "where=^^ noa = '" + $('#txtProductno').val() + "' ^^";
                q_gt('ucc', t_where, 0, 0, 0, "", r_accy);
                //取得餘料編號
                t_where = "where=^^ noa like '%" + $('#txtUno').val() + "%' ^^";
                q_gt('uccb', t_where, 0, 0, 0, "", r_accy);
                if (q_cur == 1) {
                    //取得是否重複分條
                    t_where = "where=^^ uno = '" + $('#txtUno').val() + "' ^^";
                    q_gt('cut', t_where, 0, 0, 0, "", r_accy);
                } else {
                    cuts = [];
                }
            }
            function size_change() {
                if (q_cur == 1 || q_cur == 2) {
                    $('input[id*="textSize"]').removeAttr('disabled');
                } else {
                    $('input[id*="textSize"]').attr('disabled', 'disabled');
                }
                if ($('#cmbKind').val().substring(0, 1) == 'A') {
                    $('#lblSize_help').text(q_getPara('sys.lblSizea'));
                    $('#Size').css('width', '240px');
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).show();
                        $('#textSize2_' + j).show();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).hide();
                        $('#x1_' + j).show();
                        $('#x2_' + j).show();
                        $('#x3_' + j).hide();
                        //$('#txtSpec_' + j).css('width', '220px');
                        $('#textSize1_' + j).val($('#txtDime_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0);
                    }
                } else if ($('#cmbKind').val().substring(0, 1) == 'B') {
                    $('#lblSize_help').text(q_getPara('sys.lblSizeb'));
                    $('#Size').css('width', '340px');
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).show();
                        $('#textSize2_' + j).show();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).show();
                        $('#x1_' + j).show();
                        $('#x2_' + j).show();
                        $('#x3_' + j).show();
                       // $('#txtSpec_' + j).css('width', '320px');
                        $('#textSize1_' + j).val($('#txtRadius_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtDime_' + j).val());
                        $('#textSize4_' + j).val($('#txtLengthb_' + j).val());
                    }
                } else {//鋼筋和鋼胚
                    $('#lblSize_help').text(q_getPara('sys.lblSizec'));
                    $('#Size').css('width', '200px');
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).hide();
                        $('#textSize2_' + j).hide();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).hide();
                        $('#x1_' + j).hide();
                        $('#x2_' + j).hide();
                        $('#x3_' + j).hide();
                        //$('#txtSpec_' + j).css('width', '180px');
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
                width: 2000px;
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
                width: 1600px;
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
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewUno'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewProduct'></a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='uno'>~uno</td>
						<td align="center" id='productno product,5'>~productno ~product,5</td>
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
						<td><span> </span><a id="lblDatea" class="lbl" ></a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td>
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblType"class="lbl" ></a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
						<td><span> </span><a id="lblKind" class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMech" class="lbl btn" ></a></td>
						<td>
						<input id="txtMechno" type="text" style="float:left;width:50%;" />
						<input id="txtMech"  type="text" style="float:left;width:50%;"/>
						</td>
						<td><span> </span><a id="lblType2"class="lbl" ></a></td>
						<td><select id="cmbType2" class="txt c1"></select></td>
						<td><span> </span><a id="lblCust" class="lbl btn" ></a></td>
						<td colspan="3">
						<input id="txtCustno" type="text" style="float:left;width:30%;"/>
						<input id="txtCust" type="text" style="float:left;width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblUno" class="lbl btn"></a></td>
						<td>
						<input id="txtUno" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblProduct" class="lbl"></a></td>
						<td>
						<input id="txtProductno" type="text" style="float:left;width:40%;"/>
						<input id="txtProduct" type="text" style="float:left;width:60%;"/>
						</td>
						<td><span> </span><a id="lblSpec" class="lbl"></a></td>
						<td>
						<input id="txtSpec" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCuano" class="lbl"></a></td>
						<td>
						<input id="txtCuano" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDime" class="lbl"></a></td>
						<td>
						<input id="txtDime" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id="lblWidth" class="lbl" ></a></td>
						<td>
						<input id="txtWidth" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id="lblLengthb" class="lbl"></a></td>
						<td>
						<input id="txtLengthb" type="text" class="txt num c1"  />
						</td>
						<td><span> </span><a id="lblRadius" class="lbl"></a></td>
						<td>
						<input id="txtRadius" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOweight" class="lbl" ></a></td>
						<td>
						<input id="txtOweight" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id="lblEweight" class="lbl"></a></td>
						<td>
						<input id="txtEweight" type="text" class="txt num c1" />
						</td>
						<td></td>
						<td>
						<input id="btnOrdesImport" type="button"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblGweight" class="lbl" ></a></td>
						<td>
						<input id="txtGweight" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id="lblGtime" class="lbl"></a></td>
						<td>
						<input id="txtGtime" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblGmount" class="lbl"></a></td>
						<td>
						<input id="txtGmount" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMon" class="lbl"></a></td>
						<td>
						<input id="txtMon" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblTgg" class="lbl btn"></a></td>
						<td>
						<input id="txtTggno" type="text" class="txt c1"/>
						</td>
						<td colspan="2">
						<input id="txtTgg" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblLoss" class="lbl"></a></td>
						<td>
						<input id="txtLoss" type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblTheyout" class="lbl" ></a></td>
						<td>
						<input id="txtTheyout" type="text" class="txt num c1" />
						</td>
						<td><span> </span><a id="lblTotalout" class="lbl" ></a></td>
						<td>
						<input id="txtTotalout" type="text"class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" ></a></td>
						<td colspan='7'>						<textarea id="txtMemo" rows="5" cols="10" style="width: 98%; height: 50px;"></textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCardeal" class="lbl btn"></a></td>
						<td colspan="3">
						<input id="txtCardealno" type="text" style="float:left;width:30%;"/>
						<input id="txtCardeal" type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblCarno"  class="lbl"></a></td>
						<td>
						<input id="txtCarno" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblTranmoney" class="lbl" ></a></td>
						<td>
						<input id="txtTranmoney" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno" class="lbl"></a></td>
						<td>
						<input id="txtOrdeno" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblPrice" class="lbl" ></a></td>
						<td>
						<input id="txtPrice" type="text" class="txt num c1" />
						</td>
						<td></td>
						<td></td>
						<td><span> </span><a id="lblWorker" class="lbl" ></a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
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
					<td align="center" style="width:20px;"> </td>
					<td style="width:110px;" align="center"><a id='lblCustno'></a></td>
					<td style="width:80px;" align="center"><a id='lblComps'></a></td>
					<td style="width:50px;" align="center"><a id='lblStyle'></a></td>
					<td align="center" style="width:340px;" id='Size'><a id='lblSize_help'> </a></td>
					<td style="width:80px;" align="center"><a id='lblMounts'></a></td>
					<td style="width:20px;" align="center"><a id='lblDivide'></a></td>
					<td style="width:80px;" align="center"><a id='lblTheory'></a></td>
					<td style="width:80px;" align="center"><a id='lblHweight'></a></td>
					<td style="width:80px;" align="center"><a id='lblWeight'></a></td>
					<td style="width:50px;" align="center"><a id='lblWaste'></a></td>
					<td style="width:150px;" align="center"><a id='lblBno'></a></td>
					<td style="width:50px;" align="center"><a id='lblStoreno'></a></td>
					<td style="width:150px;" align="center"><a id='lblMemos'></a></td>
					<td style="width:50px;" align="center" ><a id='lbltime'></a></td>
					<td style="width:50px;" align="center" ><a id='lblProductno'></a></td>
					<td style="width:50px;" align="center" ><a id='lblSpecs'></a></td>
					<td style="width:50px;" align="center"><a id='lblWprice'></a></td>
					<td style="width:100px;" align="center"><a id='lblSize'></a></td>
					<td style="width:80px;" align="center"><a id='lblMweight'></a></td>
					<td style="width:120px;" align="center"><a id='lblOrdenos'></a></td>
					<td style="width:30px;" align="center" ><a id='lblNo2'></a></td>
					<td style="width:50px;" align="center" ><a id='lblSpecial'></a></td>
					<td style="width:50px;" align="center" ><a id='lblCname'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input id="btnCust.*" type="button" value="." style="width: 20px; float:left;"/>
					<input id="txtCustno.*" type="text" style="width: 70px; float:left;"/>
					</td>
					<td>
					<input id="txtCust.*" type="text" style="width:95%;"/>
					</td>
					<td>
					<input style="width:95%;" id="txtStyle.*" type="text" />
					</td>
					<td>
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
					</td>
					<td>
					<input class="txt num c1" id="txtMount.*" type="text" />
					</td>
					<td>
					<input class="txt num c1" id="txtDivide.*" type="text" />
					</td>
					<td>
					<input class="txt num c1" id="txtTheory.*" type="text" />
					</td>
					<td>
					<input class="txt num c1" id="txtHweight.*" type="text" />
					</td>
					<td>
					<input class="txt num c1" id="txtWeight.*" type="text"  />
					</td>
					<td>
					<input class="txt c1" id="txtWaste.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtBno.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtStoreno.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtMemo.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtTime.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtProductno.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtSpec.*" type="text" />
					</td>
					<td>
					<input class="txt num c1" id="txtWprice.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtSize.*" type="text" />
					</td>
					<td>
					<input class="txt num c1" id="txtMweight.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtOrdeno.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtNo2.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtSpecial.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtCname.*" type="text" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
