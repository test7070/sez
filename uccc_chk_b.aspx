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
			var q_name = 'view_uccc', t_content = ' ', bbsKey = ['uno'],afilter = [], as; 
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i,s1;
			var q_readonly = ['textProduct','textCust'];
			brwCount = -1;
			brwCount2 = 0;
			aPop = new Array(
				['textProductno', '', 'ucc', 'noa,product', 'textProductno,textProduct', 'ucc_b.aspx'],
				['textStoreno', '', 'store', 'noa,store', 'textStoreno,textStore', 'store_b.aspx']
			);
			$(document).ready(function () {
				var Parent = window.parent.document;
				if(Parent.getElementById('cmbKind')){
					var t_cmbKind = Parent.getElementById('cmbKind').value.substr(0,1);
					if(t_cmbKind=='A'){
						$('#dbbs').html($('#dbbs').html().replace(/txtWidth/g,'txtWA1'));
						$('#dbbs').html($('#dbbs').html().replace(/txtDime/g,'txtWidth'));
						$('#dbbs').html($('#dbbs').html().replace(/txtWA1/g,'txtDime'));
					}
				}else if(window.parent.q_name == 'cub'){
					$('#dbbs').html($('#dbbs').html().replace(/txtWidth/g,'txtWA1'));
					$('#dbbs').html($('#dbbs').html().replace(/txtDime/g,'txtWidth'));
					$('#dbbs').html($('#dbbs').html().replace(/txtWA1/g,'txtDime'));
				}
				main();
			});         /// end ready

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6,t_content);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				$('#btnToSeek').click(function(){
					SeekStr();
				});
			}
			
			var SeekF = new Array();
			function mainPost(){
				q_getFormat();
				q_cmbParse("combTypea", q_getPara('sys.stktype'));
				$('#textProductno').focus(function(){
					q_cur=1;
				}).blur(function(){
					q_cur=0;
				});
				$('#textStoreno').focus(function(){
					q_cur=1;
				}).blur(function(){
					q_cur=0;
				});
				$('#seekTable td').children("input:text").each(function () {
					SeekF.push($(this).attr('id'));
				});
				SeekF.push('btnToSeek');
				$('#seekTable td').children("input:text").each(function () {
					$(this).bind('keydown', function (event) {
						keypress_bbm(event, $(this), SeekF, 'btnToSeek'); 
					});
				});
			}
			
			function seekData(seekStr){
				var newUrl = location.href.split(';');
				var newUrlStr = '';
				newUrl[3] = seekStr;
				for(var i = 0;i<newUrl.length;i++){
					newUrlStr += newUrl[i];
					if(i < newUrl.length-1)
						newUrlStr += ';';
				}
				location.href = newUrlStr;
			}
			
			function bbsAssign(){
				
			}
			
			function SeekStr(){
				t_ordeno = trim($('#textOrdeno').val());
				t_productno = trim($('#textProductno').val());
				t_storeno = trim($('#textStoreno').val());
				t_class = trim($('#textClass').val());
				t_radius = trim($('#textRadius').val());
				t_dime = trim($('#textDime').val());
				t_width = trim($('#textWidth').val());
				t_lengthb = trim($('#textLengthb').val());
				t_weight = trim($('#textWeight').val());
				t_kind = trim($('#combTypea').val());
				var t_where = " 1=1 " + q_sqlPara2("ordeno", t_ordeno)
									 + q_sqlPara2("productno", t_productno)
									 + q_sqlPara2("storeno", t_storeno)
									 + q_sqlPara2("class", t_class)
									 + q_sqlPara2("radius", t_radius)
									 + q_sqlPara2("dime", t_dime)
									 + q_sqlPara2("width", t_width)
									 + q_sqlPara2("lengthb", t_lengthb)
									 + q_sqlPara2("weight", t_weight)
									 + q_sqlPara2("kind", t_kind);
				seekData(t_where);
			}

			function q_gtPost() {}

			var maxAbbsCount = 0;
			function refresh() {
				_refresh();
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtUno_' + j).val() == abbs[i].uno) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
						if(w.q_name == 'cub' || w.q_name == 'orde'){
							for (var j = 0; j < w.q_bbtCount; j++) {
								if (w.$('#txtUno__' + j).val() == abbs[i].uno) {
									abbs[i].emount = dec(abbs[i].emount) + dec(w.$('#txtMount__'+j).val());
									abbs[i].eweight = dec(abbs[i].eweight) + dec(w.$('#txtWeight__'+j).val());
									abbs[i]['sel'] = "true";
									$('#chkSel_' + abbs[i].rec).attr('checked', true);
								}
							}
						}
						if (abbs[i].emount <= 0 || abbs[i].eweight <= 0) {
							abbs.splice(i, 1);
							i--;
						}
					}
					maxAbbsCount = abbs.length;
				}
				_refresh();
				$('#checkAllCheckbox').click(function(){
					$('input[type=checkbox][id^=chkSel]').each(function(){
						var t_id = $(this).attr('id').split('_')[1];
						if(!emp($('#txtUno_' + t_id).val()))
							$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
					});
				});
				var Parent = window.parent.document;
				if(Parent.getElementById('cmbKind')){
					var t_cmbKind = Parent.getElementById('cmbKind').value.substr(0,1);
					if(t_cmbKind=='A'){
						$('#lblSize_st').text(q_getPara('sys.lblSizea'));
						$('input[id*="txtLengthb_"]').css('width','29%');
						$('input[id*="txtWidth_"]').css('width','29%');
						$('input[id*="txtDime_"]').css('width','29%');
						$('input[id*="txtRadius_"]').remove();
						$('span[id*="StrX1"]').remove();
					}else if((t_cmbKind !='A') && (t_cmbKind !='B')){
						$('#lblSize_st').text(q_getPara('sys.lblSizec'));
						$('#lblSize_st').parent().css('width','6%');
						$('input[id*="txtLengthb_"]').css('width','95%');
						$('input[id*="txtRadius_"]').remove();
						$('input[id*="txtWidth_"]').remove();
						$('input[id*="txtDime_"]').remove();
						$('span[id*="StrX1"]').remove();
						$('span[id*="StrX2"]').remove();
						$('span[id*="StrX3"]').remove();
					}
				}else if(window.parent.q_name != 'cub' || window.parent.q_name == 'cub'){
					$('#lblSize_st').text(q_getPara('sys.lblSizea'));
					$('input[id*="txtLengthb_"]').css('width','29%');
					$('input[id*="txtWidth_"]').css('width','29%');
					$('input[id*="txtDime_"]').css('width','29%');
					$('input[id*="txtRadius_"]').remove();
					$('span[id*="StrX1"]').remove();
				}
				_readonly(true);
			}	
		</script>
    	<style type="text/css">
			#seekForm{
				margin-left: auto;
				margin-right: auto;
				width:950px;
			}
			#seekTable{
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			#seekTable tr {
				height: 35px;
			}
			.txt.c1{
				width:98%;
			}
			.txt.c2{
				width:95%;
			}
			.lbl{
				float:right;
			}
			span{
				margin-right: 5px;
			}
			td{
				width:4%;
			}
			.num{
				text-align:right;
			}
			input[type="button"] {	 
				font-size: medium;
			}
			.StrX{
				margin-right:-2px;
				margin-left:-2px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:White; background:#003366;' >
					<th align="center" style="width:2%;" >
						<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<td align="center" style="width:20%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:20%;"><a id='lblSize_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblEmount_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblEweight_st'> </a></td>
					<td align="center" style="width:10%;"><a id='lblMemo_st'> </a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" border="2"  cellpadding='2' cellspacing='1' style='width:100%' >
				<tr style='color:White; background:#003366;display:none;'>
					<th align="center" style="width:2%;" >
						<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<td align="center" style="width:20%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:20%;"><a id='lblSize_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblEmount_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblEweight_st'> </a></td>
					<td align="center" style="width:10%;"><a id='lblMemo_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center" style="width:2%;"><input id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td style="width:20%;"><input id="txtUno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td style="width:6%;"><input id="txtProductno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td style="width:8%;"><input id="txtProduct.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td style="width:20%;">
						<input id="txtRadius.*" type="text" style=" width: 20%;text-align: right;" readonly="readonly"/>
						<span id="StrX1" class="StrX">x</span>
						<input id="txtWidth.*" type="text" style=" width: 20%;text-align: right;" readonly="readonly"/>
						<span id="StrX2" class="StrX">x</span>
						<input id="txtDime.*" type="text" style=" width: 20%;text-align: right;" readonly="readonly"/>
						<span id="StrX3" class="StrX">x</span>
						<input id="txtLengthb.*" type="text" style=" width: 20%;text-align: right;" readonly="readonly"/>
					</td>
					<td style="width:8%;"><input id="txtSpec.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
					<td style="width:8%;"><input id="txtEmount.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
					<td style="width:8%;"><input id="txtEweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
					<td style="width:10%;"><input id="txtMemo.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
				</tr>
			</table>
		</div>
			<!--#include file="../inc/brow_ctrl.inc"--> 
		<div id="seekForm">
			<table id="seekTable" border="0" cellpadding='0' cellspacing='0'>
				<tr>
					<td><span class="lbl">品名編號</span></td>
					<td colspan="3">
						<input id="textProductno" type="text" style="width:25%"/>
						<input id="textProduct" type="text" style="width:73%"/>
					</td>
					<td><span class="lbl">倉庫</span></td>
					<td colspan="3">
						<input id="textStoreno" type="text" style="width:25%"/>
						<input id="textStore" type="text" style="width:73%"/>
					</td>
					<td><span class="lbl">類別</span></td>
					<td>
						<select id="combTypea" class="txt c1"> </select>
					</td>
				</tr>
				<tr>
					<td><span class="lbl">等級</span></td>
					<td><input id="textClass" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">短徑</span></td>
					<td><input id="textRadius" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">厚度</span></td>
					<td><input id="textDime" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">寬度</span></td>
					<td><input id="textWidth" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">長度</span></td>
					<td><input id="textLengthb" type="text" class="txt c1 num"/></td>
					<td><span class="lbl">重量</span></td>
					<td><input id="textWeight" type="text" class="txt c1 num"/></td>
				</tr>
				<tr>
					<td colspan="12" align="center">
						<input type="button" id="btnToSeek" value="查詢">
					</td>
				</tr>
			</table>
			<div id="q_acDiv" style="display: none;"><div> </div></div>
		</div>
	</body>
</html>