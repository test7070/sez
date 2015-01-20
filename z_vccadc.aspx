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
            t_cno = '';
            t_isinit = false;
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_vccadc');
            });
            function q_gfPost() {
            	q_gt('acomp', 'where=^^ exists(select top 1 noa from vcca where acomp.noa=vcca.cno) ^^', 0, 0, 0);
            }
			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acomp':
                        t_cno = '';
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_cno += (t_cno.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
                        }
                        t_cno += ',checkAll@全選';
                        break;
                }
              
               if (!t_isinit && t_cno.length > 0 ) {
               	t_isinit = true;  
                $('#q_report').q_report({
                    fileName : 'z_vccadc',
                    options : [ {//1  [1][2]
                        type : '1',
                        name : 'xmon'
                    },{//2  [3][4]
                        type : '1',
                        name : 'bmon'
                    }, {//3  [5[6]
                        type : '1',
                        name : 'emon'
                    }, {//4  [7][8]
                        type : '2',
                        name : 'xcust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {//5  [9][10]
                        type : '2',
                        name : 'xacomp',
                        dbf : 'acomp',
                        index : 'noa,acomp',
                        src : 'acomp_b.aspx'
                    }, {//  [11]
                    	type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {//6  [12]
                        type : '8',
                        name : 'xcno',
                        value : t_cno.split(',')
                     },{//7  [13][14]
                        type : '1',
                        name : 'xinvono'
                     },{//8  [15]
                        type : '6',
                        name : 'xyear'
                  }]
                });
                q_popAssign();
				q_langShow();
                $('#txtXmon1').mask('999/99');
                $('#txtXmon2').mask('999/99');
                $('#txtBmon1').mask('999/99');
                $('#txtBmon2').mask('999/99');
                $('#txtEmon1').mask('999/99');
                $('#txtEmon2').mask('999/99');
                $('#txtXyear').mask('999');
                
                var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXmon1').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtXmon2').val(t_year+'/'+t_month);
	                
	                var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtBmon1').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtBmon2').val(t_year+'/'+t_month);
	             var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtEmon1').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtEmon2').val(t_year+'/'+t_month);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                $('#txtXyear').val(t_year);

            		$("input[type='checkbox'][value='checkAll']").click(function() {
            			if($(this).next('span').text() == '全選'){
							$("input[type='checkbox'][value!='']").attr('checked',true);
							$(this).removeAttr('checked');
							$(this).next('span').text('取消全選');
						}else if($(this).next('span').text() == '取消全選'){
							$("input[type='checkbox'][value!='']").removeAttr('checked');
							$(this).next('span').text('全選');
						}
					});	                    
            }
		}
            function q_boxClose(s2) {
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