<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="/../script/jquery.min.js" type="text/javascript"></script>
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
            if(location.href.indexOf('?') < 0)// debug
            {
                location.href = location.href + "?;;;;101";
            }
            $(document).ready(function() {
                _q_boxClose();
                q_gf('', 'z_chgcash');
            });
            function q_gfPost() {
                q_func('car2.getItem', '3,4,5');
            }

            function q_boxClose(t_name) {
            }

            function q_gtPost(t_name) {
            }

            function q_funcPost(t_func, result) {
                if(result.substr(0, 5) == '<Data') {
                    var tmp = _q_appendData('carteam', '', true);
                    var t_carteam = '';
                    for(var z = 0; z < tmp.length; z++) {
                        t_carteam = t_carteam + (t_carteam.length > 0 ? ',' : '') + tmp[z].noa + '@' + tmp[z].team;
                    }
                    $('#qReport').q_report({
                        fileName : 'z_chgcash',
                        options : [{
                        type : '1',
                        name : 'date'
                    },{
                        type : '1',
                        name : 'mon'
                    },{
                        type : '2',
                        name : 'part',
                        dbf : 'part',
                        index : 'noa,part',
                        src : 'part_b.aspx'
                        },{
                        type : '2',
                        name : 'sss',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                        }]
                    });
                    q_getFormat();
                    q_langShow();
                    q_popAssign();

                    $('#txtMonth').mask('999/99');
                    $('#txtMon1').mask('999/99');
                    $('#txtMon2').mask('999/99');
                    $('#txtDate1').mask('999/99/99');
                    $('#txtDate1').datepicker();
                    $('#txtDate2').mask('999/99/99');
                    $('#txtDate2').datepicker();
                } else
                    alert('Error!' + '\r' + t_func + '\r' + result);
            }
		</script>
	</head>
	<body>
		<div id="container">
			<div id="qReport"></div>
		</div>
		<div class="prt" >
			<!--#include file="../inc/print_ctrl.inc"-->
		</div>
	</body>
</html>