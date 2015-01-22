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
          	var t_part,t_pro;
          	
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_acbej');
            });
			
			
            function q_gfPost() {
                q_gt('acpart', '', 0, 0, 0, "init1", r_accy+'_'+r_cno);
            }
			
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'init1':
                        t_part = '';
                        var as = _q_appendData("acpart", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_gt('proj', '', 0, 0, 0, "init2");
                        break;
					case 'init2':
                        t_proj = '';
                        var as = _q_appendData("proj", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_proj += (t_proj.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].proj;
                        }
                        initfinish();
                        break;
                    default:
                    	break;
                }
            }
            function initfinish(){
            	$('#q_report').q_report({
                    fileName : 'z_acbej',
                    options : [ {/*1 [1],[2]*/
                        type : '1',
                        name : 'xmon'
                    }, {/*2 [3]*/
                        type : '8',
                        name : 'xproj',
                        value : t_proj.split(',')
                    }, {/*3 [4]*/
                        type : '8',
                        name : 'xpart',
                        value : t_part.split(',')
                    }]
                });
                q_popAssign();
                $('#txtXmon1').mask('999/99');
                $('#txtXmon2').mask('999/99');
                
            }
            function q_boxClose(t_name) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
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