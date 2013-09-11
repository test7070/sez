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
                q_gf('', 'vccatxt');
                
                $('#q_report').hide();
                $('.prt').hide();
                $('#btnClosepage').hide();//備用
            });
            function q_gfPost() {
                $('#q_report').q_report({
                        fileName : 'vccatxt',
                        options : []
                    });
                    q_popAssign();
					
                    $('#textBmon').mask('999/99');
                    $('#textEmon').mask('999/99');
                    
                    //讀出有開發票的公司
                	q_gt('acomp', 'where=^^ noa in (select cno from vcca group by cno) ^^', 0, 0, 0, "", r_accy);
                    
                    $('#btnVccaxls').click(function(e) {
                    	if(!emp($('#textBmon').val()) &&!emp($('#textEmon').val())){
                    		var s1 = location.host;
                    		q_func('qtxt.query','vccadcxls.txt,vccaxls,'+encodeURI(s1) + ';' + encodeURI($('#textBmon').val()) + ';' + encodeURI($('#textEmon').val()));
                    	}
                	});
                	
                	//備用
                	$('#btnClosepage').click(function(e) {
                    	for ( i = 0; i < vccacno.length; i++) {
		                	vccacno[i].page.close();
		                }
                	});
                    
                    $('#btnXauthority').click(function(e) {
                    	$('#btnAuthority').click();
                	});
            }
            
            var vccacno;
            function q_gtPost(t_name) {
                switch (t_name) {  
                	case 'acomp':
						vccacno = _q_appendData("acomp", "", true);
						break;
                }
            }
            
            function q_funcPost(t_func, result) {
                if (vccacno[0] != undefined) {
                	for ( i = 0; i < vccacno.length; i++) {
                		setTimeout('openpage('+i+')',1000);
                	}
                }
            }
            
            function openpage(x) {
            	var s1 = location.href;
                var t_path = (s1.substr(7, 5) == 'local' ? xlsPath : s1.substr(0, s1.indexOf('/', 10)) + '/htm/');
            	//vccacno[x].page=window.open(t_path +'vccadc'+replaceAll(vccacno[x].noa,' ','')+'.xls', "_self", 'directories=no,location=no,menubar=no,resizable=no,scrollbars=no,status=0,toolbar=no,width=100,height=100;');
            	
            	var $ifrm = $("<iframe style='display:none' />");
                        $ifrm.attr("src", t_path +'vccadc'+replaceAll(vccacno[x].noa,' ','')+'.xls');
                        $ifrm.appendTo("body");
                        $ifrm.load(function () {
                            $("body").append(
                                "<div>Failed to download <i>'" + dlLink + "'</i>!");
                        });
            	
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
			<div id="vccaxls">
				<table  border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;width:300px">
					<tr>
						<td align="center" style="width:35%"><a id="lblMon" class="lbl"></a></td>
						<td align="left" style="width:65%">
							<input id="textBmon"  type="text"  class="txt" style="width: 40%;"/>~
							<input id="textEmon"  type="text"  class="txt" style="width: 40%;"/>
						</td>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input id="btnVccaxls" type="button" style="font-size: medium;"/>
							<input id="btnClosepage" type="button" style="font-size: medium;"/>
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