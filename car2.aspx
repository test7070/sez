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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "car2";
            var q_readonly = ['txtCardeal', 'txtCarowner', 'cmbSex', 'txtIdno', 'txtBirthday', 'txtTel1', 'txtTel2', 'txtMobile', 'txtFax', 'txtAddr_conn', 'txtAddr_home', 'txtDriver'];
            var bbmNum = [['txtInmoney', 10, 0],['txtInvoicemoney', 10, 0], ['txtOutmoney', 10, 0], ['txtIrange', 10, 0], ["txtManage", 10, 0], ["txtReserve", 10, 0], ["txtHelp", 10, 0], ["txtVrate", 6, 3], ["txtRrate", 6, 3], ["txtOrate", 6, 3], ["txtIrate", 6, 3], ["txtPrate", 6, 3], ["txtUlicense", 10, 0], ["txtDlicense", 10, 0], ["txtSpring", 10, 0], ["txtSummer", 10, 0], ["txtFalla", 10, 0], ["txtWinter", 10, 0], ["txtCylinder", 2, 0], ["txtSalemoney", 10, 0,1], ["txtImprovemoney1", 10, 0], ["txtImprovemoney2", 10, 0], ["txtImprovemoney3", 10, 0], ["txtDiscountmoney", 10, 0], ["txtDurableyear", 2, 0, 0, 0]];
            var bbmMask = [["txtIndate", "999/99/99"], ["txtOutdate", "999/99/99"], ["txtPassdate", "999/99/99"], ["txtLimitdate", "999/99/99"], ["txtCheckdate", "999/99/99"], ["txtCaryear", "9999/99"],["txtCaryeartw", "999/99"], ["txtSaledate", "999/99/99"], ["txtImprovedate1", "999/99/99"], ["txtImprovedate2", "999/99/99"], ["txtImprovedate3", "999/99/99"], ["txtDiscountdate", "999/99/99"], ["txtSuspdate", "999/99/99"], ["txtOverdate", "999/99/99"], ["txtEnddate", "999/99/99"], ["txtWastedate", "999/99/99"], ["txtReissuedate", "999/99/99"], ["txtSigndate", "999/99/99"]];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = 'a';
            brwCount2 = 20;
            aPop = [['txtCarownerno', 'lblCarowner', 'carowner', 'noa,namea,sex,idno,birthday,tel1,tel2,mobile,fax,addr_conn,addr_home', 'txtCarownerno,txtCarowner,cmbSex,txtIdno,txtBirthday,txtTel1,txtTel2,txtMobile,txtFax,txtAddr_conn,txtAddr_home', 'carowner_b.aspx'], ['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno', 'sss_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']];

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                
                //判斷舊車牌
                if(q_content!="" && q_getId()[3].substr(0,6)=="a.noa="){
                	t_oldnoa=replaceAll(q_getId()[3],'a.noa','a.oldnoa')
                	t_where =" where=^^ "+q_getId()[3]+" or "+t_oldnoa+"^^ ";
                	q_content=t_where;
                }
                
                q_gt(q_name, q_content, q_sqlCount, 1)

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
                q_cmbParse("cmbSex", q_getPara('sys.sex'));
                q_cmbParse("cmbChecktype", q_getPara('car2.checktype'));
                q_cmbParse("cmbCartype", q_getPara('car2.cartype'));
                q_cmbParse("cmbIsprint", q_getPara('car2.isprint'));
                q_cmbParse("cmbAuto", q_getPara('car2.auto'));
                
                if(q_getPara('sys.project').toUpperCase()!="DC"){
                	$(".btns").hide();
                }
                
                q_gt('carbrand', '', 0, 0, 0, "");
                q_gt('carkind', '', 0, 0, 0, "");
                q_gt('carspec', '', 0, 0, 0, "");
                //q_gt('carstyle', '', 0, 0, 0, "");
                q_gt('cardeal', '', 0, 0, 0, "");
				
				$(".carowner").hide();
				
				$("#btnCarowner").val("＋");
				$("#btnCarowner").toggle(function(e) {
					$(".carowner").show();
					$("#btnCarowner").val("－");
				}, function(e) {
					$(".carowner").hide();
					$("#btnCarowner").val("＋");
				});
				$('#txtCarownerno').keydown(function(e) {
					if(e.which==13)
						$('#txtIndate').focus();
				});
				
				$("#btnCarowneredit").val("車主新增/修改");
				$('#btnCarowneredit').click(function(e) {
					if(emp($('#txtCarownerno').val()))
						q_box("carowner.aspx?;;;;", 'carowner', "90%", "600px", q_getMsg("popCarowner"));
					else
						q_box("carowner.aspx?;;;noa='" + $('#txtCarownerno').val() + "'", 'carowner', "90%", "600px", q_getMsg("popCarowner"));
				});
				
				$(".carexpense").hide();
				$("#btnCarexpense").toggle(function(e) {
					$(".carexpense").show();
				}, function(e) {
					$(".carexpense").hide();
				});
				$(".sale").hide();
				$("#btnSale").toggle(function(e) {
					$(".sale").show();
				}, function(e) {
					$(".sale").hide();
				});
				$(".carnocchange").hide();
				$("#btnCarnochange").toggle(function(e) {
					$(".carnocchange").show();
				}, function(e) {
					$(".carnocchange").hide();
				});
				
				$('#btnCarsalary').click(function(e) {
					q_box("carsalary.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'carsalary', "90%", "95%", q_getMsg("popCarsalary"));
				});
				$('#btnCarinsurance').click(function(e) {
					q_box("carinsure.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'carinsure', "90%", "95%", q_getMsg("popCarinsure"));
				});
				$('#btnCarlender').click(function(e) {
					q_box("carlender.aspx?;;;noa='" + $('#txtCarownerno').val() + "'", 'carlender', "95%", "95%", q_getMsg("popCarlender"));
				});
				$('#btnCaraccident').click(function(e) {
					q_box("caraccident.aspx?;;;carno='" + $('#txtCarno').val() + "'", 'caraccident', "90%", "600px", q_getMsg("popCaraccident"));
				});
				$('#btnCarchange').click(function(e) {
					q_box("carchange.aspx?;;;noa='" + $('#txtCarno').val() + "'", 'carchange', "90%", "600px", q_getMsg("popCarchange"));
				});
				$('#btnOil').click(function(e) {
					q_box("oil.aspx?;;;carno='" + $('#txtCarno').val() + "'", 'oil', "90%", "600px", q_getMsg("popOil"));
				});
				$('#btnCartax').click(function(e) {
					q_box("cartax.aspx?;;;a.carno='" + $('#txtCarno').val() + "' and (caritemno='501' or caritemno='502') order by a.mon desc", 'cartax', "90%", "600px", q_getMsg("popCartax"));
				});
				/*$('#lblCarstyle').click(function(e) {
					q_box("carstyle.aspx", 'carstyle', "90%", "600px", q_getMsg("popCarstyle"));
				});*/
				$('#lblCarspec').click(function(e) {
					q_box("carspec.aspx", 'carspec', "90%", "600px", q_getMsg("popCarspec"));
				});
				
                //--11/21大昌改管理費+公會費=行費
                if (q_getPara('sys.comp').indexOf('大昌') > -1) {
                    $('#divGuile').hide();
                    $('#lblGuile').hide();
                    $('#txtGuile').hide();
                }

                $('#txtInvoicemoney').change(function() {
                    if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                });
                $('#txtImprovedate1').blur(function() {
                	if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                    Sale();
                });
                $('#txtImprovemoney1').blur(function() {
                	if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                    Sale();
                });
                $('#txtImprovedate2').blur(function() {
                	if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                    Sale();
                });
                $('#txtImprovemoney2').blur(function() {
                	if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                    Sale();
                });
                $('#txtImprovedate3').blur(function() {
                	if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                    Sale();
                });
                $('#txtImprovemoney3').blur(function() {
                	if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                    Sale();
                });
                $('#txtDiscountdate').blur(function() {
                	if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                    Sale();
                });
                $('#txtDiscountmoney').blur(function() {
                	if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                    Sale();
                });
                $('#txtSaledate').blur(function() {
                	if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                    Sale();
                });
                
                $('#btnChange').click(function(e) {
                	if(!emp($('#txtChangecarno').val())&&q_cur==2){
                		var t_where = "where=^^ a.noa ='"+$('#txtChangecarno').val()+"' ^^";
						q_gt('car2', t_where, 0, 0, 0, "");
					}
				});
				
				$('#txtSssno').blur(function() {
                    $('#txtManage').focus();
                });
                
                //1020702 宛蓉只有KEY金額時才跑出月份，避免結轉時結轉出單據
                $('#txtUlicense').change(function() {
                    if(dec($('#txtUlicense').val())>0)
                    	$('#txtUlicensemon').val('04');
                });
                
                $('#txtDlicense').change(function() {
                    if(dec($('#txtDlicense').val())>0)
                    	$('#txtDlicensemon').val('10');
                });
                
                $('#txtSpring').change(function() {
                    if(dec($('#txtSpring').val())>0)
                    	$('#txtSpringmon').val('03');
                });
                
                $('#txtSummer').change(function() {
                    if(dec($('#txtSummer').val())>0)
                    	$('#txtSummermon').val('06');
                });
                
                $('#txtFalla').change(function() {
                    if(dec($('#txtFalla').val())>0)
                    	$('#txtFallamon').val('09');
                });
                
                $('#txtWinter').change(function() {
                    if(dec($('#txtWinter').val())>0)
                    	$('#txtWintermon').val('12');
                });
                
                
                $('#txtUlicensemon').blur(function() {
                    if(!emp($('#txtUlicensemon').val())&&$('#txtUlicensemon').val()!='04')
                    	alert(q_getMsg('lblUlicense')+'月份錯誤，請檢查!!');
                });
                $('#txtDlicensemon').blur(function() {
                    if(!emp($('#txtDlicensemon').val())&&$('#txtDlicensemon').val()!='10')
                    	alert(q_getMsg('lblDlicense')+'月份錯誤，請檢查!!');
                });
                $('#txtSpringmon').blur(function() {
                    if(!emp($('#txtSpringmon').val())&&$('#txtSpringmon').val()!='03')
                    	alert(q_getMsg('lblSpring')+'月份錯誤，請檢查!!');
                });
                $('#txtSummermon').blur(function() {
                    if(!emp($('#txtSummermon').val())&&$('#txtSummermon').val()!='06')
                    	alert(q_getMsg('lblSummer')+'月份錯誤，請檢查!!');
                });
                $('#txtFallamon').blur(function() {
                    if(!emp($('#txtFallamon').val())&&$('#txtFallamon').val()!='09')
                    	alert(q_getMsg('lblFalla')+'月份錯誤，請檢查!!');
                });
                $('#txtWintermon').blur(function() {
                    if(!emp($('#txtWintermon').val())&&$('#txtWintermon').val()!='12')
                    	alert(q_getMsg('lblWinter')+'月份錯誤，請檢查!!');
                });
                
                $('#txtCaryear').blur(function() {
                    //if(!emp($('#txtCaryear').val())&&(/^[0-9]{4}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtCaryear').val()))
                    if(!emp($('#txtCaryear').val())){
	                    if((dec($('#txtCaryear').val().substr(0,4))-1911)>99)
	                    	$('#txtCaryeartw').val((dec($('#txtCaryear').val().substr(0,4))-1911)+'/'+(replaceAll(replaceAll($('#txtCaryear').val().substr(5,2),' ',''),'_','')!=''?$('#txtCaryear').val().substr(5,2):$('#txtPassdate').val().substr(4,2)));
	                    else
	                    	$('#txtCaryeartw').val('0'+(dec($('#txtCaryear').val().substr(0,4))-1911)+'/'+(replaceAll(replaceAll($('#txtCaryear').val().substr(5,2),' ',''),'_','')!=''?$('#txtCaryear').val().substr(5,2):$('#txtPassdate').val().substr(4,2)));
                    }
                });
                
                //異動通知
                $("#cmbCardealno").change(function() {
                	sendsignmemo();
				});
				
				$("#txtOutdate").blur(function() {
                	sendsignmemo();
				});
				
				$("#txtEnddate").blur(function() {
                	sendsignmemo();
				});
				
				$("#txtWastedate").blur(function() {
                	sendsignmemo();
				});
				
				$("#txtOutplace").change(function() {
                	sendsignmemo();
				});
				
				$("#txtSigndate").blur(function() {
                	sendsignmemo();
				});
				
				$("#txtCarownerno").change(function() {
                	sendsignmemo();
				});
				
				//1020904 車牌新增時判斷是否已存在
				$('#txtNoa').change(function() {
                    var t_where = "where=^^ a.noa ='"+$('#txtNoa').val()+"' ^^";
					q_gt('car2', t_where, 0, 0, 0, "");
                });
				
            }
            
            function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtCarownerno':
			    		sendsignmemo();
		    		break;
		    	}
			}
			 function sendsignmemo() {
			 		if(q_cur==1 || q_cur==2){ //20130520:會一次工讓車子遷入後又遷出
	                	var tx_memo='';
	                	$('#txtSendsign').val('');
	                	if(t_cardeal!=$('#cmbCardealno').find(":selected").text() && t_cardeal!=''){
	                		$('#txtSendsign').val($('#txtSigndate').val()+' '+t_cardeal+'過戶到'+$('#cmbCardealno').find(":selected").text());
	                		tx_memo=$('#txtSigndate').val()+' '+t_cardeal+'過戶到'+$('#cmbCardealno').find(":selected").text()+tx_memo;
	                	}
	                	
	                	if(t_outplace!=$('#txtOutplace').val()&&!emp($('#txtOutplace').val())){
	                		$('#txtSendsign').val($('#txtOutplace').val()+(!emp($('#txtSendsign').val())?','+$('#txtSendsign').val():''));
	                		tx_memo=$('#txtOutplace').val()+tx_memo;
	                	}
	                	if(t_outdate!=$('#txtOutdate').val() &&!emp($('#txtOutdate').val())){
	                		$('#txtSendsign').val($('#txtOutdate').val()+'遷出'+(!emp($('#txtSendsign').val())?','+$('#txtSendsign').val():''));
	                		tx_memo=$('#txtOutdate').val()+'遷出'+tx_memo;
	                	}
	                	if(t_enddate!=$('#txtEnddate').val() &&!emp($('#txtEnddate').val())){
	                		$('#txtSendsign').val($('#txtEnddate').val()+'報廢'+(!emp($('#txtSendsign').val())?','+$('#txtSendsign').val():''));
	                		tx_memo=$('#txtEnddate').val()+'報廢'+tx_memo;
	                	}
	                	if(t_wastedate!=$('#txtWastedate').val() &&!emp($('#txtWastedate').val())){
	                		$('#txtSendsign').val($('#txtWastedate').val()+'繳銷'+(!emp($('#txtSendsign').val())?','+$('#txtSendsign').val():''));
	                		tx_memo=$('#txtWastedate').val()+'繳銷'+tx_memo;
	                	}
	                	if(t_carowner!=$('#txtCarowner').val() &&!emp($('#txtCarowner').val())&&t_carowner!=''){
	                		tx_memo='車主'+trim(t_carowner)+q_date()+'換成'+$('#txtCarowner').val()+','+tx_memo;
	                	}
	                	$('#txtMemo').val(tx_memo+'\n'+t_memo);
                	}
			 }

            function q_boxClose(s2) {

                var ret;
                switch (b_pop) {
                case 'carspec':
                        q_gt('carspec', '', 0, 0, 0, "");
                        break;	
				case 'carstyle':
                        q_gt('carstyle', '', 0, 0, 0, "");
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
				b_pop = '';
            }
			function q_funcPost(t_func, result) {
		        location.href = location.origin+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";a.noa='"+$('#txtChangecarno').val()+"';"+r_accy;
		        alert('功能執行完畢');
		    } //endfunction
            function q_gfPost() {

            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'cardeal':
                        var as = _q_appendData("cardeal", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
                        }
                        q_cmbParse("cmbCardealno", t_item);
                        if(abbm[q_recno])
                        	$("#cmbCardealno").val(abbm[q_recno].cardealno);
                        break;
                    case 'carbrand':
                        var as = _q_appendData("carbrand", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].brand;
                        }
                        q_cmbParse("cmbCarbrandno", t_item);
                        if(abbm[q_recno])
                        	$("#cmbCarbrandno").val(abbm[q_recno].carbrandno);
                        break;
                    case 'carkind':
                        var as = _q_appendData("carkind", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
                        }
                        q_cmbParse("cmbCarkindno", t_item);
                        if(abbm[q_recno])
                        	$("#cmbCarkindno").val(abbm[q_recno].carkindno);
                        break;
                    case 'carspec':
                        var as = _q_appendData("carspec", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].spec;
                        }
                        q_cmbParse("cmbCarspecno", t_item);
                        if(abbm[q_recno])
                        	$("#cmbCarspecno").val(abbm[q_recno].carspecno);
                        break;
                    case 'carstyle':
                        var as = _q_appendData("carstyle", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].style;
                        }
                        q_cmbParse("cmbCarstyleno", t_item);
                        if(abbm[q_recno])
                        	$("#cmbCarstyleno").val(abbm[q_recno].carstyleno);
                        break;
                    case q_name:
                    	
                        if (q_cur == 4)
                            q_Seek_gtPost();
                            
                        if (q_cur == 1)
                        {
                        	var as = _q_appendData("car2", "", true);
	                    	if(as[0]!=undefined){
	                    		alert($('#txtNoa').val()+'車牌重覆!!');
	                    		$('#txtNoa').val('');
	                    		$('#txtNoa').focus();
	                    	}
                        }

                        if (q_cur == 2)
                        {
                        	var as = _q_appendData("car2", "", true);
	                    	if(as[0]==undefined){
	                    		if(!emp($('#txtChangecarno').val())){
	                				q_func( 'changecarno.change', $('#txtNoa').val()+','+$('#txtChangecarno').val());
                					//q_func( 'cara.carnoChange', 't_old,t_new');
								}
	                    	}else{
	                    		alert('車牌重覆!!');
	                    	}
                        }

                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('car2_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                 if(q_getPara('sys.project').toUpperCase()=="DC"){
	                $(".carexpense").show();
				}
                
                //暫存資料
                 t_cardeal='';
                 t_outdate='';
                 t_enddate='';
                 t_wastedate='';
                 t_memo='';
                 t_outplace='';
                 t_carowner='';
                
                $('#txtNoa').focus();
            }
			
			//暫存資料
			var t_cardeal='',t_outdate='',t_enddate='',t_wastedate='',t_memo='',t_outplace='',t_carowner='';
			
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                refreshBbm();
                $('txtSaledate').val(q_date());
                if (!emp($('#txtInvoicemoney').val())) {
                        if (dec($('#txtInvoicemoney').val()) >= 1000000) {
                            $('#txtDurableyear').val(10);
                        } else {
                            if (replaceAll($('#txtNoa').val(), '-', '').length == 4)//板台
                                $('#txtDurableyear').val(5);
                            else//車頭
                                $('#txtDurableyear').val(4);
                        }
                    }
                 Sale();
                 
                 //暫存資料
                 t_cardeal=$('#cmbCardealno').find(":selected").text();
                 t_outdate=$("#txtOutdate").val();
                 t_enddate=$("#txtEnddate").val();
                 t_wastedate=$("#txtWastedate").val();
                 t_memo=$("#txtMemo").val();
                 t_outplace=$("#txtOutplace").val();
                 t_carowner=$('#txtCarowner').val();
                 
                 //清除異動
                //if(!emp($('#txtSendsign').val()))
                	//$('#txtSendsign').val('');
                //$('#txtSigndate').val(q_date());
                 
                $('#txtNoa').focus();
            }

            function btnPrint() {
            	 if(q_getPara('sys.project').toUpperCase()=="DC")
					q_box('z_car2.aspx', '', "90%", "600px", q_getMsg("popPrint"));
            }

            function btnOk() {
            	if(!emp($('#txtCarownerno').val())&&emp($('#txtSssno').val())){
            		alert(q_getMsg('lblSss')+'沒有輸入。');
            		return;
            	}
            	$('#txtCardeal').val($('#cmbCardealno').find(":selected").text());
                if (!q_cd($('#txtIndate').val())){
                	alert(q_getMsg('lblIndate')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtOutdate').val())){
                	alert(q_getMsg('lblOutdate')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtPassdate').val())){
                	alert(q_getMsg('lblPassdate')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtLimitdate').val())){
                	alert(q_getMsg('lblLimitdate')+'錯誤。');
                	return;
           		}
           		
           		if ($('#txtCheckdate').val().length>0&&checkId($('#txtCheckdate').val())!=4){
                	alert(q_getMsg('lblCheckdate')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtCheckdate').val())){
                	alert(q_getMsg('lblCheckdate')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtSaledate').val())){
                	alert(q_getMsg('lblSaledate')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtImprovedate1').val())){
                	alert(q_getMsg('lblImprovedate1')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtImprovedate2').val())){
                	alert(q_getMsg('lblImprovedate2')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtImprovedate3').val())){
                	alert(q_getMsg('lblImprovedate3')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtDiscountdate').val())){
                	alert(q_getMsg('lblDiscountdate')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtSuspdate').val())){
                	alert(q_getMsg('lblSuspdate')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtOverdate').val())){
                	alert(q_getMsg('lblOverdate')+'錯誤。');
                	return;
           		}
                if (!q_cd($('#txtEnddate').val())){
                	alert(q_getMsg('lblEnddate')+'錯誤。');
                	return;
           		}
				$('#txtCaryeartw').val($.trim($('#txtCaryeartw').val()));
				$('#txtCaryear').val($.trim($('#txtCaryear').val()));
				/*if ($('#txtCaryeartw').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtCaryeartw').val())){
					alert(q_getMsg('lblCaryeartw')+'錯誤。');
					return;
				}*/
				if(emp($('#txtSendsign').val()))
                	$('#txtSigndate').val('');
					
	           	var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);

                var t_noa = replaceAll($('#txtNoa').val(),' ','');
                replaceAll($('#txtCarno').val(t_noa),' ','')
                wrServer(t_noa);
                if(q_cur=='1'&& q_getPara('sys.project').toUpperCase()=="DC")
                	$("#btnCarinsurance").click();
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
				refreshBbm();
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

            function q_appendData(t_Table) {
                dataErr = !_q_appendData(t_Table);
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

            function Sale() {
                //-----------------------折舊計算------------------------
                var depmoney = 0;
                //折舊後金額
                if (dec($('#txtInvoicemoney').val()) <= 1000)//取得金額1000以下不折舊
                    depmoney = dec($('#txtInvoicemoney').val());
                if (!emp($('#txtSaledate').val()) && dec($('#txtInvoicemoney').val()) > 0 && dec($('#txtDurableyear').val()) > 0) {
                    //取得到開發票月數
                    var t_mon = (dec($('#txtSaledate').val().substr(0, 3)) * 12 + dec($('#txtSaledate').val().substr(4, 2))) - (dec($('#txtIndate').val().substr(0, 3)) * 12 + dec($('#txtIndate').val().substr(4, 2)))
                    //折舊後金額
                    depmoney = round(dec($('#txtInvoicemoney').val()) - ((dec($('#txtInvoicemoney').val()) / (dec($('#txtDurableyear').val()) + 1) / 12) * t_mon), 0)

                    if (depmoney < 0)
                        depmoney = 0;
                    //已超過耐用年數才會為負值
                }
                //--------------------------改良計算---------------------------------
                var imsale1 = 0, imsale2 = 0, imsale3 = 0;
                //改良後金額
                if (!emp($('#txtImprovedate1').val()) && dec($('#txtImprovemoney1').val()) > 0 && !emp($('#txtSaledate').val()) && dec($('#txtDurableyear').val()) > 0) {//改良1
                    //改良日至耐用年限月數=取得日+耐用-改良日
                    var t_imon1 = (dec($('#txtIndate').val().substr(0, 3)) * 12 + dec($('#txtIndate').val().substr(4, 2)) + (dec($('#txtDurableyear').val()) * 12)) - (dec($('#txtImprovedate1').val().substr(0, 3)) * 12 + dec($('#txtImprovedate1').val().substr(4, 2)));
                    //改良日至開發票月數=開發票日-改良日
                    var t_ismon1 = (dec($('#txtSaledate').val().substr(0, 3)) * 12 + dec($('#txtSaledate').val().substr(4, 2))) - (dec($('#txtImprovedate1').val().substr(0, 3)) * 12 + dec($('#txtImprovedate1').val().substr(4, 2)));
                    //改良餘額
                    imsale1 = dec($('#txtImprovemoney1').val()) - (dec($('#txtImprovemoney1').val()) / (t_imon1 + 12) * t_ismon1);

                    if (imsale1 < 0)
                        imsale1 = 0;
                    //已超過耐用年數才會為負值
                }
                if (!emp($('#txtImprovedate2').val()) && dec($('#txtImprovemoney2').val()) > 0 && !emp($('#txtSaledate').val()) && dec($('#txtDurableyear').val()) > 0) {//改良2
                    var t_imon2 = (dec($('#txtIndate').val().substr(0, 3)) * 12 + dec($('#txtIndate').val().substr(4, 2)) + (dec($('#txtDurableyear').val()) * 12)) - (dec($('#txtImprovedate2').val().substr(0, 3)) * 12 + dec($('#txtImprovedate2').val().substr(4, 2)));
                    var t_ismon2 = (dec($('#txtSaledate').val().substr(0, 3)) * 12 + dec($('#txtSaledate').val().substr(4, 2))) - (dec($('#txtImprovedate2').val().substr(0, 3)) * 12 + dec($('#txtImprovedate2').val().substr(4, 2)));
                    imsale2 = dec($('#txtImprovemoney2').val()) - (dec($('#txtImprovemoney2').val()) / (t_imon2 + 12) * t_ismon2);

                    if (imsale2 < 0)
                        imsale2 = 0;
                    //已超過耐用年數才會為負值
                }
                if (!emp($('#txtImprovedate3').val()) && dec($('#txtImprovemoney3').val()) > 0 && !emp($('#txtSaledate').val()) && dec($('#txtDurableyear').val()) > 0) {//改良3
                    var t_imon3 = (dec($('#txtIndate').val().substr(0, 3)) * 12 + dec($('#txtIndate').val().substr(4, 2)) + (dec($('#txtDurableyear').val()) * 12)) - (dec($('#txtImprovedate3').val().substr(0, 3)) * 12 + dec($('#txtImprovedate3').val().substr(4, 2)));
                    var t_ismon3 = (dec($('#txtSaledate').val().substr(0, 3)) * 12 + dec($('#txtSaledate').val().substr(4, 2))) - (dec($('#txtImprovedate3').val().substr(0, 3)) * 12 + dec($('#txtImprovedate3').val().substr(4, 2)));
                    imsale3 = dec($('#txtImprovemoney3').val()) - (dec($('#txtImprovemoney3').val()) / (t_imon3 + 12) * t_ismon3);

                    if (imsale3 < 0)
                        imsale3 = 0;
                    //已超過耐用年數才會為負值
                }
                //------------------------------發票資售金額=原價折舊金額+改良折舊金額-折讓(折減)金額---------------------------------------
                q_tr('txtSalemoney', round(depmoney + imsale1 + imsale2 + imsale3 - dec($('#txtDiscountmoney').val()), 0));

            }

			 $(document).keydown(function(e) {
				if ( e.keyCode=='116' ){
				   location.href = (location.origin==undefined?'':location.origin)+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";a.noa>='"+$('#txtNoa').val()+"';"+r_accy;
				   event.returnValue= false;
				  }
			});
			 
			 function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }
            function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
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
                width: 650px;
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
                width: 16%;
            }
            .tbbm .tdZ {
                width: 4%;
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

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .carexpense{
            	background-color:#CCCC00;
            }
            .sale{
            	background-color:#FF9900;
            }
            .carnocchange{
            	background-color:#19FF1C;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td style="width: 20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width: 80px; color:black;"><a id='vewCarno'> </a></td>
						<td style="width: 100px; color:black;"><a id='vewCarowner'> </a></td>
						<td style="width: 100px; color:black;"><a id='vewDriver'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="carowner" style="text-align: center;">~carowner</td>
						<td id="driver" style="text-align: center;">~driver</td>
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
						<td>
							<input id="txtNoa"  type="text" class="txt c1"/>
							<input id="txtCarno" type="text"  style='display:none;'/>
						</td>
						<td><span> </span><a id="lblCardeal" class="lbl"> </a></td>
						<td>
							<select id="cmbCardealno" class="txt c1"> </select>
							<input id="txtCardeal" type="text"  style="display:none;"/>
						</td>
						<td><span> </span><a id="lblCartype" class="lbl"> </a></td>
						<td><select id="cmbCartype" class="txt c1"> </select> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarkind" class="lbl"> </a></td>
						<td><select id="cmbCarkindno" class="txt c1"> </select></td>
						
						<td><span> </span><a id="lblCarmode" class="lbl"> </a></td>
						<td><input id="txtCarmode" type="text" class="txt c1"/> </td>
						<!--<select id="cmbCarstyleno" class="txt c1"> </select>-->
						<td><span> </span><a id="lblCarspec" class="lbl btn"> </a></td>
						<td><select id="cmbCarspecno" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtDriverno" type="text"  style='width:40%; float:left;'/>
							<input id="txtDriver" type="text"  style='width:60%; float:left;'/>
						</td>
						<td> </td>
						<td colspan="2">
							<input id="chkOption01"  type="checkbox" style='float:left;'/>
							<span> </span><a id='lblOption01' class="lbl" style='float:left;'> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarowner" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtCarownerno" type="text"  style='width:40%; float:left;'/>
							<input id="txtCarowner" type="text"  style='width:60%; float:left;'/>
						</td>
						<td style="text-align: center;"><input id="btnCarowner" type="button" style="width:50%;"/></td>
						<td style="text-align: center;"><input id="btnCarowneredit" type="button" /></td>
					</tr>
					<tr class="carowner">
						<td><span> </span><a id="lblSex" class="lbl"> </a></td>
						<td><select id="cmbSex" class="txt c1"> </select></td>
						<td><span> </span><a id="lblIdno" class="lbl"> </a></td>
						<td><input id="txtIdno" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblBirthday" class="lbl"> </a></td>
						<td><input id="txtBirthday" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="carowner">
						<td><span> </span><a id="lblTel1" class="lbl"> </a></td>
						<td colspan="2"><input id="txtTel1" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblTel2" class="lbl"> </a></td>
						<td colspan="2"><input id="txtTel2" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="carowner">
						<td><span> </span><a id="lblMobile" class="lbl"> </a></td>
						<td colspan="2"><input id="txtMobile" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblFax" class="lbl"> </a></td>
						<td colspan="2"><input id="txtFax" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="carowner">
						<td><span> </span><a id="lblAddr_conn" class="lbl"> </a></td>
						<td colspan="5"><input id="txtAddr_conn" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="carowner">
						<td><span> </span><a id="lblAddr_home" class="lbl"> </a></td>
						<td colspan="5"><input id="txtAddr_home" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblIndate" class="lbl"> </a></td>
						<td><input id="txtIndate" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblInvoicemoney" class="lbl"> </a></td>
						<td><input id="txtInvoicemoney" type="text" class="txt c1 num"/> </td>
						<td><span> </span><a id="lblInplace" class="lbl"> </a></td>
						<td><input id="txtInplace" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblOutdate" class="lbl" style="color: red;"> </a></td>
						<td><input id="txtOutdate" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblOutmoney" class="lbl" style="color: red;"> </a></td>
						<td><input id="txtOutmoney" type="text" class="txt c1 num"/> </td>
						<td><span> </span><a id="lblOutplace" class="lbl" style="color: red;"> </a></td>
						<td><input id="txtOutplace" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblEnddate" class="lbl" style="color: red;"> </a></td>
						<td><input id="txtEnddate" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblWastedate" class="lbl" style="color: red;"> </a></td>
						<td><input id="txtWastedate" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblSuspdate" class="lbl" style="color: red;"> </a></td>
						<td><input id="txtSuspdate" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblPassdate" class="lbl"> </a></td>
						<td><input id="txtPassdate" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblLimitdate" class="lbl"> </a></td>
						<td><input id="txtLimitdate" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblReissuedate" class="lbl"> </a></td>
						<td><input id="txtReissuedate" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblCaryear" class="lbl"> </a></td>
						<td><input id="txtCaryear" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblCaryeartw" class="lbl"> </a></td>
						<td><input id="txtCaryeartw" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblCheckdate" class="lbl"> </a></td>
						<td><input id="txtCheckdate" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblCarbrand" class="lbl"> </a></td>
						<td><select id="cmbCarbrandno" class="txt c1"> </select></td>
						<td><span> </span><a id="lblCarstyle" class="lbl"> </a></td>
						<td><input id="txtCarstyleno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblChecktype" class="lbl"> </a></td>
						<td><select id="cmbChecktype" class="txt c1"> </select></td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblLengthb" class="lbl"> </a></td>
						<td><input id="txtLengthb" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblWidth" class="lbl"> </a></td>
						<td><input id="txtWidth" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblHeight" class="lbl"> </a></td>
						<td><input id="txtHeight" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblWheelbase" class="lbl"> </a></td>
						<td><input id="txtWheelbase" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblAxlenum" class="lbl"> </a></td>
						<td><input id="txtAxlenum" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblWheelnum" class="lbl"> </a></td>
						<td><input id="txtWheelnum" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblWeight1" class="lbl"> </a></td>
						<td><input id="txtWeight1" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblWeight2" class="lbl"> </a></td>
						<td><input id="txtWeight2" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblTon" class="lbl"> </a></td>
						<td><input id="txtTon" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblWeight3" class="lbl"> </a></td>
						<td><input id="txtWeight3" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblCylinder" class="lbl"> </a></td>
						<td><input id="txtCylinder" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblCc" class="lbl"> </a></td>
						<td><input id="txtCc" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblEngineno" class="lbl"> </a></td>
						<td><input id="txtEngineno" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblOldnoa" class="lbl"> </a></td>
						<td><input id="txtOldnoa" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblOverdate" class="lbl"> </a></td>
						<td><input id="txtOverdate" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblReferee" class="lbl"> </a></td>
						<td><input id="txtReferee" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblSss" class="lbl btn"> </a></td>
						<td><input id="txtSssno" type="text" class="txt c1"/> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblDurableyear" class="lbl"> </a></td>
						<td><input id="txtDurableyear" type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblInmoney" class="lbl"> </a></td>
						<td><input id="txtInmoney" type="text" class="txt c1 num"/> </td>
						<td><span> </span><a id="lblIsprint" class="lbl"> </a></td>
						<td><select id="cmbIsprint" class="txt c1"> </select> </td>
					</tr>
					<tr class="other">
						<td><span> </span><a id="lblSigndate" class="lbl"> </a></td>
						<td><input type="text" id="txtSigndate" class="txt c1"></td>
						<td><span> </span><a id="lblSendsign" class="lbl"> </a></td>
						<td colspan="3"><input type="text" id="txtSendsign" class="txt c1"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><textarea id="txtMemo" class="txt c1" style="height:100px;"> </textarea></td>
					</tr>
					<tr class="btns">
						<td> </td>
						<td><input id="btnCarinsurance" type="button" style="width:80%;"/> </td>					
						<td><input id="btnCaraccident" type="button" style="width:80%;"/> </td>
						<td><input id="btnCarchange" type="button" style="width:80%;"/> </td>
						<td><input id="btnOil" type="button" style="width:80%;"/> </td>	
						<td><input id="btnCartax" type="button" style="width:80%;"/> </td>
					</tr>
					<tr class="btns">
						<td> </td>
						<td><input id="btnCarexpense" type="button" style="width:80%;"/> </td>
						<td><input id="btnSale" type="button" style="width:80%;"/> </td>	
						<td><input id="btnCarsalary" type="button" style="width:80%;"/></td>
						<td><input id="btnCarlender" type="button" style="width:80%;"/></td>
						<td><input id="btnCarnochange" type="button" /></td>
					</tr>
					<tr class="carexpense">
						<td><span> </span><a id="lblAuto" class="lbl"> </a></td>
						<td><select id="cmbAuto" style="width:95%;"> </select>	</td>
						<td><span> </span><a id="lblIrange" class="lbl"> </a></td>
						<td><input id="txtIrange" type="text"  class="txt c1 num"/>	</td>	
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="carexpense">
						<td><span> </span><a id="lblManage" class="lbl"> </a></td>
						<td><input id="txtManage" type="text"  class="txt c1 num"/>	</td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="carexpense">
						<td><span> </span><a id="lblReserve" class="lbl"> </a></td>
						<td><input id="txtReserve" type="text"  class="txt c1 num"/>	</td>
						<td><span> </span><a id="lblHelp" class="lbl"> </a></td>
						<td><input id="txtHelp" type="text"  class="txt c1 num"/>	</td>	
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="carexpense">
						<td><span> </span><a id="lblVrate" class="lbl"> </a></td>
						<td><input id="txtVrate" type="text"  class="txt c1 num"/>	</td>
						<td><span> </span><a id="lblRrate" class="lbl"> </a></td>
						<td><input id="txtRrate" type="text"  class="txt c1 num"/>	</td>	
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="carexpense">
						<td><span> </span><a id="lblOrate" class="lbl"> </a></td>
						<td><input id="txtOrate" type="text"  class="txt c1 num"/>	</td>
						<td><span> </span><a id="lblIrate" class="lbl"> </a></td>
						<td><input id="txtIrate" type="text"  class="txt c1 num"/>	</td>	
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="carexpense">
						<td><span> </span><a id="lblPrate" class="lbl"> </a></td>
						<td><input id="txtPrate" type="text"  class="txt c1 num"/>	</td>	
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="carexpense">
						<td><span> </span><a id="lblUlicense" class="lbl"> </a></td>
						<td><input id="txtUlicense" type="text"  class="txt c1 num"/> </td>
						<td>
							<input id="txtUlicensemon" type="text"  style="float:left; width:50%; text-align: right;"/> 
							<a id="lblUlicense_memo" style="float:left; font-size: 14px;"> </a>
						</td>	
						<td><span> </span><a id="lblDlicense" class="lbl"> </a></td>
						<td><input id="txtDlicense" type="text"  class="txt c1 num"/> </td>
						<td>
							<input id="txtDlicensemon" type="text"  style="float:left; width:50%; text-align: right;"/> 
							<a id="lblDlicense_memo" style="float:left;  font-size: 14px;"> </a>
						</td>	
						<td> </td>
					</tr>
					<tr class="carexpense">
						<td><span> </span><a id="lblSpring" class="lbl"> </a></td>
						<td><input id="txtSpring" type="text"  class="txt c1 num"/> </td>
						<td>
							<input id="txtSpringmon" type="text"  style="float:left; width:50%; text-align: right;"/> 
							<a id="lblSpring_memo" style="float:left;  font-size: 14px;"> </a>
						</td>	
						<td><span> </span><a id="lblSummer" class="lbl"> </a></td>
						<td><input id="txtSummer" type="text"  class="txt c1 num"/> </td>
						<td>
							<input id="txtSummermon" type="text"  style="float:left; width:50%; text-align: right;"/> 
							<a id="lblSummer_memo" style="float:left;  font-size: 14px;"> </a>
						</td>	
						<td> </td>
					</tr>
					<tr class="carexpense">
						<td><span> </span><a id="lblFalla" class="lbl"> </a></td>
						<td><input id="txtFalla" type="text"  class="txt c1 num"/> </td>
						<td>
							<input id="txtFallamon" type="text"  style="float:left; width:50%; text-align: right;"/> 
							<a id="lblFalla_memo" style="float:left;  font-size: 14px;"> </a>
						</td>	
						<td><span> </span><a id="lblWinter" class="lbl"> </a></td>
						<td><input id="txtWinter" type="text"  class="txt c1 num"/> </td>
						<td>
							<input id="txtWintermon" type="text"  style="float:left; width:50%; text-align: right;"/> 
							<a id="lblWinter_memo" style="float:left;  font-size: 14px;"> </a>
						</td>	
						<td> </td>
					</tr>
					<tr class="sale">
						<td><span> </span><a id="lblImprovedate1" class="lbl"> </a></td>
						<td><input id="txtImprovedate1"  type="text"  class="txt c1"/>	</td>
						<td><span> </span><a id="lblImprovemoney1" class="lbl"> </a></td>
						<td><input id="txtImprovemoney1"  type="text"  class="txt c1 num"/>	</td>	
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="sale">
						<td><span> </span><a id="lblImprovedate2" class="lbl"> </a></td>
						<td><input id="txtImprovedate2"  type="text"  class="txt c1"/>	</td>
						<td><span> </span><a id="lblImprovemoney2" class="lbl"> </a></td>
						<td><input id="txtImprovemoney2"  type="text"  class="txt c1 num"/>	</td>	
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="sale">
						<td><span> </span><a id="lblImprovedate3" class="lbl"> </a></td>
						<td><input id="txtImprovedate3"  type="text"  class="txt c1"/>	</td>
						<td><span> </span><a id="lblImprovemoney3" class="lbl"> </a></td>
						<td><input id="txtImprovemoney3"  type="text"  class="txt c1 num"/>	</td>
						<td> </td>
						<td> </td>
						<td> </td>	
					</tr>
					<tr class="sale">
						<td><span> </span><a id="lblDiscountdate" class="lbl"> </a></td>
						<td><input id="txtDiscountdate"  type="text"  class="txt c1"/>	</td>
						<td><span> </span><a id="lblDiscountmoney" class="lbl"> </a></td>
						<td><input id="txtDiscountmoney"  type="text"  class="txt c1 num"/>	</td>	
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="sale">
						<td><span> </span><a id="lblSaledate" class="lbl"> </a></td>
						<td><input id="txtSaledate"  type="text"  class="txt c1"/>	</td>
						<td><span> </span><a id="lblSalemoney" class="lbl"> </a></td>
						<td><input id="txtSalemoney"  type="text"  class="txt c1 num"/>	</td>	
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="carnocchange">
						<td><span> </span><a id="lblChangecarno" class="lbl"> </a></td>
						<td><input id="txtChangecarno"  type="text"  class="txt c1"/></td>
						<td><input id="btnChange" type="button" /></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
