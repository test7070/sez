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
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            aPop = new Array(['txtXCustno', '', 'cust', 'noa,comp', 'txtXcustno', 'cust_b.aspx'],
            ['txtXsssno', '', 'sss', 'noa,namea', 'txtXsssno', 'sss_b.aspx']);
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_payacc');   
            });
            function q_gfPost() {
            	q_gt('ucc', "where=^^ CHARINDEX('代收',product)>0 and left(noa,1)='E' ^^", 0, 0, 0, "");
            }
            var t_item = "";
            function q_gtPost(t_name) {
            	switch (t_name) {
            	  	case 'ucc':
		                var as = _q_appendData("ucc", "", true);
		                if (as[0] != undefined) {
		                    t_item = "";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].product;
		                    }
		                    //q_cmbParse("cmbProductno", t_item); 
		                }
            		break;
                  }
                  
                  if(t_item.length>0 ){
	                  	$('#q_report').q_report({
		                    fileName : 'z_payacc',
		                    options : [{/*請款日期*/
		                        type : '1',
		                        name : 'date'
		                    },{/*客戶區間*/
		                        type : '2',
		                        name : 'xcust',
		                        dbf : 'cust',
		                        index : 'noa,comp',
		                        src : 'cust_b.aspx'
		                    },{/*業務區間*/
		                        type : '2',
		                        name : 'xsss',
		                        dbf : 'sss',
		                        index : 'noa,namea',
		                        src : 'sss_b.aspx'
		                    }, {/*代收項目*/
	                        type : '5', //select
	                        name : 'xproduct',
	                        value : [q_getPara('report.all')].concat(t_item.split(','))
	                    }]
					});
		            q_getFormat();
	                q_popAssign();
					q_langShow();
					t_item = "";
	              $('#txtDate1').mask('999/99/99');
	                $('#txtDate2').mask('999/99/99');
	                 var t_date,t_year,t_month,t_day;
		                t_date = new Date();
		                t_date.setDate(1);
		                t_year = t_date.getUTCFullYear()-1911;
		                t_year = t_year>99?t_year+'':'0'+t_year;
		                t_month = t_date.getUTCMonth()+1;
		                t_month = t_month>9?t_month+'':'0'+t_month;
		                t_day = t_date.getUTCDate();
		                t_day = t_day>9?t_day+'':'0'+t_day;
		                $('#txtDate1').val(t_year + '/' + t_month+'/'+t_day);
		                
		                t_date = new Date();
		                t_date.setDate(35);
		                t_date.setDate(0);
		                t_year = t_date.getUTCFullYear()-1911;
		                t_year = t_year>99?t_year+'':'0'+t_year;
		                t_month = t_date.getUTCMonth()+1;
		                t_month = t_month>9?t_month+'':'0'+t_month;
		                t_day = t_date.getUTCDate();
		                t_day = t_day>9?t_day+'':'0'+t_day;
		                $('#txtDate2').val(t_year + '/' + t_month+'/'+t_day);
                  }
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