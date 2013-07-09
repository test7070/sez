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
		aPop  =  new Array(['txtXsssno', 'lblXsssno', 'sss', 'noa,namea','txtSssno', 'sss_b.aspx'],
			['txtXcomp', 'lblXcomp', 'acomp', 'noa,acomp', 'txtXcomp', 'acomp_b.aspx'],
			['txtXcustno', 'lblXcustno', 'cust', 'noa,comp', 'txtXcustno', 'cust_b.aspx'],
			['txtSssall', '', 'sssall', 'noa,namea', 'txtSssall', 'sssall_b.aspx'],
			['txtCarownerno', 'lblCarownerno', 'carowner', 'noa,namea', 'txtCarownerno', 'carowner_b.aspx']);
		
             if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_labase');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_labase',
                        options : [{
                        type : '2',
                        name : 'xsssno',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                        },{
                        type : '2',
                        name : 'xcno',
                        dbf : 'acomp',
                        index : 'noa,acomp',
                        src : 'acomp_b.aspx'
                        },{
                        type : '2',
                        name : 'xcustno',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                        },{
                        type : '8',
                        name : 'xsss',
                        value : (('').concat(new Array("寄保","員工","司機","全部"))).split(',')
                    }, {
                        type : '6',
                        name : 'xyear'
                    }, {
                        type : '6',
                        name : 'cmon'
                    }, {
                            type : '2',
                            name : 'carownerno',
                            dbf : 'carowner',
                            index : 'noa,namea',
                            src : 'carowner_b.aspx'
                        },{
                        type : '0',
                        name : 'accy',
                        value : r_accy
                    },{
                        type : '8',
                        name : 'xtypea',
                        value : (('').concat(new Array("監理部","非監理部","全部"))).split(',')
                    }, {
                            type : '2',
                            name : 'sssall',
                            dbf : 'sssall',
                            index : 'noa,namea',
                            src : 'sssall_b.aspx'
                        }, {
                            type : '2',
                            name : 'xxsssall',
                            dbf : 'sssall',
                            index : 'noa,namea',
                            src : 'sssall_b.aspx'
                        }, {
                        type : '1',
                        name : 'xmon'
                    }, {
	                        type : '5', //select
	                        name : 'xlab',
	                        value : ('全部,投保,退保').split(',')
	                    }, {
	                        type : '1',
                       		name : 'salary'
	                    }, {
	                        type : '5', //select
	                        name : 'xorder',
	                        value : ('員工編號,投保公司').split(',')
	                    }]
                    });
                q_popAssign();
                
                $('#txtXmon1').mask('999/99');
                $('#txtXmon2').mask('999/99');
                $('#txtCmon').mask('999/99');
                
                
                 var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                $('#txtXmon1').val(t_year+'/'+t_month);
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                $('#txtXmon2').val(t_year+'/'+t_month);
	                
	                $('#txtXyear').val(t_year);
	                $('#txtSalary1').val(0);
	                $('#txtSalary2').val(999999);
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
           
          