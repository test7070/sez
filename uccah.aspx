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
                q_gf('', 'uccah');
                
                $('#q_report').hide();
                $('.prt').hide();
                $('#txtSource').attr('disabled','disabled').val('st');
                $('#chkVcca').prop('checked','true');
                $('#chkRc2a').prop('checked','true');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                        fileName : 'uccah',
                        options : []
                    });
                    q_popAssign();
                    q_langShow();
					
                    $('#txtMon').mask(r_picm);
                   
                    $('#btnGen').click(function(e) {
		                if(emp($('#txtMon').val()) || emp($('#txtSource').val())){
							alert('資料月份與資料路徑禁止空白');
							return;
					    }
					   	var t_mon=!emp($('#txtMon').val())?trim($('#txtMon').val()):'#non';
						var t_vcca=$('#chkVcca').prop('checked')?'1':'#non';
						var t_rc2a=$('#chkRc2a').prop('checked')?'1':'#non';
					    var t_proj=q_getPara('sys.project').toUpperCase();
					    q_func('qtxt.query.uccah', 'uccah.txt,gen,'+encodeURI(t_mon)+';'+encodeURI(t_vcca)+';'+encodeURI(t_rc2a)+';'+encodeURI(t_proj));
					    $('#btnGen').attr('disabled','disabled').val('匯入中...');
                	});
            }
            function q_funcPost(t_func, result) {
            	switch(t_func) {
                    case 'qtxt.query.uccah':
                    	alert('匯入完成');
                    	$('#btnGen').removeAttr('disabled').val('資料匯入');
                        break;
                    
                    default:
                    	break;
                }
		    }
            function q_gtPost(t_name) {
                switch (t_name) {  
                	
                }
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
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div id="ucf">
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:350px">
					<tr>
						<td align="center" style="width:35%"><a id="lblMon" class="lbl" style="font-size: medium;"> </a></td>
						<td align="left" style="width:65%">
							<input id="txtMon"  type="text"  class="txt"/>
						</td>
					</tr>
					<tr>
						<td align="center" style="width:35%"><a id="lblSorce" class="lbl" style="font-size: medium;"> </a></td>
						<td align="left" style="width:65%">
							<input id="txtSource"  type="text"  class="txt"/>
						</td>
					</tr>
					<tr>
						<td colspan="2"><input id="chkVcca" type="checkbox">
						<a  id='lblVcca'>銷項憑證　　　</a>
						<input id="chkRc2a" type="checkbox">
						<a id='lblRc2a'>進項憑證</a></td>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input id="btnGen" type="button" style="font-size: medium;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>