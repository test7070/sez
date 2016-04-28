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
           if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_workmp');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_workmp',
	                        options : [{
							type : '0',
							name : 'accy',
	                        value : r_accy
	                    },{
	                        type : '6',
	                        name : 'xnoa'
	                    }, {
							type : '1', //[3][4]
							name : 'xdate'
						}, {
							type : '2', //[5][6]
							name : 'xproduct',
							dbf : 'uca',
							index : 'noa,product',
							src : 'uca_b.aspx'
						}, {
							type : '2', //[7][8]
							name : 'xprocess',
							dbf : 'process',
							index : 'noa,process',
							src : 'process_b.aspx'
						},{
	                        type : '6',
	                        name : 'xstyle'
	                    }]
                    });
                q_popAssign();
               if(window.parent.q_name=='workm'){
					var wParent = window.parent.document;
					var t_noa= wParent.getElementById("txtNoa").value;
					$('#txtXnoa').val(t_noa);
				}
				if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
				//$('#txtXdate').datepicker();
				//$('#txtXdate').mask(r_picd);
				//$('#txtXdate').val(q_date());
				$('#txtXdate1').datepicker().mask(r_picd);
				$('#txtXdate2').datepicker().mask(r_picd);
				$('#txtXdate1').val(q_date());
				$('#txtXdate2').val(q_cdn(q_date(),15));
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
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
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
           
          