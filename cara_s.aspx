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
    var q_name = "cara_s";
	aPop = new Array(
		['txtCarownerno', 'lblCarowner', 'carowner', 'noa,namea', 'txtCarownerno,txtCarowner', 'carowner_b.aspx'],
		['txtCarno', 'lblCarno', 'car2', 'a.noa,carownerno,carowner', 'txtCarno', 'car2_b.aspx']);
	
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

       bbmMask = [['txtBmon', r_picm], ['txtEmon', r_picm]];
        q_mask(bbmMask);
		$('#txtEmon').val(q_date().substr(0,6))
        $('#txtCarno').focus();
    }

    function q_seekStr() {   
        var t_noa = $('#txtNoa').val();
        var t_accno = $('#txtAccno').val();
        var t_bmon = $('#txtBmon').val();
        var t_emon = $('#txtEmon').val();
        var t_carno = $('#txtCarno').val();
        var t_carownerno = $('#txtCarownerno').val();
        var t_carowner = $('#txtCarowner').val();
        t_bmon = t_bmon.length > 0 && t_bmon.indexOf("_") > -1 ? t_bmon.substr(0, t_bmon.indexOf("_")) : t_bmon;  /// 100.  .
        t_emon = t_emon.length > 0 && t_emon.indexOf("_") > -1 ? t_emon.substr(0, t_emon.indexOf("_")) : t_emon;  /// 100.  .

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)+ q_sqlPara2("accno", t_accno)+q_sqlPara2("carownerno", t_carownerno) +q_sqlPara2("carowner", t_carowner)+ q_sqlPara2("mon", t_bmon, t_emon);
		if(!emp(t_carno))
				t_where+= " and (carno='"+t_carno+"' or CHARINDEX('"+t_carno+"',STUFF(REPLACE((select ','+b.oldcarno from carChange b where cara.carno=b.noa FOR XML PATH('')),' ',''),1,1,''))>0) ";
				
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
                <td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
                <td><input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
              <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblMon'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBmon" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEmon" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCarowner'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtCarownerno" type="text" style="width:90px; font-size:medium;" />
                <input class="txt" id="txtCarowner" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblAccno'></a></td>
                <td><input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
