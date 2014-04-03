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
                q_gf('', 'z_ordcp');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_ordcp',
                    options : [{/* [1]*/
						type : '0',
						name : 'accy',
                        value : q_getId()[4] 
                    },{/* [2]*/
                        type : '0',
                        name : 'xkind',
                        value : q_getPara('ordc.kind')
                    },{/*1 [3][4]*/
                        type : '1',
                        name : 'xdate'
                    },{/*2 [5][6]*/
                        type : '1',
                        name : 'xnoa'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
                var t_para = (typeof (q_getId()[3]) == 'undefined' ? '' : q_getId()[3]).split('&');
                for(var i=0;i<t_para.length;i++){
                    if(t_para[i].indexOf('noa=') >= 0){
                        t_no = t_para[i].replace('noa=', '');
                        if (t_no.length > 0) {
                            $('#txtXnoa1').val(t_no);
                            $('#txtXnoa2').val(t_no);
                        }
                    }    
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