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
		var q_name = 'view_uccc', t_content = ' field=uno,productno,product,spec,unit,radius,dime,width,lengthb,weight,eweight,storeno,class', bbsKey = ['uno'], as; 
		var isBott = false;
		var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
		var i,s1;
		brwCount2 = 6;
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
			}
			main();
		});		 /// end ready

		function main() {
			if (dataErr){
				dataErr = false;
				return;
			}
			mainBrow(0,t_content);
			$('#btnToSeek').click(function(){
				SeekStr();
			});
		}
		
		function mainPost(){
			q_getFormat();
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
		}
		
		function q_gtPost() {
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
			var t_where = " 1=1 " + q_sqlPara2("ordeno", t_ordeno)
								 + q_sqlPara2("productno", t_productno)
								 + q_sqlPara2("storeno", t_storeno)
								 + q_sqlPara2("class", t_class)
								 + q_sqlPara2("radius", t_radius)
								 + q_sqlPara2("dime", t_dime)
								 + q_sqlPara2("width", t_width)
								 + q_sqlPara2("lengthb", t_lengthb)
								 + q_sqlPara2("weight", t_weight);
			seekData(t_where);
		}

		function refresh() {
			_refresh();
			var Parent = window.parent.document;
			if(Parent.getElementById('cmbKind')){
				var t_cmbKind = Parent.getElementById('cmbKind').value.substr(0,1);
				if(t_cmbKind=='A'){
					$('#lblSize_st').text('厚度x寬度x長度');
					$('input[id*="txtLengthb_"]').css('width','29%');
					$('input[id*="txtWidth_"]').css('width','29%');
					$('input[id*="txtDime_"]').css('width','29%');
					$('input[id*="txtRadius_"]').remove();
					$('span[id*="StrX1"]').remove();
				}else if((t_cmbKind !='A') && (t_cmbKind !='B')){
					$('#lblSize_st').text('長度');
					$('#lblSize_st').parent().css('width','6%');
					$('input[id*="txtLengthb_"]').css('width','95%');
					$('input[id*="txtRadius_"]').remove();
					$('input[id*="txtWidth_"]').remove();
					$('input[id*="txtDime_"]').remove();
					$('span[id*="StrX1"]').remove();
					$('span[id*="StrX2"]').remove();
					$('span[id*="StrX3"]').remove();
				}
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
			width:99%;
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
<body> 
<div id="dbbs">
	<table id="tbbs" border="2" cellpadding='0' cellspacing='0' style='width:98%' >
		<tr>
			<th align="center" > </th>
			<td align="center" style="width:8%;"><a id='lblUno_st'> </a></td>
			<td align="center" style="width:6%;"><a id='lblProductno_st'> </a></td>
			<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
			<td align="center" style="width:8%;"><a id='lblSpec_st'> </a></td>
			<td align="center" style="width:18%;"><a id='lblSize_st'> </a></td>
			<td align="center" style="width:4%;"><a id='lblMount_st'> </a></td>
			<td align="center" style="width:6%;"><a id='lblEweight_st'> </a></td>
			<td align="center" style="width:6%;"><a id='lblMweight_st'> </a></td>
			<td align="center" style="width:8%;"><a id='lblMemo_st'> </a></td>
		</tr>
		<tr>
			<td style="width:2%;"><input name="sel" id="radSel.*" type="radio" /></td>
			<td ><input id="txtUno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
			<td ><input id="txtProductno.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
			<td ><input id="txtProduct.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
			<td ><input id="txtSpec.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
			<td >
				<input id="txtRadius.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
                <span id="StrX1" class="StrX">x</span>
				<input id="txtWidth.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
				<span id="StrX2" class="StrX">x</span>
				<input id="txtDime.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
				<span id="StrX3" class="StrX">x</span>
				<input id="txtLengthb.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
            </td>
			<td ><input id="txtEmount.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
			<td ><input id="txtEweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
			<td ><input id="txtMweight.*" type="text" style=" width: 95%;text-align: right;" readonly="readonly"/></td>
			<td ><input id="txtMemo.*" type="text" style=" width: 95%;" readonly="readonly"/></td>
		</tr>
	</table>
</div>
<!--#include file="../inc/brow_ctrl.inc"-->
<div id="seekForm">
	<table id="seekTable" border="0" cellpadding='0' cellspacing='0'>
		<tr>
			<td><span class="lbl">訂單編號</span></td>
			<td colspan="3"><input id="textOrdeno" type="text" class="txt c2"/></td>
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
</div>
</body>
</html>

