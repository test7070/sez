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
            t_isinit = false;
            t_part = '';
            aPop = new Array(['txtXpart', '', 'part', 'part,noa', 'txtXpart', "part_b.aspx"]);
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_umm');
            });
            function q_gfPost() {
                q_gt('part', '', 0, 0, 0);
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'part':
                        t_part = '';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        break;
                }

                if (!t_isinit && t_part.length > 0) {
                    $('#q_report').q_report({
                        fileName : 'z_umm',
                        options : [{
                            type : '0',
                            name : 'accy',
                            value : q_getId()[4]
                        }, {/*1*/
                            type : '1',
                            name : 'date'
                        }, {/*2*/
                            type : '1',
                            name : 'mon'
                        }, {/*3*/
                            type : '2',
                            name : 'cust',
                            dbf : 'cust',
                            index : 'noa,comp',
                            src : 'cust_b.aspx'
                        }, {/*4*/
                            type : '8',
                            name : 'xpart',
                            value : t_part.split(',')
                        }, {/*5*/
                            type : '6',
                            name : 'xdate'
                        }]
                    });
                    q_popAssign();
                    $('#txtDate1').mask('999/99/99');
                    $('#txtDate1').datepicker();
                    $('#txtDate2').mask('999/99/99');
                    $('#txtDate2').datepicker();
                    $('#txtMon1').mask('999/99');
                    $('#txtMon2').mask('999/99');
					$('#txtXdate').mask('999/99/99');
                    $('#txtXdate').datepicker();	
                }
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
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

