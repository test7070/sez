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
            var q_name = "bankf_s";
			aPop = new Array(['txtLcno', 'lblLcno', 'bankf', 'lcno', 'txtLcno', 'bankf_b.aspx'],['txtCno', '', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);
			
            $(document).ready(function() {
                main();
            });

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
                
            }

            function q_seekStr() {
                t_lcno =$.trim( $('#txtLcno').val());
                t_cno =$.trim( $('#txtCno').val());
                t_acomp =$.trim( $('#txtAcomp').val());
                t_bmoney =$.trim( $('#txtBmoney').val());
                t_emoney =$.trim( $('#txtEmoney').val());
                
      
                var t_where = " 1=1 " + q_sqlPara2("lcno", t_lcno) + q_sqlPara2("cno", t_cno) 
                + q_sqlPara2("acomp", t_acomp)+ q_sqlPara2("money", t_bmoney,t_emoney);
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
		<div style="width:400px; text-align:center;padding:15px;">
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblLcno'> </a></td>
					<td style="width:70%;">
					<input class="txt" id="txtLcno" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblCno'> </a></td>
					<td style="width:70%;">
					<input class="txt" id="txtCno" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblAcomp'> </a></td>
					<td style="width:70%;">
					<input class="txt" id="txtAcomp" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td><a id='lblMoneys'> </a></td>
					<td>
						<input id="txtBmoney" type="text" style="width:40%; float:left;" />
						<span style="width:20px; display: block; float:left;">~</span>
						<input id="txtEmoney" type="text" style="width:40%; float:left;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
