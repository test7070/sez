<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
		aPop = new Array(['txtOrdeno1', '', 'orde', 'noa,custno,comp', 'txtOrdeno1', "orde_b.aspx"]
									,['txtOrdeno2', '', 'orde', 'noa,custno,comp', 'txtOrdeno1', "orde_b.aspx"]
									,['txtCuano1', '', 'cua', 'noa,datea', 'txtCuano1', "cua_b.aspx"]
									,['txtCuano2', '', 'cua', 'noa,datea', 'txtCuano2', "cua_b.aspx"]
									);
            $(document).ready(function() {
            	q_getId();
            	q_gf('', 'z_gen');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_gen',
                        options : [{
                        type : '0',
                        name : 'accy',
                        value : r_accy
                    },{
                        type : '1',
                        name : 'date'
                    },{
                        type : '2',
                        name : 'ucc',
                        dbf : 'ucaucc',
                        index : 'noa,product',
                        src : 'ucaucc_b.aspx'
                    },{
                        type : '1',
                        name : 'ordeno'
                    },{
                        type : '1',
                        name : 'cuano'
                    },{
                        type : '2',
                        name : 'workno',
                        dbf : 'work',
                        index : 'noa,product',
                        src : 'work_b.aspx'
                    }]
                    });
                q_popAssign();
                $('#txtDate1').mask('999/99/99');
	             $('#txtDate1').datepicker();
	             $('#txtDate2').mask('999/99/99');
	             $('#txtDate2').datepicker(); 
	             $('#txtOrdeno1').css('width','100px'); 
	             $('#txtOrdeno2').css('width','100px'); 
	             $('#txtCuano1').css('width','100px'); 
	             $('#txtCuano2').css('width','100px'); 
	             
	             for(var i = 0;i < aPop.length;i++){
					if(aPop[i][1].substr(0,9) == 'btnWorkno'){
						aPop[i].push('95%');
						aPop[i].push('95%');
					}
				}
	             
	             var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate1').val(t_year+'/'+t_month+'/'+t_day);
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
              
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
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>