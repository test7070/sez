<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_workg_jo');
			});
			
			var intervalupdate; //自動更新
			
			aPop = new Array(
				['txtYstation', 'lblYstation', 'station', 'noa,station', 'txtYstation', 'station_b.aspx']
			);
			
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_workg_jo',
					options : [{
						type : '0', //[1]
						name : 'accy',
						value : q_getId()[4]
					}, {
						type : '0', //[2]
						name : 'r_userno',
						value : r_userno
					}, {
						type : '0', //[3]
						name : 'r_name',
						value : r_name
					}, {
						type : '0', //[4]
						name : 'r_rank',
						value : r_rank
					}, {
						type : '6', //[5]
						name : 'xcuanoa'
					}, {
						type : '6', //[6]
						name : 'xcuanoq'
					}, {
						type : '8', //[7]
						name : 'xunenda',
						value : '1@'.split(',')
					},{
                        type : '2',//[8][9]
                        name : 'xstation',
                        dbf : 'station',
                        index : 'noa,station',
                        src : 'station_b.aspx'
                     }, {
						type : '6', //[10]
						name : 'xmount'
					}, {
						type : '8', //[11]
						name : 'xrealwork',
						value : '1@'.split(',')
					}, {
						type : '6', //[12]
						name : 'xdate'
					}, {
						type : '6', //[13]
						name : 'ystation'
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                //$('#Xunenda').css('width','300px');
                //$('#Xunenda').css('height','30px');
                //$('#chkXunenda').css('margin-top','5px');
                //$('#Xunenda .label').css('width','0px');
                
                $('#txtXcuanoq').val('001');
                
                $('#txtXdate').mask(r_picd);
                $('#txtXdate').val(q_date());
                
                //預設值
                $('#txtXmount').val('600');
                $('#txtXmount').keyup(function() {
                	$(this).val(dec($(this).val()));
                	if(isNaN($(this).val()))
                		$(this).val(0);
				});
                
				var t_key = q_getHref();
				if (t_key[1] != undefined) {
					$('#txtXcuanoa').val(t_key[1]);
				}
				
				if(r_rank<"8"){
					q_gt('sss', "where=^^noa='"+r_userno+"'^^", 0, 0, 0, "getSalesgroup");
				}
				
				
				$('#txtMount').change(function() {
					var t_mount=dec($('#txtMount').val());
					if(isNaN(t_mount))
						t_mount=0;
					$('#txtMount').val(t_mount);
					
				});
				
				$('#txtBmount').change(function() {
					var t_mount=dec($('#txtBmount').val());
					if(isNaN(t_mount))
						t_mount=0;
					$('#txtBmount').val(t_mount);
					
				});
				
				/*$('#txtInmount2').change(function() {
					var t_mount=dec($('#txtInmount2').val());
					if(isNaN(t_mount))
						t_mount=0;
					$('#txtInmount2').val(t_mount);

				});
				
				$('#txtQcmount').change(function() {
					var t_mount=dec($('#txtQcmount').val());
					if(isNaN(t_mount))
						t_mount=0;
					$('#txtQcmount').val(t_mount);

				});*/
				
				$('#txtWmount').change(function() {
					var t_mount=dec($('#txtWmount').val());
					if(isNaN(t_mount))
						t_mount=0;
					$('#txtWmount').val(t_mount);
					
				});
				
				$('#txtFixmount').change(function() {
					var t_mount=dec($('#txtFixmount').val());
					if(isNaN(t_mount))
						t_mount=0;
					$('#txtFixmount').val(t_mount);
				});
				
				$('#cmbWmemo').change(function() {
					$('#txtWmemo').val($('#cmbWmemo').find("option:selected").text());
				});
				
				$('#btnOK_div_in').click(function() {
					var t_mount=dec($('#txtMount').val());
					var t_team=emp($('#txtTeam').val())?'#non':$('#txtTeam').val();
					if(isNaN(t_mount))
						t_mount=0;
					if(t_mount<=0){
						alert('請輸入入庫數量!!')
						return;
					}
					
					/*var t_inmount2=dec($('#txtInmount2').val());
					if(isNaN(t_inmount2))
						t_inmount2=0;
						
					var t_qcmount=dec($('#txtQcmount').val());
					if(isNaN(t_qcmount))
						t_qcmount=0;*/
					
					//106/12/18 改為上階層明細
					var t_inmount2='',t_qcmount='';
					$('.in_workno').each(function(index) {
						var n=$(this).attr('id').split('_')[2];
						t_inmount2+=(t_inmount2.length>0?'##':'')+$('#in_txtWorkno_'+n).val()+'@@'+dec($('#in_txtInmount2_'+n).val());
						t_qcmount+=(t_qcmount.length>0?'##':'')+$('#in_txtWorkno_'+n).val()+'@@'+dec($('#in_txtQcmount_'+n).val());
					});	
						
					var t_wmount=dec($('#txtWmount').val());
					if(isNaN(t_wmount))
						t_wmount=0;
						
					var t_fixmount=dec($('#txtFixmount').val());
					if(isNaN(t_fixmount))
						t_fixmount=0;
						
					var t_worker=$('#txtWorker').val();
					if(t_worker.length==0){
						t_worker=r_name;
					}
					
					var t_chkmount2='0';
					if($('#chkMount2').prop('checked')){
						t_chkmount2='1';
					}
					
					var t_m2workno='#non';
					if($('#cmbWorkno').val()!=null){
						if($('#cmbWorkno').val().length>0){
							t_m2workno=$('#cmbWorkno').val();
						}
					}
					
					if($('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')!=''){
						var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						q_func('qtxt.query.workg_jo_put', 'z_workg_jo.txt,workg_jo_put,' + encodeURI($('#txtWorkno').val()) + ';'+ encodeURI(t_mount) + ';' + encodeURI(q_date()) + ';' + encodeURI(t_timea) + ';'+ encodeURI(r_accy) + ';' + encodeURI(r_userno) + ';' + encodeURI(t_worker) 
						+ ';' + encodeURI(t_team)+ ';' + encodeURI(t_inmount2)+ ';' + encodeURI(t_wmount)+ ';' + encodeURI(t_fixmount)+ ';' + encodeURI(t_qcmount)+';'+t_chkmount2+';'+encodeURI(t_m2workno));
						$('#div_in').hide();	
					}else{
						alert("【"+$('#txtWorkno').val()+"】是模擬製令不得入庫!!");
					}
				});
				
				$('#btnOK2_div_in').click(function() {
					var t_mount=dec($('#txtBmount').val());
					var t_team=emp($('#txtTeam').val())?'#non':$('#txtTeam').val();
					var t_worker=emp($('#txtWorker').val())?r_name:$('#txtWorker').val();
					if(isNaN(t_mount))
						t_mount=0;
					if(t_mount<=0){
						alert('請輸入退件數量!!')
						return;
					}
					
					var t_wmemo=$('#txtWmemo').val();
					if(t_wmemo.length==0){
						t_wmemo='#non';
					}
					
					if($('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')!=''){
						var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						q_func('qtxt.query.workg_jo_pul', 'z_workg_jo.txt,workg_jo_pul,' + encodeURI($('#txtWorkno').val()) + ';'+ encodeURI(t_mount) + ';' + encodeURI(q_date()) + ';' + encodeURI(t_timea) + ';'+ encodeURI(r_accy) + ';' + encodeURI(r_userno) + ';' + encodeURI(t_worker) 
						+ ';' + encodeURI(t_team)+ ';' + encodeURI(t_wmemo));
						$('#div_in').hide();	
					}else if(dec($('#txtInmount').val())<=0){
						alert("【"+$('#txtWorkno').val()+"】入庫量小於零不得退件!!");
					}else{
						alert("【"+$('#txtWorkno').val()+"】是模擬製令不得退件!!");
					}
				});
				
				$('#btnClose_div_in').click(function() {
					$('#div_in').hide();
				});
				
				$("#chkXunenda [type='checkbox']").click(function() {
					if($(this).prop('checked')){
						$('#txtXcuanoa').val('');
						$('#txtXcuanoq').val('');
					}else{
						var t_key = q_getHref();
						if (t_key[1] != undefined) {
							$('#txtXcuanoa').val(t_key[1]);
						}
					}
					
				});
				
				$('#btnOk').click(function() {
					var radind=$('#q_report').data('info').radioIndex;
					var t_report=$('#q_report').data('info').reportData[radind].report;
					
					//解除自動更新
					intervalupdate = setInterval(";");
					for (var i = 0 ; i < intervalupdate ; i++) {
					    clearInterval(i); 
					}
					
					if(t_report=='z_workg_jo03' && !emp($('#txtXdate').val()) && !emp($('#txtYstation').val())){
						intervalupdate=setInterval("autoOk()",1000*60); //1分鐘
					}else{
						$('#div_in').hide();
						$('#div_work').hide();
					}
					
				});
				
				$('#frameReport').bind('DOMSubtreeModified', function() { 
					var radind=$('#q_report').data('info').radioIndex;
					var t_report=$('#q_report').data('info').reportData[radind].report;
					if(t_report=='z_workg_jo03' && $('#frameReport table').length>0 && !emp($('#txtYstation').val())){ //有表再執行
						updatework();
					}
				});
				
				//107/05/28 尾箱
				$('#chkMount2').click(function() {
					if($('#chkMount2').prop('checked')){
						$('#cmbWorkno').val('');
						$('#cmbWorkno').attr('disabled', 'disabled');
					}else{
						$('#cmbWorkno').removeAttr('disabled');
					}
				});
				
				//107/05/28 尾箱補滿
				$('#cmbWorkno').change(function() {
					if($('#cmbWorkno').val().length>0){
						$('#cmbWorkno').prop('checked',false);
						$('#chkMount2').attr('disabled', 'disabled');
					}else{
						$('#chkMount2').removeAttr('disabled');
					}
				});
			}
			
			function autoOk() {
				$('#btnOk').click();
			}
			
			var d_workshow=false;
			function updatework() {
				//取得目前時間
				var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2)+':'+padL(new Date().getSeconds() ,'0',2);
				d_workshow=false;
				$('#frameReport table button').each(function(index) {
					var t_id=$(this).attr('id');
					var t_workno=t_id.split('##')[0];
					var t_datea=t_id.split('##')[1];
					var t_nos=t_id.split('##')[2];
					var t_nom=t_id.split('##')[3];
					var t_noq=t_id.split('##')[4];
					var t_btime=t_id.split('##')[5];
					var t_etime=t_id.split('##')[6];
					
					if(t_timea>=t_btime && t_timea<=t_etime && !d_workshow){
						workshow($(this)[0]);
						d_workshow=true;
						/*$(this).parent().parent().css('background','lightpink');*/
					}else{
						//$(this).parent().parent().css('background','');
					}
				});
				
				
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
				switch (s2) {
					case 'getSalesgroup':
						var as = _q_appendData("sss", "", true);
						if (as[0] != undefined) {
							if(as[0].isclerk=="true"){
								$('#txtXstation1a').attr('disabled', 'disabled');
								$('#txtXstation2a').attr('disabled', 'disabled');
								$('#btnXstation1').hide();
								$('#btnXstation2').hide();
								$('#txtXstation1a').val(as[0].salesgroup);
								$('#txtXstation1b').val('');
								$('#txtXstation2a').val(as[0].salesgroup);
								$('#txtXstation2b').val('');
								q_gt('station', "where=^^noa='"+as[0].salesgroup+"'^^", 0, 0, 0, "getSation");
							}
						}
						break;
					case 'getSation':
						var as = _q_appendData("station", "", true);
						if (as[0] != undefined) {
							$('#txtXstation1b').val(as[0].station);
							$('#txtXstation2b').val(as[0].station);
						}
						break;
					case 'view_work':
						var as = _q_appendData("view_work", "", true);
						if (as[0] != undefined) {
							$('#txtProductno').val(as[0].productno);
							$('#txtProduct').val(as[0].product);
							$('#txtStationno').val(as[0].stationno);
							$('#txtStation').val(as[0].station);
							$('#txtWorkmount').val(as[0].mount);
							$('#txtInmount').val(as[0].inmount);
							$('#txtUnmount').val(q_sub(dec(as[0].mount),dec(as[0].inmount)));
							
							//106/12/18 清除textbox
							$('#txtTeam').val('');
							//$('#txtInmount2').val('');
							//$('#txtQcmount').val('');
							$('#txtWmount').val('');
							$('#txtFixmount').val('');
							$('#txtMount').val('');
							$('#txtBmount').val('');
							$('#txtWmemo').val('');
							$('#txtWorker').val(r_name);
							
							//107/05/28 尾箱,補滿內容
							$('#chkMount2').prop('checked',false);
							$('#cmbWorkno').text('');
							q_cmbParse("cmbWorkno", '@');
							if($('#txtWorkno').val().slice(-1).toUpperCase()=='A'){
								$('.mount2').show();
								$('#chkMount2').removeAttr('disabled');
								$('#cmbWorkno').removeAttr('disabled');
								
								q_gt('view_workbs', "where=^^ isnull(mount2,0)>0 and exists (select * from view_work a left join view_orde b on a.ordeno=b.noa where isnull(b.enda,0)!=1 and isnull(b.cancel,0)!=1  and view_workbs"+r_accy+".workno=a.noa) ^^", 0, 0, 0, "getm2workno",r_accy,1);
								var bas = _q_appendData("view_workbs", "", true);
								var t_item='@';
								for (var i = 0; i < bas.length; i++) {
									t_item = t_item + (t_item.length > 0 ? ',' : '') + bas[i].workno+'@'+bas[i].workno+' 尾箱:'+bas[i].mount2;
								}
								$('#cmbWorkno').text('');
								q_cmbParse("cmbWorkno", t_item);
							}else{
								$('.mount2').hide();
							}
							
							//取得上工段移入數
							var twork=[];
							q_gt('view_work', "where=^^previd='"+as[0].noa+"'^^", 0, 0, 0, "getInmount2",r_accy,1);
							var tas = _q_appendData("view_work", "", true);
							if (tas[0] != undefined) {								
								for (var i = 0; i < tas.length; i++) {
									twork.push({
										workno:tas[i].noa, 
										ordeno:tas[i].ordeno,
										no2:tas[i].no2,
										cuanoa:tas[i].cuano,
										cuanoq:tas[i].cuanoq,
										productno:tas[i].productno,
										product:tas[i].product,
										spec:tas[i].spec,
										unit:tas[i].unit,
										stationno:tas[i].stationno,
										station:tas[i].station,
										mount:tas[i].mount,
										inmount:tas[i].inmount,
									});
								}
							}
							
							var rowslength=document.getElementById("table_in").rows.length-10; //10 不刪除的行數
							for (var j = 0; j < rowslength; j++) {
								document.getElementById("table_in").deleteRow(9);
							}
							
							if(twork.length>0){
								
								var in_row=0;
								var tmp = document.getElementById("table_in_bottom");
								for (var i = 0; i < twork.length; i++) {
									var tr = document.createElement("tr");
									tr.id = "in_"+i;
									tr.innerHTML = "<td style='background-color: oldlace;' align='center'>製令編號</td>";
									tr.innerHTML += "<td style='background-color: oldlace;'><input id='in_txtWorkno_"+i+"' class='in_workno' type='text' style='font-size: medium;width:98%;' value='"+twork[i].workno+"' disabled='disabled'/></td>";
									tr.innerHTML += "<td style='background-color: oldlace;' align='center'>排程單號</td>";
									tr.innerHTML += "<td style='background-color: oldlace;' colspan='3'><input id='in_txtCuano_"+i+"' type='text' style='font-size: medium;width:98%;' value='"+twork[i].cuanoa+'-'+twork[i].cuanoq+"' disabled='disabled'/></td>";
									tmp.parentNode.insertBefore(tr,tmp);
									
									var tr = document.createElement("tr");
									tr.id = "in_"+i;
									tr.innerHTML = "<td style='background-color: oldlace;' align='center'>訂單編號</td>";
									tr.innerHTML += "<td style='background-color: oldlace;'><input id='in_txtOrdeno_"+i+"' type='text' style='font-size: medium;width:98%;' value='"+twork[i].ordeno+'-'+twork[i].no2+"' disabled='disabled'/></td>";
									tr.innerHTML += "<td style='background-color: oldlace;' align='center'>物品編號</td>";
									tr.innerHTML += "<td style='background-color: oldlace;' colspan='3'><input id='in_txtProductno_"+i+"' type='text' style='font-size: medium;width:98%;' value='"+twork[i].productno+"' disabled='disabled'/></td>";
									tmp.parentNode.insertBefore(tr,tmp);
									
									var tr = document.createElement("tr");
									tr.id = "in_"+i;
									tr.innerHTML = "<td style='background-color: oldlace;' align='center'>物品名稱</td>";
									tr.innerHTML += "<td style='background-color: oldlace;'><input id='in_txtProduct_"+i+"' type='text' style='font-size: medium;width:98%;' value='"+twork[i].product+"' disabled='disabled'/></td>";
									tr.innerHTML += "<td style='background-color: oldlace;' colspan='4'> </td>";
									tmp.parentNode.insertBefore(tr,tmp);
									
									var tr = document.createElement("tr");
									tr.id = "in_"+i;
									tr.innerHTML = "<td style='background-color: oldlace;' align='center'>上工段線別</td>";
									tr.innerHTML += "<td style='background-color: oldlace;'><input id='in_txtStationno_"+i+"' type='text' style='font-size: medium;width:35%;' value='"+twork[i].stationno+"' disabled='disabled'/><input id='in_txtStation_"+i+"' type='text' style='font-size: medium;width:61%;' value='"+twork[i].station+"' disabled='disabled'/></td>";
									tr.innerHTML += "<td style='background-color: oldlace;width: 105px;' align='center'>上工段移入數</td>";
									tr.innerHTML += "<td style='background-color: oldlace;width: 95px;'><input id='in_txtInmount2_"+i+"' class='in_inmount' style='font-size: medium;width:95%;text-align: right;' value='"+twork[i].inmount+"' ></td>";
									tr.innerHTML += "<td style='background-color: oldlace;width: 105px;' align='center'>上工段QC數</td>";
									tr.innerHTML += "<td style='background-color: oldlace;width: 95px;'><input id='in_txtQcmount_"+i+"' class='in_qcmount' style='font-size: medium;width:95%;text-align: right;'></td>";
									tmp.parentNode.insertBefore(tr,tmp);
									
									//107/05/28 增加 退件
									var tr = document.createElement("tr");
									tr.id = "in_"+i;
									tr.innerHTML = "<td style='background-color: oldlace;' align='center'>退件原因</td>";
									tr.innerHTML += "<td style='background-color: oldlace;'><input id='in_txtWmemo_"+i+"' type='text' style='font-size: medium;width:85%;'/><select id='in_cmdWmemo_"+i+"' style='width:20px;' class='incmdwmemo'></select></td>";
									tr.innerHTML += "<td style='background-color: oldlace;' align='center'>退件數量</td>";
									tr.innerHTML += "<td style='background-color: oldlace;' colspan='3'><input id='in_txtBmount_"+i+"' class='in_bmount' type='text' style='font-size: medium;width:50%;text-align: right;' /><input type='button' id='in_btnout_"+i+"' class='in_outbtn' value='退件' style='font-size: medium;'></td>";
									tmp.parentNode.insertBefore(tr,tmp);
								}
							}
							
							$('.in_inmount').each(function(index) {
								$(this).change(function() {
									var t_mount=dec($(this).val());
									if(isNaN(t_mount))
										t_mount=0;
									$(this).val(t_mount);
								});
							});
							$('.in_qcmount').each(function(index) {
								$(this).change(function() {
									var t_mount=dec($(this).val());
									if(isNaN(t_mount))
										t_mount=0;
									$(this).val(t_mount);
								});
							});
							
							//107/05/28 增加 退件
							$('.incmdwmemo').each(function(index) {
								var n=$(this).attr('id').split('_')[2];
								$('#in_cmdWmemo_'+n).text('');
								var i_workno=$('#in_txtWorkno_'+n).val();
								
								q_gt('station', "where=^^noa=(select top 1 stationno from view_work where noa='"+i_workno+"')^^", 0, 0, 0, "getPart",r_accy,1);
								var as1 = _q_appendData("station", "", true);
								if (as1[0] != undefined) {
									if(as1[0].partno.length>0){
										q_gt('reason', "where=^^partno='"+as1[0].partno+"' and typea='workg'^^ ", 0, 0, 0, "getreason",r_accy,1);
										var as2 = _q_appendData("reasons", "", true);
										var t_item = "@";
										for (var i = 0; i < as2.length; i++) {
					                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as2[i].reason;
					                    }
					                    q_cmbParse("in_cmdWmemo_"+n, t_item);
									}else{
										q_gt('reason', "where=^^partno='' and typea='workg' ^^", 0, 0, 0, "getreason",r_accy,1);
										var as2 = _q_appendData("reasons", "", true);
										var t_item = "@";
										for (var i = 0; i < as2.length; i++) {
					                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as2[i].reason;
					                    }
					                    q_cmbParse("in_cmdWmemo_"+n, t_item);
									}
								}
								
								$(this).change(function() {
									var t_n=$(this).attr('id').split('_')[2];
									$('#in_txtWmemo_'+t_n).val($('#in_cmdWmemo_'+t_n).find("option:selected").text());
								});
								
							});
							
							$('.in_bmount').each(function(index) {
								$(this).change(function() {
									var t_mount=dec($(this).val());
									if(isNaN(t_mount))
										t_mount=0;
									$(this).val(t_mount);
								});
							});
							$('.in_outbtn').each(function(index) {
								$(this).click(function() {
									var n=$(this).attr('id').split('_')[2];
									var t_mount=dec($('#in_txtBmount_'+n).val());
									var t_team=emp($('#txtTeam').val())?'#non':$('#txtTeam').val();
									var t_worker=emp($('#txtWorker').val())?r_name:$('#txtWorker').val();
									var t_workno=$('#in_txtWorkno_'+n).val();
									if(t_workno.length==0){
										return;
									}
									
									if(isNaN(t_mount))
										t_mount=0;
									if(t_mount<=0){
										alert('請輸入退件數量!!')
										return;
									}
									
									var t_wmemo=$('#in_txtWmemo_'+n).val();
									if(t_wmemo.length==0){
										t_wmemo='#non';
									}
									
									if($('#in_txtWorkno_'+n).val().substr(1,1).replace(/[^\d]/g,'')!=''){
										var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
										q_func('qtxt.query.workg_jo_pul', 'z_workg_jo.txt,workg_jo_pul,' + encodeURI(t_workno) + ';'+ encodeURI(t_mount) + ';' + encodeURI(q_date()) + ';' + encodeURI(t_timea) + ';'+ encodeURI(r_accy) + ';' + encodeURI(r_userno) + ';' + encodeURI(t_worker) 
										+ ';' + encodeURI(t_team)+ ';' + encodeURI(t_wmemo));
										$('#div_in').hide();	
									}else if(dec($('#in_txtInmount2_'+n).val())<=0){
										alert("【"+$('#in_txtWorkno_'+n).val()+"】入庫量小於零不得退件!!");
									}else{
										alert("【"+$('#in_txtWorkno_'+n).val()+"】是模擬製令不得退件!!");
									}
								});
							});
							
							if(as[0].isfreeze=='true'){
								alert('製令已被凍結!!');
							}else if(q_sub(dec(as[0].mount),dec(as[0].inmount))>0){
								$('#cmbWmemo').text('');
								//讀取退件原因(先讀取工作線別的部門)
								q_gt('station', "where=^^noa='"+as[0].stationno+"'^^", 0, 0, 0, "getPart",r_accy,1);
								var as1 = _q_appendData("station", "", true);
								if (as1[0] != undefined) {
									if(as1[0].partno.length>0){
										q_gt('reason', "where=^^partno='"+as1[0].partno+"' and typea='workg'^^ ", 0, 0, 0, "getreason",r_accy,1);
										var as2 = _q_appendData("reasons", "", true);
										var t_item = "@";
										for (var i = 0; i < as2.length; i++) {
					                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as2[i].reason;
					                    }
					                    q_cmbParse("cmbWmemo", t_item);
									}else{
										q_gt('reason', "where=^^partno='' and typea='workg' ^^", 0, 0, 0, "getreason",r_accy,1);
										var as2 = _q_appendData("reasons", "", true);
										var t_item = "@";
										for (var i = 0; i < as2.length; i++) {
					                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as2[i].reason;
					                    }
					                    q_cmbParse("cmbWmemo", t_item);
									}
								}
								
								$('#div_in').show();
							}else{
								alert('製令已完工!!');
							}
							
						}else{
							alert('製令不存在!!');
						}
						break;
				} /// end switch
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.workg_jo_put':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if(as[0].err.length>0){
								alert(as[0].err);
							}else{
								q_func('worka_post.post', r_accy + ',' + as[0].workano + ',1');
								q_func('workb_post.post', r_accy + ',' + as[0].workbno + ',1');
								
								alert('入庫完畢，產生入庫單【'+as[0].workbno+'】!!');
								$('#txtMount').val('');
								$('#txtBmount').val('');
							}
						}else{
							alert('入庫失敗!!');	
						}
						break
					case 'qtxt.query.workg_jo_pul':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							if(as[0].err.length>0){
								alert(as[0].err);
							}else{
								q_func('worka_post.post', r_accy + ',' + as[0].workano + ',1');
								q_func('workb_post.post', r_accy + ',' + as[0].workbno + ',1');
								
								alert('退件完畢，產生退件單【'+as[0].workbno+'】!!');
								$('#txtMount').val('');
								$('#txtBmount').val('');
							}
						}else{
							alert('退件失敗!!');	
						}
						break
					default:
						break;
				}
			}
			
			function workin(workno) {
				var radind=$('#q_report').data('info').radioIndex;
				var t_report=$('#q_report').data('info').reportData[radind].report;
				$('#div_in').hide();
				if(workno.id.length>0){
					$('#txtWorkno').val(workno.id);
					$('#div_in').css('top', $(workno).offset().top+60);
					$('#div_in').css('left', $(workno).offset().left);
					
					if(t_report=='z_workg_jo03'){
						$('#div_in').css('top', $(workno).offset().top+30);
						$('#div_in').css('left', $(workno).offset().left-$('#div_in').width());
						
						if(workno.id!=$('#tdOrdeno').text()){
							workshow($(workno).parent().next().children()[0]);
						}
					}
					
					//107/05/28 尾箱,補滿內容
					$('#chkMount2').prop('checked',false);
					$('#cmbWorkno').text('');
					q_cmbParse("cmbWorkno", '@');
					$('#chkMount2').attr('disabled', 'disabled');
					$('#cmbWorkno').attr('disabled', 'disabled');
							
					q_gt('view_work', "where=^^noa='"+workno.id+"'^^", 0, 0, 0, "");
				}
			}
			
			function workshow(workno) {
				var t_workno=workno.id.split('##')[0];
				var t_datea=workno.id.split('##')[1];
				var t_nos=workno.id.split('##')[2];
				var t_nom=workno.id.split('##')[3];
				var t_noq=workno.id.split('##')[4];
				
				$('#frameReport table button').each(function(index) {
					$(this).parent().parent().css('background','');
				});
				
				$(workno).parent().parent().css('background','lightpink');
				
				if(t_workno.length>0 && t_workno != undefined){
					$('#div_work').css('top', 242);
					$('#div_work').css('left', $(workno).offset().left+50);
					
					q_func('qtxt.query.showworkg', 'z_workg_jo.txt,showworkg,' 
					+ encodeURI(t_workno) + ';'
					+ encodeURI(t_datea) + ';' 
					+ encodeURI(t_nos) + ';' 
					+ encodeURI(t_nom) + ';'
					+ encodeURI(t_noq) + ';'
					+ encodeURI(r_userno) + ';' + encodeURI(r_name),r_accy,1);
					var as = _q_appendData("tmp0", "", true, true);
					if (as[0] != undefined) {
						$('#tdOrdeno').text(as[0].ordeno);
						$('#tdOrdeno2').text(as[0].no2);
						$('#tdOrdedatea').text(as[0].ordedatea);
						$('#tdCustno').text(as[0].custno);
						$('#tdCuano').text(as[0].cuano);
						$('#tdOrdeodate').text(as[0].ordeodate);
						$('#tdWdatea').text(as[0].wdate);
						$('#tdProductno').text(as[0].productno);
						$('#tdBmount').text(as[0].bmount);
						$('#tdOmount').text(as[0].omount);
						$('#tdSpec').text(as[0].spec);
						$('#tdUca').html(as[0].uca);
						$('#tdMemo1').html(as[0].memo1);
						$('#tdMemo2').html(as[0].memo2);
						
						$('#div_work').show();
					}
				}
			}
			
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="div_in" style="position:absolute; top:300px; left:400px; display:none; width:800px; background-color: #CDFFCE; border: 5px solid gray; z-index: 9;">
			<table id="table_in" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 105px;" align="center" >製令編號</td>
					<td style="background-color: #f8d463;width: 295px;"><input id="txtWorkno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: #ffddff;width: 105px;" align="center">完工組別</td>
					<td style="background-color: #ffddff;width: 295px;" colspan="3"><input id="txtTeam" style="font-size: medium;width: 60%;text-align: left;"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">製品編號</td>
					<td style="background-color: #f8d463;"><input id="txtProductno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<!--107/05/28 寫入製單人-->
					<td style="background-color: #ffddff;width: 105px;" align="center">作業人員</td>
					<td style="background-color: #ffddff;width: 295px;" colspan="3"><input id="txtWorker" style="font-size: medium;width: 60%;text-align: left;"></td>
					
					<!--<td style="background-color: aliceblue;" colspan="4"> </td>-->
					<!--106/12/18 上工段需明細輸入-->
					<!--<td style="background-color: #99eeee;width: 105px;" align="center">上工段移入數</td>
					<td style="background-color: #99eeee;width: 95px;"><input id="txtInmount2" style="font-size: medium;width:95%;text-align: right;"></td>
					<td style="background-color: #99eeee;width: 105px;" align="center">上工段QC數</td>
					<td style="background-color: #99eeee;width: 95px;"><input id="txtQcmount" style="font-size: medium;width:95%;text-align: right;"></td>-->
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">製品名稱</td>
					<td style="background-color: #f8d463;"><input id="txtProduct" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: aliceblue;" colspan="4"> </td>
					<!--107/05/28不使用-->
					<td style="background-color: #99eeee;display: none;" align="center">維修入庫數</td>
					<td style="background-color: #99eeee;display: none;" colspan="3"><input id="txtFixmount" style="font-size: medium;width:50%;text-align: right;display: none;"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">工作線號</td>
					<td style="background-color: #f8d463;"><input id="txtStationno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: #99eeee;" align="center">報廢數</td>
					<td style="background-color: #99eeee;" colspan="3"><input id="txtWmount" style="font-size: medium;width:50%;text-align: right;"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">工作線名</td>
					<td style="background-color: #f8d463;"><input id="txtStation" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: #99eeee;" align="center" >本次入庫數量</td>
					<td style="background-color: #99eeee;" colspan="3">
						<input id="txtMount" style="font-size: medium;width:50%;text-align: right;">
						<input id="btnOK_div_in" type="button" value="入庫" style="font-size: medium;">
						<input id="chkMount2" type="checkbox" class="mount2" style="display: none;"><a class="mount2" style="display: none;">尾箱</a>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">排程數量</td>
					<td style="background-color: #f8d463;"><input id="txtWorkmount" style="font-size: medium;width: 50%;text-align: right;" disabled="disabled"></td>
					<td style="background-color: #ffffaa;" align="center"><a class="mount2" style="display: none;">尾箱補滿</a></td>
					<td style="background-color: #ffffaa;" colspan="3">
						<select id="cmbWorkno" style="font-size: medium;display: none;" class="mount2"> </select>
					</td>
					<!--107/05/28不使用-->
					<td style="background-color: #ffffaa;display: none;" align="center">本次退件數量</td>
					<td style="background-color: #ffffaa;display: none;" colspan="3">
						<input id="txtBmount" style="font-size: medium;width:50%;text-align: right;">
						<input id="btnOK2_div_in" type="button" value="退件" style="font-size: medium;">
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">已入庫量</td>
					<td style="background-color: #f8d463;"><input id="txtInmount" style="font-size: medium;width: 50%;text-align: right;" disabled="disabled"></td>
					<td style="background-color: aliceblue;" colspan="4"> </td>
					<!--107/05/28不使用-->
					<td style="background-color: #ffffaa;display: none;" align="center">退件原因</td>
					<td style="background-color: #ffffaa;display: none;" colspan="3">
						<input id="txtWmemo" style="font-size: medium;width:240px;">
						<select id="cmbWmemo" style="font-size: medium;width:20px;"> </select>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">未入庫量</td>
					<td style="background-color: #f8d463;"><input id="txtUnmount" style="font-size: medium;width: 50%;text-align: right;" disabled="disabled"></td>
					<td style="background-color: aliceblue;" colspan="4"> </td>
				</tr>
				<tr>
					<td colspan="6" style="height: 1px;background-color:grey;" > </td>
				</tr>
				
				<tr id="table_in_bottom">
					<td colspan="6" style="text-align: center;"><input id="btnClose_div_in" type="button" value="關閉視窗" style="font-size: medium;"></td>
				</tr>
			</table>
		</div>
		
		<div id="div_work" style="position:absolute; top:300px; left:400px; display:none; width:1120px; background-color: #CDFFCE; border: 5px solid gray; z-index: 9;font-size: 11pt;">
			<table id="table_work" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="font-size: 20px;" colspan="8" align="center">流程卡</td>
				</tr>
				<tr>
					<td style="width: 130px;" align="left">訂單編號<br>SỐ ĐƠN TIÊU</td>
					<td style="width: 150px;" id="tdOrdeno"> </td>
					<td style="width: 130px;" align="left">訂序<br>SỐ THỨ TỰ</td>
					<td style="width: 150px;" id="tdOrdeno2"> </td>
					<td style="width: 130px;" align="left">預交日<br>DỰ TÍNH NGÀY GIAO</td>
					<td style="width: 150px;" id="tdOrdedatea"> </td>
					<td style="width: 130px;" align="left">客戶編號<br>KHÁCH HÀNG CUỐI</td>
					<td style="width: 150px;" id="tdCustno"> </td>
				</tr>
				<tr>
					<td align="left">排產編號<br>MÃ CÔNG LỆNH</td>
					<td id="tdCuano"> </td>
					<td align="left">訂單日期<br>NGÀY KHỞI CÔNG</td>
					<td id="tdOrdeodate"> </td>
					<td align="left">開工日<br>NGÀY HOÀN THÀNH</td>
					<td id="tdWdatea"> </td>
					<td align="left">THỨ</td>
					<td> </td>
				</tr>
				<tr>
					<td align="left">製成品編號<br>SỐ MÃ KIỆN</td>
					<td colspan="3" id="tdProductno"> </td>
					<td align="left">生產數<br>SL KHỞI CÔNG</td>
					<td id="tdBmount"> </td>
					<td align="left">訂單數<br>SL ĐƠN HÀNG</td>
					<td id="tdOmount"> </td>
				</tr>
				<tr>
					<td align="left">型號<br>MÃ HÀNG</td>
					<td id="tdSpec"> </td>
					<td align="left">TC CHẤT LƯỢNG</td>
					<td> </td>
					<td align="left">SỐ THỨ TỰ ĐƠN</td>
					<td> </td>
					<td align="left">TỔNG SỐ ĐƠN TÁCH</td>
					<td> </td>
				</tr>
				<tr>
					<td style="height: 410px;" colspan="3" id="tdUca">件號中文名稱：<BR>件號越文名稱：</td>
					<td style="" colspan="2" id="tdMemo1">包裝說明及正側嘜：<BR>總工時：</td>
					<td style="" colspan="3" id="tdMemo2"> </td>
				</tr>
				<tr>
					<td align="right">大生管：<br>CHỦ QUẢN SINH QUẢN</td>
					<td> </td>
					<td align="right">小生管：<br>NHÂN VIÊN SINH QUẢN</td>
					<td> </td>
					<td align="right">原料倉：<br>KHO NGUYÊN LIỆU</td>
					<td> </td>
					<td align="right">備料員：<br>NHÂN VIÊN BỊ LIỆU</td>
					<td> </td>
				</tr>
				<tr>
					<td align="right">生產組別：<br>TỔ SẢN XUẤT</td>
					<td> </td>
					<td align="right">包裝明細：<br>CHI TIẾT ĐÓNG GÓI</td>
					<td> </td>
					<td align="right">品保：<br>KCS</td>
					<td> </td>
					<td align="right">移轉接收人：<br>NGƯỜI TIẾP NHẬN</td>
					<td> </td>
				</tr>
			</table>
		</div>
		
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>