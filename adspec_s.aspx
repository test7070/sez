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
    var q_name = "adspec_s";
    $(document).ready(function () {
        main();
    });         /// end ready
	aPop = new Array(['txtProductno', '', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx']);
    function main() {
        mainSeek();
        q_gf('', q_name);
    }

    function q_gfPost() {
        q_getFormat();
        q_langShow();
		q_cmbParse("cmbStyle",('全部'+',').concat(q_getPara('adsss.stype').split(',')));
        bbmMask = [['txtMon', r_picm]];
        q_mask(bbmMask);

        $('#txtMon').focus();
    }

    function q_seekStr() {   
        t_mon = $('#txtMon').val();
        t_noa = $('#txtNoa').val();
        t_style = $('#cmbStyle').val();
        t_productno = $('#txtProductno').val();
        t_product = $('#txtProduct').val();
        t_spec = $('#txtSpec').val();
        
       /* t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .*/

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("mon", t_mon)
        + q_sqlPara2("productno", t_productno)+ q_sqlPara2("product", t_product)+ q_sqlPara2("spec", t_spec);
        if(t_style != '全部')
                t_where+= q_sqlPara2("style", t_style);

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
                <td class='seek'  style="width:20%;"><a id='lblMon'> </a></td>
                <td><input class="txt" id="txtMon" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblStyle'> </a></td>
                <td><select id="cmbStyle" style="width:215px; font-size:medium;"> </select></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblProductno'> </a></td>
                <td><input class="txt" id="txtProductno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblProduct'> </a></td>
                <td><input class="txt" id="txtProduct" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblSpec'> </a></td>
                <td><input class="txt" id="txtSpec" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
