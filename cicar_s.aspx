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
    var q_name = "cicar_s";
	aPop = new Array(
		['txtNoa', '', 'cicar', 'a.noa', 'txtNoa', 'cicar_b.aspx'],
		['txtSaleno', '', 'cisale', 'noa,namea', 'txtSaleno,txtSale', 'cisale_b.aspx'],
			['txtCustno', '', 'cicust', 'noa,cust', 'txtCustno,txtCust', 'cicust_b.aspx']);

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
		bbmMask = [['txtBhdate', r_picd], ['txtEhdate', r_picd]];
		q_mask(bbmMask);
        $('#txtNoa').focus();
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();  
		t_custno = $('#txtCustno').val();
		t_saleno = $('#txtSaleno').val();
		
        var t_where = " 1=1 " 
        + q_sqlPara2("a.noa", t_noa) 
        +q_sqlPara2("custno", t_custno)
        +q_sqlPara2("saleno", t_saleno);
        
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
					<td style="width:35%;" ><a id='lblCust'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtCust" type="text" style="width:115px; font-size:medium;" />
					</td>
			</tr>
			<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblSale'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtSaleno" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtSale" type="text" style="width:115px; font-size:medium;" />
					</td>
			</tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
