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
		    var q_name = "umm";
		    var q_readonly = ['txtNoa', 'txtWorker', 'txtCno', 'txtAcomp','txtSale','txtTotal','txtPaysale','txtUnpay','txtOpay','textOpay'];
		    var q_readonlys = ['txtVccno', 'txtUnpay', 'txtUnpayorg', 'txtAcc2', 'txtPart2'];
		    var bbmNum = new Array(['txtSale', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtOpay', 10, 0, 1], ['txtUnopay', 10, 0, 1], ['textOpay', 10, 0, 1]);
		    var bbsNum = [['txtMoney', 10, 0, 1], ['txtChgs', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUpay', 10, 0, 1], ['txtUnpayorg', 10, 0, 1]];
		    var bbmMask = [];
		    var bbsMask = [];

		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'Datea';
		    aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
            ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
             ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2,acc7', 'txtAcc1_,txtAcc2_,txtMemo_,txtMoney_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
             ['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'],
             ['txtUmmaccno_', '', 'ummacc', 'noa,typea', 'txtUmmaccno_,txtTypea_', 'ummacc_b.aspx'],
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

		        if (r_rank < 7)
		            q_readonly[q_readonly.length] = 'txtAccno';

		        bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
		        q_mask(bbmMask);
		        bbsMask = [['txtIndate', r_picd], ['txtMon', r_picm]];

		        function umm_trd() {
		            var t_custno = "'" + $.trim($('#txtCustno').val()) + "'";
		            t_where = "where=^^ custno=" + t_custno + " and unpay!=0 ";
		            t_where1 = " where[1]=^^ noa!='" + $('#txtNoa').val() + "'";

		            var j = 0, s2 = '', s1 = '';
		            for (var i = 0; i < q_bbsCount; i++) {
		                if ($.trim($('#txtVccno_' + i).val()).length > 0) {
		                    s2 = s2 + (j == 0 ? "" : " or ") + " noa='" + $('#txtVccno_' + i).val() + "'";
		                    s1 = s1 + (j == 0 ? "" : " or ") + " vccno='" + $('#txtVccno_' + i).val() + "'";
		                    j++;
		                }
		            }

		            t_where = t_where + (s2.length > 0 ? " or (" + s2 + ")" : '') + "^^";
		            t_where1 = t_where1 + (s1.length > 0 ? " or (" + s2 + ")" : '') + "^^";
		            q_gt('umm_trd', t_where + t_where1, 0, 0, 0, "", r_accy);
		        }

		        $('#btnAccc').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
		        });

		        $('#txtCustno').change(function () { getOpay(); });

		        $('#txtOpay').change(function () { sum(); });
		        $('#txtUnopay').change(function () { sum(); });
		        
		         $('#btnBank').click(function () {
		             q_box('bank.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "800px", "600px", "銀行主檔");

		        });
		        
		        //1003將請款單匯入與自動沖帳分開
		         /*$('#btnAuto').click(function (e) {
		            t_Saving = true;
		            umm_trd();

		        });*/
		        
		         $('#btnAuto').click(function (e) {
		         		t_Saving = true;
		        		/// 自動沖帳
		               //$('#txtOpay').val(0);
		               //$('#txtUnopay').val(0);
		               for (var i = 0; i < q_bbsCount; i++) {
		               		$('#txtPaysale_'+i).val(0);//歸零
		               		$('#txtUnpay_'+i).val($('#txtUnpayorg_'+i).val());//歸零
		               }
		               
		               var t_money = 0+q_float('txtUnopay');
		               for (var i = 0; i < q_bbsCount; i++) {
		               		if($('#txtAcc1_'+i).val().indexOf('2121') == 0 || $('#txtAcc1_'+i).val().indexOf('7149') == 0 || $('#txtAcc1_'+i).val().indexOf('7044') == 0)
		               			t_money -= q_float('txtMoney_' + i);
		               		else
		               			t_money += q_float('txtMoney_' + i);
		               			
		               t_money+=q_float('txtChgs_' + i);
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
		        });
				//0926改為開啟視窗
		        $('#btnVcc').click(function (e) {
		                //umm_trd();
		                if(!emp($('#txtCustno').val()))
		                {
		                	 var t_custno = "'" + $.trim($('#txtCustno').val()) + "'";
				            t_where = "custno=" + t_custno + " and unpay!=0 ";
				            t_where1 = " where[1]=^^ noa!='" + $('#txtNoa').val() + "'";
				            t_where2 = " where[2]=^^ left(a.datea,6)='" + $('#txtDatea').val().substr(0,6) + "' ^^";
		            		t_where3 = " where[3]=^^ c.noa='" + $('#txtCustno').val() + "' ^^";
				            
				            if(!emp($('#txtCustno2').val()))
				            {
					            var t_custno2=($('#txtCustno2').val()).split(","); 
					            for (var i = 0; i < t_custno2.length; i++) {
					            	t_where+="or custno ='"+t_custno2[i]+"' "
					            }
							}
							
				            var j = 0, s2 = '', s1 = '';
				            for (var i = 0; i < q_bbsCount; i++) {
				                if ($.trim($('#txtVccno_' + i).val()).length > 0) {
				                    s2 = s2 + (j == 0 ? "" : " or ") + " noa='" + $('#txtVccno_' + i).val() + "'";
				                    s1 = s1 + (j == 0 ? "" : " or ") + " vccno='" + $('#txtVccno_' + i).val() + "'";
				                    j++;
				                }
				            }
		
				            t_where = t_where + (s2.length > 0 ? " or (" + s2 + ")" : '') + "^^";
				            t_where1 = t_where1 + (s1.length > 0 ? " or (" + s2 + ")" : '') + "^^";
			            }else{
			            	t_where = "^^1=0^^";
				            t_where1 = " where[1]=^^1=0^^";
			            }
		                q_box("umm_trd_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+t_where1+t_where2+t_where3, 'umm_trd', "70%", "600px", q_getMsg('popUmm_trd'));
		        });
		    }


		    function getOpay() {
		        var t_custno = $('#txtCustno').val();
		        var s2 = (q_cur == 2 ? " and noa!='" + $('#txtNoa').val() + "'" : '');
		        var t_where = "where=^^custno='" + t_custno + "'" + s2 + "^^";
		        q_gt("umm_opay", t_where, 1, 1, 0, '', r_accy);
		    }
		    
		    function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtAcc1_':
		                sum();
		                break;
		    	}
		    }

		    function q_boxClose(s2) {
		        var ret;
		        switch (b_pop) {
		        	case 'umm_trd':
                    if (q_cur > 0 && q_cur < 4) {   //  q_cur： 0 = 瀏覽狀態  1=新增  2=修改 3=刪除  4=查詢
                        b_ret = getb_ret();         ///  q_box() 執行後，選取的資料
                        if (!b_ret || b_ret.length == 0)
                            return;
                            
                        for (var i = 0; i < b_ret.length; i++) {
		                    if (dec(b_ret[i].total) - dec(b_ret[i].paysale) == 0) {
		                        b_ret.splice(i, 1);
		                        i--;
		                    } else {
		                        b_ret[i]._unpay = (dec(b_ret[i].total) - dec(b_ret[i].paysale)).toString();
		                        b_ret[i].paysale = 0;
		                    }
		                }
		                //清除單據bbs
		                for (var i = 0; i < q_bbsCount; i++) {
			                 $('#txtVccno_'+i).val('');
			                 $('#txtPaysale_'+i).val('');
			                 $('#txtUnpayorg_'+i).val('');
			                 $('#txtUnpay_'+i).val('');
			                 $('#txtPart2_'+i).val('');
			            }
		                
		                /*if (!t_Saving)*/
		                    ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtVccno,txtPaysale,txtUnpay,txtUnpayorg,txtPart2', b_ret.length, b_ret, 'noa,paysale,_unpay,_unpay,part2', '');   /// 最後 aEmpField 不可以有【數字欄位】
                    }
                    break;
		            case q_name + '_s':
		                q_boxClose2(s2);
		                break;
		        }
		        b_pop = '';
		    }

		    function sum() {
		        var t_money = 0, t_pay = 0,t_sale=0;
		        for (var j = 0; j < q_bbsCount; j++) {
		        	if($('#txtAcc1_'+j).val().indexOf('2121') == 0 || $('#txtAcc1_'+j).val().indexOf('7149') == 0 || $('#txtAcc1_'+j).val().indexOf('7044') == 0)
		               	t_money -= q_float('txtMoney_' + j);
		            else
		               	t_money += q_float('txtMoney_' + j);
		               	t_money+=q_float('txtChgs_' + j);
		            t_sale += q_float('txtUnpayorg_' + j);
		            t_pay += q_float('txtPaysale_' + j);
		        }
		        
		        //bbm收款金額(total)=bbs收款金額總額(money)
		        //bbm應收金額(sale)=bbs應收金額總額(Unpayorg)
				//bbm本次沖帳(paysale)=bbs沖帳金額(paysale)+bbm預收沖帳(unopay)
				//bbm未收金額(unpay)=bbm應收金額(sale)-bbm本次沖帳(paysale)
				//bbm預收(opay)=bbm應收金額(total)-bbm本次沖帳(paysale)
				//bbm預收餘額=應收餘額+預收-預收沖帳
		        
		        q_tr('txtSale', t_sale);
		        q_tr('txtTotal', t_money);
		        q_tr('txtPaysale', t_pay);
		        q_tr('txtUnpay', q_float('txtSale') - q_float('txtPaysale'));
		        if(q_float('txtTotal')-q_float('txtPaysale')>0)
		        {
		        	q_tr('txtOpay',  q_float('txtTotal')-q_float('txtPaysale'));
		        }else{
		        	q_tr('txtOpay', 0);
		        }
		        q_tr('textOpay', q_float('textOpayOrg') + q_float('txtOpay') - q_float('txtUnopay'));
		    }

		    function q_gtPost(t_name) {
		        switch (t_name) {
		            case 'umm_opay':
		                var as = _q_appendData('umm', '', true);
		                var s1 = q_trv((as.length > 0 ? round(as[0].total, 0) : 0));

		                $('#textOpay').val(s1);
		                $('#textOpayOrg').val(s1);

		                break;
		            case 'umm_trd':
		            	
		                for (var i = 0; i < q_bbsCount; i++) {
		                    if ($('#txtVccno_' + i).val().length > 0) {
		                        $('#txtVccno_' + i).val('');
		                        $('#txtPaysale_' + i).val('');
		                        $('#txtUnpay_' + i).val('');
		                        $('#txtPart2_' + i).val('');
		                        $('#txtUnpayorg_' + i).val('');
		                    }
		                }
		                var as = _q_appendData("view_trd", "", true);
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
		                    q_gridAddRow(bbsHtm, 'tbbs', 'txtVccno,txtPaysale,txtUnpay,txtUnpayorg,txtPart2', as.length, as, 'noa,paysale,_unpay,_unpay,part2', 'txtVccno', '');
		                else{/// 自動沖帳
		                	/*$('#txtOpay').val(0);
		                    $('#txtUnopay').val(0);
		                    var t_money = 0;
		                    for (var i = 0; i < q_bbsCount; i++) {
		                        t_money += q_float('txtMoney_' + i) + q_float('txtChgs_' + i);
		                    }

		                    var t_unpay, t_pay;
		                    for (var i = 0; i < q_bbsCount; i++) {
		                        if (i < as.length && as[i].total - as[i].paysale != 0) {
		                            $('#txtVccno_' + i).val(as[i].noa);
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
		                            $('#txtVccno_' + i).val('');
		                            $('#txtPaysale_' + i).val('');
		                            $('#txtUnpay_' + i).val('');
		                        }
		                    }

		                    if (t_money > 0)
		                        q_tr('txtOpay', t_money);
		                	*/
		                }

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

		    function btnOk() {
		        var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
		        if (t_err.length > 0) {
		            alert(t_err);
		            return;
		        }

		        if ($.trim($('#txtCustno').val()) == 0) {
		            alert(m_empty + q_getMsg('lblCust'));
		            return false;
		        }

		        $('#txtWorker').val(r_name);
		        var t_money = 0, t_chgs = 0, t_paysale, t_mon = '';
		        for (var i = 0; i < q_bbsCount; i++) {
		            t_money = q_float('txtMoney_' + i);
		            t_chgs = q_float('txtChgs_' + i);

		            if ($.trim($('#txtAcc1_' + i).val()).length == 0 && t_money + t_chgs > 0) {
		                t_err = true;
		                break;
		            }

		            if (t_money != 0 || i == 0)
		                t_mon = $('#txtVccno_' + i).val();
		        }

		        //$('#txtMon').val(t_mon.substr(1, r_len) + '/' + t_mon.substr(r_len + 1, 2));


		        sum();
		        if (t_err) {
		            alert(m_empty + q_getMsg('lblAcc1') + q_trv(t_money + t_chgs));
		            return false;
		        }

		        var t_opay = q_float('txtOpay');
		        var t_unopay = q_float('txtUnopay');
		        var t1 = q_float('txtPaysale') + q_float('txtOpay') - q_float('txtUnopay');
		        var t2 = q_float('txtTotal')+t_chgs;
		        if (t1 != t2) {
		            alert('收款金額  ＋ 費用 ＝' + q_trv(t2) + '\r 【不等於】 沖帳金額 ＋ 預收 －　預收沖帳 ＝' + q_trv(t1) + '\r【差額】=' + Math.abs(t1 - t2));
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

		        q_box('umm_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
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
		            
		            $('#txtCheckno_' + i).change(function (e) {
		            	 t_IdSeq = -1;
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;
		                for (var j = 0; j < q_bbsCount; j++) {
		                	if($('#txtCheckno_' + b_seq).val()==$('#txtCheckno_' + j).val() && b_seq!=j && !emp($('#txtCheckno_' + j).val())){
		                		alert('支票號碼重複輸入!!');
		                		$('#txtCheckno_'+b_seq).val(($('#txtCheckno_'+b_seq).val()).substr(0,7));
		               			$('#txtCheckno_'+b_seq).focus();
		               		}
		                }
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
		                    
		                sum();
		            });

		            $('#txtPaysale_' + i).change(function (e) {
		                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;
		                
		               /* if(q_float('txtPaysale_'+b_seq)>q_float('txtUnpayorg_'+b_seq))
		                {
		               		alert('請輸入正確沖帳金額!!');
		               		$('#txtPaysale_'+b_seq).val(0);
		               		$('#txtPaysale_'+b_seq).focus();
						}*/
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
		        q_box("z_ummp.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno , 'umm', "95%", "650px", m_print);
		    }

		    function wrServer(key_value) {
		        var i;

		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);

		    }

		    function bbsSave(as) {
		        if (!as['acc1'] && !as['money']&& !as['memo']&& !as['paysale']) {
		            as[bbsKey[1]] = '';
		            return;
		        }

		        q_nowf();

		        return true;
		    }


		    function refresh(recno) {
		        _refresh(recno);
		        getOpay();
		        //		        var t_custno = $('#txtCustno').val();
		        //		        q_gt("umm_opay", "where=^^custno='" + t_custno + "'^^", 1, 1, 0, '', r_accy);
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
                width: 22%;
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
                width: 76%;
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
						<td align="center" style="width:28%"><a id='vewDatea'></a></td>
						<td align="center" style="width:38%"><a id='vewComp'></a></td>
						<td align="center" style="width:38%"><a id='vewTotal'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp,4'>~comp,4</td>
						<td align="center" id='total,0,1'>~total,0,1</td>
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
						<td class="td5" ><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td6">
						<input id="txtMon" type="text" class="txt c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblPayc' class="lbl"></a></td>
						<td class="td8">
						<input id="txtPayc" type="text" class="txt c1"/>
						</td>
						<td class="tdZ"></td>
					</tr>
					<tr class="tr2">
						<td class="td1" ><span> </span><a id='lblAcomp' class="lbl btn"></a></td>
						<td class="td2" >
						<input id="txtCno"  type="text" class="txt c4"/>
						<input id="txtAcomp"    type="text" class="txt c5"/>
						</td>
						<td class="td3"><span> </span><a id='lblCust' class="lbl btn"></a></td>
						<td class="td4" colspan="2">
						<input id="txtCustno" type="text" class="txt c4"/>
						<input id="txtComp"  type="text" class="txt c5"/>
						</td>
						<td class="6">
						<input type="button" id="btnVcc" class="txt c1 " />
						</td>
						<td class="td7"><span> </span><a id='lblCust2' class="lbl"></a></td>
						<td class="td8"><input id="txtCustno2" type="text" class="txt c1"/></td>
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
						<td class="td5"><a id='lblWorker' class="lbl"></a></td>
						<td class="td6" >
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td class="td7"><input type="button" id="btnAuto" class="txt c1 "  style="color:Red"/></td>
						<td class="td8" ><input type="button" id="btnBank" class="txt c1 "  /></td>
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
					<td align="center" style="width:4%;"><a id='lblCheckno'></a></td>
					<td align="center" style="width:4%;"><a id='lblAccount'></a></td>
					<td align="center" style="width:8%;"><a id='lblBank'></a></td>
					<td align="center" style="width:3%;"><a id='lblIndate'></a></td>
					<td align="center" style="width:3%;"><a id='lblChgsTran'></a></td>
					<td align="center" style="width:5%;"><a id='lblMemos'></a></td>
					<td align="center" style="width:3%;"><a id='lblPaysales'></a></td>
					<%--<td align="center" style="width:5%;"><a id='lblVccno'></a></td>--%>
					<td align="center" style="width:3%;"><a id='lblUnpay_s'></a></td>
					<%--<td align="center" style="width:3%;"><a id='lblPart'></a></td>--%>
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
					<input type="text" id="txtCheckno.*"  style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtAccount.*"  style="width:95%;" />
                     </td>
					<td>
					<input type="button" id="btnBankno.*"  style="float:left;width:7%;" value="."/>
					<input type="text" id="txtBankno.*"  style="float:left;width:35%;" />
					<input type="text" id="txtBank.*" style="float:left;width:47%;"/>
                    <input type="text" id="txtTitle.*" style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtIndate.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtChgs.*" style="text-align:right;width:95%;"/>
						<input type="text" id="txtPartno.*"  style="float:left;width:25%;" /><input type="text" id="txtPart.*" style="float:left;width:57%;"/>
					</td>
					<td>
					<input type="text" id="txtMemo.*" style="width:95%;"/>
                    <input type="text" id="txtVccno.*" style="width:95%;" />
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
