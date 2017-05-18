<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		
			var q_name = 'saladjust', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
			var t_sqlname = 'saladjust_load'; t_postname = q_name;
			var isBott = false;  /// 是否已按過 最後一頁
			var afield, t_htm;
			var i, s1;
			var decbbs = ['money', 'bo_admin', 'bo_traffic', 'bo_full', 'bo_special', 'bo_oth', 'salary','meals'];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [
				['txtMoney',10,0,1],['txtBo_admin',10,0,1],['txtBo_traffic',10,0,1],['txtBo_special',10,0,1],['txtBo_oth',10,0,1],['txtBo_full',10,0,1],['txtSalary',10,0,1],['txtMeals',10,0,1]
				,['txtSa_labor',10,0,1],['txtLa_comp',10,0,1],['txtLa_person',10,0,1],['txtAs_labor',10,0,1]
				,['txtSa_health',10,0,1],['txtHe_comp',10,0,1],['txtHe_person',10,0,1],['txtAs_health',10,0,1],['txtHplus2',10,0,1]
				,['txtSa_retire',10,0,1],['txtRe_rate',10,2,1],['txtRe_comp',10,0,1],['txtRe_person',10,0,1]
				,['txtTax',10,0,1],['txtMount',10,0,1]
			];
			var bbmMask = [];
			var bbsMask = [];
			aPop = new Array(['txtJobno_', 'txtJobno_', 'salm', 'noa,job,level1', 'txtJobno_,txtJob_,txtLevel1_','salm_b.aspx']);
			$(document).ready(function () {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (location.href.indexOf('?') < 0)   // debug
				{
					location.href = location.href + "?;;;noa='0015'";
					return;
				}
				if (!q_paraChk())
					return;
				
				main();
			});            /// end ready

			function main() {
				if (dataErr)  /// 載入資料錯誤
				{
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname);
			}

			function mainPost() {
				q_getFormat();
				if (q_getPara('sys.project').toUpperCase()=='VU'){
					bbsNum = [['txtMoney',10,0,1],['txtBo_admin',10,0,1],['txtBo_traffic',10,0,1],['txtBo_special',10,0,1],['txtBo_oth',10,0,1],['txtBo_full',10,0,1],['txtSalary',10,0,1],['txtMeals',10,0,1],['txtBo_money1',10,3,1]];
				}
				
				bbsMask = [['txtDatea', r_picd]];
				q_mask(bbsMask);
				
				q_gt('class5', "where=^^ 1=1 ^^", 0, 0, 0, "",r_accy,1);
				var tclass5 = _q_appendData("class5", "", true);
				if (tclass5[0] != undefined) {
					var t_item = "";
					for ( i = 0; i < tclass5.length; i++) {
						t_item = t_item + (t_item.length > 0 ? ',' : '') + tclass5[i].noa + '@' + tclass5[i].namea;
					}
					q_cmbParse("combClass5", t_item,'s');
				}
				
				var no_auth=true;
				
				for(var i = 0; i < q_auth.length; i++) {
					var t_modi= (q_auth[i].substr(q_auth[i].indexOf(',')+1,5)).substr(4,1);
					
					if(q_auth[i].substr(0,q_auth[i].indexOf(','))=='saladjust'&&t_modi=='1'){
						no_auth=false;
						break;
					}
				}
				
				if(r_rank<8 && no_auth)
					$('#btnModi').hide();
			}

			function bbsAssign() {  /// 表身運算式
				for(var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtDatea_'+j).blur(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(b_seq>=0&&!emp($('#txtDatea_'+b_seq).val())){
								if(!emp($('#txtDatea_'+(b_seq-1)).val())){
									if(emp($('#txtJobno_'+b_seq).val())){
										$('#txtJobno_'+b_seq).val($('#txtJobno_'+(b_seq-1)).val());
									}
									if(emp($('#txtJob_'+b_seq).val())){
										$('#txtJob_'+b_seq).val($('#txtJob_'+(b_seq-1)).val());
									}
									if(emp($('#txtLevel1_'+b_seq).val())){
										$('#txtLevel1_'+b_seq).val($('#txtLevel1_'+(b_seq-1)).val());
									}
									if(emp($('#txtLevel2_'+b_seq).val())){
										$('#txtLevel2_'+b_seq).val($('#txtLevel2_'+(b_seq-1)).val());
									}
									if(emp($('#txtMoney_'+b_seq).val())){
										$('#txtMoney_'+b_seq).val($('#txtMoney_'+(b_seq-1)).val());
									}
									if(emp($('#txtBo_admin_'+b_seq).val())){
										$('#txtBo_admin_'+b_seq).val($('#txtBo_admin_'+(b_seq-1)).val());
									}
									if(emp($('#txtBo_traffic_'+b_seq).val())){
										$('#txtBo_traffic_'+b_seq).val($('#txtBo_traffic_'+(b_seq-1)).val());
									}
									if(emp($('#txtBo_special_'+b_seq).val())){
										$('#txtBo_special_'+b_seq).val($('#txtBo_special_'+(b_seq-1)).val());
									}
									if(emp($('#txtBo_oth_'+b_seq).val())){
										$('#txtBo_oth_'+b_seq).val($('#txtBo_oth_'+(b_seq-1)).val());
									}
									if(emp($('#txtBo_full_'+b_seq).val())){
										$('#txtBo_full_'+b_seq).val($('#txtBo_full_'+(b_seq-1)).val());
									}
									if(emp($('#txtSalary_'+b_seq).val())){
										$('#txtSalary_'+b_seq).val($('#txtSalary_'+(b_seq-1)).val());
									}
								}
							}
						});
						
						$('#txtLevel2_'+j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_where = "where=^^ noa='"+$('#txtLevel1_'+b_seq).val()+"' ^^";
							q_gt('salrank', t_where , 0, 0, 0, "", r_accy);
						});
						
						$('#txtMoney_'+j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtSalary_'+b_seq,q_float('txtMoney_'+b_seq)+q_float('txtBo_admin_'+b_seq)+q_float('txtBo_traffic_'+b_seq)+q_float('txtBo_special_'+b_seq)+q_float('txtBo_oth_'+b_seq)+q_float('txtBo_full_'+b_seq));
						});
						
						$('#txtBo_admin_'+j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtSalary_'+b_seq,q_float('txtMoney_'+b_seq)+q_float('txtBo_admin_'+b_seq)+q_float('txtBo_traffic_'+b_seq)+q_float('txtBo_special_'+b_seq)+q_float('txtBo_oth_'+b_seq)+q_float('txtBo_full_'+b_seq));
						});
						
						$('#txtBo_traffic_'+j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtSalary_'+b_seq,q_float('txtMoney_'+b_seq)+q_float('txtBo_admin_'+b_seq)+q_float('txtBo_traffic_'+b_seq)+q_float('txtBo_special_'+b_seq)+q_float('txtBo_oth_'+b_seq)+q_float('txtBo_full_'+b_seq));
						});
						
						$('#txtBo_special_'+j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtSalary_'+b_seq,q_float('txtMoney_'+b_seq)+q_float('txtBo_admin_'+b_seq)+q_float('txtBo_traffic_'+b_seq)+q_float('txtBo_special_'+b_seq)+q_float('txtBo_oth_'+b_seq)+q_float('txtBo_full_'+b_seq));
						});
						
						$('#txtBo_oth_'+j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtSalary_'+b_seq,q_float('txtMoney_'+b_seq)+q_float('txtBo_admin_'+b_seq)+q_float('txtBo_traffic_'+b_seq)+q_float('txtBo_special_'+b_seq)+q_float('txtBo_oth_'+b_seq)+q_float('txtBo_full_'+b_seq));
						});
						
						$('#txtBo_full_'+j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtSalary_'+b_seq,q_float('txtMoney_'+b_seq)+q_float('txtBo_admin_'+b_seq)+q_float('txtBo_traffic_'+b_seq)+q_float('txtBo_special_'+b_seq)+q_float('txtBo_oth_'+b_seq)+q_float('txtBo_full_'+b_seq));
						});
					}
				}
				_bbsAssign();
				$('.vu').hide();
				if (q_getPara('sys.project').toUpperCase()=='DJ'){
					$('#lblMoney').text('底薪');
		            $('#lblBo_admin').text('責任加給');
		            $('#lblBo_special').text('技術加給');
		            $('#lblBo_full').text('全勤獎金');
	           }
	           if (q_getPara('sys.project').toUpperCase()=='VU'){
	            	$('#lblMoney').text('底薪');
	            	$('#lblBo_admin').text('銷貨獎金');
	            	$('#lblBo_traffic').text('裁剪噸數獎金');
	            	$('#lblBo_special').text('績效獎金');
	            	$('#lblBo_oth').text('其他津貼');
	            	$('#lblBo_full').text('全勤獎金');
	            	$('#lblBo_money1').text('獎金基數');
	            	$('.vu').show();
	            	$('.vuhide').hide();
	            }
	            
	            var t_proj='DC,SF,VU,DJ,RB,XY,FE,IT,ST2,AMD,RK,TN'.split(',');
	            for(var i = 0; i < t_proj.length; i++) {
	            	if (q_getPara('sys.project').toUpperCase()==t_proj[i]){
		            	$('.labor').hide();	
		            	$('#dbbs').css('width','1280px');
		            	break;
		            }
	            }
			}
			
			function btnOk() {
				sum();
				
				for(var j = 0; j < q_bbsCount; j++) {
					if($('#combClass5_'+j).val()!=null)
                		$('#txtClass5_'+j).val($('#combClass5_'+j).val().toString());
                	else
                		$('#txtClass5_'+j).val('');
				}
				
				t_key = q_getHref();
				
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['datea'] ) {  // Dont Save Condition
					as[bbsKey[0]] = '';   /// noa  empty --> dont save
					return;
				}

				q_getId2('', as);  // write keys to as
				
				return true;

			}

			function btnModi() {
				var t_key = q_getHref();
				
				if (!t_key)
					return;
				
				_btnModi();
				
				/*for (i = 0; i < abbsDele.length; i++) {
					abbsDele[i][bbsKey[0]] = t_key[1];
				}*/
				/*if(emp($('#txtDatea_0').val()))
					$('#txtDatea_0').val(q_date());
				$('#txtJobno_0').focus();*/
			}

			function boxStore() {
			
			}
			
			function refresh() {
				_refresh();
				for(var j = 0; j < q_bbsCount; j++) {
					$('#combClass5_'+j).val($('#txtClass5_'+j).val().split(','));
				}
			}
			
			function sum() { }
			
			var salrank=[];
			var salranks=[];
			function q_gtPost(t_postname) {  /// 資料下載後 ...
				switch (t_postname) {
					case 'salrank':
					salrank = _q_appendData("salrank", "", true);
					if(salrank[0]!=undefined){
						q_tr('txtBo_admin_'+b_seq,salrank[0].bo_admin);
						q_tr('txtBo_traffic_'+b_seq,salrank[0].bo_traffic);
						q_tr('txtBo_special_'+b_seq,salrank[0].bo_special);
						q_tr('txtBo_oth_'+b_seq,salrank[0].bo_oth);
						q_tr('txtBo_full_'+b_seq,salrank[0].bo_full);
						q_tr('txtMoney_'+b_seq,salrank[0].money);
						salranks = _q_appendData("salranks", "", true);
						if(salranks[0]!=undefined)
							q_tr('txtSalary_'+b_seq,salranks[dec($('#txtLevel2_'+b_seq).val())-1].money);
					}
					break;
				}  /// end switch
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					for(var j = 0; j < q_bbsCount; j++) {
						$('#combClass5_'+j).attr('disabled','disabled');
					}
				}else{
					for(var j = 0; j < q_bbsCount; j++) {
						$('#combClass5_'+j).removeAttr('disabled');
					}
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();  /// 表身運算式
			}

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            .tbbs {
                font-size: 12pt;
                color: blue;
                text-align: left;
                border: 1px #DDDDDD solid;
                width: 100%;
                height: 100%;
            }
            .txt.c1 {
                width: 95%;
            }
            .td1 {
                width: 2%;
            }
            .td2 {
                width: 4%;
            }
            .td3 {
                width: 5%;
            }
            .td4 {
                width: 7%;
            }
            .txt.num {
                text-align: right;
            }

		</style>
	</head>
	<body>
		<div id="dbbs" style="width:2480px;">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<!--<td align="center" class="td1"><a id='lblNoa'></a></td>-->
					<td align="center" style="width: 80px;"><a id='lblDatea'> </a></td>
					<td align="center" style="width: 80px;"><a id='lblJobno'> </a></td>
					<td align="center" style="width: 100px;"><a id='lblJob'> </a></td>
					<td align="center" style="width: 40px;"><a id='lblLevel1'> </a></td>
					<td align="center" style="width: 40px;"><a id='lblLevel2'> </a></td>
					<!--<td align="center" class="td1"><a id='lblLevel3'></a></td>-->
					<td align="center" style="width: 80px;"><a id='lblMoney'> </a></td>
					<td align="center" style="width: 80px;" class="vu"><a id='lblBo_money1'> </a></td>
					<td align="center" style="width: 80px;"><a id='lblBo_admin'> </a></td>
					<td align="center" style="width: 80px;"><a id='lblBo_traffic'> </a></td>
					<td align="center" style="width: 80px;"><a id='lblBo_special'> </a></td>
					<td align="center" style="width: 80px;"><a id='lblBo_oth'> </a></td>
					<td align="center" style="width: 80px;"><a id='lblBo_full'> </a></td>
					<td align="center" style="width: 80px;"><a id='lblSalary'> </a></td>
					<td align="center" style="width: 80px;"><a id='lblMeals'> </a></td>
					<td align="center" style="width: 80px;" class="vuhide"><a id='lblClass5'> </a></td>
					<!--106/05/17 全部客戶開始使用 除非有買勞健保系統才不會抓這裡資料-->
					<td align="center" style="width: 80px;" class="labor"><a id='lblSa_labor'>勞保投保薪資</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblLa_comp'>勞保公司負擔</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblLa_person'>勞保自付額</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblAs_labor'>勞保輔助</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblSa_health'>健保投保薪資</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblHe_comp'>健保公司負擔</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblHe_person'>健保自付額</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblAs_health'>健保輔助</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblHplus2'>二代健保補價</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblSa_retire'>勞退提繳薪資</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblRe_rate'>勞退提繳率(%)</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblRe_comp'>勞退公司提繳</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblRe_person'>勞退個人提繳</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblTax'>所得稅</a></td>
					<td align="center" style="width: 80px;" class="labor"><a id='lblMount'>扶養人數</a></td>
					<!------------------------------------------------------------->
					<td align="center" style="width: 100px;"><a id='lblMemo'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  /></td>
					<td >
						<input class="txt c1"  id="txtDatea.*" type="text"  />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  />
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td ><input class="txt c1" id="txtJobno.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtJob.*" type="text"  /></td>
					<td ><input class="txt c1" id="txtLevel1.*" type="text" /></td>
					<td ><input class="txt c1" id="txtLevel2.*" type="text" /></td>
					<!--<td ><input class="txt c1" id="txtLevel3.*" type="text" /></td>-->
					<td ><input class="txt num c1" id="txtMoney.*" type="text" /></td>
					<td class="vu"><input class="txt num c1" id="txtBo_money1.*" type="text"/></td>
					<td ><input class="txt num c1" id="txtBo_admin.*" type="text"/></td>
					<td ><input class="txt num c1" id="txtBo_traffic.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtBo_special.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtBo_oth.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtBo_full.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtSalary.*" type="text" /></td>
					<td ><input class="txt num c1" id="txtMeals.*" type="text" /></td>
					<td class="vuhide">
						<select id="combClass5.*" class="txt c1" multiple="multiple" size="3"> </select>
						<input class="txt c1" id="txtClass5.*" type="hidden" />
					</td>
					<!--106/05/17------------------------------------------------------>
					<td class="labor"><input class="txt num c1" id="txtSa_labor.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtLa_comp.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtLa_person.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtAs_labor.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtSa_health.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtHe_comp.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtHe_person.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtAs_health.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtHplus2.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtSa_retire.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtRe_rate.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtRe_comp.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtRe_person.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtTax.*" type="text" /></td>
					<td class="labor"><input class="txt num c1" id="txtMount.*" type="text" /></td>
					<!------------------------------------------------------------->
					<td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
