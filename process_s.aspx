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
    var q_name = "process_s";
		aPop = new Array(['txtNoa', '', 'process', 'noa,process', 'txtNoa', 'process_b.aspx'],
		['txtTggno', '', 'tgg', 'noa,comp', 'txtTggno', 'tgg_b.aspx'],
		['txtStationgno', '', 'stationg', 'noa,namea', 'txtStationgno', 'stationg_b.aspx']);
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

        $('#txtNoa').focus();
    }

    function q_seekStr() { 
    	t_noa = $('#txtNoa').val();
    	t_process = $('#txtProcess').val();
        t_tggno = $('#txtTggno').val();
        t_tgg = $('#txtTgg').val();
        t_stationgno = $('#txtStationgno').val();
        t_stationg = $('#txtStationg').val();
        var t_where = " 1=1 "  + q_sqlPara2("noa", t_noa) + q_sqlPara2("process", t_process)
        + q_sqlPara2("tggno", t_tggno)+ q_sqlPara2("tgg", t_tgg)+ q_sqlPara2("stationgno", t_stationgno)
        + q_sqlPara2("stationg", t_stationg);

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
                <td style="width:35%;" ><a id='lblNoa'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
            </tr>
            <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblProcess' class="lbl btn"></a></td>
                <td style="width:65%;  "><input class="txt" id="txtProcess" type="text" style="width:215px; font-size:medium;" />
            </tr>
            <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblTggno' class="lbl btn"></a></td>
                <td style="width:65%;  "><input class="txt" id="txtTggno" type="text" style="width:90px; font-size:medium;" />
                	<input class="txt" id="txtTgg" type="text" style="width:115px; font-size:medium;" />
            </tr>
            <tr class='seek_tr'>
                <td style="width:35%;" ><a id='lblStationg' class="lbl btn"></a></td>
                <td style="width:65%;  "><input class="txt" id="txtStationgno" type="text" style="width:90px; font-size:medium;" />
                	<input class="txt" id="txtStationg" type="text" style="width:115px; font-size:medium;" />
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
