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

			q_tables = 't';
			var q_name = "cub";
			var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
			var q_readonlys = [];
			var q_readonlyt = [];
			var bbmNum = [['txtTotal',15,3,1]];
			var bbsNum = [['txtWeight',10,3,1]];
			var bbtNum = [['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1],['txtGweight',10,3,1],['txtWeight',10,3,1]];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			brwCount2 = 6;
			aPop = new Array(
				['txtMechno', 'lblMechno', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'],
				['txtProductno', 'lblProductno_pi', 'ucaucc', 'noa,product', 'txtProductno', 'ucaucc_b.aspx'], 
				['txtProductno_', '', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'], 
				['txtProductno2_', '', 'ucaucc', 'noa,product', 'txtProductno2_,txtProduct2_', 'ucaucc_b.aspx'],
				['txtUno__', 'btnUno__', 'view_uccc', 'uno,productno,radius,dime,width,lengthb,mount,weight,spec,class', 'txtUno__,txtProductno__,txtRadius__,txtDime__,txtWidth__,txtLengthb__,txtMount__,txtWeight__,txtSpec__,txtClass__', 'uccc_seek_b.aspx?;;;1=0','95%','60%']
			);
			function distinct(arr1){
				var uniArray = [];
				for(var i=0;i<arr1.length;i++){
					var val = arr1[i];
					if($.inArray(val, uniArray)===-1){
						uniArray.push(val);
					}
				}
				return uniArray;
			}
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('style', '', 0, 0, 0, '');
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				bbsMask = [['txtDatea', r_picd], ['txtDate2', r_picd], ['txtHdate', r_picd]];
				bbtMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('cubpi.typea'));
				$('#cmbTypea').change(function() {
					size_change();
				});
				$('#btnCubuImport').click(function(){
					var t_where = '1=1';
					var t_type = $('#cmbTypea').val();
					if(t_type=='2' || t_type=='3' || t_type=='4'){
						switch(t_type){
							case '2':
								t_where += ' and slit=1';
								break;
							case '3':
								t_where += ' and sale=1';
								break;
							case '4':
								t_where += ' and ordc=1';
								break;
							default:
								break;
						}
						t_where += " and noa !='"+trim($('#txtNoa').val())+"'";
						q_box("cubu2cub_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" +t_where, 'view_cubu2cub_'+t_type, "95%", "95%", q_getMsg('popCubu2Cub'));					
					}else{
						alert('切管、修端、包裝才有上製程匯入。');	
					}
				});
				$('#btnOrdeImport').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						var t_bdate = trim($('#txtBdate').val());
						var t_edate = trim($('#txtEdate').val());
						var t_bdime = dec($('#txtBdime').val());
						var t_edime = dec($('#txtEdime').val());
						var t_bradius = dec($('#txtRadius').val()) * 0.93;
						var t_eradius = dec($('#txtRadius').val());
						var t_bwidth = dec($('#txtWidth').val()) * 0.93;
						var t_ewidth = dec($('#txtWidth').val());
						var t_style = trim($('#txtStyle').val());
						var t_productno = trim($('#txtProductno').val());
						var t_mechno = trim($('#txtMechno').val());
						t_edate = (t_edate == '' ? 'char(255)' : t_edate);
						t_edime = (t_edime == 0 ? 9999 : t_edime);
						t_eradius = (t_eradius == 0 ? 9999 : t_eradius * 1.07);
						t_ewidth = (t_ewidth == 0 ? 9999 : t_ewidth * 1.07);
						var t_where = "1=1 and enda='0' and iscut='1' ";
						t_where += q_sqlPara2('odate', t_bdate, t_edate) + q_sqlPara2('dime', t_bdime, t_edime) + q_sqlPara2('radius', t_bradius, t_eradius) + q_sqlPara2('width', t_bwidth, t_ewidth) + q_sqlPara2('style', t_style) + q_sqlPara2('productno', t_productno) + q_sqlPara2('mechno', t_mechno);
						t_where += " and (notv > 0) and kind='B2'";
						q_box("ordests_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'view_ordes', "95%", "95%", q_getMsg('popOrde'));
						//q_gt('view_ordes', t_where, 0, 0, 0, "", r_accy);
					}
				});
				$('#btnCucImport').click(function() {
					if (q_cur == 1 || q_cur == 2) {
						var t_bdate = trim($('#txtBdate').val());
						var t_edate = trim($('#txtEdate').val());
						var t_bdime = dec($('#txtBdime').val());
						var t_edime = dec($('#txtEdime').val());
						var t_bradius = dec($('#txtRadius').val()) * 0.93;
						var t_eradius = dec($('#txtRadius').val());
						var t_bwidth = dec($('#txtWidth').val()) * 0.93;
						var t_ewidth = dec($('#txtWidth').val());
						var t_style = trim($('#txtStyle').val());
						var t_productno = trim($('#txtProductno').val());
						var t_mechno = trim($('#txtMechno').val());
						t_edate = (t_edate == '' ? 'char(255)' : t_edate);
						t_edime = (t_edime == 0 ? 9999 : t_edime);
						t_eradius = (t_eradius == 0 ? 9999 : t_eradius * 1.07);
						t_ewidth = (t_ewidth == 0 ? 9999 : t_ewidth * 1.07);
						var t_where = 'where=^^ 1=1 ';
						t_where += q_sqlPara2('a.udate', t_bdate, t_edate) + q_sqlPara2('a.dime', t_bdime, t_edime) + q_sqlPara2('a.radius', t_bradius, t_eradius) + q_sqlPara2('a.width', t_bwidth, t_ewidth) + q_sqlPara2('a.productno', t_productno) + q_sqlPara2('b.mechno', t_mechno);
						t_where += ' ^^';
						q_gt('cucs', t_where, 0, 0, 0, "", r_accy);
					}
				});
				$('#btnCubu').click(function() {
					if (q_cur == 0 || q_cur==4) {
						var t_where = "noa='" + trim($('#txtNoa').val()) + "'";
						q_box("cubu_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";"+r_accy, 'cubu', "95%", "95%", q_getMsg('popCubu'));
					}
				});
				$('#btnUccc_pi').click(function() {
					//var t_where = ' 1=1 and radius=0 ';
					var t_where = ' 1=1';
					var t_productno = trim($('#txtProductno').val());
					var t_bdime = dec($('#txtBdime').val());
					var t_edime = dec($('#txtEdime').val());
					var t_width = dec($('#txtWidth').val());
					var t_radius = dec($('#txtRadius').val());
					var t_style = ($('#txtStyle').val()).toUpperCase();
					var t_ewidth = 0;
					if (t_bdime == 0 && t_edime == 0) {
						t_edime = 9999;
					}
					if($('#cmbTypea').val() == '1'){
						t_where +=" and (charindex('帶',product) != 0) ";
						var t_bbsProduct = $('#txtProduct_0').val();
						var a1 = dec($('#txtRadius_0').val());
						var a2 = dec($('#txtWidth_0').val());
						var a3 = dec($('#txtDime_0').val());
						var a4 = dec($('#txtLengthb_0').val());
						var t_width = a2;
						t_width=(t_bbsProduct.indexOf('方管')>-1?((t_width==0?4:2)*a1)+(2*a2-a3*3.5):t_width);
						t_width=(t_bbsProduct.substring(0,1)=='圓'?3.1416*a1-a3*3.5:t_width);
						t_width=(t_bbsProduct.indexOf('橢圓管')>-1?(3.1416*a1+(a2-a1)*2-a3*3.5-5):t_width);
						t_width=(t_bbsProduct.indexOf('橢圓形')>-1?(1.5*a1+1.5*a2-a3*3.5):t_width);
						t_ewidth=t_width * 1.2;
						if(a3 > 0){
							t_bdime = a3-0.07;
							t_edime = a3+0.07;
						}else{
							t_bdime = dec($('#txtBdime').val());
							t_edime = dec($('#txtEdime').val());
							if(t_edime == 0) t_edime = t_bdime+0.07;
						}
						if(t_width > 0 || t_ewidth >0)
							t_where += q_sqlPara2('width',t_width,t_ewidth);
					}else{
						t_where += " and width >=" + t_width;
					}
					if (getProductWhere().length > 2)
						t_where += " and (productno in(" + getProductWhere() + ")) ";
					t_where += " and (dime between " + t_bdime + " and " + t_edime + ") ";
					q_box("uccc_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'uccc', "95%", "750px", q_getMsg('popUccc'));
				});
			}

			function getProductWhere() {
				var tempArray = new Array();
				tempArray.push($('#txtProductno').val());
				for (var j = 0; j < q_bbsCount; j++) {
					var t_productno = trim($('#txtProductno_' + j).val());
					var t_productno2 = trim($('#txtProductno2_' + j).val());
					if(t_productno.length >0)
						tempArray.push($('#txtProductno_' + j).val());
					if(t_productno2.length >0)
						tempArray.push($('#txtProductno2_' + j).val());
				}
				var TmpStr = distinct(tempArray).sort();

				TmpStr = TmpStr.toString().replace(/,/g, "','").replace(/^/, "'").replace(/$/, "'");
				return TmpStr;
			}
			
			function getTheory(b_seq) {
				t_Radius = $('#txtRadius_' + b_seq).val();
				t_Width = $('#txtWidth_' + b_seq).val();
				t_Dime = $('#txtDime_' + b_seq).val();
				t_Lengthb = $('#txtLengthb_' + b_seq).val();
				t_Mount = $('#txtMount_' + b_seq).val();
				t_Style = $('#txtStyle_' + b_seq).val();
                t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting={
					calc:StyleList,
					ucc:t_uccArray,
					radius:t_Radius,
					width:t_Width,
					dime:t_Dime,
					lengthb:t_Lengthb,
					mount:t_Mount,
					style:t_Style,
					productno:t_Productno,
					round:3
				};
				return theory_st(theory_setting);
			}

			function getBBSWhere(objname) {
				var tempArray = new Array();
				for (var j = 0; j < q_bbsCount; j++) {
					var thisVal = $.trim($('#txt' + objname + '_' + j).val());
					if(thisVal.length > 0)
						tempArray.push($('#txt' + objname + '_' + j).val());
				}
				var TmpStr = distinct(tempArray).sort();
				TmpStr = TmpStr.toString().replace(/,/g, "','").replace(/^/, "'").replace(/$/, "'");
				return TmpStr;
			}
			
			var StyleList = '';
			var t_uccArray = new Array;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'view_ordes':
						var wret = '';
						var chkWhere = 'where=^^';
						var as = _q_appendData("view_ordes", "", true);
						if (as[0] != undefined) {
							q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtCustno,txtProductno,txtProduct,txtRadius,txtWidth,txtDime,txtLengthb,txtMount,txtDate2,txtStyle', as.length, as, 'noa,no2,custno,productno,product,radius,width,dime,lengthb,mount,odate,style', '');
						} else {
							//alert('無符合的訂單，檢查條件是否輸入有誤。');
						}
						sum();
						var chkWhere = 'where=^^ a.noa in(' + getBBSWhere('Ordeno') + ') and (isnull(a.mount,0)-isnull(b.mount,0))>0 ^^';
						q_gt('cub_ordechk', chkWhere, 0, 0, 0, "", r_accy);
						break;
					case 'cucs':
						var wret = '';
						var as = _q_appendData("cucs", "", true);
						if (as[0] != undefined) {
							q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtCustno,txtProductno,txtProduct,txtRadius,txtWidth,txtDime,txtLengthb,txtMount,txtDate2', as.length, as, 'ordeno,no2,custno,productno,product,radius,width,dime,lengthb,mount,udate', '');
						}
						sum();
						var chkWhere = 'where=^^ a.noa in(' + getBBSWhere('Ordeno') + ') and (isnull(a.mount,0)-isnull(b.mount,0))>0  ^^';
						q_gt('cub_ordechk', chkWhere, 0, 0, 0, "", r_accy);
						break;
					case 'cub_ordechk':
						var as = _q_appendData("cub_ordechk", "", true);
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								for (var j = 0; j < q_bbsCount; j++) {
									var t_ordeno = $('#txtOrdeno_' + j).val();
									var t_no2 = $('#txtNo2_' + j).val();
									var t_mount = dec($('#txtMount_' + j).val());
									if (t_ordeno == as[i].ordeno && t_no2 == as[i].no2) {
										if (dec(as[i].mount) < 0)
											$('#txtMount_' + j).val(0);
										if ((dec(as[i].mount) - t_mount) < 0 && dec(as[i].mount) > 0)
											$('#txtMount_' + j).val(dec(as[i].mount));
										break;
									}
								}
							}
						}
						break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'view_ordes':
						var wret = '';
						var chkWhere = 'where=^^';
						var as = getb_ret();
						if (as && as[0] != undefined) {
							q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtCustno,txtProductno,txtProduct,txtRadius,txtWidth,txtDime,txtLengthb,txtMount,txtDate2,txtStyle', as.length, as, 'noa,no2,custno,productno,product,radius,width,dime,lengthb,mount,odate,style', '');
						} else {
							//alert('無符合的訂單，檢查條件是否輸入有誤。');
						}
						sum();
						var chkWhere = 'where=^^ a.noa in(' + getBBSWhere('Ordeno') + ') and (isnull(a.mount,0)-isnull(b.mount,0))>0 ^^';
						q_gt('cub_ordechk', chkWhere, 0, 0, 0, "", r_accy);
						break;
					case 'uccc':
						b_ret = getb_ret();
						if (!b_ret || b_ret.length == 0){
							b_pop = '';
							return;
						}
						if (q_cur > 0 && q_cur < 4) {
							for (var j = 0; j < b_ret.length; j++) {
								for (var i = 0; i < q_bbtCount; i++) {
									var t_uno = $('#txtUno__' + i).val();
									if (b_ret[j] && b_ret[j].uno == t_uno) {
										b_ret.splice(j, 1);
									}
								}
							}
							if (b_ret[0] != undefined) {
								ret = q_gridAddRow(bbtHtm, 'tbbt', 'txtProductno,txtUno,txtMount,txtWeight,txtRadius,txtDime,txtWidth,txtLengthb,txtSpec,txtClass', b_ret.length, b_ret, 'productno,uno,emount,eweight,radius,dime,width,lengthb,spec,class', 'txtUno', '__');
								/// 最後 aEmpField 不可以有【數字欄位】
								size_change();
								bbtAssign();
							}
							sum();
							b_ret = '';
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
					default: 
						if(b_pop.substring(0,14)=='view_cubu2cub_'){
							t_type = b_pop.replace('view_cubu2cub_','');
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0){
								b_pop = '';
								return;
							}
							if (b_ret[0] != undefined) {
								bbs_ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtCustno,txtProductno,txtProduct,txtMount,txtWeight,txtRadius,txtDime,txtWidth,txtLengthb', b_ret.length, b_ret, 'ordeno,no2,custno,productno,product,emount,eweight,radius,dime,width,lengthb', 'txtOrdeno,txtNo2');
								bbt_ret = q_gridAddRow(bbtHtm, 'tbbt', 'txtProductno,txtUno,txtMount,txtWeight,txtRadius,txtDime,txtWidth,txtLengthb,txtClass,txtSpec', b_ret.length, b_ret, 'productno,uno,emount,eweight,radius,dime,width,lengthb,class,spec', 'txtUno', '__');
								/// 最後 aEmpField 不可以有【數字欄位】
								for(var k=0;k<bbs_ret.length;k++){
									$('#chkCut_'+bbs_ret[k]).attr('checked',b_ret[k].cut+''=='true');
									$('#chkSlit_'+bbs_ret[k]).attr('checked',b_ret[k].slit+''=='true');
									$('#chkSale_'+bbs_ret[k]).attr('checked',b_ret[k].sale+''=='true');
									$('#chkOrdc_'+bbs_ret[k]).attr('checked',b_ret[k].ordc+''=='true');
										
									if(t_type=='2'){
										$('#chkCut_'+bbs_ret[k]).attr('checked',false);
									}
									if(t_type=='3'){
										$('#chkCut_'+bbs_ret[k]).attr('checked',false);
										$('#chkSlit_'+bbs_ret[k]).attr('checked',false);
									}
									if(t_type=='4'){
										$('#chkCut_'+bbs_ret[k]).attr('checked',false);
										$('#chkSlit_'+bbs_ret[k]).attr('checked',false);
										$('#chkSale_'+bbs_ret[k]).attr('checked',false);
									}
								}
								bbsAssign();
								bbtAssign();
								size_change();
							}
						}
						break;
				}
				size_change();
				b_pop = '';
			}

			function sum() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#txtWeight_'+j).val(getTheory(j));
				}
				var t_gweight = 0;
				for(var i=0;i<q_bbtCount;i++){
					t_gweight +=dec($('#txtGweight__'+i).val());
				}
				$('#txtTotal').val(t_gweight);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('cubpi_s.aspx', q_name + '_s', "530px", "650px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtCno').val('1');
				$('#txtAcomp').val((q_getPara('sys.comp').substring(0,3)=='裕承隆'?q_getPara('sys.comp').substring(0,3):q_getPara('sys.comp').substring(0,2)));
				size_change();
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				size_change();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box('z_cubpip.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				for(var k=0;k<q_bbtCount;k++){
					var t_indate = trim($('#txtDatea__'+k).val());
					if(t_indate.length == 0){
						$('#txtDatea__'+k).val(q_date());
					}
				}
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				if (q_cur == 1) {
					$('#txtWorker').val(r_name);
				} else {
					$('#txtWorker2').val(r_name);
				}
                sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if ( as['cut']+""!="true" && as['slit']+""!="true" && as['sale']+""!="true" && as['ordc']+""!="true" && parseFloat(as['mount'].length==0?"0":as['mount'])==0 && parseFloat(as['weight'].length==0?"0":as['weight'])==0) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function bbtSave(as) {
				if (!as['uno']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				if(r_rank < 9){
                	$('#btnCucImport').css('display','none');
                }

				size_change();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				size_change();
                var WantDisabledArray = ['btnOrdeImport','btnUccc_pi','btnCucImport','btnCubuImport'];
                for(var k=0;k<WantDisabledArray.length;k++){
                	if(q_cur==1 || q_cur ==2){
                		$("#"+WantDisabledArray[k]).removeAttr('disabled','disabled');
                	}else{
                		$("#"+WantDisabledArray[k]).attr('disabled','disabled');
                	}
                }
				if (q_cur == 0 && trim($('#txtNoa').val()) != '')
					$('#btnCubu').removeAttr('disabled');
				else
					$('#btnCubu').attr('disabled', 'disabled');
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				size_change();
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#txtDime_' + i).change(function() {
							sum();
						});
						$('#txtMount_' + i).change(function() {
							var getOrdeno = $.trim(getBBSWhere('Ordeno')).replace(/\'\'/, '');
							if(getOrdeno.length != ''){
								var chkWhere = 'where=^^ a.noa in(' + getOrdeno + ') ^^';
								q_gt('cub_ordechk', chkWhere, 0, 0, 0, "", r_accy);
							}
						});
					}
				}
				_bbsAssign();
				size_change();
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
						$('#textSize1__' + i).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if ($('#cmbTypea').find("option:selected").text() == '製管') {
								q_tr('txtDime__' + n, q_float('textSize1__' + n));
							} else {
								q_tr('txtRadius__' + n, q_float('textSize1__' + n));
							}
							sum();
						});
						$('#textSize2__' + i).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if ($('#cmbTypea').find("option:selected").text() == '製管') {
								q_tr('txtWidth__' + n, q_float('textSize2__' + n));
							} else {
								q_tr('txtWidth__' + n, q_float('textSize2__' + n));
							}
							sum();
						});
						$('#textSize3__' + i).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if ($('#cmbTypea').find("option:selected").text() == '製管') {
								q_tr('txtLengthb__' + n, q_float('textSize3__' + n));
							} else {
								q_tr('txtDime__' + n, q_float('textSize3__' + n));
							}
							sum();
						});
						$('#textSize4__' + i).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							if ($('#cmbTypea').find("option:selected").text() == '製管') {
								q_tr('txtRadius__' + n, q_float('textSize4__' + n));
							} else {
								q_tr('txtLengthb__' + n, q_float('textSize4__' + n));
							}
							sum();
						});
						$('#txtGmount__' + i).change(function() {
							var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
							var thisVal = dec($(this).val());
							var t_Mount = dec($('#txtMount__'+n).val());
							var t_Weight = dec($('#txtWeight__'+n).val());
							if(thisVal > t_Mount)
								$(this).val(t_Mount);
							if(t_Mount > 0 && t_Weight > 0){
								var newVal = round(q_mul(q_div(t_Weight,t_Mount),thisVal),0);
								newVal = (isNaN(newVal)?0:newVal);
								$('#txtGweight__'+n).val(round(q_mul(q_div(t_Weight,t_Mount),thisVal),0));
							}
							sum();
						});
						$('#txtGweight__' + i).change(function() {
							sum();
						});
					}
				}
				_bbtAssign();
				size_change();
			}

			function q_appendData(t_Table) {
				return _q_appendData(t_Table);
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

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			function size_change() {
				if (q_cur == 1 || q_cur == 2) {
					$('input[id*="textSize"]').removeAttr('disabled');
				} else {
					$('input[id*="textSize"]').attr('disabled', 'disabled');
				}
				if ($('#cmbTypea').find("option:selected").text() == '製管') {
					$('#lblSize_help').text(q_getPara('sys.lblSizea'));
					for (var j = 0; j < q_bbtCount; j++) {
						$('#textSize1__' + j).show();
						$('#textSize2__' + j).show();
						$('#textSize3__' + j).show();
						$('#textSize4__' + j).hide();
						$('#x1__' + j).show();
						$('#x2__' + j).show();
						$('#x3__' + j).hide();
						$('#Size').css('width', '230px');
						$('#textSize1__' + j).val($('#txtDime__' + j).val());
						$('#textSize2__' + j).val($('#txtWidth__' + j).val());
						$('#textSize3__' + j).val($('#txtLengthb__' + j).val());
						$('#textSize4__' + j).val(0);
						$('#txtRadius__' + j).val(0);
					}
				} else {
					$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
					for (var j = 0; j < q_bbtCount; j++) {
						$('#textSize1__' + j).show();
						$('#textSize2__' + j).show();
						$('#textSize3__' + j).show();
						$('#textSize4__' + j).show();
						$('#x1__' + j).show();
						$('#x2__' + j).show();
						$('#x3__' + j).show();
						$('#Size').css('width', '330px');
						$('#textSize1__' + j).val($('#txtRadius__' + j).val());
						$('#textSize2__' + j).val($('#txtWidth__' + j).val());
						$('#textSize3__' + j).val($('#txtDime__' + j).val());
						$('#textSize4__' + j).val($('#txtLengthb__' + j).val());
					}
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				width: 300px;
				border-width: 0px;
			}
			.tview {
				border: 5px solid gray;
				font-size: medium;
				background-color: black;
			}
			.tview tr {
				height: 30px;
			}
			.tview td {
				padding: 2px;
				text-align: center;
				border-width: 0px;
				background-color: #FFFF66;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 1000px;
				/*margin: -1px;
				 border: 1px black solid;*/
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
				width: 8%;
			}
			.tbbm .tdZ {
				width: 1%;
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
				width: 95%;
				float: left;
			}
			.txt.c2 {
				width: 35%;
				float: left;
			}
			.txt.c3 {
				width: 120px;
				float: left;
			}
			.txt.c8 {
				float: left;
				width: 65px;
			}
			.num {
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
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs {
				width: 2500px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				/*background: #cad3ff;*/
				background: lightgrey;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			.dbbs .tbbs select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			#dbbt {
				width: 1320px;
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
				width: 100%;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1300px;">
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewTypea'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='typea=cubpi.typea'>~typea=cubpi.typea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td style="width:9%;"> </td>
						<td style="width:9%;"> </td>
						<td style="width:9%;"> </td>
						<td style="width:6%;"> </td>
						<td style="width:6%;"> </td>
						<td style="width:5%;"> </td>
						<td style="width:6%;"> </td>
						<td style="width:5%;"> </td>
						<td style="width:9%;"> </td>
						<td style="width:9%;"> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblVcceno" class="lbl"> </a></td>
						<td><input id="txtVcceno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBdate" class="lbl" > </a></td>
						<td colspan="3">
							<input id="txtBdate" type="text" style="width:45%;"/>
							<span style="float:left; display:block; width:20px;"><a> ～ </a></span>
							<input id="txtEdate" type="text" style="width:45%;"/>
						</td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMechno" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtMechno" type="text" style="width:30%;"/>
							<input id="txtMech" type="text" style="width:65%;"/>
						</td>
						<td colspan="9"> </td>
						<td><input type="button" id="btnOrdeImport"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProductno_pi" class="lbl btn" > </a></td>
						<td><input id="txtProductno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblStyle_pi" class="lbl"> </a></td>
						<td><input id="txtStyle" type="text" class="txt c2"/></td>
						<td><span> </span><a id="lblRadius_pi" class="lbl" > </a></td>
						<td><input id="txtRadius" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblWidth_pi" class="lbl" > </a></td>
						<td><input id="txtWidth" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblBdime" class="lbl" > </a></td>
						<td colspan="3">
							<input id="txtBdime" type="text" style="width:40%;" class="txt num"/>
							<span style="float:left; display:block; width:20px;"><a> ～ </a></span>
							<input id="txtEdime" type="text" style="width:40%;" class="txt num"/>
						</td>
						<td><input type="button" id="btnUccc_pi"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2_pi" class="lbl" > </a></td>
						<td colspan="10"><input id="txtMemo2"  type="text" class="txt c1"/></td>
						<td><input type="button" id="btnCucImport"></td>
						<td><input type="button" id="btnCubu"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo_pi" class="lbl" > </a></td>
						<td colspan="10"><input id="txtMemo" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input type="button" id="btnCubuImport"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td colspan="2"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td colspan="2"><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTotal" class="lbl" > </a></td>
						<td colspan="2"><input id="txtTotal" type="text" class="txt c1 num"/></td>
					</tr>
				</table>
			</div>

		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
					<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:150px;"><a id='lbl_ordeno'> </a></td>
					<td style="width:60px;"><a id='lbl_no2'> </a></td>
					<td style="width:120px;"><a id='lbl_custno'> </a></td>
					<td style="width:150px;"><a id='lbl_productno_pi'> </a></td>
					<td style="width:180px;"><a id='lbl_product_pi'> </a></td>
					<td style="width:100px;"><a id='lbl_radius_pi'> </a></td>
					<td style="width:100px;"><a id='lbl_widths_pi'> </a></td>
					<td style="width:100px;"><a id='lbl_dime'> </a></td>
					<td style="width:100px;"><a id='lbl_lengthb'> </a></td>
					<td style="width:100px;"><a id='lbl_mount'> </a></td>
					<td style="width:100px;"><a id='lbl_weight_pi'> </a></td>
					<td style="width:60px;"><a id='lbl_cut_pi'> </a></td>
					<td style="width:60px;"><a id='lbl_slit_pi'> </a></td>
					<td style="width:60px;"><a id='lbl_sale_pi'> </a></td>
					<td style="width:60px;"><a id='lbl_ordc_pi'> </a></td>
					<td style="width:150px;"><a id='lbl_productno2_pi'> </a></td>
					<td style="width:180px;"><a id='lbl_product2_pi'> </a></td>
					<td style="width:100px;"><a id='lbl_wmount_pi'> </a></td>
					<td style="width:80px;"><a id='lbl_lengthb2_pi'> </a></td>
					<td style="width:150px;"><a id='lbl_memo'> </a></td>
					<td style="width:80px;"><a id='lbl_hmount'> </a></td>
					<td style="width:80px;"><a id='lbl_hweight'> </a></td>
					<td style="width:150px;"><a id='lbl_uno'> </a></td>
					<td style="width:120px;"><a id='lbl_date2'> </a></td>
					<td style="width:120px;"><a id='lbl_datea'> </a></td>
					<td style="width:60px;"><a id='lbl_enda'> </a></td>
					<td style="width:60px;"><a id='lbl_hend'> </a></td>
					<td style="width:120px;"><a id='lbl_hdate_pi'> </a></td>
					<td style="width:120px;"><a id='lbl_spec'> </a></td>
					<td style="width:30px;"><a id='lbl_Style'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
					<td><input id="txtNo2.*" type="text" class="txt c1"/></td>
					<td><input id="txtCustno.*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtRadius.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWidth.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtDime.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td><input id="chkCut.*" type="checkbox"></td>
					<td><input id="chkSlit.*" type="checkbox"></td>
					<td><input id="chkSale.*" type="checkbox"></td>
					<td><input id="chkOrdc.*" type="checkbox"></td>
					<td><input id="txtProductno2.*" type="text" class="txt c1"/></td>
					<td><input id="txtProduct2.*" type="text" class="txt c1"/></td>
					<td><input id="txtWmount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLengthb2.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
					<td><input id="txtHmount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtHweight.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUno.*" type="text" class="txt c1"/></td>
					<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
					<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
					<td><input id="chkEnda.*" type="checkbox"/></td>
					<td><input id="chkHend.*" type="checkbox"/></td>
					<td><input id="txtHdate.*" type="text" class="txt c1"/></td>
					<td><input id="txtBspec.*" type="text" class="txt c1"/></td>
					<td><input id="txtStyle.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt'>
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;">
					<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:250px; text-align: center;">原料批號</td>
					<td style="width:120px; text-align: center;">材質</td>
					<td style="width:120px; text-align: center;">等級</td>
					<td align="center" id='Size'><a id='lblSize_help'> </a>
					<BR>
					<a id='lblSize_st'> </a></td>
					<td style="width:100px; text-align: center;">數量</td>
					<td style="width:100px; text-align: center;">重量</td>
					<td style="width:100px; text-align: center;">耗用數</td>
					<td style="width:100px; text-align: center;">耗料重</td>
					<td style="width:100px; text-align: center;">領料日</td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnUno..*" type="button" value="." style="width:5%;"/>
						<input id="txtUno..*" type="text" style="width:80%;"/>
					</td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td><input id="txtClass..*" type="text" class="txt c1"/></td>
					<td>
						<input class="txt num c8" id="textSize1..*" type="text" disabled="disabled"/>
						<div id="x1..*" style="float: left">x</div>
						<input class="txt num c8" id="textSize2..*" type="text" disabled="disabled"/>
						<div id="x2..*" style="float: left">x</div>
						<input class="txt num c8" id="textSize3..*" type="text" disabled="disabled"/>
						<div id="x3..*" style="float: left">x</div>
						<input class="txt num c8" id="textSize4..*" type="text" disabled="disabled"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius..*" type="hidden"/>
						<input id="txtWidth..*" type="hidden"/>
						<input id="txtDime..*" type="hidden"/>
						<input id="txtLengthb..*" type="hidden"/>
						<input id="txtSpec..*" type="text"  class="txt c1"/>
					</td>
					<td><input id="txtMount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGmount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGweight..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtDatea..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>