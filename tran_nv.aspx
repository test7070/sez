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
            q_tables = 's';
            var q_name = "tran";
            var q_readonly = ['txtNoa', 'txtWeight', 'txtVolume', 'txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [['txtMount', 10, 3, 1],['txtVolume', 10, 0, 1], ['txtWeight', 10, 3, 1], ['txtTotal', 10, 0, 1], ['txtTotal2', 10, 0, 1]];
            var bbsNum = [['txtMount', 10, 0, 1], ['txtOutmount', 10, 0, 1], ['txtInmount', 10, 0, 1], ['txtMount2', 10, 0, 1], ['txtWeight', 10, 3, 1], ['txtWeight2', 10, 3, 1], 
            			 ['txtMiles', 10, 0, 1], ['txtGross', 10, 3, 1], ['txtWeight3', 10, 3, 1], ['txtPton', 10, 3, 1], ['txtPrice', 10, 3, 1], ['txtPrice2', 10, 3, 1], ['txtCustprice', 10, 3, 1], ['txtMount3', 10, 3, 1], 
            			 ['txtCustdiscount', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtTotal2', 10, 0, 1], ['txtDiscount', 10, 0, 1]];
            var bbmMask = [['txtDatea', '999/99/99'],['txtTrandate', '999/99/99'],['textMon','999/99']];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            aPop = new Array(['txtDriverno', 'lblDriverno', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            , ['txtAddrno', 'lblAddrno', 'store', 'noa,store', 'txtAddrno,txtAddr', 'store_b.aspx']
            , ['txtCaseno_', 'btnCaseno_', 'store', 'noa,store', 'txtCaseno_', 'store_b.aspx']
            , ['txtTggno_', 'btnTgg_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', 'tgg_b.aspx']
            , ['txtUccno_', 'btnProduct_', 'ucc', 'noa,product', 'txtUccno_,txtProduct_', 'ucc_b.aspx']
            , ['txtStraddrno_', 'btnStraddr_', 'addr', 'noa,addr', 'txtStraddrno_,txtStraddr_', 'addr_b.aspx']
            , ['txtCustno_', 'btnCust_', 'cust', 'noa,comp,nick,addr_home,memo2,salesno2,typea,custno2,mprice', 'txtCustno_,txtComp_,txtNick_,txtSaddr_,txtAaddr_,txtCaseno2_,cmbUnit2_,cmbStatus_,textOverh_', 'cust_b.aspx']
            , ['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']
            , ['txtDriver_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']
            , ['txtCardealno_', 'btnCardeal_', 'carplate', 'noa', 'txtCardealno_', 'carplate_b.aspx']);

            $(document).ready(function() {
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
                window.parent.document.title='出車作業'
            }

            function sum() {
            	var t_tmount=0,t_tvolume=0,t_tweight=0,t_ttotal=0,t_ttotal2=0;
             	var t_mount=0,t_weight=0,t_pton=0,t_total=0,t_total2=0;
             	for(var i=0;i<q_bbsCount;i++){
             		t_weight = q_sub(q_float('txtGross_'+i),q_float('txtWeight3_'+i));
             		t_pton = q_sub(q_float('txtWeight2_'+i),t_weight);
             		t_mount = q_sub(q_float('txtOutmount_'+i),q_float('txtInmount_'+i));
             		t_total = round(q_mul(q_add(q_float('txtCustprice_'+i),q_float('txtPrice_'+i)),t_weight),0);
             		if($('#textOverh_'+i).val()!=0){
             		    $('#txtOverh_'+i).val(q_mul(t_total,q_div($('#textOverh_'+i).val(),100)));
             		}
             		if($('#cmbCalctype_'+i).val()==1){
             		    $('#txtMount3_'+i).val(dec($('#txtPrice_'+i).val())*0.9*0.2);
             		}else if($('#cmbCalctype_'+i).val()==2){
             		    $('#txtMount3_'+i).val(dec($('#txtPrice_'+i).val())*0.82);
             		}else if($('#cmbCalctype_'+i).val()==3){
             		    $('#txtMount3_'+i).val(dec($('#txtPrice_'+i).val())*0.85);
             		}else if($('#cmbCalctype_'+i).val()==4){
                        $('#txtMount3_'+i).val($('#txtPrice_'+i).val());
                    }else if($('#cmbCalctype_'+i).val()==5){
             		    $('#txtMount3_'+i).val(dec($('#txtPrice_'+i).val())*0.91);
             		}else if($('#cmbCalctype_'+i).val()==6){
             		    $('#txtMount3_'+i).val(dec($('#txtPrice_'+i).val())*0.9);
             		}else if($('#cmbCalctype_'+i).val()==7){
                        $('#txtMount3_'+i).val(dec($('#txtPrice_'+i).val())*0.25);
                    }else{
             		    $('#txtMount3_'+i).val();
             		}
             		if($('#txtUnit_'+i).val()=='趟'){
             		    t_total2 = q_mul(q_float('txtMount3_'+i),q_float('txtMount2_'+i));
             		}else{
             		    t_total2 = q_mul(q_float('txtMount3_'+i),t_weight);
             		}
             		t_tmount = q_add(t_tmount,q_sub(q_float('txtOutmount_'+i),q_float('txtInmount_'+i)));
             		t_tvolume = q_add(t_tvolume,q_float('txtInmount_'+i));
             		t_tweight = q_add(t_tweight,t_weight);
             		t_ttotal = q_add(t_ttotal,t_total);
             		t_ttotal2 = q_add(t_ttotal2,t_total2);
             		$('#txtWeight_'+i).val(t_weight);
             		$('#txtPton_'+i).val(t_pton);
             		$('#txtMount_'+i).val(t_mount);
             		$('#txtTotal_'+i).val(t_total);
             		$('#txtTotal2_'+i).val(t_total2);
             	}
             	$('#txtMount').val(t_tmount);
             	$('#txtVolume').val(t_tvolume);
             	$('#txtWeight').val(t_tweight);
             	$('#txtTotal').val(t_ttotal);
             	$('#txtTotal2').val(t_ttotal2);
             	
            }

            function mainPost() {
            	q_mask(bbmMask);
                q_getFormat();
                bbsMask = [['txtDatea', r_picd],['txtCldate', r_picd],['txtLtime','99:99'],['txtStime','99:99'],['txtDtime','99:99']];
                q_cmbParse("cmbUnit2",'1@上班時間 ,2@指定時間,3@24小時皆可','s');
            	q_cmbParse("cmbTtype",'N@無,Y@有','s');
            	q_cmbParse("cmbStatus",'未稅@未稅,含稅@含稅','s');
            	q_cmbParse("combCaseno2",'50T@50T,100T@100T,150T@150T,200T@200T,300T@300T','s');
            	q_cmbParse("cmbCalctype",'@,1@公司車*0.9*0.2,2@外車*0.82,3@外車*0.85,4@外車*100%,5@靠車*0.91,6@靠車*0.9,7@混凝土車*0.25','s');
            	$('#lblVolume').text('目前數量');
            	
            	$('#lblAddrno').click(function() {
            			$('#lblVolume').show();
						$('#txtVolume').show();
				});
				$('#txtAddrno').change(function() {
            			$('#lblVolume').show();
						$('#txtVolume').show();
				});	
				
				$('#btnImport').click(function() {
                    $('#divImport').toggle();
                    $('#textBdate').focus();
                });
                $('#btnCancel_import').click(function() {
                    $('#divImport').toggle();
                });
                
                //第一次只KEY月分做所有處理廠匯入,後續才能KEY處理廠做BBS變動,否則資料不新增
                $('#btnImport_trans').click(function() {
                   if(q_cur != 1 && q_cur != 2){
                        var t_key = q_getPara('sys.key_payb');
                        var t_mon = $('#textMon').val();
                        t_key = (t_key.length==0?'FC':t_key);//一定要有值
                        if(t_mon.length==0){
                            alert('請輸入月份'+q_getMsg('lblMon')+'!!');
                            return;
                        }else{
                            q_func('qtxt.query.tranpayb_nv', 'tran.txt,tranpaybnv,' + encodeURI(t_key) + ';'+ encodeURI(t_mon)); 
                        }    
                   }
                });
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.tranpayb_nv':
                        var as = _q_appendData("tmp0", "", true, true);
                        alert(as[0].msg);
                        break;
                    default:
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

            function q_gtPost(t_name) {
                switch (t_name) {
                case 'addrs':
                    var as = _q_appendData("addrs", "", true);
                    if (as[0] != undefined) {
                          for(var i=0;i<q_bbsCount;i++){
                              if($('#txtStraddrno_'+i).val()==as[0].noa){
                                      $('#txtPrice_'+i).val(as[0].custprice);  
                              }      
                          }
                    }
                    for(var i=0;i<q_bbsCount;i++){
                        if(!emp($('#txtUccno_'+i).val()) && !emp($('#txtCustno_'+i).val())){
                           var t_where = "where=^^ noa=(select top 1 noa from view_trans"+r_accy+" where uccno='"+$('#txtUccno_'+i).val()+"' and custno='"+$('#txtCustno_'+i).val()+"' and datea<='"+$('#txtDatea').val()+"' order by datea desc) and uccno='"+$('#txtUccno_'+i).val()+"' and custno='"+$('#txtCustno_'+i).val()+"' ^^";
                           q_gt('trans', t_where, 0, 0, 0, "trans", r_accy, 1); 
                        } 
                    }
                    break;
                case 'trans':
                    var as = _q_appendData("trans", "", true);
                        if (as[0] != undefined) {
                             for(var i=0;i<q_bbsCount;i++){
                                 if($('#txtCustno_'+i).val()==as[0].custno && $('#txtUccno_'+i).val()==as[0].uccno){
                                     if($('#txtPrice_'+i).val().length==0){
                                         $('#txtPrice_'+i).val(as[0].price);
                                     }
                                     
                                     if($('#txtPrice2_'+i).val().length==0){
                                         $('#txtPrice2_'+i).val(as[0].price2);
                                     }
                                     
                                     if($('#txtCustprice_'+i).val().length==0){
                                         $('#txtCustprice_'+i).val(as[0].custprice);
                                     }
                                 }    
                             }
                        }    
                    break;
                case 'trans_cost':
                    var as = _q_appendData("trans", "", true);
                        if (as[0] != undefined) {
                             for(var i=0;i<q_bbsCount;i++){
                                 if($('#txtCustno_'+i).val()==as[0].custno && $('#txtUccno_'+i).val()==as[0].uccno && !emp($('#txtUccno_'+i).val()) && !emp($('#txtCustno_'+i).val()))
                                     $('#txtCustprice_'+i).val(as[0].custprice);
                                     $('#txtPrice2_'+i).val(as[0].price2);
                             }
                        }    
                    break;
                case q_name:
                    if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
                }
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtCustno_':
                        var t_where = "where=^^ noa=(select noa from addr where productno='"+$('#txtUccno_'+b_seq).val()+"' and noa='"+$('#txtStraddrno_'+b_seq).val()+"' and caseuseno='"+$('#txtCustno_'+b_seq).val()+"') and datea<='"+$('#txtDatea').val()+"' ^^";
                        q_gt('addrs', t_where, 0, 0, 0, "addrs", r_accy, 1);
                        break;
                    case 'txtUccno_':
                        var t_where = "where=^^ noa=(select noa from addr where productno='"+$('#txtUccno_'+b_seq).val()+"' and noa='"+$('#txtStraddrno_'+b_seq).val()+"' and caseuseno='"+$('#txtCustno_'+b_seq).val()+"') and datea<='"+$('#txtDatea').val()+"' ^^";
                        q_gt('addrs', t_where, 0, 0, 0, "addrs", r_accy, 1);
                        break;
                    case 'txtStraddrno_':
                        var t_where = "where=^^ noa=(select noa from addr where productno='"+$('#txtUccno_'+b_seq).val()+"' and noa='"+$('#txtStraddrno_'+b_seq).val()+"' and caseuseno='"+$('#txtCustno_'+b_seq).val()+"') and datea<='"+$('#txtDatea').val()+"' ^^";
                        q_gt('addrs', t_where, 0, 0, 0, "addrs", r_accy, 1);
                        break;
                }
                
            }

            function btnOk() {
            	sum();
            	for(var i=0;i<q_bbsCount;i++){
            			if(($('#txtPton_' + i).val()>0.3) && ($('#txtUnit_' + i).val()=='噸' || $('#txtUnit_' + i).val().toUpperCase()=='T') && emp($('#txtMemo_' + i).val())){
							$('#txtMemo_' + i).val('出廠-到廠淨重超過0.3t'+$('#txtMemo_' + i).val());
						}else if(($('#txtPton_' + i).val()<0.3) && !emp($('#txtMemo_' + i).val())){
							$('#txtMemo_' + i).val($('#txtMemo_' + i).val());
						}else{
							$('#txtMemo_' + i).val($('#txtMemo_' + i).val());
						}
				}     
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtOdate').val());
                if (q_cur ==1)
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tran_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;                
                    $('#txtTggno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnTgg_'+n).click();
                    });

                    $('#txtCustno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCust_'+n).click();
                    });
                    $('#txtCaseno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCaseno_'+n).click();
                    });
                    $('#txtUccno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnProduct_'+n).click();
                    });

                    $('#txtStraddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnStraddr_'+n).click();
                    });
                    $('#txtCarno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCarno_'+n).click();
                    });
                    
                    $('#txtDriver_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnDriver_'+n).click();
                    });
                    
                    $('#txtCardeal_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCardeal_'+n).click();
                    });
                    
                    $('#combCaseno2_' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtCaseno2_'+b_seq).val($('#combCaseno2_'+b_seq).find("option:selected").text());
					});
					
					$("#txtUccno_"+i).change(function() {
					    t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        var t_where = "where=^^ noa=(select noa from addr where productno='"+$('#txtUccno_'+b_seq).val()+"' and noa='"+$('#txtStraddrno_'+b_seq).val()+"' and caseuseno='"+$('#txtCustno_'+b_seq).val()+"') and datea<='"+$('#txtDatea').val()+"' ^^";
                        q_gt('addrs', t_where, 0, 0, 0, "addrs", r_accy, 1);
                    });
                    
                    $("#txtCustno_"+i).change(function() {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        var t_where = "where=^^ noa=(select noa from addr where productno='"+$('#txtUccno_'+b_seq).val()+"' and noa='"+$('#txtStraddrno_'+b_seq).val()+"' and caseuseno='"+$('#txtCustno_'+b_seq).val()+"') and datea<='"+$('#txtDatea').val()+"' ^^";
                        q_gt('addrs', t_where, 0, 0, 0, "addrs", r_accy, 1);
                    });
                    
                    $("#txtStraddrno_"+i).change(function() {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        var t_where = "where=^^ noa=(select noa from addr where productno='"+$('#txtUccno_'+b_seq).val()+"' and noa='"+$('#txtStraddrno_'+b_seq).val()+"' and caseuseno='"+$('#txtCustno_'+b_seq).val()+"') and datea<='"+$('#txtDatea').val()+"' ^^";
                        q_gt('addrs', t_where, 0, 0, 0, "addrs", r_accy, 1);
                    });
                
                    $('#txtOutmount_' + i).change(function() {
                        sum();
                    });
                    $('#txtInmount_' + i).change(function() {
                        sum();
                    });
                    $('#txtGross_' + i).change(function() {
                        sum();
                    });
                    $('#txtWeight3_' + i).change(function() {
                        sum();
                    });
                    $('#txtWeight2_' + i).change(function() {
                        sum();
                    });
                    $('#txtWeight_' + i).change(function() {
                        sum();
                    });
                    $('#txtCustprice_' + i).change(function() {
                        sum();
                    });
                    $('#txtPrice_' + i).change(function() {
                        sum();
                    });
                    $('#txtPrice2_' + i).change(function() {
                        sum();
                    });
                    $('#txtMount3_' + i).change(function() {
                        sum();
                    });
                    $('#cmbCalctype_' + i).change(function() {
                        sum();
                    });
                }
                _bbsAssign();
                $('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txttrandate').val(q_date());
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            	q_box("z_tran_nw.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'trans_mul', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function bbsSave(as) {
                if (!as['straddrno'] && !as['custno'] && !as['productno'] && !as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                as['trandate'] = abbm2['trandate'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                if(!emp($('#txtAddrno').val())){
					$('#lblVolume').show();
					$('#txtVolume').show();
				}
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
					$('#txtDatea').datepicker('destroy');
					$('#txtTrandate').datepicker('destroy');
				}else{
					$('#txtDatea').datepicker();
					$('#txtTrandate').datepicker();
				}
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
                q_box('tran_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
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
                overflow: auto;
            }
            .dview {
                float: left;
                width: 400px;
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
                width: 630px;
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
                width: 12%;
            }
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
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
                width: 3700px;
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
            .font1 {
                font-family: "細明體", Arial, sans-serif;
            }
            #tableTranordet tr td input[type="text"] {
                width: 80px;
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
	   <div id="divImport" style="position:absolute; top:250px; left:600px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
            <table style="width:100%;">
                <tr style="height:1px;">
                    <td style="width:150px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                </tr>
                <tr style="height:35px;">
                    <td><span> </span><a id="lblMon" style="float:right; color: blue; font-size: medium;">月份</a></td>
                    <td colspan="4">
                    <input id="textMon"  type="text" style="float:left; width:100px; font-size: medium;"/>
                    </td>
                </tr>              
                <tr style="height:35px;">
                    <td> </td>
                    <td><input id="btnImport_trans" type="button" value="付款"/></td>
                    <td></td>
                    <td></td>
                    <td><input id="btnCancel_import" type="button" value="關閉"/></td>
                </tr>
            </table>
        </div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"> </a></td>
						<td align="center" style="display:none;"><a> </a></td>
						<td align="center" style="width:20%"><a>日期</a></td>
						<td align="center" style="width:20%"><a>電腦編號</a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa_nv" class="lbl" >電腦編號</a></td>
						<td>
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1" />
						</td>
						<td><span> </span><a id="lblTrandate" class="lbl" > </a></td>
						<td>
						<input id="txtTrandate" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddrno" class="lbl btn" >倉庫</a></td>
						<td colspan="2">
							<input id="txtAddrno" type="text" class="txt" style="width:35%" />
							<input id="txtAddr" type="text" class="txt" style="width:60%"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWeight" class="lbl" > </a></td>
						<td>
						<input id="txtWeight" type="text" class="txt c1 num" />
						</td>
						<td><span> </span><a id="lblMount" class="lbl" > </a></td>
						<td>
						<input id="txtMount" type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblVolume" class="lbl" style="display:none;"> </a></td>
						<td>
						<input id="txtVolume" type="text" class="txt c1 num" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTotal" class="lbl" > </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblTotal2" class="lbl" > </a></td>
						<td><input id="txtTotal2" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="5">						<textarea id="txtMemo" style="height:40px;" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td>
						<input id="txtWorker2" type="text" class="txt c1" />
						</td>
						<td><input id="btnImport" type="button" value="廠商付款立帳" style="width:100%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px"><a>日期</a></td>
					<td align="center" style="width:80px"><a>廠商</a></td>
					<td align="center" style="width:80px"><a>貨源</a></td>
					<td align="center" style="width:100px"><a>合約規格</a></td>
					<td align="center" style="width:80px"><a>客戶</a></td>
					<td align="center" style="width:100px"><a>地點</a></td>
					<td align="center" style="width:120px"><a>場地限制</a></td>
					<td align="center" style="width:85px"><a>桶槽容量</a></td>
					<td align="center" style="width:100px"><a>可送貨時間</a></td>
					<td align="center" style="width:80px"><a>公里數</a></td>
					<td align="center" style="width:80px"><a>車頭牌</a></td>
					<td align="center" style="width:80px"><a>子車</a></td>
					<td align="center" style="width:80px"><a>司機姓名</a></td>
					<td align="center" style="width:120px"><a>出勤狀況</a></td>
					<td align="center" style="width:80px"><a>今天趟數</a></td>
					<td align="center" style="width:100px"><a>處理單號</a></td>
					<td align="center" style="width:80px"><a>發料員</a></td>
					<td align="center" style="width:120px"><a>交易產品</a></td>
					<td align="center" style="width:100px"><a>聯單編號</a></td>
					<td align="center" style="width:100px"><a>送貨單號</a></td>
					<td align="center" style="width:80px"><a>客戶要求時間</a></td>
					<td align="center" style="width:80px"><a>出廠期間</a></td>
					<td align="center" style="width:80px"><a>到廠時間</a></td>
					<td align="center" style="width:60px"><a>單位</a></td>
					<td align="center" style="width:80px"><a>出廠重量</a></td>
					<td align="center" style="width:90px"><a>客戶端總重</a></td>
					<td align="center" style="width:90px"><a>客戶端空重</a></td>
					<td align="center" style="width:90px"><a>客戶端淨重</a></td>
					<td align="center" style="width:80px"><a>磅差</a></td>
					<td align="center" style="width:80px"><a>清除者</a></td>
					<td align="center" style="width:80px"><a>再利用者</a></td>
					<td align="center" style="width:80px"><a>核定數量</a></td>
					<td align="center" style="width:80px"><a>目前數量</a></td>
					<td align="center" style="width:80px"><a>可用數量</a></td>
					<td align="center" style="width:100px"><a>管編到期日</a></td>
					<td align="center" style="width:80px"><a>成本單價</a></td>
					<td align="center" style="width:80px"><a>售料單價</a></td>
					<td align="center" style="width:80px"><a>運費單價</a></td>
					<td align="center" style="width:80px"><a>客戶金額</a></td>
					<td align="center" style="width:100px"><a>服務費</a></td>
					<td align="center" style="width:60px"><a>實際客戶金額 </a></td>
					<!--td align="center" style="width:80px"><a>車行單價</a></td>
					<td align="center" style="width:80px"><a>車行金額</a></td-->
					<td align="center" style="width:150px"><a>司機單價類別</a></td>
					<td align="center" style="width:80px"><a>司機單價</a></td>
					<td align="center" style="width:80px"><a>司機金額</a></td>
					<td align="center" style="width:60px"><a>司機寄送文件</a></td>
					<td align="center" style="width:120px"><a>備註</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtDatea.*" style="width:95%;"/></td>
					<td><input type="text" id="txtTggno.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtTgg.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnTgg.*" style="display:none;"/>
                    </td>
					<td><input type="text" id="txtCaseno.*" style="width:95%;"/>
					    <input type="button" id="btnCaseno.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtSaddr.*" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCustno.*" style="float:left;width:95%;" />
						<input type="text" id="txtComp.*" style="display:none;" />
						<input type="text" id="txtNick.*" style="float:left;width:95%;">
						<input type="button" id="btnCust.*" style="display:none;">
					</td>
					<td>
						<input type="text" id="txtStraddrno.*" style="float:left;width:95%;"/>
						<input type="text" id="txtStraddr.*" style="float:left;width:95%;"/>
						<input type="button" id="btnStraddr.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtAaddr.*" style="width:95%;"/></td>
					<td>
						<input id="txtCaseno2.*" type="text" class="num" style="width:50px;"/>
						<select id="combCaseno2.*" class="txt" style="width: 20px;"> </select>
					</td>
					<td><select id="cmbUnit2.*" class="txt" style="width:95%;"> </select></td>
					<td><input type="text" id="txtMiles.*" class="num" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCarno.*" style="width:95%;"/>
						<input type="button" id="btnCarno.*" style="display:none;"/>
					</td>
					<td>
                        <input type="text" id="txtCardealno.*" style="width:95%;"/>
                        <input type="button" id="btnCardeal.*" style="display:none;"/>
                    </td>
                    <td>
                        <input type="text" id="txtDriverno.*" style="display:none;"/>
                        <input type="text" id="txtDriver.*" style="width:95%;"/>
                        <input type="button" id="btnDriver.*" style="display:none;"/>
                    </td>
					<td><input type="text" id="txtCaseuse.*" style="width:95%;"/></td>
					<td><input type="text" id="txtMount2.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTraceno.*" style="width:95%;"/></td>
					<td><input type="text" id="txtSender.*" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtUccno.*" style="float:left;width:95%;"/>
						<input type="text" id="txtProduct.*" style="float:left;width:95%;"/>
						<input type="button" id="btnProduct.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtPo.*" style="width:95%;"/></td>
					<td><input type="text" id="txtCustorde.*" style="width:95%;"/></td>
					<td><input type="text" id="txtDtime.*" style="width:95%;"/></td>
					<td><input type="text" id="txtLtime.*" style="width:95%;"/></td>
					<td><input type="text" id="txtStime.*" style="width:95%;"/></td>
					<td><input type="text" id="txtUnit.*" style="width:95%;"/></td>
					<td><input type="text" id="txtWeight2.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtGross.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtWeight3.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtWeight.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtPton.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtWorker.*" style="width:95%;"/></td>
					<td><input type="text" id="txtWorker2.*" style="width:95%;"/></td>
					<td><input type="text" id="txtOutmount.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtInmount.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtMount.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtCldate.*" style="width:95%;"/></td>
					<td><input type="text" id="txtPrice2.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtCustprice.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtPrice.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="textOverh.*" style="display:none;"/>
                        <input type="text" id="txtOverh.*" class="num" style="width:95%;"/></td>
					<td><select id="cmbStatus.*" class="txt" style="width:95%;"> </select></td>
					<!--td><input type="text" id="txtPrice2.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtDiscount.*" class="num" style="width:95%;"/></td-->
					<td><select id="cmbCalctype.*" class="txt" style="width: 95%;"> </select></td>
					<td><input type="text" id="txtMount3.*" class="num" style="width:95%;"/></td>
                    <td><input type="text" id="txtTotal2.*" class="num" style="width:95%;"/></td>
					<td><select id="cmbTtype.*" class="txt" style="width:95%;"> </select></td>
					<td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>