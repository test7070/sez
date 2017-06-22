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
    var q_name = "ciclaim_s";
	aPop = new Array(['txtInsurerno', 'lblInsurer', 'ciinsucomp', 'noa,insurer', 'txtInsurerno,txtInsurer', 'ciinsucomp_b.aspx'],
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
		bbmMask = [['txtBhdate', r_picd], ['txtEhdate', r_picd]];
		q_mask(bbmMask);
        $('#txtNoa').focus();
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();  
		t_carno = $('#txtCarno').val();
		t_driver = $('#txtDriver').val();
		t_insurerno = $('#txtInsurerno').val();
		t_insurer = $('#txtInsurer').val();
		t_bhdate = $('#txtBhdate').val();
		t_ehdate = $('#txtEhdate').val();
		
        var t_where = " 1=1 " 
        + q_sqlPara2("noa", t_noa) 
        +q_sqlPara2("carno", t_carno)
        +q_sqlPara2("driver", t_driver)
        +q_sqlPara2("insurerno", t_insurerno)
        +q_sqlPara2("insurer", t_insurer)
        +q_sqlPara2("hdate", t_bhdate,t_ehdate);

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
					<td   style="width:35%;" ><a id='lblHdate'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBhdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEhdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
                <td><input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblDriver'></a></td>
                <td><input class="txt" id="txtDriver" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblInsurerno'></a></td>
                <td><input class="txt" id="txtInsurerno" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblInsurer'></a></td>
                <td><input class="txt" id="txtInsurer" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
