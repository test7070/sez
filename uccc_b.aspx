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
    var q_name = 'uccc', t_content = ' ', bbsKey = [''], as; 
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
                <th align="center" > </th>
                <td align="center" style="width:8%;"><a id='lblUno_st'> </a></td>
                <td align="center" style="width:6%;"><a id='lblProductno_st'> </a></td>
                <td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
                <td align="center" style="width:8%;"><a id='lblSpec_st'> </a></td>
                <td align="center" style="width:18%;"><a id='lblSize_st'> </a></td>
                <td align="center" style="width:4%;"><a id='lblMount_st'> </a></td>
                <td align="center" style="width:6%;"><a id='lblGweight_st'> </a></td>
                <td align="center" style="width:4%;"><a id='lblInvono_st'> </a></td>
                <td align="center" style="width:4%;"><a id='lblNo2_st'> </a></td>
                <td align="center" style="width:6%;"><a id='lblEweight_st'> </a></td>
                <td align="center" style="width:6%;"><a id='lblMweight_st'> </a></td>
                <td align="center" style="width:8%;"><a id='lblMemo_st'> </a></td>
                
            </tr>
            <tr>
                <td style="width:2%;"><input name="sel"  id="radSel.*" type="radio" /></td>
                <td ><input id="txtNoa.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
                <td ><input id="txtProductno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
                <td ><input id="txtProduct.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
                <td ><input id="txtSpec.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
                <td ><input id="txtRadius.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>x
                	 <input id="txtWidth.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>x
                	 <input id="txtDime.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>x
                	 <input id="txtLengthb.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
                </td>
                <td ><input id="txtEmount.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
                <td ><input id="txtGweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
                <td ><input id="txtInvono.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
                <td ><input id="txtNo2.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
                <td ><input id="txtEweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
                <td ><input id="txtMweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
                <td ><input id="txtMemo.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
                
            </tr>
        </table>
  <!--#include file="../inc/brow_ctrl.inc"--> 
</div>

</body>
</html> 

