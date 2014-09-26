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
			var q_name = "accc_s";
			$(document).ready(function() {
				main();
			});
			/// end ready
			function main() {
				mainSeek();
				q_gf('', q_name);
			}
			aPop = [['txtPart', 'lblPart', 'acpart', 'noa,part', 'txtPart', "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]];
			function q_gfPost() {
				q_getFormat();
				q_langShow();
				bbmMask = [['txtBdate', '99/99'], ['txtEdate', '99/99']];
				q_mask(bbmMask);
				$('#txtBdate').focus();
				q_cmbParse("cmbAccc1", q_getPara('acc.typea'));
			}
			function q_seekStr() {
				t_accc1 = $('#cmbAccc1').val();
				t_baccc3 = $('#txtBaccc3').val();
				t_eaccc3 = $('#txtEaccc3').val();
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_part = $('#txtPart').val();
				var t_where = " 1=1 " + q_sqlPara2("accc3", t_baccc3, t_eaccc3) + q_sqlPara2("accc2", t_bdate, t_edate)+ q_sqlPara2("accc1", t_accc1);
				if(t_part.length>0)
                    t_where += " and exists(select accc3 from acccs"+r_accy+"_"+r_cno+" where acccs"+r_accy+"_"+r_cno+".accc3=accc"+r_accy+"_"+r_cno+".accc3 and acccs"+r_accy+"_"+r_cno+".part='"+t_part+"')";
				
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
        </script>
        <style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
        </style>
    </head>
    <body>
        <div style='width:400px; text-align:center;padding:15px;' >
            <table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
                <tr class='seek_tr'>
                    <td   style="width:35%;" ><a id='lblDatea'> </a></td>
                    <td style="width:65%;  ">
                    <input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
                    <span style="display:inline-block; vertical-align:middle">&sim;</span>
                    <input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
                    <td style="width:65%;  ">
                    <input class="txt" id="txtBaccc3" type="text" style="width:90px; font-size:medium;" />
                    <span style="display:inline-block; vertical-align:middle">&sim;</span>
                    <input class="txt" id="txtEaccc3" type="text" style="width:93px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblPart'> </a></td>
                    <td>
                    <input class="txt" id="txtPart" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblAccc1'> </a></td>
                    <td>
                    <select id="cmbAccc1" style='width:88%;font-size: medium;'> </select>
                    </td>
                </tr>
            </table>
            <!--#include file="../inc/seek_ctrl.inc"-->
        </div>
    </body>
</html>
