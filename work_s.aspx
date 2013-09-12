<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

    var q_name = "work_s";
	
    $(document).ready(function () {
        main();
    });         /// end ready
	aPop = new Array(
        	['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx'],
        	['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx']
        	);
    function main() {
        mainSeek();
        q_gf('', q_name);
    }

    function q_gfPost() {
        q_getFormat();
        q_langShow();

        bbmMask = [['txtBcuadate', r_picd], ['txtEcuadate', r_picd]];
        q_mask(bbmMask);

        $('#txtBcuadate').focus();
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_bcuadate = $('#txtBcuadate').val();
        t_ecuadate = $('#txtEcuadate').val();
        t_productno = $('#txtProductno').val();
        t_product = $('#txtProduct').val();
        t_ordeno = $('#txtOrdeno').val();
        t_cuano = $('#txtCuano').val();

        t_bcuadate = t_bcuadate.length > 0 && t_bcuadate.indexOf("_") > -1 ? t_bcuadate.substr(0, t_bcuadate.indexOf("_")) : t_bcuadate;  /// 100.  .
        t_ecuadate = t_ecuadate.length > 0 && t_ecuadate.indexOf("_") > -1 ? t_ecuadate.substr(0, t_ecuadate.indexOf("_")) : t_ecuadate;  /// 100.  .

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)
        + q_sqlPara2("productno", t_productno) 
        + q_sqlPara2("product", t_product)
        + q_sqlPara2("ordeno", t_ordeno)
        + q_sqlPara2("cuano", t_cuano) 
        + q_sqlPara2("cuadate", t_bcuadate, t_ecuadate) 

        t_where = ' where=^^' + t_where + '^^ ';
        return t_where;
    }
</script>
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
<div style='width:400px; text-align:center;padding:15px;' >
       <table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblCuadate'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBcuadate" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEcuadate" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblOrdeno'></a></td>
                <td><input class="txt" id="txtOrdeno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCuano'></a></td>
                <td><input class="txt" id="txtCuano" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblProductno'></a></td>
                <td>
                	<input class="txt" id="txtProductno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtProduct" type="text" style="width:115px; font-size:medium;" />
                </td>
            </tr>
             
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
