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
            aPop = new Array(
            	['txtProductno', '', 'ucc', 'noa,product', 'txtProductno', 'ucc_b.aspx'],
            	['txtNoa', '', 'addr', 'noa,addr', 'txtNoa', 'addr_b.aspx'],
            	['txtCustno', '', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx']            	
            );
            var q_name = "addr_s";

            $(document).ready(function() {
                main();
            });

            function main() {
                mainSeek();
                q_gf('', q_name);
                $('#txtNoa').focus();
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();

                /* bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                 q_mask(bbmMask);

                 $('#txtBdate').focus();*/
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_addr = $.trim($('#txtAddr').val());
                t_productno = $('#txtProductno').val();
				t_custno = $.trim($('#txtCustno').val());
                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("productno", t_productno) 
                					 + q_sqlPara2("noa", t_custno);
                if (t_addr.length > 0)
                    t_where += " and charindex('" + t_addr + "',addr)>0";
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
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
                    <td>
                    <input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAddr'></a></td>
					<td>
					<input class="txt" id="txtAddr" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblProductno'></a></td>
                    <td>
                    <input class="txt" id="txtProductno" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
