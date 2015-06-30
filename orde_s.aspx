﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
    var q_name = "orde_s";
    var aPop = new Array(['txtCustno','','cust','noa,nick','txtCustno,txtComp','cust_b.aspx'],
            			 ['txtSalesno', '', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']);
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
       /*if(q_getPara('sys.comp').indexOf('永勝') > -1)
        	q_cmbParse("cmbStype", '@全部,'+q_getPara('orde.stype_uu'));
        else*/
        q_cmbParse("cmbStype", '@全部,'+q_getPara('orde.stype'));

        $('#txtBdate').focus();
        
        if(q_getPara('sys.project').toUpperCase()=="PK"){ //104/06/25 潘小姐 只要顯示外銷
        	$('.pk').hide();
        	$('#cmbStype').val('3')
        }
    }

    function q_seekStr() {   ///  搜尋按下時，執行
        t_noa = $('#txtNoa').val();
        t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_custno = $('#txtCustno').val();
        t_salesno = $('#txtSalesno').val();
        t_comp = $('#txtComp').val();
        t_stype = $('#cmbStype').val();
        t_quatno = $('#txtQuatno').val();
        t_contract = $('#txtContract').val();

        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .

        var t_where = " 1=1 "
        		+ q_sqlPara2("odate", t_bdate, t_edate) 
        		+ q_sqlPara2("noa", t_noa) + q_sqlPara2("comp", t_comp) 
        		 +q_sqlPara2("salesno", t_salesno) + q_sqlPara2("custno", t_custno)
        		 +q_sqlPara2("stype", t_stype)+ q_sqlPara2("contract", t_contract);
		if(t_quatno.length>0)
		       		t_where += " and exists(select noa from ordes"+r_accy+" where ordes"+r_accy+".noa=orde"+r_accy+".noa and ordes"+r_accy+".quatno='"+t_quatno+"')";
		       		
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
                <td   style="width:35%;" ><a id='lblDatea'> </a></td>
                <td style="width:65%;  "><input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">～</span>
                <input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr pk'>
                <td class='seek'  style="width:20%;"><a id='lblStype'> </a></td>
                <td><select id="cmbStype" class="txt c1" style="font-size:medium;"> </select></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCustno'> </a></td>
                <td><input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />&nbsp;<input class="txt" id="txtComp" type="text" style="width:115px;font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblSales'> </a></td>
                <td><input class="txt" id="txtSalesno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtSales" type="text" style="width:115px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblQuatno'> </a></td>
                <td><input class="txt" id="txtQuatno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblContract'> </a></td>
                <td><input class="txt" id="txtContract" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
