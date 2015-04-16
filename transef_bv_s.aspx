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
            var q_name = "transef_s";
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx'], ['txtProductno', 'lblProduct', 'ucc', 'noa,product', 'txtProductno', 'ucc_b.aspx'], ['txtAddrno', 'lblAddr', 'addr', 'noa,addr', 'txtAddrno', 'addr_b.aspx']);
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
				q_cmbParse("cmbDeliveryno", ",1,2,3");
				q_cmbParse("cmbContainertype", ",手寫託運單,edi託運單");
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                $('#txtBdate').focus();
                $("#lblDatea").text('發送日期');
                $("#lblTrandate").text('配送日期');
                $("#lblDeliveryno").text('速配袋號');
                $("#lblContainertype").text('託運單形式');
                $("#lblNoa").text('單據編號');
                $("#lblCustno").text('公司編號');
                $("#lblComp").text('公司名稱');
                $("#lblBoatname").text('97條碼');
                $("#lblPo").text('96條碼');
                $("#lblSo").text('來源表單編號');
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_btdate = $('#txtBtdate').val();
                t_etdate = $('#txtEtdate').val();
                t_custno = $('#txtCustno').val();
                t_comp = $('#txtComp').val();
				t_deliveryno = $.trim($('#cmbDeliveryno').val());
				t_containertype = $.trim($('#cmbContainertype').val());
                t_boatname = $('#txtBoatname').val();
                t_po = $('#txtPo').val();
                t_so = $('#txtSo').val();
              
                t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
                t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;
                t_btdate = t_btdate.length > 0 && t_btdate.indexOf("_") > -1 ? t_btdate.substr(0, t_btdate.indexOf("_")) : t_btdate;
                t_etdate = t_etdate.length > 0 && t_etdate.indexOf("_") > -1 ? t_etdate.substr(0, t_etdate.indexOf("_")) : t_etdate;

                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("datea", t_bdate, t_edate) 
                 + q_sqlPara2("trandate", t_btdate, t_etdate) + q_sqlPara2("so", t_so)
                + q_sqlPara2("custno", t_custno) + q_sqlPara2("deliveryno", t_deliveryno) 
                + q_sqlPara2("containertype", t_containertype) + q_sqlPara2("boatname", t_boatname)+ q_sqlPara2("po", t_po);
                
                if (t_comp.length>0)
                    t_where += " and charindex('" + t_comp + "',comp)>0";

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
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblTrandate'></a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBtdate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEtdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblContainertype'> </a></td>
					<td><select id="cmbContainertype" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDeliveryno'> </a></td>
					<td><select id="cmbDeliveryno" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblBoatname'></a></td>
					<td><input class="txt" id="txtBoatname" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblPo'></a></td>
					<td><input class="txt" id="txtPo" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
					<td><input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'></a></td>
					<td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSo'></a></td>
					<td><input class="txt" id="txtSo" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
