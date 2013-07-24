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
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911)+"_1";
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_acccp2');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_acccp2',
                    options : [{/*  [1]*/
                        type : '0',
                        name : 'accy',
                        value : r_accy + "_" + r_cno
                    },{/*  [2]*/
                        type : '0',
                        name : 'xrank',
                        value : r_rank
                    }, {/*1  [3],[4]*/
                        type : '1',
                        name : 'xaccc3'
                    }]
                });
                q_popAssign();
                q_langShow();

                var t_accc3=typeof(q_getId()[3])=='undefined'?'':q_getId()[3];
                t_accc3  =  t_accc3.replace('accc3=','');
                $('#txtXaccc31').val(t_accc3);
                $('#txtXaccc32').val(t_accc3);
            }
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>