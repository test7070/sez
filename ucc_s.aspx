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
    var q_name = "ucc_s";

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

       bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
        q_mask(bbmMask);

        $('#txtBdate').focus();
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();  
		t_product = $('#txtProduct').val();
		t_vccacc1 = $('#txtVccacc1').val();
		t_vccacc2 = $('#txtVccacc2').val();
		t_rc2acc1 = $('#txtrc2acc1').val();
		t_rc2acc2 = $('#txtrc2acc2').val();

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) +q_sqlPara2("product", t_product)+
        q_sqlPara2("vccacc1", t_vccacc1)+q_sqlPara2("vccacc2", t_vccacc2)+q_sqlPara2("rc2acc1", t_rc2acc1)+q_sqlPara2("rc2acc2", t_rc2acc2);

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
                <td class='seek'  style="width:20%;"><a id='lblItem'></a></td>
                <td><input class="txt" id="txtProduct" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblVccacc1'></a></td>
                <td><input class="txt" id="txtVccacc1" type="text" style="width:90px; font-size:medium;" />&nbsp;<input class="txt" id="txtVccacc2" type="text" style="width:115px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblRc2acc1'></a></td>
                <td><input class="txt" id="txtRc2acc1" type="text" style="width:90px; font-size:medium;" />&nbsp;<input class="txt" id="txtRc2acc2" type="text" style="width:115px; font-size:medium;" /></td>
             </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
