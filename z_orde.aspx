<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
            var acompItem = '';
            $(document).ready(function() {
                q_getId();
                q_gt('acomp', '', 0, 0, 0, "");
            });
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        acompItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            acompItem = acompItem + (acompItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_gf('', 'z_orde');
                        break;
                }
            }

            function q_gfPost() {
                $('#qReport').q_report({
                    fileName : 'z_orde',
                    options : [{
                        type : '0', //[1]
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '1', //[2][3]
                        name : 'xdate'
                    }, {
                        type : '1', //[4][5]
                        name : 'xodate'
                    }, {
                        type : '2', //[6][7]
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {
                        type : '2', //[8][9]
                        name : 'xsales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {
                        type : '2', //[10][11]
                        name : 'xproduct',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                    }, {
                        type : '5', //[12]
                        name : 'xstype',
                        value : [q_getPara('report.all')].concat(q_getPara('orde.stype').split(','))
                    }, {
                        type : '5', //[13]
                        name : 'xtran',
                        value : [q_getPara('report.all')].concat(q_getPara('sys.tran').split(','))
                    }, {
                        type : '5', //[14]
                        name : 'xcancel',
                        value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
                    }, {
                        type : '5', //[15]
                        name : 'xend',
                        value : [q_getPara('report.all')].concat(new Array('1@Y', '0@N'))
                    },{
                        type : '5', //[16]
                        name : 'xcno',
                        value : acompItem.split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
                $('#txtXodate1').mask('999/99/99');
                $('#txtXodate1').datepicker();
                $('#txtXodate2').mask('999/99/99');
                $('#txtXodate2').datepicker();
            }

            function q_boxClose(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="qReport"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>