
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
                q_gf('', 'z_tran_wj');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_tran_wj',
                        options : [  {
                        type : '0', //[1]
                        name : 'accy',
                        value : q_getId()[4]
					},{
						type : '1',//[2][3]
						name : 'date'
					},{
						type : '2', //[4][5]
						name : 'cust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					},{
						type : '2', //[6][7]
						name : 'carno',
						index : 'carno',
						dbf : 'car2'
					}
					,{
						type : '2', //[8][9]
						name : 'Driver',
						dbf : 'driver',
						index : 'noa,namea',
						src : 'driver_b.aspx'
					}]
                    });
                q_popAssign();
                 $('#txtDate1').mask('999/99/99');
	             $('#txtDate1').datepicker();
	             $('#txtDate2').mask('999/99/99');
	             $('#txtDate2').datepicker();  
               
                var t_noa=typeof(q_getId()[5])=='undefined'?'':q_getId()[5];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtNoa1').val(t_noa);
                $('#txtNoa2').val(t_noa);
                 if(window.parent.q_name=='tran'){
                		var wParent = window.parent.document;
						var t_trandate= wParent.getElementById("txtTrandate").value
						var t_carno= wParent.getElementById("txtCarno").value
						var t_driverno= wParent.getElementById("txtDriverno").value
						$('#txtDate1').val(t_trandate);
						$('#txtDate2').val(t_trandate);
						$('#txtCarno1a').val(t_carno);
						$('#txtCarno2a').val(t_carno);
						$('#txtDriver1a').val(t_driverno);
						$('#txtDriver2a').val(t_driverno);

                }
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
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<div>
  <div id="q_acDiv"></div>
  <input type="button" id="btnOk"  onMouseOver="this.style.cursor='hand'"  alt=""  style=' font-size: 16px; font-weight:bold;color:blue'/>
  <input id="btnTop" type="button" onclick="q_topPage()"  style="background:url(../image/first_32o.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="btnPrev" type="button" onclick="q_prevPage()"  style="background:url(../image/prev_32o.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="btnNext" type="button" onclick="q_nextPage()"  style="background:url(../image/next_32o.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="btnBott" type="button" onclick="q_bottPage()"  style="background:url(../image/bott_32o.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="txtPageno" value="1" type="text" style=" margin-top: 5px; text-align: center;top:1px; left:110px; width: 45px;"/>
  <label style=" vertical-align: middle;position:inherit; left:165px">/</label>
  <input id="txtEnd" value="XXXX" type="text" style=" vertical-align: middle ;text-align: center; top:1px; left:175px; width: 45px;"/>
  <input id="txtTotpage" value="1" type="hidden"/>
  <input id="txtHtmfile" value="" type="hidden"/>
  <input id="txtUrl2" value="" type="hidden"/>
  <input id="btnPrint" type="button" style="background:url(../image/print_32.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <input id="chkXlsHead" value="" type="checkbox" />
  <input id="btnXls" type="button" style="background:url(../image/excel.jpg) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
    <a id='lblPageRange'></a>
  <input id="txtPageRange" type="text" style='width:40px;'/>
  <input id="btnWebPrint" type="button" style="font-size: medium;color: #0000FF;" value=""/>
  <select id="cmbPcPrinter" style='width:220px;'></select>
  <input id="btnAuthority" type="button"  style="font-size: medium;" />
  <input id="txtUrl" value="" type="text" style='width:70px;'/>
  <input id="btnClose" type="button" onclick=""  style="background:url(../image/colose_32r.png) no-repeat;width: 36px;height: 36px;border-style: hidden;"/>
  <!--<a id='lblPaperSize'></a><a id='lblLandScape'></a>-->
  <select id="cmbPaperSize" style='width:80px;visibility:hidden;'></select>
  <input id="chkLandScape" value="" type="checkbox" style='width:80px;visibility:hidden;'/>
  <div id="frameReport"  style="visibility:visible;top: 35px; left: 0px; height: 100% ; width: 100%; border-top-color:Red; border-top-style:groove;" />
</div>
			</div>
		</div>
	</body>
</html>
           
          
