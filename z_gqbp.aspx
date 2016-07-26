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
			t_item = "";
           	t_item2 = "";
           	t_item3 = "";
           	t_item4 = "";
           	aPop  =  new Array();
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_gqbp');

            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_gqbp',
                    options : [{
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {
                        type : '1',
                        name : 'gqbno'
                    }, {/*7*/
                         	type : '8',
                            name : 'xtitle',
                            value : q_getMsg('ttitle').split('&')
                    }, {
                        type : '6',
                        name : 'xfontsize'
                    }]
                });
				var t_noa=q_getHref()[1]=='undefined'?'':q_getHref()[1];
                $('#txtGqbno1').val(t_noa);
                $('#txtGqbno2').val(t_noa);
                $('#txtGqbno1').width(120);
                $('#txtGqbno2').width(120);
                $('#txtXfontsize').val('14');
                
                $('<input id="btnOk2" type="button" value="查詢" style="font-size: 16px; font-weight: bold; color: blue; cursor: pointer;"/>').insertBefore('#btnOk');
            	$('#btnOk').hide();
            	$('#btnOk2').click(function(e){
            		switch($('#q_report').data('info').radioIndex) {
                        case 1:
                        	window.open("./pdfgqb_dc01.aspx?bno="+$('#txtGqbno1').val()+"&eno="+$('#txtGqbno2').val()+"&fontsize="+$('#txtXfontsize').val()+"&db="+q_db);
                            break;
                        default:
                           	$('#btnOk').click();
                            break;
                    }
            	});
            }

            function q_boxClose(t_name) {
            }
            function q_gtPost(t_name) {
            	
            	
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