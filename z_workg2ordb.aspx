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
                q_gf('', 'z_workg2ordb');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_workg2ordb',
                    options : [{
						type : '0',
						name : 'accy',
                        value : q_getId()[4] //[1]
                    },{
                        type : '1', //[2][3]
                        name : 'odate'
                    },{
                        type : '1', //[4][5]
                        name : 'workgno'
                    },{
                        type : '2',//[6][7]
                        name : 'xproductno',
                        dbf : 'ucc',
                        index : 'noa,product',
                        src : 'ucc_b.aspx'
                     },{
                        type : '8', //[8]
                        name : 'workgall',
                        value : "1@全部未請購生產計畫".split(',')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtOdate1').mask('999/99/99');
                $('#txtOdate1').datepicker();
                $('#txtOdate2').mask('999/99/99');
                $('#txtOdate2').datepicker();
                
                if (window.parent.q_name == 'workg') {
					var wParent = window.parent.document;
					$('#txtWorkgno1').val(wParent.getElementById("txtNoa").value);
					$('#txtWorkgno2').val(wParent.getElementById("txtNoa").value);
				}
                
                var btn = document.getElementById('btnOk');
                btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnOrdb' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='轉至請購單'>");
                
                $('#btnOk').click();
                
                $('#btnOrdb').click(function(){
                	if(confirm("確定要轉至請購單?"))
					{
						var bdate=!emp($('#txtOdate1').val())?$('#txtOdate1').val():'#non';
                		var edate=!emp($('#txtOdate2').val())?$('#txtOdate2').val():'#non';
                		var bworkgno=!emp($('#txtWorkgno1').val())?$('#txtWorkgno1').val():'#non';
                		var eworkgno=!emp($('#txtWorkgno2').val())?$('#txtWorkgno2').val():'#non';
						var bpno=!emp($('#txtXproductno1a').val())?$('#txtXproductno1a').val():'#non';
                		var epno=!emp($('#txtXproductno2a').val())?$('#txtXproductno2a').val():'#non';
                		//$('#chkWorkgall input[type=checkbox]').prop('checked')
                		var workgall=!emp($('#q_report').data('info').sqlCondition[7].getValue())?$('#q_report').data('info').sqlCondition[7].getValue():'#non';
                		
                		
						var t_where = r_accy+ ';' + bdate+ ';' + edate+ ';' + bworkgno+ ';' + eworkgno+ ';' + bpno+ ';' + epno+ ';' + workgall+';'+r_userno+';'+q_getPara('sys.key_ordb');
						var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
		                q_gtx("z_workg2ordb2", t_where + ";;" + t_para + ";;z_workg2ordb;;" + q_getMsg('qTitle'));
					}
	            });
	            
	            $('.q_report .option div .c3').css("width","180px");
	            $('.q_report .option div .c6').css("width","110px");
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
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>