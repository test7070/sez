<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'view_ordet', t_bbsTag = 'tbbs', t_content = " field=accy,noa,no2,productno,product,unit,ordmount,ordweight,mount,weight,memo,uno,noq,source,no3,issale,radius,dime,width,lengthb,custno,enda,kind", afilter = [], bbsKey = [], t_count = 0, as, 
			brwCount2 = 0;
			brwCount = -1;
			var t_sqlname = 'view_ordet_load'; t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			$(document).ready(function () {
				bbmKey = [];
				bbsKey = ['noa', 'no2'];
				if (location.href.indexOf('?') < 0){
					location.href = location.href + "?;;;noa='0015'";
					return;
				}
				if (!q_paraChk())
					return;
				main();
			});			/// end ready
		
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}
			
			function mainPost() {
				q_getFormat();
				bbsMask = [];
				q_mask(bbsMask);
			}
		
			function bbsAssign() {
				_bbsAssign();
			}

			function q_gtPost(t_name) {
				switch(t_name){
					case 'vccs':
						var as = _q_appendData("vccs", "", true);
						if(as[0]!=undefined && abbs[0]!=undefined){
							for(var i=0;i<as.length;i++){
								for(var j=0;j<abbs.length;j++){
									if(abbs[j].noa == as[i].ordeno && abbs[j].no2 == as[i].no2 && (abbs[j].uno == as[i].uno)){
										abbs[j].mount=dec(abbs[j].mount)-dec(as[i].mount);
										abbs[j].weight=dec(abbs[j].weight)-dec(as[i].weight);
									}
								}
							}
						}
						DoDefault();
						break;
					case 'vcces':
						var as = _q_appendData("vcces", "", true);
						if(as[0]!=undefined && abbs[0]!=undefined){
							for(var i=0;i<as.length;i++){
								for(var j=0;j<abbs.length;j++){
									if(abbs[j].noa == as[i].ordeno && abbs[j].no2 == as[i].no2){
										abbs[j].mount=dec(abbs[j].mount)-dec(as[i].mount);
										abbs[j].weight=dec(abbs[j].weight)-dec(as[i].weight);
									}
								}
							}
						}
						DoDefault();
						break;
				}
			}
			
			var maxAbbsCount = 0;
			function refresh() {
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtOrdeno_' + j).val() == abbs[i].noa) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
						if (abbs[i].issale == 'false' || abbs[i].issale == false || abbs[i].enda == 'true' || abbs[i].enda == true) {
							abbs.splice(i, 1);
							i--;
						}
					}
					maxAbbsCount = abbs.length;
				}
				Lock(1,{opacity:0});
				switch(w.q_name.toLowerCase()){
					case 'vcc' :
						var t_where = "where=^^ 1=1 ^^";
						q_gt('vccs', t_where , 0, 0, 0, "", r_accy);
						break;
					case 'vcce' :
						var t_where = "where=^^ 1=1 ^^";
						q_gt('vcces', t_where , 0, 0, 0, "", r_accy);
						break; 
					default:
						DoDefault();
						break;
				}
			}
			
			function DoDefault(){
				for(var i=0;i<abbs.length;i++){
					if (abbs[i].mount <=0 || abbs[i].weight <=0) {
							abbs.splice(i, 1);
							i--;
					}
				}
				_refresh();
				for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtUno_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
				size_change();
				Unlock(1);
			}
			function size_change(){
				var w = window.parent;
				if(w && w.$('#cmbKind').val()){
					var SelectrdVal = (w.$('#cmbKind').val()).toUpperCase().substring(0,1);
					switch(SelectrdVal){
						case 'A':
							$('*[id="lblSize_help"]').text(q_getPara('sys.lblSizea'));
							for (var j = 0; j < q_bbsCount; j++) {
								$('#textSize1_' + j).show();
								$('#textSize2_' + j).show();
								$('#textSize3_' + j).show();
								$('#textSize4_' + j).hide();
								$('#x1_' + j).show();
								$('#x2_' + j).show();
								$('#x3_' + j).hide();
								$('*[id="Size"]').css('width', '230px');
								$('#textSize1_' + j).val($('#txtDime_' + j).val());
								$('#textSize2_' + j).val($('#txtWidth_' + j).val());
								$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
								$('#textSize4_' + j).val(0);
								$('#txtRadius_' + j).val(0);
							}
							break;
						case 'B':
							$('*[id="lblSize_help"]').text(q_getPara('sys.lblSizeb'));
							for (var j = 0; j < q_bbsCount; j++) {
								$('#textSize1_' + j).show();
								$('#textSize2_' + j).show();
								$('#textSize3_' + j).show();
								$('#textSize4_' + j).show();
								$('#x1_' + j).show();
								$('#x2_' + j).show();
								$('#x3_' + j).show();
								$('*[id="Size"]').css('width', '313px');
								$('#textSize1_' + j).val($('#txtRadius_' + j).val());
								$('#textSize2_' + j).val($('#txtWidth_' + j).val());
								$('#textSize3_' + j).val($('#txtDime_' + j).val());
								$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
							}
							break;
						default:
							$('*[id="lblSize_help"]').text(q_getPara('sys.lblSizec'));
							for (var j = 0; j < q_bbsCount; j++) {
								$('#textSize1_' + j).hide();
								$('#textSize2_' + j).hide();
								$('#textSize3_' + j).show();
								$('#textSize4_' + j).hide();
								$('#x1_' + j).hide();
								$('#x2_' + j).hide();
								$('#x3_' + j).hide();
								$('*[id="Size"]').css('width', '55px');
								$('#textSize1_' + j).val(0);
								$('#txtDime_' + j).val(0);
								$('#textSize2_' + j).val(0);
								$('#txtWidth_' + j).val(0);
								$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
								$('#textSize4_' + j).val(0);
								$('#txtRadius_' + j).val(0);
							}
							break;
					}
				}
			}
			
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}
		</script>
		<style type="text/css">
			td a {
				font-size: medium;
			}
			input[type="text"] {
				font-size: medium;
			}
			.c1{
				width:95%;
			}
			.num {
				text-align:right;
			}
		</style>
	</head>
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%;"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:3%;"> </td>
					<td class="td2" align="center"><a id='lblUno_s'></a></td>
					<td class="td3" align="center" style="width:15%;"><a id='lblProduct_s'></a></td>
					<td class="td4" align="center" style="width:10%;"><a id='lblProductno_s'></a></td>
					<td class="td5" id='Size' align="center"><a id='lblSize_help'></a></td>
					<td class="td8" align="center" style="width:8%;"><a id='lblMount_s'></a></td>
					<td class="td9" align="center" style="width:8%;"><a id='lblWeight_s'></a></td>
					<td class="td10" align="center" style="width:10%;"><a id='lblSource_s'></a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:550px;" >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;display:none;' >
					<td class="td1" align="center" style="width:1%;">
						<input type="checkbox" id="checkAllCheckbox"/>
					</td>
					<td align="center" style="width:3%;"> </td>
					<td class="td2" align="center" ><a id='lblUno_s'></a></td>
					<td class="td3" align="center" style="width:15%;"><a id='lblProduct_s'></a></td>
					<td class="td4" align="center" style="width:10%;"><a id='lblProductno_s'></a></td>
					<td class="td5" id='Size' align="center"><a id='lblSize_help'></a></td>
					<td class="td8" align="center" style="width:8%;"><a id='lblMount_s'></a></td>
					<td class="td9" align="center" style="width:8%;"><a id='lblWeight_s'></a></td>
					<td class="td10" align="center" style="width:10%;"><a id='lblSource_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center" style="width:1%;"><input id="chkSel.*" type="checkbox"  /></td>
					<td style="width:3%;">
						<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
					</td>
					<td class="td2">
						<input class="txt c1" id="txtUno.*" type="text" />
					</td>
					<td class="td3" style="width:15%;">
						<input class="txt c1" id="txtProduct.*" type="text" />
					</td>
					<td class="td4" style="width:10%;">
						<input class="txt c1" id="txtProductno.*" type="text" />
					</td>
					<td class="td5" id='Size'>
						<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >x</div>
						<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
						<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="text" style="display:none;"/>
						<input id="txtWidth.*" type="text" style="display:none;"/>
						<input id="txtDime.*" type="text" style="display:none;"/>
						<input id="txtLengthb.*" type="text" style="display:none;"/>
					</td>
					<td class="td8" style="width:8%;">
						<input class="txt c1 num" id="txtMount.*" type="text" />
					</td>
					<td class="td9" style="width:8%;">
						<input class="txt c1 num" id="txtWeight.*" type="text" />
					</td>
					<td class="td10" style="width:10%;">
						<input class="txt c1" id="txtSource.*" type="text" />
					</td>
				</tr>
			</table>
		</div>
			<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>