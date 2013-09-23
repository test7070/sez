<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'view_ordes', t_bbsTag = 'tbbs', t_content = " field=accy,noa,no2,productno,product,sizea,unit,price,weight,memo,mount,total,datea,cancel,type,custno,indate,enda,c2,notv2,odate,spec,no3,quatno,size,dime,width,lengthb,c1,notv,style,uno,source,classa,issale,slit,iscut,theory,apv,radius,gweight,class,comp,cust,mechno,mech,tdmount,kind,cub_ordeno,cub_no2,cub_mount,cub_weight,cut_ordeno,cut_no2,cut_mount,cut_weight,ordet_ordeno,ordet_no3,ordet_mount,ordet_weight,lastmount,lastweight", afilter = [], bbsKey = ['noa'], as;
			//, t_where = '';
			var t_sqlname = 'ordests_load';
			t_postname = q_name;
			brwCount2 = 0;
			brwCount = -1;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
			$(document).ready(function() {
				if (!q_paraChk())
					return;

				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
			}

			function bbsAssign() {
				_bbsAssign();
				for (var j = 0; j < q_bbsCount; j++) {
				}
			}

			function q_gtPost() {

			}

			var maxAbbsCount = 0;
			function refresh() {
				_refresh();
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length-(abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtOrdeno_' + j).val() == abbs[i].noa && w.$('#txtNo2_' + j).val() == abbs[i].no2) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
					}
					maxAbbsCount = abbs.length;
				}
				_refresh();
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtProductno_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
			}

		</script>
		<style type="text/css">
			.seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe;
            }
			input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input type="checkbox" id="checkAllCheckbox"/>
					</td>
					<td align="center"><a id='lblProductno'></a>/<a id='lblProduct'></a></td>
					<td align="center"><a id='lblSpec'></a></td>
					<td align="center"><a id='lblUnit'></a></td>
					<td align="center"><a id='lblMount'></a></td>
					<td align="center"><a id='lblWeight'></a></td>
					<td align="center"><a id='lblPrice'></a></td>
					<td align="center"><a id='lblNotv'></a></td>
					<td align="center"><a id='lblNoa'></a></td>
					<td align="center"><a id='lblCust'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;" align="center">
					<input id="chkSel.*" type="checkbox"/>
					</td>
					<td style="width:15%;">
					<input class="txt"  id="txtProductno.*" type="text" style="width:98%;" />
					<input class="txt" id="txtProduct.*" type="text" style="width:98%;" />
					</td>
					<td style="width:18%;">
					<input class="txt" id="txtSpec.*" type="text"  style="width:98%;" />
					<input class="txt" id="txtDime.*" type="text"  style="width:25%;text-align:right;" />
					x
					<input class="txt" id="txtWidth.*" type="text"  style="width:25%;text-align:right;" />
					x
					<input class="txt" id="txtLengthb.*" type="text"  style="width:25%;text-align:right;" />
					</td>
					<td style="width:4%;">
					<input class="txt" id="txtUnit.*" type="text" style="width:94%;"/>
					</td>
					<td style="width:8%;">
					<input class="txt" id="txtLastmount.*" type="text" style="width:94%; text-align:right;"/>
					</td>
					<td style="width:8%;">
					<input class="txt" id="txtLastweight.*" type="text" style="width:96%; text-align:right;"/>
					</td>
					<td style="width:8%;">
					<input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/>
					</td>
					<td style="width:8%;">
					<input class="txt" id="txtNotv.*" type="text" style="width:96%; text-align:right;"/>
					</td>
					<td style="width:11%;">
					<input class="txt" id="txtNoa.*" type="text" style="width:98%;"/>
					<input class="txt" id="txtNo2.*" type="text"  style="width:98%;"/>
					</td>
					<td style="width:8%;">
					<input class="txt" id="txtComp.*" type="text" style="width:96%; text-align:left;"/>
					</td>
					<td>
					<input class="txt" id="txtMemo.*" type="text" style="width:98%;"/>
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
