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
    var q_name = "ciinsui_s";
	aPop = new Array(['txtInsurerno', 'lblInsurer', 'ciinsucomp', 'noa,insurer', 'txtInsurerno,txtInsurer', 'ciinsucomp_b.aspx'],
	['txtCardeal', '', 'cicardeal', 'comp,cno', 'txtCardeal', 'cicardeal_b.aspx'],
	['txtSales', '', 'cisale', 'namea,noa', 'txtSales', 'cisale_b.aspx'],
	['txtCarno', 'lblCarno', 'cicar', 'a.noa', 'txtCarno', 'cicar_b.aspx']);
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
		bbmMask = [['txtBbdate', r_picd], ['txtEbdate', r_picd],['txtBedate', r_picd], ['txtEedate', r_picd]];
		q_mask(bbmMask);
        $('#txtNoa').focus();
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();  
		t_carno = $('#txtCarno').val();
		t_insurerno = $('#txtInsurerno').val();
		t_insurer = $('#txtInsurer').val();
		t_bbdate = $('#txtBbdate').val();
		t_ebdate = $('#txtEbdate').val();
		t_bedate = $('#txtBedate').val();
		t_eedate = $('#txtEedate').val();
		t_sales = $('#txtSales').val();
		t_insurancenum = $('#txtInsurancenum').val();
		t_cardno = $('#txtCardno').val();
		
        var t_where = " 1=1 " 
        + q_sqlPara2("noa", t_noa) 
        +q_sqlPara2("carno", t_carno)
        +q_sqlPara2("insurerno", t_insurerno)
        +q_sqlPara2("insurer", t_insurer)
        +q_sqlPara2("bdate", t_bbdate,t_ebdate)
        +q_sqlPara2("edate", t_bedate,t_eedate)
        +q_sqlPara2("sale", t_sales)
        +q_sqlPara2("insurancenum", t_insurancenum)
		+ q_sqlPara2("cardno", t_cardno) ;
		
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
					<td style="width:35%;" ><a id='lblBdate'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBbdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEbdate" type="text" style="width:93px; font-size:medium;" />
					</td>
			</tr>
			<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblEdate'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBedate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEedate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
                <td><input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblSales'></a></td>
                <td><input class="txt" id="txtSales" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblInsurerno'></a></td>
                <td><input class="txt" id="txtInsurerno" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblInsurer'></a></td>
                <td><input class="txt" id="txtInsurer" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblInsurancenum'></a></td>
                <td><input class="txt" id="txtInsurancenum" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCardno'></a></td>
                <td><input class="txt" id="txtCardno" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
