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
                q_gf('', 'z_workgp');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_workgp',
                        options : [{
						type : '0',
						name : 'accy',
                        value : r_accy
                    },{
                        type : '6',
                        name : 'xdate'
                    }, {
						type : '2',
						name : 'product',
						dbf : 'uca',
						index : 'noa,product',
						src : 'uca_b.aspx'
                    },{
						type : '5',
						name : 'monweek',
						value : ('1@週期,2@月份').split(',')
					},{
						type : '8',
						name : 'isorders',
						value : ('顯示訂單明細').split(',')
					}]
                    });
                q_popAssign();
               /*if(window.parent.q_name=='workg'){
					var wParent = window.parent.document;
					var t_noa= wParent.getElementById("txtNoa").value;
					$('#txtXnoa').val(t_noa);
				}*/
				$('.q_report .option:first').css('width','700px')
				$('#Xproduct').css('width','690px');
				$('#Xproduct .c2').css('width','130px');
				$('#Xproduct .c3').css('width','130px');
				$('#txtXdate').datepicker();
				$('#txtXdate').mask('999/99/99');
				//$('#txtXdate').val(q_date());
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
           
          