<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>graph</title>
		<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="//59.125.143.170/jquery/css/qreport.css" />
		<script src="//59.125.143.170/jquery/js/qset.js" type="text/javascript"></script>
		<script type="text/javascript">
            $(document).ready(function() {
                $('#graph1').barChart({
                    width : 500,
                    height : 300,
                    xAxis : ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
                    yAxis : ["100", "200", "300", "400", "500", "600", "700", "800", "900", "1000"],
                    data : [{
                        rate : 0.23,
                        text : "230"
                    }, {
                        rate : 0.52,
                        text : "520"
                    }, {
                        rate : 0.68,
                        text : "680"
                    }, {
                        rate : 0.34,
                        text : "340"
                    }, {
                        rate : 0.43,
                        text : "430"
                    }]
                });
                $('#graph1').offset({
                    top : 30,
                    left : 0
                });

                $('#graph2').pieChart({
                    x : 200,
                    y : 200,
                    radius : 150,
                    data : [{
                        value : 1,
                        text : "A"
                    }, {
                        value : 3,
                        text : "B"
                    }, {
                        value : 7,
                        text : "C"
                    }, {
                        value : 4,
                        text : "D"
                    }, {
                        value : 2,
                        text : "E"
                    },{
                        value : 4,
                        text : "F"
                    }, {
                        value : 3,
                        text : "G"
                    }, {
                        value : 5,
                        text : "H"
                    }, {
                        value : 4,
                        text : "I"
                    }, {
                        value : 8,
                        text : "J"
                    }]
                });
                $('#graph2').width(500);
                $('#graph2').height(500);
               /* $('#graph2').offset({
                    top : 30,
                    left : 600
                });*/
				/*$('#graph3').pieChart2({
					width : 400,
                    height : 400,
                    x : 200,
                    y : 200,
                    radius : 150,
                    data : [{
                        value : 1,
                        text : "A"
                    }, {
                        value : 3,
                        text : "B"
                    }, {
                        value : 4,
                        text : "C"
                    }, {
                        value : 4,
                        text : "D"
                    }, {
                        value : 2,
                        text : "E"
                    }]
                });
                $('#graph3').offset({
                    top : 30,
                    left : 600
                });*/
            });

		</script>
	</head>
	<body>
		<div id="graph1"></div>
		<div id="graph2"></div>
		<div id="graph3"></div>
	</body>
</html>