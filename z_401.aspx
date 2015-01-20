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
				q_gf('', 'z_401');
			});
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_401',
					options : [{
						type : '1', //[1,2]
						name : 'xmon'
					},{
						type : '6', //[3]
						name : 'xdate'
					},{
						type : '6', //[4]
						name : 'x048'
					},{
						type : '6', //[5]
						name : 'x049'
					},{
						type : '6', //[6]
						name : 'x108'
					},{
						type : '6', //[7]
						name : 'x073'
					},{
						type : '6', //[8]
						name : 'x074'
					},{
						type : '6', //[9]
						name : 'x082'
					},{
						type : '6', //[10]
						name : 'x013'
					},{
						type : '6', //[11]
						name : 'x014'
					}]
				});
				q_popAssign();
                q_getFormat();
                q_langShow();

				$('#txtXmon1').mask('999/99');
				$('#txtXmon2').mask('999/99');
				$('#txtXdate').mask('999/99//99');
				var t_date=(dec(q_date().substr(4,2))%2==0)?q_cdn(q_date().substr(0,6)+'/28',-45).substr(0,6):q_date().substr(0,6);
				//$('#txtXmon1').val(q_date().substr(0,6));
				//$('#txtXmon2').val(q_cdn($('#txtXmon1').val()+'/01',45).substr(0,6)).attr('disabled', 'disabled').css('background','RGB(237,237,237)');
				$('#txtXdate').val(q_date());
				$('#txtXmon2').attr('disabled', 'disabled').css('background','RGB(237,237,237)');
				
				$('#txtXmon1').blur(function() {
					if(!emp($('#txtXmon1').val())){
						if(dec($('#txtXmon1').val().substr(4,2))%2==0){
							alert('請輸入單月份');
							$('#txtXmon1').val(q_cdn($('#txtXmon1').val()+'/28',-45).substr(0,6));
						}
						
						$('#txtXmon2').val(q_cdn($('#txtXmon1').val()+'/01',45).substr(0,6));
						
						//申報日期
						var t_mon=q_cdn($('#txtXmon2').val()+'/01',45).substr(0,6);
						t_where = "where=^^ out_date='" + t_mon + "'^^";
                        q_gt('z401', t_where, 0, 0, 0, "z401_108", r_accy);
					}else{
						$('#txtXmon2').val('');
					}
				});
				
				//將原本的指令砍掉
				$('#btnOk').data('events').click.splice(0, 1);
				$('#btnOk').click(function() {
					if(emp($('#txtXmon1').val()) || emp($('#txtXmon2').val())){
						alert('請輸入月份!!');
						return;
					}
					Lock(); 
					$('#q_report').data('info').execute($('#q_report'));
				});

				$('#report').css('width','420px');
				$('.q_report .report div').css('width','200px');
				
				$('.option .a1').css('width','300px');
				$('.q_report .option div .c3').css('width','70px');
				$('.q_report .option div .c6').css('width','120px');
				$('#lblX082').css('font-size','10px');
				
				$('.option .c5').each(function() {
					if($(this).attr('id').indexOf('txtXdate')==-1){
						$(this).css('text-align','right');
						$(this).keyup(function() {
							var tmp=$(this).val().replace(/[^\d]/g,'');
							$(this).val(FormatNumber(tmp));
						});
					}
				});
			}

			function q_boxClose(s2) {
			}

			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'z401_108':
                        var as = _q_appendData("z401", "", true);
                        if (as[0] != undefined) {
                            $('#txtX048').val(dec(as[0].t48)-dec(as[0].t44));
                            $('#txtX049').val(dec(as[0].t49)-dec(as[0].t46));
                            $('#txtX108').val(as[0].t108);
                            $('#txtX073').val(as[0].t73);
                            $('#txtX074').val(as[0].t74);
                            $('#txtX082').val(as[0].t82);
                            $('#txtX013').val(as[0].t13);
                            $('#txtX014').val(as[0].t14);
                        }else{
                        	var t_mon=q_cdn($('#txtXmon2').val()+'/01',45).substr(0,6);
							t_where = "where=^^ out_date<'" + t_mon + "'^^";
	                        q_gt('z401', t_where, 0, 0, 0, "z401_115", r_accy);
                        }
                        break;
					case 'z401_115':
						var as = _q_appendData("z401", "", true);
						if (as[0] != undefined) {
                            $('#txtX108').val(as[0].t115);
                        }
						break;
                }  /// end switch
            }
			
			function FormatNumber(n) {
	            var xx = "";
	            if(n<0){
	            	n = Math.abs(n);
	            	xx = "-";
				}     		
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
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
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>