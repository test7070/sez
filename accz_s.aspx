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
    var q_name = "accz_s";
        aPop = new Array(
        	['txtNoa', '', 'acc', 'acc1,acc2', 'txtNoa', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
        	['txtDepl_ac', '', 'acc', 'acc1,acc2', 'txtDepl_ac,txtNamea2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
        	['txtPartno', '', 'part', 'noa,part', 'txtPartno,txtPart', "part_b.aspx"]
        );
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
        //t_noa = $('#txtNoa').val();
        t_acc1 = $('#txtAcc1').val();
        t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_depl_ac = $('#txtDepl_ac').val();
        t_namea = $('#txtNamea').val();
        t_namea2 = $('#txtNamea2').val();
        t_partno = $('#txtPartno').val();
        t_part = $('#txtPart').val();
        

        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .

        var t_where = " 1=1 " + q_sqlPara2("acc1", t_acc1)  + q_sqlPara2("indate", t_bdate, t_edate) +q_sqlPara2("depl_ac", t_depl_ac) + q_sqlPara2("partno", t_partno);
        
        if(t_namea.length>0)
        	t_where+=" and charindex('"+t_namea+"',namea)>0 ";
        if(t_namea2.length>0)
			t_where+=" and charindex('"+t_namea2+"',namea2)>0 ";
		if(t_part.length>0)
			t_where+=" and charindex('"+t_part+"',part)>0 ";
			
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
             <!--<tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>-->
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblAcc1'></a></td>
                <td><input class="txt" id="txtAcc1" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNamea'></a></td>
                <td><input class="txt" id="txtNamea" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblDepl_ac'></a></td>
                <td><input class="txt" id="txtDepl_ac" type="text" style="width:90px; font-size:medium;" />&nbsp;<input class="txt" id="txtNamea2" type="text" style="width:115px;font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblPartno'></a></td>
                <td><input class="txt" id="txtPartno" type="text" style="width:90px; font-size:medium;" />&nbsp;<input class="txt" id="txtPart" type="text" style="width:115px;font-size:medium;" /></td>
             </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
