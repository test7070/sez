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
            
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_credit');   
            });
			function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_credit',
					options : [{/*[1]*/
						type : '0',
						name : 'accy',
						value : r_accy
					}, {/*[2][3]*///1
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*[4][5]*///2
                        type : '2',
                        name : 'group',
                        dbf : 'team',
                        index : 'noa,team',
                        src : 'team_b.aspx'
                    },{/*[6]*//*型態*///3
                        type : '5',
                        name : 'stype',
                        value : [q_getPara('report.all')].concat(q_getPara('gqb.typea').split(','))
                    }, {/*[7]*//*兌現*///4
                        type : '5',
                        name : 'status',
                        value : [q_getPara('report.all')].concat(new Array('Y', 'N'))
                    }, {/*[8][9]*//*收開日期*///5
                        type : '1',
                        name : 'date'
                    }, {/*[10][11]*//*到期日期*///6
                        type : '1',
                        name : 'indate'
                    },{/*[12][13]*//*銀行編號*///7
                        type : '2',
                        name : 'bank',
                        dbf : 'bank',
                        index : 'noa,bank',
                        src : 'bank_b.aspx'
                    }, {/*[14]*/
                        type : '5',
                        name : 'sort01',
                        value : q_getMsg('sort01').split('&')
                    }, {/*[15]*/
                        type : '0',
                        name : 'ctypea',
                        value : q_getPara('gqb.typea')
                    }]
                });
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                
                $('#txtIndate1').mask('999/99/99');
                $('#txtIndate1').datepicker();
                $('#txtIndate2').mask('999/99/99');
                $('#txtIndate2').datepicker();
                
                var t_key = q_getHref();
                //抓製令單號
				if(t_key[1] != undefined){
                	$('#txtCust1a').val(t_key[1]);
                	$('#txtCust2a').val(t_key[1]);
                	$('#btnOk').click();
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