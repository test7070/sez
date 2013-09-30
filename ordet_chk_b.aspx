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
			var q_name = 'ordet', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, 
			brwCount2 = 0;
			brwCount = -1;
			var t_sqlname = 'ordet_load'; t_postname = q_name;
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

			}
			
			var maxAbbsCount = 0;
			function refresh() {
				_refresh();
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtOrdeno_' + j).val() == abbs[i].noa && w.$('#txtNo2_' + j).val() == abbs[i].no2) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
						if (abbs[i].issale == 'false' || abbs[i].issale == false) {
							abbs.splice(i, 1);
							i--;
						}
					}
					maxAbbsCount = abbs.length;
				}
				_refresh();
				for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtUno' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
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
		<div id="dbbs" style="overflow: scroll;height:550px;" >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%;">
						<input type="checkbox" id="checkAllCheckbox"/>
					</td>
					<td align="center" style="width:3%;"> </td>
					<td class="td2" align="center" style="width:15%;"><a id='lblUno_s'></a></td>
					<td class="td3" align="center" style="width:15%;"><a id='lblProduct_s'></a></td>
					<td class="td4" align="center" style="width:10%;"><a id='lblProductno_s'></a></td>
					<td class="td5" align="center" style="width:8%;"><a id='lblDime_s'></a></td>
					<td class="td6" align="center" style="width:8%;"><a id='lblWidth_s'></a></td>
					<td class="td7" align="center" style="width:8%;"><a id='lblLengthb_s'></a></td>
					<td class="td8" align="center" style="width:8%;"><a id='lblMount_s'></a></td>
					<td class="td9" align="center" style="width:8%;"><a id='lblWeight_s'></a></td>
					<td class="td10" align="center" style="width:10%;"><a id='lblSource_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center"><input id="chkSel.*" type="checkbox"  /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td class="td2">
						<input class="txt c1" id="txtUno.*" type="text" />
					</td>
					<td class="td3">
						<input class="txt c1" id="txtProduct.*" type="text" />
					</td>
					<td class="td4">
						<input class="txt c1" id="txtProductno.*" type="text" />
					</td>
					<td class="td5">
						<input class="txt c1 num" id="txtDime.*" type="text" />
					</td>
					<td class="td6">
						<input class="txt c1 num" id="txtWidth.*" type="text"  />
					</td>
					<td class="td7">
						<input class="txt c1 num" id="txtLengthb.*" type="text" />
					</td>
					<td class="td8">
						<input class="txt c1 num" id="txtMount.*" type="text" />
					</td>
					<td class="td9">
						<input class="txt c1 num" id="txtWeight.*" type="text" />
					</td>
					<td class="td10">
						<input class="txt c1" id="txtSource.*" type="text" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
