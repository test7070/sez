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
    var q_name = "ucctgg_s";
	var aPop = new Array(['txtProductno', '', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],['txtTggno', '', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);
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

        bbmMask = [];
        q_mask(bbmMask);
    }
    
    function q_gtPost(t_name) {  
            switch (t_name) {
            }  /// end switch
        }

    function q_seekStr() {   
       	t_productno = $('#txtProductno').val();
        t_product = $('#txtProduct').val();
       
        t_tggno = $('#txtTggno').val();
        t_tgg = $('#txtTgg').val();

        var t_where = " 1=1 " + q_sqlPara2("productno", t_productno)  + q_sqlPara2("product", t_product)
        + q_sqlPara2("tggno", t_tggno)  + q_sqlPara2("tgg", t_tgg);

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
                <td class='seek'  style="width:20%;"><a id='lblProduct'> </a></td>
                <td><input class="txt" id="txtProductno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtProduct" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblTgg'> </a></td>
                <td><input class="txt" id="txtTggno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtTgg" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
