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
			var t_title='',tt_title='';
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_authority');
            });
            function q_gfPost() {
            	if(q_gfTxt=='qlang.txt' && t_title.length==0){
            		tt_title=xmlString.split('^^');
            		for(var i=0 ;i<tt_title.length;i++){
            			t_title=t_title+tt_title[i].split(',')[0]+','+tt_title[i].split(',')[2]+'^^';
            		}
            		
            		$('#q_report').q_report({
	                    fileName : 'z_authority',
	                    options : [{
							type : '2', //[1][2]
							name : 'xsssno',
							dbf : 'nhpe',
							index : 'noa,namea',
							src : ''
						},{
							type : '0',//[3]
							name : 'xtitle',
                        	value :t_title
						}]
	                });
	                q_popAssign();
	                q_langShow();
	                var t_noa = q_getHref()[1];
	                var t_namea = q_getHref()[3];
	                t_noa = t_noa.replace('noa=', '');
	                $('#txtXsssno1a').val(t_noa);
	                $('#txtXsssno2a').val(t_noa);
	                $('#txtXsssno1b').val(t_namea);
	                $('#txtXsssno2b').val(t_namea);
            	}else{
	                q_gf('qlang.txt', 'qTitle');
            	}  
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

