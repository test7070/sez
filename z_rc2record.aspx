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
                q_gf('', 'z_rc2record');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_rc2record',
                    options : [{
						type : '2',
						name : 'xtgg',
						dbf : 'tgg',
						index : 'noa,comp',
						src : 'tgg_b.aspx'
					}, {
						type : '2',
						name : 'xproduct',
						dbf : 'ucaucc',
						index : 'noa,product',
						src : 'ucaucc_b.aspx'
					}, {
                        type : '6',
                        name : 'xordbno',
                    }, {
                        type : '6',
                        name : 'xordbnoq',
                    }, {
                        type : '6',
                        name : 'xordcno',
                    }, {
                        type : '6',
                        name : 'xordcnoq',
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                var t_no = typeof (q_getId()[3]) == 'undefined' ? '' : q_getId()[3];
                if(t_no.length>0){
                    var tmp = t_no.split('&');
                    for(var i in tmp){
                        if (tmp[i].indexOf('tgg=') >= 0) {
                            $('#txtXtgg1a').val(tmp[i].replace('tgg=', ''));
                            $('#txtXtgg2a').val(tmp[i].replace('tgg=', ''));
                        }else if (tmp[i].indexOf('product=') >= 0){
                            $('#txtXproduct1a').val(tmp[i].replace('product=', ''));
                            $('#txtXproduct2a').val(tmp[i].replace('product=', ''));
                        }else if (tmp[i].indexOf('ordbno=') >= 0){
                            $('#txtXordbno').val(tmp[i].replace('ordbno=', ''));
                        }else if (tmp[i].indexOf('no3=') >= 0){
                            $('#txtXordbnoq').val(tmp[i].replace('no3=', ''));
                        }else if (tmp[i].indexOf('ordcno=') >= 0){
                            $('#txtXordcno').val(tmp[i].replace('ordcno=', ''));
                        }else if (tmp[i].indexOf('no2=') >= 0){
                            $('#txtXordcnoq').val(tmp[i].replace('no2=', ''));
                        }
                    }
                    $('#btnOk').click();
                }
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