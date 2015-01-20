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
    var q_name = "uccb_s";
	var aPop = new Array(['txtUseno', '', 'cust', 'noa,comp', 'txtUseno,txtUsea', 'cust_b.aspx']);
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

        /*bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
        q_mask(bbmMask);
        $('#txtBdate').focus();*/
         
    }

    function q_seekStr() {   
        t_storeno = $('#txtStoreno').val();
        t_store = $('#txtStore').val();
        t_productno = $('#txtProductno').val();
        t_product = $('#txtProduct').val();
        t_spec=$('#txtSpec').val();
        t_bdime = $('#txtBdime').val();
        t_edime = $('#txtEdime').val();
        t_bdime = t_bdime.length > 0 && t_bdime.indexOf("_") > -1 ? t_bdime.substr(0, t_bdime.indexOf("_")) : t_bdime;  /// 100.  .
        t_edime = t_edime.length > 0 && t_edime.indexOf("_") > -1 ? t_edime.substr(0, t_edime.indexOf("_")) : t_edime;  /// 100.  .
        t_bwidth = $('#txtBwidth').val();
        t_ewidth = $('#txtEwidth').val();
        t_bwidth = t_bwidth.length > 0 && t_bwidth.indexOf("_") > -1 ? t_bwidth.substr(0, t_bwidth.indexOf("_")) : t_bwidth;  /// 100.  .
        t_ewidth = t_ewidth.length > 0 && t_ewidth.indexOf("_") > -1 ? t_ewidth.substr(0, t_ewidth.indexOf("_")) : t_ewidth;  /// 100.  .
        t_blength = $('#txtBlength').val();
        t_elength = $('#txtElength').val();
        t_bwidth = t_blength.length > 0 && t_blength.indexOf("_") > -1 ? t_blength.substr(0, t_blength.indexOf("_")) : t_blength;  /// 100.  .
        t_ewidth = t_elength.length > 0 && t_elength.indexOf("_") > -1 ? t_elength.substr(0, t_elength.indexOf("_")) : t_elength;  /// 100.  .
        t_coilno = $('#txtCoilno').val();
        t_useno = $('#txtUseno').val();
        t_use = $('#txtUse').val();
        
		

        var t_where = " 1=1 " + q_sqlPara2("storeno", t_storeno) + q_sqlPara2("store", t_store) + q_sqlPara2("productno", t_productno)
        + q_sqlPara2("product", t_product)+ q_sqlPara2("spec", t_spec)+ q_sqlPara2("dime", t_bdime, t_edime)
        + q_sqlPara2("width", t_bwidth, t_ewidth)+ q_sqlPara2("lengthb", t_blength, t_elength)+ q_sqlPara2("coilno", t_coilno)
        + q_sqlPara2("useno", t_useno)+ q_sqlPara2("use", t_use);
        

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
                <td class='seek'  style="width:20%;"><a id='lblStoreno'> </a></td>
                <td><input class="txt" id="txtStoreno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtStore" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblProductno'> </a></td>
                <td><input class="txt" id="txtProductno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtProduct" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblSpec'> </a></td>
                <td><input class="txt" id="txtSpec" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
       	 	<tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblDime'> </a></td>
                <td style="width:65%;  "><input class="txt" id="txtBdime" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEdime" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
       		<tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblWidth'> </a></td>
                <td style="width:65%;  "><input class="txt" id="txtBwidth" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEwidth" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
       		<tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblLength'> </a></td>
                <td style="width:65%;  "><input class="txt" id="txtBlength" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtElength" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
       		<tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblColino'> </a></td>
                <td><input class="txt" id="txtColino" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblUseno'> </a></td>
                <td><input class="txt" id="txtUseno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtUsea" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
