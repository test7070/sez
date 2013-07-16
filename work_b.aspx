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
    var q_name = 'work' , t_content = ' field=noa,datea,workdate,uindate,cuadate,ordeno,no2,enddate,mount,rmount,inmount,wmount,memo,productno,product,process,station,processno,stationno,unit,modelno,model,hours,tggno,comp', bbsKey = ['noa'], as, t_where = '';
    var t_sqlname = 'work_load'; t_postname = q_name;
    var isBott = false;  /// 是否已按過 最後一頁
    var txtfield=[],afield,t_data,t_htm, t_bbsTag = 'tbbs';
    var i, s1;
        brwCount2 = 0;
        brwCount = -1;
        $(document).ready(function () {
            main();
        });         /// end ready

        function main() {
            if (dataErr)  /// 載入資料錯誤
            {
                dataErr = false;
                return;
            }
            mainBrow(6, t_content, t_sqlname, t_postname , r_accy );
         }
         
         function bbsAssign() {  
        	_bbsAssign();
 		}

        function q_gtPost() {  ///  for   store2 
         
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
                <th align="center" style='color:Blue;' ><a id='lblNoa'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblCuadate'></a></th>
                <!--<th align="center" style='color:Blue;' ><a id='lblDatea'></a></th>-->
                <th align="center" style='color:Blue;' ><a id='lblProductno'></a> / <a id='lblProduct'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblMount'></a></th>
                <!--<th align="center" style='color:Blue;' ><a id='lblWorkdate'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblUindate'></a></th>-->
                <th align="center" style='color:Blue;' ><a id='lblStation'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblInmount'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblRmount'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblWmount'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblOrdeno'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblTggno'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblProcess'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblHours'></a></th>
                <th align="center" style='color:Blue;' ><a id='lblMemo'></a></th>
            </tr>
            <tr>
                <td style="width:2%;"><input name="sel"  id="radSel.*" type="radio" />
                	<input id="txtDatea.*" type="hidden" />
                	<input id="txtWorkdate.*" type="hidden" />
                	<input id="txtUindate.*" type="hidden" />
                </td>
                <td style="width:12%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:6%;"><input class="txt" id="txtCuadate.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <!--<td style="width:6%;"><input class="txt" id="txtDatea.*" type="text" style="width:98%;"  readonly="readonly" /></td>-->
                <td style="width:14%;">
                	<input class="txt" id="txtProductno.*" type="text" style="width:98%;"  readonly="readonly" />
                	<input class="txt" id="txtProduct.*" type="text" style="width:98%;"  readonly="readonly" />
                </td>
                <td style="width:5%;"><input class="txt" id="txtMount.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <!--<td style="width:6%;"><input class="txt" id="txtWorkdate.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:6%;"><input class="txt" id="txtUindate.*" type="text" style="width:98%;"  readonly="readonly" /></td>-->
                <td style="width:9%;"><input class="txt" id="txtStationno.*" type="text" style="width:98%;"  readonly="readonly" />
                	<input class="txt" id="txtStation.*" type="text" style="width:98%;"  readonly="readonly" />
                </td>
                <td style="width:5%;"><input class="txt" id="txtInmount.*" type="text" style="width:98%; text-align: right;"  readonly="readonly" /></td>
                <td style="width:5%;"><input class="txt" id="txtRmount.*" type="text" style="width:98%; text-align: right;"  readonly="readonly" /></td>
                <td style="width:5%;"><input class="txt" id="txtWmount.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
                <td style="width:9%;">
                	<input class="txt" id="txtOrdeno.*" type="text" style="width:98%;"  readonly="readonly" />
                	<input class="txt" id="txtNo2.*" type="text" style="width:98%;"  readonly="readonly" />
                </td>
                <td style="width:7%;">
                	<input class="txt" id="txtTggno.*" type="text" style="width:98%;"  readonly="readonly" />
                	<input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" />
                </td>
                <td style="width:7%;"><input class="txt" id="txtProcess.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td style="width:5%;"><input class="txt" id="txtHours.*" type="text" style="width:98%;"  readonly="readonly" /></td>
                <td><input class="txt" id="txtMemo.*" type="text" style="width:98%;"  readonly="readonly" /></td>
            </tr>
        </table>
  <!--#include file="../inc/brow_ctrl.inc"--> 
</div>

</body>
</html> 

