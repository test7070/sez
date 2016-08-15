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

			q_tables = 't';
			var q_name = "vcca";
			var q_readonly = ['txtMoney', 'txtTotal', 'txtChkno', 'txtTax', 'txtAccno', 'txtWorker', 'txtTrdno', 'txtVccno'];
			var q_readonlys = [];
			var q_readonlyt = ['txtVccaccy','txtVccno','txtVccnoq'];
			var bbmNum = [['txtMoney', 15, 0,1], ['txtTax', 15, 0,1], ['txtTotal', 15, 0,1]];
			var bbsNum = [['txtMount', 15, 3,1], ['txtGmount', 15, 4,1], ['txtEmount', 15, 4,1], ['txtPrice', 15, 3,1], ['txtTotal', 15, 0,1]];
			var bbtNum = [['txtMount', 15, 0, 1],['txtWeight', 15, 2, 1],['txtPrice', 15, 2, 1],['txtMoney', 15, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Noa';
			aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
			, ['txtAddress', '', 'view_road', 'memo,zipcode', '0txtAddress,txtZip', 'road_b.aspx']
			, ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,serial,zip_invo,addr_invo', 'txtCustno,txtComp,txtNick,txtSerial,txtZip,txtAddress', 'cust_b.aspx']
			, ['txtBuyerno', 'lblBuyer', 'cust', 'noa,comp,serial', '0txtBuyerno,txtBuyer,txtSerial,txtMemo', 'cust_b.aspx']
			, ['txtSerial', 'lblSerial', 'vccabuyer', 'serial,noa,buyer', '0txtSerial,txtBuyerno,txtBuyer', 'vccabuyer_b.aspx']
			, ['txtProductno_', 'btnProductno_', 'ucca', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucca_b.aspx']);
			q_xchg = 1;
			q_desc = 1;
			brwCount2 = 20;

			function currentData() {
			}
			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				//include : ['txtDatea', 'txtCno', 'txtAcomp', 'txtCustno', 'txtComp', 'txtNick', 'txtSerial', 'txtAddress', 'txtMon', 'txtNoa', 'txtBuyerno', 'txtBuyer'],
				include : ['txtDatea', 'txtCno', 'txtAcomp', 'txtMon', 'txtNoa'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in curData.include) {
							if (fbbm[i] == curData.include[j]) {
								isInclude = true;
								break;
							}
						}
						if (isInclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
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
				if (q_getPara('sys.project').toUpperCase()=='YC'){
					bbsNum = [['txtMount', 15, 3], ['txtGmount', 15, 4], ['txtEmount', 15, 4], ['txtPrice', 15, 4], ['txtTotal', 15, 0]];
				}
				if (q_getPara('sys.comp').substring(0,2)=='傑期'){
					bbsNum = [['txtMount', 15, 2, 1], ['txtGmount', 15, 2, 1], ['txtEmount', 15, 2, 1], ['txtPrice', 15, 4, 1], ['txtMoney', 15, 0, 1]];
				}
				
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
				q_mask(bbmMask);
				q_cmbParse("cmbTaxtype", q_getPara('vcca.taxtype'));
				
				if(q_getPara('sys.project').toUpperCase()=='VU')
					$('#chkAtax').show();
					
				$('#cmbTaxtype').focus(function() {
					var len = $("#cmbTaxtype").children().length > 0 ? $("#cmbTaxtype").children().length : 1;
					$("#cmbTaxtype").attr('size', len + "");
				}).blur(function() {
					$("#cmbTaxtype").attr('size', '1');
				}).change(function(e) {
					sum();
				}).click(function(e) {
					sum();
				});
				
				$('#txtNoa').change(function(e) {
					$('#txtNoa').val($('#txtNoa').val().toUpperCase());
					q_func('qtxt.query.checkdata', 'vcca.txt,checkdata,' +q_cur+';'+$('#txtNoa').val()+';'+$('#txtCno').val()+';'+$('#txtDatea').val());
				});
				$('#txtTax').change(function() {
					sum();
				});
				$('#chkAtax').change(function() {
					sum();
				});
				$('#txtMoney').change(function() {
					sum();
				});
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
				});
				$('#lblTrdno').click(function() {
					q_pop('txtTrdno', "trd.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtTrdno').val() + "';" + r_accy + '_' + r_cno, 'trd', 'noa', 'datea', "95%", "95%", q_getMsg('popTrd'), true);
				});
				$('#lblVccno').click(function() {
					t_vccno = $('#txtVccno').val();
					
					if(t_vccno.length>0){
						if (q_getPara('sys.project').toUpperCase()=='IT')
							q_pop('txtVccno', "vcc_it.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtVccno').val() + "';" + ($('#txtDatea').val().substring(0, 3)<'101'?r_accy:$('#txtDatea').val().substring(0, 3)) + '_' + r_cno, 'vcc', 'noa', 'datea', "95%", "95%", q_getMsg('popVcc'), true);
						else if (q_getPara('sys.comp').indexOf('裕承隆') > -1)
							q_pop('txtVccno', "vccst.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtVccno').val() + "';" + r_accy + '_' + r_cno, 'vcc', 'noa', 'datea', "95%", "95%", q_getMsg('popVcc'), true);
						else if (q_getPara('sys.project').toUpperCase()=='VU')
							q_pop('txtVccno', "vcc_vu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtVccno').val() + "';" + r_accy + '_' + r_cno, 'vcc', 'noa', 'datea', "95%", "95%", q_getMsg('popVcc'), true);
						else if (q_getPara('sys.project').toUpperCase()=='XY')
							q_pop('txtVccno', "vcc_xy.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'" + $('#txtVccno').val() + "')>0;" + r_accy + '_' + r_cno, 'vcc', 'noa', 'datea', "95%", "95%", q_getMsg('popVcc'), true);
						else
							q_pop('txtVccno', "vcc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtVccno').val() + "';" + r_accy + '_' + r_cno, 'vcc', 'noa', 'datea', "95%", "95%", q_getMsg('popVcc'), true);
					}else{
						if (q_getPara('sys.project').toUpperCase()=='XY'){
							return;
						}
						if(q_cur==1 || q_cur==2){
							t_vccano = $('#txtNoa').val();
							t_custno = $('#txtCustno').val();
							t_date = $('#txtDatea').val();
							t_where = "b.custno='"+t_custno+"' and (c.noa='"+t_vccano+"' or c.noa is null) ";
							if(q_getPara('sys.project').toUpperCase() == 'VU')
								t_where +="and b.datea>'2016/02/22' and (ISNULL(b.atax,0)=1 or isnull(b.tax,0)>0)";
							if(q_getPara('sys.project').toUpperCase() != 'VU')
								t_where +="and b.datea<='"+t_date+"'";
							q_box("vccavcc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({vccano:t_vccano,custno:t_custno}), "vccavcc", "95%", "95%", '');
						}else{
							var t_noa = '';
							for(var i=0;i<q_bbtCount;i++){
								if($('#txtVccno__'+i).val().length>0)
									t_noa += (t_noa.length>0?" or ":"")+"noa='"+$('#txtVccno__'+i).val()+"'";
							}
							if(t_noa.length>0)
								q_box("vccst.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+t_noa + ";" + r_accy, 'vcc', "95%", "95%", q_getMsg("popVcc"));
						}
					}
				});
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'vccavcc':
                        if (b_ret != null) {
                        	$("#dbbt").show();
                        	as = b_ret;
                        	for(var i=0;i<q_bbtCount;i++){
                        		$('#btnMinut__'+i).click();
                        	}
                    		q_gridAddRow(bbtHtm, 'tbbt', 'txtVccaccy,txtVccno,txtVccnoq,txtProduct,txtMount,txtWeight,txtPrice,txtMoney'
                        	, as.length, as, 'accy,noa,noq,product,mount,weight,price,total', '','');
                        }else{
                        	Unlock(1);
                        }
                        break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			function q_popPost(s1) {
                switch (s1) {
                    case 'txtCno':
                        q_func('qtxt.query.checkdata', 'vcca.txt,checkdata,' +q_cur+';'+$('#txtNoa').val()+';'+$('#txtCno').val()+';'+$('#txtDatea').val());
                        break;
                	case 'txtProductno_':
                		var n = b_seq;
                		t_productno = $('#txtProductno_'+n).val();
                		t_date = $('#txtDatea').val();
                		if(t_productno.length>0 && q_getPara('sys.project').toUpperCase()!='VU' && q_getPara('sys.project').toUpperCase()!='YC' && q_getPara('sys.project').toUpperCase()!='XY' && q_getPara('sys.project').toUpperCase()!='SB')
                			q_func('qtxt.query.vcca_mount_'+n, 'vcca.txt,vcca_mount,'+$('#txtNoa').val()+';'+$('#txtCno').val()+';'+t_date+';'+t_productno);
                		
                		break;
                    default:
                        break;
                }
            }
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.vcca_apv':
                		var as = _q_appendData("tmp0", "", true);
                        if (as[0] != undefined) {
                        	if(as[0].val == 1){
                        		q_func('qtxt.query.checkdata_btnOk', 'vcca.txt,checkdata,' +q_cur+';'+$('#txtNoa').val()+';'+$('#txtCno').val()+';'+$('#txtDatea').val());	
                        	}else{
                        		alert(as[0].msg);
                        		Unlock(1);
                				return;
                        	}
                        }
                		break;
					case 'qtxt.query.checkdata':
						var as = _q_appendData("tmp0", "", true, true);
                		if(as[0]!=undefined){
                			if(as[0].val!='1'){
                				alert(as[0].msg);
                				Unlock(1);
                				return;
                			}
                		}
                		break;
					case 'qtxt.query.checkdata_btnOk':
						var as = _q_appendData("tmp0", "", true, true);
                		if(as[0]!=undefined){
                			if(as[0].val!='1'){
                				alert(as[0].msg);
                				Unlock(1);
                				return;
                			}
                		}
                		//鉅昕
                		//發票開立金額 不可大於該客戶當月出貨金額
						//項目有預收款排除
						var isExist = false;
						for(var i=0;i<q_bbsCount;i++){
							if($('#txtProduct_0').val().indexOf('預收')>=0){
								isExist = true;
								break;
							}
						}
						if(q_getPara('sys.project').toUpperCase()=='FE' && !isExist){
							q_func('qtxt.query.checkMoney', 'vcca.txt,checkMoney,'+$('#txtNoa').val()+';'+$('#txtCustno').val()+';'+$('#txtMon').val());	
						}else{
							wrServer($('#txtNoa').val());
						}
						break;
					case 'qtxt.query.checkMoney':
						var as = _q_appendData("tmp0", "", true, true);
                		if(as[0]!=undefined){
            				var t_money = q_float('txtMoney');
            				var t_vcca = parseFloat(as[0].vcca);
                			var t_vcc = parseFloat(as[0].vcc);
                			
                			if(t_money+t_vcca > t_vcc){
                				alert('本張發票金額'+t_money+' + 其他發票金額 '+t_vcca+'大於出貨金額 '+t_vcc);
                				//Unlock(1);
                				//return;
                			}
                		}
                		wrServer($('#txtNoa').val());
						break;
					default:
						if(t_func.substring(0,22)=='qtxt.query.vcca_mount_'){
							//檢查發票產品庫存(只有警告)
							var n = t_func.replace(/qtxt\u002Equery\u002Evcca\u005Fmount\u005F([0-9]+)/,'$1');
							var t_productno = $('#txtProductno_'+n).val();
							var t_date = $('#txtDatea').val();
							//var n = t_func.replace(/qtxt\u002Equery\u002Evcca\u005Fmount\u005F([0-9]+)\u005F(.+)/,'$1');
							//var t_date = t_func.replace(/qtxt\u002Equery\u002Evcca\u005Fmount\u005F([0-9]+)\u005F(.+)\u005F(.+)/,'$2');
							//var t_productno = t_func.replace(/qtxt\u002Equery\u002Evcca\u005Fmount\u005F([0-9]+)\u005F(.+)\u005F(.+)/,'$3');
							var t_mount = 0;//庫存
							
							var as = _q_appendData("tmp0", "", true, true);
	                		if(as[0]!=undefined){
	                			try{
	                				t_mount = parseFloat(as[0].mount);
	                			}catch(e){}
	                		}
	                		var t_curmount = 0;//本張發票數量
	                		for(var i=0;i<q_bbsCount;i++){
	                			if($('#txtProductno_'+i).val()==t_productno)
	                				t_curmount = q_add(t_curmount,q_float('txtMount_'+i));
	                		}
	                		if(t_curmount>t_mount){
	                			alert('產品【'+t_productno+'】'+t_date+' 庫存：'+t_mount);
	                		}
						}
						break;
				}
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'getAcomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							$('#txtCno').val(as[0].noa);
							$('#txtAcomp').val(as[0].nick);
						}
						Unlock(1);
						$('#txtDatea').val(q_date());
						if(q_getPara('sys.project')=='fe'){
							//鉅昕發票找還沒開過的
							t_wehre = "where=^^['"+$('#txtCno').val()+"','"+$('#txtDatea').val()+"')^^";
							q_gt('getvccano', t_wehre, 0, 0, 0, 'getVccano', r_accy,true);
						}else{
							//發票號碼+1
							var t_noa = trim($('#txtNoa').val());
							var str = '00000000' + (parseInt(t_noa.substring(2, 10)) + 1);
							str = str.substring(str.length - 8, str.length);
							if (!isNaN(parseFloat(str)) && isFinite(str)) {
								t_noa = t_noa.substring(0, 2) + str;
								$('#txtNoa').val(t_noa);
							}
						}
						if(q_getPara('sys.project')=='pe'){					
							$('#txtCustno').focus();
						}else{
							$('#txtDatea').focus();
						}		
						break;
					case 'getVccano':
						var as = _q_appendData("getvccano", "", true);
						if (as[0] != undefined) {
							$('#txtNoa').val(as[0].invono);
						}
						break;
					case q_name:
						if (q_cur == 4)// 查詢
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				abbm[q_recno]['accno'] = xmlString.split(";")[0];
				abbm[q_recno]['chkno'] = xmlString.split(";")[1];
				$('#txtAccno').val(xmlString.split(";")[0]);
				$('#txtChkno').val(xmlString.split(";")[1]);
				Unlock(1);
			}

			function btnOk() {
				Lock(1, {
					opacity : 0
				});

				var t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtDatea', q_getMsg('lblDatea')], ['txtCno', q_getMsg('lblAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					Unlock(1);
					return;
				}
				
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				
				$('#txtNoa').val($.trim($('#txtNoa').val()));
				
				if ($('#txtNoa').val().length > 0 && !(/^[a-z,A-Z]{2}[0-9]{8}$/g).test($('#txtNoa').val())) {
					alert(q_getMsg('lblNoa') + '錯誤。');
					Unlock(1);
					return;
				}
				
				if ($.trim($('#txtMon').val()).length == 0)
					$('#txtMon').val($('#txtDatea').val().substring(0, r_lenm));
					
				$('#txtMon').val($.trim($('#txtMon').val()));
				
				if ((!(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val()) && r_lenm==6)
				|| (!(/^[0-9]{4}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val()) && r_lenm==7)
				) {
					alert(q_getMsg('lblMon') + '錯誤。');
					Unlock(1);
					return;
				}
				
				$('#txtWorker').val(r_name);
				
				sum();
				//檢查發票抬頭
				if(q_getPara('sys.project').toUpperCase()=='FE'){
					//鉅昕印發票是印 COMP 那格,而不是買受人
					q_func('qtxt.query.vcca_apv', 'vcca.txt,vcca_apv,'+r_userno+';vcca;' + $('#btnOk').data('guid')+';'+$('#txtNoa').val()+';'+$('#txtCustno').val()+';'+$('#txtComp').val()); 
				}else{
					q_func('qtxt.query.checkdata_btnOk', 'vcca.txt,checkdata,' +q_cur+';'+$('#txtNoa').val()+';'+$('#txtCno').val()+';'+$('#txtDatea').val());	
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('vcca_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
			}

			function bbsAssign() {/// 表身運算式
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#chkAprice_'+j).click(function(e){refreshBbs();});
						$('#txtMount_' + j).change(function() {
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							t_productno = $('#txtProductno_'+n).val();
	                		t_date = $('#txtDatea').val();
	                		if(t_productno.length>0 && q_getPara('sys.project').toUpperCase()!='VU'  && q_getPara('sys.project').toUpperCase()!='YC' && q_getPara('sys.project').toUpperCase()!='XY' && q_getPara('sys.project').toUpperCase()!='SB')
	                			q_func('qtxt.query.vcca_mount_'+n, 'vcca.txt,vcca_mount,'+$('#txtNoa').val()+';'+$('#txtCno').val()+';'+t_date+';'+t_productno);
							sum();
						});
						$('#txtPrice_' + j).change(function() {
							sum();
						});
						$('#txtMoney_' + j).change(function() {
							sum();
						});
					}
				}
				_bbsAssign();
				refreshBbs();
			}
			function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtVccno__'+i).bind('contextmenu',function(e) {
	                    	/*滑鼠右鍵*/
	                    	e.preventDefault();
	                    	var n = $(this).attr('id').replace('txtVccno__','');
	                    	var t_accy = $('#txtVccaccy__'+n).val();
	                    	var t_tablea = 'vccst';
	                    	if(t_tablea.length>0 && $(this).val().indexOf('TAX')==-1 && !($(this).val().indexOf('-')>-1 && $(this).val().indexOf('/')>-1)){//稅額和月結排除
	                    		//t_tablea = t_tablea + q_getPara('sys.project');
	                    		//q_box(t_tablea+".aspx?;;;noa='" + $(this).val() + "'", t_tablea, "95%", "95%", q_getMsg("pop"+t_tablea));	
	                    		q_box(t_tablea+".aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $(this).val() + "';" + t_accy, t_tablea, "95%", "95%", q_getMsg("pop"+t_tablea));
	                    	}
	                    });
	                    
	                    $('#btnMinut__' + i).click(function() {
							setTimeout(bbtsum,10);
						});
						
						$('#txtMount__'+i).focusout(function() {
							if(q_cur==1 || q_cur==2)
								bbtsum();
						});
						
						$('#txtWeight__'+i).focusout(function() {
							if(q_cur==1 || q_cur==2)
								bbtsum();
						});
						$('#txtMoney__'+i).focusout(function() {
							if(q_cur==1 || q_cur==2)
								bbtsum();
						});
                    }
                }
                _bbtAssign();
                bbtsum();
            }

			function btnIns() {
				if(q_getPara('sys.project')=='pe'){
					$('#txtMon').val('');
					$('#txtCustno').val('');
					$('#txtComp').val('');
					$('#txtZip').val('');
					$('#txtAddress').val('');
				}
				curData.copy();
				_btnIns();
				curData.paste();
				$('#btnOk').data('guid',guid());//送簽核用
				
				if (q_getPara('sys.project').toUpperCase()=='VU'){//1050118
					$('#txtCustno').val('');
					$('#txtComp').val('');
					$('#txtSerial').val('');
					$('#txtZip').val('');
					$('#txtAddress').val('');
					$('#txtBuyerno').val('');
					$('#txtBuyer').val('');
				}
				
				$('#txtNoa').data('key_buyer','');//檢查發票抬頭用
				
				$('#cmbTaxtype').val(1);
				Lock(1, {
					opacity : 0
				});
				q_gt('acomp', '', 0, 0, 0, 'getAcomp', r_accy);
			}
			var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
			})();

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#btnOk').data('guid',guid());//送簽核用
				$('#txtNoa').data('key_buyer','');//檢查發票抬頭用
				$('#txtDatea').focus();
				$('#txtNoa').attr('readonly', true).css('color', 'green').css('background-color', 'rgb(237,237,237)');
				//讓發票號碼不可修改
				sum();
			}

			function btnPrint() {
				if (q_getPara('sys.project').toUpperCase()=='DC') {
					q_box('z_vccadc.aspx?;;;' + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				}else if (q_getPara('sys.project').toUpperCase()=='IT') {
					q_box('z_vccap_it.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
				}else if (q_getPara('sys.project').toUpperCase()=='XY') {
					q_box('z_vccp_xy.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";"+ r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				}else if (q_getPara('sys.project') == 'sh') {
					q_box('z_vccap_sh.aspx' + "?;;;noa=" + trim($('#txtNoa').val())+";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				}else if (q_getPara('sys.project') == 'pk') {
					q_box('z_vccap_pk.aspx' + "?;;;noa=" + trim($('#txtNoa').val())+";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				}else if (q_getPara('sys.project') == 'fe') {
					q_box('z_vccap_fe.aspx' + "?;;;noa=" + trim($('#txtNoa').val())+";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				}else {
					q_box('z_vccap.aspx?;;;' + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
				}
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
				if (!as['productno'] && !as['product']) {//不存檔條件
					as[bbsKey[1]] = '';
					/// no2 為空，不存檔
					return;
				}
				q_nowf();
				as['cno'] = abbm2['cno'];
                as['datea'] = abbm2['datea'];
				
				return true;
			}
			function bbtSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
				if (!as['vccno']) {//不存檔條件
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			
			//105/07/18 XY 表身可以改 表頭只開放 統編和買受人
			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				if (q_getPara('sys.project').toUpperCase()=='XY') {
					sum_xy();
					return;
				}
				if (!emp($('#txtVccno').val()))	//103/03/07 出貨單轉來發票金額一律不改
					return;
					
				$('#txtTax').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				var t_mounts, t_prices, t_moneys=0, t_mount = 0, t_money = 0, t_taxrate=0.5, t_tax=0, t_total=0;
				//銷貨客戶
				$('#txtCustno').attr('readonly', false);
				$('#txtComp').attr('readonly', false);
				//統一編號
				$('#txtSerial').attr('readonly', false);
				//產品金額
				$('#txtMoney').attr('readonly', false);
				//帳款月份
				$('#txtMon').attr('readonly', false);
				//營業稅
				$('#txtTax').attr('readonly', false);
				//總計
				$('#txtTotal').attr('readonly', false);
				//買受人
				$('#txtBuyerno').attr('readonly', false);
				$('#txtBuyer').attr('readonly', false);
				for (var k = 0; k < q_bbsCount; k++) {
					$('#txtMount_'+k).attr('readonly', false);
				}
				
				for (var k = 0; k < q_bbsCount; k++) {
					if(!$('#chkAprice_'+k).prop('checked')){
						$('#txtMoney_'+k).val(round(q_mul(q_float('txtMount_'+k),q_float('txtPrice_'+k)),0));
					}
					t_moneys = q_float('txtMoney_' + k);
                    t_money = q_add(t_money,t_moneys);
				}

				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				switch ($('#cmbTaxtype').val()) {
					case '1':
						// 應稅
						if($('#chkAtax').prop('checked')){
							t_tax=round(q_float('txtTax'), 0);
							$('#txtTax').css('color', 'black').css('background', 'white').removeAttr('readonly');  
						}else
							t_tax = round(t_money * t_taxrate, 0);
						t_total = t_money + t_tax;
						break;
					case '2':
						//零稅率
						t_tax = 0;
						t_total = t_money + t_tax;
						break;
					case '3':
						// 內含
						t_tax = round(t_money / (1 + t_taxrate) * t_taxrate, 0);
						t_total = t_money;
						t_money = t_total - t_tax;
						break;
					case '4':
						// 免稅
						t_tax = 0;
						t_total = t_money + t_tax;
						break;
					case '5':
						// 自定
						$('#txtTax').css('color', 'black').css('background', 'white').removeAttr('readonly');  
						t_tax = round(q_float('txtTax'), 0);
						t_total = t_money + t_tax;
						if (q_getPara('sys.project').toUpperCase()=='IT') {
							$('#txtMoney').removeAttr('readonly');
							t_money = dec($('#txtMoney').val());
							$('#txtTax').removeAttr('readonly');
							t_tax = round(q_float('txtTax'), 0);
							t_total = t_money + t_tax;
						}
						break;
					case '6':
						// 作廢-清空資料
						t_money = 0, t_tax = 0, t_total = 0;
						//銷貨客戶
						$('#txtCustno').val('').attr('readonly', true);
						$('#txtComp').val('').attr('readonly', true);
						//統一編號
						$('#txtSerial').val('').attr('readonly', true);
						//產品金額
						$('#txtMoney').val(0).attr('readonly', true);
						//帳款月份
						$('#txtMon').val('').attr('readonly', true);
						//營業稅
						$('#txtTax').val(0).attr('readonly', true);
						//總計
						$('#txtTotal').val(0).attr('readonly', true);
						//買受人
						$('#txtBuyerno').val('').attr('readonly', true);
						$('#txtBuyer').val('').attr('readonly', true);
						for (var k = 0; k < q_bbsCount; k++) {
							$('#txtMount_'+k).val(0).attr('readonly', true);
							$('#txtMoney_'+k).val(0).attr('readonly', true);
						}
						break;
					default:
				}
				$('#txtMoney').val(round(t_money,0));
				$('#txtTax').val(round(t_tax,0));
				$('#txtTotal').val(round(t_total,0));
			}
			
			function sum_xy() {
				$('#txtTax').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
				var t_mounts, t_prices, t_moneys=0, t_mount = 0, t_money = 0, t_taxrate=0.5, t_tax=0, t_total=0;
				if (!emp($('#txtVccno').val())){
					//統一編號
					$('#txtSerial').attr('readonly', false);
					//買受人
					$('#txtBuyerno').attr('readonly', false);
					$('#txtBuyer').attr('readonly', false);
					$('#cmbTaxtype').attr('disabled','disabled');
					$('#txtNoa').attr('disabled','disabled');
					//銷貨客戶
					$('#txtCustno').attr('readonly', true);
					$('#txtComp').attr('readonly', true);
					$('#txtMon').attr('readonly', true);
					//$('#txtDatea').attr('readonly', true);
					$('#txtCno').attr('readonly', true);
					$('#txtAcomp').attr('readonly', true);
					$('#txtZip').attr('readonly', true);
					$('#txtAddress').attr('readonly', true);
					$('#txtMemo').attr('readonly', true);
				}else{
					if(q_cur!=1){
						$('#txtNoa').attr('disabled','disabled');
					}
					//統一編號
					$('#txtSerial').attr('readonly', false);
					//買受人
					$('#txtBuyerno').attr('readonly', false);
					$('#txtBuyer').attr('readonly', false);
					//銷貨客戶
					$('#txtCustno').attr('readonly', false);
					$('#txtComp').attr('readonly', false);
					$('#txtMon').attr('readonly', false);
					$('#txtDatea').attr('readonly', false);
					$('#txtCno').attr('readonly', false);
					$('#txtAcomp').attr('readonly', false);
					$('#txtZip').attr('readonly', false);
					$('#txtAddress').attr('readonly', false);
					$('#txtMemo').attr('readonly', false);
				}
				
				for (var k = 0; k < q_bbsCount; k++) {
					if(!$('#chkAprice_'+k).prop('checked')){
						$('#txtMoney_'+k).val(round(q_mul(q_float('txtMount_'+k),q_float('txtPrice_'+k)),0));
					}
					t_moneys = q_float('txtMoney_' + k);
                    t_money = q_add(t_money,t_moneys);
				}

				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				switch ($('#cmbTaxtype').val()) {
					case '1':
						// 應稅
						if($('#chkAtax').prop('checked')){
							t_tax=round(q_float('txtTax'), 0);
							$('#txtTax').css('color', 'black').css('background', 'white').removeAttr('readonly');  
						}else
							t_tax = round(t_money * t_taxrate, 0);
						t_total = t_money + t_tax;
						break;
					case '2':
						//零稅率
						t_tax = 0;
						t_total = t_money + t_tax;
						break;
					case '3':
						// 內含
						t_tax = round(t_money / (1 + t_taxrate) * t_taxrate, 0);
						t_total = t_money;
						t_money = t_total - t_tax;
						break;
					case '4':
						// 免稅
						t_tax = 0;
						t_total = t_money + t_tax;
						break;
					case '5':
						// 自定
						$('#txtTax').css('color', 'black').css('background', 'white').removeAttr('readonly');  
						t_tax = round(q_float('txtTax'), 0);
						t_total = t_money + t_tax;
						break;
					case '6':
						// 作廢-清空資料
						t_money = 0, t_tax = 0, t_total = 0;
						//銷貨客戶
						$('#txtCustno').val('').attr('readonly', true);
						$('#txtComp').val('').attr('readonly', true);
						//統一編號
						$('#txtSerial').val('').attr('readonly', true);
						//產品金額
						$('#txtMoney').val(0).attr('readonly', true);
						//帳款月份
						$('#txtMon').val('').attr('readonly', true);
						//營業稅
						$('#txtTax').val(0).attr('readonly', true);
						//總計
						$('#txtTotal').val(0).attr('readonly', true);
						//買受人
						$('#txtBuyerno').val('').attr('readonly', true);
						$('#txtBuyer').val('').attr('readonly', true);
						for (var k = 0; k < q_bbsCount; k++) {
							$('#txtMount_'+k).val(0).attr('readonly', true);
							$('#txtMoney_'+k).val(0).attr('readonly', true);
						}
						break;
					default:
				}
				$('#txtMoney').val(round(t_money,0));
				$('#txtTax').val(round(t_tax,0));
				$('#txtTotal').val(round(t_total,0));
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbs();
				t_count = 0;
				try{
					for(var i=0;i<q_bbtCount;i++)
						if($('#txtVccno__'+i).val().length>0)
							t_count ++;
				}catch(e){
					
				}
				
				if(t_count>0)
					$("#dbbt").show();
				else
					$("#dbbt").hide();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (!emp($('#txtVccno').val()) && q_getPara('sys.project').toUpperCase()!='XY'){
					$('#txtNoa').attr('disabled','disabled');
					$('#cmbTaxtype').attr('disabled','disabled');
					$('#btnPlus').attr('disabled','disabled');
					
					for (var i = 0; i < q_bbsCount; i++) {
						$('#btnMinus_'+i).attr('disabled','disabled');
						$('#txtProductno_'+i).attr('disabled','disabled');
						$('#btnProductno_'+i).attr('disabled','disabled');
						$('#txtProduct_'+i).attr('disabled','disabled');
						$('#txtUnit_'+i).attr('disabled','disabled');
						$('#txtMount_'+i).attr('disabled','disabled');
						$('#txtPrice_'+i).attr('disabled','disabled');
						$('#txtMoney_'+i).attr('disabled','disabled');
						$('#txtMemo_'+i).attr('disabled','disabled');
					}
				}
				refreshBbs();
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
			
			function refreshBbs() {
                //金額小計自訂
				for(var i=0;i<q_bbsCount;i++){
					$('#txtMoney_'+i).attr('readonly','readonly');
					if($('#chkAprice_'+i).prop('checked')){
						$('#txtMoney_'+i).css('color','black').css('background-color','white');
						if(q_cur==1 || q_cur==2)
							$('#txtMoney_'+i).removeAttr('readonly');
					}else{
						$('#txtMoney_'+i).css('color','green').css('background-color','rgb(237,237,237)');
					}
				}
            }
			
			function bbtsum() {
            	var tot_mount=0,tot_weight=0,tot_money=0;
                for (var i = 0; i < q_bbtCount; i++) {
	                tot_mount=q_add(tot_mount,dec($('#txtMount__'+i).val()));
	                tot_weight=q_add(tot_weight,dec($('#txtWeight__'+i).val()));
	                tot_money=q_add(tot_money,dec($('#txtMoney__'+i).val()));
				}
				if(tot_mount!=0)
					$('#lblTot_mount').text(FormatNumber(tot_mount));
				else
					$('#lblTot_mount').text('');
				if(tot_weight!=0)
					$('#lblTot_weight').text(FormatNumber(tot_weight));
				else
					$('#lblTot_weight').text('');
				if(tot_money!=0)
					$('#lblTot_money').text(FormatNumber(tot_money));
				else
					$('#lblTot_money').text('');
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

			function checkId(str) {
				if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
					var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
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
				} else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
					if (regex.test(str))
						return 3;
				} else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
					str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
					if (regex.test(str))
						return 4;
				}
				return 0;
				//錯誤
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 1000px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 100%;
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
                width: 100%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1200px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
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
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id='vewCust'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewBuyer'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTax'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTotal'> </a></td>
						<td align="center" style="width:200px; color:black;"><a id='vewMemo'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
                        <td id='nick' style="text-align: left;">~nick</td>
						<td id='buyer,4' style="text-align: left;">~buyer,4</td>
						<td id='money,0,1' style="text-align: right;">~money,0,1</td>
						<td id='tax,0,1' style="text-align: right;">~tax,0,1</td>
						<td id='total,0,1' style="text-align: right;">~total,0,1</td>
						<td id='memo' style="text-align: left;">~memo</td>
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
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCno" type="text" style="float:left; width:25%;">
							<input id="txtAcomp" type="text" style="float:left; width:75%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblChkno' class="lbl"> </a></td>
						<td><input id="txtChkno"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno" type="text" style="float:left; width:30%;">
							<input id="txtComp" type="text" style="float:left; width:70%;"/>
							<input id="txtNick" type="text"  style="display:none;"/>
						</td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddress' class="lbl"> </a></td>
						<td colspan="5">
							<input id="txtZip" type="text" style="float:left; width:10%;"/>
							<input id="txtAddress" type="text" style="float:left; width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
						<td><select id="cmbTaxtype" class="txt c1" > </select></td>
						<td><span> </span><a id='lblBuyer' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtBuyerno"  type="text"  style="float:left; width:30%;"/>
							<input id="txtBuyer" type="text"  style="float:left; width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td>
							<input id="txtTax"  type="text"  class="txt num c1" style="width: 90%;"/>
							<input id="chkAtax" type="checkbox" onchange='sum()' style="display: none;" />
						</td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan='5'><textarea id="txtMemo" rows="3" class="txt c1" style="height: 50px;" > </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblVccno' class="lbl btn"> </a></td>
						<td><input id="txtVccno"  type="text" class="txt c1"/></td>
					</tr>
					<tr style="display:none;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id='lblTrdno' class="lbl btn"> </a></td>
						<td><input id="txtTrdno"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:80px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct'> </a></td>
					<td align="center" style="width:20px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:70px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:70px;"><a id='lblPrice'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotals'> </a></td>
					<td align="center" style="width:80px;"><a id='lblAprice'>自訂金額</a></td>
					<td align="center" style="width:80px;display: none;" class="ordeno"><a id='lblOrdeno'> </a></td>
					<td align="center" style="width:180px;"><a id='lblMemos'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProductno.*" type="text" style="float:left;width: 80%;"/>
						<input id="btnProductno.*" type="button" value=".." style="float:left;width: 15%;"/>
					</td>
					<td><input id="txtProduct.*" type="text" style="float:left;width: 95%;"/></td>
					<td><input id="txtUnit.*" type="text" style="float:left;width: 95%;"/></td>
					<td><input id="txtMount.*" type="text" style="float:left;width: 95%; text-align: right;"/></td>
					<td><input id="txtPrice.*" type="text" style="float:left;width: 95%; text-align: right;"/></td>
					<td><input id="txtMoney.*" type="text" style="float:left;width: 95%; text-align: right;"/></td>
					<td><input id="chkAprice.*" type="checkbox"/></td>
					<td class="ordeno" style="display: none;"><input id="txtOrdeno.*" type="text" style="float:left;width: 95%;"/></td>
					<td><input id="txtMemo.*" type="text" style="float:left;width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="display:none;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:120px; text-align: center;">出貨單號</td>
						<td style="width:200px; text-align: center;">品名</td>
						<td style="width:100px; text-align: center;">數量<BR><a id='lblTot_mount'> </a></td>
						<td style="width:100px; text-align: center;">重量<BR><a id='lblTot_weight'> </a></td>
						<td style="width:100px; text-align: center;">單價</td>
						<td style="width:100px; text-align: center;">金額<BR><a id='lblTot_money'> </a></td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input class="txt" id="txtVccaccy..*" type="text" style="width:95%;display:none;"/>
							<input class="txt" id="txtVccno..*" type="text" style="width:75%;float:left;"/>
							<input class="txt" id="txtVccnoq..*" type="text" style="width:15%;float:left;"/>
						</td>
						<td>
							<input class="txt" id="txtProduct..*" type="text" style="width:95%;float:left;"/>
						</td>
						<td><input class="txt" id="txtMount..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtWeight..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtPrice..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtMoney..*" type="text" style="width:95%;text-align: right;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>