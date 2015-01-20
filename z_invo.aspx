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
                q_gf('', 'z_invo');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_invo',
                    options : [{
						type : '0',//[1]
						name : 'accy',
                        value : q_getId()[4] 
                    },{
                        type : '1',//[2][3]
                        name : 'xnoa'
                    },{
						type : '1', //[4][5]
						name : 'xdate'
					},{
                        type : '2',//[6][7]
                        name : 'xcustno',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx' 
                    },{
                        type : '2',//[8][9]
                        name : 'xtggno',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx' 
                    },{
                        type : '6',//[10]
                        name : 'xcommodity'
                    },{
                        type : '6',//[11]
                        name : 'xcontract'
                    }, {
						type : '8', //[12]
						name : 'onlyunpay',
						value : "1@只印未收".split(',')
					}, {
						type : '5', //[13]
						name : 'im_export',
						value : "進口,出口".split(',')
					},{
                        type : '1',//[14][15]
                        name : 'xuno'
                    },{
                        type : '5', //[16]
						name : 'denominate',
						value : "1@數量,2@重量".split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('.q_report .option div .c6').css('width','90px');
                var t_key = q_getHref();
                if(t_key != undefined)
                	$('#txtXnoa').val(t_key[1]);
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