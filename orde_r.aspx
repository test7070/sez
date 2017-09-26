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
			var q_name = "orde";
			var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtSales', 'txtOrdbno', 'txtOrdcno','txtUmmno','txtCuft','txtCasemount','txtCuftnotv','txtAgent','txtGtime'];
			var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3', 'txtC1', 'txtNotv','txtPackway','txtSprice','txtBenifit','txtPayterms'
										,'txtSize','txtProfit','txtDime'];
			var bbmNum = [['txtTotal', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1],['txtFloata', 10, 5, 1], ['txtDeposit', 15, 0, 1],['txtCuft', 15, 2, 1], ['txtTotalus', 15, 2, 1]];//,['txtDate3', 2, 0, 1]
			var bbsNum = [['txtCuft', 15, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'odate';
			brwCount2 = 17;
			
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucx', 'noa,product,unit,spec,cost', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_,txtSprice_', 'ucx_b.aspx'],
				['txtSalesno', 'lblSales_r', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp_r', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtCustno', 'lblCust_r', 'cust', 'noa,nick,paytype,trantype,tel,fax,zip_comp,addr_fact,custno2,cust2', 'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr,txtCustno2,txtCust2', 'cust_b.aspx'],
				['txtCustno2', 'lblCust2', 'cust', 'noa,nick', 'txtCustno2,txtCust2', 'cust_b.aspx'],
				['ordb_txtTggno_', '', 'tgg', 'noa,comp', 'ordb_txtTggno_,ordb_txtTgg_', ''],
				['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
				['txtAgentno', 'lblAgent_r', 'cust', 'noa,nick','txtAgentno,txtAgent', 'cust_b.aspx'],
				['txtGdate', 'lblFactory_r', 'factory', 'noa,factory', 'txtGdate,txtGtime', 'factory_b.aspx'],
				['txtUcolor_','','adspec','noa,mon,memo,memo1,memo2','0txtUcolor_','adspec_b.aspx'],
				['txtScolor_','','adly','noa,mon,memo,memo1,memo2','0txtScolor_','adly_b.aspx'],
				['txtClass_','','adly','noa,mon,memo,memo1,memo2','0txtClass_','adly_b.aspx'],
				['txtClassa_','','adly','noa,mon,memo,memo1,memo2','0txtClassa_','adly_b.aspx'],
				['txtZinc_','','adly','noa,mon,memo,memo1,memo2','0txtZinc_','adly_b.aspx'],
				['txtSizea_','','adoth','noa,mon,memo,memo1,memo2','0txtSizea_','adoth_b.aspx'],
				['txtSource_','','adpro','noa,mon,memo,memo1,memo2','0txtSource_','adpro_b.aspx'],
				['txtHard_','','addime','noa,mon,memo,memo1,memo2','0txtHard_','addime_b.aspx']
				
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no2'];
				q_brwCount();
				if(q_content.length>0){
					q_content="where=^^ (stype='3' or stype='4') and "+replaceAll(q_content,"where=^^",'');
				}else{
					q_content="where=^^ (stype='3' or stype='4') ^^ "
				}
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
				$('#txtOdate').focus();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				if(q_cur==1||q_cur==2){
					var t1 = 0, t_unit, t_mount, t_weight = 0;
					for (var j = 0; j < q_bbsCount; j++) {
						t_unit = $('#txtUnit_' + j).val();
						//t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() == 'kg' ? $('#txtWeight_' + j).val() : $('#txtMount_' + j).val()); // 計價量
						t_mount = $('#txtMount_' + j).val();
						// 計價量
						//t_weight = t_weight + dec( $('#txtWeight_' + j).val()) ; // 重量合計
						$('#txtTotal_' + j).val(round(q_mul(dec($('#txtPrice_' + j).val()), dec(t_mount)), q_getPara('vcc.pricePrecision')));
	
						q_tr('txtNotv_' + j, q_sub(q_float('txtMount_' + j), q_float('txtC1' + j)));
						t1 = q_add(t1, dec($('#txtTotal_' + j).val()));
					}
					$('#txtMoney').val(round(t1, q_getPara('vcc.pricePrecision')));
					if (!emp($('#txtPrice').val()))
						$('#txtTranmoney').val(round(q_mul(t_weight, dec($('#txtPrice').val())), q_getPara('vcc.pricePrecision')));
					// $('#txtWeight').val(round(t_weight, 0));
					q_tr('txtTotal', q_add(t1, dec($('#txtTax').val())));
					//105/06/20 典盈的單價和金額全部都用外幣 故totalus不處理
					if(q_getPara('sys.project').toUpperCase()!='JO'){ 
						q_tr('txtTotalus', q_mul(q_float('txtMoney'), q_float('txtFloata')));
					}
					calTax();
					cufttotal();
				}
			}
			
			function cufttotal() {
				var t_cuft=0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_cuft=q_add(t_cuft,dec($('#txtCuft_'+j).val()));	
				}
				$('#txtCuft').val(t_cuft);
				
				var casemount=0;
				var casecuft=0;
				
				if($('#cmbCasetype').val()=="20'")
					casecuft=1172;
				if($('#cmbCasetype').val()=="40'")
					casecuft=2390;
				
				casemount=Math.ceil(q_div(t_cuft,casecuft));
				$('#txtCasemount').val(casemount);
				$('#txtCuftnotv').val(q_sub(q_mul(casemount,casecuft),t_cuft));
			}
			
			var t_imgshow=false;
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtOdate', r_picd],['txtDate1', r_picd],['txtDate2', r_picd],['txtDate4', r_picd]];
				q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd],['txtIndate', r_picd]];
				bbsNum = [['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 9, q_getPara('vcc.mountPrecision'), 1], ['txtTotal', 15, 0, 1]
				, ['txtBenifit', 15, 0, 1],['txtC1', 10, q_getPara('vcc.mountPrecision'), 1], ['txtNotv', 10, q_getPara('vcc.mountPrecision'), 1], ['txtSprice', 10, q_getPara('vcc.pricePrecision'), 1]
				,['txtCuft', 10, q_getPara('vcc.weightPrecision'), 1],['txtRadius', 12, q_getPara('vcc.pricePrecision'), 1]];
				//q_cmbParse("cmbStype", q_getPara('orde.stype'));
				q_cmbParse("cmbStype", '3@外銷,4@樣品');
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("cmbPayterms", q_getPara('sys.payterms'));
				q_cmbParse("combPayterms", q_getPara('sys.payterms'));
				q_cmbParse("cmbCasetype", "20',40'" );
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                if(q_getPara('sys.project').toUpperCase()=='JO'){
					$('.totalus').hide();
				}
                
				var t_where = "where=^^ 1=0 ^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");

				$('#btnOrdei').click(function() {
					if (q_cur != 1)
						q_box("ordei.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';" + r_accy + ";" + q_cur, 'ordei', "95%", "95%", q_getMsg('popOrdei'));
				});
				$('#btnQuat').click(function() {
					btnQuat();
				});
				$('#txtFloata').change(function() {
					sum();
				});
				$('#txtTotal').change(function() {
					sum();
				});
				$('#txtAddr').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});
				$('#txtAddr2').change(function() {
					var t_custno = trim($(this).val());
					if (!emp(t_custno)) {
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}
				});

				$('#txtCustno').change(function() {
					if (!emp($('#txtCustno').val())) {
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});

				$('#btnCredit').click(function() {
					if (!emp($('#txtCustno').val())) {
						q_box("z_credit.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";custno='" + $('#txtCustno').val() + "';" + r_accy + ";" + q_cur, 'ordei', "95%", "95%", q_getMsg('btnCredit'));
					}
				});
				
				$('#txtGdate').change(function() {
					//106/07/24 暫時不使用
					/*for(var i=0;i<q_bbsCount;i++){
						getpdate(i);
					}*/
				});
				
				$('#cmbCasetype').change(function() {
					cufttotal();
				});
				
				$('#cmbPayterms').change(function() {
					for (var j = 0; j < q_bbsCount; j++) {
						if(!emp($('#txtProductno_'+j).val())){
							$('#txtPayterms_'+j).val($(this).val());
						}else{
							$('#txtPayterms_'+j).val('');
						}
					}
				});
				
				$('#btnImg').click(function() {
					if($('.isimg').is(':hidden')){
						$('.isimg').show();
						t_imgshow=true;
						imgshowhide();
						$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)+150)+"px");
					}else{
						$('.isimg').hide();
						t_imgshow=false;
						imgshowhide();
						$('#tbbs').css("width",(dec($('#tbbs')[0].offsetWidth)-150)+"px");
					}
				});
				
				$('#btnOrdc').click(function() {
					if(!emp($('#txtGdate').val())){
						var t_where = "where=^^ 1=1 ^^ stop=100";
						q_gt('factory', t_where, 0, 0, 0, "getfactory",r_accy,1);
						var as = _q_appendData("factory", "", true);
						if (as[0] != undefined) {
							if(as[0].tggno.length==0 || as[0].ip.length==0 || as[0].db.length==0){
								alert("【Factory】內容不完整!!");
								return;
							}
						}else{
							alert("【Factory】編號不存在!!");
							return;
						}
					}
					//產生採購單
					if(!emp($('#txtNoa').val())){
						if(confirm('確定要轉採購單?')){
							q_func('qtxt.query.orde2ordc_r', 'orde.txt,orde2ordc_r,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(q_date())+ ';' + encodeURI(r_name));
						}
					}
				});
				
				$('#txtUmmno').bind('contextmenu',function(e) {
						e.preventDefault();
						if(!emp($('#txtUmmno').val()))
							q_box("umm.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtUmmno').val() + "';" + r_accy + ";" + q_cur, 'umm', "95%", "95%", q_getMsg('popUmm'));
				});
				////-----------------以下為addr2控制事件---------------
				$('#btnAddr2').mousedown(function(e) {
					var t_post2 = $('#txtPost2').val().split(';');
					var t_addr2 = $('#txtAddr2').val().split(';');
					var maxline=0;//判斷最多有幾組地址
					t_post2.length>t_addr2.length?maxline=t_post2.length:maxline=t_addr2.length;
					maxline==0?maxline=1:maxline=maxline;
					var rowslength=document.getElementById("table_addr2").rows.length-1;
					for (var j = 1; j < rowslength; j++) {
						document.getElementById("table_addr2").deleteRow(1);
					}
					
					for (var i = 0; i < maxline; i++) {
						var tr = document.createElement("tr");
						tr.id = "bbs_"+i;
						tr.innerHTML = "<td id='addr2_tdBtn2_"+i+"'><input class='btn addr2' id='btnAddr_minus_"+i+"' type='button' value='-' style='width: 30px' onClick=minus_addr2("+i+") /></td>";
						tr.innerHTML+= "<td id='addr2_tdPost2_"+i+"'><input id='addr2_txtPost2_"+i+"' type='text' class='txt addr2' value='"+t_post2[i]+"' style='width: 70px'/></td>";
						tr.innerHTML+="<td id='addr2_tdAddr2_"+i+"'><input id='addr2_txtAddr2_"+i+"' type='text' class='txt c1 addr2' value='"+t_addr2[i]+"' /></td>";
						var tmp = document.getElementById("addr2_close");
						tmp.parentNode.insertBefore(tr,tmp);
					}
					readonly_addr2();
					$('#div_addr2').show();
				});
				$('#btnAddr_plus').click(function() {
					var rowslength=document.getElementById("table_addr2").rows.length-2;
					var tr = document.createElement("tr");
						tr.id = "bbs_"+rowslength;
						tr.innerHTML = "<td id='addr2_tdBtn2_"+rowslength+"'><input class='btn addr2' id='btnAddr_minus_"+rowslength+"' type='button' value='-' style='width: 30px' onClick=minus_addr2("+rowslength+") /></td>";
						tr.innerHTML+= "<td id='addr2_tdPost2_"+rowslength+"'><input id='addr2_txtPost2_"+rowslength+"' type='text' class='txt addr2' value='' style='width: 70px' /></td>";
						tr.innerHTML+="<td id='addr2_tdAddr2_"+rowslength+"'><input id='addr2_txtAddr2_"+rowslength+"' type='text' class='txt c1 addr2' value='' /></td>";
						var tmp = document.getElementById("addr2_close");
						tmp.parentNode.insertBefore(tr,tmp);
				});
				$('#btnClose_div_addr2').click(function() {
					if(q_cur==1||q_cur==2){
						var rows=document.getElementById("table_addr2").rows.length-3;
						var t_post2 = '';
						var t_addr2 = '';
						for (var i = 0; i <= rows; i++) {
							if(!emp($('#addr2_txtPost2_'+i).val())||!emp($('#addr2_txtAddr2_'+i).val())){
								t_post2 += $('#addr2_txtPost2_'+i).val()+';';
								t_addr2 += $('#addr2_txtAddr2_'+i).val()+';';
							}
						}
						$('#txtPost2').val(t_post2.substr(0,t_post2.length-1));
						$('#txtAddr2').val(t_addr2.substr(0,t_addr2.length-1));
					}
					$('#div_addr2').hide();
				});
				
				$('#btnOrdem').click(function() {
					q_box("ordem_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';" + r_accy + ";" + q_cur, 'ordem', "95%", "95%", q_getMsg('popOrdem'));
				});
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
				//div 事件
				$('#btnClose_div_getprice').click(function() {
					$('#div_getprice').hide();
				});
				
				$('#btnOk_div_getprice').click(function() {
					//回寫單價
					if(q_cur==1 || q_cur==2){
						$('#txtPrice_'+$('#textNoq').val()).val($('#textCost3').val());
						$('#txtSprice_'+$('#textNoq').val()).val($('#textCost').val());
						$('#txtWeight_'+$('#textNoq').val()).val($('#textWeight').val());
						$('#txtPackwayno_'+$('#textNoq').val()).val($('#textPackwayno').val());
						$('#txtPackway_'+$('#textNoq').val()).val($('#textPackway').val());
						$('#txtTotal_'+$('#textNoq').val()).val(round(q_mul(dec($('#txtMount_'+$('#textNoq').val()).val()),dec($('#txtPrice_'+$('#textNoq').val()).val())),q_getPara('vcc.pricePrecision')));
						$('#txtPayterms_'+$('#textNoq').val()).val($('#combPayterms').val());
						
						$('#txtProfit_'+$('#textNoq').val()).val($('#textProfit').val());
						$('#txtInsurance_'+$('#textNoq').val()).val($('#textInsurance').val());
						$('#txtCommission_'+$('#textNoq').val()).val($('#textCommission').val());
						
						sum();
						
						if(!emp($('#txtProductno_'+$('#textNoq').val()).val()) && !emp($('#txtPackwayno_'+$('#textNoq').val()).val())){
							var t_where="where=^^ noa='"+$('#txtProductno_'+$('#textNoq').val()).val()+"' and packway='"+$('#txtPackwayno_'+$('#textNoq').val()).val()+"' ^^";
		                	q_gt('pack2s', t_where, 0, 0, 0, "", r_accy,1);
		                	var as = _q_appendData("pack2s", "", true);
							if (as[0] != undefined) {
								var t_mount=dec($('#txtMount_'+$('#textNoq').val()).val());
								var t_uweight=dec(as[0].uweight);
								var t_inmount=dec(as[0].inmount)==0?1:dec(as[0].inmount);
								var t_outmount=dec(as[0].outmount)==0?1:dec(as[0].outmount);
								var t_inweight=dec(as[0].inweight);
								var t_outweight=dec(as[0].outweight);
								var t_cuft=dec(as[0].cuft);
								t_nweight=q_mul(t_mount,t_uweight);
								var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
								var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
								var t_emount=q_sub(t_mount,q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
								$('#txtCuft_'+b_seq).val(q_mul(t_cuft,t_pcmount));
		                	}
		                	cufttotal();
	                	}
					}
					$('#div_getprice').hide();
				});
				
				$('#div_pack2').click(function() {
					t_where = "noa='" + $('#textProductno').val() + "'";
					q_box("pack2_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'divpack2', "95%", "95%", '包裝方式');
				});
				
				$('#textCost').change(function() {
					divtrantypechange();
					var cost2=dec($('#textCost2').val());
					var tranprice=dec($('#textTranprice').val());
					var profit=$('#textProfit').val();
					var insurance=$('#textInsurance').val();
					var commission=$('#textCommission').val();
					$('#textProfitmoney').val(round(q_mul(cost2,q_div(profit,100)),q_getPara('vcc.pricePrecision')));
					$('#textInsurmoney').val(round(q_mul(cost2,q_div(insurance,100)),q_getPara('vcc.pricePrecision')));
					$('#textCommimoney').val(round(q_mul(cost2,q_div(commission,100)),q_getPara('vcc.pricePrecision')));
					divpaytermschange();
				});
				
				$('[name="trantype"]').change(function() {
					divtrantypechange();
				});
				
				$('#textCyprice').change(function() {
					divtrantypechange();
				});
				
				$('#textCycbm').change(function() {
					divtrantypechange();
				});
				
				$('#textKgprice').change(function() {
					divtrantypechange();
				});
				
				$('#textCuftprice').change(function() {
					divtrantypechange();
				});
				
				$('#textTranprice').change(function() {
					var t_cost=dec($('#textCost').val());
					$('#textCost2').val(q_add(t_cost,q_add(dec($('#textFee').val()),dec($('#textTranprice').val()))));
					divpaytermschange();
				});
				
				$('#textFee').change(function() {
					var t_cost=dec($('#textCost').val());
					$('#textCost2').val(q_add(t_cost,q_add(dec($('#textFee').val()),dec($('#textTranprice').val()))));
					divpaytermschange();
				});
				
				$('#textProfit').change(function() {
					var profit=$('#textProfit').val();
					var cost2=dec($('#textCost2').val());
					$('#textProfitmoney').val(round(q_mul(cost2,q_div(profit,100)),q_getPara('vcc.pricePrecision')));
					divpaytermschange();
				});
				
				$('#textInsurance').change(function() {
					var insurance=$('#textInsurance').val();
					var cost2=dec($('#textCost2').val());
					$('#textInsurmoney').val(round(q_mul(cost2,q_div(insurance,100)),q_getPara('vcc.pricePrecision')));
					divpaytermschange();
				});
				
				$('#textCommission').change(function() {
					var commission=$('#textCommission').val();
					var cost2=dec($('#textCost2').val());
					$('#textCommimoney').val(round(q_mul(cost2,q_div(commission,100)),q_getPara('vcc.pricePrecision')));
					divpaytermschange();
				});
				
				$('#combPayterms').change(function() {
					if(!emp($('#txtCustno').val()) && !emp($('#txtProductno_'+$('#textNoq').val()).val()) && !emp($('#combPayterms').val())){
						var t_where = "where=^^ a.custno='"+$('#txtCustno').val()+"' and a.productno='"+$('#txtProductno_'+$('#textNoq').val()).val()+"' and a.payterms='"+$('#combPayterms').val()+"' and '"+$('#txtOdate').val()+"'>=a.bdate order by bdate desc,noa desc --^^";
						q_gt('custprices_uca', t_where, 0, 0, 0, "getcustprices", r_accy, 1);
						var as = _q_appendData("custprices", "", true);
						if (as[0] != undefined) {
							$('#textCommission').val(as[0].commission);
							$('#textInsurance').val(as[0].insurance);
							$('#textProfit').val(as[0].profit);
							$('#textCost').val(as[0].cost);
							$('#textTranprice').val(as[0].tranprice);
						}
					}
					divpaytermschange();
				});
				
				$('#textMount').change(function() {
					var t_weight=0;
					var t_mount=dec($('#textMount').val());
					var t_uweight=dec($('#textUweight').val());
					var t_inmount=dec($('#textInmount').val())==0?1:dec($('#textInmount').val());
					var t_outmount=dec($('#textOutmount').val())==0?1:dec($('#textOutmount').val());
					var t_inweight=dec($('#textInweight').val());
					var t_outweight=dec($('#textOutweight').val());
					var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
					var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
					var t_emount=q_sub(dec($('#textMount').val()),q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
					t_weight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
					t_weight=q_mul(t_pfmount,t_weight); //整箱毛重
					if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
						var tt_weight=q_mul(t_emount,t_uweight);
						tt_weight=q_add(tt_weight,t_outweight);
						tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
						t_weight=q_add(t_weight,tt_weight);
					}
					$('#textWeight').val(t_weight);
				});
				
				$('#textUweight').change(function() {
					var t_weight=0;
					var t_mount=dec($('#textMount').val());
					var t_uweight=dec($('#textUweight').val());
					var t_inmount=dec($('#textInmount').val())==0?1:dec($('#textInmount').val());
					var t_outmount=dec($('#textOutmount').val())==0?1:dec($('#textOutmount').val());
					var t_inweight=dec($('#textInweight').val());
					var t_outweight=dec($('#textOutweight').val());
					var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
					var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
					var t_emount=q_sub(dec($('#textMount').val()),q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
					t_weight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
					t_weight=q_mul(t_pfmount,t_weight); //整箱毛重
					if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
						var tt_weight=q_mul(t_emount,t_uweight);
						tt_weight=q_add(tt_weight,t_outweight);
						tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
						t_weight=q_add(t_weight,tt_weight);
					}
					$('#textWeight').val(t_weight);
				});
				
				//下一格
				SeekF=[];
				$("#table_getprice [type='text'] ").each(function() {
					SeekF.push($(this).attr('id'));
				});
						
				SeekF.push('btnOk_div_getprice');
				$("#table_getprice [type='text'] ").each(function() {
					$(this).bind('keydown', function(event) {
						keypress_bbm(event, $(this), SeekF, 'btnOk_div_getprice');
					});
				});
				
				$("#table_getprice .num").each(function() {
					$(this).keyup(function(e) {
						if(e.keyCode>=37 && e.keyCode<=40)
							return;
						var tmp=$(this).val();
						tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
						$(this).val(tmp);
					});
					
					$(this).focusin(function() {
						$(this).select();
					});
				});
				
				$('#btnClose_div_ucagroup').click(function() {
					ucagroupdivmove = false;
					$('#div_ucagroup').hide();
				});
				
				$('#btnClose_div_vccdate').click(function() {
					$('#div_vccdate').hide();
				});
				$('#btnVccdate').click(function(e) {
					var monhoilday=q_getPara('sys.saturday')=='1'?4:8;
					var monday=0;//當月天數
					var mongen=0,daygen=0;//當月產能
					var t_date='',t_mon='';//計算日期
					var factnotv=0;//排程量	
					
					/*if(!emp($('#txtOdate').val()) && !emp($('#txtDate3').val()) && !emp($('#txtGdate').val())){ //排產週
						var t_odate=new Date(dec($('#txtOdate').val().substr(0,r_len))
						,dec($('#txtOdate').val().substr(r_len+1,r_lenm-r_len-1))-1
						,dec($('#txtOdate').val().substr(r_lenm+1,r_lend-r_lenm-1)));
						
						var t_week=getISOYearWeek(t_odate);
						if(t_week>=52 && $('#txtOdate').val().substr(r_len+1,r_lenm-r_len-1)=='01'){
							t_week=1;
						}
						var tt_date; //當年第一週
						if(t_week<=dec($('#txtDate3').val())){ //正常排程
							tt_date=getYearFirstWeekDate(dec($('#txtOdate').val().substr(0,r_len)));
						}else{ //隔年
							tt_date=getYearFirstWeekDate(dec($('#txtOdate').val().substr(0,r_len))+1);
						}
						t_date=tt_date.getFullYear()+'/'+('00'+(tt_date.getMonth()+1).toString()).slice(-2)+'/'+('00'+(tt_date.getDate()).toString()).slice(-2);
						
						var t_day=(dec($('#txtDate3').val())-1)*7;
						if(t_day>0) 
							t_date=q_cdn(t_date,t_day);//當週第一天
							
						var t_where = "where=^^ mon='" + t_date.substr(0,r_lenm) + "' and factno='"+$('#txtGdate').val()+"' ^^";
						q_gt('supforecasts', t_where, 0, 0, 0, "",r_accy,1);
						var ass = _q_appendData("supforecasts", "", true);
						for ( i = 0; i < ass.length; i++) {
							mongen=q_add(mongen,dec(ass[i].mount)); //當月總產能
						}
						$('.mongen').text(mongen);
						
						if(mongen>0){ //當有產能才計算
							t_mon=t_date.substr(0,r_lenm);
							monday=dec(q_cdn(q_cdn(t_date.substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1).slice(-2));
							daygen=q_div(mongen,q_sub(monday,monhoilday));
							$('.daygen').text(round(daygen,0));
							//取排產週的量
							var t_where = "where=^^ a.enda!=1 and a.cancel!=1 and b.enda!=1 and b.cancel!=1 and a.gdate='"+$('#txtGdate').val()+"' and a.noa!='"+$('#txtNoa').val()
							+"' and isnull(b.mount,0)-isnull(c.c1,0)>0 and a.date3='"+$('#txtDate3').val()+"' group by a.gdate ^^";
							
							q_gt('orde_r_factnotv', t_where, 0, 0, 0, "",r_accy,1);
							var as = _q_appendData("view_orde", "", true);
							if (as[0] != undefined) {
								factnotv=dec(as[0].notv);
							}
							$('.date3orde').text(factnotv);
							//取得目前訂單的數量
							var t_bbsmount=0;
							for (var j = 0; j <= q_bbsCount; j++) {
								t_bbsmount=q_add(t_bbsmount,dec($('#txtMount_'+j).val()));
							}
							$('.ordemount').text(t_bbsmount);
							factnotv=q_add(factnotv,t_bbsmount);
							
							var t_mongen=mongen;
							var t_daygen=daygen;
							
							while(factnotv>0){
								
								if(t_date.substr(0,r_lenm) != t_mon){//取得新的產能
									t_mon=t_date.substr(0,r_lenm);
									var t_where = "where=^^ mon='" + t_mon + "' and factno='"+$('#txtGdate').val()+"' ^^";
									q_gt('supforecasts', t_where, 0, 0, 0, "",r_accy,1);
									var ast = _q_appendData("supforecasts", "", true);
									if (ast[0] != undefined) {
										mongen=0;
										for ( i = 0; i < ast.length; i++) {
											mongen=q_add(mongen,dec(ast[i].mount)); //當月總產能
										}
										monday=dec(q_cdn(q_cdn(t_date.substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1).slice(-2));
										daygen=q_div(mongen,q_sub(monday,monhoilday));
									}//如果沒有就沿用產能
								}
								
								if(t_mongen!=mongen){
									$('.mongen').text($('.mongen').text()+'>'+mongen);
									$('.daygen').text($('.daygen').text()+'>'+daygen);
									t_mongen=mongen;
									t_daygen=daygen;
								}
								
								factnotv=q_sub(factnotv,daygen);
								if(factnotv>0){
									t_date=q_cdn(t_date,1);
									
									var week='';
									if(t_date.length==10){
										week=new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2))-1,dec(t_date.substr(8,2))).getDay()
									}else{
										week=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay();
									}
									if(q_getPara('sys.saturday')!='1' && week==6)
										t_date=q_cdn(t_date,1);
									if(week==0)
										t_date=q_cdn(t_date,1);
								}
							}
							$('.vccdate').text(t_date);
							$('#table_vccdate .date3').show();
							$('#table_vccdate .odate').hide();
							$('#div_vccdate').css('top', e.pageY- $('#div_vccdate').height());
							$('#div_vccdate').css('left', e.pageX - $('#div_vccdate').width());
							$('#div_vccdate').show();
						}else{
							alert(t_date.substr(0,r_lenm)+'無產能預測，無法試算預交日!!')
						}
					}else */
					if(!emp($('#txtOdate').val()) && !emp($('#txtGdate').val())){
						var t_where = "where=^^ mon='" + q_cdn($('#txtOdate').val(),1).substr(0,r_lenm) + "' and factno='"+$('#txtGdate').val()+"' ^^";
						q_gt('supforecasts', t_where, 0, 0, 0, "",r_accy,1);
						var ass = _q_appendData("supforecasts", "", true);
						for ( i = 0; i < ass.length; i++) {
							mongen=q_add(mongen,dec(ass[i].mount)); //當月總產能
						}
						$('.mongen').text(mongen);
						//取得本月訂單量
						var t_where = "where=^^ a.cancel!=1 and b.cancel!=1 and a.gdate='"+$('#txtGdate').val()+"' and left(a.odate,"+r_lenm+")='"+$('#txtOdate').val().substr(0,r_lenm)+"' and isnull(b.mount,0)>0 group by a.gdate ^^";
						q_gt('orde_r_factnotv', t_where, 0, 0, 0, "",r_accy,1);
						var as = _q_appendData("view_orde", "", true);
						if (as[0] != undefined) {
							$('.monmount').text(as[0].mount);
						}
						
						if(mongen>0){ //當有產能才計算
							t_date=q_cdn($('#txtOdate').val(),1);
							t_mon=q_cdn($('#txtOdate').val(),1).substr(0,r_lenm);
							monday=dec(q_cdn(q_cdn(t_date.substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1).slice(-2));
							daygen=q_div(mongen,q_sub(monday,monhoilday));
							$('.daygen').text(round(daygen,0));
							//取未完工量
							var t_where = "where=^^ a.enda!=1 and a.cancel!=1 and b.enda!=1 and b.cancel!=1 and a.gdate='"+$('#txtGdate').val()+"' and a.noa!='"+$('#txtNoa').val()+"' and isnull(b.mount,0)-isnull(c.c1,0)>0 group by a.gdate ^^";
							q_gt('orde_r_factnotv', t_where, 0, 0, 0, "",r_accy,1);
							var as = _q_appendData("view_orde", "", true);
							if (as[0] != undefined) {
								factnotv=dec(as[0].notv);
							}
							$('.factnotv').text(factnotv);
							//取得目前訂單的數量
							var t_bbsmount=0;
							for (var j = 0; j <= q_bbsCount; j++) {
								t_bbsmount=q_add(t_bbsmount,dec($('#txtMount_'+j).val()));
							}
							$('.ordemount').text(t_bbsmount);
							factnotv=q_add(factnotv,t_bbsmount);
							
							var t_mongen=mongen;
							var t_daygen=daygen;
							
							while(factnotv>0){
								
								if(t_date.substr(0,r_lenm) != t_mon){//取得新的產能
									t_mon=t_date.substr(0,r_lenm);
									var t_where = "where=^^ mon='" + t_mon + "' and factno='"+$('#txtGdate').val()+"' ^^";
									q_gt('supforecasts', t_where, 0, 0, 0, "",r_accy,1);
									var ast = _q_appendData("supforecasts", "", true);
									if (ast[0] != undefined) {
										mongen=0;
										for ( i = 0; i < ast.length; i++) {
											mongen=q_add(mongen,dec(ast[i].mount)); //當月總產能
										}
										monday=dec(q_cdn(q_cdn(t_date.substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1).slice(-2));
										daygen=q_div(mongen,q_sub(monday,monhoilday));
									}//如果沒有就沿用產能
								}
								
								if(t_mongen!=mongen){
									$('.mongen').text($('.mongen').text()+'>'+mongen);
									$('.daygen').text($('.daygen').text()+'>'+daygen);
									t_mongen=mongen;
									t_daygen=daygen;
								}
								
								factnotv=q_sub(factnotv,daygen);
								if(factnotv>0){
									t_date=q_cdn(t_date,1);
									
									var week='';
									if(t_date.length==10){
										week=new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2))-1,dec(t_date.substr(8,2))).getDay()
									}else{
										week=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay();
									}
									if(q_getPara('sys.saturday')!='1' && week==6)
										t_date=q_cdn(t_date,1);
									if(week==0)
										t_date=q_cdn(t_date,1);
								}
							}
							var t_week=getISOYearWeek(new Date(dec(t_date.substr(0,r_len))
							,dec(t_date.substr(r_len+1,r_lenm-r_len-1))-1
							,dec(t_date.substr(r_lenm+1,r_lend-r_lenm-1))));
							$('.vccdate').text(t_date+'    W'+t_week);
							$('#table_vccdate .date3').hide();
							$('#table_vccdate .odate').show();
							$('#div_vccdate').css('top', e.pageY- $('#div_vccdate').height());
							$('#div_vccdate').css('left', e.pageX - $('#div_vccdate').width());
							$('#div_vccdate').show();
						}else{
							alert(q_cdn($('#txtOdate').val(),1).substr(0,r_lenm)+'無產能預測，無法試算預交日!!')
						}
					}else{
						//alert('【訂單日期/排產週】和【Factory】禁止空白!!')
						alert('【訂單日期】和【Factory】禁止空白!!')
					}
				});
			}
			
			function divtrantypechange(){
				var t_cost=dec($('#textCost').val());
				if($('[name="trantype"]:checked').val()=='cy'){
					var cyprice=dec($('#textCyprice').val());
					var cycbm=dec($('#textCycbm').val());
					var cbm=dec($('#textCbm').val());
					var t_ctnmount=q_mul(dec($('#textInmount').val()),dec($('#textOutmount').val()));//一箱多少產品
					var t_cbmmount=cbm==0?0:q_mul(Math.ceil(q_div(cycbm,cbm)),t_ctnmount); //一櫃可裝多少產品
					var unitprice=t_cbmmount==0?0:round(q_div(cyprice,t_cbmmount),q_getPara('vcc.pricePrecision')); //平均一產品成本
					$('#textTranprice').val(unitprice);
				}else if ($('[name="trantype"]:checked').val()=='kg') {
					var kgprice=dec($('#textKgprice').val());
					$('#textMount').change();
					$('#textTranprice').val(q_mul(dec($('#textWeight').val()),kgprice));
				}else if ($('[name="trantype"]:checked').val()=='cuft') {
					var cuftprice=dec($('#textCuftprice').val());
					var cuft=$('#textCuft').val();
					var t_ctnmount=q_mul(dec($('#textInmount').val()),dec($('#textOutmount').val()));//一箱多少產品
					if(t_ctnmount==0)
						$('#textTranprice').val(0);
					else
						$('#textTranprice').val(round(q_div(q_mul(cuftprice,cuft),t_ctnmount),q_getPara('vcc.pricePrecision')));
				}
				$('#textCost2').val(q_add(t_cost,q_add(dec($('#textFee').val()),dec($('#textTranprice').val()))));
				divpaytermschange();
			}
			
			function divpaytermschange(){
				var cost=dec($('#textCost').val());				
				var tranprice=dec($('#textTranprice').val());
				var fee=dec($('#textFee').val());
				var profit=$('#textProfit').val();
				var insurance=$('#textInsurance').val();
				var commission=$('#textCommission').val();
				var payterms= $('#combPayterms').val();
				var cost3=0
				var precision=dec(q_getPara('vcc.pricePrecision'));
				switch (payterms) {//P利潤 I保險 C佣金 F運費
					case 'C＆F'://(成本/(1-P)+F) //=CFR   
						cost3=round(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),precision);
						break;
					case 'C＆F＆C'://(成本/(1-P)+F)/(1-C)
						cost3=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'C＆I': //成本/(1-P)/(1-I)
						cost3=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),precision);
						break;
					case 'C＆I＆C'://成本/(1-P)/(1-I)/(1-C)
						cost3=round(q_div(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'CIF'://(成本/(1-P)+F)/(1-I)   
						cost3=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),precision);
						break;
					case 'CIF＆C'://(成本/(1-P)+F)/(1-I)/(1-C)
						cost3=round(q_div(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'EXW'://成本/(1-P)
						cost3=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
					case 'FOB'://成本/(1-P)
						cost3=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
					case 'FOB＆C': //成本/(1-P)/(1-C)
						cost3=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'FCA'://成本/(1-P)
						cost3=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
				}
				$('#textCost3').val(cost3);
			}
			
			//addr2控制事件vvvvvv-------------------
			function minus_addr2(seq) {	
				$('#addr2_txtPost2_'+seq).val('');
				$('#addr2_txtAddr2_'+seq).val('');
			}
			
			function readonly_addr2() {
				if(q_cur==1||q_cur==2){
					$('.addr2').removeAttr('disabled');
				}else{
					$('.addr2').attr('disabled', 'disabled');
				}
			}
			
			//addr2控制事件^^^^^^--------------------
			
			function imgshowhide() {
				for(var i=0;i<q_bbsCount;i++){
					if(!$('.isimg').is(':hidden')){
						if(!emp($('#txtProductno_'+i).val())){
							var t_where = "where=^^ noa='" + $('#txtProductno_'+i).val() + "' ^^";
							q_gt('ucaucc', t_where, 0, 0, 0, "",r_accy,1);
							var as = _q_appendData("ucaucc", "", true);
							if (as[0] != undefined) {
								var imagename=as[0].images.split(';');
								if(imagename[0]!=''){
									imagename.sort();
									for (var j=0 ;j<imagename.length;j++){
										if(imagename[j]!=''){
											$('#images_'+i).attr('src', "../images/upload/"+replaceAll($('#txtProductno_'+i).val(),'/','CHR(47)')+'_'+imagename[j]+"?"+new Date());
											break;
										}
									}
								}
							}else{
								$('#images_'+i).removeAttr('src');
							}
						}else{
							$('#images_'+i).removeAttr('src');
						}
					}else{
						$('#images_'+i).removeAttr('src');
					}
				}
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'quats':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							$('#txtQuatno').val(b_ret[0].noa);
							//取得報價的第一筆匯率等資料
							var t_where = "where=^^ noa='" + b_ret[0].noa + "' ^^";
							q_gt('quat', t_where, 0, 0, 0, "", r_accy);

							var i, j = 0;
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtPrice,txtMount,txtQuatno,txtNo3', b_ret.length, b_ret, 'productno,product,spec,unit,price,mount,noa,no3', 'txtProductno,txtProduct,txtSpec');
							/// 最後 aEmpField 不可以有【數字欄位】
							sum();
							imgshowhide();
							bbsAssign();
						}
						break;
					case 'quars':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
							$('#txtQuatno').val(b_ret[0].noa);
							//取得報價的第一筆匯率等資料
							var t_where = "where=^^ noa='" + b_ret[0].noa + "' ^^";
							q_gt('quar', t_where, 0, 0, 0, "", r_accy);

							var i, j = 0;
							//1050506 quar 只有有一個交易條件
							/*for(var i=0;i<b_ret.length;i++){
								if(b_ret[i].chk2=="true"){
									b_ret[i].price=b_ret[i].price2;
									b_ret[i].commission=b_ret[i].commission2;
									b_ret[i].insurance=b_ret[i].insurance2;
									b_ret[i].payterms=b_ret[i].payterms2;
									b_ret[i].profit=b_ret[i].profit2;
								}
							}*/
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtPrice,txtMount,txtQuatno,txtNo3,txtPackwayno,txtPackway,txtSprice,txtProfit,txtCommission,txtInsurance,txtPayterms,txtBenifit,txtSize,txtRadius,txtDime,txtWidth,txtLengthb'
							, b_ret.length, b_ret, 'productno,product,spec,unit,price,mount,noa,no3,packwayno,packway,cost,profit,commission,insurance,payterms,benifit,payterms2,price2,profit2,commission2,insurance2', 'txtProductno,txtProduct,txtSpec');
							/// 最後 aEmpField 不可以有【數字欄位】
							
							//處理cuft
							for(var i=0;i<q_bbsCount;i++){
								if(!emp($('#txtProductno_'+i).val()) && !emp($('#txtPackwayno_'+i).val()) && dec($('#txtCuft_'+i).val())==0){
									var t_where="where=^^ noa='"+$('#txtProductno_'+i).val()+"' and packway='"+$('#txtPackwayno_'+i).val()+"' ^^";
		                			q_gt('pack2s', t_where, 0, 0, 0, "", r_accy,1);
		                			var as = _q_appendData("pack2s", "", true);
			                    	if (as[0] != undefined) {
			                    		var t_gweight=0; //毛重
			                    		var t_nweight=0; //淨重
										var t_mount=dec($('#txtMount_'+i).val());
										var t_uweight=dec(as[0].uweight);
										var t_inmount=dec(as[0].inmount)==0?1:dec(as[0].inmount);
										var t_outmount=dec(as[0].outmount)==0?1:dec(as[0].outmount);
										var t_inweight=dec(as[0].inweight);
										var t_outweight=dec(as[0].outweight);
										var t_cuft=dec(as[0].cuft);
										t_nweight=q_mul(t_mount,t_uweight);
										var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
										var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
										var t_emount=q_sub(t_mount,q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
										t_gweight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
										t_gweight=q_mul(t_pfmount,t_gweight); //整箱毛重
										if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
											var tt_weight=q_mul(t_emount,t_uweight);
											tt_weight=q_add(tt_weight,t_outweight);
											tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
											t_gweight=q_add(t_gweight,tt_weight);
										}
										//$('#txtWeight_'+i).val(t_nweight);
										//$('#txtGweight_'+i).val(t_gweight);
										$('#txtCuft_'+i).val(q_mul(t_cuft,t_pcmount));
		                			}
	                			}
							}
							
							sum();
							bbsAssign();
						}
						break;
					case 'pack2':
						ret = getb_ret();
						if (ret != undefined) {
							$('#txtPackwayno_'+b_seq).val(ret[0].packway);
							$('#txtPackway_'+b_seq).val(ret[0].pack);
						}
						if(!emp($('#txtProductno_'+b_seq).val()) && !emp($('#txtPackwayno_'+b_seq).val())){
							var t_where="where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' and packway='"+$('#txtPackwayno_'+b_seq).val()+"' ^^";
		                	q_gt('pack2s', t_where, 0, 0, 0, "", r_accy,1);
		                	var as = _q_appendData("pack2s", "", true);
							if (as[0] != undefined) {
								var t_gweight=0; //毛重
								var t_nweight=0; //淨重
								var t_mount=dec($('#txtMount_'+b_seq).val());
								var t_uweight=dec(as[0].uweight);
								var t_inmount=dec(as[0].inmount)==0?1:dec(as[0].inmount);
								var t_outmount=dec(as[0].outmount)==0?1:dec(as[0].outmount);
								var t_inweight=dec(as[0].inweight);
								var t_outweight=dec(as[0].outweight);
								var t_cuft=dec(as[0].cuft);
								t_nweight=q_mul(t_mount,t_uweight);
								var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
								var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
								var t_emount=q_sub(t_mount,q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
								t_gweight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
								t_gweight=q_mul(t_pfmount,t_gweight); //整箱毛重
								if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
									var tt_weight=q_mul(t_emount,t_uweight);
									tt_weight=q_add(tt_weight,t_outweight);
									tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
									t_gweight=q_add(t_gweight,tt_weight);
								}
								//$('#txtWeight_'+b_seq).val(t_nweight);
								//$('#txtGweight_'+b_seq).val(t_gweight);
								$('#txtCuft_'+b_seq).val(q_mul(t_cuft,t_pcmount));
		                	}
	                	}
						break;
					case 'divpack2':
						ret = getb_ret();
						if (ret != undefined) {
							$('#textPackwayno').val(ret[0].packway);
							$('#textPackway').val(ret[0].pack);
							$('#textInmount').val(ret[0].inmount);
							$('#textOutmount').val(ret[0].outmount);
							$('#textInweight').val(ret[0].inweight);
							$('#textOutweight').val(ret[0].outweight);
							$('#textCbm').val(ret[0].cbm);
							$('#textCuft').val(ret[0].cuft);
							$('#textMount').change();
						}
						break;
					case q_name + '_s':
						if(s2[1]!=undefined){
							s2[1]="where=^^ (stype='3' or stype='4') and "+replaceAll(s2[1],"where=^^",'');
						}
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function browTicketForm(obj) {
				//資料欄位名稱不可有'_'否則會有問題
				if (($(obj).attr('readonly') == 'readonly') || ($(obj).attr('id').substring(0, 3) == 'lbl')) {
					if ($(obj).attr('id').substring(0, 3) == 'lbl')
						obj = $('#txt' + $(obj).attr('id').substring(3));
					var noa = $.trim($(obj).val());
					var openName = $(obj).attr('id').split('_')[0].substring(3).toLowerCase();
					if (noa.length > 0) {
						switch (openName) {
							case 'ordbno':
								q_box("ordb.aspx?;;;charindex(noa,'" + noa + "')>0;" + r_accy, 'ordb', "95%", "95%", q_getMsg("popOrdb"));
								break;
							case 'ordcno':
								q_box("ordc.aspx?;;;charindex(noa,'" + noa + "')>0;" + r_accy, 'ordc', "95%", "95%", q_getMsg("popOrdc"));
								break;
							case 'quarno':
								q_box("quar.aspx?;;;charindex(noa,'" + noa + "')>0;" + r_accy, 'quar', "95%", "95%", q_getMsg("popQuat"));
								break;
						}
					}
				}
			}

			var focus_addr = '';
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
					case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno])
							$('#cmbCoin').val(abbm[q_recno].coin);
						
						break;
					case 'insfactory':
						var as = _q_appendData("factory", "", true);
						if (as[0] != undefined) {
							$('#txtGdate').val(as[0].noa);
							$('#txtGtime').val(as[0].factory);
						}
						break;
					case 'msg_ucc':
						var as = _q_appendData("ucc", "", true);
						t_msg = '';
						if (as[0] != undefined) {
							t_msg = "銷售單價：" + dec(as[0].saleprice) + "<BR>";
						}
						//客戶售價
						var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and datea<'" + q_date() + "' ^^ stop=1";
						q_gt('quat', t_where, 0, 0, 0, "msg_quat", r_accy);	
						
						break;
					case 'msg_quat':
						var as = _q_appendData("quats", "", true);
						var quat_price = 0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtProductno_' + b_seq).val())
									quat_price = dec(as[i].price);
							}
						}
						t_msg = t_msg + "最近報價單價：" + quat_price + "<BR>";
						//最新出貨單價
						var t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and noa in (select noa from vccs" + r_accy + " where productno='" + $('#txtProductno_' + b_seq).val() + "' and price>0 ) ^^ stop=1";
						q_gt('vcc', t_where, 0, 0, 0, "msg_vcc", r_accy);
						break;
					case 'msg_vcc':
						var as = _q_appendData("vccs", "", true);
						var vcc_price = 0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								if (as[0].productno == $('#txtProductno_' + b_seq).val())
									vcc_price = dec(as[i].price);
							}
						}
						t_msg = t_msg + "最近出貨單價：" + vcc_price;
						q_msg($('#txtPrice_' + b_seq), t_msg);
						break;
					case 'msg_stk':
						var as = _q_appendData("stkucc", "", true);
						var stkmount = 0;
						t_msg = '';
						for (var i = 0; i < as.length; i++) {
							stkmount = q_add(stkmount, dec(as[i].mount));
						}
						t_msg = "庫存量：" + stkmount;
						//平均成本
						var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by datea desc ^^ stop=1";
						q_gt('wcost', t_where, 0, 0, 0, "msg_wcost", r_accy);
						break;
					case 'msg_wcost':
						var as = _q_appendData("wcost", "", true);
						var wcost_price;
						if (as[0] != undefined) {
							if (dec(as[0].mount) == 0) {
								wcost_price = 0;
							} else {
								wcost_price = round(q_div(q_add(q_add(q_add(dec(as[0].costa), dec(as[0].costb)), dec(as[0].costc)), dec(as[0].costd)), dec(as[0].mount)), q_getPara('vcc.pricePrecision'))
								//wcost_price=round((dec(as[0].costa)+dec(as[0].costb)+dec(as[0].costc)+dec(as[0].costd))/dec(as[0].mount),0);
							}
						}
						if (wcost_price != undefined) {
							t_msg = t_msg + "<BR>平均成本：" + wcost_price;
							q_msg($('#txtMount_' + b_seq), t_msg);
						} else {
							//原料成本
							var t_where = "where=^^ productno ='" + $('#txtProductno_' + b_seq).val() + "' order by mon desc ^^ stop=1";
							q_gt('costs', t_where, 0, 0, 0, "msg_costs", r_accy);
						}
						break;
					case 'msg_costs':
						var as = _q_appendData("costs", "", true);
						var costs_price;
						if (as[0] != undefined) {
							costs_price = as[0].price;
						}
						if (costs_price != undefined) {
							t_msg = t_msg + "<BR>平均成本：" + costs_price;
						}
						q_msg($('#txtMount_' + b_seq), t_msg);
						break;
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if (as[0] != undefined) {
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
							}
						}
						document.all.combAddr.options.length = 0;
						q_cmbParse("combAddr", t_item);
						break;
					case 'quat':
						var as = _q_appendData("quat", "", true);
						if (as[0] != undefined) {
							$('#txtFloata').val(as[0].floata);
							$('#cmbCoin').val(as[0].coin);
							$('#txtPaytype').val(as[0].paytype);
							$('#txtSalesno').val(as[0].salesno);
							$('#txtSales').val(as[0].sales);
							$('#txtContract').val(as[0].contract);
							$('#cmbTrantype').val(as[0].trantype);
							$('#txtTel').val(as[0].tel);
							$('#txtFax').val(as[0].fax);
							$('#txtPost').val(as[0].post);
							$('#txtAddr').val(as[0].addr);
							$('#txtPost2').val(as[0].post2);
							$('#txtAddr2').val(as[0].addr2);
							$('#cmbTaxtype').val(as[0].taxtype);
							sum();
						}
						break;
					case 'quar':
						var as = _q_appendData("quar", "", true);
						if (as[0] != undefined) {
							$('#txtFloata').val(as[0].floata);
							$('#cmbCoin').val(as[0].coin);
							$('#txtPaytype').val(as[0].paytype);
							$('#txtSalesno').val(as[0].salesno);
							$('#txtSales').val(as[0].sales);
							$('#txtContract').val(as[0].contract);
							$('#cmbTrantype').val(as[0].trantype);
							$('#txtTel').val(as[0].tel);
							$('#txtFax').val(as[0].fax);
							$('#txtPost').val(as[0].post);
							$('#txtAddr').val(as[0].addr);
							$('#txtPost2').val(as[0].post2);
							$('#txtAddr2').val(as[0].addr2);
							$('#cmbTaxtype').val(as[0].taxtype);
							$('#txtAgentno').val(as[0].agentno);
							$('#txtAgent').val(as[0].agent);
							$('#cmbCasetype').val(as[0].casetype);
							$('#cmbPayterms').val(as[0].payterms);
							sum();
						}
						break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined && focus_addr != '') {
							$('#' + focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
							sum();
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function btnQuat() {
				var t_custno = trim($('#txtCustno').val());
				var t_where = '';
				if (t_custno.length > 0) {
					t_where = "a.enda!=1 and a.cancel!=1 and custno='"+t_custno+"' and  datea>='"+$('#txtOdate').val()+"' ";
					q_box("quar_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'quars', "95%", "95%", $('#btnQuat').val());
				}else {
					alert(q_getMsg('msgCustEmp'));
					return;
				}
				
			}
			
			var t_dodate='',t_dodatename='';
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([ ['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')], ['txtGdate', 'Factory'] ]);
				/*['txtDate3', q_getMsg('lblWeek')]*/
				
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				//106/07/24 暫時不使用
				/*for(var k=0;k<q_bbsCount;k++){
					if(emp($('#txtDatea_'+k).val()))
						getpdate(k);
				}*/
				
				//106/01/12 預交日空 抓期望交期 沒有寫入3個月後
				/*for(var k=0;k<q_bbsCount;k++){
					if(emp($('#txtDatea_'+k).val()) && !emp($('#txtDate1').val())){
							$('#txtDatea_'+k).val($('#txtDate1').val());
					}else{
						$('#txtDatea_'+k).val(q_cdn($('#txtOdate').val(),90));
					}
				}*/
								
				//106/03/16 限制 訂單交期 106/03/17後面等確定再改抓orde.dodate
				//var t_where="where=^^noa='qsys.orde.dodate'^^"
				//106/09/14 不判斷
				/*var t_where="where=^^noa='orde.dodate'^^"
				q_gt('qsys', t_where, 0, 0, 0, "getdodate", r_accy, 1);
				var as = _q_appendData("qsys", "", true);
				if (as[0] != undefined) {
					t_dodatename=as[0].name;
					t_dodate=as[0].value;
				}
				
				var modi_mount2=0;
				for(var i=0;i<q_bbsCount;i++){
					modi_mount2=q_add(modi_mount2,dec($('#txtMount_'+i).val()));
				}
				
				t_err='';
				if(t_dodate.length>0 && (q_cur==1 || (q_cur==2 && modi_mount!=modi_mount2)) ){
					for(var k=0;k<q_bbsCount;k++){
						if($('#txtDatea_'+k).val()<=t_dodate && !emp($('#txtDatea_'+k).val())){
							t_err=q_getMsg('lblDateas')+"【"+$('#txtDatea_'+k).val()+"】不可低於"+t_dodatename+"【"+t_dodate+"】";
							break;
						}	
					}
				}
				if(t_err.length>0){
					alert(t_err);
					return;
				}*/
				
				//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
						if($('#chkCancel').prop('checked'))
							$('#chkCancel_'+j).prop('checked','true')
					}
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO"){
					if($('#cmbStype').val()=='4')//樣品
						q_gtnoa(q_name, replaceAll('S' + $('#txtOdate').val(), '/', ''));
					else
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orde') + $('#txtOdate').val(), '/', ''));
				}else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('orde_r_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function combPaytype_chg() {
				var cmb = document.getElementById("combPaytype");
				if (!q_cur)
					cmb.value = '';
				else
					$('#txtPaytype').val(cmb.value);
				cmb.value = '';
			}
			
			function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtOdate').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

			function combAddr_chg() {
				if (q_cur == 1 || q_cur == 2) {
					$('#txtAddr2').val($('#combAddr').find("option:selected").text());
					$('#txtPost2').val($('#combAddr').find("option:selected").val());
				}
			}

			function bbsAssign() {
				for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnMinus_' + j).click(function() {
							btnMinus($(this).attr('id'));
						});
						$('#btnProductno_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							pop('ucc');
						});
						$('#txtProductno_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//q_change($(this), 'ucc', 'noa', 'noa,product,unit');
						});

						$('#txtUnit_' + j).focusout(function() {
							sum();
						});
						// $('#txtWeight_' + j).focusout(function () { sum(); });
						$('#txtPrice_' + j).focusout(function() {
							sum();
						});
						$('#txtMount_' + j).focusout(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (q_cur == 1 || q_cur == 2)
								//106/07/24 暫時不使用 
								//getpdate(b_seq);
							sum();
						});
						$('#txtTotal_' + j).focusout(function() {
							sum();
						});

						$('#txtMount_' + j).focusin(function() {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								if (!emp($('#txtProductno_' + b_seq).val())) {
									//庫存
									var t_where = "where=^^ ['" + q_date() + "','','"+$('#txtProductno_' + b_seq).val()+"')  ^^";
									q_gt('calstk', t_where, 0, 0, 0, "msg_stk", r_accy);
								}
							}
						});
						$('#txtPrice_' + j).focusin(function() {
							if (q_cur == 1 || q_cur == 2) {
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								if (!emp($('#txtProductno_' + b_seq).val())) {
									//金額
									var t_where = "where=^^ noa='" + $('#txtProductno_' + b_seq).val() + "' ^^ stop=1";
									q_gt('ucc', t_where, 0, 0, 0, "msg_ucc", r_accy);
								}
							}
						});

						$('#btnBorn_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "noa='" + $('#txtNoa').val() + "' and no2='" + $('#txtNo2_' + b_seq).val() + "'";
							q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn'));
						});
						$('#btnNeed_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "productno='" + $('#txtProductno_'+ b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "'";
							q_box("z_vccneed.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'Need', "95%", "95%", q_getMsg('lblNeed'));
						});

						$('#btnVccrecord_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "custno='" + $('#txtCustno').val() + "' and comp='" + $('#txtComp').val() + "' and productno='" + $('#txtProductno_' + b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "' and ordeno='"+$('#txtNoa').val()+"' and no2='"+$('#txtNo2_'+b_seq).val()+"' ";
							q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
						});
						
						$('#btnScheduled_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val())) {
								t_where = "noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
								q_box("z_scheduled.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
							}
						});
						
						$('#btnOrdemount_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "title='本期訂單' and bdate='"+q_cdn(q_date(),-61)+"' and edate='"+q_cdn(q_date(),+61)+"' and noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
							q_box("z_workgorde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
						});
						
						$('#btnPackway_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							t_where = "noa='" + $('#txtProductno_'+b_seq).val() + "'";
							q_box("pack2_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack2', "95%", "95%", '包裝方式');
						});
						
						$('#btnGetprice_'+j).click(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtProductno_'+b_seq).val())){
								$('#textNoq').val(b_seq);
								$('#textProductno').val($('#txtProductno_'+b_seq).val());
								$('#textProduct').val($('#txtProduct_'+b_seq).val());
								$('#textUnit').val($('#txtUnit_'+b_seq).val());
								$('#textMount').val($('#txtMount_'+b_seq).val());
								var t_where = "where=^^ noa='"+$('#textProductno').val()+"' ^^";
								q_gt('view_ucaucc', t_where, 0, 0, 0, "getucaucc", r_accy, 1);
								var as = _q_appendData("view_ucaucc", "", true);
								if (as[0] != undefined) {
									$('#textUweight').val(as[0].uweight);
								}else{
									$('#textUweight').val('');
								}
								$('#textCost').val($('#txtSprice_'+b_seq).val());
								$('#textPackwayno').val($('#txtPackwayno_'+b_seq).val());
								$('#textPackway').val($('#txtPackway_'+b_seq).val());
								var t_where = "where=^^ noa='"+$('#textProductno').val()+"' and packway='"+$('#textPackwayno').val()+"' ^^";
								q_gt('pack2s', t_where, 0, 0, 0, "getpack2s", r_accy, 1);
								var as = _q_appendData("pack2s", "", true);
								if (as[0] != undefined) {
									if(dec($('#textUweight').val())==0)
										$('#textUweight').val(as[0].uweight)
									$('#textInmount').val(as[0].inmount);
									$('#textOutmount').val(as[0].outmount);
									$('#textInweight').val(as[0].inweight);
									$('#textOutweight').val(as[0].outweight);
									$('#textCbm').val(as[0].cbm);
									$('#textCuft').val(as[0].cuft);	
								}else{
									$('#textInmount').val('');
									$('#textOutmount').val('');
									$('#textInweight').val('');
									$('#textOutweight').val('');
									$('#textCbm').val('');
									$('#textCuft').val('');	
								}
								if($('#cmbCasetype').val()=="20'")
									$('#textCycbm').val(33.2);
								if($('#cmbCasetype').val()=="40'")
									$('#textCycbm').val(67.7);
								
								/*$('#textProfit').val($('#txtProfit').val());
								$('#textInsurance').val($('#txtInsurance').val());
								$('#textCommission').val($('#txtCommission').val());
								$('#combPayterms').val($('#cmbPayterms').val());
								*/
								
								$('#textProfit').val($('#txtProfit_'+b_seq).val());
								$('#textInsurance').val($('#txtInsurance_'+b_seq).val());
								$('#textCommission').val($('#txtCommission_'+b_seq).val());
								
								/*if(!emp($('#txtPayterms_'+b_seq).val()))
									$('#combPayterms').val($('#txtPayterms_'+b_seq).val());*/
								$('#combPayterms').val($('#cmbPayterms').val());
								
								$('#textMount').change();
								$('#textCost').change();
								$('#div_getprice').css('top', e.pageY- $('#div_getprice').height());
								$('#div_getprice').css('left', e.pageX - $('#div_getprice').width());
								
								$('#div_getprice').show();
							}
						});
						
						$('#btnUcagroup_' + j).click(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#table_ucagroup .no').text('');
							$('#table_ucagroup .mon').text('');
							$('#table_ucagroup .memo1').text('');
							$('#table_ucagroup .memo2').text('');
							if(!emp($('#txtProductno_'+b_seq).val())){
								$('.ucano').text($('#txtProductno_'+b_seq).val());
								var t_where = "where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' ^^";
								q_gt('uca', t_where, 0, 0, 0, "",r_accy,1);
								var as = _q_appendData("uca", "", true);
								if (as[0] != undefined) {
									$('.ucaname').text(as[0].product);
									$('.ucaspec').text(as[0].spec);
									//車縫
									$('.groupe.no').text(as[0].groupeno);
									if(!emp($('.groupe.no').text())){
										var t_where = "where=^^ noa='"+$('.groupe.no').text()+"' ^^";
										q_gt('adsize', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adsize", "", true);
										if (ass[0] != undefined) {
											$('.groupe.mon').text(ass[0].mon);
											$('.groupe.memo1').text(ass[0].memo1);
											$('.groupe.memo2').text(ass[0].memo2);
										}
									}
									//車縫線顏色
									$('.ucolor.no').text($('#txtUcolor_'+b_seq).val());
									if(!emp($('.ucolor.no').text())){
										var t_where = "where=^^ noa='"+$('.ucolor.no').text()+"' ^^";
										q_gt('adspec', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adspec", "", true);
										if (ass[0] != undefined) {
											$('.ucolor.mon').text(ass[0].mon);
											$('.ucolor.memo1').text(ass[0].memo1);
											$('.ucolor.memo2').text(ass[0].memo2);
										}
									}
									//護片
									$('.groupf.no').text(as[0].groupfno);
									if(!emp($('.groupf.no').text())){
										var t_where = "where=^^ noa='"+$('.groupf.no').text()+"' ^^";
										q_gt('adsss', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adsss", "", true);
										if (ass[0] != undefined) {
											$('.groupf.mon').text(ass[0].mon);
											$('.groupf.memo1').text(ass[0].memo1);
											$('.groupf.memo2').text(ass[0].memo2);
										}
									}
									//皮料1
									$('.scolor.no').text($('#txtScolor_'+b_seq).val());
									if(!emp($('.scolor.no').text())){
										var t_where = "where=^^ noa='"+$('.scolor.no').text()+"' ^^";
										q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adly", "", true);
										if (ass[0] != undefined) {
											$('.scolor.mon').text(ass[0].mon);
											$('.scolor.memo1').text(ass[0].memo1);
											$('.scolor.memo2').text(ass[0].memo2);
										}
									}
									//皮料2
									$('.class.no').text($('#txtClass_'+b_seq).val());
									if(!emp($('.class.no').text())){
										var t_where = "where=^^ noa='"+$('.class.no').text()+"' ^^";
										q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adly", "", true);
										if (ass[0] != undefined) {
											$('.class.mon').text(ass[0].mon);
											$('.class.memo1').text(ass[0].memo1);
											$('.class.memo2').text(ass[0].memo2);
										}
									}
									//皮料3
									$('.classa.no').text($('#txtClassa_'+b_seq).val());
									if(!emp($('.classa.no').text())){
										var t_where = "where=^^ noa='"+$('.classa.no').text()+"' ^^";
										q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adly", "", true);
										if (ass[0] != undefined) {
											$('.classa.mon').text(ass[0].mon);
											$('.classa.memo1').text(ass[0].memo1);
											$('.classa.memo2').text(ass[0].memo2);
										}
									}
									//皮料4
									$('.zinc.no').text($('#txtZinc_'+b_seq).val());
									if(!emp($('.zinc.no').text())){
										var t_where = "where=^^ noa='"+$('.zinc.no').text()+"' ^^";
										q_gt('adly', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adly", "", true);
										if (ass[0] != undefined) {
											$('.zinc.mon').text(ass[0].mon);
											$('.zinc.memo1').text(ass[0].memo1);
											$('.zinc.memo2').text(ass[0].memo2);
										}
									}
									//網烙印
									$('.sizea.no').text($('#txtSizea_'+b_seq).val());
									if(!emp($('.sizea.no').text())){
										var t_where = "where=^^ noa='"+$('.sizea.no').text()+"' ^^";
										q_gt('adoth', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adoth", "", true);
										if (ass[0] != undefined) {
											$('.sizea.mon').text(ass[0].mon);
											$('.sizea.memo1').text(ass[0].memo1);
											$('.sizea.memo2').text(ass[0].memo2);
										}
									}
									//轉印
									$('.source.no').text($('#txtSource_'+b_seq).val());
									if(!emp($('.source.no').text())){
										var t_where = "where=^^ noa='"+$('.source.no').text()+"' ^^";
										q_gt('adpro', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adpro", "", true);
										if (ass[0] != undefined) {
											$('.source.mon').text(ass[0].mon);
											$('.source.memo1').text(ass[0].memo1);
											$('.source.memo2').text(ass[0].memo2);
										}
									}
									//大弓
									$('.groupg.no').text(as[0].groupgno);
									if(!emp($('.groupg.no').text())){
										var t_where = "where=^^ noa='"+$('.groupg.no').text()+"' ^^";
										q_gt('adknife', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adknife", "", true);
										if (ass[0] != undefined) {
											$('.groupg.mon').text(ass[0].mon);
											$('.groupg.memo1').text(ass[0].memo1);
											$('.groupg.memo2').text(ass[0].memo2);
										}
									}
									//中束
									$('.grouph.no').text(as[0].grouphno);
									if(!emp($('.grouph.no').text())){
										var t_where = "where=^^ noa='"+$('.grouph.no').text()+"' ^^";
										q_gt('adpipe', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adpipe", "", true);
										if (ass[0] != undefined) {
											$('.grouph.mon').text(ass[0].mon);
											$('.grouph.memo1').text(ass[0].memo1);
											$('.grouph.memo2').text(ass[0].memo2);
										}
									}
									//座管
									$('.groupi.no').text(as[0].groupino);
									if(!emp($('.groupi.no').text())){
										var t_where = "where=^^ noa='"+$('.groupi.no').text()+"' ^^";
										q_gt('adtran', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("adtran", "", true);
										if (ass[0] != undefined) {
											$('.groupi.mon').text(ass[0].mon);
											$('.groupi.memo1').text(ass[0].memo1);
											$('.groupi.memo2').text(ass[0].memo2);
										}
									}
									//電鍍
									$('.hard.no').text($('#txtHard_'+b_seq).val());
									if(!emp($('.hard.no').text())){
										var t_where = "where=^^ noa='"+$('.hard.no').text()+"' ^^";
										q_gt('addime', t_where, 0, 0, 0, "",r_accy,1);
										var ass = _q_appendData("addime", "", true);
										if (ass[0] != undefined) {
											$('.hard.mon').text(ass[0].mon);
											$('.hard.memo1').text(ass[0].memo1);
											$('.hard.memo2').text(ass[0].memo2);
										}
									}
									$('#div_ucagroup').css('top', e.pageY- $('#div_ucagroup').height()-80);
									$('#div_ucagroup').css('left', e.pageX +10);
									ucagroupdivmove = false;
									$('#div_ucagroup').show();
								}
							}
						});
					}
				}
				_bbsAssign();
				HiddenTreat();
				if (q_cur<1 && q_cur>2) {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtDatea_'+j).datepicker( 'destroy' );
					}
				} else {
					for (var j = 0; j < q_bbsCount; j++) {
						$('#txtDatea_'+j).removeClass('hasDatepicker')
						$('#txtDatea_'+j).datepicker();
					}
				}
				if(q_cur==1 || q_cur==2){
					$('#btnGetpdate').removeAttr('disabled');
				}else{
					$('#btnGetpdate').attr('disabled', 'disabled');
				}
				$('#btnGetpdate').unbind('click');
				$('#btnGetpdate').click(function() {
					for(var k=0;k<q_bbsCount;k++){
						if(emp($('#txtDatea_'+k).val())){
							getpdate(k);
						}
					}
				});
			}

			function btnIns() {
				_btnIns();
				$('#chkIsproj').attr('checked', true);
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				$('#txtOdate').val(q_date());
				$('#txtOdate').focus();
				$('#cmbStype').val('3');

				var t_where = "where=^^ 1=0 ^^ stop=100";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				
				if(q_getPara('sys.project').toUpperCase()=='JO'){
					var t_where = "where=^^ 1=1 ^^ stop=100";
					q_gt('factory', t_where, 0, 0, 0, "insfactory");
				}
			}
			
			//106/03/16 限制 訂單交期 修改判斷總量是否有變動
			var modi_mount=0;
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				
				modi_mount=0;
				for(var i=0;i<q_bbsCount;i++){
					modi_mount=q_add(modi_mount,dec($('#txtMount_'+i).val()));
				}
					
				_btnModi();
				
				$('#txtOdate').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^ stop=100";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
                var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
				q_box("z_ordep_r.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				xmlSql = '';
				if (q_cur == 2)
					xmlSql = q_preXml();

				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                    
				if(!emp($('#txtUmmno').val()) || !emp($('#txtAcc1').val()) || dec($('#txtDeposit').val())!=0 ){
					if(!emp($('#txtUmmno').val())){
						q_func('umm_post.post.modi', r_accy + ',' + $('#txtUmmno').val() + ',0');
					}else{
						q_func('qtxt.query.ins', 'orde.txt,ordetoumm,'+ encodeURI(r_accy)+';' 
						+ encodeURI($('#txtNoa').val()) + ';1;' + encodeURI(q_getPara('sys.key_umm')) + ';' 
						+ encodeURI(q_getPara('sys.project').toUpperCase()) + ';' 
						+ encodeURI(r_userno) + ';' + encodeURI(r_name));
					}
				}
				
				
				var factory_true=true;
				if(!emp($('#txtGdate').val())){
					var t_where = "where=^^ 1=1 ^^ stop=100";
					q_gt('factory', t_where, 0, 0, 0, "getfactory",r_accy,1);
					var as = _q_appendData("factory", "", true);
					if (as[0] != undefined) {
						if(as[0].tggno.length==0 || as[0].ip.length==0 || as[0].db.length==0){
							alert("【Factory】內容不完整!!");
							factory_true=false;
						}
					}else{
						alert("【Factory】編號不存在!!");
						factory_true=false;
					}
				}
				
				//修改後重新產生
				if(q_cur==2 && (!emp($('#txtOrdcno').val()) || !emp($('#txtMemo2').val())) && factory_true){
					alert('重新轉採購單!!')
					q_func('qtxt.query.orde2ordc_r', 'orde.txt,orde2ordc_r,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(q_date())+ ';' + encodeURI(r_name));
				}
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.ins':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            abbm[q_recno]['ummno'] = as[0].ummno;
                            $('#txtUmmno').val(as[0].ummno);

                            if (as[0].ummno.length > 0) {
                                q_func('umm_post.post', r_accy + ',' + as[0].ummno + ',1');
                            }
                        }
                        break;
                	case 'umm_post.post.modi':
                		q_func('qtxt.query.modi', 'orde.txt,ordetoumm,'+ encodeURI(r_accy)+';' 
						+ encodeURI($('#txtNoa').val()) + ';0;' + encodeURI(q_getPara('sys.key_umm')) + ';' 
						+ encodeURI(q_getPara('sys.project').toUpperCase()) + ';' 
						+ encodeURI(r_userno) + ';' + encodeURI(r_name));
                		break;
                	case 'qtxt.query.modi':
                		q_func('qtxt.query.modi2', 'orde.txt,ordetoumm,'+ encodeURI(r_accy)+';' 
						+ encodeURI($('#txtNoa').val()) + ';1;' + encodeURI(q_getPara('sys.key_umm')) + ';' 
						+ encodeURI(q_getPara('sys.project').toUpperCase()) + ';' 
						+ encodeURI(r_userno) + ';' + encodeURI(r_name));
                		break;	
                	case 'qtxt.query.modi2':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            abbm[q_recno]['ummno'] = as[0].ummno;
                            $('#txtUmmno').val(as[0].ummno);

                            if (as[0].ummno.length > 0) {
                                q_func('umm_post.post', r_accy + ',' + as[0].ummno + ',1');
                            }
                        }
                		break;
					case 'umm_post.post.dele':
						q_func('qtxt.query.dele', 'orde.txt,ordetoumm,'+ encodeURI(r_accy)+';' 
						+ encodeURI($('#txtNoa').val()) + ';0;' + encodeURI(q_getPara('sys.key_umm')) + ';' 
						+ encodeURI(q_getPara('sys.project').toUpperCase()) + ';' 
						+ encodeURI(r_userno) + ';' + encodeURI(r_name));
						break;
                    case 'qtxt.query.dele':
                        _btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3);
                        break;
                    case 'qtxt.query.orde2ordc_r':
                    	var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	abbm[q_recno]['ordcno'] = as[0].ordcno;
                        	abbm[q_recno]['memo2'] = as[0].ordeno;
                            $('#txtOrdcno').val(as[0].ordcno);
                            $('#txtMemo2').val(as[0].ordeno);
                            if(as[0].err.length>0)
								alert(as[0].err);
                        }
                    	break;	
                }
            }

			function bbsSave(as) {
				if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['type'] = abbm2['type'];
				as['mon'] = abbm2['mon'];
				as['noa'] = abbm2['noa'];
				as['odate'] = abbm2['odate'];

				/*if (!emp(abbm2['datea']))
					as['datea'] = abbm2['datea'];*/

				as['custno'] = abbm2['custno'];
				as['comp'] = abbm2['comp'];

				if (!as['enda'])
					as['enda'] = 'N';
				t_err = '';
				if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
					t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';

				if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
					t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

				if (t_err) {
					alert(t_err);
					return false;
				}

				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				$('input[id*="txt"]').click(function() {
					browTicketForm($(this).get(0));
				});
				$('#div_addr2').hide();
				HiddenTreat();
				cufttotal();
				$('#div_getprice').hide();
				$('#div_ucagroup').hide();
				$('#div_vccdate').hide();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#btnOrdei').removeAttr('disabled');
					$('#combAddr').attr('disabled', 'disabled');
					$('#txtOdate').datepicker( 'destroy' );
					$('#txtDate1').datepicker( 'destroy' );
					$('#txtDate2').datepicker( 'destroy' );
					$('#txtDate4').datepicker( 'destroy' );
					$('#btnOrdem').removeAttr('disabled');
					$('#btnOrdc').removeAttr('disabled');
				} else {
					$('#btnOrdei').attr('disabled', 'disabled');
					$('#combAddr').removeAttr('disabled');
					$('#txtOdate').datepicker();
					$('#txtDate1').datepicker();
					$('#txtDate2').datepicker();
					$('#txtDate4').datepicker();
					$('#btnOrdem').attr('disabled', 'disabled');
					$('#btnOrdc').attr('disabled', 'disabled');
				}	
				
				$('#div_addr2').hide();
				readonly_addr2();
				HiddenTreat();
				cufttotal();
				
				//$('#cmbStype').attr('disabled', 'disabled');
			}
			
			function HiddenTreat() {
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				var hasSpec = q_getPara('sys.isspec');
				var isSpec = (hasSpec.toString()=='1'?$('.isSpec').show():$('.isSpec').hide());
				
				if(t_imgshow){
					$('.isimg').show();
					imgshowhide();
				}else{
					$('.isimg').hide();
					imgshowhide();
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
				//_btnDele();
				if (emp($('#txtNoa').val()))
					return;
				
				if (!confirm(mess_dele))
                    return;
                    
				if (!emp($('#txtOrdcno').val())){
					alert('已轉採購單禁止刪除!!')
					return;
				}
                    
				if (!emp($('#txtMemo2').val())){
					alert('已轉越南廠訂單禁止刪除!!')
					return;
				}
                    
                q_cur = 3;
                if ($('#txtUmmno').val().length > 0) {
					q_func('umm_post.post.dele', r_accy + ',' + $('#txtUmmno').val() + ',0');
				}else{
					_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3);
				}
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "'^^ stop=100";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
					case 'txtProductno_':
						imgshowhide();
						break;
				}
			}
			
			function getpdate(x) {
				var monhoilday=q_getPara('sys.saturday')=='1'?4:8;
				var monday=0;//當月天數
				var mongen=0,daygen=0;//當月產能
				var t_date='',t_mon='';//計算日期
				var factnotv=0;//排程量
				if((q_cur==1 || q_cur==2)){
					//排產週
					/*if(!emp($('#txtOdate').val()) && !emp($('#txtDate3').val()) && !emp($('#txtGdate').val())){ //排產週
						var t_odate=new Date(dec($('#txtOdate').val().substr(0,r_len))
						,dec($('#txtOdate').val().substr(r_len+1,r_lenm-r_len-1))-1
						,dec($('#txtOdate').val().substr(r_lenm+1,r_lend-r_lenm-1)));
						
						var t_week=getISOYearWeek(t_odate);
						if(t_week>=52 && $('#txtOdate').val().substr(r_len+1,r_lenm-r_len-1)=='01'){
							t_week=1;
						}
						var tt_date; //當年第一週
						if(t_week<=dec($('#txtDate3').val())){ //正常排程
							tt_date=getYearFirstWeekDate(dec($('#txtOdate').val().substr(0,r_len)));
						}else{ //隔年
							tt_date=getYearFirstWeekDate(dec($('#txtOdate').val().substr(0,r_len))+1);
						}
						t_date=tt_date.getFullYear()+'/'+('00'+(tt_date.getMonth()+1).toString()).slice(-2)+'/'+('00'+(tt_date.getDate()).toString()).slice(-2);
						
						var t_day=(dec($('#txtDate3').val())-1)*7;
						if(t_day>0) 
							t_date=q_cdn(t_date,t_day);//當週第一天
							
						var t_where = "where=^^ mon='" + t_date.substr(0,r_lenm) + "' and factno='"+$('#txtGdate').val()+"' ^^";
						q_gt('supforecasts', t_where, 0, 0, 0, "",r_accy,1);
						var ass = _q_appendData("supforecasts", "", true);
						for ( i = 0; i < ass.length; i++) {
							mongen=q_add(mongen,dec(ass[i].mount)); //當月總產能
						}
						
						if(mongen>0){ //當有產能才計算
							t_mon=t_date.substr(0,r_lenm);
							monday=dec(q_cdn(q_cdn(t_date.substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1).slice(-2));
							daygen=q_div(mongen,q_sub(monday,monhoilday));
							//取排產週的量
							var t_where = "where=^^ a.enda!=1 and a.cancel!=1 and b.enda!=1 and b.cancel!=1 and a.gdate='"+$('#txtGdate').val()+"' and a.noa!='"+$('#txtNoa').val()
							+"' and isnull(b.mount,0)-isnull(c.c1,0)>0 and a.date3='"+$('#txtDate3').val()+"' group by a.gdate ^^";
							
							q_gt('orde_r_factnotv', t_where, 0, 0, 0, "",r_accy,1);
							var as = _q_appendData("view_orde", "", true);
							if (as[0] != undefined) {
								factnotv=dec(as[0].notv);
							}
							//取得目前訂單的數量
							var t_bbsmount=0;
							for (var j = 0; j <= x; j++) {
								t_bbsmount=q_add(t_bbsmount,dec($('#txtMount_'+j).val()));
							}
							factnotv=q_add(factnotv,t_bbsmount);
							
							while(factnotv>0){
								
								if(t_date.substr(0,r_lenm) != t_mon){//取得新的產能
									t_mon=t_date.substr(0,r_lenm);
									var t_where = "where=^^ mon='" + t_mon + "' and factno='"+$('#txtGdate').val()+"' ^^";
									q_gt('supforecasts', t_where, 0, 0, 0, "",r_accy,1);
									var ast = _q_appendData("supforecasts", "", true);
									if (ast[0] != undefined) {
										mongen=0;
										for ( i = 0; i < ast.length; i++) {
											mongen=q_add(mongen,dec(ast[i].mount)); //當月總產能
										}
										monday=dec(q_cdn(q_cdn(t_date.substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1).slice(-2));
										daygen=q_div(mongen,q_sub(monday,monhoilday));
									}//如果沒有就沿用產能
								}
								
								factnotv=q_sub(factnotv,daygen);
								if(factnotv>0){
									t_date=q_cdn(t_date,1);
									
									var week='';
									if(t_date.length==10){
										week=new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2))-1,dec(t_date.substr(8,2))).getDay()
									}else{
										week=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay();
									}
									if(q_getPara('sys.saturday')!='1' && week==6)
										t_date=q_cdn(t_date,1);
									if(week==0)
										t_date=q_cdn(t_date,1);
								}
							}
							$('#txtDatea_'+x).val(t_date);
						}
					}*/ 
					/*else*/
					//supforecasts 工廠產能預估
					/*if(!emp($('#txtOdate').val()) && !emp($('#txtGdate').val()) && dec($('#txtMount_'+x).val())>0 ){
						var t_where = "where=^^ mon='" + q_cdn($('#txtOdate').val(),1).substr(0,r_lenm) + "' and factno='"+$('#txtGdate').val()+"' ^^";
						q_gt('supforecasts', t_where, 0, 0, 0, "",r_accy,1);
						var ass = _q_appendData("supforecasts", "", true);
						for ( i = 0; i < ass.length; i++) {
							mongen=q_add(mongen,dec(ass[i].mount)); //當月總產能
						}
						
						if(mongen>0){ //當有產能才計算
							t_date=q_cdn($('#txtOdate').val(),1);
							t_mon=q_cdn($('#txtOdate').val(),1).substr(0,r_lenm);
							monday=dec(q_cdn(q_cdn(t_date.substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1).slice(-2));
							daygen=q_div(mongen,q_sub(monday,monhoilday));
							
							//取未完工量
							var t_where = "where=^^ a.enda!=1 and a.cancel!=1 and b.enda!=1 and b.cancel!=1 and a.gdate='"+$('#txtGdate').val()+"' and a.noa!='"+$('#txtNoa').val()+"' and isnull(b.mount,0)-isnull(c.c1,0)>0 group by a.gdate ^^";
							q_gt('orde_r_factnotv', t_where, 0, 0, 0, "",r_accy,1);
							var as = _q_appendData("view_orde", "", true);
							if (as[0] != undefined) {
								factnotv=dec(as[0].notv);
							}
							
							//取得目前訂單的數量
							var t_bbsmount=0;
							for (var j = 0; j <= x; j++) {
								t_bbsmount=q_add(t_bbsmount,dec($('#txtMount_'+j).val()));
							}
							
							factnotv=q_add(factnotv,t_bbsmount);
							
							while(factnotv>0){
								if(t_date.substr(0,r_lenm) != t_mon){//取得新的產能
									t_mon=t_date.substr(0,r_lenm);
									var t_where = "where=^^ mon='" + t_mon + "' and factno='"+$('#txtGdate').val()+"' ^^";
									q_gt('supforecasts', t_where, 0, 0, 0, "",r_accy,1);
									var ast = _q_appendData("supforecasts", "", true);
									if (ast[0] != undefined) {
										mongen=0;
										for ( i = 0; i < ast.length; i++) {
											mongen=q_add(mongen,dec(ast[i].mount)); //當月總產能
										}
										monday=dec(q_cdn(q_cdn(t_date.substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1).slice(-2));
										daygen=q_div(mongen,q_sub(monday,monhoilday));
									}//如果沒有就沿用產能
								}
								
								factnotv=q_sub(factnotv,daygen);
								if(factnotv>0){
									t_date=q_cdn(t_date,1);
									var week='';
									if(t_date.length==10){
										week=new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2)),dec(t_date.substr(8,2))).getDay()
									}else{
										week=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay();
									}
									if(q_getPara('sys.saturday')!='1' && week==6)
										t_date=q_cdn(t_date,1);
									if(week==0)
										t_date=q_cdn(t_date,1);
								}
							}
							$('#txtDatea_'+x).val(t_date);
						}
					}*/
					
					//106/03/27 根據sys orde.dodate +3 若 單一產品數量超出3000 多1天
					//106/03/28 依據型號 超出模具數多1天
					var t_dodate=$('#txtOdate').val()>q_date()?$('#txtOdate').val():q_date();
					var t_where = "where=^^ noa='orde.dodate' ^^";
					q_gt('qsys', t_where, 0, 0, 0, "",r_accy,1);
					var as = _q_appendData("qsys", "", true);
					if (as[0] != undefined) {
						t_dodate=as[0].value;
					}
					q_gt('holiday', "where=^^ noa>='"+q_date()+"' ^^ stop=100" , 0, 0, 0, "getholiday", r_accy,1);
					var holiday = _q_appendData("holiday", "", true);
					//先加3天
					var t_addday=3;
					var t_productno=$('#txtProductno_'+x).val();
					//該訂單品項總數量超出3000 多1天
					/*var t_mount=0;
					for (var j = 0; j < (dec(x)+1); j++) {
						if($('#txtProductno_'+ j).val()==t_productno){
							t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
						}
					}
					if(t_mount>3000){
						t_addday=q_add(t_addday,Math.floor(t_mount/3000))
					}*/
					
					//106/03/28 依據型號 超出模具數多1天 //找不到模具超過兩萬多一天
					q_gt('model', "where=^^ exists (select * from ucx where noa='"+t_productno+"' and (spec=model.noa or spec=REPLACE(REPLACE(model.noa,'WU-',''),'WU',''))) ^^ stop=100" , 0, 0, 0, "getmodel", r_accy,1);
					var as = _q_appendData("model", "", true);
					var modelno='';
					var modelmount=0;//模具數
					var modelgen=0; //模具產能
					if (as[0] != undefined) {
						modelno=as[0].noa;
						modelmount=dec(as[0].mount);
						if(modelmount==0){
							modelmount=1;
						}
						modelgen=q_mul(modelmount,120);
					}
					//讀取表身相同型號的品號
					var modelucc=new Array();
					if(modelno.length>0){
						var t_where="";
						for (var j = 0; j < dec(x); j++) {
							if(!emp($('#txtProductno_'+j).val()))
								t_where+=" or noa='"+$('#txtProductno_'+j).val()+"'";
						}
						if(t_where.length>0){
							t_where="(1=0 "+t_where+") and exists (select * from model where noa='"+modelno+"' and (noa=ucx.spec or REPLACE(REPLACE(noa,'WU-',''),'WU','')=ucx.spec)) "
							q_gt('ucx', "where=^^ "+t_where+" ^^ stop=999" , 0, 0, 0, "getucx", r_accy,1);
							modelucc = _q_appendData("ucx", "", true);
						}
						var t_mount=dec($('#txtMount_'+x).val());
						for (var j = 0; j < dec(x); j++) {
							if($('#txtProductno_'+ j).val()==t_productno){
								t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
							}else{
								var t_existsmodel=false;
								for(var k=0;k<modelucc.length;k++){
									if($('#txtProductno_'+ j).val()==modelucc[k].noa){
										t_existsmodel=true;
										break;
									}
								}
								if(t_existsmodel){
									t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
								}
							}
						}
						if(t_mount>modelgen){
							t_addday=q_add(t_addday,Math.floor(t_mount/modelgen))
						}
					}else{
						var t_mount=0;
						//找不到模具
						for (var j = 0; j < (dec(x)+1); j++) {
							if($('#txtProductno_'+ j).val()==t_productno){
								t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
							}
						}
						if(t_mount>20000){
							t_addday=q_add(t_addday,Math.floor(t_mount/20000))
						}
					}
					
					while(t_addday>0){
						t_dodate=q_cdn(t_dodate,1);
						var t_iswork=true;
						var t_holidaywork=false; //假日主檔是否要上班
							
						for(var k=0;k<holiday.length;k++){
							if(holiday[k].noa==t_dodate){
								if(holiday[k].iswork=="true"){
									t_holidaywork=true;
								}else{
									t_iswork=false;
								}
							}
						}
							
						if(!t_holidaywork && t_iswork){
							var week='';
							if(t_dodate.length==10){
								week=new Date(dec(t_dodate.substr(0,4)),dec(t_dodate.substr(5,2))-1,dec(t_dodate.substr(8,2))).getDay()
							}else{
								week=new Date(dec(t_dodate.substr(0,3))+1911,dec(t_dodate.substr(4,2))-1,dec(t_dodate.substr(7,2))).getDay();
							}
									
							if(q_getPara('sys.saturday')!='1' && week==6)
								t_iswork=false;
							if(week==0)
								t_iswork=false;
						}
							
						if(t_iswork){
							t_addday--;
						}
					}
					$('#txtDatea_'+x).val(t_dodate);
				}
			}
			
			var ucagroupdivmove = false;
			function move(event){
 				if(ucagroupdivmove){
					var x = event.clientX-sx;
					var y = event.clientY-sy;
					sx = event.clientX;
					sy = event.clientY;
					$('#div_ucagroup').css('top', $('#div_ucagroup').offset().top+y);
					$('#div_ucagroup').css('left', $('#div_ucagroup').offset().left+x);
				}
			}

			function ucadivmove(event){
				if(!ucagroupdivmove){
					ucagroupdivmove = true; 
					sx = event.clientX;
					sy = event.clientY;
				}
				else if(ucagroupdivmove)
					ucagroupdivmove = false;
			}
			
			function getISOYearWeek(date){  
		        var commericalyear=getCommerialYear(date);  
		        var date2=getYearFirstWeekDate(commericalyear);     
		        var day1=date.getDay();     
		        if(day1==0) day1=7;     
		        var day2=date2.getDay();     
		        if(day2==0) day2=7;     
		        var d = Math.round((date.getTime() - date2.getTime()+(day2-day1)*(24*60*60*1000)) / 86400000);       
		        return Math.ceil(d / 7)+1;   
		    }
			
			function getYearFirstWeekDate(commericalyear){  
		        var yearfirstdaydate=new Date(commericalyear, 0, 1);     
		        var daynum=yearfirstdaydate.getDay();   
		        var monthday=yearfirstdaydate.getDate();  
		        if(daynum==0) daynum=7;  
		        if(daynum<=4){  
		            return new Date(yearfirstdaydate.getFullYear(),yearfirstdaydate.getMonth(),monthday+1-daynum);  
		        }else{  
		            return new Date(yearfirstdaydate.getFullYear(),yearfirstdaydate.getMonth(),monthday+8-daynum)  
		        }   
		    }
		    
		    function getCommerialYear(date){  
		        var daynum=date.getDay();   
		        var monthday=date.getDate();  
		        if(daynum==0) daynum=7;  
		        var thisthurdaydate=new Date(date.getFullYear(),date.getMonth(),monthday+4-daynum);  
		        return thisthurdaydate.getFullYear();  
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
				width: 100%;
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
			.tbbm td input[type="button"] {
				width: auto;
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
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 48%;
				float: left;
			}
			.txt.c3 {
				width: 50%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
				float: left;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"],select {
				font-size: medium;
			}
		</style>
	</head>
	<body onmousemove="move(event);">
		<div id="div_getprice" style="position:absolute; top:300px; left:500px; display:none; width:600px; background-color: #FFE7CD; ">
			<table id="table_getprice" class="table_row" style="width:100%;" cellpadding='1' cellspacing='0' border='1' >
				<tr style="display: none;">
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
					<td align="center" width="100px"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">產品</a></td>
					<td align="center" colspan="2"><input id="textProductno" type="text" class="txt c1" disabled="disabled"/></td>
					<td align="center" colspan="3">
						<input id="textProduct" type="text" class="txt c1" disabled="disabled"/>
						<input id="textNoq" type="hidden" class="txt c1" disabled="disabled"/>
					</td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">單位</a></td>
					<td align="center"><input id="textUnit" type="text" class="txt c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">數量</a></td>
					<td align="center"><input id="textMount" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">產品成本</a></td>
					<td align="center"><input id="textCost" type="text" class="txt num c1"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">單位重</a></td>
					<td align="center"><input id="textUweight" type="text" class="txt num c1"/></td>
					<td align="center"><a id="div_pack2" class="lbl" style="cursor: pointer;color: #4297D7;font-weight: bolder;">包裝方式</a></td>
					<td align="center"><input id="textPackwayno" type="text" class="txt c1" disabled="disabled"/></td>
					<td align="center" colspan="2"><input id="textPackway" type="text" class="txt c1" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">內包裝</a></td>
					<td align="center"><input id="textInmount" type="text" class="txt num c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">外包裝</a></td>
					<td align="center"><input id="textOutmount" type="text" class="txt num c1" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">內包裝重</a></td>
					<td align="center"><input id="textInweight" type="text" class="txt num c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">外包裝重</a></td>
					<td align="center"><input id="textOutweight" type="text" class="txt num c1" disabled="disabled"/></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">CBM/CTN</a></td>
					<td align="center"><input id="textCbm" type="text" class="txt num c1" disabled="disabled"/></td>
					<td align="center"><a class="lbl">CUFT/CTN</a></td>
					<td align="center"><input id="textCuft" type="text" class="txt num c1" disabled="disabled"/></td>
				</tr>
				<tr style="background-color: #E7FFCD; " >
					<td align="center"><a class="lbl">運費選擇</a></td>
					<td align="center" colspan="5"> </td>
				</tr>
				<tr style="background-color: #E7FFCD; " >
					<td align="center">
						<input type="radio" name="trantype" value="cy" checked> 
						<a class="lbl">CY $</a>
					</td>
					<td align="center"><input id="textCyprice" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">CBM</a></td>
					<td align="center"><input id="textCycbm" type="text" class="txt num c1"/></td>
					<td align="center" colspan="2"> </td>
				</tr>
				<tr style="background-color: #E7FFCD; ">
					<td align="center">
						<input type="radio" name="trantype" value="kg">
						<a class="lbl">KG $</a>
					</td>
					<td align="center"><input id="textKgprice" type="text" class="txt num c1"/></td>
					<td align="center">
						<input type="radio" name="trantype" value="cuft">
						<a class="lbl">Cuft $</a>
					</td>
					<td align="center"><input id="textCuftprice" type="text" class="txt num c1"/></td>
					<td align="center" colspan="2"> </td>
				</tr>
				<tr style="background-color: #E7CDFF; ">
					<td align="center"><a class="lbl">運費成本</a></td>
					<td align="center"><input id="textTranprice" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">其他支出</a></td>
					<td align="center"><input id="textFee" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">成本合計</a></td>
					<td align="center"><input id="textCost2" type="text" class="txt num c1"/></td>
				</tr>
				<tr style="background-color: #EC7DD2; ">
					<td align="center"><a class="lbl">Profit</a></td>
					<td align="center"><input id="textProfit" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
					<td align="center"><a class="lbl">Insurance</a></td>
					<td align="center"><input id="textInsurance" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
					<td align="center"><a class="lbl">Commission</a></td>
					<td align="center"><input id="textCommission" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
				</tr>
				<tr style="background-color: #EC7DD2;display: none;">
					<td align="right"><a class="lbl">$</a></td>
					<td align="center"><input id="textInsurmoney" type="text" class="txt num c1"/></td>
					<td align="right"><a class="lbl">$</a></td>
					<td align="center"><input id="textCommimoney" type="text" class="txt num c1"/></td>
					<td align="right"><a class="lbl">$</a></td>
					<td align="center"><input id="textProfitmoney" type="text" class="txt num c1"/></td>
				</tr>
				<tr style="background-color: #52FDAC;">
					<td align="center"><a class="lbl">價格條件</a></td>
					<td align="center"><select id="combPayterms" class="txt c1" disabled="disabled"> </select></td>
					<td align="center"><a class="lbl">試算單價</a></td>
					<td align="center"><input id="textCost3" type="text" class="txt num c1"/></td>
					<td align="center"><a class="lbl">試算總重量</a></td>
					<td align="center"><input id="textWeight" type="text" class="txt num c1"/></td>
				</tr>
				<tr style="background-color: #F1A0A2;">
					<td align="center" colspan='6'>
						<input id="btnOk_div_getprice" type="button" value="取回單價/重量">
						<input id="btnClose_div_getprice" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="div_ucagroup" style="position:absolute; top:300px; left:500px; display:none; width:680px; background-color: #FFE7CD; " onmousedown="ucadivmove(event);">
			<table id="table_ucagroup" class="table_row" style="width:100%;" cellpadding='1' cellspacing='0' border='1' >
				<tr>
					<td align="center"><a class="lbl">Item No.</a></td>
					<td align="left" colspan="4" class="ucano"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">Description</a></td>
					<td align="left" colspan="4" class="ucaname"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">型號</a></td>
					<td align="left" colspan="4" class="ucaspec"> </td>
				</tr>
				<tr>
					<td align="center" width="110px"><a class="lbl">要件</a></td>
					<td align="center" width="120px"><a class="lbl">編號</a></td>
					<td align="center" width="150px"><a class="lbl">中文</a></td>
					<td align="center" width="150px"><a class="lbl">英文</a></td>
					<td align="center" width="150px"><a class="lbl">越文</a></td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">車縫 Đường may</a></td>
					<td align="center" class="groupe no"> </td>
					<td align="center" class="groupe mon"> </td>
					<td align="center" class="groupe memo1"> </td>
					<td align="center" class="groupe memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">車縫線顏色 Màu chỉ may</a></td>
					<td align="center" class="ucolor no"> </td>
					<td align="center" class="ucolor mon"> </td>
					<td align="center" class="ucolor memo1"> </td>
					<td align="center" class="ucolor memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">護片 Phụ kiện</a></td>
					<td align="center" class="groupf no"> </td>
					<td align="center" class="groupf mon"> </td>
					<td align="center" class="groupf memo1"> </td>
					<td align="center" class="groupf memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料1 Da1</a></td>
					<td align="center" class="scolor no"> </td>
					<td align="center" class="scolor mon"> </td>
					<td align="center" class="scolor memo1"> </td>
					<td align="center" class="scolor memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料2 Da2</a></td>
					<td align="center" class="class no"> </td>
					<td align="center" class="class mon"> </td>
					<td align="center" class="class memo1"> </td>
					<td align="center" class="class memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料3 Da3</a></td>
					<td align="center" class="classa no"> </td>
					<td align="center" class="classa mon"> </td>
					<td align="center" class="classa memo1"> </td>
					<td align="center" class="classa memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">皮料4 Da4</a></td>
					<td align="center" class="zinc no"> </td>
					<td align="center" class="zinc mon"> </td>
					<td align="center" class="zinc memo1"> </td>
					<td align="center" class="zinc memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">網烙印 In ép</a></td>
					<td align="center" class="sizea no"> </td>
					<td align="center" class="sizea mon"> </td>
					<td align="center" class="sizea memo1"> </td>
					<td align="center" class="sizea memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">轉印 In ủi</a></td>
					<td align="center" class="source no"> </td>
					<td align="center" class="source mon"> </td>
					<td align="center" class="source memo1"> </td>
					<td align="center" class="source memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">大弓 Gọng</a></td>
					<td align="center" class="groupg no"> </td>
					<td align="center" class="groupg mon"> </td>
					<td align="center" class="groupg memo1"> </td>
					<td align="center" class="groupg memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">中束 Bông</a></td>
					<td align="center" class="grouph no"> </td>
					<td align="center" class="grouph mon"> </td>
					<td align="center" class="grouph memo1"> </td>
					<td align="center" class="grouph memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">座管 Ống yên</a></td>
					<td align="center" class="groupi no"> </td>
					<td align="center" class="groupi mon"> </td>
					<td align="center" class="groupi memo1"> </td>
					<td align="center" class="groupi memo2"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">電鍍 mạ</a></td>
					<td align="center" class="hard no"> </td>
					<td align="center" class="hard mon"> </td>
					<td align="center" class="hard memo1"> </td>
					<td align="center" class="hard memo2"> </td>
				</tr>
				<tr>
					<td align="center" colspan='6'>
						<input id="btnClose_div_ucagroup" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id="div_vccdate" style="position:absolute; top:300px; left:500px; display:none; width:300px; background-color: #FFE7CD; " onmousedown="ucadivmove(event);">
			<table id="table_vccdate" class="table_row" style="width:100%;" cellpadding='1' cellspacing='0' border='1' >
				<tr>
					<td align="center" width="150px"><a class="lbl">月產能</a></td>
					<td align="right"  width="150px" class="mongen"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">日產能</a></td>
					<td align="right" class="daygen"> </td>
				</tr>
				<tr class="odate">
					<td align="center"><a class="lbl">未完工量</a></td>
					<td align="right" class="factnotv"> </td>
				</tr>
				<tr class="date3">
					<td align="center"><a class="lbl">排產週已排量</a></td>
					<td align="right" class="date3orde"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">本月訂單量</a></td>
					<td align="right" class="monmount"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">本次訂單量</a></td>
					<td align="right" class="ordemount"> </td>
				</tr>
				<tr>
					<td align="center"><a class="lbl">預交日試算</a></td>
					<td align="left" class="vccdate"> </td>
				</tr>
				<tr>
					<td align="center" colspan='2'>
						<input id="btnClose_div_vccdate" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_addr2" style="position:absolute; top:244px; left:500px; display:none; width:530px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_addr2" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="width:30px;background-color: #f8d463;" align="center">
						<input class="btn addr2" id="btnAddr_plus" type="button" value='＋' style="width: 30px" />
					</td>
					<td style="width:70px;background-color: #f8d463;" align="center">郵遞區號</td>
					<td style="width:430px;background-color: #f8d463;" align="center">指送地址</td>
				</tr>
				<tr id='addr2_close'>
					<td align="center" colspan='3'>
						<input id="btnClose_div_addr2" type="button" value="確定">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewOdate_r'>Date</a></td>
						<td align="center" style="width:25%"><a id='vewNoa_r'>S/C No.</a></td>
						<td align="center" style="width:40%"><a id='vewComp_r'>Cusomer</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='custno comp,4'>~custno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr style="height: 0px">
						<td style="width: 108px;"> </td>
						<td style="width: 98px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 98px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOdate_r' class="lbl">Date</a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblStype_r' class="lbl">Type</a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblNoa_r' class="lbl">S/C No.</a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td align="center"><input id="btnOrdei" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp_r" class="lbl btn">Company</a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td ><span> </span><a id='lblContract_r' class="lbl">Contract</a></td>
						<td colspan="2"><input id="txtContract" type="text" class="txt c1"/></td>
						<td align="center"><input id="btnOrdem" type="button" style="display: none;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust_r" class="lbl btn">Cusomer</a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPaytype_r' class="lbl">Payment</a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td>
							<select id="combPaytype" class="txt c1" onchange='combPaytype_chg()' > </select>
						</td>
						<td align="center"><input id="btnCredit" type="button" value='' /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel_r' class="lbl">Tel</a></td>
						<td><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax_r' class="lbl">Fax</a></td>
						<td><input id="txtFax" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblAgent_r" class="lbl btn">Agent</a></td>
						<td><input id="txtAgentno" type="text" class="txt c1"/></td>
						<td><input id="txtAgent" type="text" class="txt c1"/></td>
						<td align="center">
							<input id="btnQuat" type="button" value='' />
							<input id="txtQuatno" type="hidden" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr_r' class="lbl">Addr</a></td>
						<td><input id="txtPost" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr" type="text" class="txt c1"/></td>
						<!--<td><span> </span><a id='lblOrdbno' class="lbl"> </a></td>
						<td><input id="txtOrdbno" type="text" class="txt c1"/></td>-->
						<td> </td>
						<td><input id="btnImg" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2_r' class="lbl">Delivery Addr.</a></td>
						<td><input id="txtPost2" type="text" class="txt c1"/></td>
						<td colspan='4'>
							<input id="txtAddr2" type="text" class="txt c1" style="width: 412px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
						<td><input id="btnAddr2" type="button" value='...' style="width: 30px;height: 21px" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPayterms_r' class="lbl">Price Term</a></td>
						<td colspan="2"><select id="cmbPayterms" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTrantype_r' class="lbl">Shipment</a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
						<td><span> </span><a id='lblCasetype_r' class="lbl">Cabinet Type</a></td>
						<td><select id="cmbCasetype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCustorde_r' class="lbl">Cust Order#</a></td>
						<td colspan="2"><input id="txtCustorde" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSales_s" class="lbl btn">Sales</a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" class="txt c2"/>
							<input id="txtSales" type="text" class="txt c3"/>
						</td>
							<td><span> </span><a id='lblCasemount' class="lbl"> </a></td>
						<td><input id="txtCasemount" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCuft_r' class="lbl">Total Cuft</a></td>
						<td colspan="2"><input id="txtCuft" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblCuftnotv' class="lbl"> </a></td>
						<td colspan="2"><input id="txtCuftnotv" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td colspan='2'><input id="txtMoney" type="text" class="txt c1" style="text-align: center;"/></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1"/></td>
						<td><select id="cmbTaxtype" class="txt c1" onchange='sum()' > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td colspan='2'><input id="txtTotal" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td class="totalus"><span> </span><a id='lblTotalus_r' class="lbl">外匯總計</a></td>
						<td class="totalus"><input id="txtTotalus" type="text" class="txt num c1"/></td>
						<!--<td><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td><input id="txtApv" type="text" class="txt c1" disabled="disabled"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblAcc1' class="lbl"> </a></td>
						<td><input id="txtAcc1" type="text" class="txt c1" /></td>
						<td><input id="txtAcc2" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDeposit' class="lbl"> </a></td>
						<td colspan='2'><input id="txtDeposit" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblUmmno' class="lbl"> </a></td>
						<td colspan='2'><input id="txtUmmno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust2_r" class="lbl btn">收款客戶</a></td>
						<td><input id="txtCustno2" type="text" class="txt c1"/></td>
						<td><input id="txtCust2" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFactory_r' class="lbl btn">Factory</a></td>
						<td><input id="txtGdate" type="text" class="txt c1" /></td>
						<td><input id="txtGtime" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblOrdcno_r' class="lbl">採購單號</a></td>
						<td  colspan="2">
							<input id="txtOrdcno" type="text" class="txt c1" />
							<input id="txtMemo2" type="hidden" class="txt c1" /><!--越南訂單號-->
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker_r' class="lbl">Operator</a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td> </td>
						<td colspan="3">
							<input id="chkIsproj" type="checkbox"/>
							<span> </span><a id='lblIsproj_r'>Project</a>
							<input id="chkEnda" type="checkbox"/>
							<span> </span><a id='lblEnda_r'>Closed</a>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel_r'>Cancel</a>
							<input id="btnVccdate" type="button" value="預交日試算" style="display: none;">
							<td><input id="btnOrdc" type="button" value="轉採購單" /></td>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo_r' class='lbl'>Remark</a></td>
						<td colspan='7'>
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblExdate' class="lbl"> </a></td>
						<td><input id="txtDate1" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblIssuedate' class="lbl"> </a></td>
						<td><input id="txtDate2" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWeek' class="lbl"> </a></td>
						<td><input id="txtDate3" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblSoadate' class="lbl"> </a></td>
						<td><input id="txtDate4" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 2415px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:45px;"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" /></td>
					<td align="center" style="width:160px;"><a id='lblProductno_r'>Item No.</a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s_r'>Description</a></td>
					<td align="center" style="width:95px;"><a id='lblMay_r'>車縫線顏色<br>Màu chỉ may</a></td>
					<td align="center" style="width:95px;"><a id='lblDa12_r'>皮料1 Da1<br>皮料2 Da2</a></td>
					<td align="center" style="width:95px;"><a id='lblDa34_r'>皮料3 Da3<br>皮料4 Da4</a></td>
					<td align="center" style="width:95px;"><a id='lblIn_r'>網烙印 In ép<br>轉印 In ủi</a></td>
					<td align="center" style="width:95px;"><a id='lblEle_r'>電鍍<br>mạ</a></td>
					<td align="center" style="width:55px;"><a id='lblUnit_r'>Unit</a></td>
					<td align="center" style="width:85px;"><a id='lblMount_r'>Quantity</a></td>
					<td align="center" style="width:85px;"><a id='lblCost_s_r'>Cost</a></td>
					<td align="center" style="width:40px;"><a id='lblGetprice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPayterms_s'>Price Term</a></td>
					<td align="center" style="width:85px;"><a id='lblPrices_r'>Unit Price</a></td>
					<td align="center" style="width:85px;"><a id='lblBenifit_s'> </a> %</td>
					<td align="center" style="width:100px;"><a id='lblPackway_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblTotal_s_r'>Amount</a></td>
					<td align="center" style="width:85px;"><a id='lblCuft_s'> </a></td>
					<td align="center" style="width:150px;display: none;" class="isimg"><a id='lblImg_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblGemounts'> </a></td>
					<td align="center" style="width:175px;"><a id='lblMemos_r'>Remark</a></td>
					<td align="center" style="width:110px;">
						<a id='lblDateas'> </a><input id='btnGetpdate' type="button" style="width: 50px;font-size: 12px;font-weight: bold;" value="計算">
						<BR><a id='lblPlanpdate_s'>生管預交日</a>
					</td>
					<td align="center" style="width:43px;"><a id='lblEndas_r'>Closed</a></td>
					<td align="center" style="width:43px;"><a id='lblCancels_r'>Cancel</a></td>
					<td align="center" style="width:43px;"><a id='lblBorn'> </a></td>
					<td align="center" style="width:43px;"><a id='lblNeed'> </a></td>
					<td align="center" style="width:43px;"><a id='lblVccrecord'> </a></td>
					<td align="center" style="width:43px;"><a id='lblOrdemount'> </a></td>
					<td align="center" style="width:43px;"><a id='lblScheduled'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td align="center">
						<input class="txt c6" id="txtProductno.*" maxlength='30'type="text" style="width:98%;" />
						<input class="btn" id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
						<input class="txt c6" id="txtNo2.*" type="text" />
						<input class="btn" id="btnUcagroup.*" type="button" value='要件明細' style="font-size: 10px;" />
					</td>
					<td>
						<input class="txt c7" id="txtProduct.*" type="text" />
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td><input id="txtUcolor.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtScolor.*" type="text" class="txt c1"/>
						<input id="txtClass.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtClassa.*" type="text" class="txt c1"/>
						<input id="txtZinc.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtSizea.*" type="text" class="txt c1"/>
						<input id="txtSource.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtHard.*" type="text" class="txt c1"/></td>
					<td align="center"><input class="txt c7" id="txtUnit.*" type="text"/></td>
					<td><input class="txt num c7" id="txtMount.*" type="text" /></td>
					<td><input class="txt num c7" id="txtSprice.*" type="text" /></td>
					<td align="center"><input class="btn" id="btnGetprice.*" type="button" value='.' style=" font-weight: bold;"/></td>
					<td>
						<input id="txtPayterms.*" type="text" class="txt c1"/>
						<input id="txtSize.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtPrice.*" type="text" class="txt num c1"/>
						<!--<input id="txtProfit.*" type="hidden" class="txt c1 num"/>-->
						<input id="txtCommission.*" type="hidden" class="txt c1 num"/>
						<input id="txtInsurance.*" type="hidden" class="txt c1 num"/>
						
						<input id="txtRadius.*" type="text" class="txt num c1"/>
						<!--<input id="txtDime.*" type="hidden" class="txt c1 num"/>-->
						<input id="txtWidth.*" type="hidden" class="txt c1 num"/>
						<input id="txtLengthb.*" type="hidden" class="txt c1 num"/>
					</td>
					<td>
						<input id="txtProfit.*" type="text" class="txt c1 num"/>
						<input id="txtDime.*" type="text" class="txt c1 num"/>
					</td>
					<td>
						<input id="txtPackwayno.*" type="text" class="txt c1" style="width: 60%;"/>
						<input class="btn" id="btnPackway.*" type="button" value='.' style=" font-weight: bold;"/>
						<input id="txtPackway.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input class="txt num c7" id="txtTotal.*" type="text" />
						<input class="txt num c7" id="txtBenifit.*" type="text" style="display: none;" />
					</td>
					<td><input class="txt num c7" id="txtCuft.*" type="text" /></td>
					<td class="isimg" style="display: none;"><img id="images.*" style="width: 150px;"></td>
					<td>
						<input class="txt num c1" id="txtC1.*" type="text" />
						<input class="txt num c1" id="txtNotv.*" type="text" />
					</td>
					<td>
						<input class="txt c7" id="txtMemo.*" type="text" />
						<input class="txt" id="txtQuatno.*" type="text" style="width: 70%;" />
						<input class="txt" id="txtNo3.*" type="text" style="width: 20%;"/>
						<input id="recno.*" type="hidden" />
					</td>
					<td>
						<input class="txt c7" id="txtDatea.*" type="text" />
						<input class="txt c7" id="txtIndate.*" type="text" />
					</td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td align="center"><input id="chkCancel.*" type="checkbox"/></td>
					<td align="center"><input class="btn" id="btnBorn.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnNeed.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnVccrecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnOrdemount.*" type="button" value='.' style=" font-weight: bold;" /></td>
					<td align="center"><input class="btn" id="btnScheduled.*" type="button" value='.' style=" font-weight: bold;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>