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
            var q_name = "lab_accc_s";
            aPop = new Array(['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno', 'sss_b.aspx']
            , ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
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
                bbmMask = [['txtMon', r_picm]];
                q_mask(bbmMask);
                
                q_cmbParse("cmbTypea", '@全部,'+q_getPara('lab_accc.typea'));
            }

            function q_seekStr() {
            	var t_where='';
            	try{
	            	t_typea = $.trim($('#cmbTypea').val());
	                t_salesno = $.trim($('#txtSalesno').val());
	                t_sales = $.trim($('#txtSales').val());
	                t_mon = $.trim($('#txtMon').val());
	                t_acc1 = $.trim($('#txtAcc1').val());
	                t_acc2 = $.trim($('#txtAcc2').val());
	                
	                t_where = " 1=1 " 
	                + q_sqlPara2("typea", t_typea)
	                + q_sqlPara2("mon", t_mon)
	                + q_sqlPara2("salesno", t_salesno)
	                + q_sqlPara2("acc1", t_acc1);
					if (t_sales.length > 0)
	                    t_where += " and patindex('%" + t_sales + "%',sales)>0";
	                if (t_acc2.length > 0)
	                    t_where += " and patindex('%" + t_acc2 + "%',acc2)>0";
	                t_where = ' where=^^' + t_where + '^^ ';
				}catch(e){
					alert(e.message);
				}
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblMon'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtMon" type="text" style="width:215px; font-size:medium;" />
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblSalesno'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtSalesno" type="text" style="width:215px; font-size:medium;" />
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblSales'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtSales" type="text" style="width:215px; font-size:medium;" />
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblAcc1'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtAcc1" type="text" style="width:215px; font-size:medium;" />
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblAcc2'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtAcc2" type="text" style="width:215px; font-size:medium;" />
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
