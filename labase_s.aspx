<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    var q_name = "labase_s";
    var aPop = new Array(['txtNoa', '', 'sssall', 'noa,namea', 'txtNoa,txtNamea', 'sssall_b.aspx'],
    					 ['txtCustno', '', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
    					 ['txtCno', '', 'acomp', 'noa,acomp', 'txtCno,', 'acomp_b.aspx']);
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
         q_cmbParse("cmbStatus", ('').concat(new Array( '','退保','未退保')));
    }

    function q_seekStr() {   
    	t_noa = $('#txtNoa').val();
    	t_namea = $('#txtNamea').val();
    	t_custno = $('#txtCustno').val();
    	t_comp = $('#txtComp').val();
    	t_cno = $('#txtCno').val();
    	t_status = $('#cmbStatus').val();
        //t_bdate = $('#txtBdate').val();
        //t_edate = $('#txtEdate').val(); 
        //t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        //t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("namea", t_namea) + q_sqlPara2("custno", t_custno)+ q_sqlPara2("comp", t_comp);
        if(!emp(t_cno))
        	t_where+=" and noa in(select noa from labased where noa+noq in(select noa+MAX(noq) from labased group by noa)and cno='"+t_cno+"')";
        if(t_status=='未退保')
        	t_where+=" and noa in(select noa from labased where noa+noq in(select noa+MAX(noq) from labased group by noa)and len(health_edate)=0)";
        if(t_status=='退保')
        	t_where+=" and noa in(select noa from labased where noa+noq in(select noa+MAX(noq) from labased group by noa)and len(health_edate)>0)";
		
		t_where+=" and (1=1 ";
		if($('#chkIssssp')[0].checked==true)
			t_where+=" and issssp='1'";
        if($('#chkIsforeign')[0].checked==true)
			t_where+=" and isforeign='1'";
		t_where+=")"
		
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
                <td class='seek'  style="width:20%;"><a id='lblNamea'> </a></td>
                <td><input class="txt" id="txtNamea" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCustno'> </a></td>
                <td><input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
                </td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblComp'> </a></td>
                <td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" />
                </td>
            </tr>
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblCno'> </a></td>
                <td><input class="txt" id="txtCno" type="text" style="width:215px; font-size:medium;" />
                </td>
            </tr>
            <tr class='seek_tr'>
	            <td class='seek'  style="width:20%;"><a id='lblStatus'> </a></td>
	            <td><select id="cmbStatus" class="txt c1"> </select></td>
			</tr>
			<tr class='seek_tr'>
	            <td colspan="2">
	            	<input id="chkIssssp" type="checkbox" /><span> </span><a id="lblIssssp"> </a>
	            	<input id="chkIsforeign" type="checkbox"/><span> </span><a id="lblIsforeign"> </a>
	            </td>
			</tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
