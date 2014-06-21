<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'quatc', t_content = ' ', bbsKey = ['quatno,no3'], as;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			var q_readonly = ['textComp'];
			var q_readonlys = [
				'txtNick','txtOdate','txtQuatno','txtNo3',
				'txtProductno','txtProduct','txtSpec','txtClass',
				'txtSize','txtMount','txtWeight','chkIsproj','txtPrice',
				'txtUnit','txtDatea','chkEnda','chkCancel','txtChecker'
			];
			brwCount = -1;
			brwCount2 = 0;
			aPop = new Array(['textCustno', '', 'cust', 'noa,comp', 'textCustno,textComp', 'cust_b.aspx']);
			isLoadGt = 0;
			var fbbm = [];
			$(document).ready(function() {
				setDefaultValue();
				t_content += ' where=^^ ' + SeekStr() + ' ^^';
				main();
				$('#btnToSeek').click(function() {
					seekData(SeekStr());
					Lock();
				});
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content);
			}

			var SeekF = new Array();
			function mainPost() {
				q_getFormat();
				$('#textBdate').mask(r_picd);
				$('#textEdate').mask(r_picd);
				setDefaultValue();
				q_cmbParse("combTypea", q_getPara('sys.stktype'));
				$('#textCustno').focus(function() {
					q_cur = 2;
				}).blur(function() {
					q_cur = 0;
				});
				$('#seekTable td').children("input:text").each(function() {
					SeekF.push($(this).attr('id'));
					fbbm.push($(this).attr('id'));
				});
				SeekF.push('btnToSeek');
				$('#seekTable td').children("input:text").each(function() {
					$(this).bind('keydown', function(event) {
						keypress_bbm(event, $(this), SeekF, 'btnToSeek');
					});
				});
			}

			function setDefaultValue() {
				var w = window.parent;
				var t_deli = '_';
				if (w.q_name == 'cub')
					t_deli = '__';
				var t_productno = w.$('#txtProductno' + t_deli + w.b_seq).val();
				t_productno = ( t_productno ? t_productno : '');
				var t_radius = dec(w.$('#txtRadius' + t_deli + w.b_seq).val());
				var t_dime = dec(w.$('#txtDime' + t_deli + w.b_seq).val());
				var t_width = dec(w.$('#txtWidth' + t_deli + w.b_seq).val());
				var t_lengthb = dec(w.$('#txtLengthb' + t_deli + w.b_seq).val());
				var t_kind = '';
				if (w.$('#cmbKind').val()) {
					t_kind = $.trim(w.$('#cmbKind').val());
				}
				if (w.q_name == 'cub') {
					if (w.$('#cmbTypea').find("option:selected").text() == '製管') {
						t_kind = 'A1';
					} else {
						t_kind = 'B2';
					}
				}
				$('#combTypea').val(t_kind);
				$('#textProductno').val(t_productno);
				$('#textRadius').val(t_radius);
				$('#textDime').val(t_dime);
				$('#textWidth').val(t_width);
				$('#textLengthb').val(t_lengthb);
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (isLoadGt == 1) {
							abbs = _q_appendData(q_name, "", true);
							isLoadGt = 0;
							refresh();
						}
						break;
				}
			}

			function seekData(seekStr) {
				isLoadGt = 1;
				q_gt(q_name, 'where=^^ ' + seekStr + ' ^^', 0, 0, 0, "", r_accy);
			}

			function bbsAssign() {
				for(var j=0;j<q_bbsCount;j++){
					$('#checkSel_'+j).change(function(){
						if(!$(this).is(':checked')){
							$('#checkAllCheckbox').attr('checked', false);
						}
					});
				}
			}

			function SeekStr() {
				t_ordeno = trim($('#textOrdeno').val());
				t_productno = trim($('#textProductno').val());
				t_storeno = trim($('#textStoreno').val());
				t_class = trim($('#textClass').val());
				t_radius = (dec($('#textRadius').val()) == 0 ? '' : dec($('#textRadius').val()));
				t_dime = (dec($('#textDime').val()) == 0 ? '' : dec($('#textDime').val()));
				t_width = (dec($('#textWidth').val()) == 0 ? '' : dec($('#textWidth').val()));
				t_lengthb = (dec($('#textLengthb').val()) == 0 ? '' : dec($('#textLengthb').val()));
				t_weight = (dec($('#textWeight').val()) == 0 ? '' : dec($('#textWeight').val()));
				t_kind = trim($('#combTypea').val());
				var t_where = " 1=1 ";
				return t_where;
			}

			var maxAbbsCount = 0;
			function refresh() {
				_refresh();
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=checkSel]').each(function() {
						$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
				Unlock();
			}
			function readonly(t_para, empty) {
				_readonly(false);
			}
		</script>
		<style type="text/css">
			#seekForm {
				margin-left: auto;
				margin-right: auto;
				width: 95%;
			}
			#seekTable {
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
			.txt.c1 {
				width: 98%;
			}
			.txt.c2 {
				width: 95%;
			}
			.lbl {
				float: right;
			}
			span {
				margin-right: 5px;
			}
			td {
				width: 4%;
			}
			.num {
				text-align: right;
			}
			input[type="text"],input[type="button"] {
				font-size: medium;
			}
			.StrX {
				margin-right: -2px;
				margin-left: -2px;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="seekForm">
			<table id="seekTable" border="0" cellpadding='0' cellspacing='0'>
				<tr>
					<td><span class="lbl">類別</span></td>
					<td><select id="combTypea" class="txt c1"></select></td>
					<td><span class="lbl">起始日期</span></td>
					<td><input id="textBdate" type="text" class="txt c1"/></td>
					<td><span class="lbl">終止日期</span></td>
					<td><input id="textEdate" type="text" class="txt c1"/></td>
					<td><span class="lbl">客戶編號</span></td>
					<td colspan="3">
						<input id="textCustno" type="text" style="width:25%"/>
						<input id="textComp" type="text" style="width:73%"/>
					</td>
					<td align="center">
						<input type="button" id="btnToSeek" value="匯入">
					</td>
				</tr>
				<tr>
					<td colspan="6" align="center">
						<input id="checkShow1" type="checkbox" class="txt"/>
						<span class="txt">僅秀低盤</span>
						<input id="checkShow2" type="checkbox" class="txt"/>
						<span class="txt">已折扣</span>
						<input id="checkShow3" type="checkbox" class="txt"/>
						<span class="txt">取消報價 僅秀已核准</span>
					</td>
					<td><span class="lbl">報價單號</span></td>
					<td colspan="2"><input id="textQuatno" type="text" class="txt c1"/></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<div id="q_acDiv" style="display: none;">
				<div></div>
			</div>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px; width:100%;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:1850px;' >
				<tr style='color:White; background:#003366;' >
					<th align="center" style="width:40px;" >
					</th>
					<th align="center" style="width:40px;" >
						<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<td align="center" style="width:130px;"><a id='lblNick'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOdate'> </a></td>
					<td align="center" style="width:150px;"><a id='lblQuatno'> </a></td>
					<td align="center" style="width:40px;"><a id='lblNo3'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct'> </a></td>
					<td align="center" style="width:80px;"><a id='lblSpec'> </a></td>
					<td align="center" style="width:80px;"><a id='lblClass'> </a></td>
					<td align="center" style="width:180px;"><a id='lblSize'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeight'> </a></td>
					<td align="center" style="width:40px;"><a id='lblIsproj'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDatea'> </a></td>
					<td align="center" style="width:40px;"><a id='lblEnda'> </a></td>
					<td align="center" style="width:40px;"><a id='lblCancel'> </a></td>
					<td align="center" style="width:100px;"><a id='lblChecker'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center" style="width:40px;">
						<input id="radioSel.*" type="radio" name="radioSel"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="checkSel.*" type="checkbox" name="checkSel"/>
					</td>
					<td align="center" style="width:130px;">
						<input id="txtNick.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:100px;">
						<input id="txtOdate.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:150px;">
						<input id="txtQuatno.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="txtNo3.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:200px;">
						<input id="txtProductno.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:200px;">
						<input id="txtProduct.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtSpec.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtClass.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:180px;">
						<input id="txtSize.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtMount.*" type="text" class="txt c2 num" readonly="readonly"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtWeight.*" type="text" class="txt c2 num" readonly="readonly"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="chkIsproj.*" type="checkbox" class="txt"/>
					</td>
					<td align="center" style="width:80px;">
						<input id="txtPrice.*" type="text" class="txt c2 num" readonly="readonly"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="txtUnit.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:100px;">
						<input id="txtDatea.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="chkEnda.*" type="checkbox" class="txt"/>
					</td>
					<td align="center" style="width:40px;">
						<input id="chkCancel.*" type="checkbox" class="txt"/>
					</td>
					<td align="center" style="width:100px;">
						<input id="txtChecker.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>