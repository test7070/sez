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
    var q_name = "carc_s";
    aPop = new Array(
		['txtCarownerno', 'lblCarowner', 'carowner', 'noa,namea', 'txtCarownerno,txtCarowner', 'carowner_b.aspx'],
		['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
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
        bbmMask = [['txtBmon', r_picm], ['txtEmon', r_picm],['txtBdate', r_picd], ['txtEdate', r_picd],['txtBadate', r_picd], ['txtEadate', r_picd]];
        q_mask(bbmMask);
        $('#txtBmon').focus();
    }

    function q_seekStr() {   ///  搜尋按下時，執行
        t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_bmon = $('#txtBmon').val();
        t_emon = $('#txtEmon').val();
        t_Noa = $('#txtNoa').val();
        t_Accno = $('#txtAccno').val();
        t_tggno = $('#txtTggno').val();
        t_comp = $('#txtComp').val();
        t_badate = $('#txtBadate').val();
        t_eadate = $('#txtEadate').val();
        
        

        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .
        t_badate = t_badate.length > 0 && t_badate.indexOf("_") > -1 ? t_badate.substr(0, t_badate.indexOf("_")) : t_badate;  /// 100.  .
        t_eadate = t_eadate.length > 0 && t_eadate.indexOf("_") > -1 ? t_eadate.substr(0, t_eadate.indexOf("_")) : t_eadate;  /// 100.  .
        t_bmon = t_bmon.length > 0 && t_bmon.indexOf("_") > -1 ? t_bmon.substr(0, t_bmon.indexOf("_")) : t_bmon;  /// 100.  .
        t_emon = t_emon.length > 0 && t_emon.indexOf("_") > -1 ? t_emon.substr(0, t_emon.indexOf("_")) : t_emon;  /// 100.  .
        var t_where = " 1=1 " + q_sqlPara2("datea", t_bdate, t_edate)+
        			q_sqlPara2("mon", t_bmon, t_emon) + q_sqlPara2("noa", t_Noa) + 
        			q_sqlPara2("accno", t_Accno)+ q_sqlPara2("acdate", t_badate, t_eadate)+ q_sqlPara2("tggno", t_tggno)+ q_sqlPara2("comp", t_comp);
       
       if(!emp($('#txtCarno').val()))
       		t_where+="and noa in (select noa from carcs where carno='"+$('#txtCarno').val()+"')";
       if(!emp($('#txtCarownerno').val()))
       		t_where+="and noa in (select noa from carcs where carownerno='"+$('#txtCarownerno').val()+"')";
       if(!emp($('#txtCarowner').val()))
       		t_where+="and noa in (select noa from carcs where carowner='"+$('#txtCarowner').val()+"')";

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
                <td style="width:35%;" ><a id='lblMon'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBmon" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEmon" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblDatea'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblNoa'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtNoa" type="text" style="font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblAccno'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtAccno" type="text" style="font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
                <td><input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCarowner'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtCarownerno" type="text" style="width:90px; font-size:medium;" />
                <input class="txt" id="txtCarowner" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblTggno'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtTggno" type="text" style="width:90px; font-size:medium;" />
                <input class="txt" id="txtComp" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblAcdate'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBadate" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEadate" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
