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

    var q_name = "workm_s";
	
    $(document).ready(function () {
        main();
    });         /// end ready
	aPop = new Array(['txtProductno', 'lblProduct', 'ucaall', 'noa,product', 'txtProductno,txtProduct', 'ucaall_b.aspx']
            ,['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx']
            ,['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx']
            ,['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);
    function main() {
        mainSeek();
        q_gf('', q_name);
    }

    function q_gfPost() {
        q_getFormat();
        q_langShow();

        bbmMask = [];
        q_mask(bbmMask);

        $('#txtNoa').focus();
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_productno = $('#txtProductno').val();
        t_product = $('#txtProduct').val();
        t_processno = $('#txtProcessno').val();
        t_process = $('#txtProcess').val();
        t_stationno = $('#txtStationno').val();
        t_station = $('#txtStation').val();
        t_tggno = $('#txtTggno').val();
        t_tgg = $('#txtTgg').val();
        t_workno = $('#txtWorkno').val();

        
        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)+ q_sqlPara2("productno", t_productno)+ q_sqlPara2("product", t_product)
        + q_sqlPara2("processno", t_processno)+ q_sqlPara2("process", t_process)
        + q_sqlPara2("stationno", t_stationno)+ q_sqlPara2("station", t_station)+ q_sqlPara2("tggno", t_tggno)+ q_sqlPara2("tgg", t_tgg);
        
        if(t_workno.length>0)
        	t_where=t_where+" and (workno='"+t_workno+"' or noa in (select noa from workms"+r_accy+" where workno='"+t_workno+"'))"

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
                <td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblProductno'> </a></td>
                <td>
                	<input class="txt" id="txtProductno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtProduct" type="text" style="width:115px; font-size:medium;" />
                </td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblProcessno'> </a></td>
                <td>
                	<input class="txt" id="txtProcessno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtProcess" type="text" style="width:115px; font-size:medium;" />
                </td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblStationno'> </a></td>
                <td>
                	<input class="txt" id="txtStationno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtStation" type="text" style="width:115px; font-size:medium;" />
                </td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblTggno'> </a></td>
                <td>
                	<input class="txt" id="txtTggno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtTgg" type="text" style="width:115px; font-size:medium;" />
                </td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblWorkno'> </a></td>
                <td><input class="txt" id="txtWorkno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
