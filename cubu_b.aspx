<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
			var q_name = 'cubu', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], t_count = 0, as, brwCount2 = 10;
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
			var bbsMask = [];
			var Parent = window.parent;
			var cubBBsArray = '';
			var cubBBtArray = '';
			if(Parent.q_name && Parent.q_name== 'cub'){
				cubBBsArray = Parent.abbsNow;
				cubBBtArray = Parent.abbtNow;
			}
			aPop = new Array(
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,nick', 'txtCustno_,txtComp_', 'cust_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']			
			);
			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (!q_paraChk())
					return;
				q_gt('style','',0,0,0,'');
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
				bbsMask = [['txtDatea',r_picd],['txtStyle','A']];
				q_mask(bbmMask);
			}

			function getTheory(b_seq){
				t_Radius = $('#txtRadius_'+b_seq).val();
				t_Width = $('#txtWidth_'+b_seq).val();
				t_Dime = $('#txtDime_'+b_seq).val();
				t_Lengthb = $('#txtLengthb_'+b_seq).val();
				t_Mount = $('#txtMount_'+b_seq).val();
				t_Style = $('#txtStyle_'+b_seq).val();
				var TheoryVal = theory_st(StyleList, t_Radius, t_Width, t_Dime, t_Lengthb, t_Mount, t_Style,2);
				$('#txtWeight_'+b_seq).val(TheoryVal);
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
								if(trim($(this).val()) != ''){
									$('#txtProductno_' + b_seq).val(temp_bbt.productno);
									if(trim(temp_bbt.productno) != '')
										q_popsChange($('#txtProductno_' + b_seq));
									$('#txtDime_' + b_seq).val(temp_bbt.dime);
								}
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
								q_popsChange($('#txtCustno_' + b_seq));
								$('#txtProductno_' + b_seq).val(temp_bbs.productno);
								$('#txtProduct_' + b_seq).val(temp_bbs.product);
								$('#txtSpec_' + b_seq).val(temp_bbs.bspec);
								$('#txtRadius_' + b_seq).val(temp_bbs.radius);
								$('#txtWidth_' + b_seq).val(temp_bbs.width);
								$('#txtDime_' + b_seq).val(temp_bbs.dime);
								$('#txtLengthb_' + b_seq).val(temp_bbs.lengthb);
								$('#txtMount_' + b_seq).val(temp_bbs.mount);
								getTheory(b_seq);
							}
						});
						$('#txtDatea_' + j).focusout(function(){
							if($(this).val() == '')
								$(this).val(q_date());
						});
						$('#txtPrt_' +j).focusout(function(){
							var t_prt = trim($(this).val());
							if(t_prt == '1')
								$(this).val('早班');
							else if(t_prt == '2')
								$(this).val('中班');
							else if(t_prt == '3')
								$(this).val('晚班');
							else if(t_prt == '4')
								$(this).val('加班');
							else
								$(this).val(t_prt);
						});
					}
					$('#txtStyle_' + j).blur(function(){
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					    q_bodyId($(this).attr('id'));
					    b_seq = t_IdSeq;
						ProductAddStyle(b_seq);
						getTheory(b_seq);
					});
					$('#txtRadius_' + j).change(function(){
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					    q_bodyId($(this).attr('id'));
					    b_seq = t_IdSeq;
						getTheory(b_seq);
					});
					$('#txtWidth_' + j).change(function(){
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					    q_bodyId($(this).attr('id'));
					    b_seq = t_IdSeq;
						getTheory(b_seq);
					});
					$('#txtDime_' + j).change(function(){
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					    q_bodyId($(this).attr('id'));
					    b_seq = t_IdSeq;
						getTheory(b_seq);
					});
					$('#txtLengthb_' + j).change(function(){
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					    q_bodyId($(this).attr('id'));
					    b_seq = t_IdSeq;
						getTheory(b_seq);
					});
					$('#txtMount_' + j).change(function(){
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					    q_bodyId($(this).attr('id'));
					    b_seq = t_IdSeq;
					    var t_ordeno = $('#txtOrdeno_'+b_seq).val();
					    var t_no2 = $('#txtNo2_'+b_seq).val();
						for(var i = 0;i<cubBBsArray.length;i++){
							if(cubBBsArray[i].ordeno==t_ordeno && cubBBsArray[i].no2==t_no2){
								var t_mount = dec($('#txtMount_'+b_seq).val());
								if(t_mount > dec(cubBBsArray[i].mount)){
									alert('數量不可大於訂單數量!!');
									$('#txtMount_'+b_seq).val(dec(cubBBsArray[i].mount));
									break;
								}
							}
						}
						getTheory(b_seq);
					});
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
				if(idno > 99){
					alert('無法產生新批號\n批號不足使用!!');
					return;
				}
				var newUno = o_Uno + padL(idno,'0',2) + 'A';
				return newUno;
			} 

			function btnOk() {
				t_key = q_getHref();
				_btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno'] ) {
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
				$('input[id*="txtProduct_"]').each(function(){
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					OldValue = $(this).val();
					nowStyle = $('#txtStyle_'+b_seq).val();
					if(!emp(nowStyle) && (StyleList[0] != undefined)){
						for(var i = 0;i < StyleList.length;i++){
		               		if(StyleList[i].noa.toUpperCase() == nowStyle){
		              			styleProduct = StyleList[i].product;
								if(OldValue.substr(OldValue.length-styleProduct.length) == styleProduct){
									OldValue = OldValue.substr(0,OldValue.length-styleProduct.length);
								}
		               		}
		               	}
		            }
					$(this).attr('OldValue',OldValue);
				});
			}
			var StyleList = '';
			function q_gtPost(t_postname) { 
				switch (t_postname) {
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
					break;
				}  /// end switch
			}
			function q_popPost(s1) {
                switch (s1) {
                    case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function(){
		                	$(this).attr('OldValue',$(this).val());
		                });
		                ProductAddStyle(b_seq);
		                break;
                }
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
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt{
				float:left;
			}
			.c1{
				width:90%;
			}
			.c2{
				width:85%;
			}
			.c3{
				width:75%;
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
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="dbbs">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: medium;'>
				<tr style='color:White; background:#003366;' >
					<td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td align="center" style="width:1%;"><a id='lblPrt'></a></td>
					<td align="center" style="width:1%;"><a id='lblStyle'></a></td>
					<td align="center" style="width:9%;"><a id='lblUno'></a></td>
					<td align="center" style="width:10%;"><a id='lblOrdeno'></a></td>
					<td align="center" style="width:5%;"><a id='lblCustno'></a></td>
					<td align="center" style="width:5%;"><a id='lblDatea'></a></td>
					<td align="center" style="width:5%;"><a id='lblStoreno'></a></td>
					<td align="center" style="width:3%;"><a id='lblClass'></a></td>
					<td align="center" style="width:5%;"><a id='lblProductno'></a></td>
					<td align="center" style="width:12%;"><a id='lblSizea'></a></td>
					<td align="center" style="width:4%;"><a id='lblMount'></a></td>
					<td align="center" style="width:4%;"><a id='lblWeight'></a></td>
					<td align="center" style="width:4%;"><a id='lblInweight'></a></td>
					<td align="center" style="width:4%;"><a id='lblWaste'></a></td>
					<td align="center" style="width:4%;"><a id='lblGmount'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr style="background:#cad3ff;font-size: 14px;">
					<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value="－" style="font-weight: bold;"/></td>
					<td><input type="text" id="txtPrt.*" class="txt c1" style="text-align: center;"/></td>
					<td><input type="text" id="txtStyle.*" class="txt c1" style="text-align: center;"/></td>
					<td><input type="text" id="txtUno.*" class="txt c1"/></td>
					<td>
						<input type="text" id="txtOrdeno.*" class="txt" style="width:65%;"/>
						<input type="text" id="txtNo2.*" class="txt" style="width:25%;"/>
					</td>
					<td>
						<input id="btnCustno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtCustno.*" class="txt c3"/>
						<input type="text" id="txtComp.*" class="txt c1"/>
					</td>
					<td><input type="text" id="txtDatea.*" class="txt c1"/></td>
					<td>
						<input id="btnStoreno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtStoreno.*" class="txt c3"/>
						<input type="text" id="txtStore.*" class="txt c1"/>
					</td>
					<td>
						<input type="text" id="txtClass.*" class="txt c1"/>
						<input type="text" id="txtSpec.*" class="txt c1"/>
					</td>
					<td>
						<input id="btnProductno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtProductno.*" class="txt c3"/>
						<input type="text" id="txtProduct.*" class="txt c1"/>
					</td>
					<td>
						<input type="text" id="txtRadius.*" class="num" style="width:19%;"/>x
						<input type="text" id="txtWidth.*" class="num" style="width:19%;"/>x
						<input type="text" id="txtDime.*" class="num" style="width:19%;"/>x
						<input type="text" id="txtLengthb.*" class="num" style="width:19%;"/>
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