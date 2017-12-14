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
			q_tables = 't';
			var q_name = "workg";
			var q_readonly = ['txtNoa','txtFact', 'txtDatea', 'txtWorker', 'txtWorker2', 'txtOrdbno','textOmount','textBmount'];//105/03/30 開放 'txtWadate' 
			var q_readonlys = ['txtWorkno','txtWorkhno', 'txtIndate', 'txtInmount', 'txtWmount', 'txtUindate'];
			var q_readonlyt = [];
			var bbmNum = [['txtMount', 15, 0, 1],['textOmount', 15, 0, 1],['textBmount', 15, 0, 1]];
			var bbsNum = [
				['txtOrdemount', 15, 0, 1], ['txtPlanmount', 15, 0, 1], ['txtStkmount', 15, 0, 1],
				['txtIntmount', 15, 0, 1], ['txtPurmount', 15, 0, 1], ['txtAvailmount', 15, 0, 1],
				['txtBornmount', 15, 0, 1], ['txtSalemount', 15, 0, 1], ['txtMount', 15, 0, 1],
				['txtInmount', 15, 0, 1], ['txtWmount', 15, 0, 1], ['txtSaleforecast', 15, 0, 1],
				['txtForecastprepare', 15, 0, 1], ['txtUnprepare', 15, 0, 1], ['txtPrepare', 15, 0, 1], ['txtDayborn', 15, 0, 1]
			];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			//brwCount2 = 6;//03/28自動
			aPop = new Array(
				['txtFactno', 'lblFactno', 'factory', 'noa,factory', 'txtFactno,txtFact', 'factory_b.aspx'],
				['txtCustno', 'lblCustno', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtProductno', 'lblProduct', 'uca', 'noa,product', 'txtProductno,txtProduct', 'uca_b.aspx'],
				['txtProductno_', 'btnProduct_', 'uca', 'noa,product,style', 'txtProductno_,txtProduct_,txtStyle_', 'uca_b.aspx'],
				['txtStationno_', 'btnStation_', 'station', 'noa,station', 'txtStationno_,txtStation_', 'station_b.aspx'],
				['txtProductno__', 'btnProduct__', 'uca', 'noa,product,style', 'txtProductno__,txtProduct__,txtStyle__', 'uca_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			}).mousedown(function(e) {
				if(!$('#div_row').is(':hidden')){
					$('#div_row').hide();
				}
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_getFormat();
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtSfbdate', r_picd], ['txtSfedate', r_picd], ['txtWadate', r_picd], ['txtWbdate', r_picd], ['txtWedate', r_picd]];
				bbsMask = [['txtRworkdate', r_picd], ['txtCuadate', r_picd], ['txtIndate', r_picd], ['txtUindate', r_picd], ['txtNoq','999'], ['txtOdatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbStype", q_getPara('workg.stype'));	
				
				 $('#btnWorkgg').click(function() {
                	q_box("z_workgg.aspx", 'z_workgg', "95%", "95%", q_getMsg("btnWorkgg"));
				});
				$('#btnImport').click(function(){
					q_box('uploadra.aspx'+ "?;;;;"+r_accy+";", 'uploadra', "95%", "95%", q_getMsg("popPrint"));
				});
				$('#btnOrde').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						if (emp($('#txtBdate').val()) && emp($('#txtEdate').val()) && emp($('#txtOrdeno').val()) ) {
							alert('【'+q_getMsg('lblBdate') +'】或【'+q_getMsg('lblOrdeno')+ '】請先填寫。');
							return;
						}
						
						if ((!emp($('#txtBdate').val()) && emp($('#txtEdate').val())) || (emp($('#txtBdate').val()) && !emp($('#txtEdate').val()))) {
							alert(q_getMsg('lblBdate') + '錯誤!!。');
							return;
						}
						
						if(emp($('#txtWbdate').val()))
							$('#txtWbdate').val(q_cdn($('#txtBdate').val(),-dec(q_getPara('orde.preborn'))));
						if(emp($('#txtWedate').val()))
							$('#txtWedate').val(q_cdn($('#txtEdate').val(),-dec(q_getPara('orde.preborn'))));
						
						if ((!emp($('#txtBdate').val()) && !emp($('#txtEdate').val())) || !emp($('#txtOrdeno').val())) {
							var t_edate=emp($('#txtEdate').val())?r_picd:$('#txtEdate').val();
							
							var t_where = "(a.datea between '"+$('#txtBdate').val()+"' and '"+t_edate+"') and isnull(a.mount,0)!=0 and isnull(a.enda,0)!=1 and isnull(a.cancel,0)!=1 ";
							t_where = t_where+" and not exists(select * from view_workgs where ordeno=a.noa+'-'+a.no2 and noa !='"+$('#txtNoa').val()+"')";
							if(!emp($('#txtCustno').val()))
								t_where = t_where+" and exists(select * from view_orde where noa=a.noa and custno='"+$('#txtCustno').val()+"') ";
							if(!emp($('#txtProductno').val()))
								t_where = t_where+" and a.productno='"+$('#txtProductno').val()+"' ";
							if(!emp($('#txtFactno').val()))
								t_where = t_where+" and exists(select * from view_orde where noa=a.noa and gdate='"+$('#txtFactno').val()+"') ";
							if(!emp($('#txtOrdeno').val()))
								t_where = t_where+" and a.noa='"+$('#txtOrdeno').val()+"' ";
								
							//106/12/13 已轉採購單的訂單不匯入排產
							t_where = t_where+" and not exists(select * from view_orde where noa=a.noa and isnull(ordcno,'')!='') ";
							
							t_where="where=^^"+t_where+"^^";
							
							q_gt('view_ordes', t_where, 0, 0, 0, "ordesimport", r_accy);
						}
					}
				});
				
				$('#btnWorkg').click(function() {
					if (q_cur == 1 || q_cur == 2) {
												
						//0418 不顯示預測為0的資料
						var sbdate='',sedate='';
						if (emp($('#txtSfbdate').val())) {
							sbdate=q_date();
						}else{
							sbdate=$('#txtSfbdate').val();
						}
						
						if(emp($('#txtWbdate').val()))
							$('#txtWbdate').val(q_cdn(sbdate,-dec(q_getPara('orde.preborn'))));
						
						if (emp($('#txtSfedate').val())) {
							sedate=r_picd;
						}else{
							sedate=$('#txtSfedate').val();
							if(emp($('#txtWedate').val()))
								$('#txtWedate').val(q_cdn($('#txtSfedate').val(),-dec(q_getPara('orde.preborn'))));
						}
						var t_where = "where=^^ ['" + q_date() + "','','') where productno=b.productno ^^"
						
						var t_where1 = "where[1]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where1=t_where1+"wa.custno='"+$('#txtCustno').val()+"' and "
						t_where1=t_where1+"wb.productno=b.productno and (wa.sfedate between '"+sbdate+"' and '"+sedate+"') and wa.noa!='"+$('#txtNoa').val()+"'^^"
						
						var t_where2 = "where[2]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where2=t_where2+"d.custno='"+$('#txtCustno').val()+"' and "
						t_where2=t_where2+"c.productno=b.productno and (case when isnull(c.datea,'')='' then d.odate else c.datea end < '"+$('#txtBdate').val()+"') and c.enda!='1' and d.enda!='1' ^^"
						
						var t_where3 = "where[3]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where3=t_where3+"d.custno='"+$('#txtCustno').val()+"' and "
						t_where3=t_where3+"c.productno=b.productno and (case when isnull(c.datea,'')='' then d.odate else c.datea end between '"+$('#txtBdate').val()+"' and '"+$('#txtEdate').val()+"') and c.enda!='1' and d.enda!='1' ^^"
						
						var t_where4 = "where[4]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where4=t_where4+"d.custno='"+$('#txtCustno').val()+"' and "
						t_where4=t_where4+"c.productno=b.productno and (case when isnull(c.datea,'')='' then d.odate else c.datea end between '"+$('#txtBdate').val()+"' and '"+$('#txtEdate').val()+"') and c.enda!='1' and d.enda!='1' ^^"
						
						//1030417應客戶需要所以即使沒有打產品也要帶入
						//var t_bbspno="1=0";
						/*for (var i = 0; i < q_bbsCount; i++) {
							if(!emp($('#txtProductno_'+i).val())){
								t_bbspno+=" or b.productno='"+$('#txtProductno_'+i).val()+"'";
							}
						}*/
						//var t_where5 = "where[5]=^^ ("+t_bbspno+") and (b.datea between '"+sbdate+"' and '"+sedate+"') and b.productno in (select noa from uca)^^";
						
						var t_where5 = "where[5]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where5=t_where5+"a.custno='"+$('#txtCustno').val()+"' and "							
						//排除已匯入的產品
						for (var i = 0; i < q_bbsCount; i++) {
							if(!emp($('#txtProductno_'+i).val())){
								t_where5+="b.productno!='"+$('#txtProductno_'+i).val()+"' and ";
							}
						}	
						t_where5=t_where5+"(b.datea between '"+sbdate+"' and '"+sedate+"') and b.productno in (select noa from uca) ^^"
							
						q_gt('workg_saleforecast', t_where + t_where1 + t_where2 + t_where3 + t_where4 + t_where5 , 0, 0, 0, "", r_accy);
						
					}
				});
				
				
				$('#btnWork').click(function() {
					if (q_cur != 1 && q_cur != 2) {
						/*if(!emp($('#txtOrdbno').val())){
							alert('製令單已請購-禁止重新產生製令單!!');
							return;
						}*/
						
						var t_where = "where=^^ cuano='" + $('#txtNoa').val() + "' and isnull(inmount,0)>0 ^^";
						q_gt('view_work', t_where, 0, 0, 0, "review_work", r_accy,1);
						
						t_inmount = 0;
						t_work = _q_appendData("view_work", "", true);
						for (var i = 0; i < t_work.length; i++) {
							t_inmount = t_inmount + dec(t_work[i].inmount);
						}
						
						var worked = false;
						for (var i = 0; i < q_bbsCount; i++) {
							if (!emp($('#txtWorkno_' + i).val()))
								worked = true;
						}
						if (worked && t_inmount > 0)
							alert('製令單已入庫/領料-禁止重新產生製令單!!');
						else {
							q_func('workg.genWork', r_accy + ',' + $('#txtNoa').val() + ',' + r_name);
							$('#btnWork').val('產生中...').attr('disabled', 'disabled');
						}
					}
				});
				//針對全部的物料需求
				/*$('#btnCuap').click(function(){
				q_box('z_cuap.aspx'+ "?;;;;"+r_accy+";", 'cup', "95%", "95%", q_getMsg("popPrint"));
				});*/
				//針對workg的物料需求
				$('#btnWorkg2ordb').click(function() {
					q_box('z_workg2ordb.aspx' + "?;;;;" + r_accy + ";", 'workg2ordb', "95%", "95%", q_getMsg("popPrint"));
				});
				
				$('#btnWorkgv').click(function() {
					q_box('z_workgv.aspx' + "?;;;;" + r_accy + ";", 'workgv', "95%", "95%", q_getMsg("popPrint"));
				});

				$('#btnWorkPrint').click(function() {
					q_box('z_workp.aspx' + "?;;;noa='" + $('#txtNoa').val() + "';" + r_accy + ";", '', "95%", "95%", q_getMsg("popPrint"));
				});
				
				$('#lblOrdbno').click(function() {
					q_box('ordb.aspx' + "?;;;charindex(noa,'" + $('#txtOrdbno').val() + "')>0;" + r_accy + ";", '', "95%", "95%", q_getMsg("lblOrdbno"));
				});
				
				if(q_getPara('sys.project').toUpperCase()=='JO'){
					$('#btnWorkg_jo').show();
				}
				
				$('#btnWorkg_jo').click(function() {
					q_box('z_workg_jo.aspx' + "?;;;noa='" + $('#txtNoa').val() + "';" + r_accy + ";", '', "95%", "95%", $('#btnWorkg_jo').val());
				});
				
				$('#btnUindate').click(function() {
					if((q_cur==1 || q_cur==2) && dec($('#txtMon').val())>0){
						var auindate=[];
						for (var i = 0; i < q_bbsCount; i++) {
							if($.trim($('#txtRworkdate_'+i).val()).length>0 && dec($('#txtMount_'+i).val())>0 && q_cd($('#txtRworkdate_'+i).val())){
								var smount=dec($('#txtMount_'+i).val());
								var t_datea=$.trim($('#txtRworkdate_'+i).val());
								while(smount>0){
									var isexists=false;
									for (var j = 0; j < auindate.length; j++) {
										if(auindate[j].datea==t_datea){
											isexists=true;
											if(auindate[j].mount>=smount){
												auindate[j].mount=q_sub(dec(auindate[j].mount),smount);
												smount=0;
											}else{
												smount=q_sub(smount,dec(auindate[j].mount));
												auindate[j].mount=0;
											}
											break;
										}
									}
									
									if(!isexists){
										if(dec($('#txtMon').val())>=smount){
											auindate.push({
												datea:t_datea,
												mount:q_sub(dec($('#txtMon').val()),smount)
											});
											smount=0;
										}else{
											smount=q_sub(smount,dec($('#txtMon').val()));
											auindate.push({
												datea:t_datea,
												mount:0
											});
										}
									}
									if(smount==0){
										break;
									}
									
									//日期變動
									t_datea=q_cdn(t_datea,1);
									var week='';
									if(t_datea.length==10){
										week=new Date(dec(t_datea.substr(0,4)),dec(t_datea.substr(5,2))-1,dec(t_datea.substr(8,2))).getDay()
									}else{
										week=new Date(dec(t_datea.substr(0,3))+1911,dec(t_datea.substr(4,2))-1,dec(t_datea.substr(7,2))).getDay();
									}
									
									if(q_getPara('sys.saturday')!='1' && week==6)
										t_datea=q_cdn(t_datea,1);
									if(week==0)
										t_datea=q_cdn(t_datea,1);
								}
								$('#txtUindate_'+i).val(t_datea);
							}
						}
					}
				});
				
				$('#btnWorkReal').click(function() {
					if($.trim($('#txtNoa').val()).length==0 && $('#txtNoa').val()!='AUTO'){
						return;
					}
					if (!confirm("確定要轉換嗎?")){
						return;
					}
					//檢查是否需要轉換
					q_gt('view_work', "where=^^ cuano='"+$.trim($('#txtNoa').val())+"' and noa not like 'W[0-9]%' ^^" , 0, 0, 0, "getworknoreal", r_accy);
				});
				
				//上方插入空白行
				$('#lblTop_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
					}
				});
				//下方插入空白行
				$('#lblDown_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
					}
				});
				
				$('#btnBbscut').click(function() {
					var t_bdate='',t_bmount=0;
					if(dec($('#txtMount').val())<=0){
						alert('請正確填寫【每日定量生產】。');
						return;
					}else{
						t_bmount=dec($('#txtMount').val());
					}
					if(emp($('#txtWbdate').val())){
						alert('請先填寫【'+q_getMsg('lblWbdate') +'】。');
						return;
					}else{
						t_bdate=$('#txtWbdate').val();
					}
					var ordepno=[];//總計
					var copy_row=new Array();
					//先加訂單號+製品號
					for (var i = 0; i < q_bbsCount; i++) {
						if(!emp($('#txtOrdeno_'+i).val()) && !emp($('#txtProductno_'+i).val())){
							if(ordepno.length==0){
								ordepno.push({
									'seq':i,
									'ordeno':$('#txtOrdeno_'+i).val(),
									'pno':$('#txtProductno_'+i).val(),
									'omount':dec($('#txtMount_'+i).val())
								});
								var t_copy=new Array();
								t_copy['seq']=i;
								for (var j = 0; j < fbbs.length; j++) {
									if(fbbs[j].substr(0,3)=='chk'){
										t_copy[fbbs[j]]=$('#'+fbbs[j]+'_'+i).prop('checked');
									}else{
										t_copy[fbbs[j]]=$('#'+fbbs[j]+'_'+i).val();
									}
								}
								copy_row.push(t_copy);
							}else{
								var isexists=false;
								for(var j=0;j<ordepno.length;j++){
									if(ordepno[j].ordeno==$('#txtOrdeno_'+i).val() && ordepno[j].pno==$('#txtProductno_'+i).val()){
										ordepno[j].omount=q_add(ordepno[j].omount,dec($('#txtMount_'+i).val()))
										isexists=true;
										break;
									}
								}
								if(!isexists){
									ordepno.push({
										'seq':i,
										'ordeno':$('#txtOrdeno_'+i).val(),
										'pno':$('#txtProductno_'+i).val(),
										'omount':dec($('#txtMount_'+i).val())
									});
									
									var t_copy=new Array();
									t_copy['seq']=i;
									for (var j = 0; j < fbbs.length; j++) {
										if(fbbs[j].substr(0,3)=='chk'){
											t_copy[fbbs[j]]=$('#'+fbbs[j]+'_'+i).prop('checked');
										}else{
											t_copy[fbbs[j]]=$('#'+fbbs[j]+'_'+i).val();
										}
									}
									copy_row.push(t_copy);
								}
							}
						}
					}
					for(var j=0;j<ordepno.length;j++){
						ordepno[j].obdate=t_bdate;
						ordepno[j].nday=Math.ceil(q_div(dec(ordepno[j].omount),t_bmount));
					}
					
					q_gt('holiday', "where=^^ noa>='"+t_bdate+"' ^^ stop=100" , 0, 0, 0, "getholiday", r_accy,1);
					var holiday = _q_appendData("holiday", "", true);
					
					var nordepno=[];//新拆分結果
					for(var j=0;j<ordepno.length;j++){
						var t_day=ordepno[j].nday;
						var t_ndate=ordepno[j].obdate;
						var t_omount=dec(ordepno[j].omount);
						var t_seqs=0,t_tlen=0;
						
						while(t_day>0 && t_omount>0){
							var t_iswork=true;
							var t_holidaywork=false; //假日主檔是否要上班
							
							for(var k=0;k<holiday.length;k++){
								if(holiday[k].noa==t_ndate){
									if(holiday[k].iswork=="true"){
										t_holidaywork=true;
									}else{
										t_iswork=false;
									}
								}
							}
							
							if(!t_holidaywork && t_iswork){
							
								var week='';
								if(t_ndate.length==10){
									week=new Date(dec(t_ndate.substr(0,4)),dec(t_ndate.substr(5,2))-1,dec(t_ndate.substr(8,2))).getDay()
								}else{
									week=new Date(dec(t_ndate.substr(0,3))+1911,dec(t_ndate.substr(4,2))-1,dec(t_ndate.substr(7,2))).getDay();
								}
										
								if(q_getPara('sys.saturday')!='1' && week==6)
									t_iswork=false;
								if(week==0)
									t_iswork=false;
							}
								
							if(t_iswork){
								nordepno.push({
									'seq':ordepno[j].seq,
									'seqs':t_seqs++,
									'ordeno':ordepno[j].ordeno,
									'pno':ordepno[j].pno,
									'omount':ordepno[j].omount,
									'obdate':ordepno[j].obdate,
									'bdate':t_ndate,
									'mount':t_omount>=t_bmount?t_bmount:t_omount
								});
								
								t_omount=q_sub(t_omount,t_bmount);
								t_day--;
								t_tlen++;
							}
							
							t_ndate=q_cdn(t_ndate,1);
						}
					}
					
					for (var i = 0; i < q_bbsCount; i++) {$('#btnMinus_'+i).click();}
					while(nordepno.length>q_bbsCount){$('#btnPlus').click();}
					
					for(var j=0;j<nordepno.length;j++){
						for(var x=0;x<copy_row.length;x++){
							if(nordepno[j].seq==copy_row[x]['seq']){
								for (var y = 0; y < fbbs.length; y++) {
									if(fbbs[y].substr(0,3)=='chk'){
										$('#'+fbbs[y]+'_'+j).prop('checked',copy_row[x][fbbs[y]])
									}else{
										$('#'+fbbs[y]+'_'+j).val(copy_row[x][fbbs[y]]);
									}
								}
								$('#txtMount_'+j).val(nordepno[j].mount)
								$('#txtUindate_'+j).val(nordepno[j].bdate)
							}
						}
						$('#txtNoq_'+j).val('');
					}
				});
			}
			
			var ordedate=false;
			var t_work, t_inmount = 0;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'getworknoreal':
						var as = _q_appendData("view_work", "", true);
						if (as[0] != undefined) {
							
							var t_bcuano=$.trim($('#txtNoa').val());
							var t_ecuano=$.trim($('#txtNoa').val());
											
							$('#btnWorkReal').attr('disabled', 'disabled');
							q_func('qtxt.query.workrealall', 'workg.txt,workrealall,'
							+t_bcuano+';'+t_ecuano+';'+r_name);
						}else{
							alert('【'+$.trim($('#txtNoa').val())+'】排產單無可轉換的模擬製令!!');
						}
						break;
					case 'view_work':
						t_inmount = 0;
						t_work = _q_appendData("view_work", "", true);
						for (var i = 0; i < t_work.length; i++) {
							t_inmount = t_inmount + dec(t_work[i].inmount);
						}
						break;
					case 'ordesimport':
						var as = _q_appendData("view_ordes", "", true);
						if (as[0] != undefined) {
							//清空bbs資料 1060316若ordeno匯入不清除
							if (q_cur == 1 && emp($('#txtOrdeno').val())) {
								for (var i = 0; i < q_bbsCount; i++) {
									$('#btnMinus_' + i).click();
								}
							}
							for (var i = 0; i < as.length; i++) {
								var isexists=false;
								for (var j = 0; j < q_bbsCount; j++) {
									if(as[i].noa+'-'+as[i].no2==$('#txtOrdeno_'+j).val()){
										isexists=true;
										break;
									}
								}
								
								if(isexists){
									as.splice(i, 1);
                                    i--;
								}else{
									as[i].rworkdate = '';
									as[i].ordeno = as[i].noa+'-'+as[i].no2;
								}
							}
							//106/06/03 依據預交日排序
							as.sort(function(a, b) {if(a.datea>b.datea) {return 1;} if (a.datea < b.datea) {return -1;} return 0;});
							
							q_gridAddRow(bbsHtm, 'tbbs', 'txtRworkdate,txtProductno,txtProduct,txtSpec,txtStyle,txtOrdemount,txtMount,txtOrdeno,txtOdatea,txtCuadate'
							, as.length, as
							, 'rworkdate,productno,product,spec,style,mount,mount,ordeno,datea,indate,stationno,station', 'txtProductno');
						} else {
							alert('無訂單資料!!。');
						}
						break;
					case 'workg_bbs':
						var as = _q_appendData("view_ordes", "", true);
						
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								var t_mount = 0;
								t_mount = dec(as[i].stkmount) - dec(as[i].unmount) - dec(as[i].ordemount);
								as[i].availmount = t_mount;
								as[i].ordeno = as[i].ordeno.substr(0, as[i].ordeno.length - 1);
							}
							
							for (var i = 0; i < q_bbsCount; i++) {
								for (var j = 0; j < as.length; j++) {
									if($('#txtProductno_' + i).val()==as[j].productno)
									{
										//重新帶入資料
										$('#txtUnmount_' + i).val(as[j].unmount);
										$('#txtOrdemount_' + i).val(as[j].ordemount);
										$('#txtPlanmount_' + i).val(as[j].planmount);
										$('#txtStkmount_' + i).val(as[j].stkmount);
										$('#txtIntmount_' + i).val(as[j].inmount);
										$('#txtPurmount_' + i).val(as[j].purmount);
										$('#txtAvailmount_' + i).val(as[j].availmount);
										$('#txtMount_' + i).val(as[j].bornmount);
										$('#txtOrdeno_' + i).val(as[j].ordeno);
										$('#txtStationno_' + i).val(as[j].stationno);
										$('#txtStation_' + i).val(as[j].station);
										$('#txtSaleforecast_' + i).val(as[j].saleforecast);
										$('#txtPrepare_' + i).val(as[j].prepare);
										$('#txtUnprepare_' + i).val(as[j].unprepare);
										as.splice(j, 1);
                                    	j--;
										break;	
									}
								}
							}
							
							q_gridAddRow(bbsHtm, 'tbbs', 'txtRworkdate,txtProductno,txtProduct,txtStyle,txtUnmount,txtOrdemount,txtPlanmount,txtStkmount,txtIntmount,txtPurmount,txtAvailmount,txtMount,txtOrdeno,txtStationno,txtStation,txtSaleforecast,txtPrepare,txtUnprepare'
							, as.length, as
							, 'rworkdate,productno,product,style,unmount,ordemount,planmount,stkmount,inmount,purmount,availmount,bornmount,ordeno,stationno,station,saleforecast,prepare,unprepare', 'txtProductno');
							ordedate=true;
						} else {
							//alert('無排產資料!!。');
							ordedate=false;
						}
						
						//抓取沒有訂單的資料
						var sbdate='',sedate='';
						if (emp($('#txtSfbdate').val())) {
							sbdate=q_date();
						}else{
							sbdate=$('#txtSfbdate').val();
						}
						if (emp($('#txtSfedate').val())) {
							sedate=r_picd;
						}else{
							sedate=$('#txtSfedate').val();
						}
						var t_where = "where=^^ ['" + q_date() + "','','') where productno=b.productno ^^"
						
						var t_where1 = "where[1]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where1=t_where1+"wa.custno='"+$('#txtCustno').val()+"' and "
						t_where1=t_where1+"wb.productno=b.productno and (wa.sfedate between '"+sbdate+"' and '"+sedate+"') and wa.noa!='"+$('#txtNoa').val()+"'^^"
						
						var t_where2 = "where[2]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where2=t_where2+"d.custno='"+$('#txtCustno').val()+"' and "
						t_where2=t_where2+"c.productno=b.productno and (case when isnull(c.datea,'')='' then d.odate else c.datea end < '"+$('#txtBdate').val()+"') and c.enda!='1' and d.enda!='1' ^^"
						
						var t_where3 = "where[3]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where3=t_where3+"d.custno='"+$('#txtCustno').val()+"' and "
						t_where3=t_where3+"c.productno=b.productno and (case when isnull(c.datea,'')='' then d.odate else c.datea end between '"+$('#txtBdate').val()+"' and '"+$('#txtEdate').val()+"') and c.enda!='1' and d.enda!='1' ^^"
						
						var t_where4 = "where[4]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where4=t_where4+"d.custno='"+$('#txtCustno').val()+"' and "
						t_where4=t_where4+"c.productno=b.productno and (case when isnull(c.datea,'')='' then d.odate else c.datea end between '"+$('#txtBdate').val()+"' and '"+$('#txtEdate').val()+"') and c.enda!='1' and d.enda!='1' ^^"
						
						//1030417應客戶需要所以即使沒有打產品也要帶入
						//var t_bbspno="1=0";
						/*for (var i = 0; i < q_bbsCount; i++) {
							if(!emp($('#txtProductno_'+i).val())){
								t_bbspno+=" or b.productno='"+$('#txtProductno_'+i).val()+"'";
							}
						}*/
						//var t_where5 = "where[5]=^^ ("+t_bbspno+") and (b.datea between '"+sbdate+"' and '"+sedate+"') and b.productno in (select noa from uca)^^";
						
						var t_where5 = "where[5]=^^ ";
						if(!emp($('#txtCustno').val()))
							t_where5=t_where5+"a.custno='"+$('#txtCustno').val()+"' and "							
						//排除已匯入的產品
						for (var i = 0; i < q_bbsCount; i++) {
							if(!emp($('#txtProductno_'+i).val())){
								t_where5+="b.productno!='"+$('#txtProductno_'+i).val()+"' and ";
							}
						}	
						t_where5=t_where5+"(b.datea between '"+sbdate+"' and '"+sedate+"') and b.productno in (select noa from uca) ^^"
							
						q_gt('workg_saleforecast', t_where + t_where1 + t_where2 + t_where3 + t_where4 + t_where5 , 0, 0, 0, "", r_accy);
						
						break;
					case 'workg_saleforecast':
						var as = _q_appendData("view_workg", "", true);
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								var t_mount = 0;
								t_mount = dec(as[i].stkmount) - dec(as[i].unmount) - dec(as[i].ordemount);
								as[i].availmount = t_mount;
								as[i].ordeno = as[i].ordeno.substr(0, as[i].ordeno.length - 1);
							}
							
							for (var i = 0; i < q_bbsCount; i++) {
								for (var j = 0; j < as.length; j++) {
									if($('#txtProductno_' + i).val()==as[j].productno)
									{
										//重新帶入資料
										$('#txtUnmount_' + i).val(as[j].unmount);
										$('#txtOrdemount_' + i).val(as[j].ordemount);
										$('#txtPlanmount_' + i).val(as[j].planmount);
										$('#txtStkmount_' + i).val(as[j].stkmount);
										$('#txtIntmount_' + i).val(as[j].inmount);
										$('#txtPurmount_' + i).val(as[j].purmount);
										$('#txtAvailmount_' + i).val(as[j].availmount);
										$('#txtMount_' + i).val(as[j].bornmount);
										$('#txtOrdeno_' + i).val(as[j].ordeno);
										$('#txtStationno_' + i).val(as[j].stationno);
										$('#txtStation_' + i).val(as[j].station);
										$('#txtSaleforecast_' + i).val(as[j].saleforecast);
										$('#txtPrepare_' + i).val(as[j].prepare);
										$('#txtUnprepare_' + i).val(as[j].unprepare);
										$('#txtStyle_' + i).val(as[j].style);
										as.splice(j, 1);
                                    	j--;
										break;	
									}
								}
							}
							q_gridAddRow(bbsHtm, 'tbbs', 'txtRworkdate,txtProductno,txtProduct,txtStyle,txtUnmount,txtOrdemount,txtPlanmount,txtStkmount,txtIntmount,txtPurmount,txtAvailmount,txtMount,txtOrdeno,txtStationno,txtStation,txtSaleforecast,txtPrepare,txtUnprepare,txtStyle'
							, as.length, as
							, 'rworkdate,productno,product,style,unmount,ordemount,planmount,stkmount,inmount,purmount,availmount,bornmount,ordeno,stationno,station,saleforecast,prepare,unprepare,style', 'txtProductno');
						} else {
							//if(!ordedate)
								alert('無排產資料!!。');
						}
						break;
					case 'check_view':
						var as = _q_appendData("workg", "", true);
						if (as[0] != undefined) {
							for (var i = 0; i < brwCount; i++) {
								if($('#vtnoa_'+i).text()!=''){
									for (var j = 0; j < as.length; j++) {
										if($('#vtnoa_'+i).text()==as[j].noa){
											if(as[j].ordbno!=''){
												$('#vtunordb_'+i).text('');
											}else{
												$('#vtunordb_'+i).text('v');
											}
											//106/11/27 請購過就算有簽核
											if(as[j].ordbno!='' || as[j].ordano!=''){
												$('#vtunorda_'+i).text('');
											}else{
												$('#vtunorda_'+i).text('v');
											}
											$('#vtunwork_'+i).text(as[j].unwork);
										}
									}
								}
							}
							
							for (var j = 0; j < as.length; j++) {
								if($('#txtNoa').val()==as[j].noa){
									$('#txtOrdbno').val(as[j].ordbno);
									$('#txtOrdano').val(as[j].ordano);
								}
							}
						}
					break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if (t_name.substr(0, 9) == 'modiwork_') {
					var s_works = _q_appendData("works", "", true);
					var s_gmount = 0;
					for (var i = 0; i < s_works.length; i++) {
						s_gmount = s_gmount + dec(s_works[i].gmount);
					}
					if (s_gmount > 0) {
						t_noq = t_name.substr(t_name.indexOf('_') + 1, t_name.length)
						for (var j = 0; j < fbbs.length; j++) {
							$('#' + fbbs[j] + '_' + t_noq).attr('disabled', 'disabled');

						}
						$('#btnMinus_' + t_noq).attr('disabled', 'disabled');
					}
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				q_func('qtxt.query', 'workg.txt,freeze,' +encodeURI($('#txtNoa').val()));
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'workg2ordb':
						//檢查是否有簽核和請購
						var endnoa=''
						for (var i = 0; i < brwCount; i++) {
							if($('#vtnoa_'+i).text()!='')
								endnoa=$('#vtnoa_'+i).text();
						}
						q_gt('workg', "where=^^ noa between '"+endnoa+"' and '"+$('#vtnoa_0').text()+"' ^^" , 0, 0, 0, "check_view", r_accy);
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('workg_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtUnorda').val('v');
				$('#txtBdate').focus();
				$('#cmbStype').val('1');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				var worked = false;
				for (var i = 0; i < q_bbsCount; i++) {
					if (!emp($('#txtWorkno_' + i).val()))
						worked = true;
				}
				//07/06 暫時不鎖
				/*if (worked && t_inmount > 0){
					alert('製令單已入庫-禁止修改排程單!!');
					return;
				}*/
				
				_btnModi();
				$('#txtProductno').focus();
				/*for (var i = 0; i < q_bbsCount; i++) {
					var t_where = "where=^^ cuano ='" + $('#txtNoa').val() + "' and cuanoq='" + $('#txtNoq_' + i).val() + "'^^";
					q_gt('work', t_where, 0, 0, 0, "modiwork_" + i, r_accy);
				}*/
			}

			function btnPrint() {
				q_box('z_workgp.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				//檢查noq 是否 重覆
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtNoq_'+i).val())){
						for (var j = i+1; j < q_bbsCount; j++) {
							if($('#txtNoq_'+i).val()==$('#txtNoq_'+j).val()){
								alert ('排程序號重複請修正!!')
								return;
							}
						}
					}
				}
				
				sum();
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workg') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if ((dec(as['forecastprepare'])+dec(as['mount']))==0) { ///0424 改成數量為0 就不儲存  !as['productno']
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function bbtSave(as) {
				if (!as['uno']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				if(q_cur==1){
					//預設vew的未展排未請購未送簽
					$('#vtunwork_0').text('v');
					$('#vtunordb_0').text('v');
					$('#vtunorda_0').text('v');					
				}
				
				var endnoa=''
				for (var i = 0; i < brwCount; i++) {
					if($('#vtnoa_'+i).text()!='')
						endnoa=$('#vtnoa_'+i).text();
				}
				q_gt('workg', "where=^^ noa between '"+endnoa+"' and '"+$('#vtnoa_0').text()+"' ^^" , 0, 0, 0, "check_view", r_accy);
				
				var t_where = "where=^^ cuano='" + $('#txtNoa').val() + "' and isnull(inmount,0)>0 ^^";
				q_gt('view_work', t_where, 0, 0, 0, "", r_accy);
				$('#div_row').hide();
				sum();
			}
			

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#btnOrde').attr('disabled', 'disabled');
					$('#btnWorkg').attr('disabled', 'disabled');
					$('#btnWorkg2ordb').removeAttr('disabled');
					$('#btnWorkPrint').removeAttr('disabled');
					$('#btnWork').removeAttr('disabled');
					$('#txtBdate').datepicker( 'destroy' );
					$('#txtEdate').datepicker( 'destroy' );
					$('#txtWbdate').datepicker( 'destroy' );
					$('#txtWedate').datepicker( 'destroy' );
					$('#txtSfbdate').datepicker( 'destroy' );
					$('#txtSfbdate').datepicker( 'destroy' );
					$('#copyunprepare').attr('disabled', 'disabled');
					$('#btnWorkReal').removeAttr('disabled');
				} else {
					$('#btnOrde').removeAttr('disabled');
					$('#btnWorkg').removeAttr('disabled');
					$('#btnWorkg2ordb').attr('disabled', 'disabled');
					$('#btnWorkPrint').attr('disabled', 'disabled');
					$('#btnWork').attr('disabled', 'disabled');
					$('#txtBdate').datepicker();
					$('#txtEdate').datepicker();
					$('#txtWbdate').datepicker();
					$('#txtWedate').datepicker();
					$('#txtSfbdate').datepicker();
					$('#txtSfedate').datepicker();
					$('#copyunprepare').removeAttr('disabled').prop('checked',false);
					$('#btnWorkReal').attr('disabled', 'disabled');
				}
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				$('#chkIscugu').attr('disabled', 'disabled');
				sum();
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					 $('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#btnMinus_' + i).bind('contextmenu',function(e) {
							e.preventDefault();
	                    	if(e.button==2){
								////////////控制顯示位置
								$('#div_row').css('top', e.pageY);
								$('#div_row').css('left', e.pageX);
								//////////////
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$('#div_row').show();
								//顯示選單
								row_b_seq = b_seq;
								//儲存選取的row
								row_bbsbbt = 'bbs';
								//儲存要新增的地方
							}
                    	});
						$('#txtWorkno_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtWorkno_' + b_seq).val())) {
								t_where = "cuano='" + $('#txtNoa').val() + "' and cuanoq='" + $('#txtNoq_' + b_seq).val() + "'";
								q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
							}
						});
						$('#txtWorkhno_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtWorkhno_' + b_seq).val())) {
								t_where = "cuano='" + $('#txtNoa').val() + "' and cuanoq='" + $('#txtNoq_' + b_seq).val() + "'";
								q_box("workh.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workh', "95%", "95%", q_getMsg('PopWorkh'));
							}
						});
						$('#txtOrdeno_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtOrdeno_' + b_seq).val())) {
								t_where = " charindex(noa,'" + $('#txtOrdeno_' + b_seq).val() + "')>0 ";
								
								q_gt('view_orde', "where=^^ "+t_where+" ^^ stop=1" , 0, 0, 0, "getorde", r_accy,1);
								var as = _q_appendData("view_orde", "", true);
								var t_stype='';
								if (as[0] != undefined) {
									t_stype=as[0].stype;
								}
								
								if(t_stype=='3' || t_stype=='4'){
									q_box("orde_r.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
								}else{
									q_box("orde_ad.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
								}
							}
						});
						
						$('#btnScheduled_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val())) {
								t_where = "noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
								q_box("z_scheduled.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
							}
						});
						
						$('#btnUnordemount_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "title='前期未交訂單' and bdate='"+$('#txtBdate').val()+"' and edate='"+$('#txtEdate').val()+"' and noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
							q_box("z_workgorde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
						});
						$('#btnOrdemount_' + i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "title='本期訂單' and bdate='"+$('#txtBdate').val()+"' and edate='"+$('#txtEdate').val()+"' and noa='"+$('#txtProductno_' + b_seq).val()+"' and product='"+$('#txtProduct_' + b_seq).val()+"' ";
							q_box("z_workgorde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'scheduled', "95%", "95%", q_getMsg('PopScheduled'));
						});

						$('#txtUnmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtOrdemount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtPlanmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtStkmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtIntmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtPurmount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#txtSalemount_' + i).blur(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1||q_cur==2)
								bbssum(b_seq);
						});
						$('#btnBorn_' + i).click(function(){
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var orde_deli = q_getPara('sys.key_orde');
							var thisOrdeno = $.trim($('#txtOrdeno_'+n).val());
							var t_ordeno = '';
							var t_no2 = '';
							if(thisOrdeno.length > 0){
								if(thisOrdeno.substring(0,orde_deli.length)==orde_deli){
									t_ordeno = thisOrdeno.substring(0,thisOrdeno.length-4);
									t_no2 = thisOrdeno.substr(t_ordeno.length+1);
									var t_where = "noa='" + t_ordeno + "' and no2='" + t_no2 + "'";
									q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn'));
								}
							}else{
								var t_noa = $.trim($('#txtNoa').val());
								var t_noq = padL((dec(n)+1), '0', 3);
								var t_where = "workgnoa='" + t_noa + "' and workgnoq='" + t_noq + "'";
								q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn'));
							}
						});
						
						$('#copyunprepare').click(function() {
							if(q_cur==1 || q_cur==2){
								for (var j = 0; j < q_bbsCount; j++) {
									if(!emp($('#txtProductno_'+j).val())){
										if($('#copyunprepare').prop('checked')){
												q_tr('txtForecastprepare_'+j,q_float('txtUnprepare_'+j));
										}else{
											q_tr('txtForecastprepare_'+j,0);
										}
									}			
								}
							}
						});
					}
				}
				_bbsAssign();
				$('#lblNoq_s').text('排程序號');
				var hasStyle = q_getPara('sys.isstyle');
				var isStyle = (hasStyle.toString()=='1'?$('.isStyle').show():$('.isStyle').hide());
				sum();
			}

			function bbssum(seq) {
				if (seq>-1) {
					//計算//1030226將計畫生產移到後面
					//0408計算拿掉由使用者自行輸入
					/*var t_availmount = q_float('txtStkmount_' + seq) - q_float('txtUnmount_' + seq) - q_float('txtOrdemount_' + seq);
					$('#txtAvailmount_' + seq).val(t_availmount);
					var t_opmount = t_availmount + q_float('txtIntmount_' + seq) + q_float('txtPurmount_' + seq) - q_float('txtSalemount_' + seq) - q_float('txtPlanmount_' + seq);

					if (t_opmount < 0)
						$('#txtMount_' + seq).val((t_opmount * -1));
					else
						$('#txtMount_' + seq).val(0);*/
					//沒有訂單號碼指定開工日寫入明天的日期
					/*if(emp($('#txtOrdeno_' + seq).val())&&q_float('txtMount_'+ seq)>0)
						$('#txtCuadate_' + seq).val(q_cdn(q_date(),1));*/
				}
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
					}
				}
				_bbtAssign();
			}

			function sum() {
				var t_omount=0;
				var t_bmount=0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_bmount=q_add(t_bmount,dec($('#txtMount_'+j).val()));
				}
				$('#textBmount').val(t_bmount);
				
				var ttorde=new Array();
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtOrdeno_'+i).val())){
						if(ttorde.length==0){
							ttorde.push({
								'ordeno':$('#txtOrdeno_'+i).val(),
								'omount':dec($('#txtOrdemount_'+i).val())
							});
						}else{
							var isexists=false;
							for(var j=0;j<ttorde.length;j++){
								if(ttorde[j].ordeno==$('#txtOrdeno_'+i).val()){
									isexists=true;
									break;
								}
							}
							if(!isexists){
								ttorde.push({
									'ordeno':$('#txtOrdeno_'+i).val(),
									'omount':dec($('#txtOrdemount_'+i).val())
								});
							}
						}
					}
				}
				
				for (var j = 0; j < ttorde.length; j++) {
					t_omount=q_add(t_omount,dec(ttorde[j].omount));
				}
				
				$('#textOmount').val(t_omount);
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
				if (t_inmount > 0)
					alert('製令單已入庫不能刪除!!');
				else
					_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			function q_popPost(id) {
				switch (id) {
					case 'txtProductno_':
						$('#txtClass_' + b_seq).focus();
						break;
					default:
						break;
				}
			}
			function q_funcPost(t_func, result) {
				if (t_func == 'qtxt.query.workrealall') {
					$('#btnWorkReal').removeAttr('disabled');
					var as = _q_appendData('tmp0','',true,true);
					if (as[0] != undefined) {
	                	if(as[0].total>0){
	                		if(as[0].total==as[0].ctotal){
	                			alert("模擬製令成功轉成正式製令!!\n共轉換"+as[0].ctotal+"張");
	                		}else{
	                			alert("模擬製令成功轉成正式製令!!\n共轉換"+as[0].ctotal+"張\n尚有"+q_sub(dec(as[0].total),dec(as[0].ctotal))+"張簽核尚未完成，不轉正式製令!!");
	                		}
	                	}else{
	                		alert("無模擬製令需轉成正式製令!!");
	                	}
					}
					var s2=new Array('workg_s',"where=^^noa<='"+$('#txtNoa').val()+"' ^^ ");
					q_boxClose2(s2);
				}
				if (t_func == 'workg.genWork') {
					var workno = result.split(';')
					for (var j = 0; j < q_bbsCount; j++) {
						abbsNow[j]['workno'] = workno[(j * 3) + 1];
						$('#txtWorkno_' + j).val(workno[(j * 3) + 1]);
						abbsNow[j]['rworkdate'] = workno[(j * 3) + 2];
						$('#txtRworkdate_' + j).val(workno[(j * 3) + 2]);
						abbsNow[j]['workhno'] = workno[(j * 3) + 3];
						$('#txtWorkhno_' + j).val(workno[(j * 3) + 3]);
					}
					alert('製令產出執行完畢!!');
					$('#vtunwork_'+q_recno).text('');
					$('#btnWork').val('製令產出').removeAttr('disabled');
					var obj = $('#tview').find('#noa');
					var t_noa=$.trim($('#txtNoa').val());
					for(var i=0;i<obj.length;i++){
						if(obj.eq(i).html()==t_noa){
							$('#tview').find('#unordb').eq(i).html('v');
							break;                                      
						}
					}
				}
			}
			
			var row_bbsbbt = '';
			//判斷是bbs或bbt增加欄位
			var row_b_seq = '';
			//判斷第幾個row
			//插入欄位
			function q_bbs_addrow(bbsbbt, row, topdown) {
				//取得目前行
				var rows_b_seq = dec(row) + dec(topdown);
				if (bbsbbt == 'bbs') {
					q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
					//目前行的資料往下移動
					for (var i = q_bbsCount - 1; i >= rows_b_seq; i--) {
						for (var j = 0; j < fbbs.length; j++) {
							if (i != rows_b_seq)
								$('#' + fbbs[j] + '_' + i).val($('#' + fbbs[j] + '_' + (i - 1)).val());
							else
								$('#' + fbbs[j] + '_' + i).val('');
						}
					}
				}
				if (bbsbbt == 'bbt') {
					q_gridAddRow(bbtHtm, 'tbbt', fbbt, 1, '', '', '', '__');
					//目前行的資料往下移動
					for (var i = q_bbtCount - 1; i >= rows_b_seq; i--) {
						for (var j = 0; j < fbbt.length; j++) {
							if (i != rows_b_seq)
								$('#' + fbbt[j] + '__' + i).val($('#' + fbbt[j] + '__' + (i - 1)).val());
							else
								$('#' + fbbt[j] + '__' + i).val('');
						}
					}
				}
				$('#div_row').hide();
				row_bbsbbt = '';
				row_b_seq = '';
			}
		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				border-width: 0px;
				width: 575px;
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
				width: 695px;
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
				/*width: 15%;*/
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
				width: 99%;
				float: left;
			}
			.txt.c2 {
				width: 46%;
				float: left;
			}
			.txt.c3 {
				width: 35%;
				float: left;
			}
			.txt.c4 {
				width: 63%;
				float: left;
			}
			.num {
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
				font-size:medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs {
				width: 2000px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
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
			#dbbt {
				width: 900px;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1px;
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
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row" class="table_row" style="width:100%;" border="1" cellpadding='1' cellspacing='0'>
				<tr><td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td></tr>
				<tr><td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td></tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="width: 1270px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:24px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:102px; color:black;"><a id='vewNoa'> </a></td>
						<!--<td style="width:80px; color:black;"><a id='vewStype'> </a></td>-->
						<!--<td style="color:black;"><a id='vewProduct'> </a></td>-->
						<td style="width:150px; color:black;"><a id='vewWrang'> </a></td>
						<td style="width:50px; color:black;"><a id='vewUnwork'> </a></td>
						<td style="width:50px; color:black;"><a id='vewUnordb'> </a></td>
						<td style="width:50px; color:black;"><a id='vewUnorda'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<!--<td align="center" id='stype=workg.stype'>~stype=workg.stype</td>-->
						<!--<td id='product' style="text-align: center;">~product</td>-->
						<td id='wbdate wedate' style="text-align: center;">~wbdate - ~wedate</td>
						<td id='unwork' style="text-align: center;">~unwork</td>
						<td id='unordb' style="text-align: center;">~unordb</td>
						<td id='unorda' style="text-align: center;">~unorda</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height: 1px;">
						<td style="width: 146px;"> </td>
						<td style="width: 111px;"> </td>
						<td style="width: 126px;"> </td>
						<td style="width: 111px;"> </td>
						<td style="width: 111px;"> </td>
						<td style="width: 180px;"> </td>
					</tr>
					<tr>
						<td style="display:none;">
							<input type="text" style="display:none;" id="txtUnwork">
							<input type="text" style="display:none;" id="txtUnordb">
							<input type="text" style="display:none;" id="txtUnorda">
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td style="display: none;"><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td style="display: none;"><select id="cmbStype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblBdate" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtBdate" type="text" class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c2"/>
						</td>
						<td><input id="btnOrde" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWadate" class="lbl"> </a></td>
						<td><input id="txtWadate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWbdate" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtWbdate" type="text" class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtWedate" type="text" class="txt c2"/>
						</td>
						<td><input id="btnImport" type="button"/></td>
					</tr>
					<tr style="display: none;">
						<td> </td>
						<td colspan="2"><span> </span><a id="lblSfdate" class="lbl" > </a></td>
						<td colspan="2">
							<input id="txtSfbdate" type="text" class="txt c2"/>
							<a style="float: left;">~</a>
							<input id="txtSfedate" type="text" class="txt c2"/>
						</td>
						<td><input id="btnWorkg" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td colspan="2"><input id="txtOrdeno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtCustno" type="text" class="txt c3"/>
							<input id="txtComp" type="text" class="txt c4"/>
						</td>
						<td><input id="btnWorkgv" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtProductno" type="text" class="txt c3"/>
							<input id="txtProduct" type="text" class="txt c4"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblFactno" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtFactno" type="text" class="txt c3"/>
							<input id="txtFact" type="text" class="txt c4"/>
						</td>
						<td><input id="btnWork" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="4">
							<!--<input id="txtMemo" type="text" class="txt c1"/>-->
							<textarea id="txtMemo" rows='5' cols='10' style="width:97%; height: 50px;"> </textarea>
						</td>
						<td><input id="btnWorkg2ordb" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdbno" class="lbl btn"> </a></td>
						<td colspan="4">
							<input id="txtOrdbno" type="text" class="txt c1"/>
							<input id="txtOrdano" type="text" class="txt c1" style="display: none;"/>
						</td>
						<td><input id="btnWorkgg" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
						<td colspan="2"><input id="btnWorkReal" type="button"/></td>
					</tr>
					<tr>
						<!--<td><span> </span><a class="lbl">每日製品入庫數</a></td>
						<td><input id="txtMon" type="text" class="txt num c1"/></td>-->
						<!--<input id="btnUindate" type="button" value="寫入預估入庫日"/>-->
						<td><span> </span><a id="lblOmount" class="lbl"> </a></td>
						<td><input id="textOmount" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblBmount"  class="lbl"> </a></td>
						<td><input id="textBmount" type="text" class="txt num c1"/></td>
						<td align="center">
							<span> </span><a id="lblRealwork" class="lbl"> </a>
							<input id="chkIscugu" type="checkbox" style="float: right;"/>
						</td>
						<td><input id="btnWorkPrint" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt num c1"/></td>
						<td colspan="3"><input id="btnBbscut" type="button"/></td>
						<td><input id="btnWorkg_jo" type="button"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:20px;"> </td>
						<td style="width:70px;"><a id='lblNoq_s'> </a></td>
						<td style="width:150px;"><a id='lblOrdeno_s'> </a></td>
						<td style="width:100px;"><a id='lblOdatea_s'> </a></td>
						<td style="width:85px;"><a id='lblRworkdate_s'> </a></td>
						<td style="width:140px;"><a id='lblProductno_s'> </a></td>
						<td style="width:210px;"><a id='lblProduct_s'> </a></td>
						<td style="width:95px;" align="center" class="isStyle"><a id='lblStyle_s'> </a></td>
						<!--<td style="width:90px;" class="sf"><a id='lblSaleforecast_s'> </a></td>
						<td style="width:90px;" class="sf"><a id='lblPrepare_s'> </a></td>
						<td style="width:90px;" class="sf"><a id='lblUnprepare_s'> </a></td>
						<td style="width:140px;" class="sf">
							<a id='lblForecastprepare_s' style="color: red;font-weight: bold;"> </a>
							<input id="copyunprepare" type="checkbox">
						</td>
						<td style="width:110px;"><a id='lblUnmount_s'> </a></td>-->
						<td style="width:110px;"><a id='lblOrdemount_s'> </a></td>
						<!--<td style="width:80px;"><a id='lblStkmount_s'> </a></td>
						<td style="width:80px;"><a id='lblAvailmount_s'> </a></td>
						<td style="width:110px;"><a id='lblIntmount_s'> </a></td>
						<td style="width:80px;"><a id='lblPurmount_s'> </a></td>-->
						<!--<td style="width:80px;"><a id='lblBornmount_s'> </a></td>-->
						<!--<td style="width:120px;"><a id='lblSalemount_s'> </a></td>
						<td style="width:100px;display: none;"><a id='lblPlanmount_s'> </a></td>-->
						<td style="width:110px;">
							<a id='lblMount_s' style="color: red;font-weight: bold;"> </a>
						</td>
						
						<!--<td style="width:130px;"><a id='lblStation_s'> </a></td>-->
						<!--<td style="width:100px;"><a id='lblDayborn_s'> </a></td>-->
						<td style="width:180px;"><a id='lblWorkno_s'> </a></td>
						<!--<td style="width:180px;"><a id='lblWorkhno_s'> </a></td>
						<td style="width:50px;"><a id='lblRank_s'> </a></td>-->
						<td style="width:90px;">
							<a id='lblUindate_s'> </a>/<a id='lblIndate_s'> </a>
						</td>
						<td style="width:90px;"><a id='lblCompdate_s'> </a></td>
						<td style="width:80px;"><a id='lblInmount_s'> </a></td>
						<td style="width:100px;"><a id='lblWmount_s'> </a></td>
						<td><a id='lblMemo_s'> </a></td>
						<td style="width:50px;"><a id='lblEnda_s'> </a></td>
						<td style="width:50px;"><a id='lblIsfreeze_s'> </a></td>
						<td style="width:40px;"><a id='lblBorn_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center"><input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/></td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td align="center"><input id="txtNoq.*" type="text" class="txt c1"/></td>
						<td><input id="txtOrdeno.*" type="text" class="txt c1 orde odm"/></td>
						<td><input id="txtOdatea.*" type="text" class="txt c1 orde odm"/></td>
						<td><input id="txtRworkdate.*" type="text" class="txt c1"/></td>
						<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
						<td>
							<input id="txtProduct.*" type="text" class="txt c1"/>
							<input id="txtSpec.*" type="text" class="txt c1"/>
						</td>
						<td class="isStyle"><input class="txt c1" id="txtStyle.*" type="text"/></td>
						<!--<td class="sf"><input id="txtSaleforecast.*" type="text" class="txt c1 num safo"/></td>
						<td class="sf"><input id="txtPrepare.*" type="text" class="txt c1 num safo"/></td>
						<td class="sf"><input id="txtUnprepare.*" type="text" class="txt c1 num safo"/></td>
						<td class="sf"><input id="txtForecastprepare.*" type="text" class="txt c1 num safo sam"/></td>
						<td>
							<input id="txtUnmount.*" type="text" class="txt c1 num orde" style="width: 80px;"/>
							<input class="btn" id="btnUnordemount.*" type="button" value='.' style=" font-weight: bold;" />
						</td>-->
						<td>
							<input id="txtOrdemount.*" type="text" class="txt c1 num orde" style="width: 80px;"/>
							<input class="btn" id="btnOrdemount.*" type="button" value='.' style=" font-weight: bold;" />
						</td>
						<!--<td><input id="txtStkmount.*" type="text" class="txt c1 num orde"/></td>
						<td><input id="txtAvailmount.*" type="text" class="txt c1 num orde"/></td>
						<td>
							<input id="txtIntmount.*" type="text" class="txt c1 num orde" style="width: 80px;"/>
							<input class="btn" id="btnScheduled.*" type="button" value='.' style=" font-weight: bold;" />
						</td>
						<td><input id="txtPurmount.*" type="text" class="txt c1 num orde"/></td>-->
						<!--<td><input id="txtBornmount.*" type="text" class="txt c1 num"/></td>-->
						<!--<td><input id="txtSalemount.*" type="text" class="txt c1 num orde"/></td>
						<td style="display: none;"><input id="txtPlanmount.*" type="text" class="txt c1 num orde"/></td>-->
						<td><input id="txtMount.*" type="text" class="txt c1 num orde odm"/></td>
						
						<!--<td>
							<input id="txtStationno.*" type="text" class="txt c1" style="width: 70%"/>
							<input id="btnStation.*" type="button" style="float:left;font-size: medium; font-weight: bold;" value="."/>
							<input id="txtStation.*" type="text" class="txt c1"/>
						</td>-->
						<!--<td><input id="txtDayborn.*" type="text" class="txt c1 num"/></td>-->
						<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
						<!--<td><input id="txtWorkhno.*" type="text" class="txt c1"/></td>
						<td><input id="txtRank.*" type="text" class="txt c1" style="text-align: center;"/></td>-->
						<td>
							<input id="txtUindate.*" type="text" class="txt c1 orde odm"/>
							<input id="txtIndate.*" type="text" class="txt c1"/>
						</td>
						<td><input id="txtCuadate.*" type="text" class="txt c1"/></td>
						<td><input id="txtInmount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWmount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td><input id="chkEnda.*" type="checkbox"/></td>
						<td><input id="chkIsfreeze.*" type="checkbox"/></td>
						<td align="center"><input class="btn" id="btnBorn.*" type="button" value='.' style=" font-weight: bold;" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt' style="display: none;">
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:160px; text-align: center;"><a id='lblOrdeno_t'> </a></td>
					<td style="width:40px; text-align: center;"><a id='lblNo2_t'> </a></td>
					<td style="width:120px; text-align: center;"><a id='lblProductno_t'> </a></td>
					<td style="width:180px; text-align: center;"><a id='lblProduct_t'> </a></td>
					<td style="width:95px; text-align: center;" class="isStyle"><a id='lblStyle_t'> </a></td>
					<td style="width:100px; text-align: center;"><a id='lblSalemount_t'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtOrdeno..*" type="text" class="txt c1"/></td>
					<td><input id="txtNo2..*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td><input id="txtProduct..*" type="text" class="txt c1"/></td>
					<td class="isStyle"><input id="txtStyle..*" type="text" class="txt c1"/></td>
					<td><input id="txtSalemount..*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>
