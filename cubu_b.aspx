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
			var q_name = 'cubu', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], t_count = 0, as, brwCount = -1;
			brwCount2 = 0;
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
			if (Parent.q_name && Parent.q_name == 'cub') {
				cubBBsArray = Parent.abbsNow;
				cubBBtArray = Parent.abbtNow;
			}
			aPop = new Array(
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,nick', 'txtCustno_,txtComp_', 'cust_b.aspx'],
				['txtOrdeno_', 'btnOrdeno_', 'view_ordes', 'noa,no2,custno,cust,class,spec,productno,product,radius,dime,width,lengthb', 'txtOrdeno_,txtNo2_,txtCustno_,txtComp_,txtClass_,txtSpec_,txtProductno_,txtProduct_,txtRadius_,txtDime_,txtWidth_,txtLengthb_', 'ordests_seek_b.aspx', '95%', '60%'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_', 'ucaucc_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (!q_paraChk())
					return;
				q_gt('style', '', 0, 0, 0, '');
				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function mainPost() {
				bbmMask = [];
				bbsMask = [['txtDatea', r_picd], ['txtStyle', 'A']];
				q_mask(bbmMask);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
			}

			function getTheory(b_seq) {
				t_Radius = $('#txtRadius_' + b_seq).val();
				t_Width = $('#txtWidth_' + b_seq).val();
				t_Dime = $('#txtDime_' + b_seq).val();
				t_Lengthb = $('#txtLengthb_' + b_seq).val();
				t_Mount = $('#txtMount_' + b_seq).val();
				t_Style = $('#txtStyle_' + b_seq).val();
				t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting = {
					calc : StyleList,
					ucc : t_uccArray,
					radius : t_Radius,
					width : t_Width,
					dime : t_Dime,
					lengthb : t_Lengthb,
					mount : t_Mount,
					style : t_Style,
					stype : 2,
					productno : t_Productno,
					round : 3
				};
				var TheoryVal = theory_st(theory_setting);
				$('#txtWeight_' + b_seq).val(TheoryVal);
			}

			var toFocusOrdeno = 0;
			function bbsAssign() {
				_bbsAssign();
				SetBBsReadonly(ReadOnlyUno);
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text((j + 1));
					if (Parent.q_name && Parent.q_name == 'cub') {
						$('#txtUno_' + j).change(function() {
							var thisuno = trim($(this).val());
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							var t_datea = $('#txtDatea_' + n).val();
							if (cubBBtArray[dec(thisuno) - 1] != undefined) {
								var temp_bbt = cubBBtArray[dec(thisuno) - 1];
								getUno(n, temp_bbt.uno, '');
								var t_datea = $('#txtDatea_' + n);
								if (trim($(this).val()) != '') {
									$('#txtProductno_' + n).val(temp_bbt.productno);
									$('#txtSpec_' + n).val(temp_bbt.spec);
									$('#txtClass_' + n).val(temp_bbt.class);
									if (trim(temp_bbt.productno) != '')
										q_popsChange($('#txtProductno_' + n));
									$('#txtDime_' + n).val(temp_bbt.dime);
								}
							}
							toFocusOrdeno = 1;
						}).focusout(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							var oUno = trim($(this).val());
							var t_datea = trim($('#txtDatea_' + n).val());
							if (oUno.length == 0 && t_datea.length > 0)
								getUno(n, '', t_datea);
						});
						$('#txtOrdeno_' + j).change(function() {
							var thisordeno = trim($(this).val());
							if (cubBBsArray[dec(thisordeno) - 1] != undefined) {
								var temp_bbs = cubBBsArray[dec(thisordeno) - 1];
								var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
								$(this).val(temp_bbs.ordeno);
								$('#txtNo2_' + n).val(temp_bbs.no2);
								$('#txtCustno_' + n).val(temp_bbs.custno);
								q_popsChange($('#txtCustno_' + n));
								$('#txtProductno_' + n).val(temp_bbs.productno);
								$('#txtProduct_' + n).val(temp_bbs.product);
								$('#txtSpec_' + n).val(temp_bbs.bspec);
								$('#txtRadius_' + n).val(temp_bbs.radius);
								$('#txtWidth_' + n).val(temp_bbs.width);
								$('#txtDime_' + n).val(temp_bbs.dime);
								$('#txtLengthb_' + n).val(temp_bbs.lengthb);
								$('#txtMount_' + n).val(temp_bbs.mount);
								$('#txtStyle_' + n).val(temp_bbs.style);
								getTheory(n);
							}
						});
						$('#txtDatea_' + j).focusout(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							var thisVal = $.trim($(this).val());
							var DatePati = /^[0-9][0-9][0-9]\/[0-1][0-9]\/[0-3][0-9]$/g;
							if (thisVal == '') {
								$(this).val(q_date());
							} else {
								if (DatePati.test(thisVal)) {
									var t_year = dec(thisVal.substring(0, 3));
									var thisyear = dec(q_date().substring(0, 3));
									if (t_year < (thisyear - 1) || t_year > (thisyear + 1)) {
										q_msg($(this), '日期差距太大');
										$(this).val('');
										return;
									}
								} else {
									q_msg($(this), '日期格式錯誤');
									$(this).val('');
									return;
								}
							}
							var oUno = trim($('#txtUno_' + n).val());
							if (oUno.length == 0)
								getUno(n, '', $(this).val());
						});
						$('#txtPrt_' + j).focusout(function() {
							var t_prt = trim($(this).val());
							if (t_prt == '1')
								$(this).val('早班');
							else if (t_prt == '2')
								$(this).val('中班');
							else if (t_prt == '3')
								$(this).val('晚班');
							else if (t_prt == '4')
								$(this).val('加班');
							else
								$(this).val(t_prt);
						});
					}
					$('#txtStyle_' + j).blur(function() {
						$('input[id*="txtProduct_"]').each(function() {
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
						});
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						ProductAddStyle(n);
						getTheory(n);
					});
					
					$('#txtRadius_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					$('#txtWidth_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					$('#txtDime_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					$('#txtLengthb_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					$('#txtWeight_' + j).change(function() {
						TotWeight();
					});
					$('#txtMount_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						var t_ordeno = $.trim($('#txtOrdeno_' + n).val());
						var t_no2 = $.trim($('#txtNo2_' + n).val());
						if (t_ordeno.length > 0) {
							for (var i = 0; i < cubBBsArray.length; i++) {
								if (cubBBsArray[i].ordeno == t_ordeno && cubBBsArray[i].no2 == t_no2) {
									var t_mount = dec($('#txtMount_' + n).val());
									if (t_mount > dec(cubBBsArray[i].mount)) {
										alert('數量不可大於訂單數量!!');
										$('#txtMount_' + n).val(dec(cubBBsArray[i].mount));
										break;
									}
								}
							}
						}
						getTheory(n);
					});
					$('#txtSize_' + j).change(function(e) {
						if ($.trim($(this).val()).length == 0)
							return;
						var n = $(this).attr('id').replace('txtSize_', '');
						var data = tranSize($.trim($(this).val()));
						$(this).val(tranSize($.trim($(this).val()), 'getsize'));
						$('#txtRadius_' + n).val('');
						$('#txtWidth_' + n).val('');
						$('#txtDime_' + n).val('');
						$('#txtLengthb_' + n).val('');
						if (data.length == 3) {
							$('#txtRadius_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
							$('#txtDime_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
							$('#txtLengthb_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
						} else {
							$('#txtRadius_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
							$('#txtWidth_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
							$('#txtDime_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
							$('#txtLengthb_' + n).val((data[3] != undefined ? (data[3].toString().length > 0 ? (isNaN(parseFloat(data[3])) ? 0 : parseFloat(data[3])) : 0) : 0));
						}
						getTheory(n);
					});
				}
				bbsRefresh();
			}

			function btnOk() {
				TotWeight();
			    bbsReSort();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}
			function bbsReSort() {
				var a_productno = new Array();
				for (var i = 0; i < q_bbsCount; i++) {
					var thisProductno = $.trim($('#txtProductno_' + i).val());
					var valArray = new Array();
					for (var j = 0; j < fbbs.length; j++) {
						valArray[fbbs[j]] = $('#' + fbbs[j] + '_' + i).val();
					}
					a_productno.push([i, thisProductno, valArray]);
				}
				a_productno.sort(function(a, b) {
					return a[1].charCodeAt() - b[1].charCodeAt();
				});
				for (var k = 0; k < q_bbsCount; k++) {
					$('#btnMinus_' + k).click();
				};
				for (var s = 0; s < a_productno.length; s++) {
					for (var key in a_productno[s][2]) {
						$('#' + key + '_' + s).val(a_productno[s][2][key]);
					}
				}
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['ordeno']) {
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
				SetBBsReadonly(ReadOnlyUno);
				$('#btnOk').before($('#btnOk').clone().attr('id', 'btnOk2').show()).hide();
				$('#btnOk2').click(function() {
					var t_errMsg = '';
					for (var i = 0; i < q_bbsCount; i++) {
						$('#txtWorker_' + i).val(r_name);
						var t_datea = trim($('#txtDatea_' + i).val());
						var t_uno = trim($('#txtUno_' + i).val());
						var t_ordeno = trim($('#txtOrdeno_' + i).val());
						var t_mount = dec($('#txtMount_' + i).val());
						var t_weight = dec($('#txtWeight_' + i).val());
						if (t_datea.length != 9) {
							if ($.trim(Parent.$('#txtDatea').val()) != '')
								$('#txtDatea_' + i).val($.trim(Parent.$('#txtDatea').val()));
							else
								$('#txtDatea_' + i).val(q_date());
						}
						//不存檔提示!!
						if ((t_mount > 0) && (t_weight <= 0))
							t_errMsg += '第 ' + (i + 1) + " 筆重量小於等於0。\n";
						if ((t_mount > 0) && (t_uno.length == 0))
							t_errMsg += '第 ' + (i + 1) + " 筆批號為空。\n";
					}
					if ($.trim(t_errMsg).length > 0) {
						alert(t_errMsg);
						return;
					}
					//檢查批號
                    for (var i = 0; i < q_bbsCount; i++) {
                        for (var j = i + 1; j < q_bbsCount; j++) {
                            if ($.trim($('#txtUno_' + i).val()).length > 0 && $.trim($('#txtUno_' + i).val()) == $.trim($('#txtUno_' + j).val())) {
                                alert('【' + $.trim($('#txtUno_' + i).val()) + '】' + q_getMsg('lblUno_st') + '重覆。\n' + (i + 1) + ', ' + (j + 1));
                                Unlock(1);
                                return;
                            }
                        }
                    }
                    //parent.$('#txtNoa').val()
                    var t_where = '';
                    for (var i = 0; i < q_bbsCount; i++) {
                        if ($.trim($('#txtUno_' + i).val()).length > 0)
                            t_where += (t_where.length > 0 ? ' or ' : '') + "(uno='" + $.trim($('#txtUno_' + i).val()) + "' and not(tablea='cubu' and noa='" + $.trim($('#txtNoa_'+i).val()) + "'))";
                    }
                    if (t_where.length > 0)
                        q_gt('view_uccb', "where=^^" + t_where + "^^", 0, 0, 0, 'btnOk_checkuno');
                    else{
                        qbtnOk();
                        parent.$.fn.colorbox.close();
                    }
				});
			}

			function SetBBsReadonly(UnoArr) {
				for (var j = 0; j < UnoArr.length; j++) {
					var thisUno = $.trim(UnoArr[j]);
					for (var k = 0; k < q_bbsCount; k++) {
						var bbsUno = $.trim($('#txtUno_' + k).val());
						if (thisUno == bbsUno) {
							$('#btnMinus_' + k).attr('disabled', 'disabled');
							$('#txtUno_' + k).attr('readonly', true).css({
								'color' : t_color2,
								'background' : t_background2
							});
						}
					}
				}
			}

			function GetBBsUno() {
				var ReturnStr = '';
				var TmpArr = [];
				for (var i = 0; i < q_bbsCount; i++) {
					var thisVal = $.trim($('#txtUno_' + i).val());
					if (thisVal.length > 0) {
						TmpArr.push(thisVal);
					}
				}
				if (TmpArr.length > 0) {
					ReturnStr = "'" + TmpArr.toString().replace(/\,/g, "','") + "'";
					return ReturnStr;
				} else {
					return '';
				}
			}

			function refresh() {
				_refresh();
				$('input[id*="txtProduct_"]').each(function() {
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
					$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
				});
				var UnoList = $.trim(GetBBsUno());
				if (UnoList.length > 0) {
					var t_where = 'where=^^ (1=1) and (uno in(' + UnoList + '))^^';
					q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
				}
				TotWeight();
				bbsRefresh();
			}
			function TotWeight(){
				var totWeight = 0;
				for(var i=0;i<q_bbsCount;i++){
					totWeight = q_add(totWeight,q_float('txtWeight_'+i));
				}
				$('#totWeight').text(totWeight);
			}

			var StyleList = '';
			var t_uccArray = new Array;
			var ReadOnlyUno = [];
			function q_gtPost(t_postname) {
				switch (t_postname) {
				    case 'btnOk_checkuno':
                        var as = _q_appendData("view_uccb", "", true);
                        if (as[0] != undefined) {
                            var msg = '';
                            for (var i = 0; i < as.length; i++) {
                                msg += (msg.length > 0 ? '\n' : '') + as[i].uno + ' 此批號已存在!!\n【' + as[i].action + '】單號：' + as[i].noa;
                            }
                            alert(msg);
                            Unlock(1);
                            return;
                        } else {
                            qbtnOk();
                            parent.$.fn.colorbox.close();
                        }
                        break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						break;
					case 'deleUccy':
						var as = _q_appendData("uccy", "", true);
						if (as[0] != undefined) {
							ReadOnlyUno = new Array;
							for (var i = 0; i < as.length; i++) {
								var asUno = $.trim(as[i].uno);
								if (dec(as[i].gweight) > 0) {
									ReadOnlyUno.push(asUno);
								}
							}
						}
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						break;
				}  /// end switch
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function() {
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
						});
						if (trim($('#txtStyle_' + b_seq).val()).length != 0)
							ProductAddStyle(b_seq);
						if (toFocusOrdeno == 1)
							$('#txtGroupa_' + b_seq).focus();//2014/05/22  groupa移到ordeno前
						toFocusOrdeno = 0;
						break;
				}
			}

			function getUno(t_id, s_ouno, s_datea) {
				var t_buno = '　';
				var t_datea = '　';
				var t_style = '　';
				t_buno += s_ouno;
				t_datea += s_datea;
				t_style += $('#txtStyle_' + t_id).val();
				q_func('qtxt.query.getuno^^' + t_id, 'uno.txt,getuno,' + t_buno + ';' + t_datea + ';' + t_style + ';');
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					default:
						if (t_func.split('^^')[0] == 'qtxt.query.getuno') {
							var as = _q_appendData("tmp0", "", true, true);
							var t_id = t_func.split('^^')[1];
							if (as[0] != undefined) {
								if (as.length != 1) {
									alert('批號取得異常。');
								} else {
									$('#txtUno_' + t_id).val(as[0].uno);
								}
							}
						}
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
				bbsRefresh();
				if (q_tables == 's')
					bbsAssign();
			}
			function bbsRefresh(){
				if(q_getPara('sys.project').toUpperCase()=='RS')
					$('.rs_hide').hide();
			}
		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt {
				float: left;
			}
			.c1 {
				width: 90%;
			}
			.c2 {
				width: 85%;
			}
			.c3 {
				width: 71%;
			}
			.c4 {
				width: 95%;
			}
			.num {
				text-align: right;
			}
			#dbbs {
				width: 2000px;
			}
			.btn {
				font-weight: bold;
			}
			#lblNo {
				font-size: medium;
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
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:15px;"></td>
					<td align="center" style="width:45px;"><a id='lblPrt'></a></td>
					<td align="center" style="width:30px;"><a id='lblStyle'></a></td>
					<td align="center" style="width:250px;"><a id='lblUno'></a></td>
					<td align="center" style="width:40px;" title="領料、入庫群組設定相同，成本單價將會獨立計算。">群組</td>
					<td align="center" style="width:180px;"><a id='lblOrdeno'></a></td>
					<td align="center" style="width:100px;"><a id='lblCustno'></a></td>
					<td align="center" style="width:100px;"><a id='lblDatea'></a></td>
					<td align="center" style="width:120px;"><a id='lblStoreno'></a></td>
					<td align="center" style="width:80px;"><a id='lblClass'></a></td>
					<td align="center" style="width:80px;"><a id='lblProductno'></a></td>
					<td align="center" style="width:260px;">
						<a id='lblSizea'></a>
						<br>
						<a id='lblSpec'></a>
					</td>
					<td align="center" style="width:180px;" class="rs_hide"><a id='lblSize'></a></td>
					<td align="center" style="width:80px;"><a id='lblMount'></a></td>
					<td align="center" style="width:120px;"><a id='lblWeight'></a><br><a id='totWeight'></a></td>
					<td align="center" style="width:120px;display:none;"><a id='lblInweight'></a></td>
					<td align="center" style="width:80px;display:none;"><a id='lblWaste'></a></td>
					<td align="center" style="width:80px;display:none;"><a id='lblGmount'></a></td>
					<td align="center" style="width:220px;"><a id='lblMemo'></a></td>
					
				</tr>
				<tr style="background:#cad3ff;font-size: 14px;">
					<td style="width:1%;">
						<input class="btn"  id="btnMinus.*" type="button" value="－" style="font-weight: bold;"/>
					</td>
					<td style="text-align:center;"><a id="lblNo.*"> </a></td>
					<td>
						<input type="text" id="txtNoa.*" class="txt c1" style="display:none;"/>
						<input type="text" id="txtPrt.*" class="txt c1" style="text-align: center;"/>
					</td>
					<td><input type="text" id="txtStyle.*" class="txt c1" style="text-align: center;"/></td>
					<td><input type="text" id="txtUno.*" class="txt c1"/></td>
					<td><input type="text" id="txtGroupa.*" class="txt c1"/></td>
					<td>
						<input id="btnOrdeno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtOrdeno.*" class="txt" style="width:60%;"/>
						<input type="text" id="txtNo2.*" class="txt" style="width:20%;"/>
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
					<td><input type="text" id="txtClass.*" class="txt c1"/></td>
					<td>
						<input id="btnProductno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtProductno.*" style="width:65%;"/>
						<input type="text" id="txtProduct.*" class="txt c4"/>
					</td>
					<td>
						<input type="text" id="txtRadius.*" class="num" style="width:19%;"/>x
						<input type="text" id="txtWidth.*" class="num" style="width:19%;"/>x
						<input type="text" id="txtDime.*" class="num" style="width:19%;"/>x
						<input type="text" id="txtLengthb.*" class="num" style="width:19%;"/>
						<input type="text" id="txtSpec.*" class="txt c4"/>
					</td>
					<td class="rs_hide"><input type="text" id="txtSize.*" class="txt c4"/></td>
					<td><input type="text" id="txtMount.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtWeight.*" class="txt c1 num"/></td>
					<td style="display:none;">
						<input type="text" id="txtInweight.*" class="txt c1 num"/>
					</td>
					<td style="display:none;">
						<input type="text" id="txtWaste.*" class="txt c1 num"/>
					</td>
					<td style="display:none;">
						<input type="text" id="txtGmount.*" class="txt c1 num"/>
					</td>
					<td>
						<input type="text" id="txtMemo.*" class="txt c1"/>
						<input type="text" id="txtWorker.*" style="display:none;"/>
					</td>
					
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>