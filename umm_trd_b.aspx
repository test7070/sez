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
    var q_name = 'trd', t_bbsTag = 'tbbs', t_content = " field=noa,paysale,total,part2,comp  order=odate ", afilter = [], bbsKey = ['noa'],  as; //, t_where = '';
    var t_sqlname = 'umm_trd_load'; t_postname = q_name; brwCount2 = 12;
    var isBott = false;  /// 是否已按過 最後一頁
    var txtfield = [], afield, t_data, t_htm;
    var bbsNum = [['txtPaysale', 10, 0, 1],['txtTotal', 10, 0, 1],['txtOpay', 10, 0, 1]];
    var i, s1;
	/*說明---開始載入資料時會抓umm_trd_load的內容，且load的第一個資料表為trd，因此q_name為trd，
	 * 而q_lang為umm_trd(網頁_b之前的值)*/

    $(document).ready(function () {
    	//當沒有網址參數
    	if (location.href.indexOf('?') < 0)   // debug
        {
            location.href = location.href + "?;;;^^1=0^^where[1]=^^1=0^^";
            return;
        }
        //custno='A003' and unpay!='0'^^where[1]=^^noa!='J1010925001'^^
        if (!q_paraChk())
            return;
        main();
    });         /// end ready

    function main() {
        if (dataErr)  /// 載入資料錯誤
        {
            dataErr = false;
            return;
        }
        mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
        $('#chkAll').click(function () {
			for (var j = 0; j < brwCount2; j++) {
				if(!emp($('#txtNoa_'+j).val()))
					$('#chkSel_'+j)[0].checked="true";
			}
        });
    }

    function bbsAssign() { 
        _bbsAssign();
	   	for (var j = 0; j < brwCount2; j++) {
	        if(!emp($('#txtNoa_'+j).val()))
	        	q_tr('txtOpay_'+ j ,q_float('txtTotal_'+j)-q_float('txtPaysale_'+j));
	   }
    }

    function q_gtPost() {  

    }
    function refresh() {
        _refresh();
    }
    function checkall() {
		var check1 = document.getElementById("chkAll");
		var check2 = document.getElementsByName("chkSel");
		
		for(var i=0;i<check2.length;i++)
    	{
    		check2[i].checked=check1.checked;   
    	}
	}
</script>
<style type="text/css">
	#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 18%;
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
                width: 80%;
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
                width: 48%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
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
            .tbbm td input[type="button"] {
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width: 3%;"></td>
                <td align="center" style="width: 15%;"><a id='lblVccno'></a></td>
                <td align="center" style="width: 15%;"><a id='lblTotal'></a></td>
                <td align="center" style="width: 15%;"><a id='lblPaysale'></a></td>
                <td align="center" style="width: 15%;"><a id='lblOpay'></a></td>
                <td align="center" style="width: 10%;"><a id='lblPart2'></a></td>
                <td align="center"><a id='lblComp'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/></td>
                <td><input id="txtNoa.*" type="text" class="txt c1" /></td>
                <td><input id="txtTotal.*" type="text" class="txt num c1"/></td>
                <td><input id="txtPaysale.*" type="text" class="txt num c1"/></td>
                <td><input id="txtOpay.*" type="text" class="txt num c1" /></td>
                <td><input id="txtPart2.*" type="text" class="txt c1"/></td>
                <td><input id="txtComp.*" type="text" class="txt c1"/></td>
            </tr>
        </table>
        <input type="button"  id="chkAll" value="全選" onclick="checkall();" />
  <!--#include file="../inc/pop_ctrl.inc"--> 
 </div>
</body>
</html>
