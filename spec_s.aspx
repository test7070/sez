<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "spec_s";
			aPop = new Array(['txtNoa', 'lblNoa', 'spec', 'noa,product', 'txtNoa', 'spec_b.aspx']);
			
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
                $('#txtNoa').focus();
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_product = $('#txtProduct').val();
                var t_where = " 1=1 " 
                	+ q_sqlPara2("noa", t_noa);
				if(t_product.length>0)
					t_where += " and charindex('"+t_product+"',product)>0";
				
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
					<td style="width:35%;" ><a id='lblNoa'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtNoa" type="text" style="width:150px; font-size:medium;" />
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblProduct'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtProduct" type="text" style="width:150px; font-size:medium;" />
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
