<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
<script type="text/javascript">
    var q_name = "acczs_s";

    $(document).ready(function () {
        main();
    });         /// end ready

    function main() {
        mainSeek();
        q_gf('', q_name);
    }

    function q_gfPost() {
        q_getFormat();
        q_langShow();

        bbmMask = [['txtBsale_date', r_picd], ['txtEsale_date', r_picd]];
        q_mask(bbmMask);

        $('#txtBdate').focus();
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_bsale_date = $('#txtBsale_date').val();
        t_esale_date = $('#txtEsale_date').val();
        t_namea = $('#txtNamea').val();
        

        t_bsale_date = t_bsale_date.length > 0 && t_bsale_date.indexOf("_") > -1 ? t_bsale_date.substr(0, t_bsale_date.indexOf("_")) : t_bsale_date;  /// 100.  .
        t_esale_date = t_esale_date.length > 0 && t_esale_date.indexOf("_") > -1 ? t_esale_date.substr(0, t_esale_date.indexOf("_")) : t_esale_date;  /// 100.  .

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("namea", t_namea) + q_sqlPara2("sale_date", t_bsale_date, t_esale_date);

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
                <td   style="width:35%;" ><a id='lblSale_date'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBsale_date" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEsale_date" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNamea'></a></td>
                <td><input class="txt" id="txtNamea" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
