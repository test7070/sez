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
    var q_name = "adtran_s";
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
        q_gt('add2','', 0, 0, 0, "");
		q_cmbParse("cmbStyle",('全部'+',').concat(q_getPara('adsss.stype').split(',')));
		q_cmbParse("cmbTrantype", ('全部'+',').concat(new Array('送達','自取','貨運','FOB','FOR','CIF','C&F','TO DOOR' )));
        bbmMask = [['txtMon', r_picm]];
        q_mask(bbmMask);

        $('#txtMon').focus();
    }
    function q_gtPost(t_name) {
                switch (t_name) {
                case 'add2':
                        var as = _q_appendData("add2", "", true);
                        var t_item = "@全部";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item +(t_item.length > 0 ? ',' : '') + as[i].post;
                        }
                        q_cmbParse("cmbPost", t_item);
                        break;
                }
           }


    function q_seekStr() {   
        t_mon = $('#txtMon').val();
        t_noa = $('#txtNoa').val();
        t_style = $('#cmbStyle').val();
        t_post = $('#cmbPost').val();
        t_trantype = $('#cmbTrantype').val();
        
       /* t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .*/

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("mon", t_mon);
        if(t_style != '全部')
                t_where+= q_sqlPara2("style", t_style);
        if(t_post != '全部')
        t_where+= q_sqlPara2("post", t_post);
        if(t_trantype != '全部')
        t_where+= q_sqlPara2("trantype", t_trantype);

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
                <td class='seek'  style="width:20%;"><a id='lblMon'> </a></td>
                <td><input class="txt" id="txtMon" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblStyle'> </a></td>
                <td><select id="cmbStyle" style="width:215px; font-size:medium;"> </select></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblPost'> </a></td>
                <td><select id="cmbPost" style="width:215px; font-size:medium;"> </select></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblTrantype'> </a></td>
                <td><select id="cmbTrantype" style="width:215px; font-size:medium;"> </select></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
