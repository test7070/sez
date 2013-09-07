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
			function z_accc() {
            }
            z_accc.prototype = {
                data : {
                    mon_accashf : null
                }
            };
            t_data = new z_accc();
            
			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_accashf');
			});
			function q_gfPost() {
				q_gt('accashf', '', 0, 0, 0, "init1");
			}
			function sortNumber(a, b){
				var n = parseInt(a.substring(0,3))*100+parseInt(a.substring(4,6));
				var m = parseInt(b.substring(0,3))*100+parseInt(b.substring(4,6));
				return m-n;
			}
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'init1':
                    	var as = _q_appendData("accashf", "", true);
                    	tmp = new Array();
                    	if(as[0]!=undefined){
	                        for ( i = 0; i < as.length; i++) {
	                        	if(as[i].mon.length>0 && tmp.indexOf(as[i].mon)<0){
	                        		tmp.push(as[i].mon);
	                        	}
	                        }
                        }
                        tmp.sort(sortNumber);
                        t_data.data['mon_accashf'] = '';
                        for(var i in tmp){
                        	t_data.data['mon_accashf'] += (t_data.data['mon_accashf'].length > 0 ? ',' : '') + tmp[i];
                        }
                        initfinish();
                    	break;
                }
            }
			function initfinish(){
				$('#q_report').q_report({
					fileName : 'z_accashf',
					options : [{
						type : '0',
						name : 'accy',
						value : q_getId()[4]
					},{
						type : '5',
						name : 'mon_accashf',
						value : t_data.data['mon_accashf'].split(',')
					}]
				});
				q_popAssign();
                q_langShow();

				var t_noa=typeof(q_getId()[3])=='undefined'?'':q_getId()[3];
				$('#txtXnoa').val(t_noa);
			}
			function q_boxClose(t_name) {
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