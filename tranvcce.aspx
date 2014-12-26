<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var befDate = new Array();
            var curData = new Array();

            $(document).ready(function() {
                $('#txtDate_0').focusout(function(e) {
                   // $('#txtDate_0').text($('#txtDate_0').text() + 'xx');
                }).focus(function(e) {
                    $(this).selectText();
                });
				
            });
            jQuery.fn.selectText = function(){
	            var doc = document;
	            var element = this[0];
	            console.log(this, element);
	            if (doc.body.createTextRange) {
	                var range = document.body.createTextRange();
	                range.moveToElementText(element);
	                range.select();
	            } else if (window.getSelection) {
	                var selection = window.getSelection();
	                var range = document.createRange();
	                range.selectNodeContents(element);
	                selection.removeAllRanges();
	                selection.addRange(range);
	            }
            };

            var w;

            function startWorker() {
                if ( typeof (Worker) !== "undefined") {
                    if ( typeof (w) == "undefined") {
                        w = new Worker("demo_workers.js");
                    }
                    w.onmessage = function(event) {
                        document.getElementById("result").innerHTML = event.data;
                    };
                } else {
                    document.getElementById("result").innerHTML = "Sorry! No Web Worker support.";
                }
            }

            function stopWorker() {
                w.terminate();
                w = undefined;
            }

		</script>
		<style type="text/css">
            .tHeader {
                border: 1px solid gray;
                font-size: medium;
                background-color: gray;
            }
            .tHeader td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: darkblue;
            }
            .tHeader a {
                color: white;
            }
            .tData {
                border: 1px solid gray;
                font-size: medium;
                background-color: white;
            }
            .tData td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #cad3ff;
            }
            .tData a {
                color: black;
            }
		</style>
	</head>
	<body>
		<div>
			<table class="tHeader">
				<tr>
					<td align="center" style="width:80px; color:black;"><a>日期</a></td>
					<td align="center" style="width:80px; color:black;"><a>貨主</a></td>
					<td align="center" style="width:80px; color:black;"><a>起迄</a></td>
					<td align="center" style="width:80px; color:black;"><a>船公司</a></td>
					<td align="center" style="width:80px; color:black;"><a>規格</a></td>
					<td align="center" style="width:80px; color:black;"><a>櫃號一</a></td>
					<td align="center" style="width:80px; color:black;"><a>櫃號二</a></td>
					<td align="center" style="width:80px; color:black;"><a>領</a></td>
					<td align="center" style="width:80px; color:black;"><a>送</a></td>
					<td align="center" style="width:80px; color:black;"><a>收</a></td>
					<td align="center" style="width:80px; color:black;"><a>交</a></td>
					<td align="center" style="width:80px; color:black;"><a>備註</a></td>
				</tr>
			</table>
		</div>
		<div>
			<table class="tData">
				<tr>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true" id="txtDate_0">日期</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">貨主</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">起迄</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">船公司</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">規格</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">櫃號一</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">櫃號二</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">領</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">送</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">收</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">交</a></td>
					<td align="center" style="width:80px; color:black;"><a contenteditable="true">備註</a></td>
				</tr>
			</table>
		</div>
	</body>
</html>
