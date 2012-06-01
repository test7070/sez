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
    var q_name = "custtran_s";

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

        bbmMask = [['txtBkeyin', r_picd], ['txtEkeyin', r_picd]];
        q_mask(bbmMask);

        $('#txtBkeyin').focus();
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_bkeyin = $('#txtBkeyin').val();
        t_ekeyin = $('#txtEkeyin').val();
        t_comp = $('#txtComp').val();
        t_boss = $('#txtBoss').val();
       
        t_bkeyin = t_bkeyin.length > 0 && t_bkeyin.indexOf("_") > -1 ? t_bkeyin.substr(0, t_bkeyin.indexOf("_")) : t_bkeyin;  /// 100.  .
        t_ekeyin = t_ekeyin.length > 0 && t_ekeyin.indexOf("_") > -1 ? t_ekeyin.substr(0, t_ekeyin.indexOf("_")) : t_ekeyin;  /// 100.  .

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("comp", t_comp) + q_sqlPara2("keyin", t_bkeyin, t_ekeyin) +
                           q_sqlPara2("boss", t_boss) ;

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
                <td   style="width:35%;" ><a id='lblKeyin'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBkeyin" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEkeyin" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblComp'></a></td>
                <td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblBoss'></a></td>
                <td><input class="txt" id="txtBoss" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
