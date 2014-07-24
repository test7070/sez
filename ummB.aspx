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
        var q_name = "ummb";
        var q_readonly = ['txtNoa','txtDatea','txtBkvccno','txtSaleno','txtWorker','txtWorker2'];
        var q_readonlys = ['txtVccno','txtVccnoq','txtMount','txtTotal'];
        var bbmNum = [];  
        var bbsNum = [['txtMount', 15, 0,1], ['txtPrice', 15, 2,1], ['txtTotal', 15, 0,1], ['txtBkmount', 15, 0,1], ['txtBkmoney', 15, 0,1], ['txtSalemount', 15, 0,1], ['txtSalemoney', 15, 0,1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
        ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
        ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
        ['txtVccno', '', 'view_vcc', 'noa,salesno,sales', 'txtVccno,txtSalesno,txtSales', ''],
        ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
			q_gt(q_name, q_content, q_sqlCount, 1)  
			q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  
            {
                dataErr = false;
                return;
            }
            mainForm(1); 
        }
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtChgdate', r_picd],['txtBkdate',r_picd],['txtVccdate',r_picd],['txtVbdate',r_picd],['txtVedate',r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('ummb.typea')); 
             
             
             $('#btnVccs').click(function () {
             	//換單 不匯入直接在BBM打單號和換單帳款月份
                var t_custno = trim($('#txtCustno').val());
                var t_vbdate = trim($('#txtVbdate').val());
                var t_vedate = trim($('#txtVedate').val());
                var t_vccno = trim($('#txtVccno').val());
	            var t_where = "1=1";
	            if($('#cmbTypea').val()=='1'){//退貨--->建立 退貨單 
	            	//1030124永勝林先生換單還是可以退貨
					//"&& noa not in (select noa from view_vcc where isnull(cardeal,'') in (select noa from ummb where typea='3')) " //換單不可再退貨
					t_where+=(t_custno.length > 0 ? q_sqlPara2("custno", t_custno) : "")
					+q_sqlPara2("datea", t_vbdate,t_vedate)
					+(t_vccno.length > 0 ? q_sqlPara2("noa", t_vccno): "")+"&& typea='1' && noa not in (select noa from view_vcc where unpay>=0 and payed>0)"
					+" && lengthb-isnull((select SUM(bkmount)-SUM(salemount) from ummbs where vccno=a.noa and vccnoq=a.noq),0)!=0 ";
					q_box("vccs_ummb_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccs_1', "95%", "95%", q_getMsg('popVccs'));
	            }else if($('#cmbTypea').val()=='2'){//換貨--->匯入【未收】出貨單--->一次一張需整張處理完--->退舊產品：系統自動建立 退貨單, 出新產品：系統自動建立 新出貨單
	            	//alert('請選擇同一出貨單號的產品!!');
	            	t_where+=(t_custno.length > 0 ? q_sqlPara2("custno", t_custno) : "")
					+q_sqlPara2("datea", t_vbdate,t_vedate)
					+(t_vccno.length > 0 ? q_sqlPara2("noa", t_vccno) : "")+" && noa in (select noa from view_vcc where isnull(payed,0)=0) && typea='1' ";
					q_box("vccs_ummb_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccs_2', "95%", "95%", q_getMsg('popVccs'));
	            }else if($('#cmbTypea').val()=='4'){//已收抵貨--->匯入【已收】出貨單--->退舊產品：系統自動建立 退貨單, 出新產品：系統自動建立  新出貨單(歸已收款，不再有未收)
	            	//alert('請選擇同一出貨單號的產品!!');
	            	t_where+=(t_custno.length > 0 ? q_sqlPara2("custno", t_custno) : "")
					+q_sqlPara2("datea", t_vbdate,t_vedate)
					+(t_vccno.length > 0 ? q_sqlPara2("noa", t_vccno) : "")+" && noa in (select noa from view_vcc where isnull(payed,0)>0) && typea='1' ";
					q_box("vccs_ummb_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccs_4', "95%", "95%", q_getMsg('popVccs'));
	            }
            });
            
            $('#cmbTypea').change(function() {
            	for (var i = 0; i < q_bbsCount; i++) {$('#btnMinus_' + i).click();}
            	fieldsdisabled ();
			});
			
			$('#txtBkvccno').click(function() {
				if($('#txtBkvccno').val().length>0)
            		q_box("vcc_uu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'" + $(this).val() +"')>0;" + $('#txtDatea').val().substr(0,3), "vcc", "95%", "95%", q_getMsg("popVcc"));
			});
			$('#txtVccno').click(function() {
				if($('#txtVccno').val().length>0 && q_cur!=1 && q_cur!=2)
            		q_box("vcc_uu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'" + $(this).val() +"')>0;" + $('#txtVccno').val().substr(1,3), "vcc", "95%", "95%", q_getMsg("popVcc"));
			});
			
			$('#txtSaleno').click(function() {
				if($('#txtSaleno').val().length>0)
            		q_box("vcc_uu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + $('#txtDatea').val().substr(0,3), "vcc", "95%", "95%", q_getMsg("popVcc"));
			});
            
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
            	case 'vccs_1':
            	if (q_cur > 0 && q_cur < 4) {
            		b_ret = getb_ret();
					///  q_box() 執行後，選取的資料
					if (!b_ret || b_ret.length == 0)
						return;
					//清空bbs
					for (var i = 0; i < q_bbsCount; i++) {$('#btnMinus_' + i).click();}
					ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtMount,txtPrice,txtTotal,txtBkmount,txtBkmoney,txtVccno,txtVccnoq'
					, b_ret.length, b_ret, 'productno,product,lengthb,price,total,lengthb,total,noa,noq', '');
					fieldsdisabled ();
            	}
            	break;
            	case 'vccs_2':
            	if (q_cur > 0 && q_cur < 4) {
            		b_ret = getb_ret();
					///  q_box() 執行後，選取的資料
					if (!b_ret || b_ret.length == 0)
						return;
					var t_noa='';
					for (var i = 0; i < b_ret.length; i++) {
						if(t_noa.length>0){
							if(t_noa!=b_ret[i].noa){
								b_ret.splice(i, 1);
								i--;
							}
						}else{
							t_noa=b_ret[i].noa;
						}
					}
					//清空bbs
					for (var i = 0; i < q_bbsCount; i++) {$('#btnMinus_' + i).click();}
					ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtMount,txtPrice,txtTotal,txtBkmount,txtBkmoney,txtVccno,txtVccnoq'
					, b_ret.length, b_ret, 'productno,product,lengthb,price,total,lengthb,total,noa,noq', '');
					fieldsdisabled ();
            	}
            	break;
            	case 'vccs_4':
            	if (q_cur > 0 && q_cur < 4) {
            		b_ret = getb_ret();
					///  q_box() 執行後，選取的資料
					if (!b_ret || b_ret.length == 0)
						return;
					var t_noa='';
					for (var i = 0; i < b_ret.length; i++) {
						if(t_noa.length>0){
							if(t_noa!=b_ret[i].noa){
								b_ret.splice(i, 1);
								i--;
							}
						}else{
							t_noa=b_ret[i].noa;
						}
					}
					//清空bbs
					for (var i = 0; i < q_bbsCount; i++) {$('#btnMinus_' + i).click();}
					ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtMount,txtPrice,txtTotal,txtBkmount,txtBkmoney,txtVccno,txtVccnoq'
					, b_ret.length, b_ret, 'productno,product,lengthb,price,total,lengthb,total,noa,noq', '');
					fieldsdisabled ();
            	}
            	break;
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }

		var z_cno=r_cno,z_acomp=r_comp,z_nick=r_comp.substr(0,2);
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'btnDele':
						var as = _q_appendData("umms", "", true);
						if (as[0] != undefined) {
							var z_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (z_msg.length > 0) {
								alert('已沖帳:' + z_msg);
								Unlock(1);
								return;
							}
						}
						_btnDele();
						Unlock(1);
						break;
            	case 'btnModi':
						var as = _q_appendData("umms", "", true);
						if (as[0] != undefined) {
							var z_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (z_msg.length > 0) {
								alert('已沖帳:' + z_msg);
								Unlock(1);
								return;
							}
						}
						_btnModi();
		            	fieldsdisabled();
		            	$('#txtCustno').focus();
		            	Unlock(1);
						break;
            	case 'cno_acomp':
                		var as = _q_appendData("acomp", "", true);
                		if (as[0] != undefined) {
	                		z_cno=as[0].noa;
	                		z_acomp=as[0].acomp;
	                		z_nick=as[0].nick;
	                	}
                		break;
                case q_name: 
                	if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            
            if($('#cmbTypea').val()=='1'&&emp($('#txtBkdate').val())){
            	alert('請填入'+q_getMsg('lblBkdate'));
            	return;
            }
            	
            if(($('#cmbTypea').val()=='2'||$('#cmbTypea').val()=='4' )&&(emp($('#txtBkdate').val()) || emp($('#txtVccdate').val()))){
            	alert('請填入'+q_getMsg('lblBkdate')+'、'+q_getMsg('lblVccdate'));
            	return;
            }
            	
            if($('#cmbTypea').val()=='3'&&(emp($('#txtChgdate').val()) || emp($('#txtVccno').val()))){
            	alert('請填入'+q_getMsg('lblChgdate')+'、'+q_getMsg('lblVccno'));
            	return;	
			}
			
            if(q_cur ==1){
				$('#txtWorker').val(r_name);
			}else if(q_cur ==2){
				$('#txtWorker2').val(r_name);
			}
			
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ummb') + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('ummb_s.aspx', q_name + '_s', "500px", "430px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
        	for (var i = 0; i < q_bbsCount; i++) {
	        	if ($('#btnMinus_' + i).hasClass('isAssign'))/// 重要
					continue;
				$('#txtVccno_'+i).bind('contextmenu',function(e) {
					/*滑鼠右鍵*/
					e.preventDefault();
					q_box("vcc_uu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + $(this).val().substr(1,3), "vcc", "95%", "95%", q_getMsg("popVcc"));
				});
				
				$('#txtPrice_' + i).change (function() {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					
					q_tr('txtBkmoney_'+b_seq,q_mul(q_float('txtBkmount_'+b_seq),q_float('txtPrice_'+b_seq)));
					q_tr('txtSalemoney_'+b_seq,q_mul(q_float('txtSalemount_'+b_seq),q_float('txtPrice_'+b_seq)));
				});
				
				$('#txtBkmount_' + i).change (function() {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					
					q_tr('txtBkmoney_'+b_seq,q_mul(q_float('txtBkmount_'+b_seq),q_float('txtPrice_'+b_seq)));
				});
				
				$('#txtSalemount_' + i).change (function() {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					
					q_tr('txtSalemoney_'+b_seq,q_mul(q_float('txtSalemount_'+b_seq),q_float('txtPrice_'+b_seq)));
				});
			}
            _bbsAssign();
            fieldsdisabled ();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtCno').val(z_cno);
            $('#txtAcomp').val(z_acomp);
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            fieldsdisabled ();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
			if($('#cmbTypea').val()=='1' || $('#cmbTypea').val()=='2'){
				Lock(1, {
					opacity : 0
				});
				var t_where = " where=^^ charindex(vccno,'" + $('#txtBkvccno').val()+','+$('#txtSaleno').val()+ "' )>0 ^^";
				q_gt('umms', t_where, 0, 0, 0, 'btnModi', r_accy);
			}else{
            	_btnModi();
            	fieldsdisabled();
            	$('#txtCustno').focus();
           }
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['productno'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['datea'] = abbm2['datea'];
         
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j

        }

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            fieldsdisabled ();
       }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            fieldsdisabled ();
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
        	if($('#cmbTypea').val()=='1' || $('#cmbTypea').val()=='2'){
				Lock(1, {
					opacity : 0
				});
				var t_where = " where=^^ charindex(vccno,'" + $('#txtBkvccno').val()+','+$('#txtSaleno').val()+ "' )>0 ^^";
				q_gt('umms', t_where, 0, 0, 0, 'btnDele', r_accy);
			}else{
            	_btnDele();
           }
        }

        function btnCancel() {
            _btnCancel();
        }
        
        function FormatNumber(n) {
				var xx = "";
				if (n < 0) {
					n = Math.abs(n);
					xx = "-";
				}
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}
        
        function fieldsdisabled () {
        	
            if($('#cmbTypea').val()=='3'){
            	$('#btnVccs').hide();
            }else{
            	$('#btnVccs').show();
            }
            if(q_cur==1 || q_cur==2){
           
		       for (var i = 0; i < q_bbsCount; i++) {
					if($('#cmbTypea').val()=='1'){
						$('#txtProductno_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtProduct_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtPrice_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtBkmount_' + i).css('color','black').css('background','white').removeAttr('readonly');
						$('#txtBkmoney_' + i).css('color','black').css('background','white').removeAttr('readonly');
		           		$('#txtSalemount_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtSalemoney_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtMemo_' + i).css('color','black').css('background','white').removeAttr('readonly');
					}else if ($('#cmbTypea').val()=='2' || $('#cmbTypea').val()=='4'){
						if(!emp($('#txtVccno_'+i).val())){
		            		$('#txtProductno_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtProduct_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtPrice_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtBkmount_' + i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtBkmoney_' + i).css('color','black').css('background','white').removeAttr('readonly');
		           			$('#txtSalemount_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtSalemoney_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtMemo_' + i).css('color','black').css('background','white').removeAttr('readonly');
						}else{
							$('#txtProductno_' + i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtProduct_' + i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtPrice_' + i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtBkmount_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
							$('#txtBkmoney_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
		           			$('#txtSalemount_' + i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtSalemoney_' + i).css('color','black').css('background','white').removeAttr('readonly');
							$('#txtMemo_' + i).css('color','black').css('background','white').removeAttr('readonly');
						}
		        	}else{
		        		$('#txtProductno_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtProductno_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtProduct_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtPrice_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtBkmount_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtBkmoney_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
		           		$('#txtSalemount_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtSalemoney_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
						$('#txtMemo_' + i).css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
		        	}
				}
			}
        }
        
    </script>
    <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 23%;
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
                width: 75%;
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
                float: left;
            }
            .txt.c3 {
                width: 62%;
                float: left;
            }
            .txt.c4 {
                width: 47%;
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
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs{
            	float:left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:100% ;  
        } 
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="width: 1260px;">
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:40%"><a id='vewCust'></a></td>
            </tr>
             <tr>
                <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                <td align="center" id='datea'>~datea</td>
                <td align="center" id='comp'>~comp</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
            	<td class="td1"><span> </span><a id='lblTypea' class="lbl"> </a></td>
				<td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
				<td class="td3"><span> </span><a id='lblDatea' class="lbl" > </a></td>
				<td class="td4"><input id="txtDatea"  type="text" class="txt c1"/></td>
				<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
				<td class="td6"><input id="txtNoa"   type="text" class="txt c1"/></td> 
            </tr>   
            <tr>
            	<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
                <td class="td2" colspan="2"><input id="txtCustno" type="text" class="txt c2"/>
                <input id="txtComp"  type="text" class="txt c3"/></td>
				<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
				<td class="td2" colspan="2"><input id="txtCno"  type="text"  class="txt c2"/>
				<input id="txtAcomp"    type="text"  class="txt c3"/></td>
            </tr>
            <tr>
                <td class="td1"><span> </span><a id='lblVdate' class="lbl"> </a></td>
                <td class="td2" colspan="2">
                	<input id="txtVbdate" type="text" class="txt c4" /> <a class="lbl" style="float: left;">~</a>
                	<input id="txtVedate" type="text" class="txt c4"/>
                </td> 
                <td class="td4"><span> </span><a id='lblVccno' class="lbl"> </a></td>
				<td class="td5"><input id="txtVccno"  type="text"  class="txt c1"/></td> 
				<td class="td6"><input id="btnVccs" type="button"/></td>
             </tr>
             <tr>
            	<td class="td1"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
                <td class="td2"><input id="txtSalesno"  type="text" class="txt c1"/></td>
                <td class="td2"><input id="txtSales"  type="text" class="txt c1"/></td>
            </tr>
             <tr>
            	<td class="td5"><span> </span><a id='lblChgdate' class="lbl"> </a></td>
				<td class="td6"><input id="txtChgdate"  type="text"  class="txt c1"/></td> 
                <td class="td5"><span> </span><a id='lblBkdate' class="lbl" > </a></td>
				<td class="td6"><input id="txtBkdate"  type="text" class="txt c1"/></td>
				<td class="td5"><span> </span><a id='lblVccdate' class="lbl" > </a></td>
				<td class="td6"><input id="txtVccdate"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblBkvccno' class="lbl" > </a></td>
				<td class="td2"><input id="txtBkvccno"  type="text" class="txt c1"/></td>
				<td class="td3"><span> </span><a id='lblSaleno' class="lbl" > </a></td>
				<td class="td4"><input id="txtSaleno"  type="text" class="txt c1"/></td>	
				<td class="td5"><span> </span><a id='lblWorker' class="lbl"> </a></td>
				<td class="td6"><input id="txtWorker"  type="text"  class="txt c1"/></td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
                <td class="td2" colspan='3' ><input id="txtMemo"  type="text"  style="width: 98%;"/></td>
                <td class="td7"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
				<td class="td8"><input id="txtWorker2"  type="text"  class="txt c1"/></td>
			</tr>
        </table>
        </div> 
        </div>       
        <div class='dbbs' style="width: 1260px;">
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
              <tr style='color:White; background:#003366;' >
                <td align="center" style="width: 35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
				<td align="center" style="width: 200px;"><a id='lblProductno_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblMount_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblPrice_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblTotal_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblBkmount_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblBkmoney_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblSalemount_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblSalemoney_s'> </a></td>
                <td align="center"><a id='lblMemo_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>             
                <td >
                	<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width: 1%;" />
                	<input  id="txtProductno.*" type="text"  class="txt c3" style="width:85%"/>
                	<input  id="txtProduct.*" type="text"  class="txt c1"/>
                </td>
                <td ><input  id="txtMount.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtPrice.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtTotal.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtBkmount.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtBkmoney.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtSalemount.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtSalemoney.*" type="text" class="txt num c1"/></td>
                <td ><input id="txtMemo.*" type="text"  class="txt c1"/>
                	<input  id="txtVccno.*" type="text"  class="txt c1" style="width:75%"/>
                	<input  id="txtVccnoq.*" type="text"  class="txt c1" style="width:20%"/>
                <input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>

        <input id="q_sys" type="hidden" />
</body>
</html>
