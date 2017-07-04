<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			//司機加減項 對應  客戶加減項
            var q_name = "custchg2carchg", t_content = "where=^^['')^^", bbsKey = ['noa'], as;
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
	            	t_content = "where=^^['"+t_para.project+"','"+t_para.carchgno+"','"+t_para.custno+"')^^";
	            }catch(e){
	            }    
                brwCount = -1;
                mainBrow(0, t_content);
            }
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						abbs = _q_appendData(q_name, "", true);
						//refresh();
						break;
				}
			}
			var maxAbbsCount = 0;
            function refresh() {
				_refresh();
				for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
				//_readonlys(true);
			}
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px" > </td>
					<td align="center" style="width:30px;"><a style="font-weight: bold;text-align: center;display: block;">　</a></td>
					<td align="center" style="width:100px;"><a>單號</a></td>
					<td align="center" style="width:70px;"><a>日期</a></td>
					<td align="center" style="width:100px;"><a>加項</a></td>
					<td align="center" style="width:80px;"><a>加項金額</a></td>
					<td align="center" style="width:100px;"><a>減項</a></td>
					<td align="center" style="width:80px;"><a>減項金額</a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:400px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<td align="center" style="width:25px;"> </td>
					<td align="center" style="width:30px;"><a style="font-weight: bold;text-align: center;display: block;">　</a></td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:70px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:80px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:80px;"> </td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;"><input id="chkSel.*" type="radio" name="groupA"/></td>
					<td style="width:30px;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="width:100px;"><input id="txtNoa.*" type="text" style="width:95%;" readonly="readonly"/></td>
					<td style="width:70px;"><input id="txtDatea.*" type="text" style="width:95%;" readonly="readonly"/></td>
					<td style="width:100px;"><input id="txtPlusitem.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:80px;"><input id="txtPlusmoney.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:100px;"><input id="txtMinusitem.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:80px;"><input id="txtMinusmoney.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

