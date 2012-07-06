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
           	aPop  =  new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver','txtXcarno', 'car2_b.aspx'],
           		['txtXaddr', 'lblXaddr', 'addr2', 'noa,addr','txtXaddr', 'addr_b.aspx']);
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
                q_gt('calctype', '', 0, 0, 0, "");
               
            }

            function q_boxClose(t_name) {
            }
            function q_gtPost(t_name) {
            	switch (t_name) {
                    case 'carteam':
                        var as = _q_appendData("carteam", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length>0?',':'') + as[i].noa +'@' + as[i].team;
                        }    
                        break;
                    case 'calctype':
                        var as = _q_appendData("calctype", "", true);
                        for( i = 0; i < as.length; i++) {
                            t_item2 = t_item2 + (t_item2.length>0?',':'') + as[i].noa +'@' + as[i].typea;
                        }    
                        break;
                }
      
                if(t_item.length>0 && t_item2.length>0){
	                $('#qReport').q_report({
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
	                    }]
	                });
	                q_getFormat();
	                q_langShow();
	                q_popAssign();
	
	                $('#txtDate1').mask('999/99/99');
	                $('#txtDate1').datepicker();
	                $('#txtDate2').mask('999/99/99');
	                $('#txtDate2').datepicker();  
	                t_item = "";
	                t_item2 = "";
                }
            }
		</script>
	</head>
	<body>
		
			<div id="q_menu"> </div>
			<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="qReport"> </div>
			</div>
			<div class="prt" >
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	
	</body>
</html>