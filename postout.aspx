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
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        var q_name="postout";
        var q_readonly = ['txtNoa','txtChecker'];
        var bbmNum = [['txtTotal',14 , 1, 1],['txtP10',14 , 0, 1],['txtP20',14 , 0, 1],['txtP30',14 , 0, 1],['txtP35',14 , 0, 1],['txtP50',14 , 0, 1],['txtP60',14 , 0, 1],['txtP70',14 , 0, 1],['txtP80',14 , 0, 1],['txtP90',14 , 0, 1],['txtP100',14 , 0, 1],['txtP120',14 , 0, 1],['txtP130',14 , 0, 1],['txtP150',14 , 0, 1],['txtP200',14 , 0, 1],['txtP250',14 , 0, 1],['txtP280',14 , 0, 1],['txtP320',14 , 0, 1],['txtP340',14 , 0, 1]]; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
		aPop = new Array(['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
		['txtSssno', 'lblSss', 'sssall', 'noa,namea,partno,part', 'txtSssno,txtNamea,txtPartno,txtPart', 'sssall_b.aspx'],
		['txtSenderno', 'lblSend', 'acomp', 'noa,nick','txtSenderno,txtSender', 'acomp_b.aspx'],
		['txtReceiverno_cust', 'lblReceiver_cust', 'cust', 'noa,comp','txtReceiverno_cust,txtReceiver_cust', 'cust_b.aspx'],
		['txtReceiverno_tgg', 'lblReceiver_tgg', 'tgg', 'noa,comp','txtReceiverno_tgg,txtReceiver_tgg', 'tgg_b.aspx'],
		['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']);
		
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
            q_desc = 1;
           	q_gt(q_name, q_content, q_sqlCount, 1)
            //$('#txtNoa').focus
            //判斷是否為權限(簽核)
            q_gt('authority', "where=^^a.noa='postout' and a.sssno='" + r_userno + "'^^", q_sqlCount, 1)
        });
 
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }
            mainForm(0); // 1=Last  0=Top
        }  


        function mainPost() { 
            q_getFormat();
        	bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('send.typea'));
            
            q_gt('postage_stk', "where=^^1=1^^" , 0, 0, 0, "postagestk", r_accy);//讀出庫存
            
			$('#btnCheck').click(function () {
	           $('#txtChecker').val(r_name);
	           var totalstr='';
			   	if(p10<=10)
	           		totalstr+='<BR>郵資1.0庫存剩'+p10+'張';
	          	if(p20<=10)
	           		totalstr+='<BR>郵資2.0庫存剩'+p20+'張';
				if(p30<=10)
	           		totalstr+='<BR>郵資3.0庫存剩'+p30+'張';
	           	if(p35<=10)
	           		totalstr+='<BR>郵資3.5庫存剩'+p35+'張';
	           	if(p50<=10)
	           		totalstr+='<BR>郵資5.0庫存剩'+p50+'張';
				if(p60<=10)
	           		totalstr+='<BR>郵資6.0庫存剩'+p60+'張';
				if(p70<=10)
	           		totalstr+='<BR>郵資7.0庫存剩'+p70+'張';
				if(p80<=10)
	           		totalstr+='<BR>郵資8.0庫存剩'+p80+'張';
				if(p90<=10)
	           		totalstr+='<BR>郵資9.0庫存剩'+p90+'張';
	           	if(p100<=10)
	           		totalstr+='<BR>郵資10.0庫存剩'+p100+'張';
	           	if(p120<=10)
	           		totalstr+='<BR>郵資12.0庫存剩'+p120+'張';
	           	if(p130<=10)
	           		totalstr+='<BR>郵資13.0庫存剩'+p130+'張';
	           	if(p150<=10)
	           		totalstr+='<BR>郵資15.0庫存剩'+p150+'張';
	           	if(p200<=10)
	           		totalstr+='<BR>郵資20.0庫存剩'+p200+'張';
	           	if(p250<=10)
	           		totalstr+='<BR>郵資25.0庫存剩'+p250+'張';
				if(p280<=10)
	           		totalstr+='<BR>郵資28.0庫存剩'+p280+'張';
	           	if(p320<=10)
	           		totalstr+='<BR>郵資32.0庫存剩'+p320+'張';
				if(p340<=10)
	           		totalstr+='<BR>郵資34.0庫存剩'+p340+'張';
	           totalstr=totalstr.substr(4)
	           q_msg( $(this), totalstr); 
	        }).blur(function () {
				q_msg();
	        });
	        
	        $('#txtStoreno').change(function () {
	        	if(!emp($('#txtStoreno').val()))
					q_gt('postage_stk', "where=^^ a.storeno='"+$('#txtStoreno').val()+"' ^^" , 0, 0, 0, "postagestk", r_accy);//讀出庫存
	        });
	        $('#txtP10').change(function () {
				if(p10<dec($('#txtP1').val())){
					alert('郵資庫存數量不足');
	           		$('#txtP10').val(p10);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資1.0庫存剩'+p10+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP20').change(function () {
				if(p20<dec($('#txtP20').val())){
					alert('郵資庫存數量不足');
	           		$('#txtP20').val(p20);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資2.0庫存剩'+p20+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP30').change(function () {
				if(p30<dec($('#txtP30').val())){
					alert('郵資庫存數量不足');
	           		$('#txtP30').val(p30);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資3.0庫存剩'+p30+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP35').change(function () {
	           if(p35<dec($('#txtP35').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP35').val(p35);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資3.5庫存剩'+p35+'張');
	        }).blur(function () {
				q_msg();
	        });
	        $('#txtP50').change(function () {
	           if(p50<dec($('#txtP50').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP50').val(p50);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資5.0庫存剩'+p50+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP50').change(function () {
				if(p50<dec($('#txtP50').val())){
					alert('郵資庫存數量不足');
	           		$('#txtP50').val(p50);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資5.0庫存剩'+p50+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP60').change(function () {
				if(p60<dec($('#txtP60').val())){
					alert('郵資庫存數量不足');
	           		$('#txtP60').val(p60);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資6.0庫存剩'+p60+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP70').change(function () {
				if(p70<dec($('#txtP70').val())){
					alert('郵資庫存數量不足');
	           		$('#txtP70').val(p70);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資7.0庫存剩'+p70+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP80').change(function () {
				if(p80<dec($('#txtP80').val())){
					alert('郵資庫存數量不足');
	           		$('#txtP80').val(p80);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資8.0庫存剩'+p80+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP90').change(function () {
				if(p90<dec($('#txtP90').val())){
					alert('郵資庫存數量不足');
	           		$('#txtP90').val(p90);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資9.0庫存剩'+p90+'張');
	        }).blur(function () {
				q_msg();
	        });
			
	        $('#txtP100').change(function () {
	           if(p100<dec($('#txtP100').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP100').val(p100);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資10.0庫存剩'+p100+'張'); 
	        }).blur(function () {
				q_msg();
	        });
	        $('#txtP120').change(function () {
	           if(p120<dec($('#txtP120').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP120').val(p120);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資12.0庫存剩'+p120+'張');
	        }).blur(function () {
				q_msg();
	        });
	        $('#txtP130').change(function () {
	           if(p130<dec($('#txtP130').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP130').val(p130);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資13.0庫存剩'+p130+'張');
	        }).blur(function () {
				q_msg();
	        });
	        $('#txtP150').change(function () {
	           if(p150<dec($('#txtP150').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP150').val(p150);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資15.0庫存剩'+p150+'張');
	        }).blur(function () {
				q_msg();
	        });
	        $('#txtP200').change(function () {
	           if(p200<dec($('#txtP200').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP200').val(p200);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資20.0庫存剩'+p200+'張');
	        }).blur(function () {
				q_msg();
	        });
			
	        $('#txtP250').change(function () {
	           if(p250<dec($('#txtP250').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP250').val(p250);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資25.0庫存剩'+p250+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP280').change(function () {
	           if(p280<dec($('#txtP280').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP280').val(p280);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資28.0庫存剩'+p280+'張');
	        }).blur(function () {
				q_msg();
	        });
			
	        $('#txtP320').change(function () {
	           if(p320<dec($('#txtP320').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP320').val(p320);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資32.0庫存剩'+p320+'張');
	        }).blur(function () {
				q_msg();
	        });
			
			$('#txtP340').change(function () {
	           if(p340<dec($('#txtP340').val())){
	           		alert('郵資庫存數量不足');
	           		$('#txtP340').val(p340);
	           	}
	           	sum();
	        }).focus(function () {
				//q_gt('postage', '' , 0, 0, 0, "", r_accy);//讀出庫存
				q_msg( $(this), '郵資34.0庫存剩'+p340+'張');
	        }).blur(function () {
				q_msg();
	        });
	        
	        $('#lblCustno2').click(function(e) {
				q_box("cust_b2.aspx", 'cust2', "500px", "95%", q_getMsg("popCust"));
			});
			$('#lblTggno2').click(function(e) {
				q_box("tgg_b2.aspx", 'tgg2', "500px", "95%", q_getMsg("popTgg"));
			});
			
			$('#txtCustno2').click(function () {
                if(q_cur==0 || q_cur==4)
           			q_msg( $(this), $(this).val());
			});
			$('#txtTggno2').click(function () {
                if(q_cur==0 || q_cur==4)
           			q_msg( $(this), $(this).val());
			});
			$('#txtMemo').click(function () {
                if(q_cur==0 || q_cur==4)
           			q_msg( $(this), $(this).val());
			});
        }
        
        function txtCopy(dest, source) {
            var adest = dest.split(',');
            var asource = source.split(',');
            $('#' + adest[0]).focus(function () { if (trim($(this).val()).length == 0) $(this).val( q_getMsg('msgCopy')); });
            $('#' + adest[0]).focusout(function () {
                var t_copy = ($(this).val().substr(0, 1) == '=');
                var t_clear = ($(this).val().substr(0, 2) == ' =') ;
                for (var i = 0; i < adest.length; i++) {
                    {
                        if (t_copy)
                            $('#' + adest[i]).val($('#' + asource[i]).val());

                        if( t_clear)
                            $('#' + adest[i]).val('');
                    }
                }
            });
        }
        
        function q_boxClose( s2) {
            var ret; 
            switch (b_pop) {
            	case 'cust2':
            		ret = getb_ret();
					if (q_cur > 0 && q_cur < 4) {
						if (ret[0] != undefined) {
							for (var i = 0; i < ret.length; i++) {
								if ($('#txtCustno2').val().length > 0) {
									var temp = $('#txtCustno2').val();
									$('#txtCustno2').val(temp + ',' + ret[i].noa);
								} else {
									$('#txtCustno2').val(ret[i].noa);
								}
							}
						}
					}
            		break;
            	case 'tgg2':
            		ret = getb_ret();
					if (q_cur > 0 && q_cur < 4) {
						if (ret[0] != undefined) {
							for (var i = 0; i < ret.length; i++) {
								if ($('#txtTggno2').val().length > 0) {
									var temp = $('#txtTggno2').val();
									$('#txtTggno2').val(temp + ',' + ret[i].noa);
								} else {
									$('#txtTggno2').val(ret[i].noa);
								}
							}
						}
					}
            		break;
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop='';
        }
		
		var ischecker=false;
		var p10=0,p20=0,p30=0,p35=0,p50=0,p60=0,p70=0,p80=0,p90=0,p100=0,p120=0,p130=0,p150=0,p200=0,p250=0,p280=0,p320=0,p340=0;//郵資庫存
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'authority':
		                var as = _q_appendData('authority', '', true);
		                if (as.length > 0 && as[0]["pr_dele"] == "true")
		                    ischecker = true;
		                else
		                    ischecker = false;
		                break;
            	case 'postagestk':
            		p10=0,p20=0,p30=0,p35=0,p50=0,p60=0,p70=0,p80=0,p90=0,p100=0,p120=0,p130=0,p150=0,p200=0,p250=0,p280=0,p320=0,p340=0;
            		var as = _q_appendData("postages", "", true);
            		if(as[0]!=undefined){
            			for (var i = 0; i < as.length; i++) {
            				if(as[i].storeno==$('#txtStoreno').val() || $('#txtStoreno').val().length==0){
								p10+=dec(as[i].p10)
	            				p20+=dec(as[i].p20)
								p30+=dec(as[i].p30)
	            				p35+=dec(as[i].p35)
	            				p50+=dec(as[i].p50)
								p60+=dec(as[i].p60)
								p70+=dec(as[i].p70)
								p80+=dec(as[i].p80)
								p90+=dec(as[i].p90)
	            				p100+=dec(as[i].p100)
	            				p120+=dec(as[i].p120)
	            				p130+=dec(as[i].p130)
	            				p150+=dec(as[i].p150)
	            				p200+=dec(as[i].p200)
	            				p250+=dec(as[i].p250)
								p280+=dec(as[i].p280)
	            				p320+=dec(as[i].p320)
								p340+=dec(as[i].p340)
            				}
            			}
            		}
            		break;
                case 'sss':  
                    q_changeFill(t_name, ['txtSalesno', 'txtSales'], ['noa', 'namea']);
                    break;

                case q_name: if (q_cur == 4)  
                        q_Seek_gtPost();

                    if (q_cur == 1 || q_cur == 2) 
                        q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('postout_s.aspx', q_name + '_s', "510px", "360px", q_getMsg( "popSeek"));
        }

        function combPay_chg() {   
            var cmb = document.getElementById("combPay")
            if (!q_cur) 
                cmb.value = '';
            else
                $('#txtPay').val(cmb.value);
            cmb.value = '';
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            $('#txtWorker').val(r_name);
            if(!ischecker)
					$('#btnCheck').attr('disabled', 'disabled');
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            
            if(!emp($('#txtChecker').val())&&!ischecker){
            	alert('已核准不准修改!!');
				return;
			}
            
            if(emp($('#txtChecker').val())&&$('#txtSssno').val()!=r_userno&&!ischecker){
            	alert('非領用人禁止修改!!');
				return;
			}
            _btnModi();
            
            if(!emp($('#txtStoreno').val()))
				q_gt('postage_stk', "where=^^ a.storeno='"+$('#txtStoreno').val()+"' ^^" , 0, 0, 0, "postagestk", r_accy);//讀出庫存
            
            if(!ischecker)
					$('#btnCheck').attr('disabled', 'disabled');
					
            $('#txtComp').focus();
        }

        function btnPrint() {
 			q_box('z_postoutp.aspx', '', "95%", "95%", q_getMsg("popPrint"));
        }
        function btnOk() {
            var t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtStoreno', q_getMsg('lblStore')]]);

            if( t_err.length > 0) {
                alert(t_err);
                return;
            }
            
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('P' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }
       
        function refresh(recno) {
            _refresh(recno);
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            if (t_para) {
				$('#btnCheck').attr('disabled', 'disabled');
			}else{
				$('#btnCheck').removeAttr('disabled');
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
		
		function sum() {
			q_tr('txtTotal',round((q_float('txtP10')*1)+(q_float('txtP20')*2)+(q_float('txtP30')*3)+(q_float('txtP35')*3.5)+(q_float('txtP50')*5)+(q_float('txtP60')*6)+(q_float('txtP70')*7)+(q_float('txtP80')*8)+(q_float('txtP90')*9)+(q_float('txtP100')*10)+(q_float('txtP120')*12)+(q_float('txtP130')*13)+(q_float('txtP150')*15)+(q_float('txtP200')*20)+(q_float('txtP250')*25)+(q_float('txtP280')*28)+(q_float('txtP320')*32)+(q_float('txtP340')*34),1));
        }
		
        function btnSeek(){
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
        
        function q_popPost(s1) {
			switch (s1) {
				case 'txtStoreno':
					if(!emp($('#txtStoreno').val()))
						q_gt('postage_stk', "where=^^ a.storeno='"+$('#txtStoreno').val()+"' ^^" , 0, 0, 0, "postagestk", r_accy);//讀出庫存
					break;
			}
		}
        
        
    </script>
    <style type="text/css">
                 #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 25%;
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
                width: 73%;
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
                width: 100%;
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
                width: 25%;
                float: left;
            }
            .txt.c5 {
                width: 75%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:25%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:40%"><a id='vewNamea'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='namea'>~namea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 74%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
          <tr class="tr1">
          	   <td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
               <td class="td2" colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblDatea" class="lbl"> </a></td>
               <td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id="lblChecker" class="lbl"> </a></td>
               <td class="td6"><input id="txtChecker" type="text" class="txt c1"/></td>
               <td class="td7"><input id="btnCheck" type="button" /></td>
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblSss" class="lbl btn" > </a></td>
               <td class="td2" colspan="2"><input id="txtSssno"  type="text"  class="txt c2"/><input id="txtNamea"  type="text"  class="txt c3"/></td>
               <td class="td3" ><span> </span><a id="lblPart" class="lbl btn"> </a></td>
               <td class="td4" colspan="2"><input id="txtPartno"  type="text"  class="txt c2"/><input id="txtPart" type="text"  class="txt c3"/></td> 
            </tr>
            <tr class="tr3">
               <td class="td1"><span> </span><a id="lblSend" class="lbl btn" > </a></td>
               <td class="td2" colspan="2"><input id="txtSenderno"  type="text"  class="txt c2"/><input id="txtSender" type="text"  class="txt c3"/></td>
           </tr>
           <tr class="tr3">
               <td class="td1"><span> </span><a id="lblReceiver_cust" class="lbl btn" style="font-size: 14px;"> </a></td>
               <td class="td2"colspan="2"><input id="txtReceiverno_cust" type="text"  class="txt c2"/><input id="txtReceiver_cust"  type="text"  class="txt c3"/></td>
               <td class="td4"><span> </span><a id="lblCustno2" class="lbl btn"> </a></td>
               <td class="td5"colspan="5"><input id="txtCustno2" type="text"  class="txt c1"/></td>
            </tr>  
            <tr class="tr3">
               <td class="td1"><span> </span><a id="lblReceiver_tgg" class="lbl btn" style="font-size: 14px;"> </a></td>
               <td class="td2"colspan="2"><input id="txtReceiverno_tgg" type="text"  class="txt c2"/><input id="txtReceiver_tgg"  type="text"  class="txt c3"/></td>
               <td class="td4"><span> </span><a id="lblTggno2" class="lbl btn"> </a></td>
               <td class="td5"colspan="5"><input id="txtTggno2" type="text"  class="txt c1"/></td>            
            </tr>
           <tr class="tr4">
           		<td class="td1"><span> </span><a id='lblPostal_code' class="lbl"> </a></td>
               	<td class="td2"><input id="txtPostal_code" type="text" class="txt c1"/></td>      
               	<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
               	<td class="td2" colspan="6"><input id="txtMemo" type="text" class="txt c1"/></td>               
            </tr> 
            <tr class="tr5">
               <td class="td1" ><span> </span><a id="lblPtype" class="lbl"> </a></td>
               <td class="td1" ><select id="cmbTypea" class="txt c1"> </select></td>
               <td class="td1" ><span> </span><a id="lblStore" class="lbl btn"> </a></td>
               <td class="td1" ><input id="txtStoreno" type="text" class="txt c1"/></td>
               <td class="td1" ><input id="txtStore" type="text" class="txt c1"/></td>
            </tr> 
            <tr class="tr6">
               <td class="td1"><span> </span><a id="lblPosts" class="lbl"> </a></td>
			   <td class="td2"><span> </span><a id="lblP10a" class="lbl">1.0</a></td>
               <td class="td3"><input id="txtP10" type="text"  class="txt num c3" /></td>
               <td class="td2"><span> </span><a id="lblP20" class="lbl"> </a></td>
               <td class="td3"><input id="txtP20" type="text"  class="txt num c3" /></td>
			   <td class="td2"><span> </span><a id="lblP30" class="lbl">3.0</a></td>
               <td class="td3"><input id="txtP30" type="text"  class="txt num c3" /></td>
               <td class="td4"><span> </span><a id="lblP35" class="lbl"> </a></td>
               <td class="td5"><input id="txtP35" type="text"  class="txt num c3" /></td>
            </tr>      
             <tr class="tr7">
               <td class="td1"> </td>
			   <td class="td6"><span> </span><a id="lblP50" class="lbl"> </a></td>
			   <td class="td7"><input id="txtP50" type="text" class="txt num c3" /></td>
			   <td class="td6"><span> </span><a id="lblP60" class="lbl">6.0</a></td>
               <td class="td7"><input id="txtP60" type="text" class="txt num c3" /></td>
			   <td class="td6"><span> </span><a id="lblP70" class="lbl">7.0</a></td>
               <td class="td7"><input id="txtP70" type="text" class="txt num c3" /></td>
			   <td class="td6"><span> </span><a id="lblP80" class="lbl">8.0</a></td>
               <td class="td7"><input id="txtP80" type="text" class="txt num c3" /></td>      
            </tr>
            <tr class="tr8">
               <td class="td1"> </td>
			   <td class="td6"><span> </span><a id="lblP90" class="lbl">9.0</a></td>
               <td class="td7"><input id="txtP90" type="text" class="txt num c3" /></td>    
			   <td class="td8"><span> </span><a id="lblP100" class="lbl"> </a></td>
               <td class="td9"><input id="txtP100" type="text" class="txt num c3" /></td>
               <td class="td2"><span> </span><a id="lblP120" class="lbl"> </a></td>
               <td class="td3"><input id="txtP120" type="text" class="txt num c3" /></td>
               <td class="td4"><span> </span><a id="lblP130" class="lbl"> </a></td>
               <td class="td5"><input id="txtP130" type="text" class="txt num c3" /></td>              
            </tr>
			<tr class = "tr9">
			   <td class="td1"> </td>
			   <td class="td6"><span> </span><a id="lblP150" class="lbl"> </a></td>
               <td class="td7"><input id="txtP150" type="text" class="txt num c3" /></td> 
			   <td class="td8"><span> </span><a id="lblP200" class="lbl"> </a></td>
               <td class="td9"><input id="txtP200" type="text" class="txt num c3" /></td>  
               <td class="td2"><span> </span><a id="lblP250" class="lbl"> </a></td>
               <td class="td3"><input id="txtP250" type="text" class="txt num c3" /></td>
			   <td class="td2"><span> </span><a id="lblP280" class="lbl">28.0</a></td>
               <td class="td3"><input id="txtP280" type="text" class="txt num c3" /></td>
			</tr>
			<tr class ="tr10">
			   <td class="td1"> </td>
			   <td class="td4"><span> </span><a id="lblP320" class="lbl"> </a></td>
               <td class="td5"><input id="txtP320" type="text" class="txt num c3" /></td>
			   <td class="td4"><span> </span><a id="lblP340" class="lbl">34.0</a></td>
               <td class="td5"><input id="txtP340" type="text" class="txt num c3" /></td>
			   <td class="td6"> </td>
               <td class="td7"><input id="txtWorker" type="hidden" class="txt c1" /></td>
               <td class="td8"><span> </span><a id="lblTotal" class="lbl"> </a></td>
               <td class="td9"><input id="txtTotal" type="text" class="txt num c1" /></td>  
			</tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />
</body>
</html>
