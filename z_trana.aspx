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
			t_item = "";
           	t_item2 = "";
           	t_item3 = "";
           	t_item4 = "";
           	t_item5 = "";
           	aPop  =  new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver','txtXcarno', 'car2_b.aspx'],
           		['txtXaddr', 'lblXaddr', 'addr', 'noa,addr','txtXaddr', 'addr_b.aspx']);
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_trana');
            });
            function q_gfPost() {
            	
                q_gt('carteam', '', 0, 0, 0, "");
                q_gt('calctype2', '', 0, 0, 0, "calctypes");
                q_gt('carkind', '', 0, 0, 0, "");
                q_gt('calctype', '', 0, 0, 0);
                q_gt('acomp', '', 0, 0, 0);
            }

            function q_boxClose(t_name) {
            }
            function q_gtPost(t_name) {
            	
            	switch (t_name) {
            		case 'carkind':
                        var as = _q_appendData("carkind", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item3 = t_item3 + (t_item3.length>0?',':'') + as[i].noa +'@' + as[i].kind;
                        }  
                        break;
                    case 'carteam':
                        var as = _q_appendData("carteam", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length>0?',':'') + as[i].noa +'@' + as[i].team;
                        }    
                        break;
                    case 'calctypes':
                        var as = _q_appendData("calctypes", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item2 = t_item2 + (t_item2.length>0?',':'') + as[i].noa+as[i].noq +'@' + as[i].typea;
                        }    
                        break;
                    case 'calctype':
                        var as = _q_appendData("calctype", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item4 = t_item4 + (t_item4.length>0?',':'') + 'calctype_' + as[i].noa +'@' + as[i].namea;
                        }    
                        break;
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item5 = t_item5 + (t_item5.length>0?',':'') + as[i].acomp;
                        }    
                        break;
                }
      
                if(t_item.length>0 && t_item2.length>0 && t_item3.length>0 && t_item4.length>0 && t_item5.length>0){
	                $('#q_report').q_report({
	                    fileName : 'z_trana',
	                    options : [{
	                        type : '0',
	                        name : 'accy',
	                        value : q_getId()[4]
	                    }, {
	                        type : '1',
	                        name : 'date'
	                    }, {
	                        type : '2',
	                        name : 'cust',
	                        dbf : 'cust',
	                        index : 'noa,comp',
	                        src : 'cust_b.aspx'
	                    }, {
	                        type : '2',
	                        name : 'driver',
	                        dbf : 'driver',
	                        index : 'noa,namea',
	                        src : 'driver_b.aspx'
	                    }, {
	                        type : '6',
	                        name : 'xcarno'
	                    }, {
	                        type : '6',
	                        name : 'xpo'
	                    }, {
	                        type : '6',
	                        name : 'xaddr'
	                    }, {
	                        type : '8', //select
	                        name : 'xcarteamno',
	                        value : t_item.split(',')
	                    }, {
	                        type : '8', //mutiple select
	                        name : 'xcalctype',
	                        value : t_item2.split(',')
	                    }, {
	                        type : '8', //select
	                        name : 'xoption1',
	                        value : q_getPara('z_trana.option1').split(',')
	                    }, {
	                        type : '5', //select
	                        name : 'xoption2',
	                        value : q_getPara('z_trana.option2').split(',')
	                    }, {
	                        type : '5', //select
	                        name : 'xoption3',
	                        value : q_getPara('z_trana.option3').split(',')
	                    }, {
	                        type : '5', //select
	                        name : 'xoption4',
	                        value : q_getPara('z_trana.option4').split(',')
	                    }, {
	                        type : '5', //select
	                        name : 'xoption5',
	                        value : q_getPara('z_trana.option5').split(',')
	                    }, {
	                        type : '2',
	                        name : 'sales',
	                        dbf : 'sss',
	                        index : 'noa,namea',
	                        src : 'sss_b.aspx'
	                    }, {
	                        type : '8', //select
	                        name : 'xfield5',
	                        value : q_getPara('z_trana.field5').split(',')
	                    }, {
	                        type : '6', 
	                        name : 'yproduct'
	                    }, {
	                        type : '6', 
	                        name : 'yaddr'
	                    }, {
	                        type : '6', 
	                        name : 'yboatname'
	                    }, {
	                        type : '5', //select
	                        name : 'xoption7',
	                        value :  t_item.split(',')
	                    }, {
	                        type : '8', //select
	                        name : 'xoption8',
	                        value : t_item3.split(',')
	                    }, {
	                        type : '5', //select
	                        name : 'xsort5',
	                        value : q_getPara('z_trana.sort5').split(',').concat(t_item4.split(','))
	                    }, {
	                        type : '8', //select
	                        name : 'xfield13',
	                        value : q_getPara('z_trana.field13').split(',')
	                    }, {
	                        type : '5', //select
	                        name : 'xsort13',
	                        value : q_getPara('z_trana.sort13').split(',').concat(t_item4.split(','))
	                    }, {
	                        type : '8', //select
	                        name : 'xfield1',
	                        value : q_getPara('z_trana.field1').split(',')
	                    }, {
	                        type : '5', //select
	                        name : 'xsort1',
	                        value : q_getPara('z_trana.sort1').split(',').concat(t_item4.split(','))
	                    }, {
	                        type : '5', //select
	                        name : 'xacomp',
	                        value : t_item5.split(',')
	                    }, {
	                        type : '5', //select
	                        name : 'xsort14',
	                        value : q_getPara('z_trana.sort14').split(',')
	                    }, {
	                        type : '6', 
	                        name : 'xtrandono'
	                    },{
	                        type : '8', //select
	                        name : 'xoption14',
	                        value : q_getPara('z_trana.option14').split(',')
	                    }]
	                });
	                q_popAssign();
	                q_langShow();
	                
	                $('#txtDate1').mask('999/99/99');
	                $('#txtDate1').datepicker();
	                $('#txtDate2').mask('999/99/99');
	                $('#txtDate2').datepicker();  
	                t_item = "";
	                t_item2 = "";
	                t_item3 = "";
	                t_item4 = "";
	                t_item5 = "";
	                $('#chkXcarteamno').children('input').attr('checked','checked');
	                $('#chkXcalctype').children('input').attr('checked','checked');
	                $('#chkXfield5').children('input').attr('checked','checked');
	                $('#chkXoption8').children('input').attr('checked','checked');
	                $('#chkXfield13').children('input').attr('checked','checked');
	                $('#chkXfield1').children('input').attr('checked','checked');
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
            }
		</script>
	</head>
	<body>
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