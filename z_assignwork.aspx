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
		aPop = new Array(['txtItemno', '', 'assignment', 'noa,item', 'txtItemno', "assignment_b.aspx"]);
            $(document).ready(function() {
            	q_getId();
            	q_gf('', 'z_assignwork');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_assignwork',
                        options : [{/*[1][2]-接單日期 1-1*/
                        	type : '1',
                        	name : 'date'
                    	}, {/*[3] 委託種類 1-2*/
	                        type : '8',
	                        name : 'xkind',
	                        value : ('工商,土地').split(',')
	                    },{/*[4][5] 客戶編號 1-4*/
	                        type : '2',
	                        name : 'cust',
	                        dbf : 'cust',
	                        index : 'noa,comp',
	                        src : 'cust_b.aspx'
                        },{/*[6][7] 業務編號 1-8*/
	                        type : '2',
	                        name : 'sss',
	                        dbf : 'sss',
	                        index : 'noa,namea',
	                        src : 'sss_b.aspx'
                        },{/*[8] 單據編號 2-1 */
                        	type : '6',
                        	name : 'xnoa'
                    	},{/*[9] 結案 2-2*/
                        	type : '5',
                        	name : 'xenda',
	                        value : ('全部,結案,未結案').split(',')
                    	}, {/*[10] 排序 2-4*/
                            type : '5',
                            name : 'xsort1',//[11]
                            value : q_getMsg('tsort1').split('&')
                        },{/*[11] 付款 2-8*/
                        	type : '5',
                        	name : 'xpay',
	                        value : ('全部,已付,未付').split(',')
                    	},{/*[12][13] 付款日 3-1*/
                        	type : '1',
                        	name : 'paydate'
                    	},{/*[14]*/
                        	type : '0',
                        	name : 'r_name',
                        	value :r_name
                    	}]
                    });
                q_popAssign();
                 $('#txtDate1').mask('999/99/99');
	             $('#txtDate1').datepicker();
	             $('#txtDate2').mask('999/99/99');
	             $('#txtDate2').datepicker(); 

	             $('#txtPaydate1').mask('999/99/99');
	             $('#txtPaydate1').datepicker();
	             $('#txtPaydate2').mask('999/99/99');
	             $('#txtPaydate2').datepicker(); 
	             
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
	                $('#txtPaydate1').val(t_year+'/'+t_month+'/'+t_day);
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
	                $('#txtPaydate2').val(t_year+'/'+t_month+'/'+t_day);
              		var wParent = window.parent.document;
					$('#txtXnoa').val(wParent.getElementById("txtNoa").value);
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