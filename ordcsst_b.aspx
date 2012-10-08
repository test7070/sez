<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
<script src='../script/qj_mess.js' type="text/javascript"></script>
<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
<script src='../script/mask.js' type="text/javascript"></script>
<script type="text/javascript">
    var q_name = 'ordcs', t_bbsTag = 'tbbs', t_content = " field=productno,product,size,dime,width,lengthb,radius,mount,weight,noa,no2,price  order=odate ", afilter = [], bbsKey = ['noa', 'no2'], t_count = 0, as;
    var t_sqlname = 'ordcs_load2'; t_postname = q_name; brwCount2 = 12;
    var isBott = false;  /// 是否已按過 最後一頁
    var txtfield = [], afield, t_data, t_htm;
    var i, s1;

    $(document).ready(function () {
        main();
    });         /// end ready

    function main() {
        if (dataErr)  /// 載入資料錯誤
        {
            dataErr = false;
            return;
        }
        mainBrow(6, t_content, t_sqlname, t_postname);
        /*var t_where='';
        if (location.href.indexOf('?') > -1)   // debug
        {
            t_where=location.href.substr(location.href.indexOf('where'));
            t_where="^^"+t_where.substr(0,t_where.indexOf(';'));
        }
        q_gt('ordc', t_where , 0, 0, 0, "", r_accy);*/
    }
    function bbsAssign() {  /// checked 
        _bbsAssign();
    }

    function q_gtPost() { 
    	/*for (var j = 0; j < q_bbsCount; j++) {
    		btnMinus('btnMinus_'+j);
    	}
        var ordc = _q_appendData("ordc", "", true);
        q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtRadius,txtWidth,txtDime,txtLengthb,txtMount,txtWeight,txtPrice,txtTotal,txtTheory,txtMemo,txtOrdbno,txtNo3', ordc.length, ordc, 'productno,product,spec,radius,width,dime,lengthb,mount,weight,price,total,theory,memo,noa,no3', '');*/
    }
    function refresh() {
        _refresh();
        size_change();
    }
    function size_change () {
		  if($('#txtRadius_0').val()=='0')	//根據第一筆資料判斷是鋼捲還是鋼管，鋼捲沒有Radius
            	{
            		$('#lblSize_help').text("厚度x寬度x長度");
	            	for (var j = 0; j < q_bbsCount; j++) {
			           $('#txtSize4_'+j).attr('hidden', 'true');
			           $('#x3_'+j).attr('hidden', 'true');
			         	$('#Size').css('width','222px');
			         	q_tr('txtSize1_'+ j ,q_float('txtDime_'+j));
			         	q_tr('txtSize2_'+ j ,q_float('txtWidth_'+j));
			         	q_tr('txtSize3_'+ j ,q_float('txtLengthb_'+j));
			         	$('#txtSize4_'+j).val(0);
			         	$('#txtRadius_'+j).val(0)
			         }
			     }
		         else
		         {
		         	$('#lblSize_help').text("短徑x長徑x厚度x長度");
			         for (var j = 0; j < q_bbsCount; j++) {
			         	$('#txtSize4_'+j).removeAttr('hidden');
			         	$('#x3_'+j).removeAttr('hidden');
			         	$('#Size').css('width','297px');
			         	q_tr('txtSize1_'+ j ,q_float('txtRadius_'+j));
			         	q_tr('txtSize2_'+ j ,q_float('txtWidth_'+j));
			         	q_tr('txtSize3_'+ j ,q_float('txtDime_'+j));
			         	q_tr('txtSize4_'+ j ,q_float('txtLengthb_'+j));
			         }
			     }
		}
</script>
<style type="text/css">
#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 98%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 15%;
                float: left;
            }
            .txt.c5 {
                width: 85%;
                float: left;
            }
            .txt.c6 {
                width: 100%;
                float: left;
            }
            .txt.c7 {
            	float:left;
                width: 22%;
                
            }
            .txt.c8 {
            	float:left;
                width: 65px;
                
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
         .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width: 100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center">&nbsp;</td>
                <td align="center"><a id='lblProductno_st'></a></td>
                <td align="center"><a id='lblProduct'></a></td>
                <td align="center"><a id='lblSpec'></a></td>
                <td align="center"><a id='lblSize'></a></td>
                <td align="center"><a id='lblMount'></a></td>
                <td align="center"><a id='lblWeight'></a></td>
                <td align="center"><a id='lblPrice'></a></td>
                <td align="center"><a id='lblNoa'></a></td>
                <td align="center"><a id='lblMemo'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="chkSel.*" type="checkbox"  /></td>
                <td style="width:10%;"><input class="txt"  id="txtProductno.*" type="text" style="width:98%;" /></td>
                <td style="width:15%;"><input class="txt" id="txtProduct.*" type="text" style="width:98%;" /></td>
                 <td style="width:15%;"><input class="txt" id="txtSpec.*" type="text"  style="width:98%;" /></td>
                <td style="width:18%;">
                       	<input class="txt num c8" id="txtSize1.*" type="text"/><div id="x1" style="float: left"> x</div>
                		<input class="txt num c8" id="txtSize2.*" type="text"/><div id="x2" style="float: left"> x</div>
                        <input class="txt num c8" id="txtSize3.*" type="text"/><div id="x3.*" style="float: left"> x</div>
                         <input class="txt num c8" id="txtSize4.*" type="text"/>
                         <!--上為虛擬下為實際-->
                         <input id="txtRadius.*" type="hidden"/>
                		<input  id="txtWidth.*" type="hidden"/>
                        <input  id="txtDime.*" type="hidden"/>
                         <input id="txtLengthb.*" type="hidden"/>
                </td>
                <td style="width:5%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/></td>
                <td style="width:5%;"><input class="txt" id="txtNoa.*" type="text" style="width:96%;"/><input class="txt" id="txtno2.*" type="text" /></td>
                <td style="width:8%;"><input class="txt" id="txtMemo.*" type="text" style="width:98%;"/><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
  <!--#include file="../inc/pop_ctrl.inc"--> 
 </div>
</body>
</html>
