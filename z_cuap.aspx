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
                q_gf('', 'z_cuap');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_cuap',
                    options : [{
						type : '0',
						name : 'accy',
                        value : q_getId()[4] //[1]
                    },{
                        type : '6',
                        name : 'cuano'
                    },{
                        type : '6',
                        name : 'stkdate'
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                $('#txtStkdate').mask('999/99/99');
                $('#txtStkdate').val(q_date());
                
                var btn = document.getElementById('btnOk');
                btn.insertAdjacentHTML("afterEnd","<input type='button' id='btnOrdb' style='font-size: 16px; font-weight: bold; color: blue; cursor: pointer;' value='轉至請購單'>");
                
                var Parent = window.parent.document;
                if(window.parent.q_name=='cua')
                	$('#txtCuano').val(Parent.getElementById('txtNoa').value);
                
                var cuano=!emp($('#txtCuano').val())?$('#txtCuano').val():'#non';
				var t_where = r_accy+ ';' + cuano;
				var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
                q_gtx("z_cuap1", t_where + ";;" + t_para + ";;z_cuap;;" + q_getMsg('qTitle'));
                
                
                $('#btnOrdb').click(function(){
                	if(confirm("確定要轉至請款單?"))
					{
						var cuano=!emp($('#txtCuano').val())?$('#txtCuano').val():'#non';
						var t_where = r_accy+ ';' + cuano+';'+r_userno+';'+q_getPara('sys.key_ordb');
						var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
		                q_gtx("z_cuap2", t_where + ";;" + t_para + ";;z_cuap;;" + q_getMsg('qTitle'));
					}
	            });
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