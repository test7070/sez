<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            var t_carteam = null;
            var t_calctypes = null;
            
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_tmp2tran');
            });
			
            function q_gfPost() {
                q_gt('carteam', '', 0, 0, 0, "load_1");
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'load_1':
                        t_carteam = '';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_carteam += (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_gt('calctype2', '', 0, 0, 0, "load_2");
                        break;
                    case 'load_2':
                        t_calctypes = '';
                        var as = _q_appendData("calctypes", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_calctypes += (t_calctypes.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                        }
                        LoadFinish();
                        break;
                    default:
                        break;
                }
            }
            function LoadFinish() {
            	$('#q_report').q_report({
                    fileName : 'z_tmp2tran',
                    options : [{/*[1]-年度*/
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {/*1  [2][3]*/
                        type : '1',
                        name : 'xdate'
                    }, {/*2  [4][5]*/
                        type : '1',
                        name : 'xtrandate'
                    }, {/*3 [6]*/
                        type : '6',
                        name : 'xcustno'
                    }, {/*4 [7]*/
                        type : '6',
                        name : 'xcarno'
                    }, {/*5-[8]-車隊*/
                        type : '8',
                        name : 'xcarteam',
                        value : t_carteam.split(',')
                    }, {/*6-[9]-計算類別*/
                        type : '8',
                        name : 'xcalctype',
                        value : t_calctypes.split(',')
                    }, {/*7 [10]*/
                        type : '6',
                        name : 'xnoa'
                    }, {/*8 [11]*/
						type : '5',
						name : 'xsort01',
						value : q_getMsg('tsort01').split('&')
					}]
                });
                $('#txtXdate1').mask('999/99/99');
                $('#txtXdate1').datepicker();
                $('#txtXdate2').mask('999/99/99');
                $('#txtXdate2').datepicker();
                $('#txtXtrandate1').mask('999/99/99');
                $('#txtXtrandate1').datepicker();
                $('#txtXtrandate2').mask('999/99/99');
                $('#txtXtrandate2').datepicker();
                
                $('#chkXcarteam').children('input').attr('checked', 'checked');
                $('#chkXcalctype').children('input').attr('checked', 'checked');
                if(q_getId()[5]!=undefined)
                	$('#txtXnoa').val(q_getId()[5].replace('noa=',''));
                q_popAssign();
                q_langShow();
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