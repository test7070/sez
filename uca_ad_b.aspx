<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		//該資料不含半成品
			var q_name = 'view_ucaucc2', t_content = ' field=tablea,noa,product,unit,spec,typea,groupano,price,tggno,comp,safemount,style,stdmount', bbsKey = ['noa'], as;
			var t_sqlname = 'ucaucc2_load';
			t_postname = q_name;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			
			aPop = new Array(
				['txtGroupeno', '', 'adsize', 'noa,mon,memo1,memo2', '0txtGroupeno', ''],
				['txtGroupfno', '', 'adsss', 'noa,mon,memo1,memo2', '0txtGroupfno', ''],
				['txtGroupgno', '', 'adknife', 'noa,mon,memo1,memo2', '0txtGroupgno', ''],
				['txtGrouphno', '', 'adpipe', 'noa,mon,memo1,memo2', '0txtGrouphno', ''],
				['txtGroupino', '', 'adtran', 'noa,mon,memo1,memo2', '0txtGroupino', ''],
				['txtUcolor','','adspec','noa,mon,memo1,memo2','0txtUcolor',''],
				['txtScolor','','adly','noa,mon,memo1,memo2','0txtScolor',''],
				['txtClass','','adly','noa,mon,memo1,memo2','0txtClass',''],
				['txtClassa','','adly','noa,mon,memo1,memo2','0txtClassa',''],
				['txtZinc','','adly','noa,mon,memo1,memo2','0txtZinc',''],
				['txtSizea','','adoth','noa,mon,memo1,memo2','0txtSizea',''],
				['txtSource','','adpro','noa,mon,memo1,memo2','0txtSource',''],
				['txtHard','','addime','noa,mon,memo1,memo2','0txtHard','']
			);
			
			$(document).ready(function() {
				main();
				parent.$.fn.colorbox.resize({
					height : "750px",
					width : "700px"
				});
			});
			function main() {
				q_cur=2;
				if (dataErr){
					dataErr = false;
					return;
				}
				brwCount2 = 6;
				mainBrow(6, t_content, t_sqlname, t_postname);
				
				$('#btnSearch').click(function() {
                    var t_where = "1=1";
                    if (!emp($('#txtNoa').val())) {
                        t_where += " and charindex('" + $('#txtNoa').val() + "',noa)>0";
                    }
                    if (!emp($('#txtProductno').val())) {
                        t_where += " and charindex('" + $('#txtProductno').val() + "',product)>0";
                    }
                    if (!emp($('#txtSpec').val())) {
                        t_where += " and (charindex('" + $('#txtSpec').val() + "',spec)>0 or charindex('" + $('#txtSpec').val() + "',product)>0)";
                    }
                    if (!emp($('#txtGroupeno').val())) {
                        t_where += " and (charindex('" + $('#txtGroupeno').val() + "',groupeno)>0 or charindex('" + $('#txtGroupeno').val() + "',product)>0)";
                    }
                    if (!emp($('#txtGroupfno').val())) {
                        t_where += " and (charindex('" + $('#txtGroupfno').val() + "',groupfno)>0 or charindex('" + $('#txtGroupfno').val() + "',product)>0)";
                    }
                    if (!emp($('#txtGroupgno').val())) {
                        t_where += " and (charindex('" + $('#txtGroupgno').val() + "',groupgno)>0 or charindex('" + $('#txtGroupgno').val() + "',product)>0)";
                    }
                    if (!emp($('#txtGrouphno').val())) {
                        t_where += " and (charindex('" + $('#txtGrouphno').val() + "',grouphno)>0 or charindex('" + $('#txtGrouphno').val() + "',product)>0)";
                    }
                    if (!emp($('#txtGroupino').val())) {
                        t_where += " and (charindex('" + $('#txtGroupino').val() + "',groupino)>0 or charindex('" + $('#txtGroupino').val() + "',product)>0)";
                    }
                    if (!emp($('#txtUcolor').val())) {
                        t_where += " and charindex('" + $('#txtUcolor').val() + "',product)>0";
                    }
                    if (!emp($('#txtScolor').val())) {
                        t_where += " and charindex('" + $('#txtScolor').val() + "',product)>0";
                    }
                    if (!emp($('#txtClass').val())) {
                        t_where += " and charindex('" + $('#txtClass').val() + "',product)>0";
                    }
                    if (!emp($('#txtClassa').val())) {
                        t_where += " and charindex('" + $('#txtClassa').val() + "',product)>0";
                    }
                    if (!emp($('#txtZinc').val())) {
                        t_where += " and charindex('" + $('#txtZinc').val() + "',product)>0";
                    }
                    if (!emp($('#txtSizea').val())) {
                        t_where += " and charindex('" + $('#txtSizea').val() + "',product)>0";
                    }
                    if (!emp($('#txtSource').val())) {
                        t_where += " and charindex('" + $('#txtSource').val() + "',product)>0";
                    }
                    if (!emp($('#txtHard').val())) {
                        t_where += " and charindex('" + $('#txtHard').val() + "',product)>0";
                    }
                    if (!emp($('#txtSize').val())) {
                        t_where += " and charindex('" + $('#txtSize').val() + "',size)>0";
                    }
                    if (!emp($('#txtStyle').val())) {
                        t_where += " and charindex('" + $('#txtStyle').val() + "',style)>0";
                    }
                    
                    var t_noa = '';
                    for (var i = 0; i < abbs.length; i++) {
                        if (abbs[i].sel == true || abbs[i].sel == "true") {
                            t_noa = t_noa + (t_noa.length > 0 ? ',' : '') + "'" + abbs[i].noa + "'";
                        }
                    }
                    if (t_noa.length > 0)
                        t_where += " or noa in (" + t_noa + ")";

                    //t_where="where=^^"+t_where+"^^"
                    location.href = "http://"+location.host + location.pathname + "?" + r_userno + ";" + r_name + ";" + q_id + ";" + t_where + ";" + r_accy;
                });
                
			}

			function q_gtPost() {
			}

			function refresh() {
				_refresh();
			}

			function bbsAssign() {
				_bbsAssign();
			}
		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div id="dbbs" >
			<table id="tbbs" border="2" cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<th align="center"> </th>
					<th align="center" style='color:Blue;' ><a id='lblNoa'> </a></th>
					<th align="center" style='color:Blue;' ><a id='lblProduct'> </a></th>
				</tr>
				<tr>
					<td style="width:2%;">
						<input name="sel" id="radSel.*" type="radio" />
					</td>
					<td style="width:30%;">
						<input class="txt" id="txtNoa.*" type="text" style="width:98%;" readonly="readonly" />
					</td>
					<td style="width:65%;">
						<textarea id="txtProduct.*" cols="10" rows="5" style="width:98%; height:65px;" readonly="readonly"> </textarea>
					</td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
			<div>
				<table style="width: 100%;">
					<tr>
						<td>產品編號</td>
						<td><input class="txt" id="txtNoa" type="text" style="width:90px;" /></td>
						<td>產品名稱</td>
						<td colspan="3"><input class="txt" id="txtProductno" type="text" style="width:200px;" /></td>
						<td rowspan="7"><input type="button" id="btnSearch" style="border-style: none; width: 36px; height: 36px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;"></td>
					</tr>
					<tr>
						<td style="width:100px;">型號</td>
						<td><input class="txt" id="txtSpec" type="text" style="width:90px;" /></td>
						<td style="width:100px;">車縫<br>Đường may</td>
						<td><input class="txt" id="txtGroupeno" type="text" style="width:90px;" /></td>
						<td style="width:100px;">護片<br>Phụ kiện</td>
						<td><input class="txt" id="txtGroupfno" type="text" style="width:90px;" /></td>
					</tr>
					<tr>
						<td>大弓<br>Gọng</td>
						<td><input class="txt" id="txtGroupgno" type="text" style="width:90px;" /></td>
						<td>中束<br>Bông</td>
						<td><input class="txt" id="txtGrouphno" type="text" style="width:90px;" /></td>
						<td>座管<br>Ống yên</td>
						<td><input class="txt" id="txtGroupino" type="text" style="width:90px;" /></td>
					</tr>
					<tr>
						<td>車縫線顏色<br>Màu chỉ may</td>
						<td><input class="txt" id="txtUcolor" type="text" style="width:90px;" /></td>
						<td>皮料1<br>Da1</td>
						<td><input class="txt" id="txtScolor" type="text" style="width:90px;" /></td>
						<td>皮料2<br>Da2</td>
						<td><input class="txt" id="txtClass" type="text" style="width:90px;" /></td>
					</tr>
					<tr>
						<td>皮料3<br>Da3</td>
						<td><input class="txt" id="txtClassa" type="text" style="width:90px;" /></td>
						<td>皮料4<br>Da4</td>
						<td><input class="txt" id="txtZinc" type="text" style="width:90px;" /></td>
						<td>網烙印<br>In ép</td>
						<td><input class="txt" id="txtSizea" type="text" style="width:90px;" /></td>
					</tr>
					<tr>
						<td>轉印<br>In ủi</td>
						<td><input class="txt" id="txtSource" type="text" style="width:90px;" /></td>
						<td>電鍍<br>mạ</td>
						<td><input class="txt" id="txtHard" type="text" style="width:90px;" /></td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td>尺寸</td>
						<td><input class="txt" id="txtSize" type="text" style="width:90px;" /></td>
						<td>車種</td>
						<td><input class="txt" id="txtStyle" type="text" style="width:90px;" /></td>
						<td> </td>
						<td> </td>
					</tr>
				</table>		
			</div>
		</div>
	</body>
</html>