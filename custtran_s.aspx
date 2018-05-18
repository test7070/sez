<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "custtran_s";
			aPop = new Array(
				['txtNoa', 'lblNoa', 'cust', 'noa,comp,nick', 'txtNoa', '']
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

                //q_mask(bbmMask);

                $('#txtNoa').focus();
                var paytype = q_getPara('vcc.paytype').split(',');
                var typea = "@全部,"+q_getPara('cust.typea');
                switch(q_getPara('sys.project').toUpperCase()){
                	case 'WH':
                		paytype = "月結,現金".split(',');
                		typea = "@全部,客戶,貨主,空運公司,空運貨主";
                		break;
                	case 'ES':
                		paytype = "月結,現金,回收".split(',');
                		break;
                	default:
                		break;
                }
                for(var i=0;i<paytype.length;i++){
                	if(paytype[i].length>0){
                		$('#listPaytype').append("<option value='"+paytype[i]+"'> </option>");
                	}
                }
                q_cmbParse("cmbTypea", typea);
            }

            function q_seekStr() {
                t_noa = $.trim($('#txtNoa').val());
                t_serial = $.trim($('#txtSerial').val());
                t_comp = $.trim($('#txtComp').val());
                t_nick = $.trim($('#txtNick').val());
                t_paytype = $.trim($('#txtPaytype').val());
				t_memo= $.trim($('#txtMemo').val());
				t_tel = $.trim($('#txtTel').val());
				t_typea = $.trim($('#cmbTypea').val());
				
                var t_where = " 1=1 " 
                + q_sqlPara2("noa", t_noa)
                + q_sqlPara2("serial", t_serial);
				
				if(t_comp.length>0)
					t_where += " and (charindex(N'"+t_comp+"',comp)>0 or charindex(N'"+t_comp+"',nick)>0)";
                if(t_paytype.length>0)
                	t_where += " and charindex(N'"+t_paytype+"',paytype)>0";
                if(t_memo.length>0)
                	t_where += " and charindex(N'"+t_memo+"',memo)>0";
            	if(t_tel.length>0)
					t_where += " and (charindex(N'"+t_tel+"',tel)>0 or charindex(N'"+t_tel+"',mobile)>0 or charindex(N'"+t_tel+"',fax)>0)";
                if(t_typea.length>0)
                	t_where += " and charindex(N'"+t_typea+"',typea)>0";
                	
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
					<td class='seek'  style="width:20%;"><a id='lblTypea'>類別</a></td>
					<td><select id="cmbTypea" class="txt" style="width:215px; font-size:medium;"> </select>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSerial'>統編</a></td>
					<td><input class="txt" id="txtSerial" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'> </a></td>
					<td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMemo'>備註</a></td>
					<td><input id="txtMemo" type="text" class="txt" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblPaytype'>收款方式</a></td>
					<td><input id="txtPaytype" type="text" class="txt" list="listPaytype" style="width:215px; font-size:medium;"/></td>
					<datalist id="listPaytype"> </datalist>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTel'>電話</a></td>
					<td><input id="txtTel" type="text" class="txt" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
