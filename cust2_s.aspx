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
			var q_name = "cust2_s";
			aPop = new Array(['txtNoa', 'lblNoa', 'cust', 'noa,nick', 'txtNoa', 'cust_b.aspx']
			,['txtSerial', 'lblSerial', 'cust', 'serial,noa,nick', 'txtSerial', 'cust_b.aspx']
			);
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
				t_noa = $.trim($('#txtNoa').val());
				t_serial = $.trim($('#txtSerial').val());
				t_memo = $.trim($('#txtMemo').val());
				
				var t_where = " 1=1 " 
					+ q_sqlPara2("noa", t_noa) 
					+ q_sqlPara2("serial", t_serial);
				if (t_memo.length > 0){
					t_where += " and (charindex('" + t_memo+ "',comp)>0" 
						+" or charindex('" + t_memo + "',nick)>0"
						+" or charindex('" + t_memo + "',tel)>0"
						+" or charindex('" + t_memo + "',fax)>0"
						+" or charindex('" + t_memo + "',addr_fact)>0"
						+" or charindex('" + t_memo + "',addr_comp)>0"
						+" or charindex('" + t_memo + "',addr_invo)>0"
						+" or charindex('" + t_memo + "',addr_home)>0"
						+" or charindex('" + t_memo + "',sales)>0"
						+" or charindex('" + t_memo + "',memo)>0"
						+")";
				}
                    
                    
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
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>客戶編號</a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSerial'>統一編號</a></td>
					<td>
					<input class="txt" id="txtSerial" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMemo'>備註</a></td>
					<td>
					<input class="txt" id="txtMemo" type="text" style="width:215px; font-size:medium;" title="備註、電話、地址..."/>
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
