<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'vcce_import', t_bbsTag = 'tbbs', t_content = " field=uno,ordeno,no2,productno,product,radius,width,dime,lengthb,spec,mount,weight,price,custno,comp", afilter = [], bbsKey = ['ordeno'],  as; //, t_where = '';
			var t_sqlname = 'vcce_import'; t_postname = q_name;
			brwCount2 = 0;
			brwCount = -1;

			var isBott = false;  /// 是否已按過 最後一頁
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
			q_desc = 1;
			$(document).ready(function () {
				if (!q_paraChk())
					return;
		
				main();
			});		 /// end ready
		
			function main() {
				if (dataErr)  /// 載入資料錯誤
				{
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}
		
			function bbsAssign() { 
				_bbsAssign();
			}
		
			function q_gtPost() {  
		
			}
			var maxAbbsCount = 0;
			function refresh() {
				_refresh();
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (abbs[i].ordeno.length>0 && w.$('#txtOrdeno_' + j).val() == abbs[i].ordeno && w.$('#txtNo2_' + j).val() == abbs[i].no2) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).prop('checked', true);
							}
						}
					}
					maxAbbsCount = abbs.length;
				}
				abbs.sort(function(a,b){
					var x = (a.sel==true || a.sel=="true"?1:0);
					var y = (b.sel==true || b.sel=="true"?1:0);
					return y-x;
				});
				_refresh();
				$('#checkAllCheckbox').click(function(){
					$('input[type=checkbox][id^=chkSel]').each(function(){
						var t_id = $(this).attr('id').split('_')[1];
						if(!emp($('#txtOrdeno_' + t_id).val()))
							$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
					});
				});
			}
	</script>
	<style type="text/css">
		.seek_tr
		{color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
		input[type="text"], input[type="button"] {
			font-size: medium;
		}
		.txt {
			float:left;
		}
		.c1 {
			width:95%;
		}
	</style>
</head>
<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
					<tr style='color:White; background:#003366;' >
						<td align="center" style="width:1%;">
							<input type="checkbox" id="checkAllCheckbox"/>
						</td>
						<td align="center" style="width:12%;"><a id='lblUno'></a></td>
						<td align="center" style="width:15%;"><a id='lblOrdeno'></a></td>
						<td align="center" style="width:10%;"><a id='lblCustno'></a></td>
						<td align="center" style="width:15%;"><a id='lblProductno'></a></td>
						<td align="center" style="width:25%;"><a id='lblSizea'></a></td>
						<td align="center" style="width:8%;"><a id='lblMount'></a></td>
						<td align="center" style="width:8%;"><a id='lblWeight'></a></td>
						<td align="center" style="width:8%;"><a id='lblPrice'></a></td>
					</tr>
			</table>
		</div>
		<div  id="dbbs" style="overflow: scroll;height:550px;">
				<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
					<tr style='color:White; background:#003366;display:none;' >
						<td align="center">
							<input type="checkbox" id="checkAllCheckbox"/>
						</td>
						<td align="center"><a id='lblUno'></a></td>
						<td align="center"><a id='lblOrdeno'></a></td>
						<td align="center"><a id='lblCustno'></a></td>
						<td align="center"><a id='lblProductno'></a></td>
						<td align="center"><a id='lblSizea'></a></td>
						<td align="center"><a id='lblMount'></a></td>
						<td align="center"><a id='lblWeight'></a></td>
						<td align="center"><a id='lblPrice'></a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td style="width:1%;" align="center"><input id="chkSel.*" type="checkbox"/></td>
						<td style="width:12%;"><input class="txt c1" id="txtUno.*" type="text"/></td>
						<td style="width:15%;">
							<input class="txt" id="txtOrdeno.*" type="text" style="width:65%;"/>
							<input class="txt" id="txtNo2.*" type="text" style="width:25%;"/>
						</td>
						<td style="width:10%;">
							<input class="txt c1" id="txtCustno.*" type="text"/>
							<input class="txt c1" id="txtComp.*" type="text"/>
						</td>
						<td style="width:15%;">
							<input class="txt c1" id="txtProductno.*" type="text"/>
							<input class="txt c1" id="txtProduct.*" type="text"/>
						</td>
						<td style="width:25%;"><input class="txt" id="txtSpec.*" type="text"  style="width:98%;" />
											<input id="txtRadius.*" type="text"  style="width:21%;text-align:right;" />x
											<input id="txtDime.*" type="text"  style="width:21%;text-align:right;" />x
											<input id="txtWidth.*" type="text"  style="width:21%;text-align:right;" />x
											<input id="txtLengthb.*" type="text"  style="width:21%;text-align:right;" /></td>
						<td style="width:8%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
						<td style="width:8%;"><input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/></td>
						<td style="width:8%;"><input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/></td>
					</tr>
				</table>
		 </div>
		  <!--#include file="../inc/pop_ctrl.inc"--> 
</body>
</html>
