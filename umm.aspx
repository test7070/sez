﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
            q_desc = 1;
            q_tables = 's';
            var q_name = "umm";
            var q_readonly = ['txtNoa','txtWorker', 'txtCno', 'txtAcomp', 'txtSale', 'txtTotal', 'txtPaysale', 'txtUnpay', 'txtOpay', 'textOpay','txtAccno','txtWorker2'];
            var q_readonlys = ['txtUnpay', 'txtUnpayorg', 'txtAcc2', 'txtPart2','txtCoin','txtCustno','txtPaymon'];
            var bbmNum = new Array(['txtSale', 15, 5, 1, 1], ['txtTotal', 15, 5, 1, 1], ['txtPaysale', 15, 5, 1, 1], ['txtUnpay', 15, 5, 1, 1], ['txtOpay', 15, 5, 1, 1], ['txtUnopay', 15, 5, 1, 1], ['textOpay', 15, 5, 1, 1]
            , ['txtFloata', 15, 5, 1, 1], ['txtEcmoney', 15, 5, 1, 1]);
            var bbsNum = [['txtMoney', 15, 5, 1, 1], ['txtChgs', 15, 5, 1, 1], ['txtPaysale', 15, 5, 1, 1], ['txtUnpay', 15, 5, 1, 1], ['txtUnpayorg', 15, 5, 1, 1]
            , ['txtMoneyus', 15, 5, 1, 1]];
            var bbmMask = [];
            var bbsMask = [];

            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwCount2 = 6;
            brwKey = 'Datea';

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
                var t_db=q_db.toLocaleUpperCase();
                q_gt('acomp', "where=^^(dbname='"+t_db+"' or not exists (select * from acomp where dbname='"+t_db+"')) ^^ stop=1", 0, 0, 0, "cno_acomp");
            });
            function main() {
                mainForm(1);
            }
			
            function mainPost() {
            	if(q_getPara('sys.project').toUpperCase()=='RB'){
            		q_bbsLen=10;
            		$('.dbbs').css('width','1260px');
            		$('#lblMoney').parent().css('width','12%');
            		$('.coin').hide();
            	}
            	
            	//放在mainPost 避免 r_accy抓不到
            	aPop = new Array(
	            	['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx']
	            	, ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_,txtMoney_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
	            	, ['txtBankno_', 'btnBank_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx']
	            	, ['txtUmmaccno_', '', 'ummacc', 'noa,typea', 'txtUmmaccno_,txtTypea_', 'ummacc_b.aspx']
	            	,['txtEcacc1', 'lblEcacc1', 'acc', 'acc1,acc2', 'txtEcacc1,txtEcacc2,txtEcmoney', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
	            	//104/10/03 Vccno不提供apop 會出現系統lag問題
	            	//, ['txtVccno_', '', 'view_vcc', 'noa,comp,unpay,unpay,typea,accy,cno,mon', 'txtVccno_,txtMemo2_,txtUnpayorg_,txtUnpay_,textTypea_,txtAccy_,txtCno_,txtPaymon_', '']
            	);
            	
            	if(q_getPara('sys.project').toUpperCase()=='XY'){
            		aPop = new Array(
		            	['txtCustno', 'lblCust', 'cust', 'noa,nick,comp,invoicetitle,serial', 'txtCustno,txtComp', 'cust_b.aspx']
		            	, ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_,txtMoney_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
		            	, ['txtBankno_', 'btnBank_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx']
		            	, ['txtUmmaccno_', '', 'ummacc', 'noa,typea', 'txtUmmaccno_,txtTypea_', 'ummacc_b.aspx']
		            	,['txtEcacc1', 'lblEcacc1', 'acc', 'acc1,acc2', 'txtEcacc1,txtEcacc2,txtEcmoney', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
	            	);
            	}
            	
            	
                q_getFormat();

                if (r_rank < 7)
                    q_readonly[q_readonly.length] = 'txtAccno';
				
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                bbsMask = [['txtIndate', r_picd], ['txtMon', r_picm]];
				q_gt('part', '', 0, 0, 0, "");
		        q_gt('acomp', '', 0, 0, 0, "");
		        q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
		        //q_cmbParse("combAcc1", '1111@現金,1121@應收票據');
		        
		         $('#txtDatea').blur(function() {
		         	if(!emp($('#txtDatea').val())&&(q_cur==1 || q_cur==2)){
		         		if(q_getPara('sys.project').toUpperCase()=='IT' || q_getPara('sys.project').toUpperCase()=='UU' || q_getPara('sys.project').toUpperCase()=='XY' || q_getPara('sys.project').toUpperCase()=='RB'){
		         			$('#txtMon').val($('#txtDatea').val().substr(0,r_lenm));
		         		}else{
		         			var d='';
		         			if(r_len==3)//民國年
	                    		d = new Date(dec($('#txtDatea').val().substr(0,r_len))+1911, dec($('#txtDatea').val().substr((r_len+1),2))-1, 1);
	                    	else//西元年
	                    		d = new Date(dec($('#txtDatea').val().substr(0,r_len)), dec($('#txtDatea').val().substr((r_len+1),2))-1, 1);
							d.setMonth(d.getMonth() - 1);
							if(r_len==3)//民國年
								$('#txtMon').val(d.getFullYear()-1911+'/'+('0'+(d.getMonth()+1)).slice(-2));
							else//西元年
								$('#txtMon').val(d.getFullYear()+'/'+('0'+(d.getMonth()+1)).slice(-2));
						}
					}
                });
		        
                /*$('#lblAccc').click(function() {
                	var t_year=$('#txtDatea').val().substr(0,r_len);
                	if(r_len==4){
                		t_year=q_sub(t_year,1911);
                	}
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + t_year + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('btnAccc'), true);
                });*/
				$('#lblAccc').click(function(){
					if($('#txtDatea').val().substring(0, 1)==1){
						q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "95%", q_getMsg('btnAccc'), true);
					}else{
						q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + ($('#txtDatea').val().substring(0, 4)-1911) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "95%", q_getMsg('btnAccc'), true);
					}
				});
                
                $('#lblCust2').click(function(e) {
					q_box("cust_b2.aspx", 'cust', "95%", "95%", q_getMsg("popCust"));
				});

                /*$('#txtOpay').change(function() {
                    sum();
                });*/
                $('#txtUnopay').change(function() {
                    sum();
                });

                $('#btnBank').click(function() {
                    q_box('bank.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", "銀行主檔");
                });

                $('#btnAuto').click(function(e) {
                    /// 自動沖帳
                    //$('#txtOpay').val(0);
                    //$('#txtUnopay').val(0);
                    for (var i = 0; i < q_bbsCount; i++) {
                        $('#txtPaysale_' + i).val(0);
                        //歸零
                        $('#txtUnpay_' + i).val($('#txtUnpayorg_' + i).val());
                        //歸零
                    }

                    var t_money = 0 + q_float('txtUnopay');
                    for (var i = 0; i < q_bbsCount; i++) {
                    	//$('#txtAcc1_' + i).val().indexOf('2121') == 0 ||
                        /*if ( $('#txtAcc1_' + i).val().indexOf('7149') == 0 || $('#txtAcc1_' + i).val().indexOf('7044') == 0)
                            t_money -= q_float('txtMoney_' + i);
                        else*/
                            t_money += q_float('txtMoney_' + i);
						//104/04/29費用不算在收款金額//0601恢復改為-
                        t_money -= q_float('txtChgs_' + i);
                    }

                    var t_unpay, t_pay = 0;
                    //先算未付金額是負的
                    for(var i=0;i<q_bbsCount;i++){
                    	t_unpay = q_float('txtUnpayorg_' + i);
                    	if(t_unpay>=0)
                    		continue;
                    	t_money = q_add(t_money,Math.abs(t_unpay));
                    	$('#txtPaysale_'+i).val(t_unpay);
                    	$('#txtUnpay_'+i).val(0);
                    }
                    for(var i=0;i<q_bbsCount;i++){
                    	t_unpay = q_float('txtUnpayorg_' + i);
                    	if(t_unpay<=0)
                    		continue;
                    	if(t_money>=t_unpay){
                    		$('#txtPaysale_'+i).val(t_unpay);
                    		$('#txtUnpay_'+i).val(0);
                    		t_money = q_sub(t_money,t_unpay);
                    	}else{
                    		$('#txtPaysale_'+i).val(t_money);
                    		$('#txtUnpay_'+i).val(q_sub(t_unpay,t_money));
                    		t_money = 0;
                    	}
                    }
                    //if (t_money > 0)
                        q_tr('txtOpay', t_money);
                    sum();
                });
                
                $('#btnVcc').click(function(e) {
                	var t_noa = $.trim($('#txtNoa').val());
                	var t_custno = $.trim($('#txtCustno').val());
                	var t_custno2 = $.trim($('#txtCustno2').val()).replace(/\,/g,'@');
                	var t_mon = $.trim($('#txtMon').val());
                	if(t_custno.length==0){
                		alert('請先輸入'+q_getMsg('lblCust')+'!!');
                		return;
                    }
                    
                    q_gt('umm_import',"where=^^['"+t_noa+"','"+t_custno+"','"+t_custno2+"','"+t_mon+"','"+q_getPara('sys.d4taxtype')+"')^^", 0, 0, 0, "umm_import");
                });
                
                $('#btnMon').click(function(e) {
                	var t_noa = $.trim($('#txtNoa').val());
                	var t_custno = $.trim($('#txtCustno').val());
                	var t_custno2 = $.trim($('#txtCustno2').val()).replace(/\,/g,'@');
                	var t_mon = $.trim($('#txtMon').val());
                	if(t_custno.length==0){
                		alert('請先輸入'+q_getMsg('lblCust')+'!!');
                		return;
                	}
                	if(t_mon.length==0){
                		alert('請先輸入'+q_getMsg('lblMon')+'!!');
                		return;
                	}
                	q_gt('umm_import',"where=^^['"+t_noa+"','"+t_custno+"','"+t_custno2+"','"+t_mon+"','mon')^^", 0, 0, 0, "umm_import");
                });
                
                $('#cmbCoin').change(function() {
					UsShow();
					if(!emp($('#txtDatea').val()) && !emp($('#cmbCoin').val())){
						q_gt('flors', "where=^^coin='"+$('#cmbCoin').val()+"' and '"+$('#txtDatea').val()+"' between bdate and edate ^^", 0, 0, 0, "flors",r_accy,1);
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							$('#txtFloata').val(as[0].floata);
						}else{
							$('#txtFloata').val(0);
						}
					}else{
						$('#txtFloata').val(0);
						for(var i=0;i<q_bbsCount;i++){
							$('#txtMoneyus_'+i).val(0);
						}
					}
					sum();
				});
                
                if(q_getPara('sys.isAcccUs')=='1')
					$('.isAcccUs').show();
					
				//上方插入空白行
		        $('#lblTop_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
		            }
		        });
		        //下方插入空白行
		        $('#lblDown_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
		            }
		        });
		        
		        if(q_getPara('sys.project').toUpperCase()=='JO' || q_getPara('sys.project').toUpperCase().substr(0,2)=='AD'){
                    $('#btnMon').hide();
                }
            }
			
			
            function getOpay() {
            	Lock(1,{opacity:0});
                var t_custno = $('#txtCustno').val();
                var s2 = (q_cur == 2 ? " and noa!='" + $('#txtNoa').val() + "'" : '');
                
                if(q_cur==4 ||q_cur==0 )
                	var t_where = "where=^^custno='" + t_custno + "'" + s2 + " and datea<='"+$('#txtDatea').val()+"' ^^";
                else
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
                        if (q_cur > 0 && q_cur < 4) {//  q_cur： 0 = 瀏覽狀態  1=新增  2=修改 3=刪除  4=查詢
                            b_ret = getb_ret();
                            ///  q_box() 執行後，選取的資料
                            if (!b_ret || b_ret.length == 0)
                                return;

                            for (var i = 0; i < b_ret.length; i++) {
                                if (dec(b_ret[i].total) - dec(b_ret[i].paysale) == 0 &&$('#txtCustno').val().substr(0,1)!='H') {
                                    b_ret.splice(i, 1);
                                    i--;
                                } else {
                                    b_ret[i]._unpay = (dec(b_ret[i].total) - dec(b_ret[i].paysale)).toString();
                                    b_ret[i].paysale = 0;
                                }
                            }
                            //清除單據bbs
                            for (var i = 0; i < q_bbsCount; i++) {
                                $('#txtVccno_' + i).val('');
                                $('#txtPaysale_' + i).val('');
                                $('#txtUnpayorg_' + i).val('');
                                $('#txtUnpay_' + i).val('');
                                $('#txtPart2_' + i).val('');
                            }

                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtVccno,txtPaysale,txtUnpay,txtUnpayorg,txtPart2,txtPartno,txtPart,txtMemo2,cmbPartno', b_ret.length, b_ret, 'noa,paysale,_unpay,_unpay,part,partno,part,memo,partno', '');
  
                            /// 最後 aEmpField 不可以有【數字欄位】
                            sum();
                            $('#txtAcc1_0').focus();
                        }
                        break;
                    case 'cust':
                		ret = getb_ret();
                        if(q_cur > 0 && q_cur < 4){
	                        if(ret[0]!=undefined){
	                        	for (var i = 0; i < ret.length; i++) {
	                        		if($('#txtCustno2').val().length>0){
		                            	var temp=$('#txtCustno2').val();
		                            	$('#txtCustno2').val(temp+','+ret[i].noa);
		                            }else{
		                            	$('#txtCustno2').val(ret[i].noa);
		                            } 
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

            function sum() {
                var t_money = 0, t_pay = 0, t_sale = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_money = q_add(t_money,emp($('#cmbCoin').val())?q_float('txtMoney_' + j):q_float('txtMoneyus_' + j));
                    
					//104/04/29費用不算在收款金額//0601恢復並改為-
                    t_money = q_sub(t_money, q_float('txtChgs_' + j));
                    t_sale = q_add(t_sale, q_float('txtUnpayorg_' + j));
                    t_pay = q_add(t_pay,q_float('txtPaysale_' + j));
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
                q_tr('txtUnpay', q_sub(q_float('txtSale'),q_float('txtPaysale')));
                if (q_sub(q_float('txtTotal'),q_float('txtPaysale')) > 0) {
                    q_tr('txtOpay', q_sub(q_float('txtTotal'),q_float('txtPaysale')));
                } else {
                    q_tr('txtOpay', 0);
                }
                q_tr('textOpay', q_sub(q_add(q_float('textOpayOrg'),q_float('txtOpay')),q_float('txtUnopay')));
            }
			
			var z_cno=r_cno,z_acomp=r_comp,z_nick=r_comp.substr(0,2);
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno]){
							$('#cmbCoin').val(abbm[q_recno].coin);
							UsShow();
						}
						
						break;
                	case 'umm_import':
                		as = _q_appendData(t_name, "", true);
                		for (var i = 0; i < as.length; i++) {
                			if(q_getPara('sys.project').toUpperCase()=='XY'){
                				as[i].tablea='vcc_xy';
                				as[i].memo=as[i].comp+' '+as[i].memo;
                			}else if(q_getPara('sys.project').toUpperCase()=='RB'){
								as[i].tablea='vcc_rb';
							}else if(q_getPara('sys.project').toUpperCase()=='IT'){
								as[i].tablea='vcc_it';
							}else if(q_getPara('sys.project').toUpperCase()=='YC'){
								as[i].tablea='vcc_yc';
							}else if(q_getPara('sys.project').toUpperCase()=='UU'){
								as[i].tablea='vcc_uu';
								as[i].memo=as[i].memo+as[i].invono;
							}else if (q_getPara('sys.comp').indexOf('楊家') > -1|| q_getPara('sys.comp').indexOf('德芳') > -1){
								as[i].tablea='vcc_tn';
							}else if(q_getPara('sys.comp').indexOf('傑期')>-1){
								as[i].tablea='vcc_pk';
							}else{
								if(q_getPara('sys.steel')=='1'){
									as[i].tablea='vccst';
								}else{
									as[i].tablea='vcc';
								}
							}
						}
                		q_gridAddRow(bbsHtm, 'tbbs', 'txtCno,txtCustno,txtPaymon,txtCoin,txtUnpay,txtUnpayorg,txtTablea,txtAccy,txtVccno,txtMemo2', as.length, as, 'cno,custno,mon,coin,unpay,unpay,tablea,tableaccy,vccno,memo', '', '');
                		
                		var t_comp = q_getPara('sys.comp').substring(0,2);
                		for(var i=0;i<q_bbsCount;i++){
                			//將沖帳金額歸零 不然 未付金額欄位會有問題
                			$('#txtPaysale_'+i).val('');
                			
                			if($('#txtTablea_'+i).val()=='vcc' && t_comp == "裕承"){
                				$('#txtTablea_'+i).val('vccst');
                			}
                		}
                		
                		if (as[0] != undefined) {
                			if(as[0].coin!=''){
                				$('#cmbCoin').val(as[0].coin).change();
                			}
                		}
                		
                		sum();
                		break;
                	case 'cno_acomp':
                		var as = _q_appendData("acomp", "", true);
                		if (as[0] != undefined) {
	                		z_cno=as[0].noa;
	                		z_acomp=as[0].acomp;
	                		z_nick=as[0].nick;
	                	}
                		break;
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
		                    if(abbm[q_recno]){
								$('#cmbCno').val(abbm[q_recno].cno);
							}
		                }
		                break;
                    case 'umm_opay':
                        var as = _q_appendData('umm', '', true);
                        var s1 = q_trv((as.length > 0 ? round(as[0].total, 0) : 0));
                        $('#textOpay').val(s1);
                        $('#textOpayOrg').val(s1);
						Unlock(1);
                        break;
                    case 'umm_trd':
                        for (var i = 0; i < q_bbsCount; i++) {
                            if ($('#txtVccno_' + i).val().length > 0) {
                            	$('#txtAccy_' + i).val('');
                                $('#txtTablea_' + i).val('');
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
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtVccno,txtPaysale,txtUnpay,txtUnpayorg,txtPart2', as.length, as, 'noa,paysale,_unpay,_unpay,part2', 'txtVccno', '');
                        sum();
                        break;
					case 'umm_mon':
                        for (var i = 0; i < q_bbsCount; i++) {
                            if ($('#txtVccno_' + i).val().length > 0) {
                            	$('#txtAccy_' + i).val('');
                                $('#txtTablea_' + i).val('');
                                $('#txtVccno_' + i).val('');
                                $('#txtPaysale_' + i).val(0);
                                $('#txtUnpay_' + i).val('');
                                $('#txtPart2_' + i).val('');
                                $('#txtUnpayorg_' + i).val('');
                                $('#txtMemo2_' + i).val('');
                            }
                        }
                        
                        
                        /*var as = _q_appendData("umms", "", true);
                        for (var i = 0; i < as.length; i++) {
                            if (as[i].total - as[i].payed == 0) {
                                as.splice(i, 1);
                                i--;
                            } 
                        }
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtVccno,txtMemo2,txtUnpay,txtUnpayorg,txtPart2', as.length, as, 'noa,memo,unpay,unpay,part2', 'txtVccno', '');
                        */
                        var as = _q_appendData("umm_mon", "", true);
                        for (var i = 0; i < as.length; i++) {
                        	if(q_getPara('sys.project').toUpperCase()=='XY'){
								as[i].tablea='vcc_xy';
							}else if(q_getPara('sys.project').toUpperCase()=='RB'){
								as[i].tablea='vcc_rb';
							}else if(q_getPara('sys.project').toUpperCase()=='IT'){
								as[i].tablea='vcc_it';
							}else if(q_getPara('sys.project').toUpperCase()=='YC'){
								as[i].tablea='vcc_yc';
							}else if(q_getPara('sys.project').toUpperCase()=='UU'){
								as[i].tablea='vcc_uu';
								as[i].memo=as[i].memo+as[i].invono;
							}else if (q_getPara('sys.comp').indexOf('楊家') > -1|| q_getPara('sys.comp').indexOf('德芳') > -1){
								as[i].tablea='vcc_tn';
							}else{
								if(q_getPara('sys.steel')=='1'){
									as[i].tablea='vccst';
								}else{
									as[i].tablea='vcc';
								}
							}
                        }
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtAccy,txtTablea,txtVccno,txtMemo2,txtUnpay,txtUnpayorg,txtPart2', as.length, as, 'accy,tablea,noa,memo,unpay,unpay,part', 'txtVccno', '');
                        sum();
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,13)=='gqb_btnOkbbs1'){
                    		//存檔時   bbs 支票號碼   先檢查view_gqb_chk,再檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]); 
                    		var t_checkno = t_name.split('_')[3];  
                    		var t_noa =  t_name.split('_')[4];               		
                    		var as = _q_appendData("view_gqb_chk", "", true);
                    		if(as[0]!=undefined){
                    			var t_isExist = false,t_msg = '';
                    			for(var i in as){
                    				if(as[i]['tablea']!=undefined ){
                    					t_isExist = true;
                    					if( as[i]['noa'] != t_noa){
                    						t_msg += (t_msg.length==0?'票據已存在:':'')+String.fromCharCode(13) + '【'+as[i]['title']+as[i]['noa']+'】'+as[i]['checkno'];
                    					}
                    				}
                    			}
                    			if(t_isExist && t_msg.length==0){
                    				checkGqb_bbs(t_sel-1);
                    			}
                    			else if(t_isExist && t_msg.length>0){
                    				alert('請由以下單據修改。'+String.fromCharCode(13)+t_msg);
                    				Unlock(1);
                    			}else if(t_msg.length>0){
                    				alert(t_msg);
                    				Unlock(1);
                    			}else{
                    				//檢查GQB
	                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
	            					q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbs2_"+t_sel, r_accy);
                    			}
                    		}else{
                				//檢查GQB
                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
            					q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbs2_"+t_sel, r_accy);
                    		}
                    	}else if(t_name.substring(0,13)=='gqb_btnOkbbs2'){
                    		//存檔時   bbs 支票號碼檢查
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);               		
                    		var as = _q_appendData("gqb", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+as[0]['gqbno']+'】已存在');
                    			Unlock(1);
                    		}else{
                    			checkGqb_bbs(t_sel-1);
                    		}
                    	}else if(t_name.substring(0,11)=='gqb_change1'){
                    		//先檢查view_gqb_chk,再檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]); 
                    		var t_checkno = t_name.split('_')[3];  
                    		var t_noa =  t_name.split('_')[4];           
                    		var as = _q_appendData("view_gqb_chk", "", true);
                    		if(as[0]!=undefined){
                    			var t_isExist = false,t_msg = '';
                    			for(var i in as){
                    				if(as[i]['tablea']!=undefined ){
                    					t_isExist = true;
                    					if( as[i]['noa'] != t_noa){
                    						t_msg += (t_msg.length==0?'票據已存在:':'')+String.fromCharCode(13) + '【'+as[i]['title']+as[i]['noa']+'】'+as[i]['checkno'];
                    					}
                    				}
                    			}
                    			if(t_isExist && t_msg.length==0){
                    				Unlock(1);
                    			}else if(t_isExist && t_msg.length>0){
                    				alert('請由以下單據修改。'+String.fromCharCode(13)+t_msg);
                    				Unlock(1);
                    			}else if(t_msg.length>0){
                    				alert(t_msg);
                    				Unlock(1);
                    			}else{
                    				//檢查GQB
	                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
	            					q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_"+t_sel, r_accy);
                    			}
                    		}else{
                				//檢查GQB
                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
            					q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_"+t_sel, r_accy);
                    		}
                    	}else if(t_name.substring(0,11)=='gqb_change2'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);               		
                    		var as = _q_appendData("gqb", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+as[0]['gqbno']+'】已存在');
                    		}
                    		Unlock(1);
                    	}else if(t_name.substring(0,11)=='gqb_status1'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("chk2s", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已託收，託收單號【'+as[0].noa+'】');
                    			//Unlock(1);
                    		}
                    		//else{
                    			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            					q_gt('ufs', t_where, 0, 0, 0, "gqb_status2_"+t_sel+"_"+t_checkno, r_accy);
                    		//}
                    	}else if(t_name.substring(0,11)=='gqb_status2'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("ufs", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已兌現，兌現單號【'+as[0].noa+'】');
                    			//Unlock(1);
                    		}
                    		//else{
                    			checkGqbStatus_btnModi(t_sel-1);
                    		//}
                    	}else if(t_name.substring(0,11)=='gqb_statusA'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("chk2s", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已託收，託收單號【'+as[0].noa+'】');
                    			//Unlock(1);
                    		}
                    		//else{
                    			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            					q_gt('ufs', t_where, 0, 0, 0, "gqb_statusB_"+t_sel+"_"+t_checkno, r_accy);
                    		//}
                    	}else if(t_name.substring(0,11)=='gqb_statusB'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("ufs", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已兌現，兌現單號【'+as[0].noa+'】');
                    			//Unlock(1);
                    		}
                    		//else{
                    			checkGqbStatus_btnDele(t_sel-1);
                    		//}
                    	}
                    	//檢查vccno是否存在
                    	if(t_name.substring(0,11)=='vccnocheck_'){
                    		var n = t_name.split('_')[1];
                    		var as = _q_appendData("view_vcc", "", true);
                    		var patten = /^(.+)-([0-9]{3,4}\/[0-9]{2})$/;
                    		if(as[0]!=undefined){
                    			var t_unpay=q_mul((as[0].typea=='2'?-1:1),dec(as[0].unpay));
                    			
                    			$('#txtMemo2_'+n).val(as[0].comp);
	                    		$('#txtCno_'+n).val(as[0].cno);
	                    		$('#txtVccno_'+n).val(as[0].noa);
	                    		$('#txtAccy_'+n).val(as[0].accy);
	                    		$('#txtTablea_'+n).val('');
	                    		$('#textTypea_'+n).val(as[0].typea);
	                    		$('#txtCustno_'+n).val(((as[0].custno2!='' && as[0].custno2!=undefined)?as[0].custno2:as[0].custno));
	                    		$('#txtPaymon_'+n).val(as[0].mon);
	                    		$('#txtPaysale_'+n).val('');
	                    		$('#txtUnpayorg_'+n).val(t_unpay);
	                    		$('#txtUnpay_'+n).val(t_unpay);
                    		}else if(patten.test($('#txtVccno_'+n).val())){
                    			//月結  
                    			$('#txtCustno_'+n).val($('#txtVccno_'+n).val().replace(patten,'$1'));
                    			$('#txtPaymon_'+n).val($('#txtVccno_'+n).val().replace(patten,'$2'));
                			}else{
                    			//資料清空
	                    		$('#txtMemo2_'+n).val('');
	                    		$('#txtCno_'+n).val('');
	                    		$('#txtVccno_'+n).val('');
	                    		$('#txtAccy_'+n).val('');
	                    		$('#txtTablea_'+n).val('');
	                    		$('#textTypea_'+n).val('');
	                    		$('#txtCustno_'+n).val('');
	                    		$('#txtPaymon_'+n).val('');
	                    		$('#txtPaysale_'+n).val('');
	                    		$('#txtUnpayorg_'+n).val('');
	                    		$('#txtUnpay_'+n).val('');
                    		}
                    	}
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
                //$('#txtAccno').val(xmlString);
                Unlock(1);
            }
            
            function btnOk() {
            	//106/04/19 RB檢查表身沒有資料不能存檔
            	if(q_getPara('sys.project').toUpperCase()=='RB'){
            		var isdata=false;
            		for (var i = 0; i < q_bbsCount; i++) {
            			if(!emp($('#txtAcc1_'+i).val()) || dec($('#txtMoney_'+i).val())!=0 || dec($('#txtPaysale_'+i).val())!=0){
            				isdata=true;
            				break;
            			}
            		}
            		if(!isdata){
            			alert('表身無填入正確資料!!')
            			return;
            		}
            	}
            	//106/04/25 VU 檢查表身應收票據
            	if(q_getPara('sys.project').toUpperCase()=='VU'){
            		var is1131err='';
            		for (var i = 0; i < q_bbsCount; i++) {
            			if($('#txtAcc1_'+i).val().substr(0,4)=='1131'){
            				if($('#txtAcc1_'+i).val()!='1131.'+$('#txtCustno').val()){
            					is1131err='應收票據科目【'+$('#txtAcc1_'+i).val()+'】與收款客戶【'+$('#txtComp').val()+'】不符!!';
            					break;
            				}
            				if(emp($('#txtCheckno_'+i).val())){
            					is1131err='應收票據未輸入支票號碼!!';
            					break;
            				}
            			}
            		}
            		if(is1131err.length>0){
            			alert(is1131err);
            			return;
            		}
            	}
            	
            	//檢查請款單的客戶是否存在客戶和客戶2
            	var vccnowhere='';
            	for (var i = 0; i < q_bbsCount; i++) {
            		if(!emp($('#txtVccno_'+i).val()) && $('#txtTablea_'+i).val().substr(0,3)=='vcc')
            			vccnowhere=vccnowhere+(vccnowhere.length>0?' or ':'')+"noa='"+$('#txtVccno_'+i).val()+"'";
            	}
            	if(vccnowhere.length!=0){
            		var t_where = "where=^^ "+vccnowhere+" ^^";
	            	q_gt('umm_cust', t_where, 0, 0, 0, "getcust", r_accy,1);
	            	var as = _q_appendData("view_vcc", "", true);
	            	if (as[0] == undefined) {
	            		alert('立帳單號客戶不存在!!');
	            		return;
	            	}else{
	            		var terr='';
	            		for (var i = 0; i < as.length; i++) {
	            			var texist=false;
	            			if(as[i].custno==$('#txtCustno').val()){ //客戶
	            				texist=true;
	            			}
	            			if(!texist){
		            			if(($('#txtCustno2').val()+',').indexOf((as[i].custno+','))!=-1){ //客戶2
		            				texist=true;
		            			}
	            			}
	            			if(!texist){
	            				terr+='【'+as[i].custno+'】'
	            			}
	            		}
	            		
	            		if(terr.length>0){
	            			terr+='不存在表頭的『客戶』和『客戶2』內!!';
	            			alert(terr);
	            			return;
	            		}
	            	}
            	}
            	
            	Lock(1,{opacity:0});
            	$('#txtAcomp').val($('#cmbCno').find(":selected").text());
                $('#txtMon').val($.trim($('#txtMon').val()));
                if(r_len==3 && $('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
                    return;
                }else if(r_len==4 && $('#txtMon').val().length > 0 && !(/^[0-9]{4}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
                    return;
                }
                
                if(dec($('#txtFloata').val())!=0 && emp($('#cmbCoin').val())){
					alert(q_getMsg('lblCoin')+'不可空白。');   
					Unlock(1);
					return;
				}
                
                for (var i = 0; i < q_bbsCount; i++) {
                	 if ($('#txtIndate_'+i).val().length > 0 && $('#txtIndate_'+i).val().indexOf('_')>-1) {
                    	alert(q_getMsg('lblIndate') + '錯誤。');
                    	Unlock(1);
                    	return;
                	}
                }
                
                $('#txtDatea').val(trim($('#txtDatea').val()));
                
                var t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtDatea', q_getMsg('lblDatea')]]);
                // 檢查空白
                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock(1);
                    return;
                }



                if(q_cur==2 && !emp(t_predate)){
                	//106/01/16取修改前日期與修改後日期比對年度，不一樣不存檔避免年度傳票被覆蓋
                    if(r_len==3){
					    var t_ypdate=t_predate.substr(0,r_len);
                	    var t_ydate=$('#txtDatea').val().substr(0,r_len);
                        if (t_ypdate != t_ydate) {
                            if(confirm(q_getMsg('lblDatea') + '日期跨年度修正，請問是否修正。')){
                                alert("確定修改!!");
                            } else {
                                alert("取消");
                                btnCancel();
                            }
                	    }
                    } else if (r_len == 4) {
					    var t_ypdate=dec(t_predate.substr(0,r_len))+1911;
                        var t_ydate = $('#txtDatea').val().substr(0, r_len);
                        if (t_ypdate != t_ydate) {
                            if(confirm(q_getMsg('lblDatea') + '日期跨年度修正，請問是否修正。')){
                                alert("確定修改!!");
                            } else {
                                alert("取消");
                                btnCancel();
                            }
                		    //alert(q_getMsg('lblDatea') + '日期禁止跨年度修正。');
                		    //Unlock(1);
                    	    //return;
                        }       
				    }
                }
				/*if(q_cur==2 && !emp(t_predate)){
                	//106/01/16取修改前日期與修改後日期比對年度，不一樣不存檔避免年度傳票被覆蓋
                	var t_ypdate=t_predate.substr(0,r_len);
                	var t_ydate=$('#txtDatea').val().substr(0,r_len);
                	
                	if (t_ypdate!=t_ydate){
                		alert(q_getMsg('lblDatea') + '日期禁止跨年度修正。');
                		Unlock(1);
                    	return;
                	}
                }*/
                
               /*if ($.trim($('#txtCustno').val()) == 0) {
                    alert(m_empty + q_getMsg('lblCust'));
                    Unlock(1);
                    return false;
                }*/
                var t_money = 0, t_chgs = 0, t_paysale, t_mon = '';
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#txtCheckno_'+i).val($.trim($('#txtCheckno_'+i).val()));
                	
                    t_money = emp($('#cmbCoin').val())?q_float('txtMoney_' + i):q_float('txtMoneyus_' + i);
                    //104/04/29費用不算在收款金額//0601恢復並改為-
                    t_chgs = q_float('txtChgs_' + i);
                    if ($.trim($('#txtAcc1_' + i).val()).length == 0 && t_money - t_chgs > 0) {
                        t_err = true;
                        break;
                    }
                    if (t_money != 0 || i == 0)
                        t_mon = $('#txtVccno_' + i).val();
                }
                
                sum();
                
                if (t_err) {
                    alert(m_empty + q_getMsg('lblAcc1') + q_trv(t_money - t_chgs));
                    Unlock(1);
                    return false;
                }
                
                t_money=0,t_chgs=0;
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#txtCheckno_'+i).val($.trim($('#txtCheckno_'+i).val()));
                	
                    t_money += emp($('#cmbCoin').val())?q_float('txtMoney_' + i):q_float('txtMoneyus_' + i);
                    //104/04/29費用不算在收款金額//0601恢復並改為-
                   t_chgs += q_float('txtChgs_' + i);
                }
                
                for (var i = 0; i < q_bbsCount; i++) {
                	if (emp($('#txtTablea_'+i).val())&&!emp($('#txtVccno_'+i).val())){
                		if(q_getPara('sys.project').toUpperCase()=='XY'){
                			$('#txtTablea_'+i).val('vcc_xy');
                		}else if(q_getPara('sys.project').toUpperCase()=='RB'){
                			$('#txtTablea_'+i).val('vcc_rb');
                		}else if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1){
							$('#txtTablea_'+i).val('vcc_it');
						}else if(q_getPara('sys.project').toUpperCase()=='YC'){
							$('#txtTablea_'+i).val('vcc_yc');
                    	}else if(q_getPara('sys.comp').indexOf('永勝')>-1){
							$('#txtTablea_'+i).val('vcc_uu');
                    	}else if (q_getPara('sys.comp').indexOf('楊家') > -1|| q_getPara('sys.comp').indexOf('德芳') > -1){
							$('#txtTablea_'+i).val('vcc_tn');
						}else{
							if(q_getPara('sys.steel')=='1'){//鋼鐵業
								$('#txtTablea_'+i).val('vccst');
							}else{
								$('#txtTablea_'+i).val('vcc');
							}
                    	}
                	}
                	
                	//105/02/04 避免 bbs表身顯示錯誤重算unpay 欄位
					var t_unpay = dec($('#txtUnpayorg_' + i).val()) - dec($('#txtPaysale_' + i).val());
					q_tr('txtUnpay_' + i, t_unpay);
                }
                
                if (emp($('#txtCustno').val()) && q_float('txtOpay')>0) {
                    alert('有預收金額客戶名稱不能空白!!');
                    Unlock(1);
                    return false;
                }
				
                var t_opay = q_float('txtOpay');
                var t_unopay = q_float('txtUnopay');
                var t1 = q_sub(q_add(q_float('txtPaysale'),q_float('txtOpay')), q_float('txtUnopay'));
                var t2 = q_sub(t_money,t_chgs);
                if (t1 != t2) {
                    alert('收款金額  － 費用 ＝' + q_trv(t2) + '\r 【不等於】 沖帳金額 ＋ 預收 －　預收沖帳 ＝' + q_trv(t1) + '\r【差額】=' + Math.abs(t1 - t2));
                   	Unlock(1);
                    return false;
                }
                //先檢查BBS沒問題才存檔      
                checkGqb_bbs(q_bbsCount-1);
            }
			function checkGqb_bbs(n){
            	if(n<0){
            		for (var i = 0; i < q_bbsCount; i++) {
			            $('#txtPart_' + i).val($('#cmbPartno_' + i).find(":selected").text());
			        }
			        //為了查詢
	            	var t_part = '',t_checkno = '';
	            	for (var i = 0; i < q_bbsCount; i++) {
	            		if(t_part.indexOf($.trim($('#txtPart_'+i).val()))==-1)
	            			t_part += (t_part.length>0?',':'') + $.trim($('#txtPart_'+i).val());
	            		if($.trim($('#txtCheckno_'+i).val()).length>0 && t_checkno.indexOf($.trim($('#txtCheckno_'+i).val()))==-1)
	            			t_checkno += (t_checkno.length>0?',':'') + $.trim($('#txtCheckno_'+i).val());
	            	}
	            	$('#txtPart').val(t_part);
	            	$('#txtCheckno').val(t_checkno);
            		if(q_cur ==1){
		            	$('#txtWorker').val(r_name);
		            }else if(q_cur ==2){
		            	$('#txtWorker2').val(r_name);
		            }else{
		            	alert("error: btnok!")
		            }
            		var t_noa = trim($('#txtNoa').val());
	                var t_date = trim($('#txtDatea').val());
	                if (t_noa.length == 0 || t_noa == "AUTO")
	                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_umm') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
	                else
	                    wrServer(t_noa);
            	}else{
            		if($.trim($('#txtCheckno_'+n).val()).length>0 
            		&& $('#txtAcc1_'+n).val().substring(0,4)==(q_getPara('sys.project').toUpperCase()=='YC'?'1141':'1121')&& q_float('txtMoney_'+n)<0){
            			//收退  ,1121 , 金額負
            			checkGqb_bbs(n-1);
            		}else if($.trim($('#txtCheckno_'+n).val()).length>0){
            			var t_noa = $('#txtNoa').val();
	    				var t_checkno = $('#txtCheckno_'+n).val() ;   	
	        			var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
	        			q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_btnOkbbs1_"+n+"_"+t_checkno+"_"+ t_noa, r_accy);
            		}else{
            			checkGqb_bbs(n-1);
            		}
            	}
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('umm_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_'+i).text(i+1);	
                    if ($('#btnMinus_' + i).hasClass('isAssign'))/// 重要
                        continue;
                    $('#txtAcc1_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAcc_'+n).click();
                    }).change(function() {
                    	var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    	if($(this).val()=="=" && n>0){
                    		$('#txtAcc1_'+n).val($('#txtAcc1_'+(dec(n)-1)).val());
                    		$('#txtAcc2_'+n).val($('#txtAcc2_'+(dec(n)-1)).val());
                    	}
                    	
                        var patt = /^(\d{4})([^\.,.]*)$/g;
	                    $(this).val($(this).val().replace(patt,"$1.$2"));
                        sum();
                    });
                    
                    $('#txtBankno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnBank_'+n).click();
                    });
                    
                    $('#txtVccno_'+i).bind('contextmenu',function(e) {
                    	/*滑鼠右鍵*/
                    	e.preventDefault();
                    	var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    	var t_accy = $('#txtAccy_'+n).val();
                    	var t_tablea = $('#txtTablea_'+n).val();
                    	if(t_tablea.length>0 && $(this).val().indexOf('TAX')==-1 && !($(this).val().indexOf('-')>-1 && $(this).val().indexOf('/')>-1)){//稅額和月結排除
                    		//t_tablea = t_tablea + q_getPara('sys.project');
                    		//q_box(t_tablea+".aspx?;;;noa='" + $(this).val() + "'", t_tablea, "95%", "95%", q_getMsg("pop"+t_tablea));	
                    		q_box(t_tablea+".aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + t_accy, t_tablea, "95%", "95%", q_getMsg("pop"+t_tablea));
                    	}
                    }).change(function() {
                    	var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                    	if(emp($('#txtVccno_'+n).val())){
                    		//資料清空
                    		$('#txtMemo2_'+n).val('');
                    		$('#txtCno_'+n).val('');
                    		$('#txtVccno_'+n).val('');
                    		$('#txtAccy_'+n).val('');
                    		$('#txtTablea_'+n).val('');
                    		$('#textTypea_'+n).val('');
                    		$('#txtCustno_'+n).val('');
                    		$('#txtPaymon_'+n).val('');
                    		$('#txtPaysale_'+n).val('');
                    		$('#txtUnpayorg_'+n).val('');
                    		$('#txtUnpay_'+n).val('');
                    	}else{
                    		var t_where = "where=^^ noa='"+$('#txtVccno_'+n).val()+"' ^^";
	            			q_gt('view_vcc', t_where, 0, 0, 0, "vccnocheck_"+n, r_accy);
                    	}
					});
					
                    $('#txtMoney_' + i).change(function(e) {
                    	var n = $(this).attr('id').split('_')[1];
                        sum();
                        
                        //106/03/28不換算外幣金額
                        /*if(dec($('#txtFloata').val())!=0){
		                	$('#txtMoneyus_'+n).val(round(q_div(dec($(this).val()),dec($('#txtFloata').val())),5));
		                }else{
		                	$('#txtMoneyus_'+n).val(0);
		                }*/
                    });
                    $('#txtChgs_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtCheckno_'+i).change(function(){
        				Lock(1,{opacity:0});
        				var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
        				var t_noa = $('#txtNoa').val();
        				var t_checkno = $('#txtCheckno_'+n).val() ;
            			var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
            			if($.trim($('#txtCheckno_'+n).val()).length>0 && $('#txtAcc1_'+n).val().substring(0,4)==(q_getPara('sys.project').toUpperCase()=='YC'?'1141':'1121') && q_float('txtMoney_'+n)<0){
	            			//收退  ,1121 , 金額負
	            			Unlock(1);
	            		}else if($.trim($('#txtCheckno_'+n).val()).length>0){
	            			q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_change1_"+n+"_"+t_checkno+"_"+ t_noa, r_accy);
            			}else{
            				Unlock(1);
            			}
            		}).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        var t_checkno = $.trim($(this).val());
                        if (t_checkno.length > 0) {
                            q_box("gqb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";gqbno='" + t_checkno + "';" + r_accy, 'gqb', "95%", "95%", q_getMsg("popGqb"));
                        }
                    });
            		$('#txtPaysale_' + i).change(function(e) {
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        var t_unpay = dec($('#txtUnpayorg_' + n).val()) - dec($('#txtPaysale_' + n).val());
                        q_tr('txtUnpay_' + n, t_unpay);
                        sum();
                    });
                    
                    $('#btnMinus_' + i).bind('contextmenu', function (e) {
						e.preventDefault();

						mouse_div = false;
						////////////控制顯示位置
						$('#div_row').css('top', e.pageY);
						$('#div_row').css('left', e.pageX);
						////////////
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						$('#div_row').show();
						row_b_seq = b_seq;
						row_bbsbbt = 'bbs';
					});
                }
                _bbsAssign();
                
                for (var i = 0; i < q_bbsCount; i++) {
                	if(emp($('#txtVccno_'+i).val()))
                		$('#txtVccno_'+i).css('color','black').css('background','white').removeAttr('readonly');
                	else
                		$('#txtVccno_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
                }
                $('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
                UsShow();
            }

            function btnIns() {
                _btnIns();
                $('#txtDatea').focus();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                
                $('#cmbCno').val(z_cno);
                $('#txtAcomp').val(z_acomp);
                UsShow();
            }
			
			var t_predate='';
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                if (q_chkClose())
             		return;
             	t_predate=$('#txtDatea').val();
				Lock(1,{opacity:0});
				checkGqbStatus_btnModi(q_bbsCount-1);
            }
            
            function checkGqbStatus_btnModi(n){
            	if(n<0){
            		 _btnModi();
            		 UsShow();
               	     $('#textOpayOrg').val(q_float('textOpay') + q_float('txtUnopay') - q_float('txtOpay'));
            		Unlock(1);
            	}else{
            		var t_checkno = $.trim($('#txtCheckno_'+n).val());
            		if(t_checkno.length>0){
            			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            			q_gt('chk2s', t_where, 0, 0, 0, "gqb_status1_"+n+"_"+t_checkno, r_accy);
            		}else{
            			checkGqbStatus_btnModi(n-1)
            		}
            	}
            }
            function checkGqbStatus_btnDele(n){
            	if(n<0){
            		 _btnDele();
            		Unlock(1);
            	}else{
            		var t_checkno = $.trim($('#txtCheckno_'+n).val());
            		if(t_checkno.length>0){
            			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            			q_gt('chk2s', t_where, 0, 0, 0, "gqb_statusA_"+n+"_"+t_checkno, r_accy);
            		}else{
            			checkGqbStatus_btnDele(n-1)
            		}
            	}
            }

            function btnPrint() {
                q_box("z_ummp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'umm', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['acc1'] && (!as['money'] || parseFloat(as['money']) == 0) && (!as['paysale'] || parseFloat(as['paysale']) == 0)) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['mon'] = abbm2['mon'];
            	as['datea'] = abbm2['datea'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                 if(q_cur==1 || q_cur==2){
		        	$("#btnVcc").removeAttr("disabled");
		        	$("#btnMon").removeAttr("disabled");
		        	$("#btnAuto").removeAttr("disabled");
		        }else{
		        	$("#btnVcc").attr("disabled","disabled");
		        	$("#btnMon").attr("disabled","disabled");
		        	$("#btnAuto").attr("disabled","disabled");
		        }
                getOpay();
                UsShow();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
		            $('#div_row').hide();
		        }
                if(q_cur==1 || q_cur==2){
		        	$("#btnVcc").removeAttr("disabled");
		        	$("#btnMon").removeAttr("disabled");
		        	$("#btnAuto").removeAttr("disabled");
		        }else{
		        	$("#btnVcc").attr("disabled","disabled");
		        	$("#btnMon").attr("disabled","disabled");
		        	$("#btnAuto").attr("disabled","disabled");
		        }
		        /*if(q_cur==1){
		        	$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
		        }else{
		        	$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
		        }*/
		        
				if(q_cur==2){
					for (var i = 0; i < q_bbsCount; i++) {
						if(emp($('#txtVccno_'+i).val()))
							$('#txtVccno_'+i).css('color','black').css('background','white').removeAttr('readonly');
                 		else
                 			$('#txtVccno_'+i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
					}
		        }
		        UsShow();
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
            	if (q_chkClose())
             		    return;
            	Lock(1,{opacity:0});
            	checkGqbStatus_btnDele(q_bbsCount-1);
            }

            function btnCancel() {
                _btnCancel();
            }
            
            function q_popPost(s1) {
			   	switch (s1) {
			        case 'txtVccno_':
			   			break;
			   		case 'txtCustno':
                    	getOpay();
			        	break;
			   	}
			}
			
			function UsShow(){
		    	if(!emp($('#cmbCoin').val())){
		    		$('.Usdata').show();
		    	}else{
		    		$('.Usdata').hide();
		    	}
		    }
			
            function tipShow(){
				Lock(1);
				tipInit();
				var t_set = $('body');
				t_set.find('.tip').eq(0).show();//tipClose
				for(var i=1;i<t_set.data('tip').length;i++){
					index = t_set.data('tip')[i].index;
					obj = t_set.data('tip')[i].ref;
					msg = t_set.data('tip')[i].msg;
					shiftX = t_set.data('tip')[i].shiftX;
					shiftY = t_set.data('tip')[i].shiftY;
					if(obj.is(":visible")){
						t_set.find('.tip').eq(index).show().offset({top:round(obj.offset().top+shiftY,0),left:round(obj.offset().left+obj.width()+shiftX,0)}).html(msg);
					}else{
						t_set.find('.tip').eq(index).hide();
					}
				}
			}
			function tipInit(){
				tip($('#txtMon'),'<a style="color:red;font-size:16px;font-weight:bold;width:250px;display:block;">*匯入資料前需注意【帳款月份】有無輸入正確。</a>',-20,-10);
				tip($('#btnVcc'),'<a style="color:red;font-size:16px;font-weight:bold;width:300px;display:block;">*【出貨單匯入】、【月結匯入】只能擇一輸入。</a>',-50,30);
				tip($('#txtOpay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑本次預收金額。</a>',-100,30);
				tip($('#txtUnopay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑若使用預收金額來沖帳，則在此填入金額。</a>',-100,30);
				tip($('#textOpay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑累計預收金額。</a>',-100,30);
				tip($('#btnAuto'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑自動填入沖帳金額。</a>',-100,30);
				tip($('#txtAcc2_0'),'<a style="color:red;font-size:16px;font-weight:bold;width:200px;display:block;">若要退票，則會計科目輸入 1121. 應收票據，收款金額輸入負數。</a>',-100,30);
				/*if (q_getPara('sys.project').toUpperCase()=='GU' || q_getPara('sys.project').toUpperCase()=='FP' ){
					tip($('#txtMon'),'<a style="color:red;font-size:16px;font-weight:bold;width:250px;display:block;">*匯入資料前需注意【帳款月份】有無輸入正確。</a>',-20,-10);
					tip($('#btnVcc'),'<a style="color:red;font-size:16px;font-weight:bold;width:300px;display:block;">*【出貨單匯入】、【月結匯入】只能擇一輸入。</a>',-50,30);
					tip($('#txtOpay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑本次預收金額。</a>',-100,30);
					tip($('#txtUnopay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑若使用預收金額來沖帳，則在此填入金額。</a>',-100,30);
					tip($('#textOpay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑累計預收金額。</a>',-100,30);
					tip($('#btnAuto'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑自動填入沖帳金額。</a>',-100,30);
					tip($('#txtAcc2_0'),'<a style="color:red;font-size:16px;font-weight:bold;width:200px;display:block;">若要退票，則會計科目輸入 1121. 應收票據，收款金額輸入負數。</a>',-100,30);
				}else{
					tip($('#txtMon'),'<a style="color:red;font-size:16px;font-weight:bold;width:250px;display:block;">匯入資料前需注意【'+q_getMsg('lblMon')+'】有無輸入正確。</a>',-20,-10);
					tip($('#btnVcc'),'<a style="color:red;font-size:16px;font-weight:bold;width:300px;display:block;">【'+q_getMsg('btnVcc')+'】、【'+q_getMsg('btnMon')+'】只能擇一輸入。</a>',-50,30);
					tip($('#txtOpay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑本次預收金額。</a>',-100,30);
					tip($('#txtUnopay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑若使用預收金額來沖帳，則在此填入金額。</a>',-100,30);
					tip($('#textOpay'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑累計預收金額。</a>',-100,30);
					tip($('#btnAuto'),'<a style="color:red;font-size:16px;font-weight:bold;width:150px;display:block;">↑自動填入沖帳金額。</a>',-100,30);
					tip($('#txtAcc2_0'),'<a style="color:red;font-size:16px;font-weight:bold;width:200px;display:block;">若要退票，則會計科目輸入 1121. 應收票據，收款金額輸入負數。</a>',-100,30);
				}*/

			}
			function tip(obj,msg,x,y){
				x = x==undefined?0:x;
				y = y==undefined?0:y;
				var t_set = $('body');
				if($('#tipClose').length==0){
					//顯示位置在btnTip上
					t_set.data('tip',new Array());
					t_set.append('<input type="button" id="tipClose" class="tip" value="關閉"/>');
					$('#tipClose')
					.css('position','absolute')
					.css('z-index','1001')
					.css('color','red')
					.css('font-size','18px')
					.css('display','none')
					.click(function(e){
						$('body').find('.tip').css('display','none');
						Unlock(1);
					});
					$('#tipClose').offset({top:round($('#btnTip').offset().top-2,0),left:round($('#btnTip').offset().left-15,0)});
					t_set.data('tip').push({index:0,ref:$('#tipClose')});
				}
				if(obj.data('tip')==undefined){
					t_index = t_set.find('.tip').length;
					obj.data('tip',t_index);
					t_set.append('<div class="tip" style="position: absolute;z-index:1000;display:none;"> </div>');
					t_set.data('tip').push({index:t_index,ref:obj,msg:msg,shiftX:x,shiftY:y});
				}			
			}
			
			var mouse_div = true; //控制滑鼠消失div
		    var row_bbsbbt = ''; //判斷是bbs或bbt增加欄位
		    var row_b_seq = ''; //判斷第幾個row
		    //插入欄位
		    function q_bbs_addrow(bbsbbt, row, topdown) {
		        //取得目前行
		        var rows_b_seq = dec(row) + dec(topdown);
		        if (bbsbbt == 'bbs') {
		            q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
		            //目前行的資料往下移動
		            for (var i = q_bbsCount - 1; i >= rows_b_seq; i--) {
		                for (var j = 0; j < fbbs.length; j++) {
		                    if (i != rows_b_seq)
		                        $('#' + fbbs[j] + '_' + i).val($('#' + fbbs[j] + '_' + (i - 1)).val());
		                    else
		                        $('#' + fbbs[j] + '_' + i).val('');
		                }
		            }
		        }
		        if (bbsbbt == 'bbt') {
		            q_gridAddRow(bbtHtm, 'tbbt', fbbt, 1, '', '', '', '__');
		            //目前行的資料往下移動
		            for (var i = q_bbtCount - 1; i >= rows_b_seq; i--) {
		                for (var j = 0; j < fbbt.length; j++) {
		                    if (i != rows_b_seq)
		                        $('#' + fbbt[j] + '__' + i).val($('#' + fbbt[j] + '__' + (i - 1)).val());
		                    else
		                        $('#' + fbbt[j] + '__' + i).val('');
		                }
		            }
		        }
		        $('#div_row').hide();
		        row_bbsbbt = '';
		        row_b_seq = '';
		    }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 25%;
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
                width: 75%;
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
                /*width: 10%;*/
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
                color: #4295D7;
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
            
            #div_row{
				display:none;
				width:750px;
				background-color: #ffffff;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();" >
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row"  class="table_row" style="width:100%;" border="1" cellpadding='1'  cellspacing='0'>
				<tr>
					<td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
				</tr>
				<tr>
					<td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1260px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:30%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:30%"><a id='vewComp'> </a></td>
						<td align="center" style="width:30%"><a id='vewTotal'> </a></td>
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
					<tr style="height:1px;">
						<td style="width: 95px;"> </td>
						<td style="width: 120px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 95px;"> </td>
						<td style="width: 120px;"> </td>
						<td style="width: 120px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 30px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtPart" type="text" style="display:none;"/>
							<input id="txtCheckno" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPayc' class="lbl btn"> </a></td>
						<td><input id="txtPayc"  type="text" class="txt c1"/></td>
						<td class="tdZ"><input type="button" id="btnTip" value="?" style="float:right;" onclick="tipShow()"/></td>
					</tr>
					<tr class="tr2">
						<td><span> </span><a id='lblAcomp' class="lbl"> </a></td>
						<td>
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text" style="display:none;"/>
						</td>
						<td class="td3"><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td class="td4" colspan="2">
						<input id="txtCustno" type="text" class="txt" style="float:left;width:40%;"/>
						<input id="txtComp"  type="text" class="txt" style="float:left;width:60%;"/>
						</td>
						<td colspan="2">
							<input type="button" id="btnVcc" class="txt c1 " style="width: 95px;"/>
							<input type="button" id="btnMon" class="txt c1 " style="width: 95px;"/>
						<span> </span><a id='lblCust2' class="lbl btn"> </a></td>
						<td><input id="txtCustno2" type="text" class="txt c1" title='多客戶使用"逗號"分隔'/></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblSale' class="lbl"> </a></td>
						<td class="td2"><input id="txtSale"  type="text" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td class="td4"><input id="txtTotal" type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblPaysale' class="lbl"> </a></td>
						<td class="td6"><input id="txtPaysale"  type="text" class="txt num c1"/></td>
						<td class="td7"><span> </span><a id='lblUnpay' class="lbl"> </a></td>
						<td class="td8"><input id="txtUnpay"  type="text" class="txt num c1"/></td>
					</tr> 
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblOpay' class="lbl"> </a></td>
						<td class="td2"><input id="txtOpay"  type="text" class="txt num c1"/></td>
							<td class="td3"><span> </span><a id='lblUnopay' class="lbl"> </a></td>
							<td class="td4">
							<input id="txtUnopay"  type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblTextopay' class="lbl"> </a></td>
						<td class="td6">
							<input id="textOpay"  type="text" class="txt num c1"/>
							<input type='hidden' id="textOpayOrg" />
						</td>
						<td><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3" rowspan="2" ><textarea id="txtMemo"  rows='3' cols='3' style="width: 100%; " > </textarea></td>
						<td> </td>
						<td><input type="button" id="btnAuto" class="txt c1 "  style="color:red"/> </td>
						<td> </td>
						<td><input type="button" id="btnBank" class="txt c1 "/></td>
					</tr>
					<tr>
						<td> </td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
					<tr style="display: none;" class="isAcccUs">
						<td><span> </span><a id='lblCoin' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1"> </select></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><input id="txtFloata" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblEcacc1' class="lbl"> </a></td>
						<td>
							<input type="text" id="txtEcacc1"  style="width:49%; float:left;"/>
							<input type="text" id="txtEcacc2"  style="width:49%; float:left;"/>
						</td>
						<td><span> </span><a id='lblEcmoney' class="lbl"> </a></td>
						<td><input id="txtEcmoney" type="text" class="txt num c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1600px;">
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:1%;"> </td>
					<td align="center" style="width:7%;"><a id='lblAcc1'> </a><br/><a id='lblAcc2'> </a></td>
					<td align="center" style="width:15%;"><a id='lblMoney'> </a><br/><a id='lblAccmemo'> </a><br class="Usdata" style="display:none;"><a class="Usdata" id='lblMoneyuss' style="display:none;"> </a></td>
					<td align="center" style="width:7%;"><a id='lblCheckno'> </a><br/><a id='lblGqbtitle'> </a></td>
					<td align="center" style="width:7%;"><a id='lblAccount'> </a></td>
					<td align="center" style="width:6%;"><a id='lblBankno'> </a><br/><a id='lblBank'> </a></td>
					<td align="center" style="width:4%;"><a id='lblIndate'> </a></td>
					<td align="center" style="width:5%;"><a id='lblChgsTran'> </a><br/><a id='lblParts'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMemos'> </a></td>
					<td align="center" style="width:5%;"><a id='lblPaysales'> </a></td>
					<td align="center" style="width:5%;"><a id='lblUnpay_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblCoins'> </a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<select id="combAcc1.*" style="display:none;width:95%;float:left;"> </select>
                        <input type="text" id="txtAcc1.*"  style="width:95%; float:left;" title="點擊滑鼠右鍵，列出明細。"/>
						<input type="text" id="txtAcc2.*"  style="width:95%; float:left;"/>
						<input type="button" id="btnAcc.*" style="display:none;" />
					</td>
					<td>
						<input type="text" id="txtMoney.*" style="text-align:right;width:95%;"/>
						<input type="text" id="txtMemo.*" style="width:95%;"/>
						<input type="text" id="txtMoneyus.*" class="Usdata" style="display:none;text-align:right;width:95%;"/>
					</td>
					<td>
						<input type="text" id="txtCheckno.*"  style="width:95%;" />
						<input type="text" id="txtTitle.*" style="width:95%;" />
					</td>
					<td><input type="text" id="txtAccount.*"  style="width:95%;" /></td>
					<td>
                        <input type="text" id="txtBankno.*"  style="width:95%; float:left;" title="點擊滑鼠右鍵，列出明細。"/>
						<input type="text" id="txtBank.*"  style="width:95%; float:left;"/>
						<input type="button" id="btnBank.*"  style=" display:none;"/>
					</td>
					<td><input type="text" id="txtIndate.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtChgs.*" style="text-align:right;width:95%;"/>
						<select id="cmbPartno.*"  style="float:left;width:95%;" > </select>
						<input type="text" id="txtPart.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtMemo2.*" style="width:60%;float:left;"/>
						<input type="text" id="txtCno.*" style="width:30%;float:left;"/>
						<input type="text" id="txtVccno.*" style="width:95%;" title="點擊滑鼠右鍵，瀏覽單據內容。" />
						<input type="text" id="txtAccy.*" style="display:none;" />
						<input type="text" id="txtTablea.*" style="display:none;" />
						<input type="text" id="textTypea.*" style="display:none;" />
						<input type="text" id="txtCustno.*" style="display:none;"/>
						<input type="text" id="txtPaymon.*" style="display:none;" />
					</td>
					<td>
						<input type="text" id="txtPaysale.*" style="text-align:right;width:95%;"/>
						<input type="text" id="txtUnpayorg.*" style="text-align:right;width:95%;"/>
					</td>
					<td>
						<input type="text" id="txtUnpay.*"  style="width:95%; text-align: right;" />
						<input type="text" id="txtPart2.*"  style="float:left;width: 95%;"/>
					</td>
					<td><input type="text" id="txtCoin.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
