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
    
    var q_name = 'vcce_import', t_bbsTag = 'tbbs', t_content = " field=uno,ordeno,no2,productno,product,radius,width,dime,lengthb,spec,mount,weight,price,custno,comp", afilter = [], bbsKey = ['ordeno'],  as; //, t_where = '';
    var t_sqlname = 'vcce_import'; t_postname = q_name; brwCount2 = 10;
    var isBott = false;  /// 是否已按過 最後一頁
    var txtfield = [], afield, t_data, t_htm;
    var i, s1;
    q_desc = 1;
    $(document).ready(function () {
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
    }

    function bbsAssign() { 
        _bbsAssign();
    }

    function q_gtPost() {  

    }
    function refresh() {
        _refresh();
		$('#checkAllCheckbox').click(function(){
			$('input[type=checkbox][id^=chkSel]').each(function(){
				var t_id = $(this).attr('id').split('_')[1];
				if(!emp($('#txtOrdeno_' + t_id).val()))
					$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
			});
		});
    }

</script>
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
    input[type="text"], input[type="button"] {
		font-size: medium;
    }
    .txt {
    	float:left;
    }
    .c1 {
    	width:95%;
    }
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center">
					<input type="checkbox" id="checkAllCheckbox"/>
				</td>
                <td align="center"><a id='lblUno'></a></td>
                <td align="center"><a id='lblOrdeno'></a></td>
                <td align="center"><a id='lblCustno'></a></td>
                <td align="center"><a id='lblProductno'></a></td>
                <td align="center"><a id='lblSizea'></a></td>
                <td align="center"><a id='lblMount'></a></td>
                <td align="center"><a id='lblWeight'></a></td>
                <td align="center"><a id='lblPrice'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;" align="center"><input id="chkSel.*" type="checkbox"/></td>
                <td style="width:12%;"><input class="txt c1" id="txtUno.*" type="text"/></td>
                <td style="width:15%;">
                	<input class="txt" id="txtOrdeno.*" type="text" style="width:65%;"/>
                	<input class="txt" id="txtNo2.*" type="text" style="width:25%;"/>
                </td>
                <td style="width:10%;">
                	<input class="txt c1" id="txtCustno.*" type="text"/>
                	<input class="txt c1" id="txtComp.*" type="text"/>
                </td>
                <td style="width:15%;">
                	<input class="txt c1" id="txtProductno.*" type="text"/>
                	<input class="txt c1" id="txtProduct.*" type="text"/>
                </td>
                <td style="width:25%;"><input class="txt" id="txtSpec.*" type="text"  style="width:98%;" />
                                    <input id="txtRadius.*" type="text"  style="width:21%;text-align:right;" />x
                                    <input id="txtDime.*" type="text"  style="width:21%;text-align:right;" />x
                                    <input id="txtWidth.*" type="text"  style="width:21%;text-align:right;" />x
                                    <input id="txtLengthb.*" type="text"  style="width:21%;text-align:right;" /></td>
                <td style="width:8%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/></td>
            </tr>
        </table>
  <!--#include file="../inc/pop_ctrl.inc"--> 
 </div>
</body>
</html>
