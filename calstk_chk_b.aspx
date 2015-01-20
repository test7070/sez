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
			var q_name = 'calstk', t_content = ' field=storeno,store,productno,product,unit,mount,weight,style,spec', bbsKey = ['storeno','productno'], as;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			brwCount = -1;
			brwCount2 = 0;
			$(document).ready(function() {
				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function mainPost(){
				q_getFormat();
			}

			function q_gtPost() {
			}
			
			function bbsAssign() {
			}
			
			function refresh() {
				_refresh();
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtProductno_' + t_id).val())){
							abbs[t_id]['sel'] = "true";
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
						}
					});
				});
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
			<table id="tbbs" class="tbbs" border="2"  cellpadding='0' cellspacing='0' style='100%'>
				<tr>
					<th align="center" style="width:40px;">
						<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<th align="center" style="width:150px;"><a id='lblStoreno'></a></th>
					<th align="center" style="width:150px;"><a id='lblStores'></a></th>
					<th align="center" style="width:180px;"><a id='lblProductno'></a></th>
					<th align="center" style="width:180px;"><a id='lblProducts'></a></th>
					<th align="center" style="width:40px;"><a id='lblUnits'></a></th>
					<th align="center" style="width:100px;"><a id='lblMounts'></a></th>
					<th align="center" style="width:100px;"><a id='lblWeights'></a></th>
				</tr>
				<tr style="background: #cad3ff;">
					<td style="text-align:center;"><input name="chk" id="chkSel.*" type="checkbox" /></td>
					<td><input class="txt c1" id="txtStoreno.*" type="text"/></td>
					<td><input class="txt c1" id="txtStore.*" type="text"/></td>
					<td><input class="txt c1" id="txtProductno.*" type="text"/></td>
					<td><input class="txt c1" id="txtProduct.*" type="text"/></td>
					<td><input class="txt c1" id="txtUnit.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtMount.*" type="text"/></td>
					<td><input class="txt c1 num" id="txtWeight.*" type="text"/>
						<input class="txt c1" id="txtSpec.*" type="hidden"/>
						<input class="txt c1" id="txtStyle.*" type="hidden"/>
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>