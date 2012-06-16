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
    var q_name = "trans_s";

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

        bbmMask = [['txtBtrandate', r_picd], ['txtEtrandate', r_picd]];
        q_mask(bbmMask);

        $('#txtBtrandate').focus();
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_driverno = $('#txtDriverno').val();
        t_driver = $('#txtDriver').val();
        t_custno = $('#txtCustno').val();
        t_comp = $('#txtComp').val();
        t_carno = $('#txtCarno').val();
        t_po = $('#txtpo').val();
        t_caseno = $('#txtCaseno').val();
        
		t_btrandate = $('#txtBtrandate').val();
        t_etrandate = $('#txtEtrandate').val();
        t_btrandate = t_btrandate.length > 0 && t_btrandate.indexOf("_") > -1 ? t_btrandate.substr(0, t_btrandate.indexOf("_")) : t_btrandate;  /// 100.  .
        t_etrandate = t_etrandate.length > 0 && t_etrandate.indexOf("_") > -1 ? t_etrandate.substr(0, t_etrandate.indexOf("_")) : t_etrandate;  /// 100.  .

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("Trandate", t_btrandate, t_etrandate) +
                            q_sqlPara2("driverno", t_driverno)+ q_sqlPara2("driver", t_driver)+ q_sqlPara2("custno", t_custno)+ q_sqlPara2("comp", t_comp)
                            + q_sqlPara2("carno", t_carno)+ q_sqlPara2("po", t_po)+ q_sqlPara2("caseno", t_caseno)+ q_sqlPara2("caseno2", t_caseno);

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
                <td   style="width:35%;" ><a id='lblTrandate'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBtrandate" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEtrandate" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr> 
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblDriverno'></a></td>
                <td><input class="txt" id="txtDriverno" type="text" style="width:90px; font-size:medium;" />&nbsp;<input class="txt" id="txtDriver" type="text" style="width:115px;font-size:medium;" /></td>
             </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
                <td><input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />&nbsp;<input class="txt" id="txtComp" type="text" style="width:115px;font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCaseno'></a></td>
                <td><input class="txt" id="txtCaseno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr> 
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblPo'></a></td>
                <td><input class="txt" id="txtPo" type="text" style="width:215px; font-size:medium;" /></td>
            </tr> 
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
                <td><input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr> 
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
