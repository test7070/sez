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
                q_gf('', 'z_workp');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_workp',
                    options : [{
						type : '0',
						name : 'accy',
                        value : q_getId()[4] //[1]
                    },{
                        type : '1',
                        name : 'xnoa' //[2][3]
                    },{
                        type : '1',
                        name : 'xdate' //[4] [5]
                    }, {
                        type : '2',
                        name : 'xtgg',
                        dbf : 'tgg',
                        index : 'noa,comp',
                        src : 'tgg_b.aspx'//[6][7]
                    },{
                        type : '6',
                        name : 'xcuano' //[8]
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#txtXdate1').datepicker().mask('999/99/99');
                $('#txtXdate2').datepicker().mask('999/99/99');
                var t_key = q_getHref();
                //抓製令單號
                if(window.parent.q_name=='workg'){
					if(t_key[1] != undefined){
						var t_where = "where=^^ cuano='"+t_key[1]+"'^^";
						q_gt('work', t_where, 0, 0, 0, "", r_accy);
					}
				}else{
					if(t_key[1] != undefined)
                	$('#txtXnoa1').val(t_key[1]);
				}
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            	switch (s2) {
                	case 'work':
                		var as = _q_appendData("work", "", true);
                		if(as[0]!=undefined){
                			$('#txtXnoa2').val(as[0].noa);
                			$('#txtXnoa1').val(as[as.length-1].noa);
                		}else{
                			$('#txtXnoa2').val('');
                			$('#txtXnoa1').val('');
                			$('#txtXdate1').val(q_date().substring(0,7)+'01');
			                var lastDays = $.datepicker._getDaysInMonth(q_date().substring(0,3),q_date().substring(4,6)-1);
			                $('#txtXdate2').val(q_date().substring(0,7)+lastDays);
                		}
                		break;
                }  /// end switch
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