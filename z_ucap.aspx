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
		aPop = new Array(['txtXproductno', '', 'uca', 'noa,product', 'txtXproductno', 'ucaucc_b.aspx']
		);
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_ucap');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_ucap',
                    options : [{
                        type : '0',
                        name : 'accy',
                        value : r_accy
                    },{
                        type : '6',
                        name : 'xproductno'
                    }, {
                        type : '2',
                        name : 'spno',
                        dbf : 'uca',
                        index : 'noa,product',
                        src : 'uca_b.aspx'
                    },{
                        type : '6',
                        name : 'xmon'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtXmon').mask('999/99');
                $('#txtXmon').val(q_date().substr(0,6));
                
                if(window.parent.q_name=='uca'){
	                var wParent = window.parent.document;
	                $('#txtSpno1a').val(wParent.getElementById("txtNoa").value);
					$('#txtSpno2a').val(wParent.getElementById("txtNoa").value);
					$('#txtSpno1b').val(wParent.getElementById("txtProduct").value);
					$('#txtSpno2b').val(wParent.getElementById("txtProduct").value);
					$('#txtXproductno').val(wParent.getElementById("txtNoa").value);
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