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
                q_gf('', 'z_drun');
            });
            function q_gfPost() {
            	var action_type = "insert@新增,delete@刪除,update@修改,apv@核准,paper@報表,form@執行,Login@登入,Logout@登出";
                $('#q_report').q_report({
                    fileName : 'z_drun',
                    options : [{
                        type : '1',
                        name : 'date'
                    },{
                        type : '6',
                        name : 'xnoa'
					},{
                        type : '2',
                        name : 'sssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
					},{
                        type : '5', //select
                        name : 'xaction',
                        value : [q_getPara('report.all')].concat(action_type.split(','))
					},{
						type : '0',
						name : 'action_type',
						value : action_type
                    },{
						type : '0',
						name : 'rlen',
						value : r_len
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
                
                if(q_getPara('sys.project').toUpperCase()=='BV')
        			document.title='7.2使用紀錄查詢'
        			
        		if (r_rank < 7 && q_getPara('sys.project').toUpperCase()!='XY'){
	                $('#txtDate1').attr('disabled', 'disabled');
	                $('#txtDate2').attr('disabled', 'disabled');
	                $('#txtSssno1a').attr('disabled', 'disabled');
	                $('#txtSssno2a').attr('disabled', 'disabled');
	            }
	            
	            //106/07/14 未限制使用者，未限制單據編號 ，日期區間最大兩個月
	            var tmp = document.getElementById("btnOk");
                var tmpbtn = document.createElement("input");
                tmpbtn.id = "btnOk2"
                tmpbtn.type = "button"
                tmpbtn.value = "查詢"
                tmpbtn.style.cssText = "font-size: 16px; font-weight: bold; color: blue; cursor: pointer;";
                tmp.parentNode.insertBefore(tmpbtn, tmp);
                $('#btnOk').hide();
	            
	            $('#btnOk2').click(function() {
	            	if(emp($('#txtXnoa').val()) && emp($('#txtSssno1a').val()) && emp($('#txtSssno2a').val())
	            	&& emp($('#txtDate1').val()) && emp($('#txtDate2').val())
	            	){
	            		$('#txtDate1').val(q_cdn(q_date(),-60));
	            		$('#txtDate2').val(q_date());
	            		$('#txtSssno1a').val(r_userno).change();
	            		$('#txtSssno2a').val(r_userno).change();
	            	}
	            	$('#btnOk').click();
				});
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