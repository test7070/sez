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
                q_gf('', 'z_uccst');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_uccst',
                    options : [{
	                        type : '1',
	                        name : 'xdate'
	                    }, {
	                        type : '2',
	                        name : 'xproduct',
	                        dbf : 'ucaucc',
	                        index : 'noa,product',
	                        src : 'ucaucc_b.aspx'
	                    }, {
							type : '0',
							name : 'accy',
							value : q_getId()[4]
	                    },{
	                        type : '6',
	                        name : 'xedate'
	                    },{
	                        type : '1',
	                        name : 'xordeno'
						}, {
							type : '5',
							name : 'xstktype',
							value : [q_getPara('report.all')].concat(q_getPara('sys.stktype').split(','))
	                    }
                    ]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();

                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
                
                $('#txtXedate').mask('999/99/99');
                $('#txtXedate').val(q_date());
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }
		</script>
		<style type="text/css">
			.q_report .option {
				width: 600px;
			}
			.q_report .option div.a1 {
				width: 580px;
			}
			.q_report .option div.a2 {
				width: 220px;
			}
			.q_report .option div .label {
				font-size:medium;
			}
			.q_report .option div .text {
				font-size:medium;
			}
			.q_report .option div .cmb{
				height: 22px;
				font-size:medium;
			}
			.q_report .option div .c2 {
				width: 80px;
			}
			.q_report .option div .c3 {
				width: 110px;
			}
		</style>
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