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
            var q_name = "ina";
            var q_readonly = ['txtWorker','txtWorker2', 'txtNoa'];
            var q_readonlys = [];
            var bbmNum = [['txtTotal', 10, 1, 1]];
            var bbsNum = [['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1], ['txtRadius', 10, 3, 1], ['txtWidth', 10, 2, 1], ['txtDime', 10, 3, 1], ['txtLengthb', 10, 2, 1], ['txtMount', 10, 2, 1], ['txtWeight', 10, 1, 1]];
            var bbmMask = [];
            var bbsMask = [['txtStyle', 'A']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            aPop = new Array(['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'], ['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'], ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'], ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'], ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
          	brwCount2 = 10;
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt('style', '', 0, 0, 0, '');
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            var abbsModi = [];

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbItype", q_getPara('ina.typea'));
                q_cmbParse("cmbTypea", q_getPara('uccc.itype'));
                q_cmbParse("cmbKind", q_getPara('sys.stktype'));
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                /* 若非本會計年度則無法存檔 */
                $('#txtDatea').focusout(function() {
                    if ($(this).val().substr(0, 3) != r_accy) {
                        $('#btnOk').attr('disabled', 'disabled');
                        alert(q_getMsg('lblDatea') + '非本會計年度。');
                    } else {
                        $('#btnOk').removeAttr('disabled');
                    }
                });

                $('#btnRc2st').click(function() {
                    var t_where = "where=^^ kind='" + $('#cmbKind').val() + "' and tggno='" + $('#txtTggno').val() + "' and (storeno ='' OR storeno is null ) ^^";
                    q_gt('rc2', t_where, 0, 0, 0, "", r_accy);
                });

                //變動尺寸欄位
                $('#cmbKind').change(function() {
                    size_change();
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
                }/// end Switch
                b_pop = '';
            }

            var StyleList = '';
            var t_uccArray = new Array;
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'rc2':
                        var rc2 = _q_appendData("rc2", "", true);
                        if (rc2[0] != undefined) {
                            var rc2s = _q_appendData("rc2s", "", true);
                            q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtRadius,txtRc2no,txtMount,txtWeight,txtMemo', rc2s.length, rc2s, 'productno,product,spec,size,dime,width,lengthb,radius,noa,mount,weight,memo', 'txtProductno,txtProduct,');
                            size_change();
                        }
                        break;
                    case 'uccb':
                        var as = _q_appendData("uccb", "", true);

                        if (uccb_readonly) {
                            if (as[0] != undefined) {
                                //已領用的物品不能再變動與刪除
                                $('#btnMinus_' + bbs_id).attr('disabled', 'disabled');
                                $('#btnProductno_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtUno_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtUno_' + bbs_id).css('background', t_background2);
                                $('#txtProductno_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtProductno_' + bbs_id).css('background', t_background2);
                                $('#txtProduct_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtProduct_' + bbs_id).css('background', t_background2);
                                $('#txtSpec_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtSpec_' + bbs_id).css('background', t_background2);
                                $('#textSize1_' + bbs_id).attr('disabled', 'disabled');
                                $('#textSize1_' + bbs_id).css('background', t_background2);
                                $('#textSize2_' + bbs_id).attr('disabled', 'disabled');
                                $('#textSize2_' + bbs_id).css('background', t_background2);
                                $('#textSize3_' + bbs_id).attr('disabled', 'disabled');
                                $('#textSize3_' + bbs_id).css('background', t_background2);
                                $('#textSize4_' + bbs_id).attr('disabled', 'disabled');
                                $('#textSize4_' + bbs_id).css('background', t_background2);
                                $('#txtMount_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtMount_' + bbs_id).css('background', t_background2);
                                $('#txtWeight_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtWeight_' + bbs_id).css('background', t_background2);
                                $('#txtMemo_' + bbs_id).attr('disabled', 'disabled');
                                $('#txtMemo_' + bbs_id).css('background', t_background2);
                            }
                            if ((dec(bbs_id) + 1) < q_bbsCount) {
                                bbs_id = dec(bbs_id) + 1;
                                bbs_readonly(bbs_id);
                            } else {
                                uccb_readonly = false;
                            }

                        } else {
                            if (as[0] != undefined) {
                                alert("批號已存在!!");
                                $('#txtUno_' + b_seq).val('');
                                $('#txtUno_' + b_seq).focus();
                            }
                        }
                        break;
                    case 'style' :
                        var as = _q_appendData("style", "", true);
                        StyleList = new Array();
                        StyleList = as;
                        break;
                    case q_name:
                    	t_uccArray = _q_appendData("ucc", "", true);
                        if (q_cur == 4)
                            q_Seek_gtPost();
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
                    default:
                        if(t_name.substring(0,9)=='checkUno_'){
							var n = t_name.split('_')[1];
							var as = _q_appendData("view_uccb", "", true);
							if(as[0]!=undefined){
								var t_uno = $('#txtUno_' + n).val();
								alert(t_uno + ' 此批號已存在!!\n【'+as[0].action+'】單號：'+as[0].noa);
								$('#txtUno_' + n).focus();
							}
						}else if(t_name.substring(0,14)=='btnOkcheckUno_'){
							var n = parseInt(t_name.split('_')[1]);
							var as = _q_appendData("view_uccb", "", true);
							if(as[0]!=undefined){
								var t_uno = $('#txtUno_' + n).val();
								alert(t_uno + ' 此批號已存在!!\n【'+as[0].action+'】單號：'+as[0].noa);
								Unlock(1);
								return;
							}else{
								btnOk_checkUno(n-1);
							}
						}
                        break;
                }  /// end switch
            }
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}
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
				//檢查批號
				for(var i=0;i<q_bbsCount;i++){
					for(var j=i+1;j<q_bbsCount;j++){
						if($.trim($('#txtUno_'+i).val()).length>0 && $.trim($('#txtUno_'+i).val()) == $.trim($('#txtUno_'+j).val())){
							alert('【'+$.trim($('#txtUno_'+i).val())+'】'+q_getMsg('lblUno_st')+'重覆。\n'+(i+1)+', '+(j+1));
							Unlock(1);
							return;
						}
					}					
				}
				btnOk_checkUno(q_bbsCount-1);
            }
            function btnOk_checkUno(n){
				if(n<0){
					if (q_cur == 1)
						$('#txtWorker').val(r_name);
					else
						$('#txtWorker2').val(r_name);
					sum();
					var t_noa = trim($('#txtNoa').val());
					var t_date = trim($('#txtDatea').val());
					if (t_noa.length == 0 || t_noa == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ina') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(t_noa);
				}else{
					var t_uno = $.trim($('#txtUno_'+n).val());
					var t_noa = $.trim($('#txtNoa').val());
					q_gt('view_uccb', "where=^^uno='"+t_uno+"' and not(accy='"+r_accy+"' and tablea='inas' and noa='"+t_noa+"')^^", 0, 0, 0, 'btnOkcheckUno_'+n);
				}
			}

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('ina_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function getTheory(b_seq) {
                t_Radius = $('#txtRadius_' + b_seq).val();
                t_Width = $('#txtWidth_' + b_seq).val();
                t_Dime = $('#txtDime_' + b_seq).val();
                t_Lengthb = $('#txtLengthb_' + b_seq).val();
                t_Mount = $('#txtMount_' + b_seq).val();
                t_Style = $('#txtStyle_' + b_seq).val();
                t_Productno = $('#txtProductno_'+b_seq).val();
				var theory_setting={
					calc:StyleList,
					ucc:t_uccArray,
					radius:t_Radius,
					width:t_Width,
					dime:t_Dime,
					lengthb:t_Lengthb,
					mount:t_Mount,
					style:t_Style,
					productno:t_Productno
				};
				return theory_st(theory_setting);
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtStyle_' + j).blur(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            ProductAddStyle(b_seq);
                        });
                        /*
                         //判斷是否重複或已存過入庫----------------------------------------
                         $('#txtUno_' + j).change(function () {
                         t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                         q_bodyId($(this).attr('id'));
                         b_seq = t_IdSeq;
                         //判斷是否重複
                         for(var k = 0; k < q_bbsCount; k++) {
                         if(k!=b_seq && $('#txtUno_' +b_seq).val()==$('#txtUno_' +k).val() && !emp($('#txtUno_' +k).val())){
                         alert("批號重複輸入!!");
                         $('#txtUno_' +b_seq).val('');
                         $('#txtUno_' +b_seq).focus();
                         }
                         }
                         //判斷是否已存過入庫
                         var t_where = "where=^^ noa='"+$('#txtUno_' +b_seq).val()+"' ^^";
                         q_gt('uccb', t_where , 0, 0, 0, "", r_accy);
                         });
                         */
                        $('#txtUno_' + j).change(function() {
							var n = $(this).attr('id').replace('txtUno_','');
							var t_uno = $.trim($(this).val());
							var t_noa = $.trim($('#txtNoa').val());
							q_gt('view_uccb', "where=^^uno='"+t_uno+"' and not(accy='"+r_accy+"' and tablea='inas' and noa='"+t_noa+"')^^", 0, 0, 0, 'checkUno_'+n);
                        });

                        //-------------------------------------------
                        //將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
                        $('#textSize1_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtDime_' + b_seq, q_float('textSize1_' + b_seq));
                                //厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtRadius_' + b_seq, q_float('textSize1_' + b_seq));
                                //短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());
                            }
                            q_tr('txtWeight_' + b_seq, getTheory(b_seq));
                        });
                        $('#textSize2_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtWidth_' + b_seq, q_float('textSize2_' + b_seq));
                                //寬度$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtWidth_' + b_seq, q_float('textSize2_' + b_seq));
                                //長徑$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());
                            }
                            q_tr('txtWeight_' + b_seq, getTheory(b_seq));
                        });
                        $('#textSize3_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtLengthb_' + b_seq, q_float('textSize3_' + b_seq));
                                //長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtDime_' + b_seq, q_float('textSize3_' + b_seq));
                                //厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());
                            } else {//鋼筋、胚
                                q_tr('txtLengthb_' + b_seq, q_float('textSize3_' + b_seq));
                            }
                            q_tr('txtWeight_' + b_seq, getTheory(b_seq));
                        });
                        $('#textSize4_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#cmbKind').val().substr(0, 1) == 'A') {
                                q_tr('txtRadius_' + b_seq, q_float('textSize4_' + b_seq));
                                //短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());
                            } else if ($('#cmbKind').val().substr(0, 1) == 'B') {
                                q_tr('txtLengthb_' + b_seq, q_float('textSize4_' + b_seq));
                                //長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());
                            }
                            q_tr('txtWeight_' + b_seq, getTheory(b_seq));
                            sum();
                        });
                        $('#txtMount_' + j).change(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            q_tr('txtWeight_' + b_seq, getTheory(b_seq));
                            sum();
                        });
                        $('#txtPrice_' + j).change(function() {
                            sum();
                        });

                        //-------------------------------------------------------------------------------------
                    }
                }
                _bbsAssign();
                size_change();
                if (q_cur == 2) {
                    //判斷哪些資料不能修改
                    uccb_readonly = true;
                    bbs_readonly(0);
                }
            }

            function btnIns() {
                _btnIns();
                $('#cmbKind').val(q_getPara('vcc.kind'));
                size_change();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
                size_change();
                //判斷哪些資料不能修改
                uccb_readonly = true;
                bbs_readonly(0);
            }

            function btnPrint() {
                q_box('z_inast.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['uno'] && !as['productno'] && !as['product'] && !as['spec']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['date'] = abbm2['date'];

                return true;
            }

            function sum() {
                var t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_weight += dec($('#txtWeight_' + j).val());
                    // 重量合計
                    t_unit = $('#txtUnit_' + j).val();
                    t_mount = (!t_unit || emp(t_unit) || trim(t_unit).toLowerCase() == 'kg' ? $('#txtWeight_' + j).val() : $('#txtMount_' + j).val());
                    // 計價量
                    $('#txtTotal_' + j).val(round($('#txtPrice_' + j).val() * dec(t_mount), 0));
                }// j
                $('#txtTotal').val(round(t_weight, 0));
                if (!emp($('#txtPrice').val()))
                    $('#txtTranmoney').val(round(t_weight * dec($('#txtPrice').val()), 0));
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
                        $('#txtClass_' + b_seq).focus();
                        break;
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                size_change();
            }

            function btnMinus(id) {
                _btnMinus(id);
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
                var t_where = 'where=^^ uno in(' + getBBSWhere('Uno') + ') ^^';
                q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }

            var uccb_readonly = false;
            var bbs_id = '';
            function bbs_readonly(id) {
                bbs_id = id;
                var t_where = "where=^^ noa='" + $('#txtUno_' + bbs_id).val() + "' and gweight>0 ^^";
                q_gt('uccb', t_where, 0, 0, 0, "", r_accy);
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
                        $('#Size').css('width', '222px');
                        $('#textSize1_' + j).val($('#txtDime_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0)
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
                        $('#Size').css('width', '297px');
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
                        $('#Size').css('width', '70px');
                        $('#textSize1_' + j).val(0);
                        $('#txtDime_' + j).val(0)
                        $('#textSize2_' + j).val(0);
                        $('#txtWidth_' + j).val(0);
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0);
                    }
                }
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
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
                width: 98%;
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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
            .txt.c6 {
                width: 90%;
                float: left;
                text-align: center;
            }
            .txt.c7 {
                float: left;
                width: 22%;
            }
            .txt.c8 {
                float: left;
                width: 65px;
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
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1px;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div class="dview" id="dview" style="float: left;  width:32%;"  >
			<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk'> </a></td>
					<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
					<td align="center" style="width:25%"><a id='vewStation'> </a></td>
				</tr>
				<tr>
					<td >
					<input id="chkBrow.*" type="checkbox" style=' '/>
					</td>
					<td align="center" id='datea'>~datea</td>
					<td align="center" id='station'>~station</td>
				</tr>
			</table>
		</div>
		<div class='dbbm' style="width: 68%;float:left">
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr class="tr1">
					<td class='td1'><span> </span><a id="lblItype" class="lbl"> </a></td>
					<td class="td2"><select id="cmbItype" class="txt c1"></select></td>
					<td class='td1'><span> </span><a id="lblType" class="lbl"> </a></td>
					<td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
					<td class='td3'><span> </span><a id="lblDatea" class="lbl"> </a></td>
					<td class="td4">
					<input id="txtDatea" type="text" class="txt c3"/>
					</td>
				</tr>
				<tr class="tr2">
					<td class='td1'><span> </span><a id="lblKind" class="lbl"> </a></td>
					<td class="td2"><select id="cmbKind" class="txt c1"></select></td>
					<td class='td3'><span> </span><a id="lblNoa" class="lbl" > </a></td>
					<td class="td4">
					<input id="txtNoa" type="text" class="txt c1"/>
					</td>
					<td class='td5'><span> </span><a id="lblOrdeno" class="lbl" > </a></td>
					<td class="td6">
					<input id="txtOrdeno" type="text" class="txt c1"/>
					</td>
				</tr>
				<tr class="tr3">
					<td class='td1'><span> </span><a id="lblStation" class="lbl btn" > </a></td>
					<td class="td2" colspan="3">
					<input id="txtStationno" type="text"  class="txt c2"/>
					<input id="txtStation" type="text"  class="txt c3"/>
					</td>
					<td class='td5'>
					<input type="button" id="btnRc2st" class="txt c1 ">
					</td>
				</tr>
				<tr class="tr4">
					<td class='td1'><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
					<td class="td2" colspan="3">
					<input id="txtTggno" type="text"  class="txt c2"/>
					<input id="txtComp" type="text"  class="txt c3"/>
					</td>
					<td class="td5"><span> </span><a id="lblTotal" class="lbl"> </a></td>
					<td class="td6">
					<input id="txtTotal" type="text" class="txt c1 num" />
					</td>
				</tr>
				<tr class="tr5">
					<td class="td1"><span> </span><a id="lblStore" class="lbl btn" > </a></td>
					<td class="td2" colspan="3">
					<input id="txtStoreno"  type="text"  class="txt c2"/>
					<input id="txtStore"  type="text" class="txt c3"/>
					</td>
					<td class='td5'><span> </span><a id="lblWorker" class="lbl"> </a></td>
					<td class="td6">
					<input id="txtWorker" type="text" style="float:left;width:50%;"/>
					<input id="txtWorker2" type="text" style="float:left;width:50%;"/>
					</td>
				</tr>
				<tr class="tr6">
					<td class="td1"><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
					<td class="td2" colspan="3">
					<input id="txtCardealno" type="text" class="txt c2"/>
					<input id="txtCardeal" type="text" class="txt c3"/>
					</td>
					<td class="td3"><span> </span><a id="lblCarno" class="lbl"> </a></td>
					<td class="td4">
					<input id="txtCarno" type="text" class="txt c1" />
					</td>
				</tr>
				<tr class="tr7">
					<td class="td1"><span> </span><a id="lblTrantype" class="lbl"> </a></td>
					<td class="td2"><select id="cmbTrantype" class="txt c1"></select></td>
					<td class="td3"><span> </span><a id="lblPrice" class="lbl"> </a></td>
					<td class="td4">
					<input id="txtPrice" type="text" class="txt c1 num" />
					</td>
					<td class="td5"><span> </span><a id="lblTranmoney" class="lbl"> </a></td>
					<td class="td6">
					<input id="txtTranmoney" type="text" class="txt c1 num" />
					</td>
				</tr>
				<tr class="tr8">
					<td class='td1'><span> </span><a id="lblMemo" class="lbl"> </a></td>
					<td class="td2" colspan='5'>					<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
				</tr>
			</table>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:10%;"><a id="lblUno_st" > </a></td>
					<td align="center" style="width:10%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
					<td align="center" style="width:12%;"><a id='lblProduct_st'> </a></td>
					<td align="center" id='Size'><a id='lblSize_help'> </a>
					<BR>
					<a id='lblSize_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblUnit_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblWeight_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:6%;"><a id='lblTotal_s'> </a></td>
					<td align="center"><a id='lblMemo_st'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td >
					<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
					</td>
					<td >
					<input class="txt c1" id="txtUno.*" type="text" />
					</td>
					<td >
					<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;float:left;width:1%;" />
					<input  id="txtProductno.*" type="text" style="width:80%;" />
					<input  id="txtClass.*" type="text" style="width: 80%;" />
					</td>
					<td >
					<input id="txtStyle.*" type="text" class="txt c6" />
					</td>
					<td >
					<input class="txt c1" id="txtProduct.*" type="text" />
					</td>
					<td>
					<input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/>
					<div id="x1.*" style="float: left">
						x
					</div>
					<input class="txt num c8" id="textSize2.*" type="text" disabled="disabled"/>
					<div id="x2.*" style="float: left">
						x
					</div>
					<input class="txt num c8" id="textSize3.*" type="text" disabled="disabled"/>
					<div id="x3.*" style="float: left">
						x
					</div>
					<input class="txt num c8" id="textSize4.*" type="text" disabled="disabled"/>
					<!--上為虛擬下為實際-->
					<input id="txtRadius.*" type="hidden"/>
					<input  id="txtWidth.*" type="hidden"/>
					<input  id="txtDime.*" type="hidden"/>
					<input id="txtLengthb.*" type="hidden"/>
					<input class="txt c1" id="txtSpec.*" type="text"/>
					</td>
					<td >
					<input class="txt c1" id="txtUnit.*" type="text"  />
					</td>
					<td >
					<input class="txt num c1" id="txtMount.*" type="text"  />
					</td>
					<td >
					<input class="txt num c1" id="txtWeight.*" type="text"  />
					</td>
					<td >
					<input class="txt num c1" id="txtPrice.*" type="text" />
					</td>
					<td >
					<input class="txt num c1" id="txtTotal.*" type="text" />
					</td>
					<td >
					<input class="txt c1" id="txtMemo.*" type="text" />
					<input class="txt c1" id="txtSize.*" type="text" />
					<input id="txtNoq.*" type="hidden" />
					<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
