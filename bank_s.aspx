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
            var q_name = "bank_s";
			aPop = new Array(['txtNoa', 'lblNoa', 'bank', 'noa,bank', 'txtNoa,txtBank', 'bank_b.aspx']);
            $(document).ready(function() {
                main();
            });

            function main() {
                mainSeek();
                q_gf('', q_name);
                $('#txtAcc1').change(function(e) {
					var patt = /(\d{4})([^\.,.]*)$/g;
					$(this).val($(this).val().replace(patt,"$1.$2"));
        		});
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
            }

            function q_seekStr() {
                t_noa =$.trim( $('#txtNoa').val());
                t_bank = $.trim($('#txtBank').val());
                t_conn = $.trim($('#txtConn').val());
                t_account = $.trim($('#txtAccount').val());
                t_acc1 = $.trim($('#txtAcc1').val());
       
                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)+ q_sqlPara2("acc1", t_acc1);
				if (t_bank.length > 0)
                	t_where += " and patindex('%" + t_bank + "%',bank)>0";
                if (t_conn.length > 0)
                	t_where += " and patindex('%" + t_conn + "%',conn)>0";
                if (t_account.length > 0)
                	t_where += " and patindex('%" + t_account + "%',account)>0";
                		    
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style="width:95%; text-align:center;padding:15px;">
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td style="width:75%;">
					<input class="txt" id="txtNoa" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblBank'> </a></td>
					<td style="width:75%;">
					<input class="txt" id="txtBank" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblConn'> </a></td>
					<td style="width:75%;">
					<input class="txt" id="txtConn" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAccount'> </a></td>
					<td style="width:75%;">
					<input class="txt" id="txtAccount" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAcc1'> </a></td>
					<td style="width:75%;">
					<input class="txt" id="txtAcc1" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
