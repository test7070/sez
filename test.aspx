<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			
			
			$(document).ready(function() {
				$('#txtA').change(function(e){
					
					var patt = /^(?:[0-1][0-9]|2[0-3])\:([0-5][0-9])$/g;
					alert(patt.test($(this).val()));
					/*var re = /(\d{4})([^\.,.]*)$/g;
					alert($(this).val().replace(re,"$1.$2"));*/
				});
				
			//(?:0?[1-9]|1[0-2])$
				
			});
			function FormatNumber(n) {
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
		</script>
	</head>
	<body>
		<input id="txtA" style="width:200px;"/>
	</body>
</html>