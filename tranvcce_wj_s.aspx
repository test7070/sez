<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			var q_name = "tranvcce_wh_s";
			
			aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick', 'txtCustno', 'cust_b.aspx']
			    ,['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno', 'acomp_b.aspx']
			    ,['txtAddrno2', 'lblAddrno2', 'addr2_wj', 'custno,addr', 'txtAddrno2', 'addr2_b2.aspx']
				,['txtProductno', 'lblProductno', 'ucc', 'noa,product', 'txtProductno', 'ucc_b.aspx']);
				
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
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
				$('#txtNoa').focus();
				
				var t_type = q_getPara('trans.typea').split(',');
				for(var i=0;i<t_type.length;i++){
					$('#listTypea').append('<option value="'+t_type[i]+'"></option>');
				}
			}
			function q_seekStr() {
				t_bdate = $.trim($('#txtBdate').val());
				t_edate = $.trim($('#txtEdate').val());
				t_noa = $.trim($('#txtNoa').val());
				t_ordeno = $.trim($('#txtOrdeno').val());
				t_no2 = $.trim($('#txtNo2').val());
				t_typea = $.trim($('#txtTypea').val());
				t_cno = $.trim($('#txtCno').val());
                t_acomp = $.trim($('#txtAcomp').val());
				t_custno = $.trim($('#txtCustno').val());
				t_cust = $.trim($('#txtCust').val());
				t_po = $.trim($('#txtPo').val());
				t_addrno2 = $.trim($('#txtAddrno2').val());
                t_addr2 = $.trim($('#txtAddr2').val());
                t_lat = $.trim($('#txtLat').val());
				
				var t_where = " 1=1 "
					+q_sqlPara2("datea", t_bdate, t_edate)
					+q_sqlPara2("noa", t_noa)
					;
				if(t_ordeno.length>0 && t_no2.length>0){
					t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".ordeno='"+t_ordeno+"' and view_tranvcces"+r_accy+".no2='"+t_no2+"' )";
				}else if(t_ordeno.length>0){
					t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".ordeno='"+t_ordeno+"')";
				}
				if(t_typea.length>0)
					t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".typea='"+t_typea+"')";
				if(t_cno.length>0)
                    t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".cno='"+t_cno+"')";
                if(t_acomp.length>0)
                    t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".cno='"+t_acomp+"')";
				if(t_custno.length>0)
					t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".custno='"+t_custno+"')";
				if(t_cust.length>0)
					t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".cust=N'"+t_cust+"')";
                if(t_po.length>0)
                    t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".conn=N'"+t_po+"')";
                if(t_addrno2.length>0)
                    t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".addrno2 like '%"+t_addrno2+"%')";
                if(t_addr2.length>0)
                    t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".addr2 like '%"+t_addr2+"%')";
                if(t_lat.length>0)
                    t_where += " and exists(select noa from view_tranvcces"+r_accy+" where view_tranvcces"+r_accy+".noa=view_tranvcce"+r_accy+".noa and view_tranvcces"+r_accy+".lat like '%"+t_lat+"%')";
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
					<td style="width:35%;" ><a id='lblDatea'>日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>電腦編號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:220px;float:left; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr' style="display:none;">
					<td class='seek'  style="width:20%;"><a id='lblOrdeno'>訂單編號</a></td>
					<td>
						<input class="txt" id="txtOrdeno" type="text" style="width:180px;float:left; font-size:medium;" />
						<input class="txt" id="txtNo2" type="text" style="width:35px;float:left; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr' style="display:none;">
					<td class='seek'  style="width:20%;"><a id='lblTypea'>類型</a></td>
					<td><input type="text" id="txtTypea" list="listTypea" class="txt" style="width:220px;float:left; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblCno'>公司編號</a></td>
                    <td><input class="txt" id="txtCno" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblAcomp'>公司名稱</a></td>
                    <td><input class="txt" id="txtAcomp" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'>客戶編號</a></td>
					<td><input class="txt" id="txtCustno" type="text" style="width:220px;float:left; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCust'>客戶名稱</a></td>
					<td><input class="txt" id="txtCust" type="text" style="width:220px;float:left; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblAddrno2'>收貨人編號</a></td>
                    <td><input class="txt" id="txtAddrno2" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblAddr2'>收貨人</a></td>
                    <td><input class="txt" id="txtAddr2" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblLat'>收貨人郵遞區號</a></td>
                    <td><input class="txt" id="txtLat" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblPo'>運輸編號</a></td>
                    <td><input class="txt" id="txtPo" type="text" style="width:220px;float:left; font-size:medium;" /></td>
                </tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
			<datalist id="listTypea"> </datalist>
		</div>
	</body>
</html>