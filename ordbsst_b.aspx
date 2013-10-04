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
			var q_name = 'view_ordbs', t_bbsTag = 'tbbs', t_content = " field=productno,product,spec,dime,width,lengthb,radius,mount,weight,noa,no3,price,total,theory,memo,kind,style,class,uno,size,acoin,afloata,amemo order=odate ", afilter = [], bbsKey = ['noa', 'no3'], t_count = 0, as;
			var t_sqlname = 'ordbs_load2'; t_postname = q_name; brwCount2 = 12;
			var isBott = false;	/// 是否已按過 最後一頁
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
		
			$(document).ready(function () {
				main();
			});		 /// end ready
		
			function main() {
				if (dataErr)	/// 載入資料錯誤
				{
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
			function bbsAssign() {	/// checked 
				_bbsAssign();
			}
		
			function q_gtPost() { 
		
			}
			function refresh() {
				_refresh();
				$('#checkAllCheckbox').click(function(){
					$('input[type=checkbox][id^=chkSel]').each(function(){
						var t_id = $(this).attr('id').split('_')[1];
						if(!emp($('#txtNoa_' + t_id).val()))
							$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
					});
				});
				size_change();
			}
			function size_change () {
				var w = window.parent;
				if(w.$('#cmbKind').val().substr(0, 1) == 'A'){
					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					for (var j = 0; j < brwCount2 ; j++) {
						$('#txtSize4_'+j).attr('hidden', 'true');
						$('#x3_'+j).attr('hidden', 'true');
						$('*[id="FixedSize"').css('width','222px');
						q_tr('txtSize1_'+ j ,q_float('txtDime_'+j));
						q_tr('txtSize2_'+ j ,q_float('txtWidth_'+j));
						q_tr('txtSize3_'+ j ,q_float('txtLengthb_'+j));
						$('#txtSize4_'+j).val(0);
						$('#txtRadius_'+j).val(0);
					 }
				 }else{
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					 for (var j = 0; j < brwCount2 ; j++) {
						$('#txtSize4_'+j).removeAttr('hidden');
						$('#x3_'+j).removeAttr('hidden');
						$('*[id="FixedSize"').css('width','297px');
						q_tr('txtSize1_'+ j ,q_float('txtRadius_'+j));
						q_tr('txtSize2_'+ j ,q_float('txtWidth_'+j));
						q_tr('txtSize3_'+ j ,q_float('txtDime_'+j));
						q_tr('txtSize4_'+ j ,q_float('txtLengthb_'+j));
					 }
				 }
			}
		</script>
<style type="text/css">
	#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 98%;
				margin: -1px;
				border: 1px black solid;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				width: 9%;
			}
			.tbbm .tdZ {
				width: 2%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
			}
			.txt.c4 {
				width: 15%;
				float: left;
			}
			.txt.c5 {
				width: 85%;
				float: left;
			}
			.txt.c6 {
				width: 100%;
				float: left;
			}
			.txt.c7 {
				float:left;
				width: 22%;
				
			}
			.txt.c8 {
				float:left;
				width: 65px;
				
			}
			.txt.num {
				text-align: right;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size:medium;
			}
			.tbbm textarea {
				font-size: medium;
			}
			
			 input[type="text"],input[type="button"] {	 
				font-size: medium;
			}
		 .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width: 100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
	.seek_tr
	{color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
	<div  id="dFixedTitle" style="overflow-y: scroll;">
		<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
			<tr style='color:White; background:#003366;' >
				<td align="center" style="width:1%;"><input type="checkbox" id="checkAllCheckbox"/></td>
				<td align="center" style="width:8%;"><a id='lblProductno_st'></a></td>
				<td align="center" style="width:10%;"><a id='lblProduct'></a></td>
				<td align="center" style="width:10%;"><a id='lblSpec'></a></td>
				<td align="center" id='FixedSize'><a id='lblSize'></a><BR><a id='lblSize_help'> </a></td>
				<td align="center" style="width:7%;"><a id='lblMount'></a></td>
				<td align="center" style="width:7%;"><a id='lblWeight'></a></td>
				<td align="center" style="width:7%;"><a id='lblPrice'></a></td>
				<td align="center" style="width:10%;"><a id='lblNoa'></a></td>
				<td align="center"><a id='lblMemo'></a></td>
			</tr>
		</table>
	</div>
	<div id="dbbs" style="overflow: scroll;height:550px;" >
		<table id="tbbs" class='tbbs'	border="2"	cellpadding='2' cellspacing='1' style='width:100%'	>
			<tr style='color:White; background:#003366;display:none;' >
				<td align="center" style="width:1%;">
					<input type="checkbox" id="checkAllCheckbox"/>
				</td>
				<td align="center" style="width:8%;"><a id='lblProductno_st'></a></td>
				<td align="center" style="width:10%;"><a id='lblProduct'></a></td>
				<td align="center" style="width:10%;"><a id='lblSpec'></a></td>
				<td align="center" id='FixedSize'><a id='lblSize'></a><BR><a id='lblSize_help'> </a></td>
				<td align="center" style="width:7%;"><a id='lblMount'></a></td>
				<td align="center" style="width:7%;"><a id='lblWeight'></a></td>
				<td align="center" style="width:7%;"><a id='lblPrice'></a></td>
				<td align="center" style="width:10%;"><a id='lblNoa'></a></td>
				<td align="center"><a id='lblMemo'></a></td>
			</tr>
			<tr style='background:#cad3ff;'>
				<td align="center" style="width:1%;"><input id="chkSel.*" type="checkbox"	/></td>
				<td style="width:8%;"><input class="txt c1"	id="txtProductno.*" type="text" /></td>
				<td style="width:10%;"><input class="txt c1" id="txtProduct.*" type="text"/></td>
				 <td style="width:10%;"><input class="txt c1" id="txtSpec.*" type="text" /></td>
				<td id="FixedSize">
					<input class="txt num c8" id="txtSize1.*" type="text"/><div id="x1" style="float: left"> x</div>
					<input class="txt num c8" id="txtSize2.*" type="text"/><div id="x2" style="float: left"> x</div>
					<input class="txt num c8" id="txtSize3.*" type="text"/><div id="x3.*" style="float: left"> x</div>
					<input class="txt num c8" id="txtSize4.*" type="text"/>
					<!--上為虛擬下為實際-->
					<input id="txtRadius.*" type="hidden"/>
					<input id="txtWidth.*" type="hidden"/>
					<input id="txtDime.*" type="hidden"/>
					<input id="txtLengthb.*" type="hidden"/>
				</td>
				<td style="width:7%;"><input class="txt num c1" id="txtMount.*" type="text"/></td>
				<td style="width:7%;"><input class="txt num c1" id="txtWeight.*" type="text" /></td>
				<td style="width:7%;"><input class="txt num c1" id="txtPrice.*" type="text"/></td>
				<td style="width:10%;"><input class="txt c1" id="txtNoa.*" type="text"/><input class="txt c1" id="txtNo3.*" type="text" /></td>
				<td><input class="txt c1" id="txtMemo.*" type="text"/><input id="txtKind.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
			</tr>
		</table>
 </div>
	<!--#include file="../inc/pop_ctrl.inc"--> 
</body>
</html>
