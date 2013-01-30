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
		    var q_readonly = ['txtNoa', 'txtWorker', 'txtAccno','txtSale','txtTotal','txtPaysale','txtUnpay','txtOpay','textOpay'];
		    var q_readonlys = ['txtRc2no', 'txtUnpay', 'txtUnpayorg', 'txtAcc2', 'txtPart2'];
		    var bbmNum = new Array(['txtSale', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtOpay', 10, 0, 1], ['txtUnopay', 10, 0, 1], ['textOpay', 10, 0, 1]);
		    var bbsNum = [['txtMoney', 10, 0, 1], ['txtChgs', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtUnpayorg', 10, 0, 1]];
		    var bbmMask = [];
		    var bbsMask = [];

		    q_sqlCount = 6;
		    brwCount = 6;
		    brwCount2 = 5;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'Datea';
		    aPop = new Array(
            ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
             ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2,acc7', 'txtAcc1_,txtAcc2_,txtMemo_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
             ['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'],
             ['txtUmmaccno_', '', 'payacc', 'noa,typea', 'txtUmmaccno_,txtTypea_', 'payacc_b.aspx'],
             ['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']);

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
		        bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
		        q_mask(bbmMask);
		        bbsMask = [['txtIndate', r_picd]];
		        q_gt('part', '', 0, 0, 0, "");
		        q_gt('acomp', '', 0, 0, 0, "");
		        $('#btnGqbPrint').click(function (e) {
		            var t_noa = '', t_max, t_min;
		            for (var i = 0; i < q_bbsCount; i++) {
		                t_noa = $.trim($('#txtCheckno_' + i).val())
		                if (t_noa.length > 0) {
		                    break;
		                }
		            }
		            q_box('z_gqbp.aspx' + "?;;;;" + r_accy + ";noa=" + t_noa, '', "900px", "600px", m_print);
		        });

		        $('#lblAccc').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substr(0,3)+ '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "92%", q_getMsg('btnAccc'), true);
		        });

		        $('#txtTggno').change(function () { getOpay(); });

		        $('#txtOpay').change(function () { sum(); });
		        $('#txtUnopay').change(function () { sum(); });
		        $('#txtRc2no').change(function () { $('txtMon').val(t_mon); });
				//1003暫時不先開啟視窗選擇要匯入的立帳單
		        $('#btnVcc').click(function (e) {
		            pay_tre();
		        });
		        $('#btnRc2no').click(function (e) {
		            var t_where = "where=^^ unpay>0 ^^"; 
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
		               //$('#txtOpay').val(0);
		               //$('#txtUnopay').val(0);
		               for (var i = 0; i < q_bbsCount; i++) {
		               		$('#txtPaysale_'+i).val(0);//歸零
		               		$('#txtUnpay_'+i).val($('#txtUnpayorg_'+i).val());//歸零
		               }
		               
		               var t_money = 0+q_float('txtUnopay');
		               for (var i = 0; i < q_bbsCount; i++) {
		               		if($('#txtAcc1_'+i).val().indexOf('1121') == 0 || $('#txtAcc1_'+i).val().indexOf('7149') == 0 || $('#txtAcc1_'+i).val().indexOf('7044') == 0)
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
			
			function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtAcc1_':
		                sum();
		                break;
		    	}
		    }
			
		    function q_gtPost(t_name) {
		        switch (t_name) {
		        	case 'part':
		                var as = _q_appendData("part", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
		                    }
		                    q_cmbParse("cmbPartno", t_item, 's');
		                    refresh(q_recno);  /// 第一次需要重新載入
		                }
		                break;
		            case 'acomp':
		                var as = _q_appendData("acomp", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
		                    }
		                    q_cmbParse("cmbCno", t_item);
		                }
		                break;
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
						
						q_gridAddRow(bbsHtm, 'tbbs', 'txtRc2no,txtPaysale,txtUnpay,txtUnpayorg,txtPart2,cmbPartno,txtPart,txtMemo,txtPayc,txtIndate', as.length, as, 'noa,paysale,_unpay,_unpay,part,partno,part,memo,payc,paydate', 'txtRc2no', '');
						var t_memo = '';
						for (var i = 0; i < q_bbsCount; i++) {
							if($.trim($('#txtMemo_'+i).val()).length>0){
								t_memo = t_memo+(t_memo.length>0?'\n':'')+ $.trim($('#txtMemo_'+i).val());
								$('#txtMemo_'+i).val('');
							}
				        }
				        $('#txtMemo').val(t_memo);
		                t_Saving = false;
		                sum();

		                break;
                    case 'pays' :
                    	var as = _q_appendData('pays', '', true);
                    	if(as[0]!=undefined){
                			$('#txtRc2no_'+b_seq).val(as[0].rc2no).attr('readonly','readonly');
                			$('#txtRc2no_'+b_seq).css('background-color', 'rgb(237, 237, 238)').css('color','green');
                			$('#txtUnpayorg_' + b_seq).val(parseFloat(as[0].money,10)*(-1));
                			$('#txtPart2_' + b_seq).val(as[0].part2);
                		}else{
                			$('#txtRc2no_'+b_seq).val('').removeAttr('readonly');
                			$('#txtRc2no_'+b_seq).css('background-color', 'rgb(255, 255, 255)').css('color','');
                			$('#txtUnpayorg_' + b_seq).val('');
                			$('#txtPart2_' + b_seq).val('');
                		}
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
		            if($('#txtAcc1_'+j).val().indexOf('1121') == 0 || $('#txtAcc1_'+j).val().indexOf('7149') == 0 || $('#txtAcc1_'+j).val().indexOf('7044') == 0)
		               	t_money -= q_float('txtMoney_' + j);
		            else
		               	t_money += q_float('txtMoney_' + j);
		            	t_money+=q_float('txtChgs_' + j);
		            t_sale += q_float('txtUnpayorg_' + j);
		            t_pay += q_float('txtPaysale_' + j);
		        }
		        //bbm付款金額(total)=bbs付款金額總額(money)
		        //bbm應付金額(sale)=bbs應付金額總額(Unpayorg)
				//bbm本次沖帳(paysale)=bbs沖帳金額(paysale)+bbm預付沖帳(unopay)
				//bbm未付金額(unpay)=bbm應付金額(sale)-bbm本次沖帳(paysale)
				//bbm預付(opay)=bbm應付金額(sale)-bbm本次沖帳(paysale)
				//bbm預付餘額=應付餘額+預付-預付沖帳
				
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

		    function btnOk() {
		    	for (var i = 0; i < q_bbsCount; i++) {
		            $('#txtPart_' + i).val($('#cmbPartno_' + i).find(":selected").text());
		        }
		        //為了查詢
            	var t_part = '';
            	for (var i = 0; i < q_bbsCount; i++) {
            		if(t_part.indexOf($.trim($('#txtPart2_'+i).val()))==-1)
            			t_part += (t_part.length>0?',':'') + $.trim($('#txtPart2_'+i).val());
            	}
            	$('#txtPart2').val(t_part);
            	
		        $('#txtAcomp').val($('#cmbCno').find(":selected").text());
				$('#txtMon').val($.trim($('#txtMon').val()));
					if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
						alert(q_getMsg('lblMon')+'錯誤。');   
						return;
				} 		
		        var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
		        if (t_err.length > 0) {
		            alert(t_err);
		            return;
		        }
		        
		        var t_money=0;
		        for (var j = 0; j < q_bbsCount; j++) {
		        	t_money+=q_float('txtMoney_' + j);
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

		        q_box('pay_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
		    }

		    function combPay_chg() {
		    }

		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		        	$('#lblNo_'+i).text(i+1);	
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
						
						if(q_float('txtPaysale_'+b_seq)>q_float('txtUnpayorg_'+b_seq))
		                {
		               		alert('請輸入正確沖帳金額!!');
		               		$('#txtPaysale_'+b_seq).val(0);
		               		$('#txtPaysale_'+b_seq).focus();
						}
						
		                var t_unpay = dec($('#txtUnpayorg_' + b_seq).val()) - dec($('#txtPaysale_' + b_seq).val());
		                q_tr('txtUnpay_' + b_seq, t_unpay);
		                sum();
		            });
                    $('#txtCheckno_' + i).change(function(){
                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        $('#txtMoney_' + b_seq).focus();
                    	if(($('#txtAcc1_' + b_seq).val().substr(0,4) == '2121') && ($('#txtMoney_'+b_seq).val() < 0)){
                    		var str1 = $('#txtCheckno_' + b_seq).val()
                    		var t_where = "where=^^ checkno = '" + str1 +"' and money > 0 ^^";
                    		q_gt('pays', t_where , 0, 0, 0, "", r_accy);
                    	}
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
		        q_box("z_payp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'pay', "95%", "650px", m_print);
		    }

		    function wrServer(key_value) {
		        var i;

		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);

		    }

		    function bbsSave(as) {
		        if (!as['acc1'] && (!as['money'] || as['money']==0)&& !as['memo']&& !as['vccno']&& !as['rc2no']&& (!as['paysale'] || as['paysale']==0)) {
		            as[bbsKey[1]] = '';
		            return;
		        }
				//!as['acc1'] && !as['money']&& !as['memo']&& !as['paysale']
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
                width: 80%;
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
            .txt.c2 {
                width: 50%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 20%;
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
            input[type="text"], input[type="button"],select {
                font-size: medium;
            }
            .num {
                text-align: right;
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
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:30%"><a id='vewDatea'></a></td>
						<td align="center" style="width:30%"><a id='vewComp'></a></td>
						<td align="center" style="width:30%"><a id='vewTotal'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp,4'>~comp,4</td>
						<td id='total,0,1' style="text-align: right;">~total,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
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
					<tr class="tr1">
						<td class="td1" ><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2" >
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td4" >
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblAcomp' class="lbl"> </a></td>
						<td>
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text" style="display:none;"/>
							<input id="txtPart2" type="text" style="display:none;"/>
						</td>
						<td class="td7"><span> </span><a id='lblPayc' class="lbl"></a></td>
						<td class="td8"><input id="txtPayc" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
                        <td class="td1" ><span> </span><a id='lblTgg' class="lbl btn"></a></td>
						<td class="td2" colspan='3'>
                        <input id="txtTggno" type="text" class="txt c4"/>
                        <input id="txtComp"  type="text" class="txt c5" />
						</td>
						<td class="td4">
							<input type="button" id="btnRc2no" class="txt c1 " />
						</td>
						<td class="5">
						<input type="button" id="btnVcc" class="txt c1 " />
						</td>
						<td class="td6"><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td7" >
						<input id="txtMon"  type="text" class="txt c1"/>
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
						<td><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr5">
						<td class="td1"> <a id='lblMemo' class="lbl"></a></td>
						<td class="td2" colspan='3' ><textarea id="txtMemo"  rows='3' cols='3' style="width: 99%; height: 50px;" ></textarea></td>
						<td class="td5" ><span> </span>
							<a id='lblRc2no' class="lbl"></a>
							<p style="height:1%;"></p><span> </span>
							<a id='lblWorker' class="lbl"></a>
						</td>
						<td class="td6" >
							<input id="txtRc2no"  type="text" class="txt c1"/>
							<p style="height:1%;"></p>
							<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td>
							<input type="button" id="btnAuto" style="width:80%;color:red;"/>
                        	<input type="button" id="btnGqbPrint" style="width:80%;"/>
                        </td>
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
					<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:1%;"> </td>
					<td align="center" style="width:8%;"><a id='lblAcc1'></a></td>
					<td align="center" style="width:5%;"><a id='lblMoney'></a></td>
					<td align="center" style="width:8%;"><a id='lblCheckno'></a></td>
					<td align="center" style="width:8%;"><a id='lblBank'></a></td>
					<td align="center" style="width:3%;"><a id='lblIndate'></a></td>
					<td align="center" style="width:3%;"><a id='lblChgsTran'></a></td>
					<td align="center" style="width:5%;"><a id='lblMemos'></a></td>
					<td align="center" style="width:3%;"><a id='lblPaysales'></a></td>
					<td align="center" style="width:3%;"><a id='lblUnpay_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtAcc1.*"  style="width:85%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtAcc2.*"  style="width:85%; float:left;"/>
					</td>
					<td>
					<input type="text" id="txtMoney.*" style="text-align:right;width:95%;"/>
					<input type="text" id="txtPayc.*"  style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtCheckno.*"  style="width:95%;" />
					<input type="text" id="txtAccount.*"  style="width:95%;" />
					</td>
					<td>
						<input class="btn"  id="btnBankno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtBankno.*"  style="width:85%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtBank.*"  style="width:85%; float:left;"/>
					</td>
					<td>
					<input type="text" id="txtIndate.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtChgs.*" style="text-align:right;width:95%;"/>
						<select id="cmbPartno.*"  style="float:left;width:95%;" > </select>
						<input type="text" id="txtPart.*" style="display:none;"/>
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
