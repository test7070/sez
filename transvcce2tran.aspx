<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
            var q_name = "transvcce2tran";
            var q_readonly = ['txtNoa','txtTotal','txtTotal2','txtMount','txtMount2','txtWorker','txtWorker2'];
            var q_readonlys = ['txtTotal','txtTotal2','txtTransvcceno','txtTranno','txtTaskcontent'];
            var bbmNum = [['txtMount',10,3,1],['txtTotal',10,0,1],['txtMount2',10,3,1],['txtTotal2',10,0,1]];
            var bbsNum = [['txtBmiles',10,0,1],['txtEmiles',10,0,1],['txtInmount',10,3,1],['txtPrice',10,3,1],['txtTotal',10,0,1],['txtOutmount',10,3,1],['txtPrice2',10,3,1],['txtPrice3',10,3,1],['txtTotal2',10,0,1],['txtTolls',10,0,1],['txtReserve',10,0,1],['txtGoss',10,3,1],['txtWeight',10,0,1]];
            var bbmMask = [['txtDatea','999/99/99'],['textBdate','999/99/99'],['textBBdate','999/99/99'],['textEdate','999/99/99'],['textEEdate','999/99/99']];
            var bbsMask = [['txtDatea','999/99/99'],['txtTrandate','999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            
            q_desc = 1;
            aPop = new Array(['textCustno', '', 'cust', 'noa,comp', 'textCustno,', 'cust_b.aspx'], 
            ['textBaddrno', '', 'addr', 'noa,addr', 'textBaddrno', 'addr_b.aspx'],
            ['textEaddrno', '', 'addr', 'noa,addr', 'textEaddrno', 'addr_b.aspx'],
            ['txtCarno_', '', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx'],
            ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx'],
            ['txtCustno_', '', 'cust', 'noa,comp,nick', 'txtCustno_,txtComp_,txtNick_', 'cust_b.aspx'],
            ['txtStraddrno_', '', 'addr', 'noa,addr,productno,product', 'txtStraddrno_,txtStraddr_,txtUccno_,txtProduct_', 'addr_b.aspx'],
            ['txtUccno_', '', 'ucca', 'noa,product', 'txtUccno_,txtProduct_', 'ucca_b.aspx'],
            ['txtSalesno_', '', 'sss', 'noa,namea', 'txtSalesno_,txtSales_', 'sss_b.aspx']);

            $(document).ready(function() {
                //q_bbsShow = -1;
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
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
                $('#textBdate').datepicker();
                $('#textEdate').datepicker();
                $('#textBBdate').datepicker();
                $('#textEEdate').datepicker();
                
                Lock(1,{opacity:0});
        		q_gt('carteam', '', 0, 0, 0, 'init_1');

            	//Import	
                $('#divImport').mousedown(function(e) {
                	if(e.button==2){               		
	                	$(this).data('xtop',parseInt($(this).css('top')) - e.clientY);
	                	$(this).data('xleft',parseInt($(this).css('left')) - e.clientX);
                	}
                }).mousemove(function(e) {
                	if(e.button==2 && e.target.nodeName!='INPUT'){             	
                		$(this).css('top',$(this).data('xtop')+e.clientY);
                		$(this).css('left',$(this).data('xleft')+e.clientX);
                	}
                }).bind('contextmenu', function(e) {
	            	if(e.target.nodeName!='INPUT')
                		e.preventDefault();
		        });
                $('#btn1').click(function(e){
                	$('#divImport').toggle();
                	$('#textBdate').focus();	
                });
                $('#btnDivimport').click(function(e){
                	$('#divImport').hide();
                });
                $('#textBdate').keydown(function(e){
                	if(e.which==13)
                		$('#textEdate').focus();		
                });
                $('#textEdate').keydown(function(e){
                	if(e.which==13)
                		$('#textCustno').focus();		
                });
                $('#textCustno').keydown(function(e){
                	if(e.which==13)
                		$('#textBaddrno').focus();		
                });
                $('#textBaddrno').keydown(function(e){
                	if(e.which==13)
                		$('#textEaddrno').focus();		
                });
                $('#textEaddrno').keydown(function(e){
                	if(e.which==13)
                		$('#btnDivimport').focus();		
                });
                $('#btnImport').click(function(e){
                	var t_noa = $.trim($('#txtNoa').val());
                	var t_bdate = $.trim($('#textBdate').val());
                	var t_edate = $.trim($('#textEdate').val());
                	var t_custno = $.trim($('#textCustno').val());
                	var t_baddrno = $.trim($('#textBaddrno').val());
                	var t_eaddrno = $.trim($('#textEaddrno').val());
                	
                	var t_where = "(c.noa='"+t_noa+"' or c.noa is null)";
                	if(t_bdate.length>0 || t_edate.length>0){
                		t_edate = (t_edate.length==0?"char(255)":"'"+t_edate+"'");
                		t_where += " and (isnull(b.datea,'') between '"+t_bdate+"' and "+t_edate+")";
                	}
                	if(t_custno.length>0)
                		t_where += " and (isnull(b.custno,'')='"+t_custno+"')";
                	if(t_baddrno.length>0 || t_eaddrno.length>0){
                		t_edate = (t_eaddrno.length==0?"char(255)":"'"+t_eaddrno+"'");
                		t_where += " and (isnull(a.addrno,'') between '"+t_baddrno+"' and "+t_eaddrno+")";
                	}             	
                	t_where = "where=^^"+t_where+"^^";
                	Lock();
                	q_gt('transvcce_tran', t_where, 0, 0, 0,'', r_accy);
                });
                //export
                $('#divExport').mousedown(function(e) {
                	if(e.button==2){               		
	                	$(this).data('xtop',parseInt($(this).css('top')) - e.clientY);
	                	$(this).data('xleft',parseInt($(this).css('left')) - e.clientX);
                	}
                }).mousemove(function(e) {
                	if(e.button==2 && e.target.nodeName!='INPUT'){             	
                		$(this).css('top',$(this).data('xtop')+e.clientY);
                		$(this).css('left',$(this).data('xleft')+e.clientX);
                	}
                }).bind('contextmenu', function(e) {
	            	if(e.target.nodeName!='INPUT')
                		e.preventDefault();
		        });
                
                $('#btn2').click(function(e){
                	$('#divExport').toggle();
                	$('#textBBdate').focus();
                });
                $('#btnDivexport').click(function(e){
                	$('#divExport').hide();
                });
                $('#textBBdate').keydown(function(e){
                	if(e.which==13)
                		$('#textEEdate').focus();		
                });
                $('#textEEdate').keydown(function(e){
                	if(e.which==13)
                		$('#btnDivexport').focus();		
                });
                $('#btnExport').click(function(e){
                	var t_accy = r_accy;
                	var t_bdate = $.trim($('#textBBdate').val());
                	var t_edate = $.trim($('#textEEdate').val());
                	if(r_accy.length==0 || t_bdate.length==0 || t_edate==0){
                		alert('參數異常。');
                		return;
                	}
                	Lock();
                	q_func('qtxt.query.transvcce2tran', 'transvcce2tran.txt,transvcce2tran,' + encodeURI(r_accy) + ';' + encodeURI(t_bdate) + ';' + encodeURI(t_edate));
                });
                
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.transvcce2tran':
                    	location.reload();
                    break;
                }
            }       
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'init_1':
						var as = _q_appendData("carteam", "", true);
						var t_item = "@";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						q_cmbParse("cmbCarteamno", t_item,'s');
						q_gt('calctype2', '', 0, 0, 0, 'init_2');
						break;
					case 'init_2':
						var as = _q_appendData("calctypes", "", true);
						var t_item = "@";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
						}
						q_cmbParse("cmbCalctype", t_item,'s');
						refresh(q_recno);
						Unlock(1);
						break;
                	case "transvcce_tran":
                		var as = _q_appendData("transvcce_tran", "", true);
                        if (as[0] != undefined){
                        	//alert(as.length);
                        	for(var i=0;i<q_bbsCount;i++)
                        		$('#btnMinus_'+i).click();
                        	q_gridAddRow(bbsHtm, 'tbbs', 'txtDatea,txtTrandate,cmbCalctype,cmbCarteamno,txtDiscount,txtPo,txtSalesno,txtSales,txtCarno,txtDriverno,txtDriver,txtCustno,txtComp,txtNick,txtStraddrno,txtStraddr,txtUccno,txtProduct,txtInmount,txtPton,txtMount,txtPrice,txtTotal,txtOutmount,txtPton2,txtMount2,txtPrice2,txtPrice3,txtDiscount,txtTotal2,txtTransvcceno,txtTransvccenoq,txtCommandid,txtTaskcontent,txtMemo'
                        	, as.length, as
                        	, 'datea,datea,calctype,carteamno,discount,po,salesno,sales,carno,driverno,driver,custno,comp,nick,addrno,addr,productno,product,inmount,pton,mount,price,total,outmount,pton2,mount2,price2,price3,discount,total2,transvcceno,transvccenoq,commandid,taskcontent,taskcontent', '', '');
                       		Lock();//畫面大小變動了
                       		for(var i=0;i<q_bbsCount;i++){     
                       			var t_taskcontent=$.trim($('#txtTaskcontent_'+i).val());
                       			if(t_taskcontent.length>0) {
                       				var t_caseno = '',t_caseno2 = '';
									if((/.*貨櫃號碼：([0-9,A-Z,a-z,\.,\-]+).*/g).test(t_taskcontent))
										t_caseno = (t_taskcontent).replace(/.*貨櫃號碼：([0-9,A-Z,a-z,\.,\-]+).*/g,'$1');
									if((/.*貨櫃號碼：([0-9,A-Z,a-z,\.,\-]+).*貨櫃號碼：([0-9,A-Z,a-z,\.,\-]+).*/g).test(t_taskcontent))
	            						t_caseno2 = (t_taskcontent).replace(/.*貨櫃號碼：([0-9,A-Z,a-z,\.,\-]+).*貨櫃號碼：([0-9,A-Z,a-z,\.,\-]+).*/g,'$1');
									if(t_caseno.length>0){
										if(t_caseno2.length>0){
										//	$('#txtCaseno2_'+i).val(t_caseno);
											$('#txtCaseno_'+i).val(t_caseno2);
										}else{
											//alert(t_caseno+'\n'+t_caseno.substring(0,11)+'\n'+t_caseno.substring(11,23));
											if(t_caseno.length>11){
												$('#txtCaseno_'+i).val(t_caseno.substring(0,11));
											//	$('#txtCaseno2_'+i).val(t_caseno.substring(11,t_caseno.length));
											}else{
												$('#txtCaseno_'+i).val(t_caseno);
											}
										}
									}
                       			}			
                       		}
                       		sum();
            				Unlock();
                        }else{
                        	alert('無資料。');
                        	Unlock();
                        }
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,11)=='addrchange1'){
                    		var t_sel = parseInt(t_name.split('_')[1]);
                    		var as = _q_appendData("addrs", "", true);
                    		if (as[0] != undefined){
                    			$('#txtPrice_'+t_sel).val(FormatNumber(as[0].custprice));
		            			$('#txtPrice2_'+t_sel).val(FormatNumber(as[0].driverprice));
		            			$('#txtPrice3_'+t_sel).val(FormatNumber(as[0].driverprice2));
		            			t_where = "where=^^carno='"+$.trim($('#txtCarno_'+t_sel).val())+"'^^";
                				q_gt('car2', t_where, 0, 0, 0,'addrchange2_'+t_sel, r_accy);
                    		}
                    	}else if(t_name.substring(0,11)=='addrchange2'){
                    		var t_sel = parseInt(t_name.split('_')[1]);
                    		var as = _q_appendData("car2", "", true);
                    		if (as[0] != undefined && as[0].cartype=='2'){
                    			//公司車
                    			$('#txtPrice3_'+t_sel).val(0);
                    		}else{
                    			$('#txtPrice2_'+t_sel).val(0);
                    		}
                    		sum();
                    	}else if(t_name.substring(0,8)=='btnModi1'){
                    		var t_sel = parseInt(t_name.split('_')[1]);
                    		var as = _q_appendData("view_trds", "", true);
                    		if (as[0] != undefined){
                    			$('#btnMinus_'+t_sel).attr('disabled','disabled');
                    			$('#txtDatea_'+t_sel).attr('readonly','readonly').css('color','green');
                    			$('#txtTrandate_'+t_sel).attr('readonly','readonly').css('color','green');	
                    			$('#txtCustno_'+t_sel).attr('readonly','readonly').css('color','green');
                    			$('#txtComp_'+t_sel).attr('readonly','readonly').css('color','green');
                    			$('#txtStraddrno_'+t_sel).attr('readonly','readonly').css('color','green');
                    			$('#txtStraddr_'+t_sel).attr('readonly','readonly').css('color','green');
                    			$('#txtInmount_'+t_sel).attr('readonly','readonly').css('color','green');
                    			$('#txtPrice_'+t_sel).attr('readonly','readonly').css('color','green');
                    		}
                    		t_where = "where=^^carno='"+$.trim($('#txtCarno_'+t_sel).val())+"'^^";
                			q_gt('car2', t_where, 0, 0, 0,'btnModi2_'+t_sel, r_accy);
                    	}else if(t_name.substring(0,8)=='btnModi2'){
                    		var t_sel = parseInt(t_name.split('_')[1]);
                    		var as = _q_appendData("car2", "", true);
                    		if (as[0] != undefined && as[0].cartype=='2'){
                    			//公司車
                    			t_datea = $('#txtDatea_'+t_sel).val();
                    			q_gt('carsal', "where=^^ noa='"+t_datea.substring(0,6)+"' ^^", 0, 0, 0, 'btnModi3_'+t_sel,r_accy);
                    		}else{
                    			t_tranno = $('#txtTranno_'+t_sel).val();
                    			q_gt('view_tres', "where=^^ tranno='"+t_tranno+"' ^^", 0, 0, 0, 'btnModi4_'+t_sel,r_accy);
                    		}
                    	}else if(t_name.substring(0,8)=='btnModi3'){
                    		var t_sel = parseInt(t_name.split('_')[1]);
                    		var as = _q_appendData("carsal", "", true);
							if(as[0]!=undefined){
								if(as[0].lock=="true" || as[0].lock=="1"){
									$('#btnMinus_'+t_sel).attr('disabled','disabled');
									$('#cmbCalctype_'+t_sel).attr('disabled','disabled');
									$('#cmbCarteamno_'+t_sel).attr('disabled','disabled');
									
									$('#txtCarno_'+t_sel).attr('readonly','readonly').css('color','green');
									$('#txtDriverno_'+t_sel).attr('readonly','readonly').css('color','green');
									$('#txtDriver_'+t_sel).attr('readonly','readonly').css('color','green');
									
									$('#txtStraddrno_'+t_sel).attr('readonly','readonly').css('color','green');
									$('#txtStraddr_'+t_sel).attr('readonly','readonly').css('color','green');
									$('#txtOutmount_'+t_sel).attr('readonly','readonly').css('color','green');
									$('#txtPrice2_'+t_sel).attr('readonly','readonly').css('color','green');
									$('#txtPrice3_'+t_sel).attr('readonly','readonly').css('color','green');
									$('#txtDiscount_'+t_sel).attr('readonly','readonly').css('color','green');
									$('#txtTolls_'+t_sel).attr('readonly','readonly').css('color','green');
									$('#txtReserve_'+t_sel).attr('readonly','readonly').css('color','green');
								}
							}
							//done
							check_btnModi(t_sel-1);
                    	}else if(t_name.substring(0,8)=='btnModi4'){
                    		var t_sel = parseInt(t_name.split('_')[1]);
                    		var as = _q_appendData("view_tres", "", true);
							if(as[0]!=undefined){
								$('#btnMinus_'+t_sel).attr('disabled','disabled');
								$('#cmbCalctype_'+t_sel).attr('disabled','disabled');
								$('#cmbCarteamno_'+t_sel).attr('disabled','disabled');
									
								$('#txtCarno_'+t_sel).attr('readonly','readonly').css('color','green');
								$('#txtDriverno_'+t_sel).attr('readonly','readonly').css('color','green');
								$('#txtDriver_'+t_sel).attr('readonly','readonly').css('color','green');
								
								$('#txtStraddrno_'+t_sel).attr('readonly','readonly').css('color','green');
								$('#txtStraddr_'+t_sel).attr('readonly','readonly').css('color','green');
								$('#txtOutmount_'+t_sel).attr('readonly','readonly').css('color','green');
								$('#txtPrice2_'+t_sel).attr('readonly','readonly').css('color','green');
								$('#txtPrice3_'+t_sel).attr('readonly','readonly').css('color','green');
								$('#txtDiscount_'+t_sel).attr('readonly','readonly').css('color','green');
								$('#txtTolls_'+t_sel).attr('readonly','readonly').css('color','green');
								$('#txtReserve_'+t_sel).attr('readonly','readonly').css('color','green');
							}
							//done
							check_btnModi(t_sel-1);
                    	}
                    	break;
                }
            }
            function q_popPost(id) {
				switch(id) {
					case 'txtStraddrno_':
						$('#txtPrice_'+b_seq).val('0');
						$('#txtPrice2_'+b_seq).val('0');
						$('#txtPrice3_'+b_seq).val('0');
						var t_addrno = $.trim($('#txtStraddrno_'+b_seq).val());
						var t_trandate = $.trim($('#txtTrandate_'+b_seq).val());
						if(t_addrno.length>0 && t_trandate.length>0){
							t_where = "where=^^noa='"+t_addrno+"' and datea<='"+t_trandate+"'^^";
                			q_gt('addrs_lasttime', t_where, 0, 0, 0,'addrchange1_'+b_seq, r_accy);
						}
						break;
				}
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
			function q_stPost() {
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if($('#txtDatea').val().substring(0,3)!=r_accy){
					alert('年度異常錯誤，請切換到【'+$('#txtDatea').val().substring(0,3)+'】年度再作業。');
					Unlock(1);
            		return;
				}
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!");
                }       
                for(var i=0;i<q_bbsCount;i++){
                	$('#txtMon_'+i).val($('#txtDatea_'+i).val().substring(0,6));
                	$('#txtMon2_'+i).val($('#txtTrandate_'+i).val().substring(0,6));
                }  
                sum();

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_transvcce2tran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('transvcce2tran_s.aspx', q_name + '_s', "600px", "450px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtInmount_'+i).change(function(){
                			sum();
                		});
                		$('#txtPrice_'+i).change(function(){
                			sum();
                		});
                		$('#txtOutmount_'+i).change(function(){
                			sum();
                		});
                		$('#txtPrice2_'+i).change(function(){
                			sum();
                		});
                		$('#txtPrice3_'+i).change(function(){
                			sum();
                		});
                		$('#txtDiscount_'+i).change(function(){
                			sum();
                		});
                		$('#txtTranno_'+i).click(function(e){
                			var t_noa = $.trim($(this).val());
                			if(t_noa.length>0)
                				q_pop('', "trans.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='"+t_noa+"';" + r_accy + '_' + r_cno+";", 'trans', 'noa', 'datea', "95%", "95%", q_getMsg('popTrans'), true);
                		});
                		$('#txtTransvcceno_'+i).click(function(e){
                			var t_noa = $.trim($(this).val());
                			if(t_noa.length>0)
                				q_pop('', "transvcce.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='"+t_noa+"';" + r_accy + '_' + r_cno+";", 'trans', 'noa', 'datea', "95%", "95%", q_getMsg('popTransvcce'), true);
                		});
                    }
                }
                _bbsAssign();
                for(var i=0;i<q_bbsCount;i++)
                	$('#txtDatea_'+i).css('color','red');
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
            	if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                _btnModi();
                check_btnModi(q_bbsCount-1);
            }
			function check_btnModi(n){
				if(n<0){
					Unlock(1);
				}else{
					var t_tranno = $.trim($('#txtTranno_'+n).val());
					var t_trannoq = $.trim($('#txtTrannoq_'+n).val());
					if(t_tranno.length>0){
						t_where=" where=^^ tranno='"+t_tranno+"' and trannoq='"+t_trannoq+"'^^";
            			q_gt('view_trds', t_where, 0, 0, 0, "btnModi1_"+n, r_accy);
					}else{
						check_btnModi(n-1);
					}
				}
            }
            function btnPrint() {
                q_box('z_transvcce2tran.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['transvcceno'] || !as['transvccenoq'] ) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
               	var t_val,t_total=0,t_mount=0,t_total2=0,t_mount2=0;
               	for(var i=0;i<q_bbsCount;i++){
               		$('#txtMount_'+i).val(FormatNumber(q_float('txtInmount_'+i).add(q_float('txtPton_'+i))));
               		t_val = q_float('txtPrice_'+i).mul(q_float('txtMount_'+i)).round(0);
               		t_mount+=q_float('txtMount_'+i);
               		t_total+=t_val;
               		$('#txtTotal_'+i).val(FormatNumber(t_val));
               		$('#txtMount2_'+i).val(FormatNumber(q_float('txtOutmount_'+i).add(q_float('txtPton2_'+i))));
               		t_val = (q_float('txtPrice2_'+i).add(q_float('txtPrice3_'+i))).mul(q_float('txtMount2_'+i)).mul(q_float('txtDiscount_'+i)).round(0);
               		t_mount2+=q_float('txtMount2_'+i);
               		t_total2+=t_val;
               		$('#txtTotal2_'+i).val(FormatNumber(t_val));
               		$('#txtMiles_'+i).val(q_float('txtEmiles_'+i)-q_float('txtBmiles_'+i));
               	}
               	$('#txtMount').val(FormatNumber(t_mount)); 
               	$('#txtMount2').val(FormatNumber(t_mount2)); 
               	$('#txtTotal').val(FormatNumber(t_total)); 
               	$('#txtTotal2').val(FormatNumber(t_total2));     
            }
            function refresh(recno) {
                _refresh(recno);
                
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                $('#btnPlus').attr('disabled','disabled');
                if(q_cur==1){
                	$('#btn1').removeAttr('disabled');
                }else{
                	$('#btn1').attr('disabled','disabled');
                	$('#divImport').hide();
                }
                if(q_cur==1 || q_cur==2){
                	$('#btn2').attr('disabled','disabled');
                	$('#divExport').hide();
                }else{
                	$('#btn2').removeAttr('disabled');
                }
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
			    return Math.round(this.mul( Math.pow(10,arg))).div( Math.pow(10,arg));
			};
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			};
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length; } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length; } catch (e) { }
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
			    try { m += s1.split(".")[1].length; } catch (e) { }
			    try { m += s2.split(".")[1].length; } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			};
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length; } catch (e) { r1 = 0; }
			    try { r2 = arg2.toString().split(".")[1].length; } catch (e) { r2 = 0; }
			    m = Math.pow(10, Math.max(r1, r2));
			    return (Math.round(arg1 * m) + Math.round(arg2 * m)) / m;
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			};
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length; } catch (e) { r1 = 0; }
			    try { r2 = arg2.toString().split(".")[1].length; } catch (e) { r2 = 0; }
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
                width: 150px;
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

		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="divImport" style="display:none;position:absolute;top:100px;left:600px;width:400px;height:250px;background:RGB(237,237,237);"> 
			<table style="border:4px solid gray; width:100%; height: 100%;">
				<tr style="height:1px;background-color: #cad3ff;">
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
				</tr>
				<tr>		
					<td style="padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"><a>派車日期</a></td>
					<td colspan="3" style="padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;">
						<input type="text" id="textBdate" style="float:left;width:40%;"/>
						<span style="float:left;width:5%;">~</span>
						<input type="text" id="textEdate" style="float:left;width:40%;"/>
					</td>
				</tr>
				<tr>		
					<td style="padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"><a>客戶編號</a></td>
					<td colspan="3" style="padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;">
						<input type="text" id="textCustno" style="float:left;width:95%;"/>
					</td>
				</tr>
				<tr>		
					<td style="padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"><a>起迄地點</a></td>
					<td colspan="3" style="padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;">
						<input type="text" id="textBaddrno" style="float:left;width:40%;"/>
						<span style="float:left;width:5%;">~</span>
						<input type="text" id="textEaddrno" style="float:left;width:40%;"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" style="background-color: #cad3ff;">
						<input type="button" id="btnImport" value="匯入"/>	
					</td>
					<td colspan="2" align="center" style=" background-color: #cad3ff;">
						<input type="button" id="btnDivimport" value="關閉"/>	
					</td>
				</tr>
			</table>
		</div>
		<div id="divExport" style="display:none;position:absolute;top:100px;left:600px;width:400px;height:120px;background:RGB(237,237,237);"> 
			<table style="border:4px solid gray; width:100%; height: 100%;">
				<tr style="height:1px;background-color: pink;">
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
					<td style="width:25%;"> </td>
				</tr>
				<tr>		
					<td style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;color: blue;"><a>登錄日期</a></td>
					<td colspan="3" style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;">
						<input type="text" id="textBBdate" style="float:left;width:40%;"/>
						<span style="float:left;width:5%;">~</span>
						<input type="text" id="textEEdate" style="float:left;width:40%;"/>
					</td>
				</tr>	
				<tr>
					<td colspan="2" align="center" style="background-color: pink;">
						<input type="button" id="btnExport" value="匯出"/>	
					</td>
					<td colspan="2" align="center" style=" background-color: pink;">
						<input type="button" id="btnDivexport" value="關閉"/>	
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewDatea"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount2" class="lbl"> </a></td>
						<td><input id="txtMount2" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTotal2" class="lbl"> </a></td>
						<td><input id="txtTotal2" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td><input type="button" id="btn1" value="匯入" style="float:left;"/></td>
						<td><input type="button" id="btn2" value="匯出" style="float:left;"/></td>
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
					<td align="center" style="width:150px;"><a> 登錄日期<br>交運日期</a></td>
					<td align="center" style="width:100px;"><a> 車牌</a></td>
					<td align="center" style="width:100px;"><a> 司機</a></td>
					<td align="center" style="width:100px;"><a> 客戶</a></td>
					<td align="center" style="width:100px;"><a> 計算類別<br>車隊 </a></td>
					<td align="center" style="width:150px;"><a> 起迄地點</a></td>
					<td align="center" style="width:100px;"><a> 產品</a></td>
					<td align="center" style="width:200px;"><a> 櫃號</a></td>
					<td align="center" style="width:100px;"><a> 里程數<br>起/迄</a></td>
					<td align="center" style="width:100px;"><a> 收數量</a></td>
					<td align="center" style="width:120px;"><a> 客戶單價</a></td>
					<td align="center" style="width:100px;"><a> 收金額</a></td>
					<td align="center" style="width:100px;"><a> 發數量</a></td>
					<td align="center" style="width:120px;"><a> 司機單價</a></td>
					<td align="center" style="width:120px;"><a> 外車單價</a></td>
					<td align="center" style="width:100px;"><a> 折扣</a></td>
					<td align="center" style="width:100px;"><a> 發金額</a></td>
					
					<td align="center" style="width:100px;"><a> 通行費<br>寄櫃費 </a></td>
					<td align="center" style="width:100px;"><a> 總重<br>淨重 </a></td>
					<td align="center" style="width:100px;"><a> PO<br>憑單</a></td>
					<td align="center" style="width:100px;"><a> 外務</a></td>
					<td align="center" style="width:200px;"><a> 備註</a></td>
					<td align="center" style="width:200px;"><a> 派車單</a></td>
					<td align="center" style="width:200px;"><a> 出車單</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input type="text" id="txtDatea.*" style="width:95%;" />
						<input type="text" id="txtMon.*" style="display:none;" />
						<input type="text" id="txtTrandate.*" style="width:95%;" />
						<input type="text" id="txtMon2.*" style="display:none;" />
					</td>
					<td><input type="text" id="txtCarno.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtDriverno.*" style="width:95%;float:left;" />
						<input type="text" id="txtDriver.*" style="width:95%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtCustno.*" style="width:95%;float:left;" />
						<input type="text" id="txtComp.*" style="width:95%;float:left;" />
						<input type="text" id="txtNick.*" style="display:none;" />
					</td>
					<td>
						<select id="cmbCalctype.*" style="width:95%;float:left;"> </select>
						<select id="cmbCarteamno.*" style="width:95%;float:left;"> </select>
					</td>
					<td>
						<input type="text" id="txtStraddrno.*" style="width:95%;float:left;" />
						<input type="text" id="txtStraddr.*" style="width:95%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtUccno.*" style="width:95%;float:left;" />
						<input type="text" id="txtProduct.*" style="width:95%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtCaseno.*" style="width:95%;float:left;" />
						<input type="text" id="txtCaseno2.*" style="width:95%;float:left;display:none;" />
					</td>
					<td>
						<input type="text" id="txtBmiles.*" style="width:95%;float:left;text-align: right;" />
						<input type="text" id="txtEmiles.*" style="width:95%;float:left;text-align: right;color:darkred;" />
						<input type="text" id="txtMiles.*" style="width:95%;float:left;text-align: right;display:none;" />
						<input type="text" id="txtGps.*" style="width:20%;float:left;text-align: right;display:none;" />
					</td>
					<td>
						<input type="text" id="txtInmount.*" style="width:95%;text-align: right;" />
						<input type="text" id="txtPton.*" style="display:none;text-align: right;" />
						<input type="text" id="txtMount.*" style="display:none;text-align: right;" />
					</td>
					<td><input type="text" id="txtPrice.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtTotal.*" style="width:95%;text-align: right;" /></td>
					<td>
						<input type="text" id="txtOutmount.*" style="width:95%;text-align: right;;" />
						<input type="text" id="txtPton2.*" style="display:none;text-align: right;" />
						<input type="text" id="txtMount2.*" style="display:none;text-align: right;" />
					</td>
					<td><input type="text" id="txtPrice2.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtPrice3.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtDiscount.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtTotal2.*" style="width:95%;text-align: right;" /></td>					
					<td>
						<input type="text" id="txtTolls.*" style="width:95%;text-align: right;" />
						<input type="text" id="txtReserve.*" style="width:95%;text-align: right;" />
					</td>
					<td>
						<input type="text" id="txtGross.*" style="width:95%;text-align: right;" />
						<input type="text" id="txtWeight.*" style="width:95%;text-align: right;" />
					</td>
					<td>
						<input type="text" id="txtPo.*" style="width:95%;float:left;" />
						<input type="text" id="txtCustorde.*" style="width:95%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtSalesno.*" style="width:95%;float:left;" />
						<input type="text" id="txtSales.*" style="width:95%;float:left;" />
					</td>
					<td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtTransvcceno.*" style="width:95%;" />
						<input type="text" id="txtTransvccenoq.*" style="display:none;" />
						<input type="text" id="txtCommandid.*" style="display:none;" />
						<input type="text" id="txtTaskcontent.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtTranno.*" style="width:95%;" />
						<input type="text" id="txtTrannoq.*" style="display:none;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
