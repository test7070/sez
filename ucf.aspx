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
                q_gf('', 'ucf');
                
                $('#q_report').hide();
                $('.prt').hide();
            });
            function q_gfPost() {
                $('#q_report').q_report({
                        fileName : 'ucf',
                        options : []
                    });
                    q_popAssign();
                    q_langShow();
					
                    $('#textBdate').mask('999/99/99');
                    $('#textEdate').mask('999/99/99');
                    
                    $('#textBdate').val(q_date().substr(0,3)+'/01/01');
                    $('#textEdate').val(q_date());
                    
                    $('#btnCost').click(function(e) {
                    	if(!emp($('#textBdate').val()) &&!emp($('#textEdate').val())){
                    		q_func('cost.genUccCost',$('#textBdate').val() + ',' + $('#textEdate').val());
                    		//cost.genUccCost(string t_bdate,string t_edate)
                    	}
                    	$('#btnCost').attr('disabled','disabled').val('結轉中...');
                	});
                	
                	$('#btnXauthority').click(function(e) {
                    	$('#btnAuthority').click();
                	});
            }
            
            function q_gtPost(t_name) {
                switch (t_name) {  
                	
                }
            }
            
            function q_funcPost(t_func, result) {
				alert('結轉功能執行完畢!!');
				$('#btnCost').removeAttr('disabled').val('結轉');
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
			<div id="ucf">
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:300px">
					<tr>
						<td align="center" style="width:35%"><a id="lblDatea" class="lbl" style="font-size: medium;"></a></td>
						<td align="left" style="width:65%">
							<input id="textBdate"  type="text"  class="txt" style="width: 40%; font-size: medium;"/>~
							<input id="textEdate"  type="text"  class="txt" style="width: 40%; font-size: medium;"/>
						</td>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input id="btnCost" type="button" style="font-size: medium;"/>
						</td>
					</tr>
				</table>
			</div>
			<input id="btnXauthority" type="button" style="float:left; width:80px;font-size: medium;"/>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>