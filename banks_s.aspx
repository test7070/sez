<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
    var q_name = "banks_s";
	aPop = new Array(['txtBankt', '', 'bankt', 'noa,namea', 'txtBankt,txtBanktname', 'bankt_b.aspx']);
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
        bbmMask = [['txtBdate', r_picd],['txtEdate', r_picd]];
        q_mask(bbmMask);
        $('#txtBdate').focus();
    }

    function q_seekStr() {   
        t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_noa = $('#txtNoa').val();
        t_account = $('#txtAccount').val();
        t_bankt = $('#txtBankt').val();
        t_banktname = $('#txtBanktname').val();
        t_checkno = $('#txtCheckno').val();

        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .
        var t_where = " 1=1 " + q_sqlPara2("datea", t_bdate, t_edate) +
         q_sqlPara2("noa", t_noa) + q_sqlPara2("account", t_account)
         + q_sqlPara2("banktno", t_bankt)+ q_sqlPara2("banktname", t_banktname)
         + q_sqlPara2("checkno", t_checkno);

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
                <td   style="width:35%;" ><a id='lblDatea'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblNoa'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtNoa" type="text" style="width:150px; font-size:medium;" />
            </tr>
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblAccount'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtAccount" type="text" style="width:150px; font-size:medium;" />
            </tr>
            <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblBankt'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBankt" type="text" style="width:150px; font-size:medium;" />
            </tr>
            <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblBankname'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBanktname" type="text" style="width:150px; font-size:medium;" />
            </tr>
            <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblCheckno'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtCheckno" type="text" style="width:150px; font-size:medium;" />
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
