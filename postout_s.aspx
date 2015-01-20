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
    var q_name = "postout_s";
		aPop = new Array(['txtPartno', '', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
		['txtSssno', '', 'sssall', 'noa,namea,partno,part', 'txtSssno,txtNamea', 'sssall_b.aspx'],
		['txtSenderno', '', 'acomp', 'noa,nick','txtSenderno,txtSender', 'acomp_b.aspx']);
 
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
        q_cmbParse("cmbChecker", ('').concat(new Array( '全部','未核准','已核准')));
    }

    function q_seekStr() {   
    	t_noa = $('#txtNoa').val();
        t_partno = $('#txtPartno').val();
        t_part = $('#txtPart').val();
        t_sssno = $('#txtSssno').val();
        t_namea = $('#txtNamea').val();
        t_senderno = $('#txtSenderno').val();
        t_sender = $('#txtSender').val();
		t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("datea", t_bdate, t_edate) + q_sqlPara2("partno", t_partno)  + q_sqlPara2("part", t_part)
        + q_sqlPara2("sssno", t_sssno)  + q_sqlPara2("namea", t_namea)+ q_sqlPara2("senderno", t_senderno)  + q_sqlPara2("sender", t_sender);
		
		if($('#cmbChecker').val()=='未核准')
			t_where+=" and checker='' "
		if($('#cmbChecker').val()=='已核准')
			t_where+=" and checker!='' "
		
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
                <td   style="width:35%;" ><a id='lblDatea'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td   style="width:35%;" ><a id='lblNoa'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtNoa" type="text" style="width:150px; font-size:medium;" />
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblPartno'></a></td>
                <td><input class="txt" id="txtPartno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtPart" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblSssno'></a></td>
                <td><input class="txt" id="txtSssno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtNamea" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblSenderno'></a></td>
                <td><input class="txt" id="txtSenderno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtSender" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblChecker'></a></td>
                <td><select id="cmbChecker" class="txt c1"> </select></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
