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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "cara";
            var q_readonly = ['txtNoa','txtIprev','txtInterest','txtItotal','txtTotal','txtPaytotal','txtBprev','txtBin','txtBtotal','txtAccno','textUnpay','txtOldcarno'];
            var q_readonlys = ['txtCaritem','txtUmmnoa','txtUdate'];
            var bbmNum = [['txtIprev', 15, 0, 1],['txtIset', 15, 0, 1],['txtBprev', 15, 0, 1],['txtInterest', 15, 0, 1],['txtBin', 15, 0, 1],['txtItotal', 15, 0, 1],['txtBtotal', 15, 0, 1],['txtTotal', 15, 0, 1],['txtPaytotal', 15, 0, 1]];
            var bbsNum = [['txtOutmoney', 15, 0, 1],['txtInmoney', 15, 0, 1],['txtCost', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc=1;
			//q_alias='a';
			aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,a.carownerno,b.carowner,a.sssno', 'txtCarno,txtCarownerno,txtCarowner,txtSssno', "car2_b.aspx"],
				['textBcarno', 'lblNextcarno', 'car2', 'a.noa,b.carowner', 'textBcarno', "car2_b.aspx?;;;a.carownerno!='' "],
				['textEcarno', 'lblNextcarno', 'car2', 'a.noa,b.carowner', 'textEcarno', "car2_b.aspx?;;;a.carownerno!='' "],
				['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'],
				['txtCaritemno_', 'btnCaritem_', 'caritem', 'noa,item,acc1,acc2', 'txtCaritemno_,txtCaritem_,txtAcc1_,txtAcc2_,txtOutmoney_', 'caritem_b.aspx'], 
				['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
			
			//['textCarseek', 'lblCarseek', 'car2', 'a.noa,b.carowner', 'textCarseek', "car2_b.aspx"],
			
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
            			
			var dateimport=false;
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtMon', r_picm],['txtPdate', r_picd]];
                q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd],['txtIndate', r_picd],['txtPdate', r_picd],['txtUdate', r_picd],['txtPaydate', r_picd]];
                //q_mask(bbsMask);
                $('#textNextmon').mask('999/99');
                $('#textDiscount').mask('99');
                q_cmbParse("cmbIsource", q_getPara('cara.isource'));
                
                q_gt('sss', "where=^^ partno='07'^^" , 0, 0, 0, "", r_accy);	
                
                $('#btnImport').click(function () {
                	if(emp($('#txtCarno').val())){
                		alert('車牌號碼請先輸入!!');
                		$('#txtCarno').focus();
                		return;
                	}
                	if(emp($('#txtMon').val())){
                		alert('月份請先輸入!!');
                		$('#txtMon').focus();
                		return;
                	}
                	dateimport=true;
                	//上期欠款
		            var t_where = "where=^^ carno ='"+$('#txtCarno').val()+"' ^^ top=1";
			        q_gt('cara', t_where , 0, 0, 0, "", r_accy);
		     	});
                $('#cmbIsource').change(function () {sum();});
                //速查
                /*$('#textCarseek').change(function () {
                	if(!emp($('#textCarseek').val())){
                		var s2=new Array('cara_s',"where=^^ carno like '%" +$('#textCarseek').val() + "%'^^ ");
                		q_boxClose2(s2);
                	}else{
                		var s2=new Array('cara_s',"where=^^ 1=1 ^^ ");
                		q_boxClose2(s2);
                	}
                }).focus(function() {
					q_cur=2;
				}).blur(function() {
					q_cur=4;
				});*/
				
				$('#btnNextmon').click(function () {
					if ($('#divNextmon').is(":hidden")) {
						$('#divNextmon').show();
						$('#textNextmon').val(q_date().substr(0,6));
						$('#textDiscount').val(0);
						$('#textBcarno').val($('#txtCarno').val());
						$('#textEcarno').val($('#txtCarno').val());
						$('#textSssno').val(sssno);
						if(r_userno.substr(0,2)!='07')
							q_msg( $(this), '要結轉前請先詢問監理部相關人員!!');
					} else{
						$('#divNextmon').hide();
		        	}
		     	});
		     	$('#lblClose_divNextmon').click(function(e) {//按下關閉
					$('#divNextmon').hide();
				});
				$('#lbl_divNextmon').click(function(e) {//按下資料匯入
					$('#divNextmon').hide();
					if(!emp($('#textNextmon').val())&&!emp($('#textDiscount').val())){
						q_msg( $(this), '資料結轉中........請稍待........請勿關閉此網頁!!');
						q_func( 'cara.genNext',$('#textNextmon').val()+','+dec($('#textDiscount').val())+','+$('#textBcarno').val()+','+$('#textEcarno').val()+','+$('#textSssno').val()+','+r_name);//genNext(string t_mon , string t_discount, string t_worker);
			    	}
				});
				
				$('#textBcarno').focus(function () {
	            	q_cur=2;
	       		}).blur(function () {
	            	q_cur=0;
	       		});
				$('#textEcarno').focus(function () {
	            	q_cur=2;
	       		}).blur(function () {
	            	q_cur=0;
	       		});
				$('#lblSssno').click(function () {
	            	q_box("sss_b2.aspx?;;;partno='07'", 'sss', "95%", "95%", q_getMsg("popSss"));
	       		});
	       		
	       		$('#lblAccno').click(function () {
	            	q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
	       		});
	       		
	       		scroll("tbbs","box",1);
	       		
	       		$('#scrollplus').click(function () {
	            	$('#btnPlus').click();
	       		});
            }
			
			function q_funcPost(t_func, result) {
		        location.href = location.origin+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";carno='"+$('#txtCarno').val()+"';"+r_accy;
		        alert('結轉功能執行完畢!!');
		    } //endfunction
			
            function q_boxClose(s2) {///   q_boxClose 2/4
                var ret;
                switch (b_pop) {
                	case 'sss':
                        ret = getb_ret();
	                        if(ret[0]!=undefined){
	                        	$('#textSssno').val('');
	                        	for (var i = 0; i < ret.length; i++) {
	                        		if($('#textSssno').val().length>0){
		                            	var temp=$('#textSssno').val();
		                            	$('#textSssno').val(temp+'.'+ret[i].noa);
		                            }else{
		                            	$('#textSssno').val(ret[i].noa);
		                            } 
	                        	}
							}
					break;
                	case 'ticket':
                		if (q_cur > 0 && q_cur < 4) {
	                        b_ret = getb_ret();
	                        if (!b_ret || b_ret.length == 0)
	                            return;
	                            
	                        if (b_seq < 0 || b_seq >= q_bbsCount){
	                        	$('#txtOutmoney_' + b_seq).val(b_ret[0].phr);
	                        	$('#txtMemo_' + b_seq).val(b_ret[0].phr);
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
			
			var sssno='';
			var holiday;//存放holiday的資料
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'holiday':
	            		holiday = _q_appendData("holiday", "", true);
	            	break;
                	case 'vcc':
                		var as = _q_appendData("vcc", "", true);
                		var unpay=0;
                		for (var i = 0; i < as.length; i++) {
                			unpay+=dec(as[i].unpay);
                		}
                		q_tr('textUnpay',unpay);
                	break;
                	case 'sss':
            			var as = _q_appendData("sss", "", true);
            			for (var i = 0; i < as.length; i++) {
            				sssno+=as[i].noa+'.';
            			}
            			sssno=sssno.substr(0,sssno.length-1);
            		break;
                	case 'car2':
                		if(dateimport){
                			var as = _q_appendData("car2", "", true);
                			if(as[0]!=undefined){
                				as[0]._datea=q_date();
                				if(dec($('#txtIprev').val())>dec(as[0].irange)&&dec(as[0].irate)>0 &&dec(as[0].auto)=='Y')
                				{
                					as[0]._iratefee=Math.round((dec($('#txtIprev').val())-dec(as[0].irange))*dec(as[0].irate))
                					as[0].caritemno='002';
                    				as[0].caritem='上月利息';
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,_iratefee', 'txtCaritemno');
                				}
                				
                				if(dec($('#txtBprev').val())>0&&dec(as[0].irate)>0 &&dec(as[0].auto)=='Y')
                				{
                					as[0]._bratefee=Math.round(dec($('#txtBprev').val())*dec(as[0].irate))
                					as[0].caritemno='202';
                    				as[0].caritem='借支利息';
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,_bratefee', 'txtCaritemno');
                				}
                				
                				if(as[0].outdate=='' && as[0].stopdate=='' && as[0].enddate==''){
	                				if(dec(as[0].manage)>0){
	                					as[0].caritemno='401';
	                    				as[0].caritem='行費';//管理費
	                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,manage', 'txtCaritemno');
	                    			}
	                    				                    			
	                    			//上牌照稅
	                    			if(as[0].ulicensemon==$('#txtMon').val().substr(4,2)&&dec(as[0].ulicense)>0){
	                    				as[0].caritemno='501';
	                    				as[0].caritem='牌照稅'
	                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,ulicense', 'txtCaritemno');
	                    			}
	                    			//下牌照稅
	                    			if(as[0].dlicensemon==$('#txtMon').val().substr(4,2)&&dec(as[0].dlicense)>0){
	                    				as[0].caritemno='501';
	                    				as[0].caritem='牌照稅'
	                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,dlicense', 'txtCaritemno');
	                    			}
	                    			
	                    			//春燃料費
	                    			if(as[0].springmon==$('#txtMon').val().substr(4,2)&&dec(as[0].spring)>0){
	                    				as[0].caritemno='502';
	                    				as[0].caritem='燃料費'
	                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,spring', 'txtCaritemno');
	                    			}
	                    			//夏燃料費
	                    			if(as[0].summermon==$('#txtMon').val().substr(4,2)&&dec(as[0].summer)>0){
	                    				as[0].caritemno='502';
	                    				as[0].caritem='燃料費'
	                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,summer', 'txtCaritemno');
	                    			}
	                    			//秋燃料費
	                    			if(as[0].fallamon==$('#txtMon').val().substr(4,2)&&dec(as[0].falla)>0){
	                    				as[0].caritemno='502';
	                    				as[0].caritem='燃料費'
	                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,falla', 'txtCaritemno');
	                    			}
	                    			//冬燃料費
	                    			if(as[0].wintermon==$('#txtMon').val().substr(4,2)&&dec(as[0].winter)>0){
	                    				as[0].caritemno='502';
	                    				as[0].caritem='燃料費'
	                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,winter', 'txtCaritemno');
	                    			}
                    			}
                			}
                			//保險費
					        var t_where = "where=^^ noa ='"+$('#txtCarno').val()+"' and inmon='"+$('#txtMon').val()+"' ^^";
					        q_gt('carinsure', t_where , 0, 0, 0, "", r_accy);
					    }
                		break;
                	case 'carinsure':
                		var as = _q_appendData("carinsure", "", true);
                    		if(as[0]!=undefined){
                    			if(dec(as[0].money)>0){
                    				as[0]._datea=q_date();
                    				as[0].caritemno='306';
                    				as[0].caritem='保險費'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', 1, as, '_datea,caritemno,caritem,money', 'txtCaritemno');
                    			}
                    		}
                    		sum();
                		break;
                		case 'caritem':
                		var as = _q_appendData("caritem", "", true);
                    		if(as[0]!=undefined){
                    			if(as[0].typea=='1'){
	           						$('#txtInmoney_'+b_seq).val(0);
	           						$('#txtOutmoney_'+b_seq).focus();
	           					}
	           					if(as[0].typea=='2'){
	           						$('#txtOutmoney_'+b_seq).val(0);
	           						$('#txtInmoney_'+b_seq).focus();
	           					}
                    		}
                    		sum();
                		break;
                    case q_name:
                    	if(dateimport){
                    		var as = _q_appendData("cara", "", true);
                    		if(as[0]!=undefined){
                    			//上月息額取上一張累計息額並判斷來源
                    			if(as[0].isource=='1'){
                    				q_tr('txtIprev',dec(as[0].itotal));
                    			}else{
                    				q_tr('txtIprev',dec(as[0].iset));
                    			}
                    			q_tr('txtBprev',dec(as[0].btotal));//上月借支餘額取上一張本月借支餘額
                    			if(dec(as[0].paytotal)>0){
                    				as[0]._datea=q_date();
                    				as[0].caritemno='001';
                    				as[0].caritem='上月欠款'
                    				q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtCaritemno,txtCaritem,txtOutmoney', as.length, as, '_datea,caritemno,caritem,paytotal', 'txtCaritemno');
                    			}
                    		}
                    		//管理費,公會費,準備金,互助金,牌照稅,燃料費
					        var t_where = "where=^^ a.noa ='"+$('#txtCarno').val()+"' ^^";
					        q_gt('car2', t_where , 0, 0, 0, "", r_accy);
					        
                    	}
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
			
			//1020311增加修改完單據後會重新整理網頁(解決次月金額變動而沒有重新整理的問題)
			var isbtnok=false;
            function btnOk() {
                if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            	}
                if (!q_cd($('#txtPdate').val())){
                	alert(q_getMsg('lblPdate')+'錯誤。');
                	return;
            	}
				$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');   
					return;
				}         	

                 t_err = q_chkEmpField([['txtCarno', q_getMsg('lblCarno')],['txtMon', q_getMsg('lblMon')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                $('#txtWorker').val(r_name)
                sum();
				
				isbtnok=true;
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    wrServer($('#txtCarno').val()+'-'+$('#txtMon').val());
                else
                	wrServer(s1);
            }
			
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
                $('#txtAccno').val(xmlString);
            }
			
            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('cara_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           				$('#txtCaritemno_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							//判斷要輸入支付和付款
           					var t_where = "where=^^ noa ='"+$('#txtCaritemno_'+b_seq).val()+"' ^^";
					        q_gt('caritem', t_where , 0, 0, 0, "", r_accy);
							
           					if(!emp($('#txtCaritemno_'+b_seq).val())&&$('#txtCaritemno_'+b_seq).val()=='303'){
           						$('#text_Noq').val(b_seq);
           						q_box("ticket.aspx", 'ticket', "95%", "95%", q_getMsg("popTicket"));
           					}
           					sum();
           				});
           				$('#txtOutmoney_'+j).change(function () {
           					sum();
           				//}).blur(function() {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#txtMemo_'+b_seq).focus();
						});
						
           				$('#txtInmoney_'+j).change(function () {
           					sum();
           				//}).blur(function() {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#txtMemo_'+b_seq).focus();
						});
						
						$('#txtAcc1_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
		                    var s1 = trim($('#txtAcc1_'+b_seq).val());
		                    if (s1.length > 4 && s1.indexOf('.') < 0)
		                        $('#txtAcc1_'+b_seq).val(s1.substr(0, 4) + '.' + s1.substr(4));
		                    if (s1.length == 4)
		                        $('#txtAcc1_'+b_seq).val(s1 + '.');
                		});
                		
						$('#txtUmmnoa_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
		                    
		                    if(!emp($('#txtUmmnoa_'+b_seq).val())){
		                    	if($('#txtUmmnoa_'+b_seq).val().substr(0,2)=='FB')
		                    		q_box("ummtran.aspx?;;;noa='" + $('#txtUmmnoa_'+b_seq).val() + "';" + r_accy, 'umm', "95%", "95%", q_getMsg("popUmmtran"));
		                    	if($('#txtUmmnoa_'+b_seq).val().substr(0,2)=='BK')
		                    		q_box("carchg.aspx?;;;noa='" + $('#txtUmmnoa_'+b_seq).val() + "';" + r_accy, 'carchg', "95%", "95%", q_getMsg("popCarchg"));
		                    	if($('#txtUmmnoa_'+b_seq).val().substr(0,1)=='Z')
		                    		q_box("lab_accc.aspx?;;;noa='" + $('#txtUmmnoa_'+b_seq).val() + "';" + r_accy, 'labaccc', "95%", "95%", q_getMsg("popLabaccc"));
		                    }
                		});
                		
                		$('#txtMemo_'+j).click(function () {
                			if(q_cur==0 || q_cur==4)
           						q_msg( $(this), $(this).val());
						});
           			}
           		}

                _bbsAssign();
                
                if(isbtnok){
                	location.href = (location.origin==undefined?'':location.origin)+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";noa<='"+$('#txtNoa').val()+"';"+r_accy;
                }
                
                //收款的資料禁止修改
                if(q_cur==2){
	                for(var j = 0; j < q_bbsCount; j++) {
						if($('#txtUmmnoa_'+j).val()!=''){
							$('#btnMinus_'+j).attr('disabled', 'disabled');
							$('#txtNoq_'+j).attr('disabled', 'disabled');
							$('#txtDatea_'+j).attr('disabled', 'disabled');
							//$('#txtCaritemno_'+j).attr('disabled', 'disabled');
							$('#txtOutmoney_'+j).attr('disabled', 'disabled');
							$('#txtInmoney_'+j).attr('disabled', 'disabled');
							$('#txtUdate_'+j).attr('disabled', 'disabled');
						}
					}
                }
                 for(var j = 0; j < q_bbsCount; j++) {
                 	if($('#txtDatea_'+j).val()==''){
                 		$('#txtDatea_'+j).focus();
                 		break;
                 	}
                 }
                 
                 //1020307新增讀取VCCA未收金額(textUnpay)
                 var t_where = "where=^^ custno ='"+$('#txtCarownerno').val()+"'^^";
                 q_gt('vcc', t_where , 0, 0, 0, "", r_accy);
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtMon').val(q_date().substr(0,6));
                $('#txtCarno').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                //102/06/14 次月15日不能再修改與刪除
            	if (checkenda){
                	alert('此單據已關帳!!');
                    return;
                }
                _btnModi();
				//禁止修改
				$('#txtCarowner').attr('disabled', 'disabled');
				$('#txtCarownerno').attr('disabled', 'disabled');
				$('#txtCarno').attr('disabled', 'disabled');
				$('#txtMon').attr('disabled', 'disabled');
				//收款的資料禁止修改
				
				
				//1020621 7月份開始資料3日後不能在處理
				var x_day=q_getPara('sys.modiday'),t_day=1;
				var t_date=q_date();
				
				while(r_rank<=7 && t_day<x_day){
					var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
					nextdate.setDate(nextdate.getDate() -1)
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
				
				
				for(var j = 0; j < q_bbsCount; j++) {
					if($('#txtUmmnoa_'+j).val()!='' || $('#txtCaritemno_'+j).val()=='001'|| $('#txtUdate_'+j).val()!=''){
						$('#btnMinus_'+j).attr('disabled', 'disabled');
						$('#txtNoq_'+j).attr('disabled', 'disabled');
						$('#txtDatea_'+j).attr('disabled', 'disabled');
						//$('#txtCaritemno_'+j).attr('disabled', 'disabled');
						$('#txtOutmoney_'+j).attr('disabled', 'disabled');
						$('#txtInmoney_'+j).attr('disabled', 'disabled');
						$('#txtUdate_'+j).attr('disabled', 'disabled');
						$('#txtCost_'+j).attr('disabled', 'disabled');
						$('#txtAcc1_'+j).attr('disabled', 'disabled');
						$('#btnAcc_'+j).attr('disabled', 'disabled');
						$('#txtAcc2_'+j).attr('disabled', 'disabled');
						if($('#txtCaritemno_'+j).val()=='001'){
							$('#btnCaritem_'+j).attr('disabled', 'disabled');
							$('#txtCaritemno_'+j).attr('disabled', 'disabled');
						}
					}
						
					if(r_rank<=7&&t_date>$('#txtDatea_'+j).val()){
						$('#btnMinus_'+j).attr('disabled', 'disabled');
						$('#txtNoq_'+j).attr('disabled', 'disabled');
						$('#txtDatea_'+j).attr('disabled', 'disabled');
						$('#txtCaritemno_'+j).attr('disabled', 'disabled');
						$('#btnCaritem_'+j).attr('disabled', 'disabled');
						$('#txtOutmoney_'+j).attr('disabled', 'disabled');
						$('#txtInmoney_'+j).attr('disabled', 'disabled');
						//$('#txtMemo_'+j).attr('disabled', 'disabled');//1020703摘要要開放讓人員修改
						$('#txtPaydate_'+j).attr('disabled', 'disabled');
						$('#txtFareyn_'+j).attr('disabled', 'disabled');
						$('#txtCost_'+j).attr('disabled', 'disabled');
						$('#txtAcc1_'+j).attr('disabled', 'disabled');
						$('#btnAcc_'+j).attr('disabled', 'disabled');
						$('#txtAcc2_'+j).attr('disabled', 'disabled');
						$('#txtPdate_'+j).attr('disabled', 'disabled');
					}
				}
            }

            function btnPrint() {
				q_box('z_car2.aspx', '', "90%", "600px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['mon'] = abbm2['mon'];
                as['carno'] = abbm2['carno'];

                return true;
            }

            function sum() {
                var t_total = 0,t_bin=0,t_interest=0,t_paytotal=0;
                for(var j = 0; j < q_bbsCount; j++) {
                	//金額合計
                    t_total += dec($('#txtOutmoney_' + j).val()) - dec($('#txtInmoney_' + j).val());
                    //實際金額合計
                    if(dec($('#txtCost_' + j).val())>0){
                    	t_paytotal+=dec($('#txtCost_' + j).val()) - dec($('#txtInmoney_' + j).val());
                    }else{
                    	t_paytotal+=dec($('#txtOutmoney_' + j).val()) - dec($('#txtInmoney_' + j).val());
                    }
                    //本月息額
                    if($('#txtCaritemno_' + j).val()!='001'&&$('#txtCaritemno_' + j).val()!='002'&&$('#txtCaritemno_' + j).val()!='102'&&$('#txtCaritemno_' + j).val()!='201'&&$('#txtCaritemno_' + j).val()!='202'&&$('#txtCaritemno_' + j).val()!='203'&&$('#txtCaritemno_' + j).val()!='306'&&$('#txtCaritemno_' + j).val()!='401'){
                    	if(dec($('#txtCost_' + j).val())>0){
                    		t_interest+=dec($('#txtCost_' + j).val()) - dec($('#txtInmoney_' + j).val());
	                    }else{
	                    	t_interest+=dec($('#txtOutmoney_' + j).val()) - dec($('#txtInmoney_' + j).val());
	                    }
                    }
                    //本月借支-入款
                    if($('#txtCaritemno_' + j).val()=='201')//借支
                    	t_bin+=dec($('#txtOutmoney_' + j).val())-dec($('#txtInmoney_' + j).val());
                    if($('#txtCaritemno_' + j).val()=='102' ||$('#txtCaritemno_' + j).val()=='112' )//入款借支.入票借支
                    	t_bin-=dec($('#txtInmoney_' + j).val())-dec($('#txtOutmoney_' + j).val());
                }
                
                q_tr('txtInterest',t_interest);//本月息額不含001,002,102,201,202,203,306,401
                if(dec($('#txtIprev').val())+dec($('#txtInterest').val())<0)
                	q_tr('txtItotal',0);//累計息額=上月息額+本月息額
                else
                	q_tr('txtItotal',dec($('#txtIprev').val())+dec($('#txtInterest').val()));//累計息額=上月息額+本月息額
                q_tr('txtBin',t_bin);//本月借支-入款=201-102-112
                q_tr('txtBtotal',dec($('#txtBprev').val())+dec($('#txtBin').val()));//本月借支餘額=上月借支餘額+本月借支-入款
                q_tr('txtTotal',t_total);//金額合計
                q_tr('txtPaytotal',t_paytotal);//金額合計
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function q_popPost(s1) {
		    	switch (s1) {
		    		case 'textCarseek':
		    			if(!emp($('#textCarseek').val())){
	                		var s2=new Array('cara',"where=^^ carno like '%" +$('#textCarseek').val() + "%'^^ ");
	                		q_boxClose2(s2);
                		}else{
	                		var s2=new Array('cara',"where=^^ 1=1 ^^ ");
	                		q_boxClose2(s2);
                		}
			        break;
			        case 'txtCaritemno_':
		    			//判斷要輸入支付和付款
           				var t_where = "where=^^ noa ='"+$('#txtCaritemno_'+b_seq).val()+"' ^^";
					    q_gt('caritem', t_where , 0, 0, 0, "", r_accy);
			        break;
		    	}
			}
            
            function refresh(recno) {
                _refresh(recno);
                endacheck();
                if(r_rank<=7)
            		q_gt('holiday', "where=^^ noa<='"+q_date()+"'^^ stop=10" , 0, 0, 0, "", r_accy);
            }
            
            var checkenda=false;
            function endacheck() {
            	if(r_rank>7){
            		checkenda=false;
            		return;
            	}
            	
            	//102/06/14 次月15日不能再修改與刪除
            	var t_date=$('#txtMon').val()+'/01';
				var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
				nextdate.setDate(nextdate.getDate() +45)
				t_date=''+(nextdate.getFullYear()-1911)+'/';
				//月份
				t_date=t_date+((nextdate.getMonth()+1)<10?('0'+(nextdate.getMonth()+1)+'/'):((nextdate.getMonth()+1)+'/'));
				//日期
				t_date=t_date+'15';
            	
                if (t_date<q_date()){
                	checkenda=true;
                }else{
                	checkenda=false;
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                if (t_para) {
		            //$('#textCarseek').removeAttr('disabled');
		            $('#btnNextmon').removeAttr('disabled');
		            //$('#btnPxextmon').removeAttr('disabled');
		            $('#btnImport').attr('disabled', 'disabled');
		        }
		        else {
		        	//$('#textCarseek').attr('disabled', 'disabled');
		        	$('#btnNextmon').attr('disabled', 'disabled');
		        	//$('#btnPnxtmon').attr('disabled', 'disabled');
		        	$('#btnImport').removeAttr('disabled');
		        }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                /// 表身運算式
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
            	//102/06/14 次月15日不能再修改與刪除
            	if (checkenda){
                	alert('此單據已關帳!!');
                    return;
                }
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
           	$(document).keydown(function(e) {
				if ( e.keyCode=='116' ){
				   location.href = (location.origin==undefined?'':location.origin)+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";noa<='"+$('#txtNoa').val()+"';"+r_accy;
				   event.returnValue= false;
				  }
			});
            
		var scrollcount=1;
        function scroll(viewid,scrollid,size){
        	if(scrollcount>1)
        	$('#box_'+(scrollcount-1)).remove();
			var scroll = document.getElementById(scrollid);
			var tb2 = document.getElementById(viewid).cloneNode(true);
			var len = tb2.rows.length;
			for(var i=tb2.rows.length;i>size;i--){
		                tb2.deleteRow(size);
			}
			//tb2.rows[0].deleteCell(0);
			tb2.rows[0].cells[0].children[0].id="scrollplus"
			var bak = document.createElement("div");
			bak.id="box_"+scrollcount
			scrollcount++;
			scroll.appendChild(bak);
			bak.appendChild(tb2);
			bak.style.position = "absolute";
			bak.style.backgroundColor = "#fff";
		    bak.style.display = "block";
			bak.style.left = 0;
			bak.style.top = "0px";
			scroll.onscroll = function(){
				bak.style.top = this.scrollTop+"px";
			}
		}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
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
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 75%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
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
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            .tbbs
        	{
	            FONT-SIZE: medium;
	            COLOR: blue ;
	            TEXT-ALIGN: left;
	             BORDER:1PX LIGHTGREY SOLID;
	             width:100% ; height:98% ;  
        	} 
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            
            .popDiv {
				position: absolute;
				/*z-index: 99;*/
				background: #4297D7;
				border: 2px #EEEEEE solid;
				display: none;/*default*/
			}
			.popDiv .block {
				border-radius: 5px;
			}
			.popDiv .block .col {
				display: block;
				width: 600px;
				height: 30px;
				margin-top: 5px;
				margin-left: 5px;
			}
      		.btnLbl {
				background: #cad3ff;
				border-radius: 5px;
				display: block;
				width: 95px;
				height: 25px;
				cursor: default;
			}
			.btnLbl.tb {
				float: right;
			}
			.btnLbl.button {
				cursor: pointer;
				background: #76A2FE;
			}
			.btnLbl.button.close {
				background: #cad3ff;
			}
			.btnLbl.button:hover {
				background: #FF8F19;
			}
			.btnLbl a {
				color: blue;
				font-size: medium;
				height: 25px;
				line-height: 25px;
				display: block;
				text-align: center;
			}
			.btnLbl.button a {
				color: #000000;
			}
			.btnLbl.close a {
				color: red;
				font-size: 16px;
				height: 25px;
				line-height: 25px;
				display: block;
				text-align: center;
			}
			#box{
				height:390px;
				width: 100%;
				overflow-y:auto;
				position:relative;
		}
		</style>
	</head>
	<body><!--onkeydown="KeyDown()"-->
		<div id="divNextmon" class='popDiv' style="top:50px;right:180px;">
			<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:300px">
	            <tr>
	                <td align="center" style="width:35%"><span> </span><a id="lblNextmon" class="lbl" ></a></td>
	                <td align="center" style="width:65%">
	                	<input id="textNextmon" type="text"  class="txt c1" style=" float: left;"/>
	                </td>
	            </tr>
	            <tr>
	                <td align="center" style="width:35%"><span> </span><a id="lblDiscount" class="lbl" ></a></td>
	                <td style="width:65%">
	                	<input id="textDiscount" type="text"  class="txt c2" style=" float: left;"/>%
	                </td>
	            </tr>
	            <tr>
	                <td align="center" style="width:35%"><span> </span><a id="lblNextcarno" class="lbl" ></a></td>
	                <td style="width:65%">
	                	<input id="textBcarno" type="text"  class="txt c2" style=" float: left;"/>
	                	<a style=" float: left;">~</a>
	                	<input id="textEcarno" type="text"  class="txt c2" style=" float: left;"/>
	                </td>
	            </tr>
	            <tr>
	                <td align="center" style="width:35%"><span> </span><a id="lblSssno" class="lbl btn" ></a></td>
	                <td style="width:65%">
	                	<input id="textSssno" type="text"  class="txt c1" style=" float: left;"/>
	                </td>
	            </tr>
	            <tr>
	            	<td align="center" colspan="2">
	            		<div class="block" style="display: table-cell;">
		            		<div class='btnLbl button close' style="float: left;">
								<a id='lbl_divNextmon'></a>
							</div>
							<div style="float: left;width: 10px;height: 25px;">	</div>
							<div class='btnLbl button close' style="float: left;">
								<a id='lblClose_divNextmon'></a>
							</div>
						</div>
	                </td>
	            </tr>
        	</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" style="float: left;  width:25%;">
				<table class="tview" id="tview" border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width: 25%;"><a id='vewDatea'></a></td>
						<td align="center" style="width: 25%;"><a id='vewMon'></a></td>
						<td align="center" style="width: 50%;"><a id='vewCarno'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea '>~datea</td>
						<td align="center" id='mon '>~mon</td>
						<td align="center" id='carno '>~carno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm"  id="tbbm"  border="0" cellpadding='2'  cellspacing='5'>
					<tr class="tr1">
						<td class="td1" ><span> </span><a id="lblCarno" class="lbl btn"></a></td>
						<td class="td2" colspan="3">
							<input id="txtCarno"  type="text"  class="txt" style="width:90px;"/>
							<input id="txtCarownerno"  type="text" class="txt" style="width:50px;"/>
							<input id="txtCarowner"  type="text" class="txt" style="width:90px;"/>
						</td>
						<td class="td5"><span> </span><a id='lblOldcarno' class="lbl"></a></td>
						<td class="td6" colspan="2"><input id="txtOldcarno"  type="text" class="txt c1"/></td>
						<td class="td8"><input id="btnNextmon" type="button" /></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td2"><input id="txtMon"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblIprev' class="lbl"></a></td>
						<td class="td4"><input id="txtIprev" type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblIset' class="lbl"></a></td>
						<td class="td6"><input id="txtIset"  type="text" class="txt num c1"/></td>
						<td class="td7"><span> </span><a id='lblBprev' class="lbl"></a></td>
						<td class="td8"><input id="txtBprev"  type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblPdate' class="lbl"></a></td>
						<td class="td2"><input id="txtPdate"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblInterest' class="lbl"></a></td>
						<td class="td4"><input id="txtInterest"  type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblIsource' class="lbl"></a></td>
						<td class="td6"><select id="cmbIsource" class="txt c1" style="font-size: medium;"></select></td>
						<td class="td7"><span> </span><a id='lblBin' class="lbl"></a></td>
						<td class="td8"><input id="txtBin" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblTotal' class="lbl"></a></td>
						<td class="td2"><input id="txtTotal"  type="text" class="txt num c1">	</td>
						<td class="td3"><span> </span><a id='lblItotal' class="lbl"></a></td>
						<td class="td4"><input id="txtItotal"  type="text" class="txt num c1"/></td>
						<td class="td5"><span> </span><a id='lblUnpay' class="lbl"></a></td>
						<td class="td6"><input id="textUnpay"  type="text" class="txt num c1"/></td>
						<td class="td7"><span> </span><a id='lblBtotal' class="lbl"></a></td>
						<td class="td8"><input id="txtBtotal"  type="text" class="txt num c1"/></td>
					<!--直接讓速查顯示10筆
						<td class="td9"><span> </span><a id='lblLastmon' class="lbl"></a></td>
						<td class="td10"><input id="txtLastmon"  type="text" class="txt c2"/></td>
					-->
					</tr>
					<tr class="tr5"><!--<input id="btnPnextmon" type="button" />-->
						<td class="td7"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td8"><input id="txtNoa"  type="text" class="txt c1"/><input id="txtSssno"  type="hidden"/>	</td>
						<td class="td3"><span> </span><a id='lblAccno' class="lbl btn"></a></td>
						<td class="td4"><input id="txtAccno"  type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td6"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class="td1"><span> </span><a id='lblPaytotal' class="lbl"></a></td>
						<td class="td2"><input id="txtPaytotal"  type="text" class="txt num c1">	</td>
					</tr>
				</table>
				<input id="text_Noq"  type="hidden" class="txt c1"/>	
			</div>
		</div>
		<div id="box">
		<div class='dbbs'>
				<table id="tbbs" class='tbbs' border="1"  cellpadding='2' cellspacing='1' style="width: 1250px;">
					<tr style='color:White; background:#003366;'>
						<td align="center" id='hide_Plus'  style="width: 42px;">
						<input class="btn"  id="btnPlus" style="width: 25px;" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" style="width: 80px; height: 35px;"><a id='lblDateas'></a></td>
						<td align="center" style="width: 70px;"><a id='lblNoq'></a></td>
						<td align="center" style="width: 100px;"><a id='lblCaritem'></a></td>
						<td align="center" style="width: 80px;"><a id='lblOutmoney'></a></td>
						<td align="center" style="width: 80px;"><a id='lblInmoney'></a></td>
						<!--<td align="center" style="width: 100px;"><a id='lblCheckno'></a></td>
						<td align="center" style="width: 100px;"><a id='lblAccount'></a></td>
						<td align="center" style="width: 200px;"><a id='lblBank'></a></td>
						<td align="center" style="width: 80px;"><a id='lblIndate'></a></td>-->
						<td align="center" style="width: 200px;"><a id='lblMemo'></a></td>
						<td align="center" style="width: 80px;"><a id='lblPaydate'></a></td>
						<td align="center" style="width: 80px;"><a id='lblFareyn'></a></td>
						<td align="center" style="width: 80px;"><a id='lblPay'></a></td>
						<td align="center" style="width: 110px;"><a id='lblAcc2'></a></td>
						<td align="center" style="width: 80px;"><a id='lblPdates'></a></td>
						<td align="center" style="width: 80px;"><a id='lblUdate'></a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
							<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td >
							<input id="txtDatea.*" type="text" class="txt c1" />
							<input id="recno.*" type="hidden" />
						</td>
						<td >
							<input id="txtNoq.*" type="text" class="txt c1"/>
							
						</td>
						<td >
							<input id="txtCaritemno.*" type="text" class="txt c5"/>
							<input class="btn"  id="btnCaritem.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
							<input id="txtCaritem.*" type="text" class="txt c1"/>
						</td>
						<td ><input id="txtOutmoney.*" type="text" class="txt num c1"/></td>
						<td ><input id="txtInmoney.*" type="text" class="txt num c1"/></td>
						<!--<td><input type="text" id="txtCheckno.*"  class="txt c1" />	</td>
						<td>	<input type="text" id="txtAccount.*"  class="txt c1" /></td>
						<td>
							<input type="button" id="btnBankno.*"  style="float:left;width:7%;" value="."/>
							<input type="text" id="txtBankno.*" class="txt c1" style="float:left;width:35%;" />
							<input type="text" id="txtBank.*" class="txt c1"style="float:left;width:47%;"/>
                    		<input type="text" id="txtTitle.*" class="txt c1"style="width:95%;" />
						</td>
						<td><input type="text" id="txtIndate.*" class="txt c1" /></td>-->
						<td ><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td ><input id="txtPaydate.*" type="text" class="txt c1"/></td>
						<td ><input id="txtFareyn.*" type="text" class="txt c1"/></td>
						<td ><input id="txtCost.*" type="text" class="txt num c1"/></td>
						<td >
							<input id="txtAcc1.*" type="text"class="txt c5"/>
							<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
							<input id="txtAcc2.*" type="text" class="txt c1"/></td>
						</td>
						<td><input type="text" id="txtPdate.*" class="txt c1" /></td>
						<td>
							<input type="text" id="txtUdate.*" class="txt c1" />
							<input type="text" id="txtUmmnoa.*" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
			</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
