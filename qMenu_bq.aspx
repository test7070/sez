<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head >
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>ERP Menu</title>
		<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src="qset.js" type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		
		<link rel="stylesheet" href="//59.125.143.170/jquery/css/qreport.css" />
		<script src="//59.125.143.170/jquery/js/qset.js" type="text/javascript"></script>
		<script type="text/javascript">
            $(document).ready(function() {
                var txtMenu = 'qrs.txt';
                switch (q_db) {
                    case 'j':
                        txtMenu = 'qbq.txt';
                }
                q_gf(txtMenu);
            });
            function q_gfPost() {
               /* $('#qMenu2').qMenu({
                    text : xmlString
                });
                $('#qMenu2').offset({
                    top : 20,
                    left : 300
                });*/
                $('#qMenu').q_menu({
                    text : xmlString
                });
            }
		</script>
	</head>
	<body id="test2">
		<div id="qMenu"></div>
		<div id="qMenu2"></div>
	</body>
</html>
