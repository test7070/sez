<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title>寫入RQCODE</title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript">
			var text=location.search;
			text=text.substring(1,text.length);
		
            myMethod();
			//setInterval(myMethod, 1800000);//30min
			function myMethod() {
				$.ajax({
					url : 'qrget.aspx'
					, type : 'POST'
					, data : JSON.stringify({datea:text.split(';')[0],timea:text.split(';')[1],qrcode:text.split(';')[2]})
					, dataType : 'text'
					, timeout : 5000
					, success : function(data) {
					    if(data.length>0){
					        var t_date = new Date();
                            t_date = t_date.getFullYear()+'/'+(t_date.getMonth()+1)+'/'+t_date.getDate()+' '+t_date.getHours()+':'+t_date.getMinutes()+':'+t_date.getSeconds();
					        document.write(t_date+' : '+data+'<br>');
					    }
					}, complete : function() {
						document.write('上傳已完成!!');
					}, error : function(jqXHR, exception) {
					    var t_date = new Date();
						t_date = t_date.getFullYear()+'/'+(t_date.getMonth()+1)+'/'+t_date.getDate()+' '+t_date.getHours()+':'+t_date.getMinutes()+':'+t_date.getSeconds();
						if (jqXHR.status === 0) {
							document.write(t_date + 'Not connect.\n Verify Network.<br>');
						} else if (jqXHR.status == 404) {
							document.write(t_date + 'Requested page not found. [404]<br>');
						} else if (jqXHR.status == 500) {
							document.write(t_date + 'Internal Server Error [500].<br>');
						} else if (exception === 'parsererror') {
							document.write(t_date + 'Requested JSON parse failed.<br>');
						} else if (exception === 'timeout') {
							document.write(t_date + 'Time out error.<br>');
						} else if (exception === 'abort') {
							document.write(t_date + 'Ajax request aborted.<br>');
						} else {
							document.write(t_date + 'Uncaught Error.<br>' + jqXHR.responseText+'<br>');
						}
					}
				});
			}
        </script>

    </head>
    <body>

    </body>
</html>