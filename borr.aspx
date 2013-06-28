<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;

            q_tables = 't';
            var q_name = "borr";
            var q_readonly = ['txtNoa', 'txtCash', 'txtChecka', 'txtVccno', 'txtMoney', 'txtInterest', 'txtTotal', 'txtPay', 'txtUnpay', 'txtWorker', 'txtWorker2', 'txtAccno'];
            var q_readonlys = ['txtUmmno', 'txtVccno', 'txtAccno'];
            var q_readonlyt = ['txtVccno', 'txtAccno'];
            var bbmNum = [['textMoney', 10, 0, 1],['txtCash', 10, 0], ['txtFixmoney', 10, 0], ['txtChecka', 10, 0], ['txtMoney', 10, 0], ['txtInterest', 10, 0], ['txtTotal', 10, 0], ['txtPay', 10, 0], ['txtUnpay', 10, 0]];
            var bbsNum = [['txtMoney', 10, 0, 1], ['txtInterest', 10, 0, 1]];
            var bbtNum = [['txtMoney', 10, 0, 1]];
            var bbmMask = [['txtDatea', '999/99/99'], ['txtBegindate', '999/99/99'], ['txtEnddate', '999/99/99'], ['textMon_windows', '999/99']];
            var bbsMask = [['txtDatea', '999/99/99'], ['txtIndate', '999/99/99']];
            var bbtMask = [['txtMon', '999/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 20;

            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtCust,txtCustnick', 'cust_b.aspx'],['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'], ['txtBankno_', '', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'], ['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtAcc1_', '', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#txtBegindate').datepicker();
                $('#txtEnddate').datepicker();
                q_cmbParse("cmbTypea", q_getPara('borr.typea'), 's');

                $("#txtBegindate").change(function() {
                    calcDay();
                });
                $("#txtEnddate").change(function() {
                    calcDay();
                });
                $("#txtCash").change(function() {
                    sum();
                });
                $("#txtChecka").change(function() {
                    sum();
                });
                $("#txtRate").change(function() {
                    sum();
                });
                $('#lblVccno').click(function() {
                    browTicketForm($(this).get(0));
                });

                $('#lblAccno').click(function() {
                    browTicketForm($(this).get(0));
                });
                $('#btnInterest').click(function() {
                    $('#InterestWindows').toggle();
                });
                $('#btnCloseWindows').click(function() {
                    $('#InterestWindows').toggle();
                });
                $('#btnProcessInterest').click(function() {
                    var P_Mon = $('#textMon_windows').val();
                    if (P_Mon.length != 0) {
                        $('#btnProcessInterest').attr('disabled', 'disabled');
                        Lock();
                        q_func('dayborr.process', P_Mon);
                    } else {
                        alert('請輸入' + q_getMsg('lblMon_windows'));
                    }
                });
                $('#btnSplit').click(function(e){
                	if(!(q_cur==1 || q_cur==2))
                		return;
                	var t_money = q_float('txtMoney_0');
                	var t_mm = q_float('textMoney');
                	var strday = parseInt($('#txtVccday').val().length==0?'0':$('#txtVccday').val());
                	if(t_money<=0){
                		alert('請輸入借出金額。');
                		return;
                	}
                	if(t_mm<=0){
                		alert('請輸入每月還本金額。');
                		return;
                	}
                	if(strday<=0 || strday>31){
                		alert('請輸入起算日。');
                		return;
                	}
                	var t_unpay = t_money;
                	var t_rate = q_float('txtRate');
                	var t_ratemon = q_float('txtRatemon');
                	var t_fixmoney = q_float('txtFixmoney');
                	
                	var t_date1 = $('#txtDatea_0').val(),t_date2,t_days;
                	
                	for(var i=1;i<q_bbsCount;i++)
                		$('#btnMinus_'+i).click();
                	for(var i=0,n=1;t_unpay>0;i++,n++){
                		if(i>120){
                			break;
                		}
                		if(i==0){
                			t_date1 = new Date(parseInt(t_date1.substr(0, 3)) + 1911, parseInt(t_date1.substring(4, 6)) - 1, parseInt(t_date1.substring(7, 9)));
                		}else{
                			t_date1 = new Date(t_date2.getTime() + 60*60*24*1000);
                		}
                		if(t_date1.getDate()>(strday-1)){
                			t_date2 = getNextMonth(t_date1.getFullYear(),t_date1.getMonth());
                			t_date2 = getLastDate(t_date2.getFullYear(),t_date2.getMonth());
                		}else{
                			t_date2 = getLastDate(t_date1.getFullYear(),t_date1.getMonth());
                		}
                		if(t_date2.getDate()>=(strday-1))
                			t_date2.setDate(strday-1);	
                			
                		t_days = Math.abs(t_date2 - t_date1) / (1000 * 60 * 60 * 24) + 1;
                		if(q_bbsCount<=n)
                			$('#btnPlus').click(); 
                		$('#cmbTypea_'+n).val(2);	        
                		$('#txtMemo_'+n).val((t_date1.getFullYear()-1911)+'/'+(t_date1.getMonth()+1)+'/'+t_date1.getDate()+'~'+(t_date2.getFullYear()-1911)+'/'+(t_date2.getMonth()+1)+'/'+t_date2.getDate());
                		$('#txtMoney_'+n).val(FormatNumber(t_unpay>=t_mm?t_mm:t_unpay));  
                		if(t_rate!=0){
                			$('#txtInterest_'+n).val(FormatNumber(t_unpay.mul(t_days).mul(t_rate).div(100).round(0))); 
                			$('#txtMemo_'+n).val($('#txtMemo_'+n).val()+'  '+t_unpay+'*'+t_rate+'*'+t_days+'/100');
                		} 
                		else if(t_ratemon!=0){
                			$('#txtInterest_'+n).val(FormatNumber(t_unpay.mul(t_days).mul(t_ratemon).div(30).div(100).round(0)));
                			$('#txtMemo_'+n).val($('#txtMemo_'+n).val()+'  '+t_unpay+'*'+t_ratemon+'*'+t_days+'/30/100');
                		}
                		else
                			$('#txtInterest_'+n).val(t_fixmoney);
                		t_unpay-= t_mm;	
                	}
                	sum();
                });
            }
            var checkenda=false;
		var holiday;//存放holiday的資料
		function endacheck(x_datea,x_day) {
			//102/06/21 7月份開始資料3日後不能在處理
			var t_date=x_datea,t_day=1;
                
			while(t_day<x_day){
				var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
				nextdate.setDate(nextdate.getDate() +1)
				t_date=''+(nextdate.getFullYear()-1911)+'/';
				//月份
				t_date=t_date+((nextdate.getMonth()+1)<10?('0'+(nextdate.getMonth()+1)+'/'):((nextdate.getMonth()+1)+'/'));
				//日期
				t_date=t_date+(nextdate.getDate()<10?('0'+(nextdate.getDate())):(nextdate.getDate()));
	                	
				//六日跳過
				if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0 //日
				||new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6 //六
				){continue;}
	                	
				//假日跳過
				if(holiday){
					var isholiday=false;
					for(var i=0;i<holiday.length;i++){
						if(holiday[i].noa==t_date){
							isholiday=true;
							break;
						}
					}
					if(isholiday) continue;
				}
	                	
				t_day++;
			}
                
			if (t_date<q_date()){
				checkenda=true;
			}else{
				checkenda=false;
			}
		}
            function getNextMonth(year,mon){
            	t_date = new Date(year, mon, 25);
            	t_date = new Date(t_date.getTime()+ 10*(1000 * 60 * 60 * 24));
            	t_date.setDate(1);
            	return t_date;     	
            }
            function getLastDate(year,mon){
            	t_date = new Date(year, mon, 25);
            	t_date = new Date(t_date.getTime()+ 10*(1000 * 60 * 60 * 24));
            	t_date.setDate(1);
            	return new Date(t_date.getTime()-(1000 * 60 * 60 * 24));     	
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'dayborr.process':
                        alert('Done!'+result);
						Unlock();
                        $('#btnProcessInterest').removeAttr('disabled', 'disabled');
                        break;
                }
            }
            
            function browTicketForm(obj) {
            	//資料欄位名稱不可有'_'否則會有問題
                if (($(obj).attr('readonly') == 'readonly') || ($(obj).attr('id').substring(0, 3) == 'lbl')) {
                    if ($(obj).attr('id').substring(0, 3) == 'lbl')
                        obj = $('#txt' + $(obj).attr('id').substring(3));
                    var noa = $.trim($(obj).val());
                    var openName = $(obj).attr('id').split('_')[0].substring(3).toLowerCase();
					var isBbs = false,isBbt = false,n = -1;
					if($(obj).attr('id').indexOf('__')>0){
						isBbt = true;
						n = $(obj).attr('id').split('__')[1];
					}else if($(obj).attr('id').indexOf('_')>0){
						isBbs = true;
						n = $(obj).attr('id').split('_')[1];
					}
                    if (noa.length > 0) {
                        switch (openName) {
                            case 'vccno':                        
                                q_box("vcctran.aspx?;;;noa='" + noa + "';" + (isBbt?$('#txtMon__'+n).val().substring(0,3):(isBbs?$('#txtDatea_'+n).val().substring(0,3):$('#txtDatea').val().substring(0,3))), 'vcc', "95%", "95%", q_getMsg("popVcctran"));
                                break;
                            case 'accno':
                                q_box("accc.aspx?;;;accc3='" + noa + "';" + (isBbt?$('#txtMon__'+n).val().substring(0,3):(isBbs?$('#txtDatea_'+n).val().substring(0,3):$('#txtDatea').val().substring(0,3))) + "_1", 'accc', "95%", "95%", q_getMsg("popAccc"));
                                break;
                            case 'ummno':
                                q_box("ummtran.aspx?;;;noa='" + noa + "';" + r_accy, 'umm', "95%", "95%", q_getMsg("popUmmtran"));
                                break;
                            case 'checkno':
                                q_box("gqb.aspx?;;;gqbno='" + noa + "';" + r_accy, 'gqb', "95%", "95%", q_getMsg("popGqb"));
                                break;
                        }
                    }
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'holiday':
            				holiday = _q_appendData("holiday", "", true);
            				endacheck($('#txtDatea').val(),q_getPara('sys.modiday'));//單據日期,幾天後關帳
            			break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        if (t_name.substring(0, 13) == 'gqb_btnOkbbs1') {
                            //存檔時   bbs 支票號碼   先檢查view_gqb_chk,再檢查GQB
                            var t_sel = parseFloat(t_name.split('_')[2]);
                            var t_checkno = t_name.split('_')[3];
                            var t_noa = t_name.split('_')[4];
                            var t_ummno = t_name.split('_')[5];
                            var as = _q_appendData("view_gqb_chk", "", true);
                            if (as[0] != undefined) {
                                var t_isExist = false, t_msg = '';
                                for (var i in as) {
                                    if (as[i]['tablea'] != undefined) {
                                        t_isExist = true;
                                        if(as[i]['tablea']=='umms' && as[i]['noa']==t_ummno){
                                        	//忽略
                                        }else if (as[i]['noa'] != t_noa && !(as[i]['tablea']=='umms' && as[i]['acc1'].substring(0,4)=='1121' && as[i]['money'].substring(0,1)=='-')) {
                                            t_msg += (t_msg.length == 0 ? '票據已存在:' : '') + String.fromCharCode(13) + '【' + as[i]['title'] + as[i]['noa'] + '】' + as[i]['checkno'];
                                        }
                                    }
                                }
                                if (t_isExist && t_msg.length == 0) {
                                    checkGqb_bbs(t_sel - 1);
                                } else if (t_isExist && t_msg.length > 0) {
                                    alert('資料異常。' + String.fromCharCode(13) + t_msg);
                                    Unlock();
                                } else if (t_msg.length > 0) {
                                    alert(t_msg);
                                    Unlock();
                                } else {
                                    //檢查GQB
                                    var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
                                    q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbs2_" + t_sel, r_accy);
                                }
                            } else {
                                //檢查GQB
                                var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
                                q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbs2_" + t_sel, r_accy);
                            }
                        } else if (t_name.substring(0, 13) == 'gqb_btnOkbbs2') {
                            //存檔時   bbs 支票號碼檢查
                            //檢查GQB
                            var t_sel = parseFloat(t_name.split('_')[2]);
                            var as = _q_appendData("gqb", "", true);
                            if (as[0] != undefined) {
                                alert('支票【' + as[0]['gqbno'] + '】已存在');
                                Unlock();
                            } else {
                                checkGqb_bbs(t_sel - 1);
                            }
                        } else if (t_name.substring(0, 11) == 'gqb_change1') {
                            //先檢查view_gqb_chk,再檢查GQB
                            var t_sel = parseFloat(t_name.split('_')[2]);
                            var t_checkno = t_name.split('_')[3];
                            var t_noa = t_name.split('_')[4];
                            var t_ummno = t_name.split('_')[5];
                            var as = _q_appendData("view_gqb_chk", "", true);
                            if (as[0] != undefined) {
                                var t_isExist = false, t_msg = '';
                                for (var i in as) {
                                    if (as[i]['tablea'] != undefined) {
                                        t_isExist = true;
                                        if(as[i]['tablea']=='umms' && as[i]['noa']==t_ummno){
                                        	//忽略
                                        }else if (as[i]['noa'] != t_noa && !(as[i]['tablea']=='umms' && as[i]['acc1'].substring(0,4)=='1121' && as[i]['money'].substring(0,1)=='-')) {
                                            t_msg += (t_msg.length == 0 ? '票據已存在:' : '') + String.fromCharCode(13) + '【' + as[i]['title'] + as[i]['noa'] + '】' + as[i]['checkno'];
                                        }
                                    }
                                }
                                if (t_isExist && t_msg.length == 0) {
                                    Unlock();
                                } else if (t_isExist && t_msg.length > 0) {
                                    alert('票據重覆。' + String.fromCharCode(13) + t_msg);
                                    Unlock();
                                } else if (t_msg.length > 0) {
                                    alert(t_msg);
                                    Unlock();
                                } else {
                                    //檢查GQB
                                    var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
                                    q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_" + t_sel, r_accy);
                                }
                            } else {
                                //檢查GQB
                                var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
                                q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_" + t_sel, r_accy);
                            }
                        } else if (t_name.substring(0, 11) == 'gqb_change2') {
                            //檢查GQB
                            var t_sel = parseFloat(t_name.split('_')[2]);
                            var as = _q_appendData("gqb", "", true);
                            if (as[0] != undefined) {
                                alert('支票【' + as[0]['gqbno'] + '】已存在');
                            }
                            Unlock();
                        }
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var s2 = xmlString.split(';');
                abbm[q_recno]['accno'] = s2[0];
                abbm[q_recno]['vccno'] = s2[1];
                var t_noa = abbm[q_recno]['noa'];
                $('#txtAccno').val(s2[0]);
                $('#txtVccno').val(s2[1]);
                var b_seq = 0;
                var i = 2;
                for (var j = 0; j < abbs.length; j++) {
                    if (abbs[j]['noa'] == t_noa) {
                        abbs[j]['ummno'] = s2[++i];
                        abbs[j]['accno'] = s2[++i];
                        abbs[j]['vccno'] = s2[++i];
                        $('#txtUmmno_' + b_seq).val(s2[i]);
                        $('#txtAccno_' + b_seq).val(s2[i + 1]);
                        $('#txtVccno_' + b_seq).val(s2[i + 2]);
                        b_seq++;
                    }
                }
                Unlock();
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('borr_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
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
                 if (checkenda){
                	alert('超過'+q_getPara('sys.modiday')+'天'+'已關帳!!');
                	return;
                }
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box('z_borr.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
                Lock();
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock();
                    return;
                }
                sum();
                //先檢查BBS沒問題才存檔
                checkGqb_bbs(q_bbsCount - 1);

            }

            function checkGqb_bbs(n) {
                if (n < 0) {
                    //為了查詢
                    var t_checkno = '';
                    for (var i = 0; i < q_bbsCount; i++) {
                        if ($.trim($('#txtCheckno_' + i).val()).length > 0 && t_checkno.indexOf($.trim($('#txtCheckno_' + i).val())) == -1)
                            t_checkno += (t_checkno.length > 0 ? ',' : '') + $.trim($('#txtCheckno_' + i).val());
                    }
                    $('#txtCheckno').val(t_checkno);
                    if (q_cur == 1) {
                        $('#txtWorker').val(r_name);
                    } else if (q_cur == 2) {
                        $('#txtWorker2').val(r_name);
                    } else {
                        alert("error: btnok!");
                    }
                    var t_noa = trim($('#txtNoa').val());
                    var t_date = trim($('#txtDatea').val());
                    if (t_noa.length == 0 || t_noa == "AUTO")
                        q_gtnoa(q_name, replaceAll(q_getPara('sys.key_borr') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                    else
                        wrServer(t_noa);
                } else {
                    if ($.trim($('#txtCheckno_' + n).val()).length > 0) {
                        var t_noa = $('#txtNoa').val();
                        var t_checkno = $('#txtCheckno_' + n).val();
                        var t_ummno = $('#txtUmmno_'+n).val();
                        var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
                        q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_btnOkbbs1_" + n + "_" + t_checkno + "_" + t_noa+ "_" + t_ummno, r_accy);
                    } else {
                        checkGqb_bbs(n - 1);
                    }
                }
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (parseFloat(as['money'].length==0?"0":""+as['money'])==0 && parseFloat(as['interest'].length==0?"0":""+as['interest'])==0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                if(r_rank<=7)
            		q_gt('holiday', "where=^^ noa>='"+$('#txtDatea').val()+"'^^" , 0, 0, 0, "", r_accy);//單據日期之後的假日
            	else
            		checkenda=false;
                //if (q_cur > 0 && q_cur < 4)
                //    sum();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $('#txtAcc1_' + i).change(function() {
                            var patt = /^(\d{4})([^\.,.]*)$/g;
                            $(this).val($(this).val().replace(patt, "$1.$2"));
                            sum();
                        });
                        $('#txtCheckno_' + i).change(function() {
                            Lock();
                            var n = $(this).attr('id').replace('txtCheckno_', '');
                            var t_noa = $('#txtNoa').val();
                            var t_checkno = $('#txtCheckno_' + n).val();
                            var t_ummno = $('#txtUmmno_'+n).val();
                            var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
                            q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_change1_" + n + "_" + t_checkno + "_" + t_noa+ "_" +t_ummno, r_accy);
                        });
                        $('#txtMoney_' + i).change(function() {
                            sum();
                        });
                        $('#txtInterest_' + i).change(function() {
                            sum();
                        });
                        $('#txtCheckno_' + i).change(function() {
                            sum();
                        });
                        $('#cmbTypea_' + i).change(function() {
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                        $('#txtMoney__' + i).change(function() {
                            sum();
                        });
                    }
                }
                _bbtAssign();
            }

            function calcDay() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var t_days = 0;
                var t_date1 = $('#txtBegindate').val();
                var t_date2 = $('#txtEnddate').val();
                t_date1 = new Date(dec(t_date1.substr(0, 3)) + 1911, dec(t_date1.substring(4, 6)) - 1, dec(t_date1.substring(7, 9)));
                t_date2 = new Date(dec(t_date2.substr(0, 3)) + 1911, dec(t_date2.substring(4, 6)) - 1, dec(t_date2.substring(7, 9)));
                t_days = Math.abs(t_date2 - t_date1) / (1000 * 60 * 60 * 24) + 1;
                $('#txtDays').val(t_days);
                sum();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var t_days = 0, t_money = 0, t_cash = 0, t_checka = 0, t_interest = 0, t_pay = 0;
                t_days = q_float('txtDays');
                for (var i = 0; i < q_bbsCount; i++) {
                    if ($('#cmbTypea_' + i).val() == '1')
                        if ($.trim($('#txtCheckno_' + i).val()).length > 0)
                            t_checka += q_float('txtMoney_' + i);
                        else
                            t_cash += q_float('txtMoney_' + i);
                    else{
                    	t_pay += q_float('txtMoney_' + i);
                    	t_interest += q_float('txtInterest_' + i)
                    }
                }
                $('#txtCash').val(FormatNumber(t_cash));
                $('#txtChecka').val(FormatNumber(t_checka));
                t_money = t_cash + t_checka;
                $('#txtMoney').val(FormatNumber(t_money));
                
                $('#txtInterest').val(FormatNumber(t_interest));
                //$('#txtTotal').val(FormatNumber(t_money + t_interest));
                $('#txtPay').val(FormatNumber(t_pay));
                $('#txtUnpay').val(FormatNumber(t_money - t_pay));
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
            	 if (checkenda){
                	alert('超過'+q_getPara('sys.modiday')+'天'+'已關帳!!');
                	return;
	    		}
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            function q_popPost(id) {
                switch (id) {
                    default:
                        break;
                }
            }
			function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
			Number.prototype.round = function(arg) {
			    return Math.round(this * Math.pow(10,arg))/ Math.pow(10,arg);
			}
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			}
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""))
			        r2 = Number(arg2.toString().replace(".", ""))
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			}
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length } catch (e) { }
			    try { m += s2.split(".")[1].length } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			}
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2))
			    return (arg1 * m + arg2 * m) / m
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			}
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((arg1 * m - arg2 * m) / m).toFixed(n));
			}
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                width: 950px;
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
                width: 100%;
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
                width: 9%;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 130%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 130%;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 100%;
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
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:80px; color:black;"><a id='vewCust'> </a></td>
						<td style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td style="width:80px; color:black;"><a id='vewInterest'> </a></td>
						<td style="width:80px; color:black;"><a id='vewTotal'> </a></td>
						<td style="width:80px; color:black;"><a id='vewPay'> </a></td>
						<td style="width:80px; color:black;"><a id='vewUnpay'> </a></td>
						<td style="width:300px; color:black;"><a id='vewMemo'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='custnick' style="text-align: center;">~custnick</td>
						<td id='money,0,1' style="text-align: right;">~money,0,1</td>
						<td id='interest,0,1' style="text-align: right;">~interest,0,1</td>
						<td id='total,0,1' style="text-align: right;">~total,0,1</td>
						<td id='pay,0,1' style="text-align: right;">~pay,0,1</td>
						<td id='unpay,0,1' style="text-align: right;">~unpay,0,1</td>
						<td id='memo' style="text-align: left;">~memo</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td><input id="txtCheckno"  type="text" style="display:none;"/></td>
						<td></td>
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
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblPart" class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtPartno"  type="text"  style="width:25%; float:left;"/>
						<input id="txtPart"  type="text" style="width:75%; float:left;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtCustno"  type="text" style="width:25%; float:left;"/>
						<input id="txtCust"  type="text" style="width:75%; float:left;"/>
						<input id="txtCustnick"  type="text" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSalesno" class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtSalesno"  type="text" style="width:25%; float:left;"/>
						<input id="txtSales"  type="text" style="width:75%; float:left;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCash" class="lbl"> </a></td>
						<td>
						<input id="txtCash"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblChecka" class="lbl"> </a></td>
						<td>
						<input id="txtChecka"  type="text" class="txt c1 num" />
						</td>
						<td align="right" colspan="2">
						<input id="chkIsnointe" type="checkbox" style=' '/>
						<a id="lblIsnointe" class="lbl"> </a></td>
						<td></td>
						<td></td>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td>
						<input id="txtMoney" type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBegindate" class="lbl"> </a></td>
						<td>
						<input id="txtBegindate" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblEnddate" class="lbl"> </a></td>
						<td>
						<input id="txtEnddate" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblVccday" class="lbl"> </a></td>
						<td>
						<input id="txtVccday"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblRate" class="lbl"> </a></td>
						<td>
						<input id="txtRate" type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblInterest" class="lbl"> </a></td>
						<td>
						<input id="txtInterest" type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblRatemon" class="lbl"> </a></td>
						<td>
						<input id="txtRatemon" type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblFixmoney" class="lbl"> </a></td>
						<td>
						<input id="txtFixmoney" type="text" class="txt c1 num"/>
						</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><span> </span><a id="lblTotal" class="lbl" style="display:none;"> </a></td>
						<td>
						<input id="txtTotal" type="text" class="txt c1 num"  style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6">
						<input id="txtMemo" type="text" class="txt c1"/>
						</td>
						<td></td>
						<td><span> </span><a id="lblPay" class="lbl"> </a></td>
						<td>
						<input id="txtPay" type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblVccno" class="lbl btn"> </a></td>
						<td>
						<input id="txtVccno" type="text" class="txt c1"/>
						</td>
						<td colspan="2" align="center">
						<div id="InterestWindows">
							<table>
								<tr>
									<td style="width:30%;"><span> </span><a id="lblMon_windows" class="lbl"> </a></td>
									<td style="width:70%;">
									<input id="textMon_windows" type="text" class="txt c1"/>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
									<input id="btnProcessInterest" type="button">
									<input id="btnCloseWindows" type="button" value="關閉視窗">
									</td>
								</tr>
							</table>
						</div>
						<input id="btnInterest" type="button">
						</td>
						<td><span> </span><a id="lblUnpay" class="lbl"> </a></td>
						<td>
						<input id="txtUnpay" type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSplitmoney" class="lbl">每月還本金額</a></td>
						<td><input id="textMoney" type="text" class="txt c1"/></td>
						<td><input id="btnSplit" type="button" value="自動產生還款利息" /> </td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"></td>
						<td style="width:80px;"><a id='lbl_typea'> </a></td>
						<td style="width:80px;"><a id='lbl_datea'> </a></td>
						<td style="width:80px;"><a id='lbl_money'> </a></td>
						<td style="width:80px;"><a id='lbl_Interest'> </a></td>
						<td style="width:200px;"><a id='lbl_Acc1'> </a></td>
						<td style="width:100px;"><a id='lbl_checkno'> </a></td>
						<td style="width:80px;"><a id='lbl_indate'> </a></td>
						<td style="width:80px;"><a id='lbl_bankno'> </a></td>
						<td style="width:80px;"><a id='lbl_bank'> </a></td>
						<td style="width:150px;"><a id='lbl_account'> </a></td>
						<td style="width:150px;"><a id='lbl_memo'> </a></td>
						<td style="width:100px;"><a id='lbl_ummno'> </a></td>
						<td style="width:100px;"><a id='lbl_accno'> </a></td>
						<td style="width:100px;"><a id='lbl_vccno'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><select id="cmbTypea.*" style="width:95%; text-align: center;"></select></td>
						<td>
						<input class="txt" id="txtDatea.*" type="text" style="width:95%; text-align: center;"/>
						</td>
						<td>
						<input class="txt" id="txtMoney.*" type="text" style="width:95%; text-align: right;"/>
						</td>
						<td>
						<input class="txt" id="txtInterest.*" type="text" style="width:95%; text-align: right;"/>
						</td>
						<td >
						<input id="txtAcc1.*" type="text" class="txt c1" style="float:left;width:30%;"/>
						<input id="txtAcc2.*" type="text" class="txt c1" style="float:left;width:60%;"/>
						</td>
						<td>
						<input class="txt" id="txtCheckno.*" onclick="browTicketForm(this)" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtIndate.*" type="text" style="width:95%; text-align: center;"/>
						</td>
						<td>
						<input class="txt" id="txtBankno.*" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtBank.*" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtAccount.*" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtUmmno.*" onclick="browTicketForm(this)" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtAccno.*" onclick="browTicketForm(this)" type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input class="txt" id="txtVccno.*" onclick="browTicketForm(this)" type="text" style="width:95%; text-align: left;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:60px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"></td>
						<td style="width:120px; text-align: center;">請款日期</td>
						<td style="width:100px; text-align: center;">金額(利息)</td>
						<td style="width:350px; text-align: center;">備註</td>
						<td style="width:150px; text-align: center;">請款單號</td>
						<td style="width:150px; text-align: center;">傳票號碼</td>
					</tr>
					<tr>
						<td><!--<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>--><span> </span><a id="lblCancel_t" class="lbl"> </a>
						<input id="chkCancel..*" type="checkbox"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
						<input id="txtMon..*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input id="txtMoney..*"  type="text" style="width:95%; text-align: right;"/>
						</td>
						<td>
						<input id="txtMemo..*"  type="text" style="width:95%; text-align: left;"/>
						</td>
						<td>
						<input id="txtVccno..*" onclick="browTicketForm(this)" type="text" class="txt c1"/>
						</td>
						<td>
						<input id="txtAccno..*" onclick="browTicketForm(this)" type="text" class="txt c1"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
