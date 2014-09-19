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
		    $(document).ready(function () {

		        q_getId();
		        q_gf('', 'z_acbe2');

		        $('#txtByear').val( parseFloat( r_accy)-1);
		        $('#txtEyear').val(r_accy);
		        $('#txtBmon1').val('01');
		        $('#txtEmon1').val('12');
		        $('#txtBmon2').val('01');
		        $('#txtEmon2').val('12');

		        $('#btnOk').click(function () {
		            var t_byear = $('#txtByear').val();
		            var t_eyear = $('#txtEyear').val();
		            var t_part1 = $('#combPart1').val();
		            var t_part2 = $('#combPart2').val();

		            var t_bmon1 = $('#txtBmon1').val();
		            var t_emon1 = $('#txtEmon1').val();

		            var t_bmon2 = $('#txtBmon2').val();
		            var t_emon2 = $('#txtEmon2').val();

		            var t_detail = $('#chkDetail')[0].checked;
		            t_detail = (t_detail ? 1 : 0);

		            var t_where = r_accy + ';' + r_cno + ';' + t_byear + ';' + t_bmon1 + ';' + t_emon1 + ';' + t_part1 + ';' + t_eyear + ';' + t_bmon2 + ';' + t_emon2 + ';' + t_part2 + ';' + t_detail;

		            //ret = qExec.z_acbe2a("101", "1", "101", "01", "12", "", "101", "01", "12", "", "0");  /// z_acbe2
		            var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno + ",year1=" + t_byear + ",bmon1=" + t_bmon1 + ",bmon2=" + t_bmon2 + ",year2=" + t_eyear + ",emon1=" + t_emon1 + ",emon2=" + t_emon2;

		            q_gtx("z_acbe2a", t_where + ";;" + t_para + ";;z_acbe2;;" + q_getMsg('qTitle'));
		        });
		    });
		    function q_gfPost() {
		        q_popAssign();
		        q_gt('acpart', '', 0, 0, 0, "", r_accy + '_' + r_cno);
		    }

		    function q_boxClose(t_name) {
		    }
		    function q_gtPost(t_name) {
		        switch (t_name) {
		            case 'acpart':
		                t_part = "zzz@全部";
		                var as = _q_appendData("acpart", "", true);
		                for (i = 0; i < as.length; i++) {
		                    t_part = t_part + ',' + as[i].noa + '@' + as[i].part;
		                }
		                q_cmbParse("combPart1", t_part);
		                q_cmbParse("combPart2", t_part);
		                break;
		        }
		        
		        if(q_getPara('acc.lockPart')=='1' && r_rank<8){
		        	$('#combPart1').val(r_partno);
		        	$('#combPart1').attr('Disabled','Disabled');
		        	$('#combPart2').val(r_partno);
		        	$('#combPart2').attr('Disabled','Disabled');
		        }
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
			<div class="dview" id="dview" style="float: left;  width:15%; "  >
			 	<table class="tview" id="tview"   border="0" cellpadding='2'  cellspacing='0'>
			 	<tr>
			 		 <td class="td1"><a id='lblAcbe2' class="lbl" style="font-size: xx-large;font-family:dfkai-sb;"></a></td>
			 	</tr>
			 </table>
			 </div>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			 <tr>
               <td class="td1"><a id="lblByear"></a></td>
               <td class="td2"><input id="txtByear"   type="text"/></td>
               <td class="td3"><a id="lblBmon1"></a></td>
               <td class="td4"><input id="txtBmon1"   type="text" style='width: 30%;'/><a id="lblSymbol1" style="width: 8%;"></a>
               	<input id="txtEmon1"   type="text" style='width: 30%;'/>
               </td>
               <td class="td5"><a id='lblPart1'></a></td>
               <td class="td6"><select id="combPart1" style="width: 100%;" value=" "></select></td> 
            </tr> 
           <tr>
               <td class="td1"><a id="lblEyear"></a></td>
               <td class="td2"><input id="txtEyear"   type="text" /></td>
               <td class="td3"><a id="lblBmon2"></a></td>
               <td class="td4"><input id="txtBmon2"   type="text" style='width: 30%;'/><a id="lblSymbol2" style="width: 8%;"></a>
               	<input id="txtEmon2"   type="text" style='width: 30%;'/>
               </td>
               <td class="td5"><a id='lblPart2'></a></td>
               <td class="td6"><select id="combPart2" style="width: 100%;" value=" "></select></td> 
               <td class="td7"><a id='lblDetail'></a><input id="chkDetail" type="checkbox" style=" "/></td>  
            </tr>  
            </table>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          

