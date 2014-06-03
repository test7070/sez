<!DOCTYPE html>
<html>
	<head>
		<title></title>
		<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'usecrd', t_bbsTag = 'tbbs', t_content = " field=noa,noq,creditno,namea,basev,mul,refv,credit,worker", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
			var t_sqlname = 'usecrd_load';
			t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var q_readonly = [];
			var q_readonlys = ['txtCreditno','txtNamea','txtCredit','txtWorker','txtBasev','txtMul'];
			var bbmNum = [];
			var bbsNum = [['txtRefv',15,2,1],['txtCredit',15,2,1],['txtBasev',15,2,1],['txtMul',15,2,1]];
			var bbmMask = [];
			var bbsMask = [];
			brwCount = -1;
			brwCount2 = 0;
			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (!q_paraChk())
					return;
				main();
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname);
				parent.$.fn.colorbox.resize({
					height : "650px"
				});
				q_mask(bbmMask);
			}
			function q_gtPost(t_name) {
				switch(t_name){
					case 'GetCredit':
						var as = _q_appendData('credit', "", true);
						//先清空BBS
						for(var k=0;k<q_bbsCount;k++){
							$('#btnMinus_'+k).click();
						}
						as = as.sort(function(a,b){return dec(a.noa)-dec(b.noa);})
						//匯入Credit的資料
						var ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtCreditno,txtNamea,txtBasev,txtMul', as.length, as, 'noa,namea,basev,mul', 'txtCreditno');
						//更新金額/數量 額度 作業人員 單位值 權值
						if(abbs.length > 0){
							for(var k=0;k<abbs.length;k++){
								var thisCreditno = $.trim(abbs[k].creditno);
								for(var j=0;j<q_bbsCount;j++){
									var bbsCreditno = $.trim($('#txtCreditno_'+j).val());
									if(thisCreditno==bbsCreditno){
										$('#txtRefv_'+j).val(abbs[k].refv);
										$('#txtCredit_'+j).val(abbs[k].credit);
										$('#txtBasev_'+j).val(abbs[k].basev);
										$('#txtMul_'+j).val(abbs[k].mul);
										$('#txtWorker_'+j).val(abbs[k].worker);
										break;
									}
								}
							}
						}
						brwCount = as.length;
						if(q_cur==0 || q_cur==4){
							_readonlys(true);
						}
						break;
				}
			}

			function bbsAssign() {
				for(var k=0;k<q_bbsCount;k++){
					$('#txtRefv_'+k).change(function(){
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
						var t_refv=0,t_basev=0,t_mul=0,t_credit=0;
						t_refv = dec($('#txtRefv_'+n).val());
						t_basev = dec($('#txtBasev_'+n).val());
						t_mul = dec($('#txtMul_'+n).val());
						t_credit = q_mul(q_div(t_refv,(t_basev==0?1:t_basev)),t_mul);
						$('#txtCredit_'+n).val(t_credit);
						$('#txtWorker_'+n).val(r_name);
					});
				}
				_bbsAssign();
			}

			function btnOk() {
				sum();
				t_key = q_getHref();
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['creditno']) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
			}

			function refresh() {
				_refresh();
				q_gt('credit', '', 0, 0, 0, "GetCredit", r_accy);
			}

			function sum() {
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
		</script>
		<style type="text/css">
			.num{
				text-align:right;
			}
			.c1{
				float:left;
				width:95%;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<div id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:36px;display:none;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:80px;"><a id='lblCreditno'></a></td>
					<td align="center" style="width:250px;"><a id='lblNamea'></a></td>
					<td align="center" style="width:100px;"><a id='lblRefv'></a></td>
					<td align="center" style="width:100px;"><a id='lblCredit'></a></td>
					<td align="center" style="width:80px;"><a id='lblWorker'></a></td>
					<td align="center" style="width:100px;"><a id='lblBasev'></a></td>
					<td align="center" style="width:100px;"><a id='lblMul'></a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;">
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%' >
				<tr style="display:none;">
					<td align="center" style="width:36px;display:none;">
						<input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" />
					</td>
					<td align="center" style="width:80px;"><a id='lblCreditno'></a></td>
					<td align="center" style="width:250px;"><a id='lblNamea'></a></td>
					<td align="center" style="width:100px;"><a id='lblRefv'></a></td>
					<td align="center" style="width:100px;"><a id='lblCredit'></a></td>
					<td align="center" style="width:80px;"><a id='lblWorker'></a></td>
					<td align="center" style="width:100px;"><a id='lblBasev'></a></td>
					<td align="center" style="width:100px;"><a id='lblMul'></a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center" style="display:none;width:36px;">
						<input class="btn" id="btnMinus.*" type="button" value='-' style="font-weight: bold; " />
						<input class="txt c1" id="txtNoa.*" type="hidden" />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td style="width:80px;"><input id="txtCreditno.*" type="text" class="c1" /></td>
					<td style="width:250px;"><input id="txtNamea.*" type="text" class="c1" /></td>
					<td style="width:100px;"><input id="txtRefv.*" type="text" class="c1 num" /></td>
					<td style="width:100px;"><input id="txtCredit.*" type="text" class="c1 num" /></td>
					<td style="width:80px;"><input id="txtWorker.*" type="text" class="c1" /></td>
					<td style="width:100px;"><input id="txtBasev.*" type="text" class="c1 num" /></td>
					<td style="width:100px;"><input id="txtMul.*" type="text" class="c1 num" /></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_modi.inc"-->
		<input id="q_sys" type="hidden" />
	</body>
</html>
