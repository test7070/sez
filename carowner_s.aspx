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
    var q_name = "carowner_s";

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
        t_namea = $('#txtNamea').val();
        t_idno = $('#txtIdno').val();
        t_tel = $('#txtTel').val();
        t_addr_conn = $('#txtAddr_conn').val();
		/*t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .*/
		var tel_where=" ";
		if(t_tel.length>0)
			tel_where=" and ( left(tel1,"+t_tel.length+")='"+t_tel+"' or left(tel2,"+t_tel.length+")='"+t_tel+"' or left(mobile,"+t_tel.length+")='"+t_tel+"') ";
		
		var addr_conn_where=" ";
		if(t_addr_conn.length>0)
			addr_conn_where=" and charindex('"+t_addr_conn+"',addr_conn)>0 ";
		
        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("namea", t_namea)+ q_sqlPara2("idno", t_idno)+tel_where+addr_conn_where;

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
                <td class='seek'  style="width:20%;"><a id='lblNamea'></a></td>
                <td><input class="txt" id="txtNamea" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblIdno'></a></td>
                <td><input class="txt" id="txtIdno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblTel'></a></td>
                <td><input class="txt" id="txtTel" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblAddr_conn'></a></td>
                <td><input class="txt" id="txtAddr_conn" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
