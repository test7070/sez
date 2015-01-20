<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    var q_name = "labpay_s";
	 aPop = new Array(['txtProductno','lblProduct','ucc','noa,product,vccacc1,vccacc2','txtProductno,txtProduct,txtAcc1,txtAcc2','ucc_b.aspx'],
        ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy+ '_' + r_cno]
        ,['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno', 'sss_b.aspx']);
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
        t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_productno = $('#txtProductno').val();
        t_product = $('#txtProduct').val();
        t_noa = $('#txtNoa').val();
        t_acc1 = $('#txtAcc1').val();
        t_acc2 = $('#txtAcc2').val();
        t_salesno = $('#txtSalesno').val();
        t_accno = $('#txtAccno').val();
         
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .

        var t_where = " 1=1 "  + q_sqlPara2("noa", t_bdate,t_edate)+ q_sqlPara2("noa", t_noa)+ q_sqlPara2("salesno", t_salesno)
        + q_sqlPara2("productno", t_productno)+ q_sqlPara2("product", t_product)+ q_sqlPara2("acc1", t_acc1)+ q_sqlPara2("acc2", t_acc2)+ q_sqlPara2("accno", t_accno);
        

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
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
              <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblNoa'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblSalesno'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtSalesno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
              <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblProductno'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtProductno" type="text" style="width:90px; font-size:medium;" />
                	<input class="txt" id="txtProduct" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
              <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblAcc1'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtAcc1" type="text" style="width:90px; font-size:medium;" />
                	<input class="txt" id="txtAcc2" type="text" style="width:115px; font-size:medium;" />
                </td>
            </tr>
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblAccno'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
