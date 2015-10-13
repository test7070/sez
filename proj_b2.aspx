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
			var q_name = 'proj', t_content = ' field=noa,proj', bbsKey = ['noa'], as;
		    var t_sqlname = 'proj_load';
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
				
				$('#btnSearch').click(function() {
					var t_where="1=1";
					if($('#textProjno').val().length>0){
						t_where+=" and charindex('"+$('#textProjno').val()+"',noa)>0";
					}
					if($('#textProj').val().length>0){
						t_where+=" and charindex('"+$('#textProj').val()+"',proj)>0";
					}
					var t_noa='';
					for(var i=0; i<abbs.length; i++){
						if(abbs[i].sel==true || abbs[i].sel=="true"){
							t_noa=t_noa+(t_noa.length>0?',':'')+"'"+abbs[i].noa+"'"; 
						}
					}
					location.href = "http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+t_where+";"+r_accy;
				});
				
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
			}
			function mainPost() {
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
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
		<div  id="dbbs">
			<div style="width:350px;overflow-y: scroll;">
				<table border="2"  cellpadding='0' cellspacing='0' style='width:100%' >
					<tr>
						<td align="center" style="width:30px;"> </td>
						<td align="center" style="width:120px;color:blue;"><a id='lblNoa'> </a></td>
						<td align="center" style="width:200px;color:blue;"><a id='lblProj'> </a></td>
					</tr>
				</table>
			</div>
			<div style="width:350px;height:500px;overflow-y: scroll;" >
				<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:100%' >
					<tr style="height:1px;">
						<td align="center" style="width:30px;"> </td>
						<td align="center" style="width:120px;"> </td>
						<td align="center" style="width:200px;"> </td>
					</tr>
					<tr>
						<td style="width:30px;"><input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/></td>
						<td style="width:120px;"><input class="txt" id="txtNoa.*" type="text" style="width:100%;"  readonly="readonly" /></td>
						<td style="width:200px;"><input class="txt" id="txtProj.*" type="text" style="width:100%;"  readonly="readonly" /></td>
					</tr>
				</table>
			</div>
			<!--#include file="../inc/pop_ctrl.inc"-->
			<div>
				<a>專案編號</a>
				<input class="txt" id="textProjno" type="text" style="width:150px;" />
			</div>
			<div>
				<a>專案名稱 </a>
				 <input class="txt" id="textProj" type="text" style="width:150px;" />
				 <input type="button" id="btnSearch" style="border-style: none; width: 36px; height: 36px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;">
			 </div>
		</div>
	</body>
</html>

