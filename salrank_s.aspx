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
    var q_name = "salrank_s";

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

       /* bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
        q_mask(bbmMask);
        $('#txtBdate').focus();*/
         
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_bmoney = $('#txtBmoney').val();
        t_emoney = $('#txtEmoney').val();
        t_level1 = $('#txtLevel1').val(); 
        t_level2 = $('#txtLevel2').val();
        /*t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .*/
        t_bmoney = t_bmoney.length > 0 && t_bmoney.indexOf("_") > -1 ? t_bmoney.substr(0, t_bmoney.indexOf("_")) : t_bmoney;  /// 100.  .
        t_emoney = t_emoney.length > 0 && t_emoney.indexOf("_") > -1 ? t_emoney.substr(0, t_emoney.indexOf("_")) : t_emoney;  /// 100.  .

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)+ q_sqlPara2("level1", t_level1)
        + q_sqlPara2("level2", t_level2)+ q_sqlPara2("money", t_bmoney,t_emoney);
        

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
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblMoney'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBmoney" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEmoney" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblLevel1'></a></td>
                <td><input class="txt" id="txtLevel1" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblLevel2'></a></td>
                <td><input class="txt" id="txtLevel2" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
