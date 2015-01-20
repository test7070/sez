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
    var q_name = "salvacause_s";
	var aPop = new Array(['txtSssno', '', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx'],
			 			 ['txtHtype', '', 'salhtype', 'noa,namea', 'txtHtype,txtHname', 'salhtype_b.aspx']);
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

        bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBhdate', r_picd], ['txtEhdate', r_picd]];
        q_mask(bbmMask);
        $('#txtBdate').focus();
        q_gt('sss', "where=^^noa='" + q_getId()[0] + "'^^", 0, 0,0,"");
         
    }
    var ssspartno='';
    function q_gtPost(t_name) {
                switch (t_name) {
                	case 'authority':
		                var as = _q_appendData('authority', '', true);
		                if(r_rank >=7)
		                	seekwhere = "";
		                else if (as.length > 0 && as[0]["pr_modi"] == "true")
		                    seekwhere = "and partno='"+ssspartno+"' ";
		                else
		                    seekwhere = "and sssno='" + r_userno + "' ";
		                break;
                	
                    case 'sss':
                        	var as = _q_appendData('sss', '', true);
                        	if(as[0]){
                        		ssspartno=as[0].partno;
                        		q_gt('authority', "where=^^a.noa='salvacause' and a.sssno='" + r_userno + "'^^", 0, 0,0,"");
                        	}
                        break;
                }  /// end switch
            }

    function q_seekStr() {   
        t_noa = $('#txtNoa').val();
        t_sssno = $('#txtSssno').val();
        t_namea = $('#txtNamea').val();
        t_htype = $('#txtHtype').val();
        t_hname = $('#txtHname').val();
        
        t_bdate = $('#txtBdate').val();
        t_edate = $('#txtEdate').val();
        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .
        
        t_bhdate = $('#txtBhdate').val();
        t_ehdate = $('#txtEhdate').val();
        t_bhdate = t_bhdate.length > 0 && t_bhdate.indexOf("_") > -1 ? t_bhdate.substr(0, t_bhdate.indexOf("_")) : t_bhdate;  /// 100.  .
        t_ehdate = t_ehdate.length > 0 && t_ehdate.indexOf("_") > -1 ? t_ehdate.substr(0, t_ehdate.indexOf("_")) : t_ehdate;  /// 100.  .
		

        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)+ q_sqlPara2("datea", t_bdate, t_edate)+ q_sqlPara2("sssno", t_sssno)
        + q_sqlPara2("namea", t_namea)+ q_sqlPara2("htype", t_htype)+ q_sqlPara2("hname", t_hname)
        + q_sqlPara2("bdate", t_bhdate, t_ehdate)+ q_sqlPara2("edate", t_bhdate, t_ehdate);

        t_where = ' where=^^' + t_where + seekwhere+'^^ ';
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
                <td   style="width:35%;" ><a id='lblHdate'></a></td>
                <td style="width:65%;  "><input class="txt" id="txtBhdate" type="text" style="width:90px; font-size:medium;" />
                <span style="display:inline-block; vertical-align:middle">&sim;</span>
                <input class="txt" id="txtEhdate" type="text" style="width:93px; font-size:medium;" /></td>
            </tr>
       	    <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
            	<tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblSssno'></a></td>
                <td><input class="txt" id="txtSssno" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtNamea" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
            	<tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblHtype'></a></td>
                <td><input class="txt" id="txtHtype" type="text" style="width:90px; font-size:medium;" />&nbsp;
                	<input class="txt" id="txtHname" type="text" style="width:115px; font-size:medium;" /></td>
            </tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
