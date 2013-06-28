<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_desc=1;
			q_tables = 's';
            var q_name = "assignwork";
            var q_readonly = ['txtWorker','txtNoa','txtVccno','txtPaybno','txtAccno2','txtAccno','txtMoney','txtCost','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney',14, 0, 1],['txtCost',14, 0, 1]];
            var bbsNum = [['txtMoney',14, 0, 1],['txtCost',14, 0, 1],['txtRealcost',14, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2= 13;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick,conn,conntel', 'txtCustno,txtComp,txtCustnick,txtConn,txtConntel', 'cust_b.aspx'],
            ['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtComp_', 'tgg_b.aspx'],
            ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
            ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea,partno', 'txtSalesno2,txtSales2,cmbPartno2', 'sss_b.aspx'],
            ['txtProductno_', 'btnProductno_', 'assignproduct', 'noa,product', 'txtProductno_,txtProduct_', 'assignproduct_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
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
            	q_getFormat();
                bbmMask = [['txtOdate', r_picd], ['txtWdate', r_picd], ['txtPaydate', r_picd], ['txtEnddate', r_picd]];
            	q_mask(bbmMask);
            	bbsMask = [['txtSenddate', r_picd], ['txtApprdate', r_picd], ['txtRepdate', r_picd]];
            	q_cmbParse("cmbItem", ('').concat(new Array( '','所有權第一次登記','所有權移轉登記','抵押權登記','抵押權塗銷登記','抵押權內容變更登記','標示變更登記','書狀換(補)發登記')));
            	q_cmbParse("cmbReason", ('').concat(new Array( '@')));
            	q_gt('assignproject', '', 0, 0, 0, "");
            	//q_gt('assignproduct', '', 0, 0, 0, "");
            	
                q_gt('part', '', 0, 0, 0, "");
                 q_cmbParse("cmbKind", ('').concat(new Array( '工商','土地')));
                 
                 $('#cmbItem').change(function(e) {
                 	$('#cmbReason').text('');
                 	if($('#cmbItem').val()=='所有權第一次登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','第一次登記')));
                 	}else if($('#cmbItem').val()=='所有權移轉登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','買賣','贈與','繼承','分割繼承','拍賣','共有物分割')));
                 	}else if($('#cmbItem').val()=='抵押權登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','設定','法定','讓與')));
                 	}else if($('#cmbItem').val()=='抵押權塗銷登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','清償','拋棄','混同','判決塗銷')));
                 	}else if($('#cmbItem').val()=='抵押權內容變更登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','權利價值變更','權力內容等變更')));
                 	}else if($('#cmbItem').val()=='標示變更登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','分割','合併','地目變更')));
                 	}else if($('#cmbItem').val()=='書狀換(補)發登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','書狀換(補)發登記')));
                 	}
                 	$("#cmbReason").val(abbm[q_recno].reason);
				})
                 
                $('#lblProject').click(function(e) {
					q_box("assignproject.aspx", 'conttype', "90%", "600px", q_getMsg("popAssignproject"));
				});
                
            	$('#btnInput').click(function () {
            		if(emp($('#txtItemno').val())){
            			alert('請先輸入項目!!');
            		return;
            	}
		           	t_where = "where=^^ noa=(select noa from assignment where noa ='"+$('#txtItemno').val()+"') ^^"
		           	q_gt('assignment', t_where , 0, 0, 0, "", r_accy);
	        	});
             	$('#lblVccno').click(function() {
		     		t_where = "noa='" + $('#txtVccno').val() + "'";
            		q_box("vcctran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcc', "95%", "95%", q_getMsg('popVcctran'));
             	});
             	$('#lblPaybno').click(function() {
		     		t_where = "noa='" + $('#txtPaybno').val() + "'";
            		q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pay', "95%", "95%", q_getMsg('popPaytran'));
             	});
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
                $('#lblAccno2').click(function() {
                    q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
                
                $('#cmbKind').change(function() {
                	if ($('#cmbKind').find("option:selected").text().indexOf('工商')>-1){  
	            		$(".land").hide();
	            		$(".inco").show();
                	}
                	if ($('#cmbKind').find("option:selected").text().indexOf('土地')>-1){
                		$(".land").show();
                		$(".inco").hide();
                	}
                });
                
                $('#btnAssignpaper').click(function (e) {
		            q_box("assignpaper.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'assignpaper', "95%", "95%", q_getMsg("popAssignpaper"));
		        });
		       $('#btnCust').click(function() {
					q_box("custtran.aspx", 'cust', "95%", "95%", q_getMsg("popCust"));  
                });
            }
			function cmbpaybno(id){
					t_where = "noa='" + $('#txtPaybno' + id).val() + "'";
            		q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'payb', "95%", "650px", q_getMsg('popPayb'));
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
			
			var project='';
			var projectnumber=0;
            function q_gtPost(t_name) {
            	switch (t_name) {
            		case 'holiday':
	            		holiday = _q_appendData("holiday", "", true);
	            		endacheck($('#txtEndadate').val(),q_getPara('sys.modiday'));//單據日期,幾天後關帳
	            	break;
            		case 'assignproject':
                        var as = _q_appendData("assignproject", "", true);
	                    projectnumber=as.length;
	                    project+="<table style='width:100%;'>"
	            		for (var i = 0; i < as.length; i++) {
	            			if(i%4==0)
	            			project+="<tr style='height: 20px;'>";
	            			project+="<td><input id='checkProjectno"+i+"' type='checkbox' style='float: left;' value='"+as[i].noa+"' disabled='disabled'/><a class='lbl'  id='aprojectno"+i+"' style='float: left;'>"+as[i].namea+"</a></td>"
	            			if(i%4==3)
	            			project+="</tr>";
	            			//sssno+=as[i].noa+';';
	            		}
	            		project+="</table>"
	            		$('#xproject').append(project);
	            		
	            		//更新勾選
	            		var xprojectno = abbm[q_recno].project.split(',');
	            		for (var j = 0; j < projectnumber; j++) {
	            			for (var i = 0; i < xprojectno.length; i++) {
	            				if($('#checkProjectno'+j).val()==xprojectno[i]){
	            					$('#checkProjectno'+j)[0].checked=true;
	            					break;
	            				}else{
	            					$('#checkProjectno'+j)[0].checked=false;
	            				}
	            			}
	            		}
                        break;
            		case 'assignment':
	            	var as = _q_appendData("assignments", "", true);
	            	q_gridAddRow(bbsHtm, 'tbbs', 'txtTggno,txtComp,txtProduct,txtDays,txtMoney,txtCost,txtMemo', as.length, as, 'tggno,comp,product,days,money,cost,memo', '');
	            	sum();
            	break;
                	case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                            q_cmbParse("cmbPartno2", t_item);
                             if (abbm[q_recno] != undefined) {
	                        	$("#cmbPartno2").val(abbm[q_recno].partno2);
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
				var s2 = xmlString.split(';');
                abbm[q_recno]['accno'] = s2[0];
                abbm[q_recno]['vccno'] = s2[1];
                abbm[q_recno]['paybno'] = s2[2];
                abbm[q_recno]['payno'] = s2[3];
                $('#txtAccno').val(s2[0]);
                $('#txtVccno').val(s2[1]);
                $('#txtPaybno').val(s2[2]);
                $('#txtPayno').val(s2[3]);
            }
            
            function btnOk() {
            	var t_err = '';
            	if($.trim($('#txtNick').val()).length==0)
            		$('#txtNick').val($('#txtComp').val());
 				
 				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock();
                    return;
                }
                /*
 				if($('#txtPaydate').val().length==0 || !q_cd($('#txtPaydate').val())){
 					//預設次月5日,遇六日順延
 					var t_paydate = $('#txtDatea').val();
            		var t_year = parseFloat(t_paydate.substring(0,3))+1911;
            		var t_mon = parseFloat(t_paydate.substring(4,6))-1;
            		var t_day = 5;
            		if(t_mon == 11){
            			t_year += 1;
            			t_mon = 0;
            		}else{
            			t_mon += 1;
            		}         
            		switch((new Date(t_year,t_mon,t_day)).getDay()){
            			case 0:
            				t_day += 1;
            				break;
            			case 6:
            				t_day += 2;
            				break;
            		}
            		$('#txtPaydate').val((t_year-1911)+'/'+(t_mon+1)+'/'+t_day);
 				}
 				*/
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                if ($('#cmbKind').find("option:selected").text().indexOf('工商')>-1){
	                var projectno='';
	                var projectnamea='';
	                for (var i = 0; i < projectnumber; i++) {
	                	if($('#checkProjectno'+i)[0].checked){
	                		projectno+=","+$('#checkProjectno'+i).val();
	                		projectnamea+=","+$('#aprojectno'+i).text();
	                	}
	                }
	                projectno=projectno.substr(1,projectno.length);
	                projectnamea=projectnamea.substr(1,projectnamea.length);
	                
	                $('#txtProject').val(projectno);
	                $('#txtPronick').val(projectnamea);
                }else{
                	$('#txtPronick').val($('#cmbItem').val()+'('+$('#cmbReason').val()+')');
                }
                
                
                sum();
                if(q_cur==1)
	            	$('#txtWorker').val(r_name);
            	else
            		$('#txtWorker2').val(r_name);
            		
            	if($('#chkEnda')[0].checked && emp($('#txtEndadate').val()))
            		$('#txtEndadate').val(q_date());
            	if(!$('#chkEnda')[0].checked)
                	$('#txtEndadate').val('');
                	
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_assignwork') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('assignwork_s.aspx', q_name + '_s', "550px", "530px", q_getMsg("popSeek"));
            }
           
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtItemno').focus();
                $('#txtDatea').val(q_date());
                $('#txtOdate').val(q_date());
                $('#txtWdate').val(q_date());
                //下個月5日遇六日則順延<Begin>
                var t_year = q_date().substring(0,3);
                var t_mon = q_date().substring(4,6);
                var t_day = '05';
                if((dec(t_mon)+1) > 12){
                	t_year = dec(t_year)+1;
                	t_mon = '01';
                }else{
                	t_mon = (dec(t_mon)+1).toString();
                	t_mon = padL(t_mon,'0',2);
                }
                var DateNew = new Date((dec(t_year)+1911) + '/' + t_mon + '/' + t_day);
                if(DateNew.getDay() == 0){
                	t_day = padL((dec(t_day)+1),'0',2);
                }else if(DateNew.getDay() == 6){
                	t_day = padL((dec(t_day)+2),'0',2);
                }
                //下個月5日遇六日則順延<End> t_year,t_mon,t_day
                $('#txtPaydate').val(t_year + '/' + t_mon + '/' + t_day);
	            $('#txtSalesno').val(r_userno);
	            $('#txtSales').val(r_name);
	            
	            $('#cmbKind').change();
	            $('#cmbReason').val('');
               	$('#cmbItem').val('');
	            
	            //清除勾選
	            for (var j = 0; j < projectnumber; j++) {
	            	$('#checkProjectno'+j)[0].checked=false;
	            }
	            $('#chkEnda')[0].checked=false;
	            $('#chkIscombine')[0].checked=false;
            }
           
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                //102/06/14 結案三天後不能再修改與刪除
                if (checkenda){
                	alert('此委託案件已關帳!!');
                    return;
                }
                
                _btnModi();           
                $('#txtNoa').attr('readonly','readonly');
                $('#txtItemno').focus();
            }
            function btnPrint() {
            	q_box('z_assignwork.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
             
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtMoney_'+i).blur(function () {
			            	sum();
			       		});
			       		$('#txtCost_'+i).blur(function () {
			            	sum();
			       		});
			       		$('#chkIsprepay_'+i).change(function () {
			            	sum();
			       		});
			       		$('#txtRealcost_'+i).blur(function () {
			       			t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							$('#chkIsprepay_'+b_seq)[0].checked=true;
			            	sum();
			       		});
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
                if (!as['product']&&!as['comp']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                
                return true;
            }

            function sum() {
            	var t1 = 0,t_money = 0,t_cost=0;
            	for (var j = 0; j < q_bbsCount; j++) {
					t_money+=dec($('#txtMoney_'+j).val());
					if($('#chkIsprepay_'+j)[0].checked){
						if(dec($('#txtRealcost_'+j).val())!=0)
							t_cost+=dec($('#txtRealcost_'+j).val());
						else
							t_cost+=dec($('#txtCost_'+j).val());
					}
            	}  // j
				q_tr('txtMoney',t_money);
				q_tr('txtCost',t_cost);
            }
            
            function refresh(recno) {
                _refresh(recno);
                if(r_rank<=8 && $('#chkEnda')[0].checked)
	            	q_gt('holiday', "where=^^ noa>='"+$('#txtEndadate').val()+"'^^" , 0, 0, 0, "", r_accy);//單據日期之後的假日
	            else
	            	checkenda=false;
	            	
                //清除勾選
	            for (var j = 0; j < projectnumber; j++) {
	            	$('#checkProjectno'+j)[0].checked=false;
	            }
                
                if ($('#cmbKind').find("option:selected").text().indexOf('工商')>-1){
                		$(".inco").show();
	            		$(".land").hide();
	            	//更新勾選
	            	if(abbm[q_recno]){
		            	var xprojectno = abbm[q_recno].project.split(',');
		            		for (var j = 0; j < projectnumber; j++) {
		            			for (var i = 0; i < xprojectno.length; i++) {
		            				if($('#checkProjectno'+j).val()==xprojectno[i]){
		            					$('#checkProjectno'+j)[0].checked=true;
		            					break;
		            				}else{
			            				$('#checkProjectno'+j)[0].checked=false;
			            			}
		    	        		}
		        	    	}
	        	    	}
                }
                if ($('#cmbKind').find("option:selected").text().indexOf('土地')>-1){
                		$(".inco").hide();
                		$(".land").show();
                	$('#cmbReason').text('');
                 	if($('#cmbItem').val()=='所有權第一次登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','第一次登記')));
                 	}else if($('#cmbItem').val()=='所有權移轉登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','買賣','贈與','繼承','分割繼承','拍賣','共有物分割')));
                 	}else if($('#cmbItem').val()=='抵押權登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','設定','法定','讓與')));
                 	}else if($('#cmbItem').val()=='抵押權塗銷登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','清償','拋棄','混同','判決塗銷')));
                 	}else if($('#cmbItem').val()=='抵押權內容變更登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','權利價值變更','權力內容等變更')));
                 	}else if($('#cmbItem').val()=='標示變更登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','分割','合併','地目變更')));
                 	}else if($('#cmbItem').val()=='書狀換(補)發登記'){
                 		q_cmbParse("cmbReason", ('').concat(new Array('','書狀換(補)發登記')));
                 	}
                 	if(abbm[q_recno])
                 		$("#cmbReason").val(abbm[q_recno].reason);
                }
            }
            
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
				if (t_para) {
					for (var i = 0; i < projectnumber; i++) {
	                	$('#checkProjectno'+i).attr('disabled', 'disabled');
                	}
                } else {
                	for (var i = 0; i < projectnumber; i++) {
	                	$('#checkProjectno'+i).removeAttr('disabled');
                	}
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
            	//102/06/14 結案三天後不能再修改與刪除
                if (checkenda){
                	alert('此委託案件已關帳!!');
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
                width: 100%;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 20%;
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
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
                width: 100%;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
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
						<td align="center" style="width:5%; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="color:black;" width="40%"><a id='vewProject'> </a></td>
						<td align="center" style="color:black;" width="35%"><a id='vewCustnick'> </a></td>
						<td align="center" style="color:black;" width="20%"><a id='vewKind'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="pronick" style="text-align: center;">~pronick</td>
						<td id="custnick" style="text-align: center;">~custnick</td>
						<td id="kind" style="text-align: center;">~kind</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtDatea" class="txt c1"/>	</td>	
						<td class="td3"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtNoa" class="txt c1"/>
						<input type="text" id="txtProject" style="display: none;"/>	
						<input type="text" id="txtPronick" style="display: none;"/>	
						</td>
					</tr>
					<tr class="inco">
						<td class="td1"><span> </span><a id='lblProject' class="lbl btn"> </a></td>
						<td class="td2" colspan="4" id="xproject">	
						</td>	
					</tr>
					<tr class="land">
						<td class="td1"><span> </span><a id='lblItem' class="lbl"> </a></td>
						<td class="td2"><select id="cmbItem" class="txt c1"> </select></td>
						<td class="td3"><span> </span><a id='lblReason' class="lbl"> </a></td>
						<td class="td4"><select id="cmbReason" class="txt c1"> </select></td>
					</tr>
					<tr class="land">
						<td class="td1"><span> </span><a id='lblRightp' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtRightp" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblObligationp' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtObligationp" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
						<td class="td2"colspan="2">
							<input type="text" id="txtCustno" style="width: 30%;"/>
							<input type="text" id="txtComp" style="width: 70%;"/>
							<input id="txtCustnick"  type="text" style="display: none;"/>
						</td>
						<td class="td4"><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td class="td5"><select id="cmbKind" class="txt c1"> </select></td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtSalesno" type="text"  style="float:left; width:30%;"/>
							<input id="txtSales" type="text"  style="float:left; width:70%;"/>
						</td>
						<td> </td>
						<td><input id="btnCust" type="button"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSales2' class="lbl btn"> </a></td>
						<td colspan="2">
							<input type="text" id="txtSalesno2" style="float:left;width:30%;"/>
							<input type="text" id="txtSales2" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblPart2" class="lbl"> </a></td>
						<td>
							<select id="cmbPartno2" class="txt c1"> </select>
							<input id="txtPart2"  type="text" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblConn' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtConn" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblConntel' class="lbl"> </a></td>
						<td class="td4" colspan="2"><input type="text" id="txtConntel" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtOdate" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblWdate' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtWdate" class="txt c1"/>	</td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtEnddate" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtPaydate" class="txt c1"/>	</td>							
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtMoney" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblCost' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtCost" class="txt num c1"/></td>	
					</tr>
					<tr>
						<td class="td1"></td>
						<td class="td2">
							<input id="chkIscombine" type="checkbox" style="float: left;"/><a id="lblIscombine" class="lbl" style="float: left;"></a>
						</td>
						<td class="td3">
							<input id="chkEnda" type="checkbox" style="float: left;"/>
							<a id="lblEnda" class="lbl" style="float: left;"></a>
						</td>
						<td class="td4"><input id="btnAssignpaper" type="button" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblVccno' class="lbl btn"> </a></td>
						<td class="td2"><input type="text" id="txtVccno" class="txt c1"/></td>	
						<td class="td3"><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td class="td4"><input type="text" id="txtAccno" class="txt c1"/></td>	
					</tr>
					<tr>
			            <td class='td1'><span> </span><a id="lblPaybno" class="lbl btn"></a></td>
			            <td class='td2'><input id="txtPaybno"  type="text" class="txt c1" /></td>
			            <td class='td3'><span> </span><a id="lblAccno2" class="lbl btn"></a></td>
			            <td class='td4'><input id="txtAccno2"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtWorker" class="txt c1"/></td>	
						<td class="td3"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtWorker2" class="txt c1"/><input type="hidden" id="txtEndadate" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:2%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:15%;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:6%;"><a id='lblDays_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblCost_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblRealcost_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblIsprepay_s'> </a></td>
					<td align="center" style="width:20%;"><a id='lblTggno_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblSenddate_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblApprdate_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblRepdate_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtProductno.*"  style="width:30%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtProduct.*"  class="txt" style="width:50%;"/>
						<!--<select id="cmbProduct.*" class="txt c1" style="font-size: medium;"> </select>-->
					</td>
					<td><input id="txtDays.*" type="text" class="txt c1"/></td>
					<td><input id="txtMoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtCost.*" type="text" class="txt num c1"/></td>
					<td><input id="txtRealcost.*" type="text" class="txt num c1"/></td>
					<td align="center"><input id="chkIsprepay.*" type="checkbox"/></td>
					<td><input class="btn"  id="btnTggno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtTggno.*"  style="width:30%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtComp.*"  style="width:60%; float:left;"/>
					</td>
					<td><input id="txtSenddate.*" type="text" class="txt c1"/></td>
					<td><input id="txtApprdate.*" type="text" class="txt c1"/></td>
					<td><input id="txtRepdate.*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
