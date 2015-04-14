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

			var q_name = "trans";
			var q_readonly = ['txtMiles','txtNoa'];
			var bbmNum = [['txtMount',10,3,1]];
			var bbmMask = [['txtDatea','999/99/99'],['txtTrandate','999/99/99'],['txtMon','999/99'],['txtMon2','999/99'],['txtLtime','99:99'],['txtAdd3','99:99'],['txtAdd4','99:99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
            //q_xchg = 1;
            brwCount2 = 10;
            //不能彈出瀏覽視窗
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,serial', 'txtCustno,txtComp,txtNick,txtSerial', 'cust_b.aspx']
			);
			function currentData() {
            }
            currentData.prototype = {
                data : [],
                /*新增時複製的欄位*/
                include : ['txtDatea', 'txtTrandate','txtMon','txtMon2','txtCarno','txtDriverno','txtDriver'
                	,'txtCustno','txtComp','txtNick','txtStraddrno','txtStraddr'
                	,'txtUccno','txtProduct','txtMount'
                	,'txtPo','txtCustorde','txtSalesno','txtSales'],
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
			function transData() {
            }
            transData.prototype = {
            	calctype : new Array(),
            	isInit : false, 
            	isTrd : null,
            	isTre : null,
            	isoutside : null,
            	init : function(){
            		Lock(1,{opacity:0});
            		q_gt('carteam', '', 0, 0, 0, 'transInit_1');
            	},
            	refresh : function(){
            		if(!this.isInit)
            			return;
            	},
            	calctypeChange : function(){
            		if(!this.isTre){
		        		this.priceChange_afterCalctypeChange();
            		}
            	},
            	priceChange_afterCalctypeChange : function(){
            		var t_addrno = $.trim($('#txtStraddrno').val());
					var t_date = $.trim($('#txtTrandate').val());
					q_gt('addrs', "where=^^ noa='"+t_addrno+"' and datea<='"+t_date+"' ^^", 0, 0, 0, 'getPrice2');
            	},
            	priceChange : function(){
            		var t_addrno = $.trim($('#txtStraddrno').val());
					var t_date = $.trim($('#txtTrandate').val());
					q_gt('addrs', "where=^^ noa='"+t_addrno+"' and datea<='"+t_date+"' ^^", 0, 0, 0, 'getPrice');
            	},
            	checkData : function(){
        			this.isTrd = false;
        			this.isTre = false;
        			this.isoutside = false;

        			$('#txtDatea').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			$('#txtTrandate').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			
        			$('#txtCustno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			$('#txtComp').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			$('#txtStraddrno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			$('#txtStraddr').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			$('#txtMount').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			$('#txtCarno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			$('#txtDriverno').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			$('#txtDriver').attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
        			if($('#txtOrdeno').val().length>0){
        				//轉來的一律不可改日期
        			}else{
        				var t_tranno = $.trim($('#txtNoa').val());
        				var t_trannoq = $.trim($('#txtNoq').val());
        				var t_datea = $.trim($('#txtDatea').val());
        				if(q_cur==2 && (t_tranno.length==0 || t_trannoq.length==0 || t_datea.length==0)){
        					alert('資料異常。 code:1');
        				}else{
        					//檢查是否已立帳
        					q_gt('view_trds', "where=^^ tranno='"+t_tranno+"' and trannoq='"+t_trannoq+"' ^^", 0, 0, 0, 'checkTrd_'+t_tranno+'_'+t_trannoq+'_'+t_datea,r_accy);
        				}
        			}
            	}
           };
            trans = new transData();
            	
			$(document).ready(function() {
				bbmKey = ['noa'];
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
				$("#lblDatea").text('資料時間');
				$("#lblTrandate").text('讀取時間');
				$("#lblSerial").text('統一編碼');
				$("#lblCust").text('公司名稱');
				$("#lblStraddr").text('地址');
				$("#lblInmount").text('件數');
				$("#lblPo").text('電話');
				$("#lblOrdeno").text('發送局');
				$("#lblWorker").text('聯絡人');
				$("#lblWorker2").text('宅配員');
				
				document.title='派遣作業';

				q_modiDay= q_getPara('sys.modiday2');  /// 若未指定， d4=  q_getPara('sys.modiday'); 
				$('#btnIns').val($('#btnIns').val() + "(F8)");
				$('#btnOk').val($('#btnOk').val() + "(F9)");
				q_mask(bbmMask);
				trans.init();
				 $('#txtSerial').change(function() {
                	$(this).val($.trim($(this).val()).toUpperCase());
                	if ($(this).val().length > 0 && checkId($(this).val())!=2){
                		Lock();
	            		alert(q_getMsg('lblSerial')+'錯誤。');
	            		Unlock();
	            	}
	            });	
				$("#txtStraddrno").focus(function() {
					var input = document.getElementById ("txtStraddrno");
		            if (typeof(input.selectionStart) != 'undefined' ) {	  
		                input.selectionStart =  $(input).val().replace(/^(\w+\u002D).*$/g,'$1').length;
		                input.selectionEnd = $(input).val().length;
		            }
				});
				//q_xchgForm();
			}

			function sum() {
				if(q_cur!=1 && q_cur!=2)
					return;
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'isTre':
						var as = _q_appendData("view_tres", "", true);
                        if (as[0] != undefined) {
                        	alert('已立帳，付款立帳單號【'+as[0].noa+'】');
                        	Unlock(1);
                        	return;
                        }
                    	_btnDele();
                    	Unlock(1);
                        
						break;
					case 'isCarsal':
						var as = _q_appendData("carsal", "", true);
                        if (as[0] != undefined) {
                        	if(as[0].lock=="true" || as[0].lock=="1"){
                        		alert('【'+as[0].noa+'】司機薪資已鎖定。');
	                        	Unlock(1);
	                        	return;
                        	}
                        }
                    	_btnDele();
                		Unlock(1);
						break;
					case 'isTrd':
						var as = _q_appendData("view_trds", "", true);
                        if (as[0] != undefined) {
                        	alert('已立帳，請款立帳單號【'+as[0].noa+'】');
                        	Unlock(1);
                        	return;
                        }else{
                        	var t_isoutside = false;
                        	if(t_isoutside)
                        		q_gt('view_tres', "where=^^ tranno='"+$('#txtNoa').val()+"' ^^", 0, 0, 0, 'isTre',r_accy);	
                        	else
                        		q_gt('carsal', "where=^^ noa='"+$('#txtDatea').val().substring(0,6)+"' ^^", 0, 0, 0, 'isCarsal',r_accy);	
                        }
						break;
					case 'btnDele':
                		var as = _q_appendData("trans", "", true);
                        if (as[0] != undefined) {
                        	if(as[0].ordeno.length>0){
                        		alert('轉來的單據禁止刪除。');
                        		Unlock(1);
                        		return;
                        	}
                        	q_gt('view_trds', "where=^^ tranno='"+$('#txtNoa').val()+"' and trannoq='"+$('#txtNoq').val()+"' ^^", 0, 0, 0, 'isTrd',r_accy);	
                        }else{
                        	alert('資料異常。');
                        }
                		break;                	
                	case 'btnModi':
                		var as = _q_appendData("trans", "", true);
                        if (as[0] != undefined) {
                        	if(as[0].ordeno.length>0){
                        		alert('轉來的單據禁止修改。');
                        		if(r_rank!=9){
                        			Unlock(1);
                        			return;
                        		}
                        	}
                        }
                        Unlock(1);
	                	Lock(1,{opacity:0});
						_btnModi();
						trans.refresh();
						trans.checkData();
						$('#txtDatea').focus();
                		break; 
                	case 'getPrice2':
						var t_price = 0;
						var t_price2 = 0;
						var t_price3 = 0;
						var as = _q_appendData("addrs", "", true);
						if(as[0]!=undefined){
							t_price = as[0].custprice;
						 	t_price2 = as[0].driverprice;
							t_price3 = as[0].driverprice2;
						}
						sum();
						break;
					case 'getPrice':
						var t_price = 0;
						var t_price2 = 0;
						var t_price3 = 0;
						var as = _q_appendData("addrs", "", true);
						if(as[0]!=undefined){
							t_price = as[0].custprice;
						 	t_price2 = as[0].driverprice;
							t_price3 = as[0].driverprice2;
						}
						sum();
						break;
					case 'transInit_1':
						var as = _q_appendData("carteam", "", true);
						if (as[0] != undefined) {
    						var t_item = "";
    						for ( i = 0; i < as.length; i++) {
    							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
    						}
						}
						q_gt('calctype2', '', 0, 0, 0, 'transInit_2');
						break;
					case 'transInit_2':
						var as = _q_appendData("calctypes", "", true);
						var t_item = "";
						if (as[0] != undefined) {
    						for ( i = 0; i < as.length; i++) {
    							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
    							trans.calctype.push({
    								noa : as[i].noa + as[i].noq,
    								typea : as[i].typea,
    								discount : as[i].discount,
    								discount2 : as[i].discount2,
    								isoutside : as[i].isoutside.length == 0 ? false : (as[i].isoutside == "false" || as[i].isoutside == "0" || as[i].isoutside == "undefined" ? false : true)
    							});
    						}
						}
						trans.isInit = true;
						trans.refresh();
						Unlock(1);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						if(t_name.substring(0,8)=='checkTrd'){
							var t_tranno = t_name.split('_')[1];
							var t_trannoq = t_name.split('_')[2];
							var t_datea = t_name.split('_')[3];
							var as = _q_appendData("view_trds", "", true);
							if(as[0]!=undefined){
								trans.isTrd = true;
							}else{
								$('#txtCustno').removeAttr('readonly').css('color','black').css('background','white');
			        			$('#txtComp').removeAttr('readonly').css('color','black').css('background','white');
			        			$('#txtStraddrno').removeAttr('readonly').css('color','black').css('background','white');
			        			$('#txtStraddr').removeAttr('readonly').css('color','black').css('background','white');
								$('#txtMount').removeAttr('readonly').css('color','black').css('background','white');
							}
							if(trans.isoutside){
								//外車
								q_gt('view_tres', "where=^^ tranno='"+t_tranno+"' ^^", 0, 0, 0, 'checkTre',r_accy);
							}else{
								//公司車
								q_gt('carsal', "where=^^ noa='"+t_datea.substring(0,6)+"' ^^", 0, 0, 0, 'checkCarsal',r_accy);
							}
						}else if(t_name.substring(0,8)=='checkTre'){
							var as = _q_appendData("view_tres", "", true);
							if(as[0]!=undefined){
								trans.isTre = true;
							}else{
								$('#txtCarno').removeAttr('readonly').css('color','black').css('background','white');
								$('#txtDriverno').removeAttr('readonly').css('color','black').css('background','white');
								$('#txtDriver').removeAttr('readonly').css('color','black').css('background','white');
							}
							if(!trans.isTrd && !trans.isTre){
								$('#txtDatea').removeAttr('readonly').css('color','black').css('background','white');
								$('#txtTrandate').removeAttr('readonly').css('color','black').css('background','white');
							}
							sum();
							Unlock(1);
						}else if(t_name.substring(0,11)=='checkCarsal'){
							var as = _q_appendData("carsal", "", true);
							if(as[0]!=undefined){
								if(as[0].lock=="true" || as[0].lock=="1")
									trans.isTre = true;
							}
							if(!trans.isTre){
								$('#txtCarno').removeAttr('readonly').css('color','black').css('background','white');
								$('#txtDriverno').removeAttr('readonly').css('color','black').css('background','white');
								$('#txtDriver').removeAttr('readonly').css('color','black').css('background','white');
							}
							if(!trans.isTrd && !trans.isTre){
								$('#txtDatea').removeAttr('readonly').css('color','black').css('background','white');
								$('#txtTrandate').removeAttr('readonly').css('color','black').css('background','white');
							}
							sum();
							Unlock(1);
						}
						break;
				}
			}
			function q_popPost(id) {
				switch(id) {
					/*case 'txtCarno':
						if(q_cur==1 || q_cur==2){
							$('#txtDriverno').focus();
						}
						break;*/
					case 'txtCustno':
						if(q_cur==1 || q_cur==2){
							if(!trans.isTrd){
								$('#txtCaseuseno').val($('#txtCustno').val());
								$('#txtCaseuse').val($('#txtComp').val());
								if ($("#txtCustno").val().length > 0) {
									$("#txtStraddrno").val($("#txtCustno").val()+'-');
									$("#txtStraddr").val("");
								}
							}
						}
						break;
					case 'txtStraddrno':
						if(!trans.isTrd){
							trans.priceChange();
						}
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('trans_s.aspx', q_name + '_s', "550px", "95%", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtNoq').val('001');
				$('#txtDatea').focus();
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtNamea').focus();
			}
			function btnPrint() {
				q_box('z_trans.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
			function btnOk() {
				Lock(1,{opacity:0});
				//日期檢查
				if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())){
					alert(q_getMsg('lblTrandate')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if ($('#txtSerial').val().length > 0 && checkId($('#txtSerial').val())!=2){
         			alert(q_getMsg('lblSerial')+'錯誤。');
         			Unlock();
         			return;
				}
				
				var t_days = 0;
                var t_date1 = $('#txtDatea').val();
                var t_date2 = $('#txtTrandate').val();
                t_date1 = new Date(dec(t_date1.substr(0, 3)) + 1911, dec(t_date1.substring(4, 6)) - 1, dec(t_date1.substring(7, 9)));
                t_date2 = new Date(dec(t_date2.substr(0, 3)) + 1911, dec(t_date2.substring(4, 6)) - 1, dec(t_date2.substring(7, 9)));
                t_days = Math.abs(t_date2 - t_date1) / (1000 * 60 * 60 * 24) + 1;
				if(t_days>60){
					alert(q_getMsg('lblDatea')+'、'+q_getMsg('lblTrandate')+'相隔天數不可多於60天。');
					Unlock(1);
            		return;
				}
				//---------------------------------------------------------------
				for(var i in trans.calctype){
        		}
        		sum();
				//---------------------------------------------------------------
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (q_cur ==1)
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);		
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				trans.refresh();
				/*t_color = ['darkred','darkblue'];
				var obj=$('#dview').find('tr');
				for(var i=1;i<obj.length;i++){
					objs = obj.eq(i).find('td');
					for(var j=0;j<objs.length;j++){
						objs.eq(j).css('color',t_color[i%t_color.length]);
					}
				}*/
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
			    return (Math.round(arg1 * m) + Math.round(arg2 * m)) / m
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
			    return parseFloat(((Math.round(arg1 * m) - Math.round(arg2 * m)) / m).toFixed(n));
			}
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
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 100%; 
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
				background-color: #FFEA00;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a> 資料時間 </a></td>
						<td align="center" style="width:80px; color:black;"><a> 讀取時間 </a></td>
						<td align="center" style="width:80px; color:black;"><a> 公司名稱 </a></td>
						<td align="center" style="width:120px; color:black;"><a> 地址 </a></td>
						<td align="center" style="width:60px; color:black;"><a> 件數</a></td>
						<td align="center" style="width:120px; color:black;"><a> 電話 </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="trandate" style="text-align: center;">~trandate</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="straddr" style="text-align: center;">~straddr</td>
						<td id="mount" style="text-align: right;">~mount</td>
						<td id="po" style="text-align: center;">~po</td>
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
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtDatea"  type="text" class="txt c1" style="float:left;width:60%;"/>
						    <input id="txtAdd3"   type="text" class="txt c1" style="float:left;width:40%;"/>
						<td><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtTrandate"  type="text" class="txt c1" style="float:left;width:60%;"/>
						    <input id="txtAdd4"   type="text" class="txt c1" style="float:left;width:40%;"/>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="float:left;width:30%;"/>
							<input id="txtComp"  type="text" style="float:left;width:70%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
							<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
							<td colspan="3"><input id="txtOrdeno"  type="text" class="txt c1"/></td>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>
							<input id="txtNoa"  type="text" class="txt c1"/>
							<input id="txtNoq"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount"  type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td><input id="txtPo"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblStraddr" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtStraddr"  type="text" style="float:left;width:100%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
