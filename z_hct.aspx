<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				q_getId();
				q_gf('', 'z_hct');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_hct',
					options : [{
						type : '1', //[1,2]
						name : 'xdate'
					}]
				});
				q_popAssign();
                q_getFormat();
                q_langShow();

				$('#txtXdate1').mask('999/99//99');
				$('#txtXdate1').datepicker();
				$('#txtXdate2').mask('999/99//99');
				$('#txtXdate2').datepicker();
				
				$('#btnXXX').click(function(e) {
                    btnAuthority(q_name);
                });
				

              	$('#btnRun').click(function(){
					var t_index = $('#q_report').data('info').radioIndex;
					var txtreport = $('#q_report').data('info').reportData[t_index].report;
					if(emp($('#txtXdate1').val()) || emp($('#txtXdate2').val())){
						alert('請輸入日期!!');
						return;
					}
					if(t_index==1){
						var t_bdatea=emp($('#txtXdate1').val())?'#non':$('#txtXdate1').val();
						var t_edatea=emp($('#txtXdate2').val())?'#non':$('#txtXdate2').val();
						
						q_func('qtxt.query.'+txtreport,'z_hct.txt,'+txtreport+','+
							t_bdatea + ';' +t_edatea + ';' 
						);
					}
				});
				
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					default:
						break;
				}
              
            }
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.z_hct':
						var as = _q_appendData('tmp0','',true,true);
						if (as[0] == undefined) {
							alert('沒有資料!!');
						}else{
							filenametxt = as;
							for ( i = 0; i < filenametxt.length; i++) {
		                		setTimeout('openpage('+i+')',1000);
		                	}
						}
					break;
				}
			}
			
			var filenametxt=[];
			function openpage(x) {
            	var s1 = location.href;
                var t_path = (s1.substr(7, 5) == 'local' ? xlsPath : s1.substr(0, s1.indexOf('/', 10)) + '/htm/htm/');
            	
            	var $ifrm = $("<iframe style='display:none' />");
				$ifrm.attr("src", t_path +replaceAll(filenametxt[x].filename,' ','')+'.txt');
				$ifrm.appendTo("body");
				$ifrm.load(function () {
					//$("body").append("<div>Failed to download <i>'" + dlLink + "'</i>!");
				});
            }	
					
			
		</script>
		<style type="text/css">
			#frameReport table{
					border-collapse: collapse;
				}
		</style>
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
			<div id="MediaCtrl" style="display:inline-block;width:2000px;">
				<input type="button" id="btnRun" style="float:left; width:80px;font-size: medium;" value="執行"/>
				<input type="button" id="btnXXX" style="float:left; width:80px;font-size: medium;" value="權限"/>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>