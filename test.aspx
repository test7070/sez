<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			
			
			$(document).ready(function() {
				$.ajaxSetup({
  					timeout : 1000
				});
				$('#erp').click(function(e){
					erpWin = window.open('http://60.249.136.206');
					erpWin.setTimeout('zzz()', 5000);
					
			 		/*$.get("http://60.249.136.206/se/login.aspx",'', function(response,status,xhr){
    						alert(xhr);
  					}).error(function(){
						alert('error');
					});*/
				});
				$('#mail').click(function(e){
					var newwin = window.open("http://www.dachang.com.tw:8081/roundcube/"); 
					//newwin.location= ""; 
				});			         
			});
			function zzz(){
				alert($(erpWin.document).length);
			}
			
			$(document).ready(function() {
				$('#txtA').change(function(e){
					var re = /(\d{4})([^\.,.]*)$/g;
					alert($(this).val().replace(re,"$1.$2"));
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