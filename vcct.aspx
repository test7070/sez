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
            var q_name = "vcct";
            var q_readonly = ['txtTotal'];
            var bbmNum = [['txtMoney',15,0,1],['txtTax',15,0,1],['txtTotal',15,0,1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 20;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa,noq';
            q_copy=1;
            aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);
            //ajaxPath = ""; //  execute in Root

            $(document).ready(function() {
                bbmKey = ['noa','noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
                q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
                $('#txtNoa').focus();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }

            function mainPost() {
            	bbmMask = [['txtDatea', r_picd],['txtMon', r_picm],['textBdate', r_picd],['textEdate', r_picd],['textMon', r_picm],['txtSerial', '99999999']];
                q_mask(bbmMask);
                
                q_cmbParse("cmbTypea", q_getPara('vcct.typea'));
                q_cmbParse("cmbKind", q_getPara('vcct.kind'));
                q_cmbParse("cmbTaxtype", q_getPara('vcct.taxtype'));
                q_cmbParse("cmbSpecialfood", q_getPara('vcct.specialfood'));
                q_cmbParse("cmbNotaxnote", q_getPara('vcct.notaxnote'));
                q_cmbParse("cmbPasstype", q_getPara('vcct.passtype'));
                q_cmbParse("cmbSpecialtax", q_getPara('vcct.specialtax'));
                
                $('#txtNoa').change(function(e) {
                    $(this).val($.trim($(this).val()).toUpperCase());
                    if ($(this).val().length > 0) {
                        if($('#cmbKind').val()=='23' || $('#cmbKind').val()=='24' || $('#cmbKind').val()=='33' || $('#cmbKind').val()=='34'){
	                		t_where = "where=^^ noa='" + $('#txtNoa').val() + "' and kind in('23','24','33','34') and mon='"+$('#txtMon').val()+"' ^^";
	                	}else{
	                		t_where = "where=^^ noa='" + $('#txtNoa').val() + "' and kind not in ('23','24','33','34') ^^";
	                	}
                        
                        q_gt('vcct', t_where, 0, 0, 0, "checkVcctno_change", r_accy);
                    }
                });
                
				$('#cmbTypea').change(function(e) {
                	$('#cmbKind').val('');
                	field_change();
                	refreshBbm();
                });
                 
				$('#cmbKind').change(function(e) {
                	field_change();
				});
				
				$('#txtMoney').change(function(e) {
                	calTax();
				});
				
				$('#txtSerial').change(function() {
					calTax();
				});
				
				$('#txtTax').change(function(e) {
					if('32,37,38'.indexOf($('#cmbKind').val())>-1
					|| ('22,27'.indexOf($('#cmbKind').val())>-1  && $('#txtDutymemo').val().length==0)
					|| ('31,35,36'.indexOf($('#cmbKind').val())>-1 && $('#txtSerial').val().length==0)
					|| $('#cmbTaxtype').val()=='2' || $('#cmbTaxtype').val()=='3' || $('#cmbTaxtype').val()=='6' || $('#cmbTaxtype').val()=='D'
					){
						$('#txtTax').val(0);
					}
					
                	$('#txtTotal').val(dec($('#txtTax').val())+dec($('#txtMoney').val()));
				});
                 
				$('#btnVcca').click(function() {
					$('#div_vcca').show();
					$('#div_vcca').css('top', $('#btnVcca').offset().top+25);
					$('#div_vcca').css('left', $('#btnVcca').offset().left-$('#div_vcca').width()+$('#btnVcca').width()+10);
				});
				
				$('#txtDatea').blur(function() {
					if(!emp($(this).val()) && (q_cur==1 || q_cur==2)){
						if(dec($(this).val().substr((r_len+1),2))%2==1)
							$('#txtMon').val(q_cdn($(this).val().substr(0,r_lenm)+'/01',62).substr(0,r_lenm));
						else
							$('#txtMon').val(q_cdn($(this).val().substr(0,r_lenm)+'/01',45).substr(0,r_lenm));
					}
				});
				
				$('#chkIsadd').click(function() {
					if(q_cur==1 || q_cur==2){
						if($('#chkIsadd').prop('checked'))
							$('#chkIsshare').prop('checked',false);
						field_change();
					}
				});
				
				$('#chkIsshare').click(function() {
					if(q_cur==1 || q_cur==2){
						if($('#chkIsshare').prop('checked'))
							$('#chkIsadd').prop('checked',false);
						field_change();
					}
				});
				
				$('#btn_div_vcca').click(function() {
					if(emp($('#textMon').val()) || emp($('#textBdate').val()) ||emp($('#textEdate').val())){
						alert('申報月份與發票日期禁止空白');
						return;
					}
					if(dec($('#textMon').val().substr((r_len+1),2))%2!=1){
						alert('申報月份只能單數月份');
						return;
					}
					
					var b_date=q_cdn($('#textMon').val()+'/01',-45).substr(0,r_lenm)+'/01';
					var e_date=q_cdn($('#textMon').val()+'/01',-1);
					if(!(($('#textBdate').val()>=b_date && $('#textBdate').val()<=e_date)
					&& ($('#textEdate').val()>=b_date && $('#textEdate').val()<=e_date))
					){
						alert('資料非'+b_date.substr(0,r_lenm)+'-'+e_date.substr(0,r_lenm));
						return;
					}
					
					var t_mon=!emp($('#textMon').val())?trim($('#textMon').val()):'#non';
					var t_bdate=!emp($('#textBdate').val())?trim($('#textBdate').val()):'#non';
					var t_edate=!emp($('#textEdate').val())?trim($('#textEdate').val()):'#non';
					var t_vcca=$('#checkVcca').prop('checked')?'1':'#non';
					var t_rc2a=$('#checkRc2a').prop('checked')?'1':'#non';
					var t_proj=q_getPara('sys.project').toUpperCase();
					var t_len=r_len;
					
					q_func('qtxt.query.vcct', 'vcct.txt,vcct,'+t_mon+';'+t_bdate+';'+t_edate+';'+t_vcca+';'+t_rc2a+';'+t_proj+';'+t_len);
				});
				
				$('#btnClose_div_vcca').click(function() {
					$('#div_vcca').hide();
				});
				
				$('#txtDutymemo').change(function() {
					if('32,37,38'.indexOf($('#cmbKind').val())>-1
					|| ('22,27'.indexOf($('#cmbKind').val())>-1  && $('#txtDutymemo').val().length==0)
					){
						$('#txtTax').val(0);
						$('#txtTotal').val(dec($('#txtTax').val())+dec($('#txtMoney').val()));
					}
					
					if($('#cmbKind').val()=='36'){
						$('#txtDutymemo').val(dec($('#txtDutymemo').val()));
						if($('#txtDutymemo').val()=='NaN'){
							$('#txtDutymemo').val('');
							alert('請輸入憑證號碼，需為數字型態。');
						}
					}
				});
				
				if(dec(q_date().substr((r_len+1),2))%2==1)
					$('#textMon').val(q_date().substr(0,r_lenm));
				else
					$('#textMon').val(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm));
				
				$('#textBdate').val(q_cdn($('#textMon').val()+'/01',-45).substr(0,r_lenm)+'/01');
				$('#textEdate').val(q_cdn($('#textMon').val()+'/01',-1));
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;

                }
            }
			
			var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
                    case 'checkVcctno_change':
                        var as = _q_appendData("vcct", "", true);
                        if (as[0] != undefined) {
                        	if($('#cmbKind').val()=='23' || $('#cmbKind').val()=='24' || $('#cmbKind').val()=='33' || $('#cmbKind').val()=='34'){
                        		alert('當月份已登陸【 ' + as[0].noa+'】折讓發票號碼，請確認是否正確!!(若無誤可不理會此訊息)');
                        	}else{                        	
                            	alert('已存在發票號碼【 ' + as[0].noa+'】');
                            }
                        }
                        break;
                    case 'checkVcctno_btnOk':
                        var as = _q_appendData("vcct", "", true);
                        if (as[0] != undefined) {
                        	if($('#cmbKind').val()=='23' || $('#cmbKind').val()=='24' || $('#cmbKind').val()=='33' || $('#cmbKind').val()=='34'){
                        		$('#txtNoq').val(('000'+(as.length+1)).slice(-3));
                        		wrServer($('#txtNoa').val());
                        	}else{
	                            alert('已存在 ' + as[0].noa);
	                            Unlock(1);
                           }
                        } else {
                        	$('#txtNoq').val('001');
                        	if($('#cmbTypea').val()=='2' && ($('#cmbKind').val()!='33' && $('#cmbKind').val()!='34' && $('#cmbKind').val()!='36' && $('#cmbKind').val()!='38')){
                        		var t_where = "where=^^ cno='" + $('#txtCno').val() + "' and ('" + $('#txtDatea').val() + "' between bdate and edate) " + " and exists(select noa from vccars where vccars.noa=vccar.noa and ('" + $('#txtNoa').val() + "' between binvono and einvono)) ^^";
                        		q_gt('vccar', t_where, 0, 0, 0, "", r_accy);
                        		break;
                        	}else{
	                            wrServer($('#txtNoa').val());
                           }
                        }
                        break;
                    case 'vccar':
                    	var as = _q_appendData("vccar", "", true);
						if (as[0] == undefined) {
							alert("請檢查發票號碼主檔設定，或發票已輸入。");
							Unlock(1);
						} else {
							wrServer($('#txtNoa').val());
						}
                    	break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                if(q_getPara('sys.project').toUpperCase()=='RB'){
                	q_box('vcct_s.aspx', q_name + '_s', "500px", "370px", q_getMsg("popSeek"));
                }else{
                	q_box('vcct_s.aspx', q_name + '_s', "500px", "340px", q_getMsg("popSeek"));
                }
            }
			
            function btnIns() {
            	t_noa=$('#txtNoa').val();
                _btnIns();
                $('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				
                refreshBbm();
                $('#txtNoa').focus();
                
                $('#cmbTypea').val('1').change();
                if(t_noa.length>0 && $('#chekQcopy').prop('checked')){
                	t_noa=t_noa.substr(0,7);
                	$('#txtNoa').val(t_noa);
                }
                $('#cmbKind').val('21');
                field_change();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnPrint() {
				q_box('z_vcct.aspx' + "?;;;noa='" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
				
				//107/03/14 回寫出貨單手開發票
				var t_sono=$('#txtSono').val();
				if(q_getPara('sys.project').toUpperCase()=='RB' && t_sono.length>0){
					q_func('qtxt.query.updatevcc_rb', 'vcct.txt,updatevcc_rb,'+t_sono+';'+$('#txtNoa').val());
				}
				
                Unlock();
            }

            function btnOk() {
            	Lock(1, {
					opacity : 0
				});
				
				if(q_cur==1){
					if(emp($('#txtNoa').val()) && (($('#cmbKind').val()=='22' || $('#cmbKind').val()=='23' ||$('#cmbKind').val()=='24'
						|| $('#cmbKind').val()=='25' || $('#cmbKind').val()=='27' || $('#cmbKind').val()=='34' || $('#cmbKind').val()=='37' || $('#cmbKind').val()=='38')
						&& $('#chkIscarrier').prop('checked') || $('#cmbKind').val()=='28' || $('#cmbKind').val()=='29' || $('#cmbKind').val()=='36')){
						if($('#txtDutymemo').val().length>0){
							$('#txtNoa').val($('#txtDutymemo').val());
						}
					}
				}
				
            	var t_err = '';
				t_err = q_chkEmpField([['cmbKind', q_getMsg('lblKind')], ['txtNoa', q_getMsg('lblNoa')], ['txtMon', q_getMsg('lblMon')], ['txtDatea', q_getMsg('lblDatea')], ['txtCno', q_getMsg('lblAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					Unlock(1);
					return;
				}
				
				if(($('#cmbKind').val()=='22' && $('#chkIsadd').prop('checked'))|| $('#cmbKind').val()=='28' || $('#cmbKind').val()=='29' || $('#cmbKind').val()=='36'){
					if($('#txtDutymemo').val().length==0){
						alert($('#lblDutymemo').text()+'禁止空白!!');
						Unlock(1);
						return;
					}
				}
            	
                $('#txtNoa').val($.trim($('#txtNoa').val()));
                $('#txtTotal').val(dec($('#txtTax').val())+dec($('#txtMoney').val()));
                
                if ($('#txtNoa').val().length > 0 && !(/^[a-z,A-Z]{2}[0-9]{8}$/g).test($('#txtNoa').val())
                && !(($('#cmbKind').val()=='22' && $('#chkIsadd').prop('checked')) 
				|| $('#cmbKind').val()=='28' || $('#cmbKind').val()=='29' || $('#cmbKind').val()=='36')
				&& !$('#chkIscarrier').prop('checked')
                ) {
					alert(q_getMsg('lblNoa') + '錯誤。');
					Unlock(1);
					return;
				}
				
				if(r_len==3){
					if (!(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
						alert(q_getMsg('lblMon') + '錯誤。');
						Unlock(1);
						return;
					}
				}
				if(r_len==4){
					if (!(/^[0-9]{4}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
						alert(q_getMsg('lblMon') + '錯誤。');
						Unlock(1);
						return;
					}
				}
                
                if (q_cur == 1) {
                	if($('#cmbKind').val()=='23' || $('#cmbKind').val()=='24' || $('#cmbKind').val()=='33' || $('#cmbKind').val()=='34'){
                		t_where = "where=^^ noa='" + $('#txtNoa').val() + "' ^^";
                	}else{
                		t_where = "where=^^ noa='" + $('#txtNoa').val() + "' and kind not in ('23','24','33','34') ^^";
                	}
                    q_gt('vcct', t_where, 0, 0, 0, "checkVcctno_btnOk", r_accy);
                } else {
                    wrServer($('#txtNoa').val());
                }

            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbmKey[1], '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
                field_change();
                $('#div_vcca').hide();
            }

            function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
                if(q_getPara('sys.project').toUpperCase()=='RB' && $('#cmbTypea').val()=='2' ){
					$('.rb').show();
					$('#lblSono').text('銷貨單號');
				}else{
					$('.rb').hide();
				}
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 if(t_para){
					$('#btnVcca').removeAttr('disabled');
				}else{
					$('#btnVcca').attr('disabled','disabled');
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
            
            function calTax(){
            	if($('#cmbKind').val()=='37' || $('#cmbKind').val()=='38'){
            		switch ($('#cmbSpecialtax').val()){
            			case '1':
            				$('#cmbSpecialfood').val('25');
            				break;
            			case '2':
            				$('#cmbSpecialfood').val('15');
            				break;
            			case '3':
            				$('#cmbSpecialfood').val('2');
            				break;
            			case '4':
            				$('#cmbSpecialfood').val('1');
            				break;
            			case '5':
            				$('#cmbSpecialfood').val('5');
            				break;
            			case '6':
            				$('#cmbSpecialfood').val('5');
            				break;
            			case '7':
            				$('#cmbSpecialfood').val('5');
            				break;
            			default:
            				$('#cmbSpecialfood').val('5');
            			//查定課徵 1%
            			//農產品0.1 %
            		}
            	}
            	
				var t_money=dec($('#txtMoney').val()),t_tax=0,t_total=dec($('#txtTotal').val());
				var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')) , 100);
				if('32,37,38'.indexOf($('#cmbKind').val())>-1
				 || ('22,27'.indexOf($('#cmbKind').val())>-1 && $('#txtDutymemo').val().length==0)
				 || ('31,35,36'.indexOf($('#cmbKind').val())>-1 && $('#txtSerial').val().length==0)
				){
					t_taxrate = 0;
				}
				switch ($('#cmbTaxtype').val()) {
					case '0':
	                   	// 無
						t_tax = 0;
						t_total = q_add(t_money,t_tax);
						break;
					case '1':
                        // 應稅
                        t_tax = round(q_mul(t_money,t_taxrate), 0);
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '2':
                        //零稅率
                        t_tax = 0;
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '3':
                        // 內含
                        t_tax = round(q_mul(q_div(t_money,q_add(1,t_taxrate)),t_taxrate), 0);
                        t_total = t_money;
                        t_money = q_sub(t_total,t_tax);
                        break;
                    case '4':
                        // 免稅
                        t_tax = 0;
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '5':
                        // 自定
                        //$('#txtTax').attr('readonly', false);
                        //$('#txtTax').css('background-color', 'white').css('color', 'black');
                        t_tax = round(q_float('txtTax'), 0);
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '6':
                        // 作廢-清空資料
                        t_money = 0, t_tax = 0, t_total = 0;
                        break;
                    default:
				}
			
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
				field_change();
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
            
            function field_change() {
            	
            	var x_kind=$('#cmbKind').val();
            	try{
            		if(x_kind=='')
            		x_kind=abbm[q_recno].kind;
            	}catch(e){
            		
            	}
            		
            	$('#cmbKind').text('');
            	var kind=q_getPara('vcct.kind').split(',');
                var t_kind='@';
                for(var i=0;i<kind.length;i++){
                	if($('#cmbTypea').val()=='1'){
	                	if(kind[i].split('@')[0].substr(0,1)=='2')
	                		t_kind=t_kind+(t_kind.length>0?',':'')+kind[i];
	                }else{
	                	if(kind[i].split('@')[0].substr(0,1)=='3')
	                		t_kind=t_kind+(t_kind.length>0?',':'')+kind[i];
	                }	
                }
                q_cmbParse("cmbKind", t_kind);
                $('#cmbKind').val(x_kind);
                
                //106/07/20 開放
                //$('#chkIsnondeductible').prop('checked',false);
                //$('.nondeductible').hide();//目前不開放抵扣
                
                //106/07/25 自我開立 二聯收銀機 隱藏 
                $('.self').hide();
                $('.two').hide();
                
                if($('#cmbTypea').val()=='1'){
                	$('.asset').show();
                	$('.typea1').show();
                	$('#lblSerial').text('銷售人統編');
                	if(q_getPara('sys.project').toUpperCase()=='RB'){
                		$('.rb').hide();
                	}
                	$('.typea2').hide();
                	$('#cmbSpecialfood').val('');
                	$('.notaxnote').hide();
                	$('#cmbNotaxnote').val('');
                	$('.nondeductible').show();
                	
                	//$('.two').hide();
                	//$('#chkIstwo').prop('checked',false);
                	
                	if('22,25,26,27'.indexOf($('#cmbKind').val())>-1 && $('#cmbKind').val()!=''){
                		$('.isadd').show();
                		if($('#cmbKind').val()=='26' || $('#cmbKind').val()=='27'){
                			$('#chkIsadd').prop('checked',true);
                		}
                	}else{
                		$('.isadd').hide();
                		$('#chkIsadd').prop('checked',false);
                	}
                	
                	if('23,25,22,24,27'.indexOf($('#cmbKind').val())>-1 && $('#cmbKind').val()!=''){
                		$('.carrier').show();
                	}else{
                		$('.carrier').hide();
                		$('#chkIscarrier').prop('checked',false);
                	}
                	
                	if($('#chkIsadd').prop('checked') && '22,25,26,27'.indexOf($('#cmbKind').val())>-1){
                		$('#txtSerial').val('').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                		if($('#cmbKind').val()=='22'){
                			$('#txtNoa').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                			if(q_cur==1){$('#txtNoa').val('');}
                		}else{
                			if(q_cur==1)
                				$('#txtNoa').removeAttr('disabled').css('background','white');
                		}
                		if(q_cur==1 || q_cur==2)
                			$('#txtMount').removeAttr('disabled').css('background','white');
                	}else{
                		if(q_cur==1 || q_cur==2){
	                		$('#txtSerial').removeAttr('disabled').css('background','white');
	                		if(q_cur==1)
	                			$('#txtNoa').removeAttr('disabled').css('background','white');
                		}
                		$('#txtMount').val('').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                	}
                	
                	//海關
                	if('28,29'.indexOf($('#cmbKind').val())>-1){
                		$('#txtSerial').val('').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                		$('#txtNoa').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                		if(q_cur==1){$('#txtNoa').val('');}
                		$('#txtMount').val('').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                	}
                	
                	if($('#cmbKind').val()=='25' && (q_cur==1 || q_cur==2)){ //分攤
                		$('.share').show();
                	}else{
                		$('.share').hide();
                		$('#chkIsshare').prop('checked',false);
                	}
                	//22,24,27 其他憑證
                	//23,25 載具流水號
                	//28,29 海關繳納證號碼
                	if('22,23,24,25,27,28,29'.indexOf($('#cmbKind').val())>-1 && $('#cmbKind').val()!=''){
                		$('#txtDutymemo').removeAttr('disabled').css('background','white');
                		if('22,24,27'.indexOf($('#cmbKind').val())>-1){
                			$('#lblDutymemo').text('其他憑證');
                		}else if('23,25'.indexOf($('#cmbKind').val())>-1){
                			$('#lblDutymemo').text('載具流水號');
                		}else{
                			$('#lblDutymemo').text('海關繳納憑證');
                		}
                	}else{
                		$('#lblDutymemo').text('憑證/流水號');
                		$('#txtDutymemo').val('').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                	}
                	
                	//106/07/13 開啟使用 XY有零稅率海關問題
                	$('.passtype').hide();
                	$('#cmbPasstype').val('');
                }else{
                	$('.asset').hide();
                	if(q_cur==1 || q_cur==2){
	                	$('#txtSerial').removeAttr('disabled').css('background','white');
	                	if(q_cur==1)
	                		$('#txtNoa').removeAttr('disabled').css('background','white');
	                }
                	$('#txtMount').val('').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                	$('.notaxnote').show();
                	
                	if(q_getPara('sys.project').toUpperCase()=='RB'){
	                	$('.rb').show();
	                }
	                
	                if('37,38'.indexOf($('#cmbKind').val())>-1 && $('#cmbKind').val()!=''){
                		$('.typea2').show();
                	}else{
                		$('.typea2').hide();
                	}
                	
                	$('.nondeductible').hide();
                	$('.carrier').hide();
                	$('.share').hide();
                	
                	if('31,32,35,36'.indexOf($('#cmbKind').val())>-1 && $('#cmbKind').val()!=''){
                		$('.isadd').show();
                	}else{
                		$('.isadd').hide();
                		$('#chkIsadd').prop('checked',false);
                	}
                	
                	if($('#chkIsadd').prop('checked') && $('#cmbKind').val()!='36'){
                		$('#lblSerial').text('發票訖號');
                	}else{
                		$('#lblSerial').text('買受人統編');
                	}
                	
                	if($('#cmbKind').val()=='36'){
                		$('#txtNoa').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                		if(q_cur==1){$('#txtNoa').val('');}
                	}else{
                		if(q_cur==1)
                			$('#txtNoa').removeAttr('disabled').css('background','white');
                	}
                	
                	/*if('32,34'.indexOf($('#cmbKind').val())>-1 && $('#cmbKind').val()!=''){
                		$('.two').show();
                	}else{
                		$('.two').hide();
                		$('#chkIstwo').prop('checked',false);
                	}*/
                	
                	//其他憑證
                	if('34,36,37,38'.indexOf($('#cmbKind').val())>-1 && $('#cmbKind').val()!=''){
                		$('.typea1').show();
                		$('#lblDutymemo').text('其他憑證');
                		$('#txtDutymemo').removeAttr('disabled').css('background','white');
                		if($('#cmbKind').val()=='36')
                			$('.carrier').hide();
                		else
                			$('.carrier').show();
                	}else{
                		$('.typea1').hide();
                		$('#lblDutymemo').text('憑證/流水號');
                		$('#txtDutymemo').val('').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
                		$('.carrier').hide();
                	}
                	
                	//106/07/13 開啟使用 XY有零稅率海關問題
                	if($('#cmbTaxtype').val()=='2' && $('#cmbKind').val()!='33' && $('#cmbKind').val()!='34'){
	                	$('.passtype').show();
                	}else{
                		$('.passtype').hide();
                		$('#cmbPasstype').val('');
                	}
                }
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.vcct':
                		alert("資料匯入完成!!");
                		$('#div_vcca').hide();
                		
                		var s2=[];
						s2[0]=q_name + '_s';
						s2[1]="where=^^ datea<='"+q_date()+"' ^^"
						q_boxClose2(s2);
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
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_vcca" style="position:absolute; top:0px; left:0px; display:none; width:310px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_vcca" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">申報月份</td>
					<td style="background-color: #f8d463;"><input id='textMon' type='text' style='text-align:left;width:80px;'/></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">發票日期</td>
					<td style="background-color: #f8d463;">
						<input id='textBdate' type='text' style='text-align:left;width:80px;'/>	~
						<input id='textEdate' type='text' style='text-align:left;width: 80px;'/>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">銷項發票</td>
					<td style="background-color: #f8d463;"><input id="checkVcca" type="checkbox" style="float: left;"/></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">進項發票</td>
					<td style="background-color: #f8d463;"><input id="checkRc2a" type="checkbox" style="float: left;"/></td>
				</tr>
				<tr id='vcca_close'>
					<td align="center" colspan="2">
						<input id="btn_div_vcca" type="button" value="匯入營業稅">
						<input id="btnClose_div_vcca" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:30%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:28%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:13%"><a id='vewMon'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='mon'>~mon</td>
						<td align="center" id='datea'>~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id="lblKind" class="lbl"> </a></td>
						<td colspan="3">
							<select id="cmbKind" class="txt c1"> </select>
							<input id="txtNoq" type="hidden">
						</td>
						<td> </td>
						<td><input id="btnVcca" type="button"/></td>
						<td style="width:1%;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCno" type="text" style="float:left; width:25%;">
							<input id="txtAcomp" type="text" style="float:left; width:75%;"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td colspan="4">
							<span style="float: left;"> </span><span style="float: left;"> </span>
							<a id='lblIsadd' class="lbl isadd" style="float: left;"> </a><span style="float: left;" class="isadd"> </span><input id="chkIsadd" type="checkbox" style="float: left;" class="isadd"/> 
							<a id='lblIsshare' class="lbl share" style="float: left;"> </a><span style="float: left;" class="share"> </span><input id="chkIsshare" type="checkbox" style="float: left;" class="share"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial"  type="text" class="txt c1" /></td>
						<td colspan="4"> 
							<span style="float: left;"> </span><span style="float: left;"> </span>
							<a id='lblIstwo' class="lbl two" style="float: left;"> </a><span style="float: left;" class="two"> </span><input id="chkIstwo" type="checkbox" style="float: left;" class="two"/>
							<a id='lblIsasset' class="lbl asset" style="float: left;"> </a><span style="float: left;" class="asset"> </span><input id="chkIsasset" type="checkbox" style="float: left;" class="asset"/>
							<a id='lblIsself' class="lbl self" style="float: left;"> </a><span style="float: left;" class="self"> </span><input id="chkIsself" type="checkbox" style="float: left;" class="self"/>
							<a id='lblIsnondeductible' class="lbl nondeductible" style="float: left;"> </a><span style="float: left;" class="nondeductible"> </span><input id="chkIsnondeductible" type="checkbox" style="float: left;" class="nondeductible"/>
							<a id='lblIscarrier' class="lbl carrier" style="float: left;"> </a><span style="float: left;" class="carrier"> </span><input id="chkIscarrier" type="checkbox" style="float: left;" class="carrier"/>
						</td>
						<td class="notaxnote"><span> </span><a id='lblNotaxnote' class="lbl"> </a></td>
						<td class="notaxnote"><select id="cmbNotaxnote" class="txt c1"> </select></td>
					</tr>
					<tr class="typea1">
						<td><span> </span><a id='lblDutymemo' class="lbl"> </a></td>
						<td><input id="txtDutymemo"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td><input id="txtMount"  type="text" class="txt num c1" /></td>
					</tr>
					<tr class="typea2">
						<td><span> </span><a id='lblSpecialtax' class="lbl"> </a></td>
						<td><select id="cmbSpecialtax" class="txt c1" onchange="calTax();"> </select></td>
						<td style="display: none;"><span> </span><a id='lblSpecialfood' class="lbl"> </a></td>
						<td style="display: none;"><select id="cmbSpecialfood" class="txt c1" onchange="calTax();"> </select></td>
					</tr>
					<tr class="passtype">
						<td><span> </span><a id='lblPasstype' class="lbl"> </a></td>
						<td><select id="cmbPasstype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
						<td><select id="cmbTaxtype" class="txt c1" onchange="calTax();"> </select></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text" class="txt num c1" /></td>
					</tr>
					<tr class="rb">
						<td><span> </span><a id='lblSono' class="lbl"> </a></td>
						<td><input id="txtSono"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblBook' class="lbl"> </a></td>
						<td><input id="txtBook"  type="text" class="txt num c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
