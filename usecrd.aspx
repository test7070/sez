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
			function sum(){
				var t_credit = 0;
				for(var i=0;i<q_bbsCount;i++){
					t_credit += q_float('txtCredit_'+i);		
				}
				$('#txtA1').val(t_credit);
				$('#txtA5').val(q_float('txtA1')-q_float('txtA2')-q_float('txtA3')-q_float('txtA4'));
			}
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
				
				if (window.parent.q_name == 'cust') {
                    var wParent = window.parent.document;
                    q_func('qtxt.query.credit', 'credit.txt,fe,'+ encodeURI(wParent.getElementById("txtNoa").value) + ';non');
                }
			}
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.credit':
                        var as = _q_appendData("tmp0", "", true, true);                     
                        if(as[0]!=undefined){
                            var credit = parseFloat(as[0].credit.length==0?"0":as[0].credit);
                            var orde = parseFloat(as[0].orde.length==0?"0":as[0].orde);
						 	var ordetax = parseFloat(as[0].ordetax.length==0?"0":as[0].ordetax);
						 	var vcctotal = parseFloat(as[0].vcctotal.length==0?"0":as[0].vcctotal);
						 	var vcca = parseFloat(as[0].vcca.length==0?"0":as[0].vcca);
						 	var gqb = parseFloat(as[0].gqb.length==0?"0":as[0].gqb);
						 	var umm = parseFloat(as[0].umm.length==0?"0":as[0].umm);
						 	var total = parseFloat(as[0].total.length==0?"0":as[0].total);
						 	
                            var curorde = 0;
                            var curtotal = 0;
                          	
                          	$('#txtA1').val(credit);
                          	$('#txtA2').val(orde+ordetax);
                          	$('#txtA3').val(vcctotal+vcca-umm);
                          	$('#txtA4').val(gqb);
                          	$('#txtA5').val(total);  
                        }
                        break;
                }
            }

			function q_gtPost(t_name) {
				switch(t_name){
					case 'nhpe':
						var as = _q_appendData('nhpe', "", true);
						if (as[0] != undefined) {
							//記錄 額度  以更新畫面資料(cust.aspx)
							t_credit = 0;
							for(var i=0;i<q_bbsCount;i++){
								t_credit = q_add(t_credit,q_float('txtCredit_'+i));
							}
							x_credit = 0;
							try{
								x_credit = parseFloat(as[0].credit);
							}catch(e){
								x_credit = 0;
							}
							if(x_credit>=t_credit){
								if (window.parent.q_name == 'cust') {
				                    var wParent = window.parent.document;
				                    wParent.getElementById("txtCredit").value = t_credit;
				                    window.parent.abbm[window.parent.q_recno] = t_credit;
				                }
								t_key = q_getHref();
								_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
							}else{
								alert('額度不足，禁止修改。');
								return;
							}
						}else{
							alert('額度不足，禁止修改。');
							return;
						}
						break;
					case 'GetCredit':
						var as = _q_appendData('credit', "", true);
						//先清空BBS
						for(var k=0;k<q_bbsCount;k++){
							$('#btnMinus_'+k).click();
						}
						//as = as.sort(function(a,b){return dec(a.noa)-dec(b.noa);})
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
						sum();
						break;
				}
			}

			function bbsAssign() {
				for(var k=0;k<q_bbsCount;k++){
					$('#txtRefv_'+k).change(function(){
						var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
						var t_refv=0,t_basev=0,t_mul=0,t_credit=0;
						t_refv = dec($('#txtRefv_'+n).val());
						t_basev = dec($('#txtBasev_'+n).val());
						t_mul = dec($('#txtMul_'+n).val());
						t_credit = q_mul(q_div(t_refv,(t_basev==0?1:t_basev)),t_mul);
						$('#txtCredit_'+n).val(t_credit);
						$('#txtWorker_'+n).val(r_name);
						sum();
					});
				}
				_bbsAssign();
			}

			function btnOk() {
				sum();
				q_gt('nhpe', "where=^^ noa='"+r_userno+"'^^", 0, 0, 0, "nhpe");
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
					<td align="center" style="width:100px;"><a id='lblMemo'>歷史記錄</a></td>
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
					<td align="center" style="width:100px;"><a id='lblMemo'></a></td>
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
					<td style="width:100px;"><input id="txtMemo.*" type="text" class="c1 num" /></td>
				</tr>
			</table>
		</div>
		<div>
			<a style="float:left;">額度 </a>
			<input id="txtA1" type="text" style="float:left;width:120px;color:green;" readonly="readonly"/>
			<a style="float:left;">-未出訂單  </a>
			<input id="txtA2" type="text" style="float:left;width:120px;color:green;" readonly="readonly"/>
			<a style="float:left;">-應收貨款 </a>
			<input id="txtA3" type="text" style="float:left;width:120px;color:green;" readonly="readonly"/>
			<a style="float:left;">-應收票據  </a>
			<input id="txtA4" type="text" style="float:left;width:120px;color:green;" readonly="readonly"/>
			<a style="float:left;">=可用額度 </a>
			<input id="txtA5" type="text" style="float:left;width:120px;color:green;" readonly="readonly"/>
		</div>
		<!--#include file="../inc/pop_modi.inc"-->
		
		<input id="q_sys" type="hidden" />
	</body>
</html>
