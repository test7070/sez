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
            var q_name = "uccdc_s";
			aPop = new Array(['txtNoa', '', 'ucc', 'noa,product', 'txtNoa,txtItem', "ucc_b.aspx"],
			  ['txtVacc1', 'lblVacc1', 'acc', 'acc1,acc2', 'txtVacc1', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
			, ['txtRacc1', 'lblRacc1', 'acc', 'acc1,acc2', 'txtRacc1', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
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
				
				$('#txtVacc1').change(function() {
					var str=$.trim($(this).val());
                	if((/^[0-9]{4}$/g).test(str))
                		$(this).val(str+'.');
				});
				$('#txtRacc1').change(function() {
					var str=$.trim($(this).val());
                	if((/^[0-9]{4}$/g).test(str))
                		$(this).val(str+'.');
				});
				
                $('#txtBdate').focus();
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_item = $('#txtItem').val();
                t_vacc1 = $('#txtVacc1').val();
                t_racc1 = $('#txtRacc1').val();

                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)  + q_sqlPara2("vccacc1", t_vacc1) + q_sqlPara2("rc2acc1", t_racc1);
				if (t_item.length > 0)
                    t_where += " and patindex('%" + t_item + "%',product)>0";
                    
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background: #76a2fe;
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:150px;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:150px;"><a id='lblItem'></a></td>
					<td>
					<input class="txt" id="txtItem" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:150px;"><a id='lblVacc1'></a></td>
					<td><input class="txt" id="txtVacc1" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:150px;"><a id='lblRacc1'></a></td>
					<td><input class="txt" id="txtRacc1" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
