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
			var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3', 'txtC1', 'txtNotv','txtPackwayno','txtPackway','txtSprice','txtBenifit','txtPayterms'];
			var bbmNum = [['txtTotal', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1],['txtFloata', 10, 5, 1], ['txtTotalus', 15, 2, 1], ['txtDeposit', 15, 0, 1],['txtCuft', 15, 2, 1]];
			var bbsNum = [['txtCuft', 15, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'odate';
			brwCount2 = 13;
			
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucaucc2', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_', 'ucaucc2_b.aspx'],
				['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,nick,paytype,trantype,tel,fax,zip_comp,addr_fact', 'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx'],
				['ordb_txtTggno_', '', 'tgg', 'noa,comp', 'ordb_txtTggno_,ordb_txtTgg_', ''],
				['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
				['txtAgentno', 'lblAgent', 'cust', 'noa,nick','txtAgentno,txtAgent', 'cust_b.aspx'],
				['txtGdate', 'lblFactory', 'factory', 'noa,factory', 'txtGdate,txtGtime', 'factory_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no2'];
				q_brwCount();
				if(q_content.length>0){
					q_content="where=^^ stype='3' and "+replaceAll(q_content,"where=^^",'');
				}else{
					q_content="where=^^ stype='3' ^^ "
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
						$('#txtTotal_' + j).val(round(q_mul(dec($('#txtPrice_' + j).val()), dec(t_mount)), 0));
	
						q_tr('txtNotv_' + j, q_sub(q_float('txtMount_' + j), q_float('txtC1' + j)));
						t1 = q_add(t1, dec($('#txtTotal_' + j).val()));
					}
					$('#txtMoney').val(round(t1, 0));
					if (!emp($('#txtPrice').val()))
						$('#txtTranmoney').val(round(q_mul(t_weight, dec($('#txtPrice').val())), 0));
					// $('#txtWeight').val(round(t_weight, 0));
					q_tr('txtTotal', q_add(t1, dec($('#txtTax').val())));
					q_tr('txtTotalus', q_mul(q_float('txtMoney'), q_float('txtFloata')));
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
				bbmMask = [['txtOdate', r_picd]];
				q_mask(bbmMask);
				bbsMask = [['txtDatea', r_picd]];
				bbsNum = [['txtPrice', 12, q_getPara('vcc.pricePrecision'), 1], ['txtMount', 9, q_getPara('vcc.mountPrecision'), 1], ['txtTotal', 15, 0, 1]
				, ['txtBenifit', 15, 0, 1],['txtC1', 10, q_getPara('vcc.mountPrecision'), 1], ['txtNotv', 10, q_getPara('vcc.mountPrecision'), 1], ['txtSprice', 10, q_getPara('vcc.pricePrecision'), 1]];
				q_cmbParse("cmbStype", q_getPara('orde.stype'));
				//q_cmbParse("cmbCoin", q_getPara('sys.coin'));
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
				q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
				q_cmbParse("combPayterms", q_getPara('sys.payterms'));
				
				q_cmbParse("cmbCasetype", "20',40'" );

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
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});

				$('#btnCredit').click(function() {
					if (!emp($('#txtCustno').val())) {
						q_box("z_credit.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";custno='" + $('#txtCustno').val() + "';" + r_accy + ";" + q_cur, 'ordei', "95%", "95%", q_getMsg('btnCredit'));
					}
				});
				
				$('#txtGdate').change(function() {
					for(var i=0;i<q_bbsCount;i++){
						getpdate(i);
					}
				});
				
				$('#cmbCasetype').change(function() {
					cufttotal();
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
						$('#txtTotal_'+$('#textNoq').val()).val(round(q_mul(dec($('#txtMount_'+$('#textNoq').val()).val()),dec($('#txtPrice_'+$('#textNoq').val()).val())),0));
						$('#txtPayterms_'+$('#textNoq').val()).val($('#combPayterms').val());
						
						$('#txtProfit_'+$('#textNoq').val()).val($('#textProfit').val());
						$('#txtInsurance_'+$('#textNoq').val()).val($('#textInsurance').val());
						$('#txtCommission_'+$('#textNoq').val()).val($('#textCommission').val());
						
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
				
				$('#textInsurance').change(function() {
					var insurance=$('#textInsurance').val();
					var cost2=dec($('#textCost2').val());
					$('#textInsurmoney').val(round(q_mul(cost2,q_div(insurance,100)),3));
					divpaytermschange();
				});
				
				$('#textCommission').change(function() {
					var commission=$('#textCommission').val();
					var cost2=dec($('#textCost2').val());
					$('#textCommimoney').val(round(q_mul(cost2,q_div(commission,100)),3));
					divpaytermschange();
				});
				
				$('#combPayterms').change(function() {
					if(!emp($('#txtCustno').val()) && !emp($('#txtProductno_'+$('#textNoq').val()).val()) && !emp($('#combPayterms').val())){
						var t_where = "where=^^ a.custno='"+$('#txtCustno').val()+"' and a.productno='"+$('#txtProductno_'+$('#textNoq').val()).val()+"' and a.payterms='"+$('#combPayterms').val()+"' and '"+$('#txtOdate').val()+"'>=a.bdate order by bdate desc,noa desc ^^";
						q_gt('custprices', t_where, 0, 0, 0, "getcustprices", r_accy, 1);
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
							ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtPrice,txtMount,txtQuatno,txtNo3,txtPackwayno,txtPackway,txtSprice,txtProfit,txtCommission,txtInsurance,txtPayterms,txtBenifit'
							, b_ret.length, b_ret, 'xproductno,product,spec,unit,price,mount,noa,no3,packwayno,packway,cost,profit,commission,insurance,payterms,benifit', 'txtProductno,txtProduct,txtSpec');
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
										var t_inmount=dec(as[0].inmount);
										var t_outmount=dec(as[0].outmount);
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
								var t_inmount=dec(as[0].inmount);
								var t_outmount=dec(as[0].outmount);
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
							s2[1]="where=^^ stype='3' and "+replaceAll(s2[1],"where=^^",'');
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
								q_box("ordc.aspx?;;;noa='" + noa + "';" + r_accy, 'ordc', "95%", "95%", q_getMsg("popOrdc"));
								break;
							case 'quarno':
								q_box("quar.aspx?;;;noa='" + noa + "';" + r_accy, 'quar', "95%", "95%", q_getMsg("popQuat"));
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
					case 'orde_ordb':
						var as = _q_appendData("view_orde", "", true);
						var rowslength=document.getElementById("table_ordb").rows.length-1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("table_ordb").deleteRow(1);
						}
							
						for (var i = 0; i < as.length; i++) {
							var tr = document.createElement("tr");
							tr.id = "bbs_"+i;
							tr.innerHTML= "<td id='ordb_tdNo2_"+i+"'><input id='ordb_txtNo2_"+i+"' type='text' value='"+as[i].no2+"' style='width: 45px' disabled='disabled' /><input id='ordb_txtNoa_"+i+"' type='text' value='"+as[i].noa+"' style='width: 45px;display:none' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdProdcut_"+i+"'><input id='ordb_txtProdcut_"+i+"' type='text' value='"+as[i].product+"' style='width: 200px' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdMount_"+i+"'><input id='ordb_txtMount_"+i+"' type='text' value='"+as[i].mount+"' style='width: 80px;text-align: right;' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdSafemount_"+i+"'><input id='ordb_txtSafemount_"+i+"' type='text' value='"+dec(as[i].safemount)+"' style='width: 80px;text-align: right;' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdStmount_"+i+"'><input id='ordb_txtStmount_"+i+"' type='text' value='"+as[i].stmount+"' style='width: 80px;text-align: right;' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdOcmount_"+i+"'><input id='ordb_txtOcmount_"+i+"' type='text' value='"+dec(as[i].ocmount)+"' style='width: 80px;text-align: right;' disabled='disabled' /></td>";
							//庫存-訂單數量>安全量?不需請購:abs(安全量-(庫存-訂單數量))
							tr.innerHTML+="<td id='ordb_tdObmount_"+i+"'><input id='ordb_txtObmount_"+i+"' type='text' value='"+(q_sub(dec(as[i].stmount),dec(as[i].mount))>as[i].safemount?0:Math.abs(q_sub(dec(as[i].safemount),q_sub(dec(as[i].stmount),dec(as[i].mount)))))+"' class='num' style='width: 80px;text-align: right;' /></td>";
							tr.innerHTML+="<td id='ordb_tdTggno_"+i+"'><input id='ordb_txtTggno_"+i+"' type='text' value='"+as[i].tggno+"' style='width: 150px'  /><input id='ordb_txtTgg_"+i+"' type='text' value='"+as[i].tgg+"' style='width: 200px' disabled='disabled' /></td>";
							tr.innerHTML+="<td id='ordb_tdInprice_"+i+"'><input id='ordb_txtInprice_"+i+"' type='text' value='"+(dec(as[i].tggprice)>0?as[i].tggprice:as[i].inprice)+"' class='num' style='width: 80px;text-align: right;' /></td>";
								
							var tmp = document.getElementById("ordb_close");
							tmp.parentNode.insertBefore(tr,tmp);
						}
						$('#lblOrde2ordb').text(q_getMsg('lblOrde2ordb'));
						$('#div_ordb').show();
						
						var SeekF= new Array();
						$('#table_ordb td').children("input:text").each(function() {
							if($(this).attr('disabled')!='disabled')
								SeekF.push($(this).attr('id'));
						});
						
						SeekF.push('btn_div_ordb');
						$('#table_ordb td').children("input:text").each(function() {
							$(this).keydown(function(event) {
								if( event.which == 13) {
									$('#'+SeekF[SeekF.indexOf($(this).attr('id'))+1]).focus();
									$('#'+SeekF[SeekF.indexOf($(this).attr('id'))+1]).select();
								}
							});
						});
						
						$('#table_ordb td .num').each(function() {
							$(this).keyup(function() {
								var tmp=$(this).val();
								tmp=tmp.match(/\d{1,}\.{0,1}\d{0,}/);
								$(this).val(tmp);
							});
						});
						
						refresh(q_recno);
						q_cur=2;
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
								wcost_price = round(q_div(q_add(q_add(q_add(dec(as[0].costa), dec(as[0].costb)), dec(as[0].costc)), dec(as[0].costd)), dec(as[0].mount)), 0)
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
			
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				/*for(var k=0;k<q_bbsCount;k++){
					if(emp($('#txtDatea_'+k).val()))
						$('#txtDatea_'+k).val(q_cdn($.trim($('#txtOdate').val()),15))
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
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orde') + $('#txtOdate').val(), '/', ''));
				else
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
								getpdate(b_seq);
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
								
								if(!emp($('#txtPayterms_'+b_seq).val()))
									$('#combPayterms').val($('#txtPayterms_'+b_seq).val());
								
								$('#textMount').change();
								$('#textCost').change();
								$('#div_getprice').css('top', e.pageY- $('#div_getprice').height());
								$('#div_getprice').css('left', e.pageX - $('#div_getprice').width());
								
								$('#div_getprice').show();
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

				var t_where = "where=^^ 1=1 ^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtOdate').focus();

				if (!emp($('#txtCustno').val())) {
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "'  ^^";
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

				if (!emp(abbm2['datea']))
					as['datea'] = abbm2['datea'];

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
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#btnOrdei').removeAttr('disabled');
					$('#combAddr').attr('disabled', 'disabled');
					$('#txtOdate').datepicker( 'destroy' );
					$('#btnOrdem').removeAttr('disabled');
				} else {
					$('#btnOrdei').attr('disabled', 'disabled');
					$('#combAddr').removeAttr('disabled');
					$('#txtOdate').datepicker();
					$('#btnOrdem').attr('disabled', 'disabled');
				}	
				
				$('#div_addr2').hide();
				readonly_addr2();
				HiddenTreat();
				cufttotal();
				
				$('#cmbStype').attr('disabled', 'disabled');
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
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "'^^";
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
					if(!emp($('#txtOdate').val()) && !emp($('#txtGdate').val()) && dec($('#txtMount_'+x).val())>0 ){
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
								factnotv=dec(as[0].mount);
							}
							
							//取得目前訂單的數量
							var t_bbsmount=0;
							for (var j = 0; j <= x; j++) {
								t_bbsmount=q_add(t_bbsmount,$('#txtMount_'+j).val());
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
								
								factnotv=q_sub(factnotv,mongen);
								if(factnotv>0)
									t_date=q_cdn(t_date,1);
							}
							$('#txtDatea_'+x).val(t_date);
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
					<td align="center"><select id="combPayterms" class="txt c1"> </select></td>
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_ordb" style="position:absolute; top:180px; left:20px; display:none; width:1020px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_ordb" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="width:45px;background-color: #f8d463;" align="center">訂序</td>
					<td style="width:200px;background-color: #f8d463;" align="center">品名</td>
					<td style="width:80px;background-color: #f8d463;" align="center">訂單數量</td>
					<td style="width:80px;background-color: #f8d463;" align="center">安全庫存</td>
					<td style="width:80px;background-color: #f8d463;" align="center">庫存數量</td>
					<td style="width:80px;background-color: #f8d463;" align="center">在途數量</td>
					<td style="width:80px;background-color: #f8d463;" align="center">採購數量</td>
					<td style="width:200px;background-color: #f8d463;" align="center">供應商</td>
					<td style="width:80px;background-color: #f8d463;" align="center">進貨單價</td>
				</tr>
				<tr id='ordb_close'>
					<td align="center" colspan='9'>
						<input id="btnClose_div_ordb" type="button" value="確定">
						<input id="btnClose_div_ordb2" type="button" value="取消">
					</td>
				</tr>
			</table>
		</div>
		
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
						<td align="center" style="width:25%"><a id='vewOdate'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
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
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
						<td style="width: 108px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td><input id="txtOdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td align="center"><input id="btnOrdei" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
						<td ><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td colspan="2"><input id="txtContract" type="text" class="txt c1"/></td>
						<td align="center"><input id="btnOrdem" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td>
							<select id="combPaytype" class="txt c1" onchange='combPaytype_chg()' > </select>
						</td>
						<td align="center"><input id="btnCredit" type="button" value='' /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input id="txtFax" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblAgent" class="lbl btn"> </a></td>
						<td><input id="txtAgentno" type="text" class="txt c1"/></td>
						<td><input id="txtAgent" type="text" class="txt c1"/></td>
						<td align="center">
							<input id="btnQuat" type="button" value='' />
							<input id="txtQuatno" type="hidden" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td><input id="txtPost" type="text" class="txt c1"/></td>
						<td colspan='4'><input id="txtAddr" type="text" class="txt c1"/></td>
						<!--<td><span> </span><a id='lblOrdbno' class="lbl"> </a></td>
						<td><input id="txtOrdbno" type="text" class="txt c1"/></td>-->
						<td> </td>
						<td><input id="btnImg" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr2' class="lbl"> </a></td>
						<td><input id="txtPost2" type="text" class="txt c1"/></td>
						<td colspan='4'>
							<input id="txtAddr2" type="text" class="txt c1" style="width: 412px;"/>
							<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
						</td>
						<td><input id="btnAddr2" type="button" value='...' style="width: 30px;height: 21px" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" class="txt c2"/>
							<input id="txtSales" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
						<td><span> </span><a id='lblCustorde' class="lbl"> </a></td>
						<td><select id="txtCustorde" class="txt c1"> </select></td>
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
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td colspan='2'>
							<input id="txtMoney" type="text" class="txt c1" style="text-align: center;"/>
						</td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1"/></td>
						<td><select id="cmbTaxtype" class="txt c1" onchange='sum()' > </select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" onchange='coin_chg()'> </select></td>
						<td><input id="txtFloata" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td colspan='2'><input id="txtTotalus" type="text" class="txt num c1"/></td>
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
						<td><span> </span><a id='lblFactory' class="lbl btn"> </a></td>
						<td><input id="txtGdate" type="text" class="txt c1" /></td>
						<td><input id="txtGtime" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
						<td colspan="2">
							<input id="chkIsproj" type="checkbox"/>
							<span> </span><a id='lblIsproj'> </a>
							<input id="chkEnda" type="checkbox"/>
							<span> </span><a id='lblEnda'> </a>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class='lbl'> </a></td>
						<td colspan='7'>
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1985px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:45px;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:160px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:55px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:85px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:85px;"><a id='lblPrices'> </a><BR><a id='lblCost_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblGetprice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPayterms_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPackway_s'> </a></td>
					<td align="center" style="width:115px;"><a id='lblTotal_s'> </a><BR><a id='lblBenifit_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblCuft_s'> </a></td>
					<td align="center" style="width:150px;display: none;" class="isimg"><a id='lblImg_s'> </a></td>
					<td align="center" style="width:85px;"><a id='lblGemounts'> </a></td>
					<td align="center" style="width:175px;"><a id='lblMemos'> </a></td>
					<td align="center" style="width:85px;"><a id='lblDateas'> </a></td>
					<td align="center" style="width:43px;"><a id='lblEndas'> </a></td>
					<td align="center" style="width:43px;"><a id='lblCancels'> </a></td>
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
					</td>
					<td>
						<input class="txt c7" id="txtProduct.*" type="text" />
						<input id="txtSpec.*" type="text" class="txt c1 isSpec"/>
					</td>
					<td align="center"><input class="txt c7" id="txtUnit.*" type="text"/></td>
					<td><input class="txt num c7" id="txtMount.*" type="text" /></td>
					<td>
						<input class="txt num c7" id="txtPrice.*" type="text" />
						<input class="txt num c7" id="txtSprice.*" type="text" />
						
						<input id="txtProfit.*" type="hidden" class="txt c1 num"/>
						<input id="txtCommission.*" type="hidden" class="txt c1 num"/>
						<input id="txtInsurance.*" type="hidden" class="txt c1 num"/>
					</td>
					<td align="center"><input class="btn" id="btnGetprice.*" type="button" value='.' style=" font-weight: bold;"/></td>
					<td><input id="txtPayterms.*" type="text" class="txt c1"/></td>
					<td>
						<input id="txtPackwayno.*" type="text" class="txt c1" style="width: 60%;"/>
						<input class="btn" id="btnPackway.*" type="button" value='.' style=" font-weight: bold;"/>
						<input id="txtPackway.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input class="txt num c7" id="txtTotal.*" type="text" />
						<input class="txt num c7" id="txtBenifit.*" type="text" />
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
					<td><input class="txt c7" id="txtDatea.*" type="text" /></td>
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