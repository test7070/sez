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
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'view_uccc', t_content = ' ', bbsKey = ['uno'], as;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
			var i, s1;
			var q_readonly = ['textProduct', 'textStore'];
			brwCount = -1;
			brwCount2 = 0;
			aPop = new Array(['textProductno', '', 'ucc', 'noa,product', 'textProductno,textProduct', 'ucc_b.aspx']
			, ['textStoreno', '', 'store', 'noa,store', 'textStoreno,textStore', 'store_b.aspx']);
			isLoadGt = 0;
			$(document).ready(function() {
				var t_para = new Array();
				try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	$('#textProductno').val(t_para.productno);
	            	$('#textProduct').val(t_para.product);
	            	$('#textBdime').val(t_para.bdime);
	            	$('#textEdime').val(t_para.edime);
	            	$('#textBwidth').val(t_para.width);
	            	$('#textEwidth').val(t_para.width);
	            	$('#textLengthb').val(t_para.blength);            	
	            }catch(e){
	            }
				setDefaultValue();
				if(q_getPara('sys.comp').substring(0,2)=='裕承')
					t_content += ' where=^^ 1!=1 ^^';
				else
					t_content += ' where=^^ ' + SeekStr() + ' ^^';
				main();
				
			});
			/// end ready

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				
				var w = window.parent;
				mainBrow(6, t_content);
				w.$('#cboxTitle').text('若沒有找到相關資料，請注意類別的選取。').css('color', 'red').css('font-size', 'initial');
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				if(q_getPara('project')=='pk')
					$('.pk').show();
				else
					$('.pk').hide();
			}

			var SeekF = new Array();
			function mainPost() {
				q_getFormat();
				q_cmbParse("combTypea", " @ ,"+q_getPara('sys.stktype'));
				//setDefaultValue();
				$('#textProductno').focus(function() {
					q_cur = 1;
				}).blur(function() {
					q_cur = 0;
				});
				$('#textStoreno').focus(function() {
					q_cur = 1;
				}).blur(function() {
					q_cur = 0;
				});
				$('#seekTable td').children("input:text").each(function() {
					SeekF.push($(this).attr('id'));
				});
				SeekF.push('btnToSeek');
				$('#seekTable td').children("input:text").each(function() {
					$(this).bind('keydown', function(event) {
						keypress_bbm(event, $(this), SeekF, 'btnToSeek');
					});
				});
				$('#btnToSeek').click(function() {
					seekData(SeekStr());
					Lock();
				});
			}

			function setDefaultValue() {
				var w = window.parent;
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
				q_gt(q_name, 'where=^^ ' + seekStr + ' ^^', 0, 0, 0, "");
			}

			function bbsAssign() {

			}

			function SeekStr() {
				t_uno = trim($('#textUno').val());
				t_ordeno = trim($('#textOrdeno').val());
				t_productno = trim($('#textProductno').val());
				t_storeno = trim($('#textStoreno').val());
				t_class = trim($('#textClass').val());
				t_radius = q_float('textRadius');
				t_bdime = q_float('textBdime');
				t_edime = q_float('textEdime');
				t_bwidth = q_float('textBwidth');
				t_ewidth = q_float('textEwidth');
				t_lengthb = q_float('textLengthb');
				t_weight = q_float('textWeight');
				t_kind = trim($('#combTypea').val());
				var t_where = "";
				
				if(t_uno.length==0){
					t_where = " 1=1 " + q_sqlPara2("ordeno", t_ordeno) + 
						q_sqlPara2("productno", t_productno) + 
						(q_getPara('sys.comp').substring(0,2)=='裕承'?" and storeno='"+t_storeno+"'":q_sqlPara2("storeno", t_storeno))+
						q_sqlPara2("class", t_class) + 
						(q_getPara('sys.comp').substring(0,2)=='裕承'?(t_radius>0?' and radius='+t_radius+' ':'') :(t_radius>0?' and radius>='+t_radius+' ':''))+
						(t_bdime>0?' and dime>='+t_bdime+' ':'') + 
						(t_edime>0?' and dime<='+t_edime+' ':'') + 
						(t_bwidth>0?' and width>='+t_bwidth+' ':'') + 
						(t_ewidth>0?' and width<='+t_ewidth+' ':'') + 
						//(q_getPara('sys.comp').substring(0,2)=='裕承'?(t_width>0?' and width='+t_width+' ':'') :(t_width>0?' and width>='+t_width+' ':''))+
						(t_lengthb>0?' and (lengthb=0 or lengthb>='+t_lengthb+') ':'') + 
					//	(t_weight>0?' and weight>='+t_weight+' ':'') + 
						q_sqlPara2("kind", t_kind);
				}else{
					t_where = " 1=1 " + q_sqlPara2("uno", t_uno);
				}		
				return t_where;
			}

			var maxAbbsCount = 0;
			function refresh() {
				//_refresh();
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtUno_' + j).val() == abbs[i].uno) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
						if (w.q_name == 'cub' || w.q_name == 'orde') {
							for (var j = 0; j < w.q_bbtCount; j++) {
								if ((w.$('#txtUno__' + j).val() == abbs[i].uno) && (w.q_cur == 2)) {
									abbs[i].emount = dec(abbs[i].emount) + dec(w.$('#txtGmount__' + j).val());
									abbs[i].eweight = dec(abbs[i].eweight) + dec(w.$('#txtGweight__' + j).val());
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
				q_bbsCount = (abbs.length==0?1:abbs.length);
				_refresh();
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtUno_' + t_id).val())){
							abbs[t_id]['sel'] = "true";
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
						}
					});
				});
				var t_cmbKind = '';
				t_cmbKind = $('#combTypea').val().substr(0, 1);
				if (t_cmbKind == 'A' || $.trim(t_cmbKind) == '') {
					$('#lblSize_st').text(q_getPara('sys.lblSizea')).show();
					$('#lblSize_st').parent().css('width', '18%').show();
					$('#size_changeTd').css('width', '18%').show();
					$('input[id*="txtLengthb_"]').css('width', '29%').show();
					$('input[id*="txtWidth_"]').css('width', '29%').show();
					$('input[id*="txtDime_"]').css('width', '29%').show();
					$('input[id*="txtRadius_"]').hide();
					$('span[id*="StrX1"]').hide();
					for (var k = 0; k < q_bbsCount; k++) {
						exchange($('#txtWidth_' + k), $('#txtDime_' + k));
					}
				} else if (t_cmbKind == 'B') {
					$('#lblSize_st').text(q_getPara('sys.lblSizeb')).show();
					$('#lblSize_st').parent().css('width', '18%').show();
					$('#size_changeTd').css('width', '18%').show();
					$('input[id*="txtLengthb_"]').css('width', '21%').show();
					$('input[id*="txtWidth_"]').css('width', '21%').show();
					$('input[id*="txtDime_"]').css('width', '21%').show();
					$('input[id*="txtRadius_"]').css('width', '21%').show();
				} else if ((t_cmbKind != 'A') && (t_cmbKind != 'B')) {
					$('#lblSize_st').text(q_getPara('sys.lblSizec'));
					$('#lblSize_st').parent().css('width', '6%');
					$('#size_changeTd').css('width', '6%');
					$('input[id*="txtLengthb_"]').css('width', '95%');
					$('input[id*="txtRadius_"]').hide();
					$('input[id*="txtWidth_"]').hide();
					$('input[id*="txtDime_"]').hide();
					$('span[id*="StrX1"]').hide();
					$('span[id*="StrX2"]').hide();
					$('span[id*="StrX3"]').hide();
				}
				var w = window.parent;
				if (w.q_name == 'cub' && w.b_seq >= 0) {
					for (var k = 0; k < q_bbsCount; k++) {
						var thisUno = trim($('#txtUno_' + k).val()).toUpperCase();
						var t_uno = trim(w.$('#txtUno__' + w.b_seq).val()).toUpperCase();
						if (thisUno == t_uno)
							$('#radSel_' + k).prop('checked', true);
					}
				}
				_readonly(true);
				Unlock();
			}

			var exchange = function(a, b) {
				try {
					var tmpTop = a.offset().top;
					var tmpLeft = a.offset().left;
					a.offset({
						top : b.offset().top,
						left : b.offset().left
					});
					b.offset({
						top : tmpTop,
						left : tmpLeft
					});
				} catch(e) {
				}
			};
		</script>
		<style type="text/css">
			#seekForm {
				margin-left: auto;
				margin-right: auto;
				width: 950px;
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
			input[type="button"] {
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
		<div id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style='color:White; background:#003366;' >
					<th align="center" style="width:2%;" >
						<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<td align="center" style="width:10%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:18%;"><a id='lblSize_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblEweight_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblStoreno_st'> </a></td>
					<td align="center" style="width:2%;"><a id='lblSource_st'>國別</a></td>
					<td align="center"><a id='lblMemo_st'> </a></td>
					<td align="center" style="width:4%;" class="pk"><a>實際厚</a></td>
					<td align="center" style="width:4%;" class="pk"><a>實際寬</a></td>
					<td align="center" style="width:4%;" class="pk"><a>實際長</a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:2%;" >
					<input type="checkbox" id="checkAllCheckbox"/>
					</th>
					<td align="center" style="width:10%;"><a id='lblUno_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblProductno_st'> </a></td>
					<td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblSpec_st'> </a></td>
					<td align="center" style="width:18%;"><a id='lblSize_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:6%;"><a id='lblEweight_st'> </a></td>
					<td align="center" style="width:4%;"><a id='lblStoreno_st'> </a></td>
					<td align="center" style="width:2%;"><a id='lblSource_st'>國別</a></td>
					<td align="center"><a id='lblMemo_st'> </a></td>
					<td align="center" style="width:4%;" class="pk"><a>實際厚</a></td>
					<td align="center" style="width:4%;" class="pk"><a>實際寬</a></td>
					<td align="center" style="width:4%;" class="pk"><a>實際長</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center" style="width:2%;"><input id="chkSel.*" type="checkbox" name="chkSel"/></td>
					<td align="center" style="width:10%;">
					<input id="txtUno.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:4%;">
					<input id="txtProductno.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:8%;">
					<input id="txtProduct.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td align="center" style="width:4%;">
					<input id="txtSpec.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td id="size_changeTd" align="center" style="width:18%;">
					<input id="txtRadius.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
					<span id="StrX1" class="StrX">x</span>
					<input id="txtWidth.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
					<span id="StrX2" class="StrX">x</span>
					<input id="txtDime.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
					<span id="StrX3" class="StrX">x</span>
					<input id="txtLengthb.*" type="text" style=" width: 21%;text-align: right;" readonly="readonly"/>
					</td>
					<td align="center" style="width:4%;">
					<input id="txtEmount.*" type="text" class="txt c2 num" readonly="readonly"/>
					</td>
					<td style="width:6%;">
					<input id="txtEweight.*" type="text" class="txt c2 num" readonly="readonly"/>
					</td>
					<td style="width:4%;">
					<input id="txtLaststoreno.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td style="width:2%;">
					<input id="txtSource.*" type="text" class="txt c2" readonly="readonly"/>
					</td>
					<td><input id="txtMemo.*" type="text" class="txt c2" readonly="readonly" class="pk"/></td>
					<td><input id="txtTdime.*" type="text" class="txt c2" readonly="readonly" class="pk"/></td>
					<td><input id="txtTwidth.*" type="text" class="txt c2" readonly="readonly" class="pk"/></td>
					<td><input id="txtTlength.*" type="text" class="txt c2" readonly="readonly" class="pk"/></td>
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
					<input id="textStore" type="text" style="width:65%"/>
					</td>
					<td><span class="lbl">類別</span></td>
					<td><select id="combTypea" class="txt c1"></select></td>
					<td style="display:none;"><span class="lbl">重量</span></td>
					<td style="display:none;">
					<input id="textWeight" type="text" class="txt c1 num"/>
					</td>
				</tr>
				<tr>
					<td><span class="lbl">等級</span></td>
					<td>
					<input id="textClass" type="text" class="txt c1 num"/>
					</td>
					<td><span class="lbl">短徑</span></td>
					<td>
					<input id="textRadius" type="text" class="txt c1 num"/>
					</td>
					<td><span class="lbl">厚度</span></td>
					<td colspan="3">
					<input id="textBdime" type="text" class="txt num" style="float:left;width:40%;"/>
					<span style="float:left;">~</span>
					<input id="textEdime" type="text" class="txt num" style="float:left;width:40%;"/>
					</td>
					<td><span class="lbl">寬度</span></td>
					<td>
						<input id="textBwidth" type="text" class="txt num" style="float:left;width:40%;"/>
						<span style="float:left;">~</span>
						<input id="textEwidth" type="text" class="txt num" style="float:left;width:40%;"/>
					</td>
					<td><span class="lbl">長度</span></td>
					<td><input id="textLengthb" type="text" class="txt c1 num"/></td>
					
				</tr>
				<tr>
					<td><span class="lbl">批號</span></td>
					<td colspan="4"><input id="textUno" type="text" class="txt c1"/></td>
					<td colspan="7">
					<input type="button" id="btnToSeek" value="查詢">
					</td>
				</tr>
			</table>
			<div id="q_acDiv" style="display: none;">
				<div></div>
			</div>
		</div>
	</body>
</html>