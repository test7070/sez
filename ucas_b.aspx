<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'ucas', t_content = ' field=noa,noq,spec,productno,product,unit,mount,weight,mtype,processno,process,loss,memo', bbsKey = ['noa'], as;
			var isBott = false;
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
				mainBrow();
			}

			function mainPost(){
				q_getFormat();
				q_cmbParse("cmbMtype", q_getPara('uca.mtype'),'s');
			}

			function q_gtPost() {
				
			}
			function refresh() {
				_refresh();
				_readonlys(true);
			}
		</script>
		<style type="text/css">
            .num {
                text-align: right;
            }
            .txt.c1 {
            	width: 98%;
                float: left;
            }
            #tbbs tr:first-child{
            	color: White;
				background: #003366;
            }
		</style>
	</head>

	<body>
		<div id="dbbs" >
			<table id="tbbs" class="tbbs" border="2"  cellpadding='0' cellspacing='0' style='width:98%'>
				<tr>
					<th align="center" style="width:2%;"></th>
					<th align="center" style="width:11%;"><a id='lblProductno'></a></th>
					<th align="center" style="width:15%;"><a id='lblProducts'></a></th>
					<th align="center" style="width:4%;"><a id='lblUnit'></a></th>
					<th align="center" style="width:5%;"><a id='lblMount'></a></th>
					<th align="center" style="width:8%;"><a id='lblWeights'></a></th>
					<th align="center" style="width:8%;"><a id='lblMtype_s'></a></th>
					<th align="center" style="width:15%;"><a id='lblProcessno_s'></a></th>
					<th align="center" style="width:6%;"><a id='lblLoss_s'></a></th>
					<th align="center"><a id='lblMemos'></a></th>
				</tr>
				<tr style="background: #cad3ff;">
					<td><input name="sel" id="radSel.*" type="radio" /></td>
	                <td>
	                	<input id="txtNoa.*" type="hidden"/>
	                	<input id="txtProductno.*" type="text" class="txt c1"/>
	                </td>
	                <td>
	                	<input id="txtProduct.*" type="text" class="txt c1"/>
	                	<input id="txtSpec.*" type="text" class="txt c1"/>
	                </td>
	                <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
	                <td><input id="txtMount.*" type="text" class="txt num c1"/></td>
	                <td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
	                <td><select id="cmbMtype.*" class="txt c1"> </select></td>
	                <td>
	                	<input id="txtProcessno.*" type="text" style="width: 30%;"/>
	                	<input id="txtProcess.*" type="text" style="width: 65%;"/>
	                </td>
	                <td><input id="txtLoss.*" type="text" class="txt num c1"/></td>
	                <td>
	                	<input id="txtMemo.*" type="text" class="txt c1"/>
	                	<input id="txtNoq.*" type="hidden" />
	                </td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>

