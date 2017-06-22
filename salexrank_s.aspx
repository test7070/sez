<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
<script type="text/javascript">
    var q_name = "salexrank_s";

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

      /*  bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
        q_mask(bbmMask);
        $('#txtBdate').focus();*/
         
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_class = $('#txtClass').val();
        
        /*t_point1 = $('#txtPoint1').val();
        t_point2 = $('#txtPoint2').val();*/
		
		/*t_point1 = t_point1.length > 0 && t_point1.indexOf("_") > -1 ? t_point1.substr(0, t_point1.indexOf("_")) : t_point1;  /// 100.  .
        t_point2 = t_point2.length > 0 && t_point2.indexOf("_") > -1 ? t_point2.substr(0, t_point2.indexOf("_")) : t_point2;  /// 100.  .*/
       
        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)+ q_sqlPara2("class", t_class);
        

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
                <td class='seek'  style="width:20%;"><a id='lblClass'></a></td>
                <td><input class="txt" id="txtClass" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
