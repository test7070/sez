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
			var q_name = 'ucaucc', t_content = ' field=noa,product,spec,engpro,uweight', bbsKey = ['noa'], as;
			var t_sqlname = 'ucaucc_load';
			t_postname = q_name;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			brwCount2 = 20;
			$(document).ready(function() {
				main();
			});
			
			function main() {
				if (dataErr)
				{
					dataErr = false;
					return;
				}
				//mainBrow(6, t_content, t_sqlname, t_postname);
				mainBrow();
				
				$('#btnSearch').click(function() {
					var t_where="1=1";
					if(!emp($('#txtNoa').val())){
						t_where+=" and charindex('"+$('#txtNoa').val()+"',noa)>0";
					}
					if(!emp($('#txtProductno').val())){
						t_where+=" and charindex('"+$('#txtProductno').val()+"',product)>0";
					}
					if(!emp($('#txtSpec').val())){
						t_where+=" and charindex('"+$('#txtSpec').val()+"',spec)>0";
					}
					if(!emp($('#txtStyle').val())){
						t_where+=" and charindex('"+$('#txtStyle').val()+"',style)>0";
					}
					if (q_getPara('sys.project').toUpperCase()=='XY' && !emp($('#cmbStyle_xy').val())){
						t_where+=" and style='"+$('#cmbStyle_xy').val()+"'";
					}
					for(var i=0; i<abbs.length; i++){
						if(abbs[i].sel==true || abbs[i].sel=="true"){
							t_noa=t_noa+(t_noa.length>0?',':'')+"'"+abbs[i].noa+"'"; 
						}
					}
					
					//t_where="where=^^"+t_where+"^^"
					location.href = "http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+t_where+";"+r_accy;
				});
				
				if (q_getPara('sys.project').toUpperCase()=='XY'){
                	$('#txtStyle').hide();
                	$('#cmbStyle_xy').show();
                	q_cmbParse("cmbStyle_xy",'@全部,便品,空白,公版,加工,印刷,私-空白,新版,改版,新版數位樣,新版正式樣,改版數位樣,改版正式樣');
                }
			}

			function q_gtPost() {
			}

			function refresh() {
				_refresh();
				if (q_getPara('sys.project').toUpperCase()=='RB'){
					$('.br').hide();
					$('.isspec').hide();
					$('.isstyle').hide();
				}
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('.isstyle').show();
					$('#txtStyle').hide();
                	$('#cmbStyle_xy').show();
				}
				$('#lblNoa_s').text(q_getMsg('lblNoa'));
				$('#lblProduct_s').text(q_getMsg('lblProduct'));
				$('#lblSpec_s').text(q_getMsg('lblSpec'));
				$('#lblStyle_s').text(q_getMsg('lblStyle'));
			}

			function bbsAssign() {
				_bbsAssign();
				
				if (q_getPara('sys.project').toUpperCase()=='RB'){
					$('.br').hide();
					$('.isspec').hide();
					$('.isstyle').hide();
				}
				if (q_getPara('sys.project').toUpperCase()=='XY'){
					$('.isstyle').show();
					$('#txtStyle').hide();
                	$('#cmbStyle_xy').show();
				}
			}
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div id="dbbs" >
			<table id="tbbs" border="2" cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center" > </th>
					<th align="center" style='color:Blue;' ><a id='lblNoa'> </a></th>
					<th align="center" style='color:Blue;' ><a id='lblProduct'> </a></th>
					<th class="isspec" align="center" style='color:Blue;' ><a id='lblSpec'> </a></th>
					<th class="isstyle" align="center" style='color:Blue;display: none;' ><a id='lblStyle'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;">
						<input name="sel" id="radSel.*" type="radio" />
					</td>
					<td style="width:20%;">
						<input class="txt" id="txtNoa.*" type="text" style="width:98%;" readonly="readonly" />
					</td>
					<td style="width:30%;">
						<input class="txt" id="txtProduct.*" type="text" style="width:98%;" readonly="readonly" />
					</td>
					<td style="width:40%;" class="isspec">
						<input class="txt" id="txtSpec.*" type="text" style="width:98%;" readonly="readonly" />
					</td>
					<td style="width:10%;display: none;" class="isstyle">
						<input class="txt" id="txtStyle.*" type="text" style="width:98%;" readonly="readonly" />
					</td>
				</tr>
			</table>
			<div>
				<a id='lblNoa_s'> </a>
				<input class="txt" id="txtNoa" type="text" style="width:130px;" />
				<a id='lblProduct_s'> </a>
				 <input class="txt" id="txtProductno" type="text" style="width:200px;" />
				 <BR class="br">
				 <a class="isspec" id='lblSpec_s'> </a>
				 <input class="txt isspec" id="txtSpec" type="text" style="width:200px;" />
				 <a class="isstyle" id='lblStyle_s'  style="display: none;"> </a>
				 <input class="txt isstyle" id="txtStyle" type="text" style="width:50px;display: none;" />
				 <select id="cmbStyle_xy" class="txt isstyle" style="width:115px; font-size:medium;display: none;"> </select>
				 <input type="button" id="btnSearch" style="border-style: none; width: 26px; height: 26px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;background-size: 100%;">
			 </div>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>
	</body>
</html>