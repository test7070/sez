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
    var q_name = "cardeal_s";

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
        $('#txtNoa').focus();
    }

    function q_seekStr() {   ///  搜尋按下時，執行
        t_noa = $('#txtNoa').val();
        t_nick = $('#txtNick').val();
        t_boss = $('#txtBoss').val();
        t_tel1 = $('#txtTel1').val();

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("nick", t_nick) + q_sqlPara2("boss", t_boss) + q_sqlPara2("tel1", t_tel1);

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
                <td   style="width:35%;" ><a id='lblNoa'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtNoa" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblNick'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtNick" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblBoss'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBoss" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblTel1'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtTel1" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
