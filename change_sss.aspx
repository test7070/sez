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
                $('#btnIns').hide();
                $('#btnModi').hide();
                $('#btnDele').hide();
                $('#btnSeek').hide();
                $('#btnPrint').hide();
                $('#btnPrevPage').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnNextPage').hide();
                $('#btnOk').hide();
                $('#btnCancel').hide();
                $('#btnSign').hide();
                $('#pageNow').hide();
                $('#pageAll').hide();
            	$('#btnChange').click(function() {
					if($('#txtOsssno').val() != '' && $('#txtNsssno').val() != ''){
	                	q_func( 'change_sss.change', $('#txtOsssno').val()+','+$('#txtNsssno').val());
					}else{
						alert(q_getMsg('lblOsssno')+'、'+q_getMsg('lblNsssno')+'為必填項!');
					}
				});
				$('#btnAuthority').click(function(){
					btnAuthority();
				})
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
		<!--#include file="../inc/toolbar.inc"-->
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
			<tr>
				<td colspan="2">
					<td><input id="btnChange" type="button" /></td>
				</td>
			</tr>
		</table>
        </div> 
	</body>
</html>