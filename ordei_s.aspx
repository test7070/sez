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
            var q_name = "ordei_s";
			
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
                q_cmbParse("cmbTrantype",q_getPara('sys.tran'));
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
        		q_mask(bbmMask);
        		$('#txtBdate').focus();
            }

            function q_seekStr() {
                t_lcno =$.trim( $('#txtLcno').val());
                t_noa =$.trim( $('#txtNoa').val());
                t_trantype =$.trim( $('#cmbTrantype').val());
                
                
            	t_bdate = $('#txtBdate').val();
        		t_edate = $('#txtEdate').val();
        		t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        		t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .

      
                var t_where = " 1=1 " + q_sqlPara2("lcno", t_lcno) + q_sqlPara2("noa", t_noa) 
                + q_sqlPara2("trantype", t_trantype)+ q_sqlPara2("datea", t_bdate,t_edate);
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
					<td><a id='lblDatea'> </a></td>
					<td>
						<input id="txtBdate" type="text" style="width:40%; float:left;" />
						<span style="width:20px; display: block; float:left;">&sim;</span>
						<input id="txtEdate" type="text" style="width:40%; float:left;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblNoa'> </a></td>
					<td style="width:70%;">
					<input class="txt" id="txtNoa" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblLcno'> </a></td>
					<td style="width:70%;">
					<input class="txt" id="txtLcno" type="text" style="width:95%; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblTrantype'> </a></td>
					<td style="width:70%;">
					<select  id="cmbTrantype" style="width:95%; font-size:medium;" > </select>
					</td>
				</tr>
				
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
