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
		    q_desc = 1
		    q_tables = 's';
		    var q_name = "payacc";
		    var q_readonly = ['txtNoa', 'txtWorker', 'txtAccno','txtSale','txtTotal','txtPaysale','txtUnpay','txtOpay','textOpay','txtWorker2'];
		    var q_readonlys = ['txtRc2no', 'txtUnpay', 'txtUnpayorg', 'txtAcc2', 'txtPart2','txtMemo2','txtCustno','txtComp2'];
		    var bbmNum = new Array(['txtSale', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1]);
		    var bbsNum = [['txtMoney', 10, 0, 1], ['txtChgs', 10, 0, 1], ['txtPaysale', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtUnpayorg', 10, 0, 1]];
		    var bbmMask = [];
		    var bbsMask = [];

		    q_sqlCount = 6;
		    brwCount = 6;
		    brwCount2 = 5;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'Noa';
		    aPop = new Array(
            ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
             ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_,txtMoney_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
             ['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'],
             ['txtUmmaccno_', '', 'payacc', 'noa,typea', 'txtUmmaccno_,txtTypea_', 'payacc_b.aspx'],
             ['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']);

		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();
		        q_gt(q_name, q_content, q_sqlCount, 1);
		    });
		    function main() {
		        mainForm(1);
		    }

		    var t_Saving;
		    function mainPost() {
		        q_getFormat();
		        bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
		        q_mask(bbmMask);
		        bbsMask = [['txtIndate', r_picd]];
		        q_gt('part', '', 0, 0, 0, "");
		        q_gt('ucc', "where=^^ CHARINDEX('代收',product)>0 and left(noa,1)='E' ^^", 0, 0, 0, "");
		        
		        q_cmbParse("cmbPayc2", q_getMsg('payc').split('&').join(),"s");
		 
		        $('#btnGqbPrint').click(function (e) {
		            var t_noa = '', t_max, t_min;
		            for (var i = 0; i < q_bbsCount; i++) {
		                t_noa = $.trim($('#txtCheckno_' + i).val())
		                if (t_noa.length > 0) {
		                    break;
		                }
		            }
		            q_box('z_gqbp.aspx' + "?;;;;" + r_accy + ";noa=" + t_noa, '', "900px", "600px", m_print);
		        });

		        $('#lblAccc').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substr(0,3)+ '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "92%", q_getMsg('btnAccc'), true);
		        });
		        
		        
		         $('#btnAuto').click(function (e) {
		         	t_Saving = true;
		        		/// 自動沖帳 
		               for (var i = 0; i < q_bbsCount; i++) {
		               		$('#txtPaysale_'+i).val(0);//歸零
		               		$('#txtUnpay_'+i).val($('#txtUnpayorg_'+i).val());//歸零
		               }
		               
		               var t_money = 0+q_float('txtUnopay');
		               for (var i = 0; i < q_bbsCount; i++) {
		               		if($('#txtAcc1_'+i).val().indexOf('1121') == 0 || $('#txtAcc1_'+i).val().indexOf('7149') == 0 || $('#txtAcc1_'+i).val().indexOf('7044') == 0)
		               			t_money -= q_float('txtMoney_' + i);
		               		else
		               			t_money += q_float('txtMoney_' + i);
		               			
		               			t_money+=q_float('txtChgs_' + i);
		               }
						
		               var t_unpay, t_pay=0;
		               for (var i = 0; i < q_bbsCount; i++) {
		               		if (q_float('txtUnpay_' + i) != 0) {
								t_unpay=q_float('txtUnpayorg_' + i)
		                        if (t_money >= t_unpay) {
		                            q_tr('txtPaysale_' + i, t_unpay);
		                            $('#txtUnpay_' + i).val(0);
		                            t_money = t_money - t_unpay;
		                        }
		                        else {
		                            q_tr('txtPaysale_' + i, t_money);
		                            q_tr('txtUnpay_' + i, t_unpay - t_money);
		                             t_money = 0;
		                        }
		                    }
		                }
		                if (t_money > 0)
		                    q_tr('txtOpay', t_money);
		                    
		                sum();
		                
		         });
		         
		         $('#btnLabpay').click(function (e) {
		         	if($('#cmbProductno').val()==''){
		         		alert('請先選擇'+q_getMsg('lblProduct')+'。');
		         		return;
					}
		         	var t_where = "where=^^ ";
		         	if($('#txtTggno').val().indexOf('-')>-1){
		         		var salesno=$('#txtTggno').val().substr($('#txtTggno').val().indexOf('-')+1,$('#txtTggno').val().length)
		         		t_where+="(b.salesno='"+salesno+"')"
		         	}else{
		         		t_where+="(b.sales='"+r_name+"')"
		         	}
		         	
		            t_where+=" and CHARINDEX('代收',a.product)>0  and b.datea>='102/05/01' and a.productno='"+$('#cmbProductno').val()+"'";
		            t_where+=" group by a.custno,a.noa,a.productno,a.memo,a.comp";
		            
		            q_gt('payacc_labpay', t_where, 0, 0, 0, "", r_accy);
		        });
		        
		        //20130506 自動沖帳和支票列印隱藏
		        $('#btnAuto').hide();
		        $('#btnGqbPrint').hide();
		        
		        //20130614 加入全選
		        $('#btnCheckall').click(function () {
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtCustno_' +i).val())){
		            		$('#chkIssel_' +i)[0].checked=true;
		            		$('#trSel_'+ i).addClass('chkIssel');//變色
		            	}
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
			
			function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtAcc1_':
		                sum();
		                $('#txtMoney_'+b_seq).focus();
		                break;
		    	}
		    }
			
		    function q_gtPost(t_name) {
		        switch (t_name) {
					case 'holiday':
	            		holiday = _q_appendData("holiday", "", true);
	            		endacheck($('#txtDatea').val(),q_getPara('sys.modiday'));//單據日期,幾天後關帳
	            	break;
		        	case 'payacc_labpay':
		        		//清除現有資料
		        		for (var i = 0; i < q_bbsCount; i++) {
		        			$('#btnMinus_'+i).click();
		        		}
		        		var as = _q_appendData("payaccs", "", true);
		        		if (as[0] == undefined){
		               		alert('無資料。');
		               		return;
		               	}
		               	for (var i = 0; i < as.length; i++) {
		                    if (as[i].total - as[i].paysale == 0) {
		                        as.splice(i, 1);
		                        i--;
		                    } else {
		                        as[i]._unpay = (as[i].total - as[i].paysale).toString();
		                        as[i].paysale = 0;
		                    }
						}
		               	
		               	q_gridAddRow(bbsHtm, 'tbbs', 'txtRc2no,txtPaysale,txtUnpay,txtUnpayorg,txtPart2,cmbPartno,txtPart,txtMemo2,txtCustno,txtComp2',
		               								 as.length, as, 'noa,paysale,_unpay,_unpay,part,partno,part,memo,custno,comp', '', '');
		               	sum();
		        	break;
		        	case 'part':
		                var as = _q_appendData("part", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
		                    }
		                    q_cmbParse("cmbPartno", t_item, 's');
		                    refresh(q_recno);  /// 第一次需要重新載入
		                }
		                break;
		            case 'ucc':
		                var as = _q_appendData("ucc", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].product;
		                    }
		                    q_cmbParse("cmbProductno", t_item);
		                    if (abbm[q_recno]) {
	                        	$("#cmbProductno").val(abbm[q_recno].productno);
	                        }
		                }
		                break;
		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();
		                break;
		        }
		    }

		    function q_stPost() {
		        if (!(q_cur == 1 || q_cur == 2))
		            return false;
		        abbm[q_recno]['accno'] = xmlString;
		        //$('#txtAccno').val(xmlString);
		    }

		    function sum() {
		        var t_money = 0, t_pay = 0,t_sale=0;
		        for (var j = 0; j < q_bbsCount; j++) {
		            if($('#txtAcc1_'+j).val().indexOf('1121') == 0 || $('#txtAcc1_'+j).val().indexOf('7149') == 0 || $('#txtAcc1_'+j).val().indexOf('7044') == 0)
		               	t_money -= q_float('txtMoney_' + j);
		            else
		               	t_money += q_float('txtMoney_' + j);
		            	t_money+=q_float('txtChgs_' + j);
		            t_sale += q_float('txtUnpayorg_' + j);
		            t_pay += q_float('txtPaysale_' + j);
		        }
		        //bbm付款金額(total)=bbs付款金額總額(money)
		        //bbm應付金額(sale)=bbs應付金額總額(Unpayorg)
				//bbm本次沖帳(paysale)=bbs沖帳金額(paysale)+bbm預付沖帳(unopay)
				//bbm未付金額(unpay)=bbm應付金額(sale)-bbm本次沖帳(paysale)
				//bbm預付(opay)=bbm應付金額(sale)-bbm本次沖帳(paysale)
				//bbm預付餘額=應付餘額+預付-預付沖帳
				
		        q_tr('txtSale', t_sale);
		        q_tr('txtTotal', t_money);
		        q_tr('txtPaysale', t_pay);
		        q_tr('txtUnpay', q_float('txtPaysale')-q_float('txtTotal'));
		    }

		    function btnOk() {
		    	for (var i = 0; i < q_bbsCount; i++) {
		            $('#txtPart_' + i).val($('#cmbPartno_' + i).find(":selected").text());
		        }
		        //為了查詢
            	var t_part = '',t_checkno = '';
            	for (var i = 0; i < q_bbsCount; i++) {
            		if(t_part.indexOf($.trim($('#txtPart2_'+i).val()))==-1)
            			t_part += (t_part.length>0?',':'') + $.trim($('#txtPart2_'+i).val());
            		if($.trim($('#txtCheckno_'+i).val()).length>0 && t_checkno.indexOf($.trim($('#txtCheckno_'+i).val()))==-1)
            			t_checkno += (t_checkno.length>0?',':'') + $.trim($('#txtCheckno_'+i).val());
            	}
            	$('#txtPart2').val(t_part);
            	$('#txtCheckno').val(t_checkno);
            	
		        var t_err = q_chkEmpField([['txtTggno', q_getMsg('lblTgg')],['txtDatea', q_getMsg('lblDatea')]]);  // 檢查空白 
		        if (t_err.length > 0) {
		            alert(t_err);
		            return;
		        }
		             
		        var t_money = 0, t_chgs = 0, t_paysale,t_mon='';
		        for (var i = 0; i < q_bbsCount; i++) {
		            t_money = q_float('txtMoney_' + i);
		            t_chgs = q_float('txtChgs_' + i);

                    if ($.trim($('#txtAcc1_' + i).val()).length == 0 && t_money + t_chgs > 0) {
		                    t_err = true;
		                    break;
		            }
		        }

				if (t_err) {
		            alert(m_empty + q_getMsg('lblAcc1') + q_trv(t_money + t_chgs));
		            return false;
		        }
				
		        sum();
		        
		        //1020625炳圳：付款金額!=本次沖帳不要存檔--會計傳票會有問題
		        if($('#txtPaysale').val()!=$('#txtTotal').val()){
		        	alert("『本次沖帳金額』 不等於 『付款金額』");
		        	return false;
		        }
		        
		        
		        if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }
		        
		        var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_payacc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;

		        q_box('payacc_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
		    }

		    function combPay_chg() {
		    }

		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		        	$('#lblNo_'+i).text(i+1);	
		            if ($('#btnMinus_' + i).hasClass('isAssign'))    /// 重要
		                continue;
					
					$('#cmbPayc2_' + i).change(function (e) {					
		                var n = $(this).attr("id").replace(/cmbPayc2_/g,'');
		                $("#txtPayc_"+n).val($(this).find(":selected").text());
		            });
		            
		            $('#txtMoney_' + i).change(function (e) {
		                sum();
		            });

		            $('#txtChgs_' + i).change(function (e) {
		                sum();
		            });

		            $('#txtAcc1_' + i).change(function () {
		                t_IdSeq = -1;
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;

		                var s1 = trim($(this).val());
		                if (s1.length > 4 && s1.indexOf('.') < 0)
		                    $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
		                if (s1.length == 4)
		                    $(this).val(s1 + '.');
		                sum();
		            });

		            $('#txtPaysale_' + i).change(function (e) {
		                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;
						
						if(q_float('txtPaysale_'+b_seq)>q_float('txtUnpayorg_'+b_seq))
		                {
		               		alert('請輸入正確沖帳金額!!');
		               		$('#txtPaysale_'+b_seq).val(0);
		               		$('#txtPaysale_'+b_seq).focus();
						}
						
		                var t_unpay = dec($('#txtUnpayorg_' + b_seq).val()) - dec($('#txtPaysale_' + b_seq).val());
		                q_tr('txtUnpay_' + b_seq, t_unpay);
		                sum();
		            });
		            
		            $('#chkIssel_' + i).click(function () {
	                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
	                    q_bodyId($(this).attr('id'));
	                    b_seq = t_IdSeq;
						 if($('#chkIssel_' +b_seq)[0].checked){	//判斷是否被選取
		                	$('#trSel_'+ b_seq).addClass('chkIssel');//變色
		                	$('#txtPaysale_'+ b_seq).val($('#txtUnpayorg_'+ b_seq).val());
		                }else{
		                	$('#trSel_'+b_seq).removeClass('chkIssel');//取消變色
		                	$('#txtPaysale_'+ b_seq).val(0);
		                }
		                sum();
	                });
		        }

		        _bbsAssign();
		    }

		    function btnIns() {
		        _btnIns();
		        $('#txtDatea').focus();
		        $('#txtNoa').val('AUTO');
		        $('#txtDatea').val(q_date());
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
		            return;
		        if (checkenda){
	                alert('已關帳!!');
	                return;
				}
		        _btnModi();
		    }

		    function btnPrint() {
		        q_box("z_payacc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy + "_" + r_cno, 'payacc', "95%", "95%", m_print);
		    }

		    function wrServer(key_value) {
		        var i;

		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);

		    }

		    function bbsSave(as) {
                if (!as['acc1'] && (!as['money'] || as['money'] == 0) && (!as['paysale'] || as['paysale'] == 0)) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
				as['productno'] = abbm2['productno'];
				
				
		        return true;
		    }


		    function refresh(recno) {
		        _refresh(recno);
		        if(r_rank<=8)
	            	q_gt('holiday', "where=^^ noa>='"+$('#txtDatea').val()+"'^^" , 0, 0, 0, "", r_accy);//單據日期之後的假日
	            else
	            	checkenda=false;
		        if(q_cur==1 || q_cur==2){
		        	$("#btnAuto").removeAttr("disabled");
		        }else{
		        	$("#btnAuto").attr("disabled","disabled");
		        }
		        
		        for (var i = 0; i < q_bbsCount; i++) {
		        	if($('#chkIssel_' +i)[0].checked){	//判斷是否被選取
		               	$('#trSel_'+ i).addClass('chkIssel');//變色
		            }else{
		            	$('#trSel_'+i).removeClass('chkIssel');//取消變色
					}
				}
		        
		    }

		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		         if(q_cur==1 || q_cur==2){
		        	$("#btnLabpay").removeAttr("disabled");
		        	$("#btnCheckall").removeAttr("disabled");
		        }else{
		        	$("#btnLabpay").attr("disabled","disabled");
		        	$("#btnCheckall").attr("disabled","disabled");
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
		    	
		    	if (checkenda){
	                alert('已關帳!!');
	                return;
				}
		        _btnDele();
		    }

		    function btnCancel() {
		        _btnCancel();
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 30%;
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
                width: 70%;
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
            .txt.c2 {
                width: 50%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 20%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
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
            input[type="text"], input[type="button"],select {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .tbbs tr.chkIssel { background:bisque;} 
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
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:30%"><a id='vewDatea'></a></td>
						<td align="center" style="width:30%"><a id='vewComp'></a></td>
						<td align="center" style="width:30%"><a id='vewTotal'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp'>~comp</td>
						<td id='total,0,1' style="text-align: right;">~total,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtCheckno" type="text" style="display:none;"/>
						</td>
						<td class="td3" ><span> </span><a id='lblDatea' class="lbl"></a></td>
						<td class="td4" >
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id='lblProduct' class="lbl"></a></td>
						<td class="td4" >
						<select id="cmbProductno" class="txt c1"> </select>
						</td>
					</tr>
					<tr class="tr2">
                        <td class="td1" ><span> </span><a id='lblTgg' class="lbl btn"></a></td>
						<td class="td2" colspan='3'>
                        <input id="txtTggno" type="text" class="txt c4"/>
                        <input id="txtComp"  type="text" class="txt c5" />
						</td>
						<td align="center">
						<input type="button" id="btnLabpay" style="width: 70%;" />
						<input type="button" id="btnAuto" style="width:80%;color:red;"/>
                    	<input type="button" id="btnGqbPrint" style="width:80%;"/>
						</td>
						<td align="center">
							<input type="button" id="btnCheckall" value="付款全選" />
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblSale' class="lbl"></a></td>
						<td class="td2">
						<input id="txtSale"  type="text" class="txt num c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblTotal' class="lbl"></a></td>
						<td class="td4">
						<input id="txtTotal" type="text" class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
						<td class="td6">
						<input id="txtAccno"  type="text" class="txt c1"/>
						</td>
					</tr>  
					<tr class="tr4">
						<td class="td5"><span> </span><a id='lblPaysale' class="lbl"></a></td>
						<td class="td6">
						<input id="txtPaysale"  type="text" class="txt num c1"/>
						</td>
						<td class="td7"><span> </span><a id='lblUnpay' class="lbl"></a></td>
						<td class="td8">
						<input id="txtUnpay"  type="text" class="txt num c1"/>
						</td>
                        <td class="td7"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td8">
							<input id="txtWorker"  type="text" class="txt c1"/>
							<input id="txtWorker2"  type="text" class="txt c1" style="display:none;"/>
						</td>
					</tr>  
					<tr class="tr5">
						<td class="td1"> <a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan='5' ><textarea id="txtMemo"  class="txt c1" style="height: 50px;" > </textarea></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" border="1"  cellpadding='2' cellspacing='1' class='tbbs' style="background:#cad3ff;">
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:1%;"><a id='lblSel'></a></td>
					<td align="center" style="width:1%;"><a id='lblNo'></a></td>
					<td align="center" style="width:5%;"><a id='lblCusts'></a></td>
					<td align="center" style="width:5%;"><a id='lblMemos'></a></td>
					<td align="center" style="width:3%;"><a id='lblPaysales'></a></td>
					<td align="center" style="width:8%;"><a id='lblAcc1'></a></td>
					<td align="center" style="width:8%;"><a id='lblMoney'></a></td>
					<td align="center" style="width:4%;"><a id='lblIndate'></a></td>
					<td align="center" style="width:8%;"><a id='lblCheckno'></a></td>
					<td align="center" style="width:5%;"><a id='lblBank'></a></td>
					<td align="center" style="width:3%;"><a id='lblChgsTran'></a></td>
					<!--<td align="center" style="width:3%;"><a id='lblUnpay_s'></a></td>-->
				</tr>
				<tr  id="trSel.*">
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td ><input id="chkIssel.*" type="checkbox"/></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input type="text" id="txtCustno.*" style="width:95%;"/>
                    <input type="text" id="txtComp2.*" style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtMemo2.*" style="width:95%;"/>
                    <input type="text" id="txtRc2no.*" style="width:95%;" />
                    <input type="hidden" id="txtProductno.*" style="width:95%;" />
					</td>
  					<td>
					<input type="hidden" id="txtPaysale.*" style="text-align:right;width:95%;"/>
					<input type="text" id="txtUnpayorg.*" style="text-align:right;width:95%;"/>
					</td>
					<td>
                        <input type="text" id="txtAcc1.*"  style="width:85%; float:left;"/>
                        <input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtAcc2.*"  style="width:85%; float:left;"/>
					</td>
					<td>
						<input type="text" id="txtMoney.*" style="text-align:right;width:95%;"/>
						<input type="text" id="txtMemo.*" style="width:95%;"/>
					</td>
					<td>
						<input type="text" id="txtPayc.*"  style="float:left;width:75%;" />
						<select id="cmbPayc2.*"  style="float:left;width:10%;"> </select>
						<input type="text" id="txtIndate.*" style="width:85%;" />
					</td>
					<td>
					<input type="text" id="txtCheckno.*"  style="width:95%;" />
					<input type="text" id="txtAccount.*"  style="width:95%;" />
					</td>
					<td>
						<input class="btn"  id="btnBankno.*" type="button" value='.' style=" font-weight: bold;width:5%;float:left;" />
                        <input type="text" id="txtBankno.*"  style="width:80%; float:left;"/>
                        <span style="display:block; width:5%;float:left;"> </span>
						<input type="text" id="txtBank.*"  style="width:80%; float:left;"/>
					</td>
					<td>
						<input type="text" id="txtChgs.*" style="text-align:right;width:95%;"/>
						<select id="cmbPartno.*"  style="float:left;width:95%;" > </select>
						<input type="text" id="txtPart.*" style="display:none;"/>
					</td>
					
					<td style="display:none;">
					<input type="text" id="txtUnpay.*"  style="width:95%; text-align: right;" />
					<input type="text" id="txtPart2.*"  style="float:left;width: 95%;"/>
					</td>
				</tr>
			</table>
		</div>

		<input id="q_sys" type="hidden" />
	</body>
</html>
