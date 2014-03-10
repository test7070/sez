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
    var q_name = "ummb_s";
    var aPop = new Array(['txtCno', '', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
     ,['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']);
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
		q_cmbParse("cmbTypea", '全部@全部,'+q_getPara('ummb.typea')); 
		
        bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
        q_mask(bbmMask);
        $('#txtBdate').focus();
         
    }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_cno = $('#txtCno').val();
        t_acomp = $('#txtAcomp').val();
        t_custno = $('#txtCustno').val();
        t_comp = $('#txtComp').val();
        t_worker = $('#txtWorker').val();
        t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_vccno = $('#txtVccno').val();
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .
		

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("cno", t_cno)+ q_sqlPara2("acomp", t_acomp)
         + q_sqlPara2("custno", t_custno)+ q_sqlPara2("comp", t_comp)
        + q_sqlPara2("worker", t_worker)+ q_sqlPara2("datea", t_bdate, t_edate);
        
        if(t_vccno.length>0){
        	t_where=t_where+" and (noa in (select noa from ummbs where vccno='"+t_vccno+"') or vccno='"+t_vccno+"')";
        }
        
        if($('#cmbTypea').val()!='全部'){
        	t_where=t_where+" and typea='"+$('#cmbTypea').val()+"'";
        }
        
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
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTypea'> </a></td>
					<td>	<select id="cmbTypea" class="txt c1"> </select></td>
			</tr>
			<tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
                <td><input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtComp" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCno'></a></td>
                <td><input class="txt" id="txtCno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtAcomp" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblVccno'></a></td>
                <td><input class="txt" id="txtVccno" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblWorker'></a></td>
                <td><input class="txt" id="txtWorker" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
