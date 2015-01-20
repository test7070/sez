<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
    var q_name = 'drun', t_content = ' ', bbsKey = ['noa'], as; 
    var isBott = false;  
    var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
    var i,s1;
        $(document).ready(function () {
            main();
        });         /// end ready

        function main() {
            if (dataErr)  
            {
                dataErr = false;
                return;
            }
            mainBrow(0,t_content);
         }

        function q_gtPost() {  
        }

        function refresh() {
            _refresh();
        }
    </script>
    <style type="text/css">
    </style>
</head>

<body> 
<div  id="dbbs"  >
       <table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
            <tr>
                <th align="center" style='color:Blue;' ><a id='lblDatea'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblTimea'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblUsera'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblAction'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblNoa'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblTablea'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblTitle'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblMemo'></a></th>
            </tr>
            <tr>
                <td style="width:10%;"><input class="txt" id="txtDatea.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:10%;"><input class="txt" id="txtTimea.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:10%;"><input class="txt" id="txtUsera.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:10%;"><input class="txt" id="txtAction.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:10%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:10%;"><input class="txt" id="txtTablea.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:10%;"><input class="txt" id="txtTitle.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:20%;"><input class="txt" id="txtMemo.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            </tr>
        </table>
  <!--#include file="../inc/brow_ctrl.inc"--> 
</div>

</body>
</html> 

