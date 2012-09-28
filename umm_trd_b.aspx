<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src="../script/jquery.min.js" type="text/javascript"></script>
<script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
<script src='../script/qj_mess.js' type="text/javascript"></script>
<script src='../script/mask.js' type="text/javascript"></script>
<script type="text/javascript">
    var q_name = 'trd', t_bbsTag = 'tbbs', t_content = " field=noa,paysale,total,part2  order=odate ", afilter = [], bbsKey = ['noa'],  as; //, t_where = '';
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
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"></td>
                <td align="center"><a id='lblVccno'></a></td>
                <td align="center"><a id='lblTotal'></a></td>
                <td align="center"><a id='lblPaysale'></a></td>
                <td align="center"><a id='lblOpay'></a></td>
                <td align="center"><a id='lblPart2'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/></td>
                <td><input class="txt"  id="txtNoa.*" type="text"  /></td>
                <td><input class="txt" id="txtTotal.*" type="text" /></td>
                <td><input class="txt" id="txtPaysale.*" type="text"  /></td>
                <td><input class="txt" id="txtOpay.*" type="text"  /></td>
                <td><input class="txt" id="txtPart2.*" type="text" /></td>
            </tr>
        </table>
        <input type="button"  id="chkAll" value="全選" onclick="checkall();" />
  <!--#include file="../inc/pop_ctrl.inc"--> 
 </div>
</body>
</html>
