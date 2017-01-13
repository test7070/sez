<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_tables = 't';
			var q_name = "ucx";
			var decbbs = ['weight', 'uweight', 'price'];
			var decbbm = ['weight', 'hours', 'pretime', 'mount', 'wages', 'makes'/*, 'mechs', 'trans'*/, 'molds', 'packs', 'uweight', 'price'];
			var decbbt = [];
			var q_readonly = ['txtModel','txtStationg','txtMolds','txtRev'];
			var q_readonlys = [];
			var q_readonlyt = ['txtAssm'];
			var bbmNum = [['txtPrice', 12, 3, 1],['txtPreday', 12, 0, 1],['txtHours', 10, 3, 1],['txtMinutes', 10, 3, 1],['txtPretime', 12, 2, 1],['txtBadperc', 12, 2, 1],['txtUweight', 12, 2, 1],['txtMakes', 15, 3, 1]
			,['txtPacks', 15, 3, 1],['txtWages', 15, 3, 1],['txtCost', 15, 3, 1]/*,['txtMechs', 15, 2, 1],['txtTrans', 15, 2, 1]*/,['txtSafemount', 15, 2, 1],['txtStdmount', 15, 2, 1],['txtMoq', 15, 2, 1]];
			var bbsNum = [['txtMount', 12, 2,1]/*, ['txtWeight', 11, 2]*/, ['txtCost', 11, 3 ,1], ['txtHours', 9, 2,1],['txtLoss', 10, 2,1],['txtDividea', 10, 0,1],['txtMul', 10, 2,1]];
			var bbtNum = [['txtMount_', 12, 2, 1]/*, ['txtWeight_', 12, 2 ,1]*/,['txtPrice_', 12, 3, 1], ['txtEndmount_', 12, 0, 1], ['txtEndweight_', 12, 2, 1]];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 14;
			q_copy=1;
			aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
				['txtSssno', '', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,spec,unit', '0txtProductno_,txtProduct_,txtSpec_,txtUnit_', 'ucaucc_b.aspx'],
				['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
				['txtStationno__', 'btnStation__', 'station__', 'noa,station', 'txtStationno__,txtStation__', 'station_b.aspx'],
				['txtStationgno', 'lblStationg', 'stationg', 'noa,namea', 'txtStationgno,txtStationg', 'stationg_b.aspx'],
				['txtModelno', 'lblModel', 'model', 'noa,model', 'txtModelno,txtModel', 'model_b.aspx'],
				['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx'],
				['txtProcessno_', 'btnProcessno_', 'process', 'noa,process', 'txtProcessno_,txtProcess_', 'process_b.aspx'],
				['txtTggno__', 'btnTggno__', 'tgg', 'noa,nick', 'txtTggno__,txtNick__', 'tgg_b.aspx'],
				['txtProcessno__', 'btnProcessno__', 'process', 'noa,process', 'txtProcessno__,txtProcess__', 'process_b.aspx'],
				['txtUcano', 'lblUcano', 'uca', 'noa,product', '0txtUcano', 'uca_b.aspx'],
				['txtUccno', 'lblUccno', 'ucaucc', 'noa,product', '0txtUccno', 'ucacc_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			}).mousedown(function(e) {
				if(!$('#div_row').is(':hidden')){
					$('#div_row').hide();
				}
			});
			
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				q_mask(bbmMask);
				mainForm(0);
				$('#txtNoa').focus();
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtKdate', r_picd], ['txtWdate', r_picd]];
				q_mask(bbmMask);
				//q_cmbParse("cmbTypea", q_getPara('uca.typea'));
				q_cmbParse("cmbMtype", q_getPara('uca.mtype'), 's');
				q_gt('uccga', '', 0, 0, 0, "");
				
				$('#btnUploadimg').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("uploadimg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'uploadimg', "680px", "650px", q_getMsg('btnUploadimg'));
				});
				
				$('#btnUcctd').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("ucctd_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucctd', "680px", "650px", q_getMsg('btnUcctd'));
				});
				
				$('#btnUcap').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("ucap_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucap', "860px", "706px", q_getMsg('btnUcap'));
				});
				
				$('#btnPack2').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("pack2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack2', "95%", "95%", q_getMsg('btnPack2'));
				});

				$('#btnCheck_div_assm').click(function() {
					//寫入到對應的assm
					var bbt_b_seq = $('#bbt_b_seq').val();
					var tmpassm = '';
					for (var i = 0; i < assm_row; i++) {
						if (dec($('#assm_txtMount_' + i).val()) > 0)
							tmpassm += ($('#assm_txtProductno_' + i).val() + ',' + $('#assm_txtMount_' + i).val() + ';');
					}
					//if(tmpassm.length>0){
					tmpassm = tmpassm.substr(0, tmpassm.length - 1);
					$('#txtAssm__' + bbt_b_seq).val(tmpassm);
					//}
					$('#div_assm').toggle();
				});
				$('#btnClose_div_assm').click(function() {
					$('#div_assm').toggle();
				});
				//上方插入空白行
				$('#lblTop_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
					}
				});
				//下方插入空白行
				$('#lblDown_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
					}
				});

				$('#btnCustproduct').click(function() {
					var t_ucano=$('#txtUcano').val();
					t_where = "noa='" + t_ucano + "'";
					q_box("ucccust.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucccust', "95%", "95%", q_getMsg('btnCustproduct'));
				});

				$('#btnModel').click(function(){
					//var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
					//q_box("ucab.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucab', "95%", "95%", $('#btnModel').val());
					
					var t_where = "mouldno='" + $.trim($('#cmbGroupano').val()) + "'";
					q_box("modfixcs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'modfixcs', "95%", "95%", $('#btnModel').val());
					
				});
				$('#txtNoa').change(function(){
					var thisVal = $.trim($(this).val());
					if(thisVal.length > 0){
						var t_where = "where=^^ noa='" + thisVal + "' ^^";
						Lock();
						q_gt('ucaucc', t_where, 0, 0, 0, "checkNoa", r_accy,1);
						var as = _q_appendData("ucaucc", "", true);
						if (as[0] != undefined) {
							alert('物品編號重複!!');
							$('#txtNoa').val('').focus();
						}else{
							q_gt('ucx', t_where, 0, 0, 0, "checkNoa2", r_accy,1);
							var asx = _q_appendData("ucx", "", true);
							if (asx[0] != undefined) {
								alert('物品編號重複!!');
								$('#txtNoa').val('').focus();
							}
						}
						Unlock();
					}
				});
				
				$('#txtWages').change(function() {
					costsum();
				});
				$('#txtMakes').change(function() {
					costsum();
				});
				$('#txtPrice').change(function() {
					costsum();
				});
				$('#txtMolds').change(function() {
					costsum();
				});
				$('#txtPacks').change(function() {
					costsum();
				});
				
				$('#btnCub_r').click(function() {
					var t_where = " isnull(productno,'')!='' and (productno='" + $.trim($('#txtUcano').val()) + "' or productno='" + $.trim($('#txtUccno').val()) + "' or productno='" + $.trim($('#txtNoa').val()) + "') ";
					q_box("cub_r.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cub_r', "95%", "95%", $('#btnCub_r').val());
				});
			}
			
			function costsum() {
				//原料成本
				var t_costa=0;
				for (var i = 0; i < q_bbsCount; i++) {
					t_costa=q_add(t_costa,dec($('#txtCost_'+i).val()));
				}
				//直接人工
				var t_costb=dec($('#txtWages').val());
				//製造費用
				var t_costc=dec($('#txtMakes').val());
				//委外單價
				var t_costd=dec($('#txtPrice').val());
				//模具成本
				var t_costm=dec($('#txtMolds').val());
				//包裝費用
				var t_costp=dec($('#txtPacks').val());
				//報廢成本
				//運輸單價
				//成本合計
				$('#txtCost').val(q_add(q_add(q_add(q_add(q_add(t_costa,t_costb),t_costc),t_costd),t_costm),t_costp));
			}
			
			var t_td = '';
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					/*case 'cub_r':
						var t_where = "where=^^noa='" + $('#txtNoa').val() + "'^^";
						q_gt('ucx', t_where, 0, 0, 0, "get_ordeno", r_accy);
						break;*/
					case 'td':
						if (q_cur > 0 && q_cur < 3) {
							ret = getb_ret();
							if (ret != null) {
								for (var i = 0; i < ret.length; i++) {
									t_td += ret[i].noa + '.';
								}
								if (t_td.length > 0) {
									t_td = t_td.substr(0, t_td.length - 1);
									$('#txtTd_' + b_seq).val(t_td);
									//判斷替代品是否會造成BOM無窮迴圈
									q_func('qtxt.query', 'bom.txt,bom,' + encodeURI(t_td) + ';' + encodeURI($('#txtNoa').val()));
								}
							}
						}
						break;
					case 'ucab':
						getMolds();
						break;
					case 'uploadimg':
						var t_where = "where=^^noa='" + $('#txtNoa').val() + "'^^";
						q_gt('ucx', t_where, 0, 0, 0, "uploadimg_noa", r_accy);
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			var ucsa_cost = 0;
			function q_gtPost(t_name) {
				switch (t_name) {
					/*case 'get_ordeno':
						var as = _q_appendData("ucx", "", true);
						if (as[0] != undefined) {
							$('#txtOrdeno').val(as[0].ordeno);
						}
						break;*/
					case 'ucamodel_cost':
						var as = _q_appendData("ucamodel_cost", "", true);
						if (as[0] != undefined) {
							var newVal = 0;
							for(var j=0;j<as.length;j++){
								newVal = q_add(newVal,dec(as[j].cost));
							}
							newVal = round(newVal,0);
							$('#txtMolds').val(newVal);
						}
						break;
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						if (as[0] != undefined) {
							var t_item = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
							}
							q_cmbParse("cmbGroupano", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupano").val(abbm[q_recno].groupano);
							}
						}
						break;
					case 'uploadimg_noa':
						var as = _q_appendData("ucx", "", true);
						if (as[0] != undefined) {
							abbm[q_recno]['images'] = as[0].images;
							$('#txtImages').val(as[0].images);
						}
						$('.images').html('');
						if(!emp($('#txtImages').val())&&!emp($('#txtNoa').val())){
							imagename=$('#txtImages').val().split(';');
							imagename.sort();
							var imagehtml="<table width='1260px'><tr>";
							for (var i=0 ;i<imagename.length;i++){
								if(imagename[i]!='')
									imagehtml+="<td><img id='images_"+i+"' style='cursor: pointer;' width='200px' src='../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[i]+"?"+new Date()+"'> </td>"
							}
							imagehtml+="</tr></table>";
							$('.images').html(imagehtml);
							
							for (var i=0 ;i<imagename.length;i++){
								$('#images_'+i).click(function() {
									var n = $(this).attr('id').split('_')[1];
									t_where = "noa='" + $('#txtNoa').val() + "'";
									q_box("../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[n]+"?;;;;;"+new Date(), 'image', "85%", "85%", "");
								});
							}
						}
						break;
					case q_name:
						if (q_cur == 4){
							q_Seek_gtPost();
						}
						break;
				}
			}

			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtProduct', q_getMsg('lblProduct')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				//判斷bbt是否有值並判斷其一托工流程是否有填寫製成品編號(最後一個托工流程的製成品會是物品編號)
				var tcount = false, endnoa = false;
				for (var i = 0; i < q_bbtCount; i++) {
					if (!tcount && !emp($('#txtProcess__' + i).val()))
						tcount = true;
					if ($('#txtProductno__' + i).val() == $('#txtNoa').val())
						endnoa = true;
				}
				if (tcount && !endnoa) {//有托工，但沒指定最後一個托工流程
					alert('請指定一個托工流程為最後流程(在『在製編號』內填寫『物品編號』)');
					return;
				}
				//產生bbt的在製編號
				var noqt = 0;
				for (var i = 0; i < q_bbtCount; i++) {
					noqt += 1;
					//檢查是否重複編號
					for (var j = 0; j < q_bbtCount && emp($('#txtProductno__' + i).val()); j++) {
						if (!emp($('#txtProductno__' + j).val()) && $('#txtProductno__' + j).val() == ($('#txtNoa').val() + '-' + $('#txtTggno__' + i).val() + '-' + ('000' + noqt).slice(-3))) {
							i--;
							break;
						}
					}

					if (!emp($('#txtProcess__' + i).val()) && !emp($('#txtTggno__' + i).val()) && emp($('#txtProductno__' + i).val())) {
						$('#txtProductno__' + i).val($('#txtNoa').val() + '-' + $('#txtTggno__' + i).val() + '-' + ('000' + noqt).slice(-3));
					}
				}

				$('#txtWorker').val(r_name);
				sum();

				//重新設定noq
				for (var i = 0; i < q_bbsCount; i++) {
					if (!emp($('#txtProductno_' + i).val()))
						$('#txtNoq_' + i).val(('000' + (i + 1)).slice(-3));
				}
				for (var i = 0; i < q_bbtCount; i++) {
					if (!emp($('#txtProcessno__' + i).val()))
						$('#txtNoq__' + i).val(('000' + (i + 1)).slice(-3));
				}

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				wrServer(s1);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('ucx_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
			}
			
			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtCost_'+j).change(function() {
							costsum();
						});
						
						$('#btnProductno_'+ j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtProductno_' + b_seq).val()))
								q_box("z_ucap.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtProductno_'+ b_seq).val() + "' and product='" + $('#txtProduct_'+ b_seq).val() + "';" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
						});
						
						$('#txtProductno_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if (emp($('#txtNoa').val())) {
								alert('請先輸入【' + q_getMsg('lblNoa') + '】');
								$('#txtNoa').focus();
							}
							if (!emp($('#txtProductno_' + b_seq).val()) && !emp($('#txtNoa').val()))
								q_func('qtxt.query', 'bom.txt,bom,' + encodeURI($('#txtProductno_' + b_seq).val()) + ';' + encodeURI($('#txtNoa').val()));
						});
						$('#btnTproductno_' + j).click(function() {
							if (emp($('#txtNoa').val())) {
								alert('請先輸入【' + q_getMsg('lblNoa') + '】');
								$('#txtNoa').focus();
								return;
							}
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#text_Noq').val(b_seq);
							q_box("ucc_b2.aspx", 'td', "95%", "650px", q_getMsg('popTd'));
						});
						$('#txtTd_' + j).focusin(function() {
							if (emp($('#txtNoa').val())) {
								alert('請先輸入【' + q_getMsg('lblNoa') + '】');
								$('#txtNoa').focus();
								return;
							} else {
								q_msg($(this), '輸入格式為：品號.品號.品號........');
							}
						}).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtTd_' + b_seq).val())) {
								if ($('#txtTd_' + b_seq).val().indexOf(';') > 0 || $('#txtTd_' + b_seq).val().indexOf(',') > 0) {
									$('#txtTd_' + b_seq).val(replaceAll($('#txtTd_' + b_seq).val(), ',', '.'));
									$('#txtTd_' + b_seq).val(replaceAll($('#txtTd_' + b_seq).val(), ';', '.'));
								}
								t_td = $('#txtTd_' + b_seq).val();
								//判斷替代品是否會造成BOM無窮迴圈
								q_func('qtxt.query', 'bom.txt,bom,' + encodeURI(t_td) + ';' + encodeURI($('#txtNoa').val()));
							}
						});

						$('#btnMinus_'+j).bind('contextmenu',function(e) {
							e.preventDefault();
	                    	if(e.button==2){
								////////////控制顯示位置
								$('#div_row').css('top', e.pageY);
								$('#div_row').css('left', e.pageX);
								//////////////
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$('#div_row').show();
								//顯示選單
								row_b_seq = b_seq;
								//儲存選取的row
								row_bbsbbt = 'bbs';
								//儲存要新增的地方
							}
                    	});
						
					}
				}
				_bbsAssign();
			}

			var assm_row = 0;
			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
						$('#txtPrice__' + i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (dec($('#txtWages__' + b_seq).val()) == 0 && dec($('#txtMakes__' + b_seq).val()) == 0 && !emp($('#txtPrice__' + b_seq).val())) {
								q_tr('txtWages_fee__' + b_seq, round(q_float('txtPrice__' + b_seq) * 0.8, 2));
								q_tr('txtMakes_fee__' + b_seq, round(q_float('txtPrice__' + b_seq) * 0.2, 2));
							}
						});

						$('#btnAssm__' + i).mousedown(function(e) {
							if (q_cur < 1 || q_cur > 2)
								return;
							if (!$("#div_assm").is(":hidden"))
								return;
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (e.button == 0) {
								$('#btnCheck_div_assm').show();
								$('#div_assm').toggle();
								$('#bbt_b_seq').val(b_seq);
								//清除之前插入的內容
								//document.getElementById("table_assm").deleteRow();
								var rowslength = document.getElementById("table_assm").rows.length - 1;
								for (var j = 1; j < rowslength; j++) {
									document.getElementById("table_assm").deleteRow(1);
								}
								assm_row = 0;
								//插入bbs&bbt
								for (var j = 0; j < q_bbsCount; j++) {
									if (!emp($('#txtProductno_' + j).val())) {
										var tr = document.createElement("tr");
										tr.id = "bbs_" + j;
										tr.innerHTML = "<td id='assm_tdProductno_" + assm_row + "'><input id='assm_txtProductno_" + assm_row + "' type='text' class='txt c1' value='" + $('#txtProductno_' + j).val() + "' disabled='disabled'/></td>";
										tr.innerHTML += "<td id='assm_tdProduct_" + assm_row + "'><input id='assm_txtProduct_" + assm_row + "' type='text' class='txt c1' value='" + $('#txtProduct_' + j).val() + "' disabled='disabled' /></td>";
										tr.innerHTML += "<td id='assm_tdMount_" + assm_row + "'><input id='assm_txtMount_" + assm_row + "' type='text' class='txt c1 num' value='" + $('#txtMount_' + j).val() + "' onkeyup='return ValidateFloat($(this),value)'/></td>";
										var tmp = document.getElementById("assm_close");
										tmp.parentNode.insertBefore(tr, tmp);
										assm_row++;
									}
								}
								for (var j = 0; j < q_bbtCount; j++) {
									if (!emp($('#txtProductno__' + j).val()) && $('#txtProductno__' + j).val() != $('#txtNoa').val()) {
										var tr = document.createElement("tr");
										tr.id = "bbt_" + j;
										tr.innerHTML = "<td id='assm_tdProductno_" + assm_row + "'><input id='assm_txtProductno_" + assm_row + "' type='text' class='txt c1' value='" + $('#txtProductno__' + j).val() + "' disabled='disabled'/></td>";
										tr.innerHTML += "<td id='assm_tdProduct_" + assm_row + "'><input id='assm_txtProduct_" + assm_row + "' type='text' class='txt c1' value='" + $('#txtProductno__' + j).val() + "-半成品' disabled='disabled' /></td>";
										tr.innerHTML += "<td id='assm_tdMount_" + assm_row + "'><input id='assm_txtMount_" + assm_row + "' type='text' class='txt c1 num' value='0' onkeyup='return ValidateFloat($(this),value)'/></td>";
										var tmp = document.getElementById("assm_close");
										tmp.parentNode.insertBefore(tr, tmp);
										assm_row++;
									}
								}

								//顯示資料的數量
								var assmtmp = $('#txtAssm__' + b_seq).val().split(';');
								for (var x = 0; x < assmtmp.length; x++) {
									var assmmount = assmtmp[x].split(',');
									for (var y = 0; y < assm_row; y++) {
										if ($('#assm_txtProductno_' + y).val() == assmmount[0]) {
											$('#assm_txtMount_' + y).val(assmmount[1]);
											break;
										}
									}
								}
								////////////控制顯示位置
								$('#div_assm').css('top', e.pageY - parseInt($('#div_assm').css('height')));
								$('#div_assm').css('left', e.pageX - parseInt($('#div_assm').css('width')));
								//////////////
							}
						});

						//只顯示使用的原物料
						$('#txtAssm__' + i).mousedown(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (emp($('#txtAssm__' + b_seq).val()))
								return;
							if (!$("#div_assm").is(":hidden"))
								return;
							if (e.button == 0) {
								$('#btnCheck_div_assm').hide();
								$('#div_assm').toggle();
								$('#bbt_b_seq').val(b_seq);
								//清除之前插入的內容
								//document.getElementById("table_assm").deleteRow();
								var rowslength = document.getElementById("table_assm").rows.length - 1;
								for (var j = 1; j < rowslength; j++) {
									document.getElementById("table_assm").deleteRow(1);
								}
								assm_row = 0;
								//插入bbs&bbt
								for (var j = 0; j < q_bbsCount; j++) {
									if (!emp($('#txtProductno_' + j).val()) && $('#txtAssm__' + b_seq).val().indexOf($('#txtProductno_' + j).val()) > -1) {
										var tr = document.createElement("tr");
										tr.id = "bbs_" + j;
										tr.innerHTML = "<td id='assm_tdProductno_" + assm_row + "'><input id='assm_txtProductno_" + assm_row + "' type='text' class='txt c1' value='" + $('#txtProductno_' + j).val() + "' disabled='disabled'/></td>";
										tr.innerHTML += "<td id='assm_tdProduct_" + assm_row + "'><input id='assm_txtProduct_" + assm_row + "' type='text' class='txt c1' value='" + $('#txtProduct_' + j).val() + "' disabled='disabled' /></td>";
										tr.innerHTML += "<td id='assm_tdMount_" + assm_row + "'><input id='assm_txtMount_" + assm_row + "' type='text' class='txt c1 num' value='" + $('#txtMount_' + j).val() + "' onkeyup='return ValidateFloat($(this),value)' disabled='disabled'/></td>";
										var tmp = document.getElementById("assm_close");
										tmp.parentNode.insertBefore(tr, tmp);
										assm_row++;
									}
								}
								for (var j = 0; j < q_bbtCount; j++) {
									if (!emp($('#txtProductno__' + j).val()) && $('#txtProductno__' + j).val() != $('#txtNoa').val() && $('#txtAssm__' + b_seq).val().indexOf($('#txtProductno__' + j).val()) > -1) {
										var tr = document.createElement("tr");
										tr.id = "bbt_" + j;
										tr.innerHTML = "<td id='assm_tdProductno_" + assm_row + "'><input id='assm_txtProductno_" + assm_row + "' type='text' class='txt c1' value='" + $('#txtProductno__' + j).val() + "' disabled='disabled'/></td>";
										tr.innerHTML += "<td id='assm_tdProduct_" + assm_row + "'><input id='assm_txtProduct_" + assm_row + "' type='text' class='txt c1' value='" + $('#txtProductno__' + j).val() + "-半成品' disabled='disabled' /></td>";
										tr.innerHTML += "<td id='assm_tdMount_" + assm_row + "'><input id='assm_txtMount_" + assm_row + "' type='text' class='txt c1 num' value='0' onkeyup='return ValidateFloat($(this),value)' disabled='disabled'/></td>";
										var tmp = document.getElementById("assm_close");
										tmp.parentNode.insertBefore(tr, tmp);
										assm_row++;
									}
								}

								//顯示資料的數量
								var assmtmp = $('#txtAssm__' + b_seq).val().split(';');
								for (var x = 0; x < assmtmp.length; x++) {
									var assmmount = assmtmp[x].split(',');
									for (var y = 0; y < assm_row; y++) {
										if ($('#assm_txtProductno_' + y).val() == assmmount[0]) {
											$('#assm_txtMount_' + y).val(assmmount[1]);
											break;
										}
									}
								}

								////////////控制顯示位置
								$('#div_assm').css('top', e.pageY - parseInt($('#div_assm').css('height')));
								$('#div_assm').css('left', e.pageX - parseInt($('#div_assm').css('width')));
								//////////////
							}
						});

						$('#btnMinut__' + i).bind('contextmenu',function(e) {
							e.preventDefault();
							if (e.button == 2) {
								////////////控制顯示位置
								$('#div_row').css('top', e.pageY);
								$('#div_row').css('left', e.pageX);
								//////////////
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$('#div_row').show();
								row_b_seq = b_seq;
								row_bbsbbt = 'bbt';
							}
						});
					}
				}
				_bbtAssign();
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] == undefined) {
							if (t_td.length > 0) {
								alert('替代品會造成BOM錯誤!!請重新填入!!');
								$('#txtTd_' + b_seq).val('');
							} else {
								alert('BOM錯誤!!該品號不能填入!!');
								$('#btnMinus_' + b_seq).click();
							}
						}
						t_td = '';
						break;
				}
			};

			function btnIns() {
				_btnIns();
				$('#txtKdate').val(q_date());
				$('#txtKdate').focus();
				//$('#txtRev').val('001');
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtMdate').val(q_date());
				$('#txtMdate').focus();
			}

			function btnPrint() {
				q_box("z_ucap.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "' and product='" + $('#txtProduct').val() + "';" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				if(!emp($('#txtNoa').val())){
					//變動ucctgg
					q_func('qtxt.query.updateucctgg', 'ucx.txt,updateucctgg,'+encodeURI($('#txtNoa').val()) +  ';' + encodeURI(q_date()) + ';' + encodeURI(r_name));
					//變動uca
					q_func('qtxt.query.insuca', 'ucx.txt,insuca,'+encodeURI($('#txtNoa').val()) +  ';' + encodeURI(q_date()) + ';' + encodeURI(r_name));
				}
			}

			function bbsSave(as) {
				t_err = '';
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				as['rev'] = abbm2['rev'];
				if (t_err) {
					alert(t_err);
					return false;
				}

				return true;
			}

			function sum() {

			}

			function getMolds(){
				var thisNoa = $.trim($('#txtNoa').val());
				if((thisNoa.length>0)){
					var t_where = "where=^^ a.noa=N'"+thisNoa+"' ^^";
					q_gt('ucamodel_cost', t_where, 0, 0, 0, "");
				}
			}
			
			function refresh(recno) {
				_refresh(recno);
				getMolds();
				//format();
				$('.images').html('');
				if(!emp($('#txtImages').val())&&!emp($('#txtNoa').val())){
					imagename=$('#txtImages').val().split(';');
					imagename.sort();
					var imagehtml="<table width='1260px'><tr>";
					for (var i=0 ;i<imagename.length;i++){
						if(imagename[i]!='')
							imagehtml+="<td><img id='images_"+i+"' style='cursor: pointer;' width='200px' src='../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[i]+"?"+new Date()+"'> </td>"
					}
					imagehtml+="</tr></table>";
					$('.images').html(imagehtml);
					
					for (var i=0 ;i<imagename.length;i++){
						$('#images_'+i).click(function() {
							var n = $(this).attr('id').split('_')[1];
							t_where = "noa='" + $('#txtNoa').val() + "'";
							q_box("../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[n]+"?;;;;;"+new Date(), 'image', "85%", "85%", "");
						});
					}
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#div_row').hide();
					$('#div_assm').hide();
					$('#btnUploadimg').removeAttr('disabled');
					$('#btnUcctd').removeAttr('disabled');
					$('#btnCustproduct').removeAttr('disabled');
					$('#btnModel').removeAttr('disabled');
					//恢復滑鼠右鍵
					/*document.oncontextmenu = function() {
						return true;
					}*/
				} else {
					$('#btnUploadimg').attr('disabled', 'disabled');
					$('#btnUcctd').attr('disabled', 'disabled');
					$('#btnCustproduct').attr('disabled', 'disabled');
					$('#btnModel').attr('disabled', 'disabled');
					//防滑鼠右鍵
					/*document.oncontextmenu = function() {
						return false;
					}*/
				}
				if(!emp($('#txtSssno').val())){
					$('#txtSssno').attr('disabled', 'disabled');
					$('#txtNamea').attr('disabled', 'disabled');
				}
				
			}

			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}

			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
			}

			function btnSeek() {
				_btnSeek();
			}

			function btnTop() {
				_btnTop();
			}

			function btnPrev() {
				_btnPrev();
			}

			function btnPrevPage() {
				_btnPrevPage();
			}

			function btnNext() {
				_btnNext();
			}

			function btnNextPage() {
				_btnNextPage();
			}

			function btnBott() {
				_btnBott();
			}

			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}

			function btnDele() {
				_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			//輸入數字判斷
			function ValidateFloat(e, pnumber) {
				if (!/^\d+[.]?\d*$/.test(pnumber)) {
					$(e).val(/^\d+[.]?\d*/.exec($(e).val()));
				}
				return false;
			}

			var mouse_div = true;
			//控制滑鼠消失div
			var row_bbsbbt = '';
			//判斷是bbs或bbt增加欄位
			var row_b_seq = '';
			//判斷第幾個row
			//插入欄位
			function q_bbs_addrow(bbsbbt, row, topdown) {
				//取得目前行
				var rows_b_seq = dec(row) + dec(topdown);
				if (bbsbbt == 'bbs') {
					q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
					//目前行的資料往下移動
					for (var i = q_bbsCount - 1; i >= rows_b_seq; i--) {
						for (var j = 0; j < fbbs.length; j++) {
							if (i != rows_b_seq)
								$('#' + fbbs[j] + '_' + i).val($('#' + fbbs[j] + '_' + (i - 1)).val());
							else
								$('#' + fbbs[j] + '_' + i).val('');
						}
					}
				}
				if (bbsbbt == 'bbt') {
					q_gridAddRow(bbtHtm, 'tbbt', fbbt, 1, '', '', '', '__');
					//目前行的資料往下移動
					for (var i = q_bbtCount - 1; i >= rows_b_seq; i--) {
						for (var j = 0; j < fbbt.length; j++) {
							if (i != rows_b_seq)
								$('#' + fbbt[j] + '__' + i).val($('#' + fbbt[j] + '__' + (i - 1)).val());
							else
								$('#' + fbbt[j] + '__' + i).val('');
						}
					}
				}
				$('#div_row').hide();
				row_bbsbbt = '';
				row_b_seq = '';
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview td {
				padding: 2px;
				/*text-align: center;*/
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 68%;
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
				/*width: 9%;*/
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
			.txt.c5 {
				width: 75%;
				float: left;
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
			.tbbm td input[type="button"] {
				/*float: left;*/
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbs select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbs a {
				font-size: medium;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 1415px;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
			#div_assm {
				display: none;
				width: 750px;
				background-color: #FFAC55;
				border: 5px solid gray;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
			#div_assm .tdY {
				width: 98%;
			}
			#div_row {
				display: none;
				width: 750px;
				background-color: #ffffff;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
			.table_row tr td .lbl.btn {
				color: #000000;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
			.table_row tr td .lbl.btn:hover {
				color: #FF8F19;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row" class="table_row" style="width:100%;" border="1" cellpadding='1' cellspacing='0'>
				<tr>
					<td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
				</tr>
				<tr>
					<td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
				</tr>
			</table>
		</div>
		<div id="div_assm" style="position:absolute; top:300px; left:500px; display:none; width:500px; background-color: #FFAC55; border: 5px solid gray;">
			<table id="table_assm" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr id='assm_top'>
					<td align="center" style="width: 40%;">品號 </td>
					<td align="center" style="width: 45%;">品名</td>
					<td align="center" style="width: 15%;">數量</td>
				</tr>
				<tr id='assm_close'>
					<td align="center" colspan='3'>
					<input id="btnCheck_div_assm" type="button" value="確認">
					<input id="btnClose_div_assm" type="button" value="關閉視窗">
					<input id="bbt_b_seq" type="hidden"/>
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:hidden; width: 1260px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left; width:400px;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="word-break: break-all;background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:40px"><a id='vewChk'> </a></td>
						<td align="center" style="width:150px"><a id='vewNoa'> </a></td>
						<td align="center" style="width:210px"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa'>~noa</td>
						<td id='product spec'>~product ~spec</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 850px;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0' >
					<tr style="height:1px;">
						<td style="width:100px;"> </td>
						<td style="width:190px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:170px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:190px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblKdate" class="lbl"> </a></td>
						<td><input id="txtKdate" type="text" class="txt c1" style="width:65%;"/></td>
						<td><span> </span><a id="lblWdate" class="lbl"> </a></td>
						<td><input id="txtWdate" type="text" class="txt c1" style="width:65%;"/></td>
					</tr>
					<tr>
						<!--<td><span> </span><a id="lblType" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1" style="font-size: medium;"> </select></td>-->
						<td><span> </span><a id="lblProduct" class="lbl"> </a></td>
						<td colspan='4'><input id="txtProduct" type="text" class="txt c1"/></td>
						<td><input id="btnUploadimg" type="button" />
							<input id="btnCub_r" type="button" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblEngpro" class="lbl"> </a></td>
						<td colspan='5'><input id="txtEngpro" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSpec" class="lbl"> </a></td>
						<td><input id="txtSpec" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblUnit" class="lbl"> </a></td>
						<td><input id="txtUnit" type="text" class="txt c1" style="width: 50%;"/></td>
						<td><span> </span><a id="lblUweight" class="lbl"> </a></td>
						<td><input id="txtUweight" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td>
							<span> </span><a id="lblTgg" class="lbl btn"> </a>
							<input type="checkbox" id="chkIsoutsource" style="float:right;">
						</td>
						<td>
							<input id="txtTggno" type="text" class="txt" style="width: 45%;"/>
							<input id="txtComp" type="text" class="txt" style="width: 53%;"/>
						</td>
						<td><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblStdmount" class="lbl" > </a></td>
						<td><input id="txtStdmount" type="text" class="txt c1 num" style="width:30%;"/>
							<span style="float: left;"> </span>
							<a id="lblSafemount" class="lbl" style="float: left;"> </a>
							<span style="float: left;"> </span>
							<input id="txtSafemount" type="text" class="txt c1 num" style="width:30%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStyle" class="lbl"> </a></td>
						<td><input id="txtStyle" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblGroupano" class="lbl"> </a></td>
						<td><select id="cmbGroupano" class="txt c1" style="font-size: medium;"> </select></td>
						<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td><input id="txtOrdeno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProcess" class="lbl btn"> </a></td>
						<td>
							<input id="txtProcessno" type="text" class="txt" style="width: 45%;"/>
							<input id="txtProcess" type="text" class="txt" style="width: 53%;"/>
						</td>
						<td><span> </span><a id="lblStation" class="lbl btn"> </a></td>
						<td>
							<input id="txtStationno" type="text" class="txt" style="width: 45%;"/>
							<input id="txtStation" type="text" class="txt" style="width: 53%;"/>
						</td>
						<td><span> </span><a id="lblStationg" class="lbl btn"> </a></td>
						<td>
							<input id="txtStationgno" type="text" class="txt" style="width: 45%;"/>
							<input id="txtStationg" type="text" class="txt" style="width: 53%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblHours" class="lbl"> </a></td>
						<td>
							<input id="txtHours" type="text" class="txt num" style="width:30%;"/>
							<span style="float:left;width:15%;padding-left:3px;">Hr.</span>
							<input id="txtMinutes" type="text" class="txt num" style="width:30%;"/>
							<span style="float:left;width:15%;padding-left:3px;">Min.</span>
						</td>
						<td><span> </span><a id="lblPredaytime" class="lbl"> </a></td>
						<td>
							<input id="txtPreday" type="text" class="txt num" style="width:30%;"/>
							<span style="float:left;width:18%;padding-left:3px;">Day</span>
							<input id="txtPretime" type="text" class="txt num" style="width:30%;"/>
							<span style="float:left;width:15%;padding-left:3px;">Hr.</span>
						</td>
						<td><span> </span><a id="lblBadperc" class="lbl"> </a></td>
						<td>
							<input id="txtBadperc" type="text" class="txt c1 num" style="width:35%;"/>
							<span style="float: left;width: 10px;"> </span>
							<a id="lblMoq" class="lbl" style="float: left;"> </a><!--最低採購量-->
							<span style="float: left;"> </span>
							<input id="txtMoq" type="text" class="txt c1 num" style="width:35%;"/>
						</td>
					</tr>
					<tr>
						<!--
						<td><span> </span><a id="lblMechs" class="lbl" style="font-size: 14px;"> </a></td>
						<td><input id="txtMechs" type="text" class="txt c1 num"/></td>
						-->
						<td><span> </span><a id="lblMakes" class="lbl" style="font-size: 14px;"> </a></td>
						<td><input id="txtMakes" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblMolds" class="lbl" style="font-size: 14px;"> </a></td>
						<td><input id="txtMolds" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblPacks" class="lbl" style="font-size: 14px;"> </a></td>
						<td><input id="txtPacks" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWages" class="lbl" style="font-size: 14px;"> </a></td>
						<td><input id="txtWages" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblModel" class="lbl btn"> </a></td>
						<td>
							<input id="txtModelno" type="text" class="txt" style="width: 45%;"/>
							<input id="txtModel" type="text" class="txt" style="width: 53%;"/>
						</td>
						<td style="display: none;"><span> </span><a id="lblRev" class="lbl" > </a></td>
						<td style="display: none;"><input id="txtRev" type="text" class="txt c1" style="width: 30%;"/></td>
						<td colspan="2">
							<span style="float: left;"> </span><input id="btnModel" type="button" />
							<span style="float: left;"> </span><input id="btnCustproduct" type="button" />
 							<span style="float: left;"> </span><input id="btnPack2" type="button" />
 							<input id="btnUcctd" type="button" style="display: none;"/>
						</td>
						<!--
						<td><span> </span><a id="lblTrans" class="lbl"> </a></td>
						<td><input id="txtTrans" type="text" class="txt c1 num"/></td>
						-->
					</tr>
					<tr>
						<td><span> </span><a id="lblCost" class="lbl"> </a></td>
						<td><input id="txtCost" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblUcano" class="lbl"> </a></td>
						<td><input id="txtUcano" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblUccno" class="lbl"> </a></td>
						<td><input id="txtUccno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='3'>
							<input id="txtMemo" type="text" class="txt c1" style="width: 99%;"/>
							<input type="hidden" id="txtImages" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblSssno" class="lbl"> </a></td>
						<td>
							<input id="txtSssno" type="text" class="txt" style="width: 45%;"/>
							<input id="txtNamea" type="text" class="txt" style="width: 53%;"/>
						</td>
					</tr>
					<input id="text_Noq" type="hidden" />
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1350px;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:200px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:260px;"><a id='lblProducts'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount'> </a></td>
					<!--<td align="center" style="width:8%;"><a id='lblWeights'></a></td>-->
					<td align="center" style="width:100px;"><a id='lblCost_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMtype_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProcessno_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblLoss_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDividea_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMul_s'> </a></td>
					<!--<td align="center" style="width:15%;"><a id='lblTd'></a></td>-->
					<td align="center" style="width:200px;"><a id='lblMemos'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;float: left;" />
						<input id="txtProductno.*" type="text" class="txt c1" style="width: 85%;"/>
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtUnit.*" type="text" class="txt c1" style="text-align:center;"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<!--<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>-->
					<td><input id="txtCost.*" type="text" class="txt num c1"/></td>
					<td><select id="cmbMtype.*" class="txt c1"> </select></td>
					<td>
						<input class="btn" id="btnProcessno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtProcessno.*" type="text" style="width: 75%;"/>
						<input id="txtProcess.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtLoss.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDividea.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMul.*" type="text" class="txt num c1"/></td>
					<!--<td>
					<input class="btn" id="btnTproductno.*" type="button" value='.' style=" font-weight: bold;" />
					<input id="txtTd.*" type="text" style="width: 80%;"/>
					</td>-->
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<div id="dbbt" style="display: none;" >
			<table id="tbbt" class='tbbt' border="1" cellpadding='2' cellspacing='1'>
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:40px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:145px;"><a id='lblProcess_t'> </a></td>
					<td align="center" style="width:145px;"><a id='lblTgg_t'> </a></td>
					<td align="center" style="width:145px;"><a id='lblStation_t'> </a></td>
					<!--<td align="center" style="width:8%;"><a id='lblMount_t'></a></td>-->
					<td align="center" style="width:100px;"><a id='lblPrice_t'> </a></td>
					<!--<td align="center" style="width:8%;"><a id='lblEndmount_t'></a></td>-->
					<td align="center" style="width:75px;"><a id='lblHours_t'> </a></td>
					<td align="center" style="width:175px;"><a id='lblProductno_t'> </a></td>
					<td align="center" style="width:190px;"><a id='lblAssm_t'> </a></td>
					<td align="center" style="width:87px;"><a id='lblWages_t'> </a></td>
					<td align="center" style="width:87px;"><a id='lblMakes_t'> </a></td>
					<td align="center" style="width:103px;"><a id='lblWages_fee_t'> </a></td>
					<td align="center" style="width:103px;"><a id='lblMakes_fee_t'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProcessno..*" type="text" class="txt c5"/>
						<input id="btnProcessno..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input id="txtProcess..*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtTggno..*" type="text" class="txt c5"/>
						<input id="btnTggno..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input id="txtNick..*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtStationno..*" type="text" class="txt c5"/>
						<input id="btnStation..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input id="txtStation..*" type="text" class="txt c1"/>
					</td>
					<!--<td>
					<input id="txtMount..*" type="text" class="txt c1 num"/>
					<input id="txtWeight..*" type="text" class="txt c1 num"/>
					</td>-->
					<td><input id="txtPrice..*" type="text" class="txt c1 num"/></td>
					<!--<td>
					<input id="txtEndmount..*" type="text" class="txt c1 num"/>
					<input id="txtEndweight..*" type="text" class="txt c1 num"/>
					</td>-->
					<td><input id="txtHours..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td>
						<input id="btnAssm..*" type="button" value='.' style=" font-weight: bold;width:1%; float: left;" />
						<input id="txtAssm..*" type="text" class="txt" style="width: 80%"/>
					</td>
					<td><input id="txtWages..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMakes..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWages_fee..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMakes_fee..*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
		<div class='images' style="float: left;"> </div>
		<input id="q_sys" type="hidden" />
	</body>
</html>