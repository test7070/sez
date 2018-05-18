<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
				q_gf('', 'z_workkp');
			});
			
			$('#q_report').click(function(e) {
					if(q_getPara('sys.project').toUpperCase()!='JO' || q_getPara('sys.project').toUpperCase()!='AD'){
						var delete_report=999;
						for(var i=0;i<$('#q_report').data().info.reportData.length;i++){
							if($('#q_report').data().info.reportData[i].report=='z_Workkp06')
								delete_report=i;
						}
						if($('#q_report div div').text().indexOf('工令領料單')>-1){
							$('#q_report div div').eq(delete_report).hide();
						}
						delete_report=999;										
					}
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_workkp',
					options : [{
						type : '0',
						name : 'accy',
						value : q_getId()[4] //[1]
					}, {
						type : '6',
						name : 'xnoa'
					}, {
						type : '1',
						name : 'xdate'
					}, {
						type : '2',
						name : 'xstationno',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					}, {
						type : '2',
						name : 'xstationgno',
						dbf : 'stationg',
						index : 'noa,namea',
						src : 'stationg_b.aspx'
					},{
						type : '2',
						name : 'xproductno',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
						type : '2',
						name : 'xstoreno',
						dbf : 'store',
						index : 'noa,store',
						src : 'store_b.aspx'
					},{
						type : '0',
						name : 'r_len',
						value : r_len
					}, {
						type : '8',
						name : 'xissemi',
						value:'1@含半成品'.split(',')
					}]
				});
				q_popAssign();
				q_getFormat();
				q_langShow();
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask(r_picd);
				$('#txtXdate2').datepicker();
				$('.q_report .report').css('width','420px');
				$('.q_report .report div').css('width','200px');
				
				$('.q_report .option:first').css('width','700px');
				$('.q_report .option div.a1').css('width','690px');
				$('.q_report .option div .c2').css('width','130px');
				$('.q_report .option div .c3').css('width','130px');
				
				$('#Xnoa').css('width','340px');
				$('#txtXnoa').css('width','240px');
				
				$('#Xissemi').css('width','340px');
				$('#chkXissemi').css('width','300px');
				$('#Xissemi .label').css('width','0px')
				
				$('#txtXdate1').val(q_date().substr(0,r_lenm)+'/01');
	            $('#txtXdate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));

				var t_key = q_getHref();
				if (t_key != undefined)
					$('#txtXnoa').val(t_key[1]);
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(s2) {
			}
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>