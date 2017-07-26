<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "uca_s";
			aPop = new Array(
				['txtNoa', '', 'uca', 'noa,product', 'txtNoa', "uca_b.aspx"],
				['txtTggno', 'lblTgg', 'tgg', 'noa,nick', 'txtTggno', 'tgg_b.aspx'],
				['txtGroupeno', '', 'adsize', 'noa,mon,memo1,memo2', '0txtGroupeno', ''],
				['txtGroupfno', '', 'adsss', 'noa,mon,memo1,memo2', '0txtGroupfno', ''],
				['txtGroupgno', '', 'adknife', 'noa,mon,memo1,memo2', '0txtGroupgno', ''],
				['txtGrouphno', '', 'adpipe', 'noa,mon,memo1,memo2', '0txtGrouphno', ''],
				['txtGroupino', '', 'adtran', 'noa,mon,memo1,memo2', '0txtGroupino', ''],
				['txtUcolor','','adspec','noa,mon,memo1,memo2','0txtUcolor_',''],
				['txtScolor','','adly','noa,mon,memo1,memo2','0txtScolor',''],
				['txtClass','','adly','noa,mon,memo1,memo2','0txtClass',''],
				['txtClassa','','adly','noa,mon,memo1,memo2','0txtClassa',''],
				['txtZinc','','adly','noa,mon,memo1,memo2','0txtZinc',''],
				['txtSizea','','adoth','noa,mon,memo1,memo2','0txtSizea',''],
				['txtSource','','adpro','noa,mon,memo1,memo2','0txtSource',''],
				['txtHard','','addime','noa,mon,memo1,memo2','0txtHard',''],
				['txtSpec','','adsec','noa,memo','0txtSpec',''],
				['txtStyle','','adpro2','memo','0txtStyle',''],
				['txtModelno', 'lblModelno', 'modg', 'noa,namea', 'txtModelno', 'modg_b.aspx'],
				['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno', 'process_b.aspx'],
				['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno', 'station_b.aspx']
				
			);
			$(document).ready(function() {
				main();
			});

			function main() {
				mainSeek();
				q_gf('', q_name);
				$('#btnSearch').before($('#btnSearch').clone().attr('id', 'btnSearch2').show()).hide();
				$('#btnSearch2').click(function(){
					var t_noa = $.trim($('#txtNoa').val());
					var t_product = $.trim($('#txtProduct').val());
					if(t_noa.length > 0){
						var t_where = "where=^^ left(noa,"+t_noa.length+")='" + t_noa + "' ^^ stop=10 ";
						q_gt('uca', t_where, 0, 0, 0, "SeekNoaInUca", r_accy);
					}else if(t_product.length > 0){
						var t_where = "where=^^ product like '%" + t_product + "%' ^^ stop=10 ";
						q_gt('uca', t_where, 0, 0, 0, "SeekProductInUca", r_accy);
					}else{
						$('#btnSearch').click();
					}
				});
				q_gt('uccga', "where=^^noa < '50' ^^", 0, 0, 0, "");
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();
				q_cmbParse("cmbTypea", '@全部,' + q_getPara('uca.typea'));
				q_cmbParse("cmbGroupdno", ',ODM,OBM,OEM');
				
				$('#txtNoa').focus();
			}

			function q_gtPost(s2){
				switch(s2){
					case 'SeekNoaInUca':
						var as = _q_appendData("uca", "", true);
						if (as[0] != undefined) {
							$('#btnSearch').click();
						}else{
							var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
							parent.b_window = false;
							parent.q_box("ucc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucc', "95%", "95%", q_getMsg('popUcc'));
						}
						break;
					case 'SeekProductInUca':
						var as = _q_appendData("uca", "", true);
						if (as[0] != undefined) {
							$('#btnSearch').click();
						}else{
							var t_where = "product like '%" + $.trim($('#txtProduct').val()) + "%'";
							parent.b_window = false;
							parent.q_box("ucc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucc', "95%", "95%", q_getMsg('popUcc'));
						}
						break;
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
							}
							q_cmbParse("cmbGroupano", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupano").val(abbm[q_recno].groupano);
							}
						}
						break;
				}
			}
			
			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_product = $('#txtProduct').val();
				t_processno = $('#txtProcessno').val();
				t_process = $('#txtProcess').val();
				t_stationno = $('#txtStationno').val();
				t_station = $('#txtStation').val();
				
				t_spec = $('#txtSpec').val();
				t_groupeno = $('#txtGroupeno').val();
				t_groupfno = $('#txtGroupfno').val();
				t_groupgno = $('#txtGroupgno').val();
				t_grouphno = $('#txtGrouphno').val();
				t_groupino = $('#txtGroupino').val();
				t_ucolor = $('#txtUcolor').val();
				t_scolor = $('#txtScolor').val();
				t_class = $('#txtClass').val();
				t_classa = $('#txtClassa').val();
				t_zinc = $('#txtZinc').val();
				t_sizea = $('#txtSizea').val();
				t_sourcer = $('#txtSource').val();
				t_hard = $('#txtHard').val();
				
				//t_size = $('#txtSize').val();
				t_size1 = $('#txtSize1').val();
				t_size2 = $('#txtSize2').val();
				t_size3 = $('#txtSize3').val();
				t_size4 = $('#txtSize4').val();
				
				t_groupdno = $('#cmbGroupdno').val();
				
				t_typea = $('#cmbTypea').val();
				t_tggno = $('#txtTggno').val();
				t_comp = $('#txtComp').val();
				t_groupano = $('#cmbGroupano').val();
				t_style = $('#txtStyle').val();
				
				t_modelno = $('#txtModelno').val();
				t_model = $('#txtModel').val();

				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) +
										q_sqlPara2("groupdno", t_groupdno) +
										q_sqlPara2("processno", t_processno) +
										q_sqlPara2("stationno", t_stationno) +
										q_sqlPara2("typea", t_typea) +
										q_sqlPara2("groupano", t_groupano) +
										q_sqlPara2("tggno", t_tggno) +
										q_sqlPara2("modelno", t_modelno)
										
										;
				
				if (t_product.length > 0 && t_spec.length==0)
					t_where += " and charindex('" + t_product + "',product)>0";
				if (t_spec.length > 0)
					t_where += " and charindex('" + t_spec + "',spec)>0 ";//106/03/23 不查詢品名 or charindex('" + t_spec + "',product)>0)
				if (t_groupeno.length > 0)
					t_where += " and (charindex('" + t_groupeno + "',groupeno)>0 or charindex('" + t_groupeno + "',product)>0) ";
				if (t_groupfno.length > 0)
					t_where += " and (charindex('" + t_groupfno + "',groupfno)>0 or charindex('" + t_groupfno + "',product)>0) ";
				if (t_groupgno.length > 0)
					t_where += " and (charindex('" + t_groupgno + "',groupgno)>0 or charindex('" + t_groupgno + "',product)>0) ";
				if (t_grouphno.length > 0)
					t_where += " and (charindex('" + t_grouphno + "',grouphno)>0 or charindex('" + t_grouphno + "',product)>0) ";
				if (t_groupino.length > 0)
					t_where += " and (charindex('" + t_groupino + "',groupino)>0 or charindex('" + t_groupino + "',product)>0) ";
					
				if (t_ucolor.length > 0)
					t_where += " and charindex('" + t_ucolor + "',product)>0 ";
				if (t_scolor.length > 0)
					t_where += " and charindex('" + t_scolor + "',product)>0 ";
				if (t_class.length > 0)
					t_where += " and charindex('" + t_class + "',product)>0 ";
				if (t_classa.length > 0)
					t_where += " and charindex('" + t_classa + "',product)>0 ";
				if (t_zinc.length > 0)
					t_where += " and charindex('" + t_zinc + "',product)>0 ";
				if (t_sizea.length > 0)
					t_where += " and charindex('" + t_sizea + "',product)>0 ";
				if (t_sourcer.length > 0)
					t_where += " and charindex('" + t_sourcer + "',product)>0 ";
				if (t_hard.length > 0)
					t_where += " and charindex('" + t_hard + "',product)>0 ";				
				
				if (t_style.length > 0)
					t_where += " and charindex('" + t_style + "',style)>0";
				/*if (t_size.length > 0)
					t_where += " and charindex('" + t_size + "',size)>0";*/	
					
				if (t_model.length > 0)
					t_where += " and charindex('" + t_model + "',model)>0";
				
				if(t_size1.length>0 || t_size2.length>0){
					if(t_size2.length==0){
						t_where += " and (cast(dbo.get_num(substring(size,0,CHARINDEX('*',size))) as float) between "+t_size1+" and 9999999 ) ";
					}else{
						t_where += " and (cast(dbo.get_num(substring(size,0,CHARINDEX('*',size))) as float) between "+t_size1+" and "+t_size2+") ";
					}
				}
				
				if(t_size3.length>0 || t_size4.length>0){
					if(t_size4.length==0){
						t_where += " and (cast(dbo.get_num(substring(size,CHARINDEX('*',size)+1,len(size)))as float) between "+t_size3+" and 9999999 ) ";
					}else{
						t_where += " and (cast(dbo.get_num(substring(size,CHARINDEX('*',size)+1,len(size)))as float) between "+t_size3+" and "+t_size4+") ";
					}
				}
					
				if (t_process.length > 0)
					t_where += " and charindex('" + t_process + "',process)>0";
				if (t_station.length > 0)
					t_where += " and charindex('" + t_station + "',station)>0";
				if (t_comp.length > 0)
					t_where += " and charindex('" + t_comp + "',comp)>0";
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
			.c1{
				width:200px;
				font-size:medium;
			}
		</style>
	</head>
	<body>
		<div style='width:700px; text-align:center;padding:15px;' >
			<table id="seek" border="1" cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek' style="width:130px;"><a id='lblNoa'> </a></td>
					<td><input class="txt c1" id="txtNoa" type="text"/></td>
					<td class='seek'  style="width:130px;"><a id='lblProduct'> </a></td>
					<td><input class="txt c1" id="txtProduct" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblSpec_jo'>型號</a></td>
					<td><input class="txt c1" id="txtSpec" type="text" /></td>
					<td class='seek'><a id='lblGroupeno_jo'>車縫 Đường may</a></td>
					<td><input class="txt c1" id="txtGroupeno" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblGroupfno_jo'>護片Phụ kiện</a></td>
					<td><input class="txt c1" id="txtGroupfno" type="text" /></td>
					<td class='seek'><a id='lblGroupgno_jo'>大弓 Gọng</a></td>
					<td><input class="txt c1" id="txtGroupgno" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblGrouphno_jo'>中束 Bông</a></td>
					<td><input class="txt c1" id="txtGrouphno" type="text" /></td>
					<td class='seek'><a id='lblGroupino_jo'>座管 Ống yên</a></td>
					<td><input class="txt c1" id="txtGroupino" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblUcolor_jo'>車縫線顏色<br>Màu chỉ may</a></td>
					<td><input class="txt c1" id="txtUcolor" type="text" /></td>
					<td class='seek'><a id='lblSizea_jo'>網烙印 In ép</a></td>
					<td><input class="txt c1" id="txtSizea" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblScolor_jo'>皮料1 Da1</a></td>
					<td><input class="txt c1" id="txtScolor" type="text" /></td>
					<td class='seek'><a id='lblClass_jo'>皮料2 Da2</a></td>
					<td><input class="txt c1" id="txtClass" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblClassa_jo'>皮料3 Da3</a></td>
					<td><input class="txt c1" id="txtClassa" type="text" /></td>
					<td class='seek'><a id='lblZinc_jo'>皮料4 Da4</a></td>
					<td><input class="txt c1" id="txtZinc" type="text" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblSource_jo'>轉印 In ủi</a></td>
					<td><input class="txt c1" id="txtSource" type="text" /></td>
					<td class='seek'><a id='lblHard_jo'>電鍍 mạ</a></td>
					<td><input class="txt c1" id="txtHard" type="text" /></td>
				</tr>
				
				<tr class='seek_tr'>
					<td class='seek'><a id='lblSize1_jo'>尺寸(長)</a></td>
					<td>
						<!--<input class="txt c1" id="txtSize" type="text" />-->
						<input class="txt c1" id="txtSize1" type="text" style="width: 45%;text-align: right;" />~
						<input class="txt c1" id="txtSize2" type="text" style="width: 45%;text-align: right;"/>
						
					</td>
					<td class='seek'><a id='lblSize3_jo'>尺寸(寬)</a></td>
					<td>
						<input class="txt c1" id="txtSize3" type="text" style="width: 45%;text-align: right;"/>~
						<input class="txt c1" id="txtSize4" type="text" style="width: 45%;text-align: right;"/>
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblStyle_jo'>車種</a></td>
					<td><input class="txt c1" id="txtStyle" type="text" /></td>
					<td class='seek'><a id='lblModelno_jo'>模具群組</a></td>
					<td>
						<input class="txt" id="txtModelno" type="text" style="width:80px; font-size:medium;" />
						<input class="txt" id="txtModel" type="text" style="width:105px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" class="c1" > </select></td>
					<td class='seek'><a id='lblGroupano'> </a></td>
					<td><select id="cmbGroupano" class="c1" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblGroupdno_jo'>銷售屬性</a></td>
					<td><select id="cmbGroupdno" class="c1" > </select></td>
					<td class='seek'><a id='lblTggno'> </a></td>
					<td>
						<input class="txt" id="txtTggno" type="text" style="width:80px; font-size:medium;" />
						<input class="txt" id="txtComp" type="text" style="width:105px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblProcessno'> </a></td>
					<td>
						<input class="txt" id="txtProcessno" type="text" style="width:80px; font-size:medium;" />
						<input class="txt" id="txtProcess" type="text" style="width:105px; font-size:medium;" />
					</td>
					<td class='seek'><a id='lblStation'>工作線別</a></td>
					<td>
						<input class="txt" id="txtStationno" type="text" style="width:80px; font-size:medium;" />
						<input class="txt" id="txtStation" type="text" style="width:105px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>