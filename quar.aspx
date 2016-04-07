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
			q_copy=1;
			q_desc = 1;
			q_tables = 's';
			var q_name = "quar";
			var decbbs = ['price', 'weight', 'mount', 'total', 'dime', 'width', 'lengthb', 'c1', 'notv', 'theory'];
			var decbbm = ['money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'totalus'];
			var q_readonly = ['txtNoa','txtWorker', 'txtComp', 'txtAcomp', 'txtSales','txtTotal','txtTotalus', 'txtWorker2'
			,'txtMount','txtWeight','txtCost','txtBenifit','txtCasemount','txtCuft','txtCuftnotv'];
			var q_readonlys = ['txtNo3','txtPackway','txtPackwayno','txtCost','txtBenifit','txtPayterms','txtBenifit2','txtPayterms2'];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 16;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucx', 'noa,product,unit,spec,cost', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_,txtCost_,txtPrice_', 'ucx_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,nick','txtCustno,txtComp', 'cust_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtAgentno', 'lblAgent', 'cust', 'noa,nick','txtAgentno,txtAgent', 'cust_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}

			function sum() {
				var t1 = 0, t_unit, t_mount=0, t_weight = 0, t_total = 0,t_cost=0,t_benifit=0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_mount = q_add(t_mount, q_float('txtMount_' + j));
					t_weight = q_add(t_weight, q_float('txtWeight_' + j));
					t_total = q_add(t_total, q_float('txtTotal_' + j));
					t_cost=q_add(t_cost, q_mul(q_float('txtCost_' + j),q_float('txtMount_' + j)));
					
					$('#txtBenifit_'+j).val(round(q_sub(q_mul(q_float('txtPrice_' + j),q_float('txtMount_' + j)),q_mul(q_float('txtCost_' + j),q_float('txtMount_' + j))),0));
					$('#txtBenifit2_'+j).val(round(q_sub(q_mul(q_float('txtPrice2_' + j),q_float('txtMount_' + j)),q_mul(q_float('txtCost_' + j),q_float('txtMount_' + j))),0));
				}
				q_tr('txtMount', t_mount);
				q_tr('txtWeight',t_weight);
				q_tr('txtTotal', t_total);
				q_tr('txtTotalus', q_mul(q_float('txtTotal'), q_float('txtFloata')));
				t_cost=q_add(t_cost,q_float('txtBankfee'));
				t_cost=q_add(t_cost,q_float('txtCustomsfee'));
				t_cost=q_add(t_cost,q_float('txtPortfee'));
				t_cost=q_add(t_cost,q_float('txtTranfee'));
				t_cost=q_add(t_cost,q_float('txtVisafee'));
				t_cost=q_add(t_cost,q_float('txtBillfee'));
				t_cost=q_add(t_cost,q_float('txtCertfee'));
				t_cost=q_add(t_cost,q_float('txtOthfee'));
				q_tr('txtCost', round(t_cost,0));
				t_benifit=q_sub(t_total,t_cost);
				q_tr('txtBenifit', round(t_benifit,0));
				cufttotal();
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
			
			var SeekF = new Array();
			var t_imgshow=false;
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
				q_mask(bbmMask);
				bbmNum = [['txtTotal', 15, 0, 1],['txtTotalus', 15, 2, 1], ['txtFloata', 11, 5, 1],['txtMount', 15, q_getPara('vcc.mountPrecision'), 1],['txtWeight', 15, q_getPara('vcc.weightPrecision'), 1]
				,['txtCost', 15, 0, 1],['txtBenifit', 15, 0, 1],['txtBankfee', 15, 0, 1],['txtCustomsfee', 15, 0, 1],['txtPortfee', 15, 0, 1],['txtTranfee', 15, 0, 1],['txtVisafee', 15, 0, 1],['txtBillfee', 15, 0, 1],['txtCertfee', 15, 0, 1],['txtOthfee', 15, 0, 1]
				];//,['txtProfit', 10, 2, 1],['txtInsurance', 10, 2, 1],['txtCommission', 10, 2, 1]
				bbsNum = [['txtMount', 10, q_getPara('vcc.mountPrecision'), 1],['txtMount', 10, q_getPara('vcc.weightPrecision'), 1]
				, ['txtPrice', 10, q_getPara('vcc.pricePrecision'), 1]	, ['txtPrice2', 10, q_getPara('vcc.pricePrecision'), 1]	
				, ['txtCost', 10, q_getPara('vcc.pricePrecision'), 1]	, ['txtTotal', 15, 0, 1], ['txtBenifit', 15, 0, 1], ['txtBenifit2', 15, 0, 1]];
				
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				//q_cmbParse("cmbPayterms", q_getPara('sys.payterms'),'s');
				q_cmbParse("combPayterms", q_getPara('sys.payterms'));
				q_cmbParse("combPayterms2", q_getPara('sys.payterms'));
				
				q_cmbParse("cmbCasetype", "20',40'" );
				
				var t_where = "where=^^ 1=0 ^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");

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
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
				
				$('#chkCancel').click(function(){
					if($(this).prop('checked')){
						for(var k=0;k<q_bbsCount;k++){
							$('#chkCancel_'+k).prop('checked',true);
						}
					}
				});
				
				$('.fee').change(function() {
					sum();
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
				
				$('#cmbCasetype').change(function() {
					cufttotal();
				});
				
				//div 事件
				$('#btnClose_div_getprice').click(function() {
					$('#div_getprice').hide();
				});
				
				$('#btnOk_div_getprice').click(function() {
					//回寫單價
					if(q_cur==1 || q_cur==2){
						$('#txtPrice_'+$('#textNoq').val()).val($('#textCost3').val());
						$('#txtCost_'+$('#textNoq').val()).val($('#textCost').val());
						$('#txtWeight_'+$('#textNoq').val()).val($('#textWeight').val());
						$('#txtPackwayno_'+$('#textNoq').val()).val($('#textPackwayno').val());
						$('#txtPackway_'+$('#textNoq').val()).val($('#textPackway').val());
						$('#txtTotal_'+$('#textNoq').val()).val(round(q_mul(dec($('#txtMount_'+$('#textNoq').val()).val()),dec($('#txtPrice_'+$('#textNoq').val()).val())),0));
						$('#txtPayterms_'+$('#textNoq').val()).val($('#combPayterms').val());
						
						$('#txtProfit_'+$('#textNoq').val()).val($('#textProfit').val());
						$('#txtInsurance_'+$('#textNoq').val()).val($('#textInsurance').val());
						$('#txtCommission_'+$('#textNoq').val()).val($('#textCommission').val());
						
						//--------------------------------------------------------
						$('#txtPrice2_'+$('#textNoq').val()).val($('#textCost32').val());
						$('#txtPayterms2_'+$('#textNoq').val()).val($('#combPayterms2').val());
						
						$('#txtProfit2_'+$('#textNoq').val()).val($('#textProfit2').val());
						$('#txtInsurance2_'+$('#textNoq').val()).val($('#textInsurance2').val());
						$('#txtCommission2_'+$('#textNoq').val()).val($('#textCommission2').val());
						
						sum();
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
					$('#textProfitmoney').val(round(q_mul(cost2,q_div(profit,100)),3));
					$('#textInsurmoney').val(round(q_mul(cost2,q_div(insurance,100)),3));
					$('#textCommimoney').val(round(q_mul(cost2,q_div(commission,100)),3));
					
					var profit2=$('#textProfit2').val();
					var insurance2=$('#textInsurance2').val();
					var commission2=$('#textCommission2').val();
					
					$('#textProfitmoney2').val(round(q_mul(cost2,q_div(profit2,100)),3));
					$('#textInsurmoney2').val(round(q_mul(cost2,q_div(insurance2,100)),3));
					$('#textCommimoney2').val(round(q_mul(cost2,q_div(commission2,100)),3));
					
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
					$('#textProfitmoney').val(round(q_mul(cost2,q_div(profit,100)),3));
					divpaytermschange();
				});
				
				$('#textProfit2').change(function() {
					var profit2=$('#textProfit2').val();
					var cost2=dec($('#textCost2').val());
					$('#textProfitmoney2').val(round(q_mul(cost2,q_div(profit2,100)),3));
					divpaytermschange();
				});
				
				$('#textInsurance').change(function() {
					var insurance=$('#textInsurance').val();
					var cost2=dec($('#textCost2').val());
					$('#textInsurmoney').val(round(q_mul(cost2,q_div(insurance,100)),3));
					divpaytermschange();
				});
				
				$('#textInsurance2').change(function() {
					var insurance2=$('#textInsurance2').val();
					var cost2=dec($('#textCost2').val());
					$('#textInsurmoney2').val(round(q_mul(cost2,q_div(insurance2,100)),3));
					divpaytermschange();
				});
				
				$('#textCommission').change(function() {
					var commission=$('#textCommission').val();
					var cost2=dec($('#textCost2').val());
					$('#textCommimoney').val(round(q_mul(cost2,q_div(commission,100)),3));
					
					divpaytermschange();
				});
				
				$('#textCommission2').change(function() {
					var commission2=$('#textCommission2').val();
					var cost2=dec($('#textCost2').val());
					$('#textCommimoney2').val(round(q_mul(cost2,q_div(commission2,100)),3));
					divpaytermschange();
				});
				
				$('#combPayterms').change(function() {
					if(!emp($('#txtAgentno').val()) && !emp($('#txtProductno_'+$('#textNoq').val()).val()) && !emp($('#combPayterms').val())){
						var t_where = "where=^^ a.custno='"+$('#txtAgentno').val()+"' and b.xproductno='"+$('#txtProductno_'+$('#textNoq').val()).val()+"' and a.payterms='"+$('#combPayterms').val()+"' and '"+$('#txtOdate').val()+"'>=a.bdate order by bdate desc,noa desc ^^";
						q_gt('custprices', t_where, 0, 0, 0, "getcustprices", r_accy, 1);
						var as = _q_appendData("custprices", "", true);
						if (as[0] != undefined) {
							$('#textCommission').val(as[0].commission);
						}
					}
					divpaytermschange();
				});
				
				$('#combPayterms2').change(function() {
					if(!emp($('#txtAgentno').val()) && !emp($('#txtProductno_'+$('#textNoq').val()).val()) && !emp($('#combPayterms2').val())){
						var t_where = "where=^^ a.custno='"+$('#txtAgentno').val()+"' and b.xproductno='"+$('#txtProductno_'+$('#textNoq').val()).val()+"' and a.payterms='"+$('#combPayterms2').val()+"' and '"+$('#txtOdate').val()+"'>=a.bdate order by bdate desc,noa desc ^^";
						q_gt('custprices', t_where, 0, 0, 0, "getcustprices", r_accy, 1);
						var as = _q_appendData("custprices", "", true);
						if (as[0] != undefined) {
							$('#textCommission2').val(as[0].commission);
						}
					}
					divpaytermschange();
				});
				
				$('#textMount').change(function() {
					var t_weight=0;
					var t_mount=dec($('#textMount').val());
					var t_uweight=dec($('#textUweight').val());
					var t_inmount=dec($('#textInmount').val());
					var t_outmount=dec($('#textOutmount').val());
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
					var t_inmount=dec($('#textInmount').val());
					var t_outmount=dec($('#textOutmount').val());
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
			}
			
			function divtrantypechange(){
				var t_cost=dec($('#textCost').val());
				if($('[name="trantype"]:checked').val()=='cy'){
					var cyprice=dec($('#textCyprice').val());
					var cycbm=dec($('#textCycbm').val());
					var cbm=dec($('#textCbm').val());
					var t_ctnmount=q_mul(dec($('#textInmount').val()),dec($('#textOutmount').val()));//一箱多少產品
					var t_cbmmount=cbm==0?0:q_mul(Math.ceil(q_div(cycbm,cbm)),t_ctnmount); //一櫃可裝多少產品
					var unitprice=t_cbmmount==0?0:round(q_div(cyprice,t_cbmmount),3); //平均一產品成本
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
						$('#textTranprice').val(round(q_div(q_mul(cuftprice,cuft),t_ctnmount),3));
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
				}
				$('#textCost3').val(cost3);
				//-------------------------------------------------------------------------------------------------	
				var profit2=$('#textProfit2').val();
				var insurance2=$('#textInsurance2').val();
				var commission2=$('#textCommission2').val();
				var payterms2= $('#combPayterms2').val();
				var cost32=0
				switch (payterms2) {//P利潤 I保險 C佣金 F運費
					case 'C＆F'://(成本/(1-P)+F) //=CFR   
						cost32=round(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit2,100))),tranprice),precision);
						break;
					case 'C＆F＆C'://(成本/(1-P)+F)/(1-C)
						cost32=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit2,100))),tranprice),q_sub(1,q_div(commission2,100))),precision);
						break;
					case 'C＆I': //成本/(1-P)/(1-I)
						cost32=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit2,100))),q_sub(1,q_div(insurance2,100))),precision);
						break;
					case 'C＆I＆C'://成本/(1-P)/(1-I)/(1-C)
						cost32=round(q_div(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit2,100))),q_sub(1,q_div(insurance2,100))),q_sub(1,q_div(commission2,100))),precision);
						break;
					case 'CIF'://(成本/(1-P)+F)/(1-I)   
						cost32=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit2,100))),tranprice),q_sub(1,q_div(insurance2,100))),precision);
						break;
					case 'CIF＆C'://(成本/(1-P)+F)/(1-I)/(1-C)
						cost32=round(q_div(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit2,100))),tranprice),q_sub(1,q_div(insurance2,100))),q_sub(1,q_div(commission2,100))),precision);
						break;
					case 'EXW'://成本/(1-P)
						cost32=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit2,100))),precision);
						break;
					case 'FOB'://成本/(1-P)
						cost32=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit2,100))),precision);
						break;
					case 'FOB＆C': //成本/(1-P)/(1-C)
						cost32=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit2,100))),q_sub(1,q_div(commission2,100))),precision);
						break;
				}
				$('#textCost32').val(cost32);
			}
			
			function imgshowhide() {
				for(var i=0;i<q_bbsCount;i++){
					if(!$('.isimg').is(':hidden')){
						if(!emp($('#txtProductno_'+i).val())){
							var t_where = "where=^^ noa='" + $('#txtProductno_'+i).val() + "' ^^";
							q_gt('ucx', t_where, 0, 0, 0, "",r_accy,1);
							var as = _q_appendData("ucx", "", true);
							if (as[0] != undefined) {
								var imagename=as[0].images.split(';');
								if(imagename[0]!=''){
									imagename.sort();
									for (var j=0 ;j<imagename.length;j++){
										if(imagename[j]!=''){
											$('#images_'+i).attr('src', "../images/upload/"+$('#txtProductno_'+i).val()+'_'+imagename[j]+"?"+new Date());
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
					case 'pack2':
						ret = getb_ret();
						if (ret != undefined) {
							$('#txtPackwayno_'+b_seq).val(ret[0].packway);
							$('#txtPackway_'+b_seq).val(ret[0].pack);
							
							//計算重量
							var t_weight=0;
							var t_mount=dec($('#txtMount_'+b_seq).val());
							var t_uweight=dec(ret[0].uweight);
							var t_inmount=dec(ret[0].inmount);
							var t_outmount=dec(ret[0].outmount);
							var t_inweight=dec(ret[0].inweight);
							var t_outweight=dec(ret[0].outweight);
							var t_cuft=dec(ret[0].cuft);
							var t_pfmount=q_mul(t_inmount,t_outmount)==0?0:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
							var t_pcmount=q_mul(t_inmount,t_outmount)==0?0:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
							var t_emount=q_sub(t_mount,q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
							t_weight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
							t_weight=q_mul(t_pfmount,t_weight); //整箱毛重
							if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
								var tt_weight=q_mul(t_emount,t_uweight);
								tt_weight=q_add(tt_weight,t_outweight);
								tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
								t_weight=q_add(t_weight,tt_weight);
							}
							$('#txtWeight_'+b_seq).val(t_weight);
							$('#txtCuft_'+b_seq).val(q_mul(t_cuft,t_pcmount));
						}
						cufttotal();
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
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

			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCust')], ['txtOdate', q_getMsg('lblOdate')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
					}
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				if (q_cur == 2)
					$('#txtWorker2').val(r_name);
					
				sum();

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_quar') + (!emp($('#txtDatea').val())?$('#txtDatea').val():q_date()), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;

				q_box('quar_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
				var cmb = document.getElementById("combPay")
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
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnMinus_' + j).click(function() {
							sum();
						});
						$('#txtUnit_' + j).change(function() {
							sum();
						});
						$('#txtMount_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							$('#txtTotal_'+b_seq).val(round(q_mul(dec($('#txtMount_'+b_seq).val()),dec($('#txtPrice_'+b_seq).val())),0));
							sum();
						});
						$('#txtWeight_' + j).change(function () {
							sum();
						});
						$('#txtPrice_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							$('#txtTotal_'+b_seq).val(round(q_mul(dec($('#txtMount_'+b_seq).val()),dec($('#txtPrice_'+b_seq).val())),0));
							sum();
						});
						
						$('#txtTotal_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							sum();
						});
						
						$('#btnVccrecord_' + j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//t_where = "cust='" + $('#txtCustno').val() + "' and noq='" + $('#txtProductno_' + b_seq).val() + "'";
							t_where = "custno='" + $('#txtCustno').val() + "' and comp='" + $('#txtComp').val() + "' and productno='" + $('#txtProductno_' + b_seq).val() + "' and product='" + $('#txtProduct_' + b_seq).val() + "'";
							q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
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
								q_gt('ucx', t_where, 0, 0, 0, "getucx", r_accy, 1);
								var as = _q_appendData("ucx", "", true);
								if (as[0] != undefined) {
									$('#textCost').val($('#txtCost_'+b_seq).val());
									$('#textUweight').val(as[0].uweight);
								}else{
									$('#textCost').val($('#txtCost_'+b_seq).val());
									$('#textUweight').val('');
								}
								$('#textPackwayno').val($('#txtPackwayno_'+b_seq).val());
								$('#textPackway').val($('#txtPackway_'+b_seq).val());
								var t_where = "where=^^ noa='"+$('#textProductno').val()+"' and packway='"+$('#textPackwayno').val()+"' ^^";
								q_gt('pack2s', t_where, 0, 0, 0, "getpack2s", r_accy, 1);
								var as = _q_appendData("pack2s", "", true);
								if (as[0] != undefined) {
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
								$('#combPayterms').val($('#txtPayterms_'+b_seq).val());
								$('#textProfit').val($('#txtProfit_'+b_seq).val());
								$('#textInsurance').val($('#txtInsurance_'+b_seq).val());
								$('#textCommission').val($('#txtCommission_'+b_seq).val());
								
								$('#combPayterms2').val($('#txtPayterms2_'+b_seq).val());
								$('#textProfit2').val($('#txtProfit2_'+b_seq).val());
								$('#textInsurance2').val($('#txtInsurance2_'+b_seq).val());
								$('#textCommission2').val($('#txtCommission2_'+b_seq).val());
								
								$('#textMount').change();
								$('#textCost').change();
								$('#div_getprice').css('top', e.pageY- $('#div_getprice').height());
								$('#div_getprice').css('left', e.pageX - $('#div_getprice').width());
								
								$('#div_getprice').show();
							}
						});
						
						$('#btnPackway_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							t_where = "noa='" + $('#txtProductno_'+b_seq).val() + "'";
							q_box("pack2_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack2', "95%", "95%", '包裝方式');
						});
					}
				}
				_bbsAssign();
				HiddenField();
			}

			function btnIns() {
				_btnIns();
								
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtDatea').val(q_cdn(q_date(), 3));
				
				$('#txtDatea').focus();

				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
					q_box('z_quarp.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['odate'] = abbm2['odate'];
				as['custno'] = abbm2['custno'];
				as['apv'] = abbm2['apv'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				HiddenField();
				$('#div_getprice').hide();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#combAddr').attr('disabled', 'disabled');
				} else {
					$('#combAddr').removeAttr('disabled');
				}
			}
			
			function HiddenField(){
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
				if (q_tables == 's')
					bbsAssign();
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

			function q_popPost(s1) {
				switch (s1) {
					case 'txtCustno':
						if (!emp($('#txtCustno').val())) {
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('cust', t_where, 0, 0, 0, "getcust",r_accy,1);
							var as = _q_appendData("cust", "", true);
							if (as[0] != undefined) {
								$('#txtPaytype').val(as[0].paytype);
								$('#cmbTrantype').val(as[0].trantype);
								$('#txtTel').val(as[0].tel);
								$('#txtFax').val(as[0].fax);
								$('#txtPost').val(as[0].zip_comp);
								$('#txtAddr').val(as[0].addr_comp);
								$('#txtProfit').val(as[0].profit);
								$('#txtConn').val(as[0].conn);
								$('#txtSalesno').val(as[0].salesno);
								$('#txtSales').val(as[0].sales);
							}
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custm', t_where, 0, 0, 0, "getcustm",r_accy,1);
							var as = _q_appendData("custm", "", true);
							if (as[0] != undefined) {
								//$('#cmbPayterms').val(as[0].payterms);
								$('#txtAgentno').val(as[0].agentno);
								$('#txtAgent').val(as[0].agent);
							}
							
							$('#txtBdock').focus();
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						break;
					case 'txtProductno_':
						imgshowhide();
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
				/*width: 10%;*/
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
			.txt.c4 {
				width: 25%;
				float: left;
			}
			.txt.c5 {
				width: 72%;
				float: left;
			}
			.txt.c6 {
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
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
			.tbbm td input[type="button"] {
				width: auto;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			input[type="text"], input[type="button"] ,select{
				font-size: medium;
			}
		</style>
	</head>
	<body>
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
					<td align="center"><a class="lbl">試算總重量</a></td>
					<td align="center"><input id="textWeight" type="text" class="txt num c1"/></td>
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
					<td align="center">單價1</td>
					<td colspan="5"> </td>
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
				<tr style="background-color: #EC7DD2;">
					<td align="center"><a class="lbl">價格條件</a></td>
					<td align="center"><select id="combPayterms" class="txt c1"> </select></td>
					<td align="center"><a class="lbl">試算單價</a></td>
					<td align="center"><input id="textCost3" type="text" class="txt num c1"/></td>
					<td align="center"> </td>
					<td align="center"> </td>
				</tr>
				
				<tr style="background-color: #52FDAC; ">
					<td align="center">單價2</td>
					<td align="center" colspan="5"> </td>
				</tr>
				<tr style="background-color: #52FDAC; ">
					<td align="center"><a class="lbl">Profit</a></td>
					<td align="center"><input id="textProfit2" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
					<td align="center"><a class="lbl">Insurance</a></td>
					<td align="center"><input id="textInsurance2" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
					<td align="center"><a class="lbl">Commission</a></td>
					<td align="center"><input id="textCommission2" type="text" class="txt num c1" style="width: 70%"/>&nbsp; %</td>
				</tr>
				<tr style="background-color: #52FDAC;display: none;">
					<td align="right"><a class="lbl">$</a></td>
					<td align="center"><input id="textInsurmoney2" type="text" class="txt num c1"/></td>
					<td align="right"><a class="lbl">$</a></td>
					<td align="center"><input id="textCommimoney2" type="text" class="txt num c1"/></td>
					<td align="right"><a class="lbl">$</a></td>
					<td align="center"><input id="textProfitmoney2" type="text" class="txt num c1"/></td>
				</tr>
				<tr style="background-color: #52FDAC;">
					<td align="center"><a class="lbl">價格條件</a></td>
					<td align="center"><select id="combPayterms2" class="txt c1"> </select></td>
					<td align="center"><a class="lbl">試算單價</a></td>
					<td align="center"><input id="textCost32" type="text" class="txt num c1"/></td>
					<td align="center"> </td>
					<td align="center"> </td>
				</tr>
				
				<tr style="background-color: #F1A0A2;">
					<td align="center" colspan='6'>
						<input id="btnOk_div_getprice" type="button" value="取回單價/重量">
						<input id="btnClose_div_getprice" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1270px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='custno comp,4'>~custno ~comp,4</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" style="width: 872px;">
					<tr style="height: 1px;">
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="3"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td colspan="3"><input id="txtContract" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblAgent' class="lbl btn"> </a></td>
						<td><input id="txtAgentno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAgent" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="3"><input id="txtTel"	type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input id="txtFax" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblConn' class="lbl"> </a></td>
						<td><input id="txtConn" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td><input id="txtPost" type="text" class="txt c1"></td>
						<td colspan='6' ><input id="txtAddr" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td><input id="txtPost2" type="text" class="txt c1"/></td>
						<td colspan='6' >
							<input id="txtAddr2" type="text" class="txt c1" style="width: 625px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
						<td><span> </span><a id='lblBdock' class="lbl"> </a></td>
						<td colspan="2"><input id="txtBdock" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblEdock' class="lbl"> </a></td>
						<td colspan="2"><input id="txtEdock" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<!--<td><span> </span><a id='lblPayterms' class="lbl"> </a></td>
						<td><select id="cmbPayterms" class="txt c1"> </select></td>-->
						<!--<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td colspan="2"><input id="txtPrice" type="text" class="txt c1 num"/></td>-->
						<!--<td><span> </span><a id='lblVia' class="lbl"> </a></td>
						<td colspan="2"><input id="txtVia" type="text" class="txt c1"/></td>-->
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td>
							<input id="txtPaytype" type="text" class="txt c1" style="width: 80px;"/>
							<select id="combPaytype" class="txt c1" onchange='combPay_chg()' style="width: 25px;"> </select>
						</td>
						<td><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td><input id="txtSalesno" type="text" class="txt c1"/></td>
						<td><input id="txtSales" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td align="right"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan='7' >
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
						</td>
					</tr>
					<tr>
						<!--<td><span> </span><a id='lblProfit' class="lbl"> </a></td>
						<td><input id="txtProfit" type="text" class="txt c5 num"/><a>&nbsp; %</a></td>-->
						<!--<td><span> </span><a id='lblInsurance' class="lbl"> </a></td>
						<td><input id="txtInsurance" type="text" class="txt c5 num" /><a>&nbsp; %</a></td>-->
						<!--<td><span> </span><a id='lblCommission' class="lbl"> </a></td>
						<td><input id="txtCommission" type="text" class="txt c5 num"/><a>&nbsp; %</a></td>-->
						<td><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td><input id="txtTotalus"	type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCasetype' class="lbl"> </a></td>
						<td><select id="cmbCasetype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblCasemount' class="lbl"> </a></td>
						<td><input id="txtCasemount" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblCuft' class="lbl"> </a></td>
						<td><input id="txtCuft" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblCuftnotv' class="lbl"> </a></td>
						<td><input id="txtCuftnotv" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBankfee' class="lbl"> </a></td>
						<td><input id="txtBankfee" type="text" class="txt c1 num fee"/></td>
						<td><span> </span><a id='lblCustomsfee' class="lbl"> </a></td>
						<td><input id="txtCustomsfee"	 type="text" class="txt c1 num fee"/></td>
						<td><span> </span><a id='lblPortfee' class="lbl"> </a></td>
						<td><input id="txtPortfee" type="text" class="txt c1 num fee"/></td>
						<td><span> </span><a id='lblTranfee' class="lbl"> </a></td>
						<td><input id="txtTranfee" type="text" class="txt c1 num fee"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblVisafee' class="lbl"> </a></td>
						<td><input id="txtVisafee" type="text" class="txt c1 num fee"/></td>
						<td><span> </span><a id='lblBillfee' class="lbl"> </a></td>
						<td><input id="txtBillfee" type="text" class="txt c1 num fee"/></td>
						<td><span> </span><a id='lblCertfee' class="lbl"> </a></td>
						<td><input id="txtCertfee" type="text" class="txt c1 num fee"/></td>
						<td><span> </span><a id='lblOthfee' class="lbl"> </a></td>
						<td><input id="txtOthfee" type="text" class="txt c1 num fee"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCost' class="lbl"> </a></td>
						<td colspan='3'><input id="txtCost" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id='lblBenifit' class="lbl"> </a></td>
						<td colspan='3'><input id="txtBenifit"	type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td colspan="3">
							<input id="chkIsproj" type="checkbox"/>
							<span> </span><a id='lblIsproj'> </a>
							<input id="chkEnda" type="checkbox"/>
							<span> </span><a id='lblEnda'> </a>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'> </a>
							<input id="btnImg" type="button" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1830px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;"><input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" /></td>
					<td align="center" style="width:40px;"><a id='lblNo3_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCost_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblGetprice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPayterms_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a><BR></td>
					<td align="center" style="width:100px;"><a id='lblBenifit_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPackway_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblCuft_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:150px;display: none;" class="isimg"><a id='lblImg_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblEnda_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblCancel_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><input id="txtNo3.*" type="text" class="txt c1" /></td>
					<td align="center">
						<input id="txtProductno.*" type="text" class="txt c1" style="width: 80%;" />
						<input class="btn" id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtCost.*" type="text" class="txt c1 num"/>
						
						<input id="txtProfit.*" type="hidden" class="txt c1 num"/>
						<input id="txtCommission.*" type="hidden" class="txt c1 num"/>
						<input id="txtInsurance.*" type="hidden" class="txt c1 num"/>
						<input id="txtProfit2.*" type="hidden" class="txt c1 num"/>
						<input id="txtCommission2.*" type="hidden" class="txt c1 num"/>
						<input id="txtInsurance2.*" type="hidden" class="txt c1 num"/>
					</td>
					<td align="center"><input class="btn" id="btnGetprice.*" type="button" value='.' style=" font-weight: bold;"/></td>
					<td><!--<select id="cmbPayterms.*" class="txt c1"> </select>-->
						<input id="txtPayterms.*" type="text" class="txt c1"/>
						<input id="txtPayterms2.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtPrice.*" type="text" class="txt c1 num"/>
						<input id="txtPrice2.*" type="text" class="txt c1 num"/>
					</td>
					<td>
						<input id="txtBenifit.*" type="text" class="txt c1 num"/>
						<input id="txtBenifit2.*" type="text" class="txt c1 num"/>
					</td>
					<td>
						<input id="txtPackwayno.*" type="text" class="txt c1" style="width: 60%;"/>
						<input class="btn" id="btnPackway.*" type="button" value='.' style=" font-weight: bold;"/>
						<input id="txtPackway.*" type="text" class="txt isSpec c1"/>
					</td>
					<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtCuft.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtTotal.*" type="text" class="txt c1 num"/></td>
					<td class="isimg" style="display: none;"><img id="images.*" style="width: 150px;"></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
					<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
					<td align="center"><input id="chkCancel.*" type="checkbox"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
