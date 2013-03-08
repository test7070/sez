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
           if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'change_sss');
            	$('#btnOk').hide();
            	$('#btnTop').hide();
            	$('#btnPrev').hide();
            	$('#btnNext').hide();
            	$('#btnBott').hide();
            	$('#txtPageno').hide();
            	$('#txtEnd').hide();
            	$('#txtTotpage').hide();
            	$('#txtHtmfile').hide();
            	$('#txtUrl2').hide();
            	$('#btnPrint').hide();
            	$('#lblPageRange').hide();
            	$('#btnWebPrint').hide();
            	$('#cmbPcPrinter').hide();
            	$('#lblPaperSize').hide();
            	$('#lblLandScape').hide();
            	$('#lblDownPrint').hide();
            	$('#txtUrl').hide();
            	$('#btnClose').hide();
            	$('#frameReport').hide();
            	$('#txtPageRange').hide();
            	$('#cmbPaperSize').hide();
            	$('#chkLandScape').hide();
            	$('#chkDownPrint').hide();
            	$('#q_acDiv').hide();
            	$('label').text('');
            });
            function q_gfPost() {
            	q_langShow();
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
		<br>
        <div id='dmain' style="overflow:hidden;">
		<table>
			<tr>
				<td>
					<td class="td1"><span> </span><a id='lblOsssno' class="lbl">  </a></td>
					<td class="td2"><input id="txtOsssno"  type="text"  class="txt c1"/></td>
				</td>
			</tr>
			<tr>
				<td>
					<td class="td1"><span> </span><a id='lblNsssno' class="lbl">  </a></td>
					<td class="td2"><input id="txtNsssno"  type="text"  class="txt c1"/></td>
				</td>
			</tr>
		</table>
        </div> 
		<!--#include file="../inc/print_ctrl.inc"-->

	</body>
</html>
           
          