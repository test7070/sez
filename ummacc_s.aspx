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
    var q_name = "ummacc_s";
    var aPop = new Array(['txtRacc1', '','acc','acc1,acc2', 'txtRacc1,txtRacc2',"acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
    					 ['txtPacc1', '','acc','acc1,acc2', 'txtPacc1,txtPacc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
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

     /*  bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
        q_mask(bbmMask);

        $('#txtBdate').focus();*/
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_typea = $('#txtTypea').val();
		t_racc1 = $('#txtRacc1').val();
		t_racc2 = $('#txtRacc2').val();
		t_pacc1 = $('#txtPacc1').val();
		t_pacc2 = $('#txtPacc2').val();
        /*t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .*/

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) +q_sqlPara2("typea", t_typea)+ q_sqlPara2("racc1", t_racc1)+q_sqlPara2("racc2", t_racc2)+ q_sqlPara2("pacc1", t_pacc1)+q_sqlPara2("pacc2", t_pacc2);

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
                <td class='seek'  style="width:20%;"><a id='lblTypea'></a></td>
                <td><input class="txt" id="txtTypea" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblRacc1'></a></td>
                <td><input class="txt" id="txtRacc1" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtRacc2" type="text" style="width:115px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblPacc1'></a></td>
                <td><input class="txt" id="txtPacc1" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtPacc2" type="text" style="width:115px; font-size:medium;" /></td>
             </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
