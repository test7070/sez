<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'cubu', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
			var t_sqlname = 'cubu';
			t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var decbbs = [];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [['txtIndate',r_picd]];
			var Parent = window.parent;
			var cubBBsArray = '';
			var cubBBtArray = '';
			if(Parent.q_name && Parent.q_name== 'cub'){
				cubBBsArray = Parent.abbsNow;
				cubBBtArray = Parent.abbtNow;
			}
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
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
			}

			function mainPost() {
				bbmMask = [];
				bbsMask = [['txtIndate',r_picd]];
				q_mask(bbmMask);
			}

			function bbsAssign() {
				_bbsAssign();
				for(var j = 0;j<q_bbsCount;j++){
					if(Parent.q_name && Parent.q_name== 'cub'){
						$('#txtUno_'+j).change(function(){
							var thisuno = trim($(this).val());
							if(cubBBtArray[dec(thisuno)-1] != undefined){
								var temp_bbt = cubBBtArray[dec(thisuno)-1];
								t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$(this).val(getNewUno(temp_bbt.uno));
								$('#txtProductno_' + b_seq).val(temp_bbt.productno);
								$('#txtDime_' + b_seq).val(temp_bbt.dime);
							}
						});
						$('#txtOrdeno_'+j).change(function(){
							var thisordeno = trim($(this).val());
							if(cubBBsArray[dec(thisordeno)-1] != undefined){
								var temp_bbs = cubBBsArray[dec(thisordeno)-1];
								t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$(this).val(temp_bbs.ordeno);
								$('#txtNo2_' + b_seq).val(temp_bbs.no2);
								$('#txtCustno_' + b_seq).val(temp_bbs.custno);
								$('#txtProductno_' + b_seq).val(temp_bbs.productno);
								$('#txtProduct_' + b_seq).val(temp_bbs.product);
								$('#txtSpec_' + b_seq).val(temp_bbs.spec);
								$('#txtRadius_' + b_seq).val(temp_bbs.radius);
								$('#txtWidth_' + b_seq).val(temp_bbs.width);
								$('#txtDime_' + b_seq).val(temp_bbs.dime);
								$('#txtLengthb_' + b_seq).val(temp_bbs.lengthb);
							}
						});
						$('#txtIndate_0').focusout(function(){
							if($(this).val() == '')
								$(this).val(q_date());
						});
					}
				}
			}

			function getNewUno(o_Uno){
				var idno = 1;
				for(var i = 0;i< q_bbsCount;i++){
					var refUno = trim($('#txtUno_' + i).val());
					if(refUno.substring(0,o_Uno.length)==o_Uno){
						idno +=1;
					}
				}
				var newUno = o_Uno + padL(idno,'0',2) + 'A';
				return newUno;
			} 

			function btnOk() {
				t_key = q_getHref();
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['prt'] ) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
			}

			function btnModi() {
				var t_key = q_getHref();
				if (!t_key)
					return;
				_btnModi(1);
			}

			function refresh() {
				_refresh();
			}

			function q_gtPost(t_postname) { 
				
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
				
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
			.txt{
				float:left;
			}
			.c1{
				width:98%;
			}
			.c2{
				width:85%;
			}
			.num{
				text-align: right;
			}
			#dbbs{
				width:1800px;
			}
			.btn{
				font-weight: bold;
			}
		</style>
	</head>
	<body>
		<div id="dbbs">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: medium;'>
				<tr style='color:White; background:#003366;' >
					<td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td align="center" style="width:2%;"><a id='lblPrt'></a></td>
					<td align="center" style="width:2%;"><a id='lblStyle'></a></td>
					<td align="center" style="width:8%;"><a id='lblUno'></a></td>
					<td align="center" style="width:8%;"><a id='lblOrdeno'></a></td>
					<td align="center" style="width:8%;"><a id='lblCustno'></a></td>
					<td align="center" style="width:5%;"><a id='lblIndate'></a></td>
					<td align="center" style="width:8%;"><a id='lblStoreno'></a></td>
					<td align="center" style="width:2%;"><a id='lblClass'></a></td>
					<td align="center" style="width:8%;"><a id='lblProductno'></a></td>
					<td align="center" style="width:14%;"><a id='lblSizea'></a></td>
					<td align="center" style="width:4%;"><a id='lblMount'></a></td>
					<td align="center" style="width:4%;"><a id='lblWeight'></a></td>
					<td align="center" style="width:4%;"><a id='lblInweight'></a></td>
					<td align="center" style="width:4%;"><a id='lblWaste'></a></td>
					<td align="center" style="width:4%;"><a id='lblGmount'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr style="background:#cad3ff;font-size: 14px;">
					<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value="－" style="font-weight: bold;"/></td>
					<td><input type="text" id="txtPrt.*" class="txt c1"/></td>
					<td><input type="text" id="txtStyle.*" class="txt c1"/></td>
					<td><input type="text" id="txtUno.*" class="txt c1"/></td>
					<td>
						<input type="text" id="txtOrdeno.*" class="txt" style="width:70%;"/>
						<input type="text" id="txtNo2.*" class="txt" style="width:28%;"/>
					</td>
					<td>
						<input id="btnCustno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtCustno.*" class="txt c2"/>
						<input type="text" id="txtComp.*" class="txt c1"/>
					</td>
					<td><input type="text" id="txtIndate.*" class="txt c1"/></td>
					<td>
						<input id="btnStoreno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtStoreno.*" class="txt c2"/>
						<input type="text" id="txtStore.*" class="txt c1"/>
					</td>
					<td><input type="text" id="txtClass.*" class="txt c1"/></td>
					<td>
						<input id="btnProductno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtProductno.*" class="txt c2"/>
						<input type="text" id="txtProduct.*" class="txt c1"/>
					</td>
					<td>
						<input type="text" id="txtSpec.*" class="txt c1"/>
						<input type="text" id="txtRadius.*" class="num" style="width:21%;"/>x
						<input type="text" id="txtWidth.*" class="num" style="width:21%;"/>x
						<input type="text" id="txtDime.*" class="num" style="width:21%;"/>x
						<input type="text" id="txtLengthb.*" class="num" style="width:21%;"/>
					</td>
					<td><input type="text" id="txtMount.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtWeight.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtInweight.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtWaste.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtGmount.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtMemo.*" class="txt c1"/></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>