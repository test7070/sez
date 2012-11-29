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
    var q_name = 'salinsures', t_content = ' ', bbsKey = ['noa'], as; 
    var isBott = false;  /// 是否已按過 最後一頁
    var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
    var i,s1;
        $(document).ready(function () {
            main();
        });         /// end ready

        function main() {
            if (dataErr)  /// 載入資料錯誤
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
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:150% ; height:100% ;  
        }      
        .txt.c1
        {
            width: 95%;
        }
        .td1
        {
            width: 3%;
        }
        .td2
        {
            width: 2%;
        }
    </style>
</head>

<body> 
<div  id="dbbs"  >
       <table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style="width: 150%;">
            <tr>
                <th align="center" > </th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblNoa'></a></th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblMon'></a></th>
                <th align="center" style='color:Blue;' class="td1"><a id='lblHe_person'></a></th>
                <th align="center" style='color:Blue;' class="td1"><a id='lblHe_comp'></a></th>
                <th align="center" style='color:Blue;' class="td1"><a id='lblLa_person'></a></th>
                <th align="center" style='color:Blue;' class="td1"><a id='lblLa_comp'></a></th>
                <th align="center" style='color:Blue;' class="td1"><a id='lblRe_person'></a></th>
                <th align="center" style='color:Blue;' class="td1"><a id='lblRe_comp'></a></th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblTotal1'></a></th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblTotal2'></a></th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblPayc'></a></th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblPay'></a></th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblUnpay'></a></th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblSalary'></a></th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblMount'></a></th>
                <th align="center" style='color:Blue;' class="td2"><a id='lblDisaster'></a></th>
            </tr>
            <tr>
                <td style="width:2%;"><input name="sel"  id="radSel.*" type="radio" /></td>
                <td ><input class="txt c1" id="txtNoa.*" type="text"   readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtMon.*" type="text"   readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtHe_person.*"  type="text"  readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtHe_comp.*"  type="text"  readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtLa_person.*"  type="text"   readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtLa_comp.*"  type="text"   readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtRe_person.*"  type="text"   readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtRe_comp.*"  type="text"  readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtTotal1.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtTotal2.*" type="text"   readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtPayc.*" type="text"   readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtPay.*" type="text"   readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtUnpay.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtSalary.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtMount.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt c1" id="txtDisaster.*" type="text"  readonly="readonly" /></td>
            </tr>
        </table>
  <!--#include file="../inc/brow_ctrl.inc"--> 
</div>
</body>
</html> 

