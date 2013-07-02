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

            q_desc = 1;
            q_tables = 's';
            var q_name = "carcsa";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtWeight','txtMount','txtInmoney','txtOutmoney'];
            var q_readonlys = ['txtInmoney','txtOutmoney','txtTranno'];
            var bbmNum = [['txtWeight',10,3,1],['txtMount',10,3,1],['txtPrice',10,3,1]
            ,['txtInmoney',10,0,1]
            ,['txtOutmoney',10,0,1]];
            var bbsNum = [['txtWeight',10,3,1],['txtMount',10,3,1],['txtDiscount',10,3,1],['txtInmoney',10,0,1],['txtOutmoney',10,0,1],['txtOutprice',10,3,1]];
            var bbmMask = [['txtTrandate', '999/99/99'], ['txtBtime', '99:99'], ['txtEtime', '99:99'], ['txtMon', '999/99']];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(
            ['txtAddrno', '', 'addr', 'noa,addr,productno,product', 'txtAddrno,txtAddr,txtUccno,txtProduct', 'addr_b.aspx'],
            ['txtUccno', 'lblProduct', 'ucca', 'noa,product', 'txtUccno,txtProduct', 'ucca_b.aspx'],
            ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx'],
        	['txtCustno', '', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'],
        	['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']);

			brwCount2 = 15;
            q_xchg = 1;
            var calctypeItem = new Array();
            function currentData() {}
			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				include : ['txtTrandate','txtMon','cmbInterval','txtCustno','txtComp','txtNick','txtAddrno','txtAddr','txtUccno','txtProduct'],
				/*記錄當前的資料*/
				copy : function() {
					this.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in this.include) {
							if (fbbm[i] == this.include[j]) {
								isInclude = true;
								break;
							}
						}
						if (isInclude) {
							this.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in this.data) {
						$('#' + this.data[i].field).val(this.data[i].value);
					}
				}
			};
			var curData = new currentData();
			
			function carcsaData(){}
			carcsaData.prototype={
				isInit : false,
				type : new Array(),
				calctype : new Array(),
				init : function(){
            		Lock(1,{opacity:0});
            		q_gt('calctype', '', 0, 0, 0, 'carcsaInit_1');
            	}
			}
			var carcsa = new carcsaData();
			
			
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_desc = 1;
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_mask(bbmMask);
                carcsa.init();
				q_cmbParse("cmbOntime", ',Y');
				q_cmbParse("cmbInterval", q_getPara('carcsa.interval'));
				
				$("#txtAddrno").focus(function() {
					var input = document.getElementById ("txtAddrno");
		            if (typeof(input.selectionStart) != 'undefined' ) {	  
		                input.selectionStart = 5;
		                input.selectionEnd =8;
		            }
				});
                $('#combType').change(function() {         
                    var n = parseFloat($('#combType').val());
                    if(n>=0 && n<carcsa.type.length){
                    	$('#txtCartype').val(carcsa.type[n].cartype);
	                    $('#txtTypea').val(carcsa.type[n].memo);
	                    $('#cmbTypea2').val(carcsa.type[n].typea);
	                    $('#txtPrice').val(FormatNumber(carcsa.type[n].price));
	                    $('#txtType').val(carcsa.type[n].cartype+' '+carcsa.type[n].memo+' '+carcsa.type[n].typea+' '+FormatNumber(carcsa.type[n].price));
                    }/*else{
                    	alert(n+"__$('#combType').change");
                    }*/
                    sum();
                });
                $('#txtPrice').change(function() {
                    sum();
                });
                $('#lblType').click(function(){
                	q_box("carcsatype.aspx?" + r_userno + ";" + r_name + ";" + q_time, 'carcsatype', "95%", "95%", q_getMsg('popCarcsatype'));
                });
                $('#btnTran').click(function(){
                	var t_where = '',t_tranno='';
                    for (var i = 0; i < q_bbsCount; i++) {
                    	t_tranno = $.trim($('#txtTranno_'+i).val());
                    	if(t_tranno.length>0)
                    		t_where += (t_where.length > 0 ? ' or ' : '') + "noa='" + t_tranno + "'";
                    }
                   	if(t_where.length>0)
                   		q_pop('', "trans.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno+";", 'trans', 'noa', 'datea', "95%", "95%", q_getMsg('popTrans'), true);
               		else
               			alert('無出車單號。');
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
			function browTrans(obj){
				var noa = $.trim($(obj).val());
            	if(noa.length>0)
            		q_box("trans.aspx?;;;noa='" + noa + "';"+r_accy, 'trans', "95%", "95%", q_getMsg("popTarans"));
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
                	case 'holiday':
            				holiday = _q_appendData("holiday", "", true);
            				endacheck(abbm[q_recno].trandate,q_getPara('sys.modiday2'));//單據日期,幾天後關帳
            			break;
                	case 'carcsaInit_1':
						var as = _q_appendData("calctypes", "", true);
						var t_item = "@";
						carcsa.calctype.push({
							noa : '',
							typea : '',
							discount : 0,
							discount2 : 0,
							isoutside : false
						});
						for ( i = 0; i < as.length; i++) {
							if(as[i].noa+as[i].noq=="D01" || as[i].noa+as[i].noq=="D02" || as[i].noa+as[i].noq=="E01"){
								//for 大昌
								t_item += (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
								carcsa.calctype.push({
									noa : as[i].noa + as[i].noq,
									typea : as[i].typea,
									discount : as[i].discount,
									discount2 : as[i].discount2,
									isoutside : as[i].isoutside.length == 0 ? false : (as[i].isoutside == "false" || as[i].isoutside == "0" || as[i].isoutside == "undefined" ? false : true)
								});
							}
						}
						q_cmbParse("cmbCalctype", t_item, "s");
						q_gt('carcsatype', '', 0, 0, 0, 'carcsaInit_2');
						break;
                	case 'carcsaInit_2':
						var as = _q_appendData("carcsatype", "", true);
						var t_item = " @ ";
						var t_item2 = new Array();
						t_item2.push('');
						t_item2.push('全拖');
						t_item2.push('半拖');
						t_item2.push('小時');
						t_item2.push('塊');
						for ( i = 0; i < as.length; i++) {
							t_item += (t_item.length > 0 ? ',' : '')+ i+'@'+as[i].cartype + '_' + as[i].memo + '_' + as[i].typea + '_' + as[i].price;
							carcsa.type.push({
								noa : as[i].noa,
								cartype : as[i].cartype,
								memo : as[i].memo,
								typea : as[i].typea,
								price : parseFloat(as[i].price.length == 0 ? "0":as[i].price)
							});
							if(t_item2.indexOf(as[i].typea)<0){
								t_item2.push(as[i].typea);
							}
						}
						q_cmbParse("combType", t_item);
						if (abbm[q_recno] != undefined) {
                        	$("#combType").val(abbm[q_recno].cno);
                        }
                        t_item2.sort();
                        q_cmbParse("cmbTypea2", t_item2.toString());
                        
						carcsa.isInit = true;
						Unlock(1);
						break;
                	case 'addr':
                        var as = _q_appendData("addr", "", true);
                        if (as[0] != undefined) {
	                        $('#txtAddrno').val(as[0].noa);
	                        $('#txtAddr').val(as[0].addr);
	                        $('#txtUccno').val(as[0].productno);
	                        $('#txtProduct').val(as[0].product);
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,13)=="checkBbs_trds"){
                    		var t_accy = t_name.split('_')[2];
                    		var t_tranno = t_name.split('_')[3];
                    		var t_sel = parseFloat(t_name.split('_')[4]);
                    		var as = _q_appendData("view_trds", "", true);
                        	if (as[0] != undefined) {
                        		$('#btnMinus_' + t_sel).data('info').isTrd = true;
                        	}
                        	checkBbs(t_sel-1);
                    	}else if(t_name.substring(0,13)=="checkBbs_tres"){
						    var t_accy = t_name.split('_')[2];
                    		var t_tranno = t_name.split('_')[3];
                    		var t_sel = parseFloat(t_name.split('_')[4]);
                    		var as = _q_appendData("view_tres", "", true);
                        	if (as[0] != undefined) {
                        		$('#btnMinus_' + t_sel).data('info').isTre = true;
                    		}   
                    		var t_where = "where=^^ tranno='"+ t_tranno +"' ^^";
            				q_gt('view_trds', t_where, 0, 0, 0, "checkBbs_trds_"+t_accy+"_"+t_tranno+"_"+t_sel, t_accy);             		
                    	}else if(t_name.substring(0,15)=="checkBbs_carsal"){
                    		var t_accy = t_name.split('_')[2];
                    		var t_tranno = t_name.split('_')[3];
                    		var t_sel = parseFloat(t_name.split('_')[4]);
                    		var as = _q_appendData("carsal", "", true);
							if(as[0]!=undefined){
								if(as[0].lock=="true" || as[0].lock=="1")
									$('#btnMinus_' + t_sel).data('info').isTre = true;
								var t_where = "where=^^ tranno='"+ t_tranno +"' ^^";
            					q_gt('view_trds', t_where, 0, 0, 0, "checkBbs_trds_"+t_accy+"_"+t_tranno+"_"+t_sel, t_accy);             		
							}else{
								checkBbs(t_sel-1);
							}
                    	}else if(t_name.substring(0,8)=="btnDele1"){
                    		var t_tranno = t_name.split('_')[1];
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var as = _q_appendData("trans", "", true);
							if(as[0]!=undefined){															
								var t_where = "where=^^ noa+noq='"+ as[0].calctype +"' ^^";
								q_gt('calctype2', t_where, 0, 0, 0, "btnDele2_"+t_tranno+"_"+as[0].calctype+"_"+as[0].datea+"_"+t_sel, r_accy);             		
							}else{
								alert(r_accy+'年度查無出車單【'+t_tranno+'】禁止刪除。');
								return r_accy+'年度查無出車單【'+t_tranno+'】禁止刪除。';
							}
                    	}else if(t_name.substring(0,8)=="btnDele2"){
                    		var t_tranno = t_name.split('_')[1];
                    		var t_calctype = t_name.split('_')[2];
                    		var t_date = t_name.split('_')[3];
                    		var t_sel = parseFloat(t_name.split('_')[4]);
                    		var as = _q_appendData("calctypes", "", true);
                    		if(as[0]!=undefined){
                    			var t_isoutside = (as[0].isoutside == "false" || as[0].isoutside == "0" || as[0].isoutside == undefined ? false : true);
                    			if(t_isoutside){
									//外車    
									var t_where = "where=^^ tranno='"+ t_tranno +"' ^^";
									q_gt('view_tres', t_where, 0, 0, 0, "btnDele3_"+t_tranno+"_"+t_sel, r_accy);             		                				
                    			}else{
                    				//公司車
                    				var t_where = "where=^^ noa='"+ t_date.substring(0,6) +"' ^^";
									q_gt('carsal', t_where, 0, 0, 0, "btnDele4_"+t_tranno+"_"+t_date.substring(0,6)+"_"+t_sel, r_accy);  
                    			}
                    		}else{
                    			alert('資料異常，查計算類別【'+t_calctype+'】禁止刪除。');
								return '資料異常，查計算類別【'+t_calctype+'】禁止刪除。';
                    		}
                    	}else if(t_name.substring(0,8)=="btnDele3"){
                    		var t_tranno = t_name.split('_')[1];
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var as = _q_appendData("view_tres", "", true);
                    		if(as[0]!=undefined){
                    			alert('出車單【'+t_tranno+'】已立帳，付款立帳單號【'+as[0].noa+'】。');
								return '出車單【'+t_tranno+'】已立帳，付款立帳單號【'+as[0].noa+'】。';
                    		}else{
                    			var t_where = "where=^^ tranno='"+ t_tranno +"' ^^";
            					q_gt('view_trds', t_where, 0, 0, 0, "btnDele5_"+t_tranno+"_"+t_sel, r_accy);  
                    		}
                    	}else if(t_name.substring(0,8)=="btnDele4"){
                    		var t_tranno = t_name.split('_')[1];
                    		var t_mon = t_name.split('_')[2];
                    		var t_sel = parseFloat(t_name.split('_')[3]);
                    		var as = _q_appendData("carsal", "", true);
                    		if(as[0]!=undefined){
                    			if(as[0].lock == "true" || as[0].lock == "1"){
                    				alert('出車單【'+t_tranno+'】已立帳，【'+t_mon+'】司機薪資已鎖定。');
									return '出車單【'+t_tranno+'】已立帳，【'+t_mon+'】司機薪資已鎖定。';
                    			}
                			}       
                			var t_where = "where=^^ tranno='"+ t_tranno +"' ^^";
        					q_gt('view_trds', t_where, 0, 0, 0, "btnDele5_"+t_tranno+"_"+t_sel, r_accy); 
                    	}else if(t_name.substring(0,8)=="btnDele5"){
                    		var t_tranno = t_name.split('_')[1];
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var as = _q_appendData("view_trds", "", true);
                    		if(as[0]!=undefined){
                    			alert('出車單【'+t_tranno+'】已立帳，請款立帳單號【'+as[0].noa+'】。');
								return '出車單【'+t_tranno+'】已立帳，請款立帳單號【'+as[0].noa+'】。';
                    		}else{
                    			checkDele(t_sel-1);
                    		}
                    	}
                    	break;
                } 
            }
            function q_popPost(id) {
				switch(id) {
					case 'txtCustno':
						if ($("#txtCustno").val().length > 0) {
							var t_addrno = $('#txtCustno').val()+'-001';
							var t_where = "where=^^ noa='"+t_addrno+"' ^^";
	                		q_gt('addr', t_where, 0, 0, 0, "");
						}
						break;
					case 'txtCarno_':
						if(q_cur==1 || q_cur==2){
							if(q_float('txtOutprice_'+b_seq)==0)							
								$('#txtOutprice_'+b_seq).val($('#txtPrice').val());
						}
						break;
				}
			}
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var string =  xmlString.split(';');
                var n = 0;
                /*for (var i = 0; i < q_bbsCount; i++) {
                	n += $.trim($('#txtCarno_'+i).val()).length>0?1:0;
                }
                if(n != string.length && q_cur==2){
                	alert('stPost 出車單回傳錯誤!'+n+'_'+string.length +'_'+string);
                	Unlock(1);
                	return;
                }*/
                var t_noa = abbm[q_recno]['noa'];
				var b_seq = 0;
               	var i = 0;
				for (var j = 0; j < abbs.length; j++) {
					if(abbs[j]['noa'] == t_noa){
						abbs[j]['tranno'] = string[i];
						$('#txtTranno_'+i).val(string[i]);
						i++;
						b_seq++;
					}
				} 
				Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	for (var i = 0; i < q_bbsCount; i++) {
                	if($.trim($('#txtCarno_'+i).val()).length>0 && $('#cmbCalctype_'+i).val().length==0){
                		alert('請輸入計算類別。');
	                	Unlock(1);
	                	return;
                	}
                }
            	if ($('#txtTrandate').val().length==0 || !q_cd($('#txtTrandate').val())){
                	alert(q_getMsg('lblTrandate')+'錯誤。');
                	Unlock(1);
                	return;
                }
            	if($('#txtTrandate').val().substring(0,3)!=r_accy){
					alert('年度異常錯誤，請切換到【'+$('#txtTrandate').val().substring(0,3)+'】年度再作業。');
					Unlock(1);
            		return;
				}
            	for (var i = 0; i < q_bbsCount; i++) {
            		if($.trim($('#txtCarno_'+i).val()).length>0){
            			$('#txtCarno').val($.trim($('#txtCarno_'+i).val()));
            			break;
            		}
            	}
            	if ($('#txtCustno').val().length==0){
                	alert('請輸入'+q_getMsg('lblCust')+'。');
                	Unlock(1);
                	return;
                }
                if ($('#txtAddrno').val().length==0){
                	alert('請輸入'+q_getMsg('lblAddr')+'。');
                	Unlock(1);
                	return;
                }
                if ($('#txtUccno').val().length==0){
                	alert('請輸入'+q_getMsg('lblProduct')+'。');
                	Unlock(1);
                	return;
                }
                $('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val()))
                    alert(q_getMsg('lblMon')+'錯誤。');
				if(q_cur==1)
                	$('#txtWorker').val(r_name);
                else
                	$('#txtWorker2').val(r_name);
                sum();

                var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtTrandate').val()); /*!!!!!!!!!!*/
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_carcsa') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('carcsa_s.aspx', q_name + '_s', "550px", "95%", q_getMsg("popSeek"));
            }
            function bbsAssign() {
            	for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_'+j).text(j+1);	
                	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                		$('#btnMinus_' + j).data('info',{
                			isTrd : false,//判斷是否立帳
                			isTre : false,//判斷是否立帳
                			isoutside : null//判斷是否是外車
                		});
                		$('#btnMinus_' + j).click(function(e){
                			var n = parseFloat($(this).attr('id').replace('btnMinus_','')); 
                			//init
                			$(this).data('info').isTrd = false;
                			$(this).data('info').isTre = false;
                			$(this).data('info').isoutside = null;
                			refreshBbm();
                		});
                		
                		$('#cmbCalctype_'+j).change(function(e){
                			var n = parseInt($(this).attr('id').replace('cmbCalctype_',''));
                			var m = $(this)[0].selectedIndex;
                			$('#txtDiscount_' + n).val(carcsa.calctype[m].discount);
                			sum();
                		});
                		$('#txtMount_' + j).change(function(e){
                			sum();
                		});
                		$('#txtDiscount_' + j).change(function(e){
                			sum();
                		});
                		$('#txtOutprice_' + j).change(function(e){
                			sum();
                		});
                		$('#txtOutplus_' + j).change(function(e){
                			sum();
                		});
                		$('#txtOutminus_' + j).change(function(e){
                			sum();
                		});
                	}
                }     
                _bbsAssign();   
            }

            function btnIns() {
                curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                $('#combType').val('');
                if($('#txtTrandate').val().length==0)
               		$('#txtTrandate').val(q_date());
               	if(q_cur==1 || q_cur==2)
                	$('#combType').removeAttr('disabled');
                else
                	$('#combType').attr('disabled','disabled');
                $('#txtTrandate').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                 if (checkenda){
         		       alert('超過'+q_getPara('sys.modiday2')+'天'+'已關帳!!');
                		return;
	    		}
                Lock(1,{opacity:0});
                if(q_cur==1 || q_cur==2)
                	$('#combType').removeAttr('disabled');
                else
                	$('#combType').attr('disabled','disabled');
                
                _btnModi();
                sum();
            }
			
			function checkBbs(n){		
            	if(n<0){
            		refreshBbm();
            		Unlock(1);
                	$('#txtTrandate').focus();
            	}else{
            		if($('#btnMinus_'+n).data('info')==undefined){
            			$('#btnMinus_'+n).data('info',{
            				isTrd : false,
            				isTre : false,
            				isoutside : null
            			});
            		}
            		for(var i in carcsa.calctype){
	            		if(carcsa.calctype[i].noa == $('#cmbCalctype_'+n).val()){
	            			$('#btnMinus_'+n).data('info').isoutside = carcsa.calctype[i].isoutside;
	            		}
	        		}
            		$('#btnMinus_'+n).data('info').isTrd = false;
        			$('#btnMinus_'+n).data('info').isTre = false;
            		
            		var t_accy = $('#txtTrandate').val().substring(0,3);
            		var t_mon = $('#txtTrandate').val().substring(0,6);
            		var t_tranno = $.trim($('#txtTranno_'+n).val());
            		if(t_tranno.length>0){
            			if($('#btnMinus_' + n).data('info').isoutside){
                    		var t_where = "where=^^ tranno='"+ t_tranno +"' ^^";
        					q_gt('view_tres', t_where, 0, 0, 0, "checkBbs_tres_"+t_accy+"_"+t_tranno+"_"+n, t_accy);
                    	}else{
                    		var t_where = "where=^^ noa='"+t_mon+"' ^^";
                    		q_gt('carsal', t_where , 0, 0, 0, "checkBbs_carsal_"+t_accy+"_"+t_tranno+"_"+n,t_accy);	
                    	}
            		}else{
            			checkBbs(n-1);
            		}
            	}
			}
    			
            function btnPrint() {
                q_box('z_carcs.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['carno'] && !as['tranno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
            		return;
                var t_mount=0,t_weight=0,t_inmoney=0,t_outmoney=0,t_outprice;
                var t_price = q_float('txtPrice');
                for (var j = 0; j < q_bbsCount; j++) {
                	if(q_float('txtOutprice_'+j)==0 && $('#txtCarno_'+j).val().length>0)							
						$('#txtOutprice_'+j).val(FormatNumber(t_price));
					t_outprice = q_float('txtOutprice_'+j);
                	
                    $('#txtInmoney_'+j).val(FormatNumber((t_price.mul(q_float('txtMount_'+j))).round(0)));
                    $('#txtOutmoney_'+j).val(FormatNumber((t_outprice.mul(q_float('txtMount_'+j)).mul(q_float('txtDiscount_'+j))).round(0)));
                    
                    t_mount += q_float('txtMount_'+j);
                    t_weight += q_float('txtWeight_'+j);
                    t_inmoney += q_float('txtInmoney_'+j);
                    t_outmoney += q_float('txtOutmoney_'+j);
                }
                
                $('#txtMount').val(FormatNumber(t_mount));
                $('#txtWeight').val(FormatNumber(t_weight));
                $('#txtInmoney').val(FormatNumber(t_inmoney));
     
                $('#txtOutmoney').val(FormatNumber(t_outmoney));
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
                if(r_rank<=7)
            		q_gt('holiday', "where=^^ noa>='"+abbm[q_recno].trandate+"'^^" , 0, 0, 0, "", r_accy);//單據日期之後的假日
            	else
            		checkenda=false;
                if(q_cur==1 || q_cur==2)
                	$('#combType').removeAttr('disabled');
                else
                	$('#combType').attr('disabled','disabled');
            }
            function q_refreshf(){
            	if(q_cur==2){
            		checkBbs(q_bbsCount-1);
            	}
            }
            function refreshBbm(){
            	var x_trd = false;
            	var x_tre = false;
            	var x_isoutsideAndTre = false;
      			
            	for (var i = 0; i < q_bbsCount; i++) {
            		var isTrd = $('#btnMinus_' + i).data('info').isTrd;
            		var isTre = $('#btnMinus_' + i).data('info').isTre;
            		var isoutside = $('#btnMinus_' + i).data('info').isoutside;
            		x_trd = x_trd | isTrd;
            		x_tre = x_tre | isTre;
            		x_isoutsideAndTre = x_isoutsideAndTre | (isTre&isoutside);
	            	refreshBbs(i);
            	}
            	if(x_trd || x_tre){
            		$('#txtTrandate').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		
            	}else{
            		$('#txtTrandate').removeAttr('readonly').css('color','black').css('background','white');
            	}
            	if(x_trd){
            		$('#txtCustno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		$('#combType').attr('disabled','disabled');
            		$('#txtPrice').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		$('#txtComp').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		$('#txtAddrno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		$('#txtAddr').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            	}else{
            		$('#txtCustno').removeAttr('readonly').css('color','black').css('background','white');
            		$('#combType').removeAttr('disabled');
            		$('#txtPrice').removeAttr('readonly').css('color','black').css('background','white');
            		$('#txtComp').removeAttr('readonly').css('color','black').css('background','white');
            		$('#txtAddrno').removeAttr('readonly').css('color','black').css('background','white');
            		$('#txtAddr').removeAttr('readonly').css('color','black').css('background','white');
            	}
            	if(x_isoutsideAndTre){
            		$('#txtMon').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		$('#cmbInterval').attr('disabled','disabled');
            	}else{
            		$('#txtMon').removeAttr('readonly').css('color','black').css('background','white');
            		$('#cmbInterval').removeAttr('disabled');
            	}
            }
            function refreshBbs(n){
            	var isTrd = $('#btnMinus_' + n).data('info').isTrd;
            	var isTre = $('#btnMinus_' + n).data('info').isTre;
            	var isoutside = $('#btnMinus_' + n).data('info').isoutside;
            	
            	if(isTrd || isTre){
            		$('#btnMinus_' + n).attr('disabled','disabled');
            	}else{
            		$('#btnMinus_' + n).removeAttr('disabled');
            	}
            	if(isTrd){
            		$('#txtMount_' + n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            	}else{
            		$('#txtMount_' + n).removeAttr('readonly').css('color','black').css('background','white');
            	}
            	if(isTre){
            		$('#txtCarno_' + n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		$('#btnDriver_' + n).attr('disabled','disabled');
            		$('#txtDriverno_' + n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		$('#txtDriver_' + n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		$('#cmbCalctype_' + n).attr('disabled','disabled');
            		$('#txtDiscount_' + n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            		$('#txtOutprice_' + n).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
            	}else{
            		$('#txtCarno_' + n).removeAttr('readonly').css('color','black').css('background','white');
            		$('#btnDriver_' + n).removeAttr('disabled');
            		$('#txtDriverno_' + n).removeAttr('readonly').css('color','black').css('background','white');
            		$('#txtDriver_' + n).removeAttr('readonly').css('color','black').css('background','white');
            		$('#cmbCalctype_' + n).removeAttr('disabled');
            		$('#txtDiscount_' + n).removeAttr('readonly').css('color','black').css('background','white');
            		$('#txtOutprice_' + n).removeAttr('readonly').css('color','black').css('background','white');
            	}
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
			
			function q_delef(){
                return checkDele(q_bbsCount-1);
			}
			function checkDele(n){
            	if(n<0){	
            		q_delef2();
            	}else{
            		var t_tranno = $.trim($('#txtTranno_'+n).val());
            		if(t_tranno.length>0){
            			var t_where =" where=^^ noa='"+ t_tranno +"'^^";
               			q_gt('trans', t_where, 0, 0, 0, 'btnDele1_'+t_tranno+'_'+n,r_accy);
            		}else{
            			checkDele(n-1);
            		}
            	}
            }
            function btnDele() {
            	 if (checkenda){
         	       alert('超過'+q_getPara('sys.modiday2')+'天'+'已關帳!!');
            	    return;
	    		}
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
                overflow: hidden;
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
                width: 950px;
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
            .tbbm .trX{
                background-color: #FFEC8B;
            }
            .tbbm .trY{
                background-color: #DAA520;
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
                width: 100%;
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTrandate'> </a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewOrdeno'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCartype'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewMon'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewInterval'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewMount'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTimes'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewInmoney'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewOutmoney'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="trandate" style="text-align: center;">~trandate</td>
						<td id="ordeno" style="text-align: center;">~ordeno</td>
						<td id="cartype" style="text-align: center;">~cartype</td>
						<td id="mon" style="text-align: center;">~mon</td>
						<td id="interval=carcsa.interval" style="text-align: center;">~interval=carcsa.interval</td>
						<td id="nick" style="text-align: left;">~nick</td>
						<td id="mount" style="text-align: right;">~mount</td>
						<td id="times" style="text-align: right;">~times</td>
						<td id="inmoney,0,1" style="text-align: right;">~inmoney,0,1</td>
						<td id="carno" style="text-align: left;">~carno</td>
						<td id="outmoney,0,1" style="text-align: right;">~outmoney,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td><input id="txtCarno" type="text" style="display:none;"/> </td>
						<td> </td>
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
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td><input id="txtTrandate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblInterval" class="lbl"> </a></td>
						<td><select id="cmbInterval" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td colspan="2"><input id="txtOrdeno" type="text" class="txt c1"/></td>
						<td> </td>
						<td><span> </span><a id="lblType" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtType" type="text" style="float:left;width:95%;"/>
							<select id="combType" style="float:left;width:5%;"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCartype" class="lbl"> </a></td>
						<td><input id="txtCartype" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td>
							<input id="txtTypea" type="text" style="float:left; width:50%;"/>
							<select id="cmbTypea2" style="float:left; width:50%;"> </select>
						</td>
						<td><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="float:left; width:35%;"/>
							<input id="txtComp"  type="text" style="float:left; width:65%;"/>
							<input id="txtNick"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblAddr" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtAddrno"  type="text"  style="float:left; width:50%;"/>
							<input id="txtAddr"  type="text"  style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td colspan="4"> </td>
						<td><span> </span><a id="lblProduct" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtUccno"  type="text"  style="float:left; width:50%;"/>
							<input id="txtProduct"  type="text"  style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBtime" class="lbl"> </a></td>
						<td><input id="txtBtime"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblOntime" class="lbl"> </a></td>
						<td><select id="cmbOntime" class="txt c1"> </select></td>
						<td><span> </span><a id="lblEtime" class="lbl"> </a></td>
						<td><input id="txtEtime" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTimes" class="lbl"> </a></td>
						<td><input id="txtTimes" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblInmoney" class="lbl"> </a></td>
						<td><input id="txtInmoney"  type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOutmoney" class="lbl"> </a></td>
						<td><input id="txtOutmoney"  type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><input type="button" id="btnTran" value="出車單明細"/> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;"><a id='lblCarnos'> </a></td>
					<td align="center" style="width:200px;"><a id='lblDrivers'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCalctype'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeights'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMounts'> </a></td>
					<td align="center" style="width:80px;"><a id='lblIns'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDiscounts'> </a></td>
					<td align="center" style="width:80px;"><a id='lblOutprice'> </a></td>
					<td align="center" style="width:80px;"><a id='lblOuts'> </a></td>
					<td align="center" style="width:150px;"><a id='lblTranno'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*"  style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					
					<td>
						<input class="btn"  id="btnCarno.*" type="button" value='.' style="display: none; font-weight: bold;width:1%;float:left;" />
						<input  id="txtCarno.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input class="btn"  id="btnDriver.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtDriverno.*"  style="width:40%; float:left;"/>
						<input type="text" id="txtDriver.*"  style="width:40%; float:left;"/>
					</td>
					<td><select id="cmbCalctype.*" class="txt c1"> </select></td>
					<td><input  id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtInmoney.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtDiscount.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtOutprice.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtOutmoney.*" type="text" class="txt c1 num" /></td>
					<td><input  id="txtTranno.*" onclick="browTrans(this)" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
