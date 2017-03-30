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
            var q_name = "cust_buyer", t_content = "where=^^['','')^^", bbsKey = ['buyerno'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
       		brwCount = -1;
			brwCount2 = -1;
			
            $(document).ready(function() {
                main();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	t_content = "where=^^['"+t_para.custno+"','"+t_para.cno+"')^^";
	            }catch(e){
	            }    
                brwCount = -1;
                mainBrow(0, t_content);
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
				}
            }
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				$('#checkAllCheckbox').click(function(e){
					$('.ccheck').prop('checked',$(this).prop('checked'));
				});
			}
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						abbs = _q_appendData(q_name, "", true);
						refresh();
						break;
				}
			}

            function refresh() {
                _refresh();
            }
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<!--<th align="center" style="width:2%;"><input type="checkbox" id="checkAllCheckbox"/></th>-->
					<th align="center" style="width:3%;"> </th>
					<th align="center" style="width:4%;"> </th>
					<td align="center" style="width:10%;">編號</td>
					<td align="center" style="width:25%;">買受人</td>
					<td align="center" style="width:10%;">統編</td>
					<td align="center" style="width:10%;">郵遞區號</td>
					<td align="center" style="width:40%;">地址</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:3%;"> </th>
					<th align="center" style="width:4%;"> </th>
					
					<td align="center" style="width:10%;">編號</td>
					<td align="center" style="width:25%;">買受人</td>
					<td align="center" style="width:10%;">統編</td>
					<td align="center" style="width:10%;">郵遞區號</td>
					<td align="center" style="width:40%;">地址</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<!--<td style="width:2%;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>-->
					<td style="width:3%;">
						<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
					</td>
					<td style="width:4%;"><input name="sel" id="radSel.*" type="radio" /></td>
					<td style="width:10%;"><input type="text" id="txtBuyerno.*" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:25%;"><input type="text" id="txtBuyer.*" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:10%;"><input type="text" id="txtSerial.*" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:10%;"><input type="text" id="txtZip.*" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:40%;"><input type="text" id="txtAddress.*" style="float:left;width:95%;"  readonly="readonly" /></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

