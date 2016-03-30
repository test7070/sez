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
			var q_name = 'ucr', t_content = ' field=noa,product,unit,engpro,typea', bbsKey = ['noa'], as;
			var isBott = false;
			/// 是否已按過 最後一頁
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			$(document).ready(function() {
				main();
				r_accy='';
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow();
				
				$('#btnSearch').click(function() {
					var t_where="1=1";
					if(!emp($('#txtNoa').val())){
						t_where+=" and charindex('"+$('#txtNoa').val()+"',noa)>0";
					}
					if(!emp($('#txtProductno').val())){
						t_where+=" and charindex('"+$('#txtProductno').val()+"',product)>0";
					}
					for(var i=0; i<abbs.length; i++){
						if(abbs[i].sel==true || abbs[i].sel=="true"){
							t_noa=t_noa+(t_noa.length>0?',':'')+"'"+abbs[i].noa+"'"; 
						}
					}
					
					//t_where="where=^^"+t_where+"^^"
					location.href = "http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+t_where+";"+r_accy;
				});
			}

			function q_gtPost() {

			}

			function refresh() {
				_refresh();
					
				for (var j = 0; j < brwCount; j++) {
					if($('#combTypea_'+j).length<1)
						continue;
					
					q_cmbParse("combTypea_"+j, q_getPara('ucr.typea'));	// 需在 main_form() 後執行，才會載入 系統參數
			        
			        if(!emp($('#txtTypea_'+j).val()))
			        	$('#combTypea_'+j).val($('#txtTypea_'+j).val());
			        else
			        	$('#combTypea_'+j).text('');
			        
			        for (var k = 0; k < fbbs.length; k++) {
			        	if(fbbs[k]!='radSel'){
				        	$('#'+fbbs[k]+'_'+j).attr('disabled', 'disabled');
			            	$('#'+fbbs[k]+'_'+j).css('background', t_background2);
		            	}
					}
					$('#combTypea_'+j).attr('disabled', 'disabled');
		            $('#combTypea_'+j).css('background', t_background2);
		        }
				
				$('#lblXnoa').text($('#lblNoa').text());
				$('#lblXproduct').text($('#lblProduct').text());
				
				parent.$.fn.colorbox.resize({
					height : (parent.$.colorbox.getHeight()+120)+"px"
				});
			}
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" > </th>
					<th align="center" style='color:blue;'><a id='lblNoa'> </a></th>
					<th align="center" style='color:blue;'><a id='lblProduct'> </a></th>
					<th align="center" style='color:blue;'><a id='lblUnit'> </a></th>
					<th align="center" style='color:blue;'><a id='lblTypea'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;"><input name="sel"  id="radSel.*" type="radio" /></td>
					<td style="width:22%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:50%;"><input class="txt" id="txtProduct.*" type="text" style="width:99%;"  readonly="readonly" /></td>
					<td style="width:8%;"><input class="txt" id="txtUnit.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:15%;">
						<input class="txt" id="txtTypea.*" type="hidden" style="width:98%;" />
						<select id="combTypea.*" class="txt c1" style="width:98%;"  readonly="readonly"> </select>
					</td>
				</tr>
			</table>
			<div>
				<a id='lblXnoa'> </a>
				<input class="txt" id="txtNoa" type="text" style="width:110px;" />
				<a id='lblXproduct'> </a>
				 <input class="txt" id="txtProductno" type="text" style="width:180px;" />
				 <input type="button" id="btnSearch" style="border-style: none; width: 36px; height: 36px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;">
			 </div>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>