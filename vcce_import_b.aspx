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
			var q_name = 'vcce_import', t_bbsTag = 'tbbs', t_content = " field=uno,ordeno,no2,productno,product,radius,width,dime,lengthb,spec,mount,weight,price,custno,comp,style,size,sprice", afilter = [], bbsKey = ['ordeno'],  as; //, t_where = '';
			var t_sqlname = 'vcce_import'; t_postname = q_name;
			brwCount2 = 0;
			brwCount = -1;

			var isBott = false;  /// 是否已按過 最後一頁
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
			q_desc = 1;
			$(document).ready(function () {
				if (!q_paraChk())
					return;
		
				main();
				setTimeout('parent.$.fn.colorbox.resize({innerHeight : "750px"})', 300);
			});		 /// end ready
		
			function main() {
				if (dataErr)  /// 載入資料錯誤
				{
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				var w = window.parent;
				w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color','red').css('font-size','initial');
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}
		
			function bbsAssign() { 
				_bbsAssign();
			}
		
			function q_gtPost() {  
		
			}
			var maxAbbsCount = 0;
			function refresh() {
				switch (window.parent.q_name) {
					case 'vcce':
						q_gt('vcces', '', 0, 0, 0, "",r_accy);
						break;
					default:
						toReabbs();
						break;
				}
				$('#checkAllCheckbox').click(function(){
					$('input[type=checkbox][id^=chkSel]').each(function(){
						var t_id = $(this).attr('id').split('_')[1];
						if(!emp($('#txtOrdeno_' + t_id).val()) || q_getPara('sys.project').toUpperCase()=='PE')
							$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
					});
				});
				size_change();
			}
			
			function toReabbs(){
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (abbs[i].ordeno.length>0 && w.$('#txtOrdeno_' + j).val() == abbs[i].ordeno && w.$('#txtNo2_' + j).val() == abbs[i].no2) {
								if((w.q_name == 'vcc' || w.q_name=='vcce') && (w.$('#txtNoa').val() != 'AUTO')){
									abbs[i].mount = dec(abbs[i].mount)+dec(w.$('#txtMount_' + j).val());
									abbs[i].weight = dec(abbs[i].weight)+dec(w.$('#txtWeight_' + j).val());
								}
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).prop('checked', true);
							}
						}
						if (abbs[i].mount <= 0 || abbs[i].weight <= 0) {
							abbs.splice(i, 1);
							i--;
						}
					}
					maxAbbsCount = abbs.length;
				}
				abbs.sort(function(a,b){
					var x = (a.sel==true || a.sel=="true"?1:0);
					var y = (b.sel==true || b.sel=="true"?1:0);
					return y-x;
				});
				_refresh();
				size_change();
			}
			
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'vcces' :
						var as = _q_appendData("vcces", "", true);
						if (as[0] != undefined){
							var w = window.parent;
							if (maxAbbsCount < abbs.length) {
								for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
									for (var j = 0; j < as.length; j++) {
										if (abbs[i].ordeno.length>0 && as[j].ordeno == abbs[i].ordeno && as[j].no2 == abbs[i].no2) {
												abbs[i].mount = dec(abbs[i].mount)-dec(as[j].mount);
												abbs[i].weight = dec(abbs[i].weight)-dec(as[j].weight);
										}
									}
									if (abbs[i].mount <= 0 || abbs[i].weight <= 0) {
										abbs.splice(i, 1);
										i--;
									}
								}
							}
						}
						toReabbs();
						break;
				}  /// end switch
			}
			function size_change() {
				var w = window.parent;
				var t_kind = ((w.$('#cmbKind').val())?w.$('#cmbKind').val():'');
				t_kind = t_kind.substr(0, 1);				
				if (t_kind == 'A') {
					$('*[id="sizeTd"]').css('width','208px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).hide();
						$('#txtSpec_'+j).css('width','208px');
						$('#textSize1_' + j).val($('#txtDime_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				} else if (t_kind == 'B') {
					$('*[id="sizeTd"]').css('width','280px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).show();
						$('#textSize2_' + j).show();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).show();
						$('#x1_' + j).show();
						$('#x2_' + j).show();
						$('#x3_' + j).show();
						$('#txtSpec_'+j).css('width','280px');
						$('#textSize1_' + j).val($('#txtRadius_' + j).val());
						$('#textSize2_' + j).val($('#txtWidth_' + j).val());
						$('#textSize3_' + j).val($('#txtDime_' + j).val());
						$('#textSize4_' + j).val($('#txtLengthb_' + j).val());
					}
				} else if (t_kind == 'C'){//鋼筋和鋼胚
					$('*[id="sizeTd"]').css('width','55px');
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textSize1_' + j).hide();
						$('#textSize2_' + j).hide();
						$('#textSize3_' + j).show();
						$('#textSize4_' + j).hide();
						$('#x1_' + j).hide();
						$('#x2_' + j).hide();
						$('#x3_' + j).hide();
						$('#txtSpec_'+j).css('width','55px');
						$('#textSize1_' + j).val(0);
						$('#txtDime_' + j).val(0);
						$('#textSize2_' + j).val(0);
						$('#txtWidth_' + j).val(0);
						$('#textSize3_' + j).val($('#txtLengthb_' + j).val());
						$('#textSize4_' + j).val(0);
						$('#txtRadius_' + j).val(0);
					}
				}
				if(q_getPara('sys.project').toUpperCase()=='PE'){
					$('.pe_hide').hide();
				}
				
			}
	</script>
	<style type="text/css">
		.seek_tr {
			color:white; 
			text-align:center; 
			font-weight:bold;
			BACKGROUND-COLOR: #76a2fe
		}
		input[type="text"], input[type="button"] {
			font-size: medium;
		}
		.txt {
			float:left;
		}
		.c1 {
			width:95%;
		}
		.num {
			text-align: right;
		}
	</style>
</head>
<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
					<tr style='color:White; background:#003366;' >
						<td align="center" style="width:1%;">
							<input type="checkbox" id="checkAllCheckbox"/>
						</td>
						<td align="center"><a id='lblUno'> </a></td>
						<td align="center" style="width:150px;" class="pe_hide"><a id='lblOrdeno'> </a></td>
						<td align="center" style="width:100px;"><a id='lblCustno'> </a></td>
						<td align="center" style="width:80px;"><a id='lblProductno'> </a></td>
						<td align="center" id="sizeTd" ><a id='lblSizea'> </a></td>
						<td align="center" style="width:60px;"><a id='lblMount'> </a></td>
						<td align="center" style="width:80px;"><a id='lblWeight'> </a></td>
						<td align="center" style="width:60px;"><a id='lblPrice'> </a></td>
					</tr>
			</table>
		</div>
		<div  id="dbbs" style="overflow: scroll;height:550px;">
				<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
					<tr style='color:White; background:#003366;display:none;' >
						<td align="center"><input type="checkbox" id="checkAllCheckbox"/> </td>
						<td align="center"><a id='lblUno'> </a></td>
						<td align="center"  class="pe_hide"><a id='lblOrdeno'> </a></td>
						<td align="center"><a id='lblCustno'> </a></td>
						<td align="center"><a id='lblProductno'> </a></td>
						<td align="center"><a id='lblSizea'> </a></td>
						<td align="center"><a id='lblMount'> </a></td>
						<td align="center"><a id='lblWeight'> </a></td>
						<td align="center"><a id='lblPrice'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td style="width:1%;" align="center"><input id="chkSel.*" type="checkbox"/></td>
						<td><input class="txt c1" id="txtUno.*" type="text"/></td>
						<td style="width:150px;"  class="pe_hide">
							<input class="txt" id="txtOrdeno.*" type="text" style="width:65%;"/>
							<input class="txt" id="txtNo2.*" type="text" style="width:25%;"/>
						</td>
						<td style="width:100px;">
							<input class="txt c1" id="txtCustno.*" type="text"/>
							<input class="txt c1" id="txtComp.*" type="text"/>
						</td>
						<td style="width:80px;">
							<input class="txt c1" id="txtProductno.*" type="text"/>
							<input class="txt c1" id="txtProduct.*" type="text"/>
						</td>
						<td id="sizeTd">
							<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
							<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;" >
								x
							</div>
							<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
							<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">
								x
							</div>
							<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
							<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">
								x
							</div>
							<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
							<!--上為虛擬下為實際-->
							<input id="txtRadius.*" type="text" style="display:none;"/>
							<input id="txtWidth.*" type="text" style="display:none;"/>
							<input id="txtDime.*" type="text" style="display:none;"/>
							<input id="txtLengthb.*" type="text" style="display:none;"/>
							<input id="txtSpec.*" type="text" style="float:left;"/>
						</td>
						<td style="width:60px;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
						<td style="width:80px;"><input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/></td>
						<td style="width:60px;">
							<input class="txt" id="txtPrice.*" type="text" style="width:96%; text-align:right;"/>
							<input class="txt" id="txtSprice.*" type="text" style="width:96%; text-align:right;display: none;"/>
						</td>
					</tr>
				</table>
		 </div>
		  <!--#include file="../inc/pop_ctrl.inc"--> 
</body>
</html>
