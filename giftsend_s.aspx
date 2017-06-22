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
			var q_name = "giftsend_s";
			var aPop = new Array(
				['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], 
				['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], 
				['txtGiftno', 'lblGiftno', 'gift', 'noa,product', 'txtGiftno,txtGift', 'gift_b.aspx'],
				['txtCustno', 'lblCustno', 'giftcust', 'noa,namea', 'txtCustno,txtNamea', 'giftcust_b.aspx']
				);

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
				q_gt('giftsendt', '', 0, 0, 0, "", r_accy);
				q_gt('acomp', '', 0, 0, 0, "");
				$('#txtBdate').focus();
			}
			function q_gtPost(t_name) {
                switch (t_name) {
                case 'giftsendt':
                        var as = _q_appendData("giftsendt", "", true);
                        var t_item = "@";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
                        }
                        q_cmbParse("cmbSendmemo", t_item);
                        break;
				case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        var t_stype = "@";
                        for ( i = 0; i < as.length; i++) {
                            t_stype = t_stype + (t_stype.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_cmbParse("cmbCno", t_stype);
                        break;
				}
           }

			function q_seekStr() {
				t_noa = $.trim($('#txtNoa').val());
				t_bdate = $.trim($('#txtBdate').val());
				t_edate = $.trim($('#txtEdate').val());
				t_sendmemo = $('#cmbSendmemo').val();
				t_cno = $.trim($('#cmbCno').val());
				//t_acomp = $.trim($('#txtAcomp').val());
				t_salesno = $.trim($('#txtSalesno').val());
				t_sales = $.trim($('#txtSales').val());
				t_giftno = $.trim($('#txtGiftno').val());
				t_gift = $.trim($('#txtGift').val());
				t_custno = $.trim($('#txtCustno').val());
				t_cust = $.trim($('#txtNamea').val());
				
		        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
       			t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .

				var t_where = " 1=1 "
					+q_sqlPara2("noa", t_noa)
					+q_sqlPara2("case when len(senddate)<9 then senddate+'01' else senddate end", t_bdate, t_edate)
					+q_sqlPara2("sendmemo", t_sendmemo)
					+q_sqlPara2("cno", t_cno)
					//+q_sqlPara2("acomp", t_acomp)
					+q_sqlPara2("salesno", t_salesno)
					+q_sqlPara2("sales", t_sales)
					+q_sqlPara2("giftno", t_giftno)
					+q_sqlPara2("gift", t_gift);
				
				if(!emp(t_custno))
					t_where+=" and noa in (select noa from giftsends where custno='"+t_custno+"') "
				if(!emp(t_cust))
					t_where+=" and noa in (select noa from giftsends where namea='"+t_cust+"') "
				
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
					<td style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSendmemo'></a></td>
					<td><select class="txt" id="cmbSendmemo" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCno'></a></td>
					<td>
						<select id="cmbCno" class="txt c1"> </select>
					<!--<input class="txt" id="txtCno" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtAcomp" type="text" style="width:115px; font-size:medium;" />-->
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSalesno'></a></td>
					<td>
					<input class="txt" id="txtSalesno" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtSales" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGiftno'></a></td>
					<td>
					<input class="txt" id="txtGiftno" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtGift" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCust'></a></td>
					<td>
					<input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtNamea" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
