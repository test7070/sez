<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_workgorde');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_workgorde',
                    options : [ {
							type : '0', //[1]
							name : 'xtitle',
							value : q_getHref()[1]
						},{
                        	type : '1', //[2][3]
                        	name : 'xdate'
                    	},{
	                        type : '2',//[4][5]
	                        name : 'xproduct',
	                        dbf : 'ucc',
	                        index : 'noa,product',
	                        src : 'ucc_b.aspx'
	                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				$('.q_report .option:first').css('width','700px')
				$('#Xproduct').css('width','690px');
				$('#Xproduct .c2').css('width','130px');
				$('#Xproduct .c3').css('width','130px');
				$('#txtXdate1').datepicker();
				$('#txtXdate1').mask(r_picd);
				$('#txtXdate2').datepicker();
				$('#txtXdate2').mask(r_picd);
				
                var t_key = q_getHref();
				if (t_key != undefined){
					$('#txtXdate1').val(t_key[3]);
					$('#txtXdate2').val(t_key[5]);
					$('#txtXproduct1a').val(t_key[7]);
					$('#txtXproduct2a').val(t_key[7]);
					$('#txtXproduct1b').val(t_key[9]);
					$('#txtXproduct2b').val(t_key[9]);
					$('#btnOk').click();
				}
				
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