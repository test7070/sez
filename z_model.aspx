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
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}

			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_model');
			});

			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_model',
					options : [{
						type : '0',
						name : 'accy',
						value : r_accy
					},{
						type : '2',//[2][3]
						name : 'xmodelno',
						dbf : 'model',
						index : 'noa,model',
						src : 'model_b.aspx'
					},{
                    	type : '8',//[4]
						name : 'xshowenda',
						value : "1@過期未保養,2@即將保養,3@已保養".split(',')
					}, {
						type : '2',//[5][6]
						name : 'xmodgno',
						dbf : 'modg',
						index : 'noa,namea',
						src : 'modg_b.aspx'
					},{
                        type : '1', //[7][8]
                        name : 'xdate'
                    },{
						type : '2',//[9][10]工作站區間
						name : 'xstation',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					}]
				});
				q_popAssign();
				
				$('#chkXshowenda input').click(function(){ 
					var tcheck=$(this).val(); 
					$('#chkXshowenda input').each(function() {
						if(tcheck!=$(this).val()){ 
							$(this).prop('checked',false)
						}
					})   
				})
			}
			function q_boxClose(s2) {
			}
			function q_gtPost(s2) {
			}
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
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