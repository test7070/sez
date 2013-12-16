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
		var q_name = 'view_uccc', t_content = ' field=accy,tablea,action,noa,datea,uno,productno,product,radius,dime,width,lengthb,spec,style,storeno,class,class2,typea,source,hard,waste,mount,weight,mweight,size,memo,descr,zinc,scolor,ucolor,unit,kind,eweight,emount,itype,laststoreno', bbsKey = ['uno'], as; 
		var isBott = false;
		var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
		var i,s1;
		var q_readonly = ['textProduct','textStore'];
		brwCount = -1;
		brwCount2 = 0;
		aPop = new Array(
			['textProductno', '', 'ucc', 'noa,product', 'textProductno,textProduct', 'ucc_b.aspx'],
			['textStoreno', '', 'store', 'noa,store', 'textStoreno,textStore', 'store_b.aspx']
		);
		$(document).ready(function () {
			var Parent = window.parent;
			if(Parent.$('#cmbKind').val()){
				var t_cmbKind = Parent.$('#cmbKind').val().substr(0,1);
				if(t_cmbKind=='A'){
					$('#dbbs').html($('#dbbs').html().replace(/txtWidth/g,'txtWA1'));
					$('#dbbs').html($('#dbbs').html().replace(/txtDime/g,'txtWidth'));
					$('#dbbs').html($('#dbbs').html().replace(/txtWA1/g,'txtDime'));
				}
			}else if(Parent.q_name == 'cub'){
					$('#dbbs').html($('#dbbs').html().replace(/txtWidth/g,'txtWA1'));
					$('#dbbs').html($('#dbbs').html().replace(/txtDime/g,'txtWidth'));
					$('#dbbs').html($('#dbbs').html().replace(/txtWA1/g,'txtDime'));
			}
			main();
			setTimeout('parent.$.fn.colorbox.resize({innerHeight : "750px"})', 300);
		});		 /// end ready
		
		
		function main() {
			if (dataErr){
				dataErr = false;
				return;
			}
			var w = window.parent;
			if(w.q_name=='cub' && w.b_seq >=0){
					var w_href=q_getHref();
					for(var k=0;k<w_href.length;k++){
						if(w_href[k] && w_href[k].toString().indexOf('uno') > -1 && location.href.toString().indexOf('uno=') == -1){
							var t_uno = w.$('#txtUno__'+w.b_seq).val();
							if(t_uno){
								var t_where = " 1=1 and uno='"+t_uno+"'";
								seekData(t_where);
								break;
							}
						}
					}
					if(location.href.toString().indexOf('uno') ==-1 && location.href.toString().indexOf('kind')==-1){
						seekData("kind='A1'");
					} 
			}

			mainBrow(6, t_content);
			w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color','red').css('font-size','initial');
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
		
		function q_gtPost(s1) {
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

		var maxAbbsCount = 0;
		function refresh() {
			//_refresh();
			var w = window.parent;
			if (maxAbbsCount < abbs.length) {
				for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
					if(w.q_name == 'cub' || w.q_name == 'orde'){
						for (var j = 0; j < w.q_bbtCount; j++) {
							if ((w.$('#txtUno__' + j).val() == abbs[i].uno) && (w.q_cur==2)) {
								abbs[i].emount = dec(abbs[i].emount) + dec(w.$('#txtGmount__'+j).val());
								abbs[i].eweight = dec(abbs[i].eweight) + dec(w.$('#txtGweight__'+j).val());
							}
						}
					}
					if (dec(abbs[i].emount) <= 0 || dec(abbs[i].eweight) <= 0) {
						abbs.splice(i, 1);
						i--;
					}
				}
				maxAbbsCount = abbs.length;
			}
			_refresh();
			var w = window.parent;
			if(w.$('#cmbKind').val() || w.q_name=='cub'){
				var t_cmbKind = '';
				if(w.$('#cmbKind').val())
					t_cmbKind = w.$('#cmbKind').val().substr(0,1);
				if(w.q_name=='cub'){
					var w_href=q_getHref();
					for(var k=0;k<w_href.length;k++){
						if(w_href[k] && w_href[k+1] && w_href[k].toString().indexOf('kind') > -1){
							t_cmbKind = w_href[k+1].toString().substr(0,1);
							$('#combTypea').val(w_href[k+1].toString());
							break;
						}
					}
					if(t_cmbKind=='' && abbs.length >0){
						if(abbs[0].kind)
							t_cmbKind = abbs[0].kind.substr(0,1);
						t_cmbKind = $('#combTypea').val().substr(0,1);
					}
				}
				if(t_cmbKind=='A'){
					$('#lblSize_st').text(q_getPara('sys.lblSizea'));
					$('#lblSize_st').parent().css('width','18%');
					$('#size_changeTd').css('width','18%');
					$('input[id*="txtLengthb_"]').css('width','29%');
					$('input[id*="txtWidth_"]').css('width','29%');
					$('input[id*="txtDime_"]').css('width','29%');
					$('input[id*="txtRadius_"]').remove();
					$('span[id*="StrX1"]').remove();
				}else if(t_cmbKind=='B'){
					$('#lblSize_st').text(q_getPara('sys.lblSizeb'));
					$('#lblSize_st').parent().css('width','18%');
					$('#size_changeTd').css('width','18%');
					$('input[id*="txtLengthb_"]').css('width','21%');
					$('input[id*="txtWidth_"]').css('width','21%');
					$('input[id*="txtDime_"]').css('width','21%');
					$('input[id*="txtRadius_"]').css('width','21%');
					//$('span[id*="StrX1"]').remove();
				}else if((t_cmbKind !='A') && (t_cmbKind !='B')){
					$('#lblSize_st').text(q_getPara('sys.lblSizec'));
					$('#lblSize_st').parent().css('width','6%');
					$('#size_changeTd').css('width','6%');
					$('input[id*="txtLengthb_"]').css('width','95%');
					$('input[id*="txtRadius_"]').remove();
					$('input[id*="txtWidth_"]').remove();
					$('input[id*="txtDime_"]').remove();
					$('span[id*="StrX1"]').remove();
					$('span[id*="StrX2"]').remove();
					$('span[id*="StrX3"]').remove();
				}
			}
			var w = window.parent;
			if(w.q_name=='cub' && w.b_seq >=0){
				for(var k=0;k<q_bbsCount;k++){
					var thisUno = trim($('#txtUno_'+k).val()).toUpperCase();
					var t_uno = trim(w.$('#txtUno__'+w.b_seq).val()).toUpperCase();
					if(thisUno==t_uno)
						$('#radSel_'+k).prop('checked',true);
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
					<th align="center" style="width:2%;" > </th>
					<td align="center" style="width:10%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:18%;"><a id='lblSize_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblEweight_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblStoreno_st'> </a></td>
					<td align="center"><a id='lblMemo_st'> </a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;" > </th>
					<td align="center" style="width:10%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:18%;"><a id='lblSize_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblEweight_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblStoreno_st'> </a></td>
					<td align="center"><a id='lblMemo_st'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:2%;"><input name="sel" id="radSel.*" type="radio" /></td>
					<td align="center" style="width:10%;"><input id="txtUno.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td align="center" style="width:4%;"><input id="txtProductno.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td align="center" style="width:8%;"><input id="txtProduct.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td align="center" style="width:4%;"><input id="txtSpec.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td id="size_changeTd" align="center" style="width:18%;">
						<input id="txtRadius.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
						<span id="StrX1" class="StrX">x</span>
						<input id="txtWidth.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
						<span id="StrX2" class="StrX">x</span>
						<input id="txtDime.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
						<span id="StrX3" class="StrX">x</span>
						<input id="txtLengthb.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
					</td>
					<td align="center" style="width:4%;"><input id="txtEmount.*" type="text" class="txt c2 num" readonly="readonly"/></td>
					<td style="width:6%;"><input id="txtEweight.*" type="text" class="txt c2 num" readonly="readonly"/></td>
					<td style="width:4%;"><input id="txtLaststoreno.*" type="text" class="txt c2" readonly="readonly"/></td>
					<td ><input id="txtMemo.*" type="text" class="txt c2" readonly="readonly"/></td>
				</tr>
			</table>
		</div>
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

