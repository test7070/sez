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
                q_gf('', 'z_workb');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_workb',
                    options : [{
						type : '0',
						name : 'accy',
                        value : q_getId()[4] //[1]
                    },{
                        type : '1',
                        name : 'date'
                    },{
                        type : '6',
                        name : 'xnoa'
					}, {
                        type : '2',
                        name : 'product',//[5][6]
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    },{
                        type : '2',
                        name : 'storeno', //[7][8]
                        dbf : 'store',
                        index : 'noa,store',
                        src : 'store_b.aspx'
                    }, {
						type : '2', //[9][10]
						name : 'xstation',
						dbf : 'station',
						index : 'noa,station',
						src : 'station_b.aspx'
					},{
                        type : '6',//[11]
                        name : 'xteam'
					},{
                        type : '6',//[12]
                        name : 'xworker'
					}, {
						type : '5', //[13]
						name : 'xsortby',
						value : 'station@依工作線別,team@依組別,worker@依作業人員'.split(',')
					}]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                if(r_len==4){                
                    $.datepicker.r_len=4;
                    //$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }
                
                $('#txtDate1').mask(r_picd);
                $('#txtDate1').datepicker();
                $('#txtDate2').mask(r_picd);
                $('#txtDate2').datepicker();
                $('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
                $('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
                
				$('.q_report .option:first').css('width','700px')
				$('#Product').css('width','690px');
				$('#Product .c2').css('width','130px');
				$('#Product .c3').css('width','130px');
				$('#Storeno').css('width', '690px');
                $('#Storeno .c2').css('width', '130px');
                $('#Storeno .c3').css('width', '130px');
				
                var t_key = q_getHref();
                if(t_key[1] != undefined)
                	$('#txtXnoa').val(t_key[1]);
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(s2) {
            }
		</script>
	</head>
	<body id="z_accc" ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>