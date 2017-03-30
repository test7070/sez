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
	            	t_content = "where=^^['"+t_para.custno+"','"+t_para.cno+"','"+t_para.condition+"')^^";
	            	$('#txtCondition').val(t_para.condition);
	            }catch(e){
	            }    
                brwCount = -1;
                mainBrow(6, t_content);
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
				}
				$('#btnSearch').click(function() {
					var t_where ='';
					var t_custno='',t_cno='';
					var t_condition = $.trim($('#txtCondition').val());
		            try{
		            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
		            	t_custno=t_para.custno;
		            	t_cno=t_para.cno;
		            	q_time=t_para.q_time;
		            }catch(e){
		            } 
		            console.log("http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_getId()[2] + ";" + t_where+";"+";"+JSON.stringify({custno:t_custno,cno:t_cno,condition:t_condition,q_time:q_time}));
					location.href = "http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_getId()[2] + ";" + t_where+";"+";"+JSON.stringify({custno:t_custno,cno:t_cno,condition:t_condition,q_time:q_time});
				});
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
						refresh();
						break;
				}
			}

            function refresh() {
                _refresh();
            }
            function bbsAssign() {/// 表身運算式
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if ($('#btnMinus_' + i).hasClass('isAssign')) 
						continue;
				}
				_bbsAssign();
			}
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div>
			<a>查詢</a>
			<input class="txt" id="txtCondition" type="text" style="width:130px;" />
			<input type="button" id="btnSearch" style="border-style: none; width: 26px; height: 26px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;background-size: 100%;">
		 </div>
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

