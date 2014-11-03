<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 't';
            var q_name = "borrc";
            var q_readonly = ['txtCheckno','txtNoa','txtPaymoney','txtMoney','txtVccno','txtPayno','txtAccno','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney',10,0,1],['txtPaymoney',10,0,1]];
            var bbsNum = [['txtMoney',10,0,1]];
            var bbtNum = [['txtMoney',10,0,1]];
            var bbmMask = [['txtDatea', '999/99/99']];
            var bbsMask = [['txtIndate', '999/99/99']];
            var bbtMask = [['txtIndate', '999/99/99']];
            
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
			q_desc = 1;
            //q_xchg = 1;
            brwCount2 = 5;
            
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'] 
            , ['txtBankno_', 'btnBank_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx']
            , ['txtAcc1__', 'btnAcc1__', 'acc', 'acc1,acc2', 'txtAcc1__,txtAcc2__', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtBankno__', 'btnBank__', 'bank', 'noa,bank,account', 'txtBankno__,txtBank__,txtAccount__', 'bank_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
					
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                $('#btnIns').attr('value',$('#btnIns').attr('value')+"(F8)");
            	$('#btnOk').attr('value',$('#btnOk').attr('value')+"(F9)");
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
                $('#lblPayno').click(function() {
                	if($(this).val().length>0){
                		t_where = "noa='" + $('#txtPayno').val() + "'";
            		q_box("pay.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pay', "95%", "95%", q_getMsg('popPay'));
                	}
             	});
             	$('#lblVccno').click(function() {
                	if($('#txtVccno').val().length>0){
                		t_where = "noa='" + $(this).val() + "'";
            		q_box("vcctran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcc', "95%", "95%", q_getMsg('popVcctran'));
                	}
             	});
                $('#lblAccno').click(function() {
                	if($('#txtAccno').val().length>0){
                		q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                	}
                });
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
            function q_popPost(id) {
                switch (id) {//b_seq
                    default:
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
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
                    				alert('資料異常'+String.fromCharCode(13)+t_msg);
                    				Unlock();
                    			}else if(t_msg.length>0){
                    				alert(t_msg);
                    				Unlock();
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
                    			Unlock();
                    		}else{
                    			checkGqb_bbs(t_sel-1);
                    		}
                    	}else if(t_name.substring(0,13)=='gqb_btnOkbbt1'){
                    		//存檔時   bbst 支票號碼   先檢查view_gqb_chk,再檢查GQB
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
                    				checkGqb_bbt(t_sel-1);
                    			}
                    			else if(t_isExist && t_msg.length>0){
                    				alert('票據重覆。'+String.fromCharCode(13)+t_msg);
                    				Unlock();
                    			}
                    			else if(t_msg.length>0){
                    				alert(t_msg);
                    				Unlock();
                    			}else{
                    				//檢查GQB
	                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
	            					q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbt2_"+t_sel, r_accy);
                    			}
                    		}else{
                				//檢查GQB
                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
            					q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbt2_"+t_sel, r_accy);
                    		}
                    	}else if(t_name.substring(0,13)=='gqb_btnOkbbt2'){
                    		//存檔時   bbt 支票號碼檢查
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);               		
                    		var as = _q_appendData("gqb", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+as[0]['gqbno']+'】已存在');
                    			Unlock();
                    		}else{
                    			checkGqb_bbt(t_sel-1);
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
                    				Unlock();
                    			}else if(t_isExist && t_msg.length>0){
                    				alert('票據重覆。'+String.fromCharCode(13)+t_msg);
                    				Unlock();
                    			}else if(t_msg.length>0){
                    				alert(t_msg);
                    				Unlock();
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
                    		Unlock();
                    	}
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
                Unlock();
            }
            function btnOk() {
            	Lock();
                if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock();
                    return;
                }             
                var t_checkno = new Array();
                for(var i=0;i<q_bbsCount;i++)
                	if($('#txtCheckno_'+i).val().length>0)
                		t_checkno.push($('#txtCheckno_'+i).val());
                for(var i=0;i<q_bbtCount;i++)
                	if($('#txtCheckno__'+i).val().length>0)
                		t_checkno.push($('#txtCheckno__'+i).val());
                for(var i=0;i<t_checkno.length;i++)
                	for(var j=i+1;j<t_checkno.length;j++)
                		if(t_checkno[i]==t_checkno[j]){
                			alert('支票【'+t_checkno[i]+'】重覆。');
                			Unlock();
                			return;
                		}
                sum();
                //先檢查BBS再檢查BBT沒問題才存檔      
                checkGqb_bbs(q_bbsCount-1);	
            }
            function checkGqb_bbs(n){
            	if(n<0){
            		checkGqb_bbt(q_bbtCount-1);
            	}else{
            		if($.trim($('#txtCheckno_'+n).val()).length>0){
            			var t_noa = $('#txtNoa').val();
	    				var t_checkno = $('#txtCheckno_'+n).val() ;   	
	        			var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
	        			q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_btnOkbbs1_"+n+"_"+t_checkno+"_"+ t_noa, r_accy);
            		}else{
            			checkGqb_bbs(n-1);
            		}
            	}
            }
            function checkGqb_bbt(n){
            	if(n<0){
            		var t_checkno ='';
            		for(var i=0;i<q_bbsCount;i++){
            			if($('#txtCheckno_'+i).val().length>0)
            				t_checkno += (t_checkno.length>0?',':'') + $('#txtCheckno_'+i).val();
            		}
            		for(var i=0;i<q_bbtCount;i++){
            			if($('#txtCheckno__'+i).val().length>0)
            				t_checkno += (t_checkno.length>0?',':'') + $('#txtCheckno__'+i).val();
            		}
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
	                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_borrc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
	                else
	                    wrServer(t_noa);
            	}else{
            		if($.trim($('#txtCheckno__'+n).val()).length>0){
            			var t_noa = $('#txtNoa').val();
	    				var t_checkno = $('#txtCheckno__'+n).val() ;   	
	        			var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
	        			q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_btnOkbbt1_"+n+"_"+t_checkno+"_"+ t_noa, r_accy);
            		}else{
            			checkGqb_bbt(n-1);
            		}
            	}
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('borrc_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();           
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
					if(q_holiday){
						var isholiday=false;
						for(var i=0;i<q_holiday.length;i++){
							if(q_holiday[i]==t_date){
								isholiday=true;
								break;
							}
						}
						if(isholiday) continue;
					}
					t_day++;
				}
				for(var j = 0; j < q_bbsCount; j++) {
					if(r_rank<=7&&t_date>$('#txtDatea_'+j).val()){
						$('#btnPlus').attr('disabled', 'disabled');
						$('#btnMinus_'+j).attr('disabled', 'disabled');
						$('#txtCheckno_'+j).attr('disabled', 'disabled');
						$('#txtIndate_'+j).attr('disabled', 'disabled');
						$('#txtBankno_'+j).attr('disabled', 'disabled');
						$('#txtBank_'+j).attr('disabled', 'disabled');
						$('#txtAccount_'+j).attr('disabled', 'disabled');
						$('#txtMoney_'+j).attr('disabled', 'disabled');
						$('#txtMemo_'+j).attr('disabled', 'disabled');
					}
				}
                sum();
                $('#txtDatea').focus();
            }
            function btnPrint() {
            	q_box('z_borrc.aspx'+ "?;;;;"+r_accy+";noa="+trim($('#txtNoa').val()), '', "95%", "95%", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_'+i).text(i+1);	
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtIndate_'+i).datepicker();
                		$('#txtMoney_'+i).change(function(){
                			$(this).val(FormatNumber($(this).val()));
                			sum();
                		});
                		$('#txtCheckno_'+i).change(function(){
            				Lock();
            				var n = $(this).attr('id').replace('txtCheckno_','');
            				var t_noa = $('#txtNoa').val();
            				var t_checkno = $('#txtCheckno_'+n).val() ;
                			var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
                			q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_change1_"+n+"_"+t_checkno+"_"+ t_noa, r_accy);
                		});
                    }
                }
                _bbsAssign();
            }
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtIndate__'+i).datepicker();
                	 	$('#txtAcc1__'+i).change(function(e) {
		                    var patt = /^(\d{4})([^\.,.]*)$/g;
		                    $(this).val($(this).val().replace(patt,"$1.$2"));
		        		});
		        		$('#txtMoney__'+i).change(function(){
                			$(this).val(FormatNumber($(this).val()));
                			sum();
                		});
                		$('#txtCheckno__'+i).change(function(){
            				Lock();
            				var n = $(this).attr('id').replace('txtCheckno__','');
                			var t_noa = $('#txtNoa').val();
            				var t_checkno = $('#txtCheckno__'+n).val() ;
                			var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
                			q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_change1_"+n+"_"+t_checkno+"_"+ t_noa, r_accy);
                		});
                    }
                }
                _bbtAssign();
            }

            function bbsSave(as) {
                if (!as['checkno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function bbtSave(as) {
                if (!as['acc1']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function sum() {
            	if(!(q_cur==1 || q_cur==2))
					return;	
				var t_money = 0,t_interest=0,t_paymoney=0;
				for(var i = 0; i < q_bbsCount; i++) {
                	t_money += q_float('txtMoney_'+i);
                }
                for(var i = 0; i < q_bbtCount; i++) {
                	t_paymoney += q_float('txtMoney__'+i);
                }
                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtPaymoney').val(FormatNumber(t_paymoney));
            }
            function refresh(recno) {
                _refresh(recno);
                 
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                font-size: medium;
            }
            .dbbs {
                width: 950px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            #dbbt {
                width: 1200px;
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNick'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMoney'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='money,0,1' style="text-align: right;">~money,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height: 1px;">
						<td><input type="text" id="txtCheckno" style="display:none;"></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust"t class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCustno"  type="text"  style="float:left; width:30%;"/>
						<input id="txtComp"  type="text"  style="float:left; width:70%;"/>
						<input id="txtNick"  type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney"  type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblPaymoney" class="lbl"> </a></td>
						<td><input id="txtPaymoney"  type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtSalesno"  type="text"  style="float:left; width:40%;"/>
							<input id="txtSales"  type="text"  style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblVccno" class="lbl btn"> </a></td>
						<td><input id="txtVccno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPayno" class="lbl btn"> </a></td>
						<td><input id="txtPayno"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold; width:90%;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a id='lblCheckno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblIndate_s'> </a></td>
					<td align="center" style="width:205px;"><a id='lblBank_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblAccount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold; width:90%;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtCheckno.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtIndate.*" type="text" style="width: 95%;"/></td>
					<td>
						<input id="btnBank.*" type="button" style="float:left;width:15px;"/>
						<input id="txtBankno.*"type="text" style="float:left;width: 80px;"/>	
						<input id="txtBank.*" type="text" style="float:left;width:100px;"/>		
					</td>
					<td><input id="txtAccount.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMoney.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtMemo.*" type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:30px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="+"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:210px; text-align: center;">付款科目</td>
						<td style="width:100px; text-align: center;">金額</td>
						<td style="width:150px; text-align: center;">票據號碼</td>
						<td style="width:100px; text-align: center;">到期日</td>
						<td style="width:205px; text-align: center;">銀行</td>
						<td style="width:150px; text-align: center;">帳號</td>
						<td style="width:100px; text-align: center;">備註</td>				
					</tr>
					<tr>
						<td>
						<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold; width:90%;" value="-"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input class="btn"  id="btnAcc1..*" type="button" style=" font-weight: bold;width:10px;float:left;" />
	                        <input type="text" id="txtAcc1..*"  style="width:80px; float:left;"/>
	                        <span style="display:block; width:10px;float:left;"> </span>
							<input type="text" id="txtAcc2..*"  style="width:100px; float:left;"/>
						</td>
						<td><input id="txtMoney..*"  type="text" style="width:95%; text-align: right;"/></td>
						<td><input id="txtCheckno..*" type="text" style="width: 95%;"/></td>
						<td><input id="txtIndate..*" type="text" style="width: 95%;"/></td>
						<td>
							<input id="btnBank..*" type="button" style="float:left;width:15px;"/>
							<input id="txtBankno..*"type="text" style="float:left;width: 80px;"/>	
							<input id="txtBank..*" type="text" style="float:left;width:100px;"/>		
						</td>
						<td><input id="txtAccount..*" type="text" style="width: 95%;"/></td>
						<td><input id="txtMemo..*"  type="text" style="width:95%; text-align: left;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
