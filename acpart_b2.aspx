<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'acpart', t_content = ' field=noa,part,nick', bbsKey = ['noa'], as;
		    var t_sqlname = 'acpart_load';
            t_postname = q_name;
            //brwCount2 = 0;
            brwCount = -1;
			var isBott = false;
			/// 是否已按過 最後一頁
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			
			$(document).ready(function() {
				main();
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
			}

			function q_gtPost() {
			}
			
			//var xuccno=''
			function bbsAssign() {
                _bbsAssign();
                /*if(isbtnBott && !isbtnTop){
                	isbtnTop=true;
                	for (var i=0;i<t_noa.length;i++){
	                	for(var j=0; j<abbs.length; j++){
		               			if(t_noa[i]==abbs[j].noa){
		               				abbs[j].sel=true
		               				break;
							}
						}
	                }
					$('#btnTop').click();
					_refresh();
				}
				if(t_noa.length>0 && !isbtnBott && !isbtnTop){
					isbtnBott=true;
					setTimeout(function(){
						$('#btnBott').click()
					}, 1000);
					//$('#btnBott').click();
				}*/
            }
			
			//var isbtnBott=false,isbtnTop=false,t_noa="";
			function refresh() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
                /*for (var i=0;i<q_getHref().length;i++){
                	if(q_getHref()[i]!=undefined){
	                	if(q_getHref()[i].indexOf('or noa in')>-1){
	                		t_noa=q_getHref()[i].substring(q_getHref()[i].indexOf('or noa in'));
	                		t_noa=t_noa.replace("or noa in ('",'');
	                		t_noa=t_noa.replace("')",'');
	                		t_noa=t_noa.split("','");
	                		break;
	                	}
                	}
                }*/
				_refresh();
				
			}
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div  id="dbbs"  >
			<div style="width:350px;">
				<table border="2"  cellpadding='0' cellspacing='0' style='width:100%' >
					<tr>
						<td align="center" style="width:30px;"> </td>
						<td align="center" style="width:120px;color:blue;"><a id='lblNoa'> </a></td>
						<td align="center" style="width:200px;color:blue;"><a id='lblPart'> </a></td>
					</tr>
				</table>
			</div>
			<div style="width:350px;" >
				<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:100%' >
					<tr style="height:1px;">
						<td align="center" style="width:30px;"> </td>
						<td align="center" style="width:120px;"> </td>
						<td align="center" style="width:200px;"> </td>
					</tr>
					<tr>
						<td style="width:30px;"><input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/></td>
						<td style="width:120px;"><input class="txt" id="txtNoa.*" type="text" style="width:100%;"  readonly="readonly" /></td>
						<td style="width:200px;"><input class="txt" id="txtPart.*" type="text" style="width:100%;"  readonly="readonly" /></td>
					</tr>
				</table>
			</div>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>

