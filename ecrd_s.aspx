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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "ecrd_s";
            aPop = new Array(['txtCustno', '', 'cust', 'noa,nick', 'txtCustno,txtCust', 'cust_b.aspx']);
            
            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
				$('#txtNoa').focus();
                
                $('#txtCust').attr('readonly', true).css('background-color', 'rgb(237,237,238)').css('color', 'green');
            }
            
			function q_gtPost(t_name) {
				switch (t_name) {
                	
                }  /// end switch
            }

            function q_seekStr() {///  搜尋按下時，執行
                t_bdate = $.trim($('#txtBdate').val());
                t_edate = $.trim($('#txtEdate').val());
               // t_noa = $.trim($('#txtNoa').val());
                t_custno = $.trim($('#txtCustno').val());

                var t_where = " 1=1 " 
            	//+ q_sqlPara2("noa", t_noa) 
            	+ q_sqlPara2("datea", t_bdate, t_edate) 
            	+ q_sqlPara2("custno", t_custno);

                t_where = ' where=^^' + t_where+ '^^ ';
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
            input[type="text"], input[type="button"],select {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<!--<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblNoa'> </a></td>
					<td style="width:65%;"><input class="txt" id="txtNoa" type="text" style="width:220px; font-size:medium;" /></td>
				</tr>-->
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:95px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:95px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCust'> </a></td>
					<td>
						<input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />
						<input class="txt" id="txtCust" type="text" style="width:115px;font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
