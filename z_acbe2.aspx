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
            	 
            	q_getId();
                q_gf('', 'z_acbe2');
            });
            function q_gfPost() {
               q_popAssign();  
            }

            function q_boxClose(s2) {
            }
            function q_gtPost(s2) {
            }
		</script>
	</head>
	<body>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="dview" id="dview" style="float: left;  width:15%; "  >
			 	<table class="tview" id="tview"   border="0" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
			 	<tr>
			 		 <td class="td1"><a id='lblAcbe2' class="lbl" style="font-size: xx-large;"></a></td>
			 	</tr>
			 </table>
			 </div>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			 <tr>
               <td class="td1"><a id="lblByear"></a></td>
               <td class="td2"><input id="txtByear"   type="text"/></td>
               <td class="td3"><a id="lblBmon1"></a></td>
               <td class="td4"><input id="txtBMon1"   type="text" style='width: 30%;'/><a id="lblSymbol1" style="width: 8%;"></a>
               	<input id="txtEMon1"   type="text" style='width: 30%;'/>
               </td>
               <td class="td5"><a id='lblPart1'></a></td>
               <td class="td6"><select id="combPart1" style="width: 100%;" value=" "></select></td> 
            </tr> 
           <tr>
               <td class="td1"><a id="lblEyear"></a></td>
               <td class="td2"><input id="txtEyear"   type="text" /></td>
               <td class="td3"><a id="lblBmon2"></a></td>
               <td class="td4"><input id="txtBMon2"   type="text" style='width: 30%;'/><a id="lblSymbol2" style="width: 8%;"></a>
               	<input id="txtEMon2"   type="text" style='width: 30%;'/>
               </td>
               <td class="td5"><a id='lblPart2'></a></td>
               <td class="td6"><select id="combPart2" style="width: 100%;" value=" "></select></td> 
            </tr>  
            </table>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          