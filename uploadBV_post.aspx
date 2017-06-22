<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
		    $(document).ready(function () {
		        _q_boxClose();
		        q_getId();
		        q_gf('', 'uploaddc');

                q_func('etc.watch', "a")
		    });
		    
		    function q_funcPost( func,result) {
		        $('#txtMessage').text(" 已轉入資料庫");
		        if(result.length>0 && result.indexOf('^@')>-1){
		        	var t_tr=result.split('\\r');
		        	var divtable="<table id='edi_table'>";
		        	for (var i=0;i<t_tr.length;i++){
		        		divtable+="<tr>";
		        		var t_td=t_tr[i].split('^@');
		        		for (var j=0;j<t_td.length;j++){
		        			divtable+="<td>"+replaceAll(t_td[j],'^^$','')+"</td>";
		        		}
		        		divtable+="</tr>";	
		        	}
		        	divtable+="</table>";
		        	$('#divMemo').html(divtable);
		        }
		    }
		    
		    function q_gfPost() {
		        q_langShow();
		    }
		</script>
		<style type="text/css">
			#edi_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #edi_table tr {
                height: 30px;
            }
            #edi_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: blanchedalmond;
            }
		</style>
	</head>
<body>
    <div id='q_menu'> </div>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <span id='txtMessage' style="font-weight: 700; font-size: x-large; color: #0000FF">資料處理中.....預估三分鐘，請勿再上傳檔案，會容易造成當機</span>
    <div id='divMemo'> </div>
    <p>&nbsp;</p>
</body>
</html>
