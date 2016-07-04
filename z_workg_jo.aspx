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
						value : '1@未完工'.split(',')
					},{
                        type : '2',//[8][9]
                        name : 'xstation',
                        dbf : 'station',
                        index : 'noa,station',
                        src : 'station_b.aspx'
                     }]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
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
				$('#btnOK_div_in').click(function() {
					var t_mount=dec($('#txtMount').val());
					if(isNaN(t_mount))
						t_mount=0;
					if(t_mount>0){
						q_func('');
					}else{
						alert('請輸入入庫數量!!')
						return;
					}
					
					if($('#txtWorkno').val().substr(1,1).replace(/[^\d]/g,'')!=''){
						var t_timea=padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2);
						q_func('qtxt.query.workg_jo_put', 'z_workg_jo.txt,workg_jo_put,' + encodeURI($('#txtWorkno').val()) + ';'+ encodeURI(t_mount) + ';' + encodeURI(q_date()) + ';' + encodeURI(t_timea) + ';'+ encodeURI(r_accy) + ';' + encodeURI(r_userno) + ';' + encodeURI(r_name));
						$('#div_in').hide();	
					}else{
						alert("【"+$('#txtWorkno').val()+"】是模擬製令不得入庫!!");
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
							$('#txtUnmount').val(dec(as[0].mount)-dec(as[0].inmount));
							
							if(dec(as[0].mount)-dec(as[0].inmount)>0){
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
							}
						}else{
							alert('入庫失敗!!');	
						}
						break
					default:
						break;
				}
			}
			
			function workin(workno) {
				if(workno.id.length>0){
					$('#txtWorkno').val(workno.id);
					$('#div_in').css('top', $(workno).offset().top+20);
					$('#div_in').css('left', $(workno).offset().left);
					
					q_gt('view_work', "where=^^noa='"+workno.id+"'^^", 0, 0, 0, "");
				}
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="div_in" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray; z-index: 9;">
			<table id="table_in" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">製令編號</td>
					<td style="background-color: #f8d463;"><input id="txtWorkno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">製品編號</td>
					<td style="background-color: #f8d463;"><input id="txtProductno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">製品名稱</td>
					<td style="background-color: #f8d463;"><input id="txtProduct" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">工作線號</td>
					<td style="background-color: #f8d463;"><input id="txtStationno" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">工作線名</td>
					<td style="background-color: #f8d463;"><input id="txtStation" style="font-size: medium;width: 98%;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">排程數量</td>
					<td style="background-color: #f8d463;"><input id="txtWorkmount" style="font-size: medium;width: 60%;text-align: right;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">已入庫量</td>
					<td style="background-color: #f8d463;"><input id="txtInmount" style="font-size: medium;width: 60%;text-align: right;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">未入庫量</td>
					<td style="background-color: #f8d463;"><input id="txtUnmount" style="font-size: medium;width: 60%;text-align: right;" disabled="disabled"></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">本次入庫數量</td>
					<td style="background-color: #f8d463;"><input id="txtMount" style="font-size: medium;width: 60%;text-align: right;"></td>
				</tr>
				<tr>
					<td align="center" colspan='3'>
						<input id="btnOK_div_in" type="button" value="入庫" style="font-size: medium;">
						<input id="btnClose_div_in" type="button" value="關閉視窗" style="font-size: medium;">
					</td>
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