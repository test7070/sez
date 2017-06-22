<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "assignwork_s";
			var aPop = new Array(
				['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'], 
				['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
				['txtProductno', 'btnProductno', 'assignproduct', 'noa,product', 'txtProductno,txtProduct', 'assignproduct_b.aspx']);

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

				bbmMask = [['txtBodate', r_picd], ['txtEodate', r_picd],['txtBenddate', r_picd], ['txtEenddate', r_picd]];
				q_mask(bbmMask);

				$('#txtBodate').focus();
				q_cmbParse("cmbKind", ('').concat(new Array( '全部','工商','土地')));
				q_cmbParse("cmbEnda", ('').concat(new Array( '@','1@結案','0@未結案')));
			}

			function q_seekStr() {
				t_noa = $.trim($('#txtNoa').val());
				t_bodate = $.trim($('#txtBodate').val());
				t_eodate = $.trim($('#txtEodate').val());
				t_benddate = $.trim($('#txtBenddate').val());
				t_eenddate = $.trim($('#txtEenddate').val());
				t_custno = $.trim($('#txtCustno').val());
				t_comp = $.trim($('#txtComp').val());
				t_itemno = $.trim($('#txtItemno').val());
				t_item = $.trim($('#txtItem').val());
				t_enda = $.trim($('#cmbEnda').val());
				t_accno = $.trim($('#txtAccno').val());
				t_accno2 = $.trim($('#txtAccno2').val());
				t_vccno = $.trim($('#txtVccno').val());
				t_paybno = $.trim($('#txtPaybno').val());
			    t_bodate = t_bodate.length > 0 && t_bodate.indexOf("_") > -1 ? t_bodate.substr(0, t_bodate.indexOf("_")) : t_bodate;  /// 100.  .
        		t_eodate = t_eodate.length > 0 && t_eodate.indexOf("_") > -1 ? t_eodate.substr(0, t_eodate.indexOf("_")) : t_eodate;  /// 100.  .
				t_benddate = t_benddate.length > 0 && t_benddate.indexOf("_") > -1 ? t_benddate.substr(0, t_benddate.indexOf("_")) : t_benddate;  /// 100.  .
        		t_eenddate = t_eenddate.length > 0 && t_eenddate.indexOf("_") > -1 ? t_eenddate.substr(0, t_eenddate.indexOf("_")) : t_eenddate;  /// 100.  .
					
				var t_where = " 1=1 "
					+q_sqlPara2("noa", t_noa)
					+q_sqlPara2("odate", t_bodate, t_eodate)
					+q_sqlPara2("enddate", t_benddate,t_eenddate)
					+q_sqlPara2("custno", t_custno)
					+q_sqlPara2("comp", t_comp)
					+q_sqlPara2("itemno", t_itemno)
					+q_sqlPara2("enda", t_enda)
					+q_sqlPara2("item", t_item)
					+q_sqlPara2("accno", t_accno)
					+q_sqlPara2("accno2", t_accno2)
					+q_sqlPara2("vccno", t_vccno)
					+q_sqlPara2("paybno", t_paybno);
					
				if($('#cmbKind').val()=='全部')
					t_where = " where=^^" + t_where + "^^";
				else
					t_where = " where=^^" + t_where + " and kind='"+$('#cmbKind').val()+"'^^";
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
					<td style="width:35%;" ><a id='lblOdate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBodate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEodate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblEnddate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBenddate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEenddate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'> </a></td>
					<td>
					<input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtComp" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblProductno'> </a></td>
					<td>
					<input class="txt" id="txtProductno" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtProduct" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblKind'> </a></td>
					<td>
					<select id="cmbKind" class="txt c1"> </select>
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblEnda'> </a></td>
					<td>
						<select id="cmbEnda" class="txt c1"> </select>
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAccno'> </a></td>
					<td>
					<input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAccno2'> </a></td>
					<td>
					<input class="txt" id="txtAccno2" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblVccno'> </a></td>
					<td>
					<input class="txt" id="txtVccno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblPaybno'> </a></td>
					<td>
					<input class="txt" id="txtPaybno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
