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
            var q_name = 'giftcust', t_content = ' field=noa,namea,comp,job,custno,nick', bbsKey = ['noa'], as;
            var isBott = false;
            //q_desc=1;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            $(document).ready(function() {
                main();
            });
            // end ready

            function main() {
                if(dataErr)// 
                {
                    dataErr = false;
                    return;
                }
                mainBrow(0, t_content);
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
            }
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" style="width:2%;"></th>
					<th align="center" style='width:10%;color:Blue;' ><a id='lblNoaa'></a></th>
					<th align="center" style='width:15%;color:Blue;' ><a id='lblCustno'></a></th>
					<th align="center" style='width:15%;color:Blue;' ><a id='lblJob'></a></th>
					<th align="center" style='width:15%;color:Blue;' ><a id='lblNamea'></a></th>
					<th align="center" style='width:15%;color:Blue;' ><a id='lblTel'></a></th>
					<th align="center" style='width:15%;color:Blue;' ><a id='lblMobile'></a></th>
					<th align="center" style='color:Blue;' ><a id='lblSendtype'></a></th>
				</tr>
				<tr>
					<td>
					<input name="sel"  id="radSel.*" type="radio" />
					</td>
					<td>
					<input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td>
					<input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td>
					<input class="txt" id="txtJob.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td>
					<input class="txt" id="txtNamea.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td>
					<input class="txt" id="txtTel.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td>
					<input class="txt" id="txtMobile.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
					<td>
					<input class="txt" id="txtSendtype.*" type="text" style="width:98%;"  readonly="readonly" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>
