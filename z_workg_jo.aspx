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
				
				$('#txtInmount2').change(function() {
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

				});
				
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
					
					var t_inmount2=dec($('#txtInmount2').val());
					if(isNaN(t_inmount2))
						t_inmount2=0;
						
					var t_qcmount=dec($('#txtQcmount').val());
					if(isNaN(t_qcmount))
						t_qcmount=0;
						
					var t_wmount=dec($('#txtWmount').val());
					if(isNaN(t_wmount))
						t_wmount=0;
						
					var t_fixmount=dec($('#txtFixmount').val());
					if(isNaN(t_fixmount))
						t_fixmount=0;
					
					if($('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')!=''){
						var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						q_func('qtxt.query.workg_jo_put', 'z_workg_jo.txt,workg_jo_put,' + encodeURI($('#txtWorkno').val()) + ';'+ encodeURI(t_mount) + ';' + encodeURI(q_date()) + ';' + encodeURI(t_timea) + ';'+ encodeURI(r_accy) + ';' + encodeURI(r_userno) + ';' + encodeURI(r_name) 
						+ ';' + encodeURI(t_team)+ ';' + encodeURI(t_inmount2)+ ';' + encodeURI(t_wmount)+ ';' + encodeURI(t_fixmount)+ ';' + encodeURI(t_qcmount) );
						$('#div_in').hide();	
					}else{
						alert("【"+$('#txtWorkno').val()+"】是模擬製令不得入庫!!");
					}
				});
				
				$('#btnOK2_div_in').click(function() {
					var t_mount=dec($('#txtBmount').val());
					var t_team=emp($('#txtTeam').val())?'#non':$('#txtTeam').val();
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
						q_func('qtxt.query.workg_jo_pul', 'z_workg_jo.txt,workg_jo_pul,' + encodeURI($('#txtWorkno').val()) + ';'+ encodeURI(t_mount) + ';' + encodeURI(q_date()) + ';' + encodeURI(t_timea) + ';'+ encodeURI(r_accy) + ';' + encodeURI(r_userno) + ';' + encodeURI(r_name) 
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
				
				$('#btnOk').click(function() {
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
				if(workno.id.length>0){
					$('#txtWorkno').val(workno.id);
					$('#div_in').css('top', $(workno).offset().top+60);
					$('#div_in').css('left', $(workno).offset().left);
					
					q_gt('view_work', "where=^^noa='"+workno.id+"'^^", 0, 0, 0, "");
				}
			}
			
			function workshow(workno) {
				if(workno.id.length>0){
					$('#div_work').css('top', 300);
					$('#div_work').css('left', $(workno).offset().left+50);
					$('#div_work').show();
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
					<td style="background-color: #99eeee;width: 105px;" align="center">上工段移入數</td>
					<td style="background-color: #99eeee;width: 95px;"><input id="txtInmount2" style="font-size: medium;width:95%;text-align: right;"></td>
					<td style="background-color: #99eeee;width: 105px;" align="center">上工段QC數</td>
					<td style="background-color: #99eeee;width: 95px;"><input id="txtQcmount" style="font-size: medium;width:95%;text-align: right;"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">製品名稱</td>
					<td style="background-color: #f8d463;"><input id="txtProduct" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: #99eeee;" align="center">報廢數</td>
					<td style="background-color: #99eeee;" colspan="3"><input id="txtWmount" style="font-size: medium;width:50%;text-align: right;"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">工作線號</td>
					<td style="background-color: #f8d463;"><input id="txtStationno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: #99eeee;" align="center">維修入庫數</td>
					<td style="background-color: #99eeee;" colspan="3"><input id="txtFixmount" style="font-size: medium;width:50%;text-align: right;"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">工作線名</td>
					<td style="background-color: #f8d463;"><input id="txtStation" style="font-size: medium;width: 98%;" disabled="disabled"></td>
					<td style="background-color: #99eeee;" align="center" >本次入庫數量</td>
					<td style="background-color: #99eeee;" colspan="3">
						<input id="txtMount" style="font-size: medium;width:50%;text-align: right;">
						<input id="btnOK_div_in" type="button" value="入庫" style="font-size: medium;">
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">排程數量</td>
					<td style="background-color: #f8d463;"><input id="txtWorkmount" style="font-size: medium;width: 50%;text-align: right;" disabled="disabled"></td>
					<td style="background-color: #ffffaa;" align="center">本次退件數量</td>
					<td style="background-color: #ffffaa;" colspan="3">
						<input id="txtBmount" style="font-size: medium;width:50%;text-align: right;">
						<input id="btnOK2_div_in" type="button" value="退件" style="font-size: medium;">
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">已入庫量</td>
					<td style="background-color: #f8d463;"><input id="txtInmount" style="font-size: medium;width: 50%;text-align: right;" disabled="disabled"></td>
					<td style="background-color: #ffffaa;" align="center">退件原因</td>
					<td style="background-color: #ffffaa;" colspan="3">
						<input id="txtWmemo" style="font-size: medium;width:260px;">
						<select id="cmbWmemo" style="font-size: medium;width:20px;"> </select>
					</td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">未入庫量</td>
					<td style="background-color: #f8d463;"><input id="txtUnmount" style="font-size: medium;width: 50%;text-align: right;" disabled="disabled"></td>
					<td colspan="4" style="text-align: center;"><input id="btnClose_div_in" type="button" value="關閉視窗" style="font-size: medium;"></td>
				</tr>
			</table>
		</div>
		
		<div id="div_work" style="position:absolute; top:300px; left:400px; display:none; width:1220px; background-color: #CDFFCE; border: 5px solid gray; z-index: 9;">
			<table id="table_work" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="font-size: 20px;" colspan="8" align="center">流程卡</td>
				</tr>
				<tr>
					<td style="width: 105px;" align="left">訂單編號<br>SỐ ĐƠN TIÊU</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">訂序<br>SỐ THỨ TỰ</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">預交日<br>DỰ TÍNH NGÀY GIAO</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">客戶編號<br>KHÁCH HÀNG CUỐI</td>
					<td style="width: 200px;"> </td>
				</tr>
				<tr>
					<td style="width: 105px;" align="left">排產編號<br>MÃ CÔNG LỆNH</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">訂單日期<br>NGÀY KHỞI CÔNG</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">開工日<br>NGÀY HOÀN THÀNH</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">THỨ</td>
					<td style="width: 200px;"> </td>
				</tr>
				<tr>
					<td style="width: 105px;" align="left">製成品編號<br>SỐ MÃ KIỆN</td>
					<td style="width: 200px;" colspan="3"> </td>
					<td style="width: 105px;" align="left">生產數<br>SL KHỞI CÔNG</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">訂單數<br>SL ĐƠN HÀNG</td>
					<td style="width: 200px;"> </td>
				</tr>
				<tr>
					<td style="width: 105px;" align="left">型號<br>MÃ HÀNG</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">TC CHẤT LƯỢNG</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">SỐ THỨ TỰ ĐƠN</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="left">TỔNG SỐ ĐƠN TÁCH</td>
					<td style="width: 200px;"> </td>
				</tr>
				<tr>
					<td style="height: 300px;" colspan="3">件號中文名稱：<BR>件號越文名稱：</td>
					<td style="" colspan="2">包裝說明及正側嘜：<BR>總工時：</td>
					<td style="" colspan="3"> </td>
				</tr>
				<tr>
					<td style="width: 105px;" align="right">大生管：<br>CHỦ QUẢN SINH QUẢN</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="right">小生管：<br>NHÂN VIÊN SINH QUẢN</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="right">原料倉：<br>KHO NGUYÊN LIỆU</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="right">備料員：<br>NHÂN VIÊN BỊ LIỆU</td>
					<td style="width: 200px;"> </td>
				</tr>
				<tr>
					<td style="width: 105px;" align="right">生產組別：<br>TỔ SẢN XUẤT</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="right">包裝明細：<br>CHI TIẾT ĐÓNG GÓI</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="right">品保：<br>KCS</td>
					<td style="width: 200px;"> </td>
					<td style="width: 105px;" align="right">移轉接收人：<br>NGƯỜI TIẾP NHẬN</td>
					<td style="width: 200px;"> </td>
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