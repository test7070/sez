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
			var q_name = 'ucc', t_content = ' field=noa,product,unit,spec,stdmount,vccacc1,vccacc2 order=odate', bbsKey = ['noa'], as;
			 var t_sqlname = 'ucc_load';
            t_postname = q_name;
            brwCount2 = 30;
			var isBott = false;
			/// 是否已按過 最後一頁
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			$(document).ready(function() {
				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				
				$('#btnSearch').click(function() {
					var t_where="1=1";
					if(!emp($('#txtNoa').val())){
						t_where+=" and charindex('"+$('#txtNoa').val()+"',noa)>0";
					}
					if(!emp($('#txtProductno').val())){
						t_where+=" and charindex('"+$('#txtProductno').val()+"',product)>0";
					}
					//t_where="where=^^"+t_where+"^^"
					location.href = location.origin+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+t_where+";"+r_accy;
				});
			}

			function q_gtPost() {

			}
			
			var xuccno=''
			function bbsAssign() {
                _bbsAssign();
            }

			function refresh() {
				_refresh();
				 /*if(window.parent.q_name=='uca'){
					 var wParent = window.parent.document;
					 var b_seq= wParent.getElementById("text_Noq").value
					 xuccno= wParent.getElementById("txtTd_"+b_seq).value;
				
				
					var xuccnos=xuccno.split('.');
					
					for (var j = 0; j < brwCount; j++) {
						for(var i=0;i<xuccnos.length;i++){
							if(xuccnos[i]==$('#txtNoa_' + j).val())
								$('#chkSel_'+j)[0].checked = "true";
						}
	                }
               }*/
			}
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<td align="center" > </td>
					<td align="center" style='color:blue;'><a id='lblNoa'> </a></td>
					<td align="center" style='color:blue;'><a id='lblProduct'> </a></td>
					<td align="center" style='color:blue;'><a id='lblUnit'> </a></td>
				</tr>
				<tr>
					<td style="width:2%;">	<input class="chk"  id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td style="width:20%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:63%;"><input class="txt" id="txtProduct.*" type="text" style="width:99%;"  readonly="readonly" /></td>
					<td style="width:8%;"><input class="txt" id="txtUnit.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
			<div>
				<a>物品編號</a>
				<input class="txt" id="txtNoa" type="text" style="width:130px;" />
				<a>物品名稱 </a>
				 <input class="txt" id="txtProductno" type="text" style="width:200px;" />
				 <input type="button" id="btnSearch" style="border-style: none; width: 36px; height: 36px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;">
			 </div>
		</div>
	</body>
</html>

