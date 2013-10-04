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
            if(location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;101";
            }
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_ordcst');
               
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_ordcst',
                    options : [{
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    },{
                        type : '1',
                        name : 'date'
                    },{
                        type : '1',
                        name : 'odate'
                    }, {
                        type : '2',
                        name : 'tgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'
                    }, {
                        type : '2',
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2',
                        name : 'product',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {
                        type : '5', 
                        name : 'stype',
                        value : [q_getPara('report.all')].concat(q_getPara('ordc.stype').split(','))
                    }, {
                        type : '5', 
                        name : 'tran',
                        value : [q_getPara('report.all')].concat(q_getPara('sys.tran').split(','))
                    }, {
                        type : '5', 
                        name : 'cancel',
                        value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
                    }, {
                        type : '5', 
                        name : 'end',
                        value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
 				$('#txtOdate1').mask('999/99/99');
                $('#txtOdate1').datepicker();
                $('#txtOdate2').mask('999/99/99');
                $('#txtOdate2').datepicker();
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