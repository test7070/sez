<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
			var q_name = "tranorde";
			var q_readonly = ['txtNoa', 'txtTranquatno','txtTweight2','txtTtrannumber', 'txtTranquatnoq', 'txtContract', 'txtWorker', 'txtWorker2','txtCasetype','txtCasetype2'];
			var q_readonlys = [];
			var bbsNum = [];
			var bbsMask = new Array(['txtTrandate', '999/99/99']);
			var bbtMask = new Array(['txtDatea', '999/99/99']);
			var bbmNum = new Array();
			var bbmMask = new Array(['txtDatea', '999/99/99'], ['txtDldate', '999/99/99'], ['txtCldate', '999/99/99'], 
					['txtNodate', '999/99/99'], ['txtMadate', '999/99/99'], ['txtRedate', '999/99/99'], ['txtStrdate', '999/99/99'],
					['textOrdet_Datea_1', '999/99/99'], ['textOrdet_Datea_2', '999/99/99'], ['textOrdet_Datea_3', '999/99/99'], ['textOrdet_Datea_4', '999/99/99'], ['textOrdet_Datea_5', '999/99/99']);
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_alias = '';
			q_desc = 1;
			q_xchg = 1;
			brwCount2 = 15;
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'], 
			['txtComp', 'lblCust', 'cust', 'comp,noa,nick', '0txtComp,txtCustno,txtNick', 'cust_b.aspx'],
			['txtProductno', 'lblProduct', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],	
			['txtDeliveryno', 'lblDeliveryno', 'trando', 'deliveryno,po', 'txtDeliveryno,txtPo', 'trando_b.aspx'],
			['txtCasepackaddr', 'lblCasepackaddr', 'addrcase', 'addr,noa', 'txtCasepackaddr', 'addrcase_b.aspx'],
			['txtCaseopenaddr', 'lblCaseopenaddr', 'addrcase', 'addr,noa', 'txtCaseopenaddr', 'addrcase_b.aspx'], 
			['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
			['textAddrno1', 'btnAddr1', 'addr', 'noa,addr', 'textAddrno1,textAddr1', 'addr_b.aspx'],
			['textAddrno2', 'btnAddr2', 'addr', 'noa,addr', 'textAddrno2,textAddr2', 'addr_b.aspx'],
			['textAddrno3', 'btnAddr3', 'addr', 'noa,addr', 'textAddrno3,textAddr3', 'addr_b.aspx'],
			['textAddrno4', 'btnAddr4', 'addr', 'noa,addr', 'textAddrno4,textAddr4', 'addr_b.aspx'],
			['textAddrno5', 'btnAddr5', 'addr', 'noa,addr', 'textAddrno5,textAddr5', 'addr_b.aspx']);

			var t_casetype = ["20''", "40''", "超重櫃", "HQ", "OT"];
			var t_casetype2 = ["20''", "40''","OT","太空包"];

			$(document).ready(function() {
				var t_where = '';
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}

				mainForm(0);
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'tranorde.check':
						if (result.substring(0, 1) != '1')
							alert(result);
						else {
							var t_noa = trim($('#txtNoa').val());
							var t_date = trim($('#txtDatea').val());
							if (t_noa.length == 0 || t_noa == "AUTO")
								q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
							else
								wrServer(t_noa);
						}
						break;
					case 'qtxt.query.tranordetinsert':
						var t_noa =trim($('#txtNoa').val()); 
						if(!emp(t_noa) && t_noa != 'AUTO'){
							t_where = "where=^^noa='" + t_noa + "'^^";
							q_gt("tranordet", t_where, 0, 0, 0, 'LoadOrdet', r_accy);
							Lock(1,{opacity:0});
						};
						break;
				}
			}

			function mainPost() {
				q_mask(bbmMask);
				q_cmbParse("cmbContainertype", ('').concat(new Array( '','傾卸櫃','平板櫃')));
				q_cmbParse("cmbCtype", ('').concat(new Array( '貨櫃','平板','散裝')));
				q_cmbParse("cmbStype", q_getPara('vcc.stype'));
				q_cmbParse("cmbUnit", q_getPara('sys.unit'));
				q_cmbParse("combMemo", ('').concat(q_getMsg('combmemo').split('&')));
				$('#combMemo').click(function(e){
					if(q_cur==1 || q_cur==2){
						$('#txtMemo').val($('#combMemo>option:selected').text()+$('#txtMemo').val());
						$('#combMemo').val(0);
					}					
				});
				$("#cmbStype").focus(function() {
					var len = $("#cmbStype").children().length > 0 ? $("#cmbStype").children().length : 1;
					$("#cmbStype").attr('size', len + "");
				}).blur(function() {
					$("#cmbStype").attr('size', '1');
				});
				$("#cmbUnit").focus(function() {
					var len = $("#cmbUnit").children().length > 0 ? $("#cmbUnit").children().length : 1;
					$("#cmbUnit").attr('size', len + "");
				}).blur(function() {
					$("#cmbUnit").attr('size', '1');
				});
				$('#btnUnpresent').click(function() {
					q_pop('', "carpresent.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy + '_' + r_cno, '', '', '', "92%", "1054px", q_getMsg('popCarpresent'), true);

				});
				$("#btnTranquat").click(function(e) {
					if ($('#txtCustno').val().length == 0) {
						alert('請輸入客戶編號!');
						return;
					}
					t_where = "b.custno='" + $('#txtCustno').val() + "' and not exists(select * from tranorde" + r_accy + " c where a.noa = c.tranquatno and a.noq = c.tranquatnoq and not c.noa='" + $('#txtNoa').val() + "')";
					q_box("tranquat_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;tranquatno=" + $('#txtTranquatno').val() + '_' + $('#txtTranquatnoq').val() + ";", 'tranquats', "95%", "650px", q_getMsg('popTranquat'));
				});
				$('#btnDeliveryno').click(function(e) {
					if ($('#txtDeliveryno').val().length == 0) {
						alert('請輸入提單編號!');
						return;
					}
					$(this).val('請稍後');
					t_where = "where=^^b.deliveryno='" + $('#txtDeliveryno').val() + "'  and  (c.tranno is null or c.noa='" + $('#txtNoa').val() + "')^^";
					q_gt('trando3', t_where, 0, 0, 0, "", r_accy);
				});
				$("#btnPrintorde").click(function(e) {
					q_box('z_tranorde.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				});
				$("#btnPrinttrand").click(function(e) {
					q_box('z_trand.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
				});
				$('#btnTransvcce').click(function(e){
					var noa = $.trim($('#txtNoa').val());
					if(noa.length>0)
						q_box("transvcce.aspx?;;;ordeno='" + noa + "';"+r_accy, 'transvcce', "95%", "95%", q_getMsg("popTransvcce"));
				});
				$('#txtDatea').datepicker();
				$('#txtCldate').datepicker();
				$('#txtNodate').datepicker();
				$('#txtMadate').datepicker();
				$('#txtRedate').datepicker();
				$('#txtStrdate').datepicker();
				$('#txtDldate').datepicker();
				var m, n;
				n = 7;
				//一行可放幾個
				for (var i = 0; i < t_casetype.length; i++) {
					m = Math.floor(i / n);
					if (i % n == 0) {
						//add tr
						$('.schema_tr').clone().insertBefore($('#xxx').nextAll().eq(m)).css('display', '').removeClass('schema_tr').addClass('x_tr  trX').attr('id', 'x_tr_' + m);
					}
					if (i == 0) {
						//add lbl
						$('.schema_td').clone().appendTo($('#x_tr_' + m)).removeClass('schema_td').addClass('x_td str');
						$('.schema_span').clone().appendTo($('.x_td.str')).removeClass('schema_span').addClass('x_span');
						$('.schema_lbl').clone().appendTo($('.x_td.str')).removeClass('schema_lbl').css('float', 'right').html(q_getMsg('lblCasetype'));
					} else if (i % n == 0)
						$('.schema_td').clone().appendTo($('#x_tr_' + m)).removeClass('schema_td').addClass('x_td');
					//add checkbox
					$('.schema_chk').clone().appendTo($('.schema_td').clone().appendTo($('#x_tr_' + m)).removeClass('schema_td').attr('id', 'x_td_' + i)).removeClass('schema_chk').addClass('x_chk').attr('id', 'x_chk_' + i);
					//add lbl
					$('#x_td_' + i).append($('.schema_lbl').clone().removeClass('schema_lbl').addClass('x_lbl').css('float', 'left').attr('id', 'x_lbl_' + i).html(t_casetype[i]).css('cursor', 'pointer').click(function(e) {
						if (q_cur == 1 || q_cur == 2) {
							$(this).prev().eq(0).prop('checked', !$(this).prev().eq(0).prop('checked'));
							var string = '';
							for (var i in t_casetype) {
								if ($('#x_chk_' + i).prop('checked'))
									string += (string.length > 0 ? ',' : '') + t_casetype[i];
							}
							$('#txtCasetype').val(string);
						}
					}));
					if (i % n == n - 1) {
						$('.schema_td').clone().appendTo($('#x_tr_' + m)).removeClass('schema_td').addClass('x_td str tdZ');
					}
				}
				for (var i = n - (t_casetype.length % n); i > 0; i--) {
					m = Math.floor((t_casetype.length - 1) / n);
					$('.schema_td').clone().appendTo($('#x_tr_' + m)).removeClass('schema_td').addClass('x_td str');
					if (i == 1) {
						$('.schema_td').clone().appendTo($('#x_tr_' + m)).removeClass('schema_td').addClass('x_td str tdZ');
					}
				}
				$('.x_chk').click(function(e) {
					if (q_cur == 1 || q_cur == 2) {
						var string = '';
						for (var i in t_casetype) {
							if ($('#x_chk_' + i).prop('checked'))
								string += (string.length > 0 ? ',' : '') + t_casetype[i];
						}
						$('#txtCasetype').val(string);
					}
				});
				for (var i = 0; i < t_casetype2.length; i++) {
					m = Math.floor(i / n);
					if (i % n == 0) {
						//add tr
						$('.schema_tr').clone().insertBefore($('#yyy').nextAll().eq(m)).css('display', '').removeClass('schema_tr').addClass('y_tr trY').attr('id', 'y_tr_' + m);
					}
					if (i == 0) {
						//add lbl
						$('.schema_td').clone().appendTo($('#y_tr_' + m)).removeClass('schema_td').addClass('y_td str');
						$('.schema_span').clone().appendTo($('.y_td.str')).removeClass('schema_span').addClass('y_span');
						$('.schema_lbl').clone().appendTo($('.y_td.str')).removeClass('schema_lbl').css('float', 'right').html(q_getMsg('lblCasetype2'));
					} else if (i % n == 0)
						$('.schema_td').clone().appendTo($('#y_tr_' + m)).removeClass('schema_td').addClass('y_td');
					//add checkbox
					$('.schema_chk').clone().appendTo($('.schema_td').clone().appendTo($('#y_tr_' + m)).removeClass('schema_td').attr('id', 'y_td_' + i)).removeClass('schema_chk').addClass('y_chk').attr('id', 'y_chk_' + i);
					//add lbl
					$('#y_td_' + i).append($('.schema_lbl').clone().removeClass('schema_lbl').addClass('y_lbl').css('float', 'left').attr('id', 'y_lbl_' + i).html(t_casetype2[i]).css('cursor', 'pointer').click(function(e) {
						if (q_cur == 1 || q_cur == 2) {
							$(this).prev().eq(0).prop('checked', !$(this).prev().eq(0).prop('checked'));
							var string = '';
							for (var i in t_casetype2) {
								if ($('#y_chk_' + i).prop('checked'))
									string += (string.length > 0 ? ',' : '') + t_casetype2[i];
							}
							$('#txtCasetype2').val(string);
						}

					}));
					if (i % n == n - 1) {
						$('.schema_td').clone().appendTo($('#y_tr_' + m)).removeClass('schema_td').addClass('y_td str tdZ');
					}
				}
				for (var i = n - (t_casetype2.length % n); i > 0; i--) {
					m = Math.floor((t_casetype2.length - 1) / n);
					$('.schema_td').clone().appendTo($('#y_tr_' + m)).removeClass('schema_td').addClass('y_td str');
					if (i == 1) {
						$('.schema_td').clone().appendTo($('#y_tr_' + m)).removeClass('schema_td').addClass('y_td str tdZ');
					}
				}
				$('.y_chk').click(function(e) {
					if (q_cur == 1 || q_cur == 2) {
						var string = '';
						for (var i in t_casetype2) {
							if ($('#y_chk_' + i).prop('checked'))
								string += (string.length > 0 ? ',' : '') + t_casetype2[i];
						}
						$('#txtCasetype2').val(string);
					}
				});

				$('#divAddr').mousedown(function(e) {
					if(e.button==2){			   		
						$(this).data('xtop',parseInt($(this).css('top')) - e.clientY);
						$(this).data('xleft',parseInt($(this).css('left')) - e.clientX);
					}
				}).mousemove(function(e) {
					if(e.button==2 && e.target.nodeName!='INPUT'){ 
						$(this).css('top',$(this).data('xtop')+e.clientY);
						$(this).css('left',$(this).data('xleft')+e.clientX);
					}
				}).bind('contextmenu', function(e) {
					if(e.target.nodeName!='INPUT')
						e.preventDefault();
				});
				$('#btnDivaddr').click(function(e){
					$('#divAddr').hide();
				});
				$('#btnAddr').click(function(e){
					$('#divAddr').toggle();
				});
				$("#textAddrno1").focus(function() {
					var input = document.getElementById ("textAddrno1");
					if (typeof(input.selectionStart) != 'undefined' ) {	  
						input.selectionStart =  $(input).val().replace(/^(\w+\u002D).*$/g,'$1').length;
						input.selectionEnd = $(input).val().length;
					}
				});
				$("#textAddrno2").focus(function() {
					var input = document.getElementById ("textAddrno2");
					if (typeof(input.selectionStart) != 'undefined' ) {	  
						input.selectionStart =  $(input).val().replace(/^(\w+\u002D).*$/g,'$1').length;
						input.selectionEnd = $(input).val().length;
					}
				});
				$("#textAddrno3").focus(function() {
					var input = document.getElementById ("textAddrno3");
					if (typeof(input.selectionStart) != 'undefined' ) {	  
						input.selectionStart =  $(input).val().replace(/^(\w+\u002D).*$/g,'$1').length;
						input.selectionEnd = $(input).val().length;
					}
				});
				$("#textAddrno4").focus(function() {
					var input = document.getElementById ("textAddrno4");
					if (typeof(input.selectionStart) != 'undefined' ) {	  
						input.selectionStart =  $(input).val().replace(/^(\w+\u002D).*$/g,'$1').length;
						input.selectionEnd = $(input).val().length;
					}
				});
				$("#textAddrno5").focus(function() {
					var input = document.getElementById ("textAddrno5");
					if (typeof(input.selectionStart) != 'undefined' ) {	  
						input.selectionStart =  $(input).val().replace(/^(\w+\u002D).*$/g,'$1').length;
						input.selectionEnd = $(input).val().length;
					}
				});
				$('#btnOrdet_Close').click(function(){
					$('#divTranordet').toggle();
					sum();
				});
				$('#btnTweight2').click(function (e) {
					$('#dbbt').toggle();
					if(q_cur==1 || q_cur==2)
						sum();
					/*if(!emp($('#txtNoa').val())){
						$('#divTranordet').toggle();
						sum();
					}*/
				});
				$('#btnOrdet_Top').click(function(){
					LoadTranOrdetTable(0);
				});
				$('#btnOrdet_Prev').click(function(){
					LoadTranOrdetTable(-1);
				});
				$('#btnOrdet_Next').click(function(){
					LoadTranOrdetTable(-2);
				});
				$('#btnOrdet_Bott').click(function(){
					var Total_Page = Math.ceil((TranOrdeArray.length/5)-1);
					LoadTranOrdetTable(Total_Page);
				});
				//TranOrdetDiv 跳下一格解決 (若有後續問題 請直接刪除此段) BtnOk MainPost
				TranOrdetNextFields(1);
				//TranOrdetDiv 跳下一格解決 (若有後續問題 請直接刪除此段) BtnOk MainPost
				$('input[id*="btnOrdetMinus_"]').click(function(){
					var thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
					var ArryNo = $('#TranOrdet_Idno_'+thisId).val();
					SetTranOrdetValue(thisId,'',ArryNo);
				});
				$('input[id*="textOrdet_Datea_"]').focusout(function(){
					var thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
					var ArryNo = $('#TranOrdet_Idno_'+thisId).val();
					if(!emp($('#textOrdet_Datea_'+thisId).val())){
						AlterTranOrdet(thisId,ArryNo);
					}
				});
				$('input[id*="textOrdet_Weight2_"]').focusout(function(){
					var thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
					var ArryNo = $('#TranOrdet_Idno_'+thisId).val();
					if(!emp($('#textOrdet_Datea_'+thisId).val())){
						AlterTranOrdet(thisId,ArryNo);
					}
				});
				$('input[id*="textOrdet_Trannumber_"]').focusout(function(){
					var thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length-1];
					var ArryNo = $('#TranOrdet_Idno_'+thisId).val();
					if(!emp($('#textOrdet_Datea_'+thisId).val())){
						AlterTranOrdet(thisId,ArryNo);
					}
				});
			}

			function display() {
				try{
					$('.x_chk').prop('checked',false);
					var t_item = $('#txtCasetype').val().split(',');
					for (var i in t_item ) {
						n = t_casetype.indexOf(t_item[i]);
						if (n >= 0)
							$('#x_chk_' + n).prop('checked', true);
					}
					$('.y_chk').prop('checked',false);
					var t_item = $('#txtCasetype2').val().split(',');
					for (var i in t_item ) {
						n = t_casetype2.indexOf(t_item[i]);
						if (n >= 0)
							$('#y_chk_' + n).prop('checked', true);
					}
				}catch(e){
					alert('display()  error');
				}
				
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
                    }
				}
				_bbsAssign();
			}
			function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtWeight__'+i).change(function(e){
                    		sum();
                    	});
                    	$('#txtTrannumber__'+i).change(function(e){
                    		sum();
                    	});
                    }
                }
                _bbtAssign();
            }

			function bbsSave(as) {
				if (!as['caseno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				var t_weight2 = 0,t_trannumber = 0;
				for(var i=0;i<q_bbtCount;i++){
					if($('#txtDatea__'+i).val().length>0){
						t_weight2 = q_add(t_weight2,q_float('txtWeight2__'+i));
						t_trannumber = q_add(t_trannumber,q_float('txtTrannumber__'+i));
					}
						
				}
				$('#txtTweight2').val(round(t_weight2,2));
				$('#txtTtrannumber').val(round(t_trannumber,2));	
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'tranquats':
						if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!(!b_ret || b_ret.length == 0)) {
								$('#txtTranquatno').val(b_ret[0].noa);
								$('#txtTranquatnoq').val(b_ret[0].noq);
								$('#txtContract').val(b_ret[0].contract);
								$('#cmbStype').val(b_ret[0].stype);
								$('#txtProductno').val(b_ret[0].productno);
								$('#txtProduct').val(b_ret[0].product);
								$('#txtStraddrno').val(b_ret[0].straddrno);
								$('#txtStraddr').val(b_ret[0].straddr);
								$('#txtMount').val(b_ret[0].mount);
								$('#txtMemo').val(b_ret[0].memo);
							}
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function TranOrdetNextFields(wcur){ //0 = dele 1 = add
				if(wcur == 1){
					for(var i = 1;i< 6;i++){
						fbbm.push('textOrdet_Datea_'+i);
						fbbm.push('textOrdet_Weight2_'+i);
						fbbm.push('textOrdet_Trannumber_'+i);
					}
				}else if(wcur == 0){
					for(var i = fbbm.length-1;i>0;i--){
						if(fbbm[i] != undefined && fbbm[i].length >=10){
							if(fbbm[i].substring(0,9) == 'textOrdet'){
								fbbm.splice(i, 1);
							}
						}
					}
				}
			}

			function LoadTranOrdetTable(PageNo){ // -1 = 上一頁 -2 = 下一頁 否則 指定頁數
				var Total_Page = Math.ceil((TranOrdeArray.length/5)-1);
				var t_idno = 0;
				if(TranOrdeArray.length%5==0){Total_Page+=1;};
				var k = 1;
				if(PageNo >= Total_Page+1){
					return;
				}else if(PageNo == -1){
					TranOrdetPage = TranOrdetPage-1;
					if(TranOrdetPage < 0){
						TranOrdetPage += 1;
						return;
					}else{
						t_idno = TranOrdetPage*5;
						for(var i = t_idno;i<t_idno+6;i++){
							if(TranOrdeArray[i] != undefined){
								SetTranOrdetValue(k,TranOrdeArray[i],i);
							}else{
								SetTranOrdetValue(k,'','');
							}
							k++;
						}
					}
				}else if(PageNo == -2){
					TranOrdetPage = TranOrdetPage+1;
					if(TranOrdetPage > Total_Page){
						TranOrdetPage -= 1;
						return;
					}else{
						t_idno = TranOrdetPage*5;
						for(var i = t_idno;i<t_idno+6;i++){
							if(TranOrdeArray[i] != undefined){
								SetTranOrdetValue(k,TranOrdeArray[i],i);
							}else{
								SetTranOrdetValue(k,'','');
							}
							k++;
						}
					}
				}else{
					if(PageNo < 0 || PageNo > Total_Page){
						return;
					}else{
						t_idno = PageNo*5;
						for(var i = t_idno;i<t_idno+6;i++){
							if(TranOrdeArray[i] != undefined){
								SetTranOrdetValue(k,TranOrdeArray[i],i);
							}else{
								SetTranOrdetValue(k,'','');
							}
							k++;
						}
						TranOrdetPage = PageNo;
					}
				}
			}
			function SetTranOrdetValue(t_idno,t_ValueArray,ArrayId){
				if(typeof(t_ValueArray) == 'object'){
					$('#TranOrdet_Idno_'+t_idno).val(ArrayId);
					$('#textOrdet_Datea_'+t_idno).val(t_ValueArray.datea);
					$('#textOrdet_Weight2_'+t_idno).val(t_ValueArray.weight2);
					$('#textOrdet_Trannumber_'+t_idno).val(t_ValueArray.trannumber);
				}else{
					if(TranOrdeArray[ArrayId] != undefined){
						TranOrdeArray[ArrayId].datea = t_ValueArray;
						TranOrdeArray[ArrayId].weight2 = t_ValueArray;
						TranOrdeArray[ArrayId].trannumber = t_ValueArray;
					}
					$('#TranOrdet_Idno_'+t_idno).val(ArrayId);
					$('#textOrdet_Datea_'+t_idno).val(t_ValueArray);
					$('#textOrdet_Weight2_'+t_idno).val(t_ValueArray);
					$('#textOrdet_Trannumber_'+t_idno).val(t_ValueArray);
				}
			}
			function AlterTranOrdet(t_idno,ArrayId){
				var w_datea = trim($('#textOrdet_Datea_'+t_idno).val());
				var w_weight2 = dec($('#textOrdet_Weight2_'+t_idno).val());
				var w_trannumber = dec($('#textOrdet_Trannumber_'+t_idno).val());
				if(!emp(w_datea)){
					if(TranOrdeArray[ArrayId] != undefined){
						TranOrdeArray[ArrayId].datea = w_datea;
						TranOrdeArray[ArrayId].weight2 = w_weight2;
						TranOrdeArray[ArrayId].trannumber = w_trannumber;
					}else{
						t_detail = {
							datea : w_datea,
							weight2 : w_weight2,
							trannumber : w_trannumber
						};
						$('#TranOrdet_Idno_'+t_idno).val(TranOrdeArray.length);
						TranOrdeArray.push(t_detail);
					}
				}else{
					if(TranOrdeArray[ArrayId] != undefined){
						TranOrdeArray.splice(ArrayId, 1);
					}
				}
			}
			function SaveTranOrdetStr(){
				var ReturnStr = new Array();
				for(var i = 0;i<TranOrdeArray.length;i++){
					if(!emp(TranOrdeArray[i].datea)){
						ReturnStr.push(TranOrdeArray[i].datea);
						ReturnStr.push(TranOrdeArray[i].weight2);
						ReturnStr.push(TranOrdeArray[i].trannumber);
					}
				}
				return ReturnStr.toString();
			}
			var TranOrdeArray = new Array();
			var TranOrdetPage = 0; //目前頁數 重0開始 每頁5個; 
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'trando3':
						var as = _q_appendData("trandos", "", true);
						q_gridAddRow(bbsHtm, 'tbbs', 'txtCaseno,txtTranno,txtTrannoq', as.length, as, 'caseno,tranno,trannoq', '', '');
						$('#btnDeliveryno').val("匯入櫃號 ");
						break;
					case 'LoadOrdet':
						var as = _q_appendData("tranordet", "", true);
						TranOrdeArray = as;
						LoadTranOrdetTable(0);
						Unlock(1);
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('tranorde_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				for(var i=1;i<=5;i++){
					$('#textAddrno'+i).val('');
					$('#textAddr'+i).val('');
				}
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#chkEnda').prop('checked',false);
				$('#txtDatea').focus();
				display();
				TranOrdeArray = new Array();
				TranOrdetPage = 0;
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
				display();
			}

			function btnPrint() {
				q_box('z_tranorde.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				//TranOrdetDiv 跳下一格解決 (若有後續問題 請直接刪除此段)
				TranOrdetNextFields(0);
				//TranOrdetDiv 跳下一格解決 (若有後續問題 請直接刪除此段)
				if ($('#txtDldate').val().length == 0 && $('#txtCldate').val().length > 0)
					$('#txtDldate').val($('#txtCldate').val());
				if ($('#txtDldate').val().length == 0 && $('#txtMadate').val().length > 0)
					$('#txtDldate').val($('#txtMadate').val());
				if($('#txtNick').val().length==0)	
				   $('#txtNick').val($('#txtComp').val().substring(0,4)); 
				$('#txtDatea').val($.trim($('#txtDatea').val()));
				if (checkId($('#txtDatea').val()) == 0) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				$('#txtCaddr').val();
				var t_addr='',t_caddr = '',t_item,t_str;
				for(var i=1;i<=5;i++){
				    if($('#textAddr'+i).val().length>0){
                        t_addr += (t_addr.length>0?'<br>':'')+$('#textAddr'+i).val();
                    }
					if($.trim($('#textAddr'+i).val()).length==0){
						$('#textAddrno'+i).val('');
						$('#textAddr'+i).val('');
					}
					t_str = $.trim($('#textAddrno'+i).val());
					t_item = '';
					for(var j=0;j<t_str.length;j++){
						t_item += (t_item.length==0?'':' ') + t_str.substring(j,j+1).charCodeAt(0);
					}
					t_caddr += (i==1?'':',')+t_item;

					t_str = $.trim($('#textAddr'+i).val());
					t_item = '';
					for(var j=0;j<t_str.length;j++){
						t_item += (t_item.length==0?'':' ') + t_str.substring(j,j+1).charCodeAt(0);
					}
					t_caddr += ','+t_item;
				}
				$('#txtCaddr').val(t_caddr);
				$('#txtAddr').val(t_addr);
				sum();
				$('#txtTranordeta').val(SaveTranOrdetStr());
				if(q_cur ==1){
					$('#txtWorker').val(r_name);
				}else if(q_cur ==2){
					$('#txtWorker2').val(r_name);
				}else{
					alert("error: btnok!");
				}
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				//q_func('qtxt.query.tranordetinsert','tranordet.txt,tranordetinsert,'+encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()));
				//TranOrdetNextFields(1);
			}

			function refresh(recno) {
				_refresh(recno);
				display();
				if(q_cur!=1){
					for(var i=0;i<q_bbsCount;i++){
						$('#textAddrno'+i).val('');
						$('#textAddr'+i).val('');
					}
					//var t_caddr = $('#txtCaddr').val().split(',');
					if(abbm[recno]!=undefined){
						var t_caddr = abbm[recno].caddr.split(',');
						var t_item,t_str;
						for(var i=0;i<t_caddr.length;i++){
							t_item = t_caddr[i].split(' ');
							t_str='';
							for(var j=0;t_caddr[i].length>0 && j<t_item.length;j++){
								t_str+=String.fromCharCode(parseInt(t_item[j]));
							}
							if(i%2==0)
								$('#textAddrno'+(Math.floor(i/2)+1)).val(t_str);
							else
								$('#textAddr'+(Math.floor(i/2)+1)).val(t_str);
						}	
					}
				}
				//載入tranordet
				/*var t_noa =trim($('#txtNoa').val()); 
				if(!emp(t_noa) && t_noa != 'AUTO'){
					
					t_where = "where=^^noa='" + t_noa + "'^^";
					q_gt("tranordet", t_where, 0, 0, 0, 'LoadOrdet', r_accy);
					Lock(1,{opacity:0});
				};
				TranOrdetNextFields(0);
				TranOrdetNextFields(1);*/
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (q_cur == 1 || q_cur == 2) {
					$('.x_chk').removeAttr('disabled');
					$('.y_chk').removeAttr('disabled');
					
					$('#btnTranquat').removeAttr('disabled');
					$('#btnDeliveryno').removeAttr('disabled');

					for(var i = 1;i <6;i++){
						$('#textAddrno'+i).css('color','black').css('background','white').removeAttr('readonly');
						$('#textAddr'+i).css('color','black').css('background','white').removeAttr('readonly');

						$('#btnOrdetMinus_'+i).removeAttr('disabled');
						$('#textOrdet_Datea_'+i).css('color','black').css('background','white').removeAttr('readonly');
						$('#textOrdet_Weight2_'+i).css('color','black').css('background','white').removeAttr('readonly');
						$('#textOrdet_Trannumber_'+i).css('color','black').css('background','white').removeAttr('readonly');
					}
				} else {
					$('.x_chk').attr('disabled', 'disabled');
					$('.y_chk').attr('disabled', 'disabled');
					
					$('#btnTranquat').attr('disabled', 'disabled');
					$('#btnDeliveryno').attr('disabled', 'disabled');

					for(var i = 0;i < 6;i++){
						$('#textAddrno'+i).css('color','green').css('background','rgb(237,237,237)').attr('readonly','readonly');
						$('#textAddr'+i).css('color','green').css('background','rgb(237,237,237)').attr('readonly','readonly');
						
						$('#btnOrdetMinus_'+i).attr('disabled', 'disabled');
						$('#textOrdet_Datea_'+i).css('color','green').css('background','rgb(237,237,237)').attr('readonly','readonly');
						$('#textOrdet_Weight2_'+i).css('color','green').css('background','rgb(237,237,237)').attr('readonly','readonly');
						$('#textOrdet_Trannumber_'+i).css('color','green').css('background','rgb(237,237,237)').attr('readonly','readonly');
					}
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);

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

			function q_popPost(id) {
				switch(id){
					case 'txtCustno':
						var t_carno = $.trim($('#txtCustno').val());
						if(q_cur==1 && t_carno.length>0){
							for(var i=1;i<=5;i++)
								if($.trim($('#textAddr'+i).val()).length==0)
									$('#textAddrno'+i).val(t_carno+'-');
						}
						break;
				}
			}

			function checkId(str) {
				if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
					var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
					var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
					var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
					if ((n % 10) == 0)
						return 1;
				} else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
					var key = '12121241';
					var n = 0;
					var m = 0;
					for (var i = 0; i < 8; i++) {
						n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
						m += Math.floor(n / 10) + n % 10;
					}
					if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
						return 2;
				} else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
					if (regex.test(str))
						return 3;
				} else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
					str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
					if (regex.test(str))
						return 4
				}
				return 0;
				//錯誤
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: auto;
			}
			.dview {
				float: left;
				width: 1400px;
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
				width: 1100px;
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
				width: 12%;
			}
			.tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
				background-color: #FFEC8B;
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
			}
			.tbbm .trX {
				background-color: #FFEC8B;
			}
			.tbbm .trY {
				background-color: pink;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 40%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
				float: left;
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
			}
			.dbbs {
				width: 950px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}
			.font1 {
				font-family: "細明體", Arial, sans-serif;
			}
			#tableTranordet tr td input[type="text"]{
				width:80px;
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
	<body 
	ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="divAddr" style="display:none;position:absolute;top:100px;left:600px;width:400px;height:250px;background:RGB(237,237,237);"> 
			<table style="border:4px solid gray; width:100%; height: 100%;">
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"> </td>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"> </td>
					<td style="width:40%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"><a>起迄編號</a></td>
					<td style="width:45%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"><a>名稱</a></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><a>1</a></td>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><input type="button" id="btnAddr1"></td>
					<td style="width:40%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddrno1"/></td>
					<td style="width:45%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddr1"/></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><a>2</a></td>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><input type="button" id="btnAddr2"></td>
					<td style="width:40%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddrno2"/></td>
					<td style="width:45%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddr2"/></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><a>3</a></td>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><input type="button" id="btnAddr3"></td>
					<td style="width:40%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddrno3"/></td>
					<td style="width:45%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddr3"/></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><a>4</a></td>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><input type="button" id="btnAddr4"></td>
					<td style="width:40%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddrno4"/></td>
					<td style="width:45%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddr4"/></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><a>5</a></td>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;"><input type="button" id="btnAddr5"></td>
					<td style="width:40%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddrno5"/></td>
					<td style="width:45%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textAddr5"/></td>
				</tr>
				<tr>
					<td colspan="4" align="center" style="width:100%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="button" id="btnDivaddr" value="關閉"/>	</td>
				</tr>
			</table>
		</div>
		<div id="divTranordet" style="display:none;z-index: 50;position:absolute;top:100px;left:600px;background:RGB(237,237,237);"> 
			<table id="tableTranordet" style="border:4px solid gray; width:300px;; height: 100%;">
				<tr>
					<td colspan="4" align="center" style="width:100%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;">
						<input type="button" id="btnOrdet_Top" value="第一頁"/>
						<input type="button" id="btnOrdet_Prev" value="上一頁"/>
						<input type="button" id="btnOrdet_Next" value="下一頁"/>
						<input type="button" id="btnOrdet_Bott" value="最末頁"/>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center" style="width:100%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;">
						<input type="button" id="btnOrdet_Close" value="關閉"/>
					</td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"> </td>
					<td style="width:35%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"><a>日期</a></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"><a>碼頭重</a></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"><a>車次</a></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;">
						<input class="btn"  id="btnOrdetMinus_1" type="button" value='-' style=" font-weight: bold;" />
						<input type="hidden" id="TranOrdet_Idno_1">
					</td>
					<td style="width:35%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textOrdet_Datea_1"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Weight2_1"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Trannumber_1"/></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;">
						<input class="btn"  id="btnOrdetMinus_2" type="button" value='-' style=" font-weight: bold;" />
						<input type="hidden" id="TranOrdet_Idno_2">
					</td>
					<td style="width:35%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textOrdet_Datea_2"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Weight2_2"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Trannumber_2"/></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;">
						<input class="btn"  id="btnOrdetMinus_3" type="button" value='-' style=" font-weight: bold;" />
						<input type="hidden" id="TranOrdet_Idno_3">
					</td>
					<td style="width:35%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textOrdet_Datea_3"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Weight2_3"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Trannumber_3"/></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;">
						<input class="btn"  id="btnOrdetMinus_4" type="button" value='-' style=" font-weight: bold;" />
						<input type="hidden" id="TranOrdet_Idno_4">
					</td>
					<td style="width:35%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textOrdet_Datea_4"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Weight2_4"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Trannumber_4"/></td>
				</tr>
				<tr>
					<td style="width:5%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: black;">
						<input class="btn"  id="btnOrdetMinus_5" type="button" value='-' style=" font-weight: bold;" />
						<input type="hidden" id="TranOrdet_Idno_5">
					</td>
					<td style="width:35%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" id="textOrdet_Datea_5"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Weight2_5"/></td>
					<td style="width:30%; padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;"><input type="text" class="num" id="textOrdet_Trannumber_5"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewCust'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewStrdate'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDldate'></a></td>
						<td align="center" style="width:250px; color:black;"><a id='vewAddr'></a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewDeliveryno'></a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewPo'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewProduct'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMount'></a></td>
						<td align="center" style="width:50px; color:black;"><a id='vewUnit'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTweight2'></a></td>
						<td align="center" style="width:50px; color:black;"><a id='vewTtrannumber'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='strdate' style="text-align: center;">~strdate</td>
						<td id='dldate' style="text-align: center;">~dldate</td>
						<td id='addr' style="text-align: left;">~addr</td>
						<td id='deliveryno' style="text-align: left;">~deliveryno</td>
						<td id='po' style="text-align: left;">~po</td>
						<td id='product' style="text-align: left;">~product</td>
						<td id='mount' style="text-align: right;">~mount</td>
						<td id='unit' style="text-align: center;">~unit</td>
						<td id='tweight2' style="text-align: right;">~tweight2</td>
						<td id='ttrannumber' style="text-align: right;">~ttrannumber</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td><input type="text" id="txtCaddr" style="display:none;"></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtNoa" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtDatea" class="txt c1"/>
						</td>
						<td>
						<input type="button" id="btnPrintorde" />
						</td>
						<td>
						<input type="button" id="btnPrinttrand" />
						</td>
						<td>
						<input type="checkbox" id="chkEnda">手動結案</input>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStrdate" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtStrdate" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDldate" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtDldate" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCtype" class="lbl"> </a></td>
						<td>
						<select id="cmbCtype" class="txt c1"> </select>
						</td>
						<td><input type="button" id="btnUnpresent" value="未出車"/> </td>
						<td><input type="button" id="btnTransvcce" value="派車明細"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl"> </a></td>
						<td colspan="3">
						<input type="text" id="txtCustno" class="txt" style="width:15%;float: left; " />
						<input type="text" id="txtComp" class="txt" style="width:85%;float: left; " />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTranquatno" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtTranquatno" class="txt" style="width:80%;float: left; " />
						<input type="text" id="txtTranquatnoq" class="txt" style="width:20%;float: left; " />
						</td>
						<td>
						<input type="button" id="btnTranquat" style="width:100px;"/>
						</td>
						<td><span> </span><a id="lblTweight2" class="lbl"> </a></td>
						<td><input type="text" id="txtTweight2" class="txt num c1"/> </td>
						<td><span> </span><a id="lblTtrannumber" class="lbl"> </a></td>
						<td><input type="text" id="txtTtrannumber" class="txt num c1"/> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDeliveryno" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtDeliveryno" class="txt c1"/>
						</td>
						<td>
						<input type="button" id="btnDeliveryno" style="width:100px;"/>
						</td>
						<td> </td>
						<td>
						<input type="button" id="btnTweight2" style="width:100px;"/>
						</td>
						<td>
						<input type="button" id="btnAddr" style="width:100px;" value="起迄地點"/>
						<input type="text" id="txtAddr" class="txt" style="display:none;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td colspan="5">
						<input type="text" id="txtCno" class="txt" style="width:15%;float: left; " />
						<input type="text" id="txtAcomp" class="txt" style="width:85%;float: left; " />
						<input type="text" id="txtNick" class="txt" style="display:none; " />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblContract" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtContract" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblStype" class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl btn"> </a></td>
						<td colspan="2">
						<input type="text" id="txtProductno" class="txt" style="width:40%;float: left; " />
						<input type="text" id="txtProduct" class="txt" style="width:60%;float: left; " />
						</td>
						<td><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtPo" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtMount" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblUnit" class="lbl"> </a></td>
						<td><select id="cmbUnit" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5">
						<input type="text" id="txtMemo" class="txt c1"/>
						</td>
						<td><select id="combMemo" style="float:left;width:20px;"> </select><span> </span><a id="lblCancel" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCancel" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2" class="lbl"> </a></td>
						<td colspan="5">
							<textarea rows="5" id="txtMemo2" class="txt c1"> </textarea>
						</td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblExcon" class="lbl" style="color: #ff0033;font-weight:bolder;"> </a></td>
						<td><span> </span><a id="lblDocketno1" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtDocketno1" class="txt c1"/> </td>
						<td> </td>
						<td>
						<input type="text" id="txtEmpdock" class="txt c1"/>
						</td>
						<td align="left"><a id="lblEmpdock" > </a></td>
						<td><span> </span><a id="lblDock" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtDock" class="txt c1"/>
						</td>
						<td> </td>
					</tr>
					<tr class="trX">
						<td> </td>
						<td><span> </span><a id="lblBoat" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtBoat" class="txt c1"/>
						</td>
						<td> </td>
						<td><span> </span><a id="lblShip" class="lbl"> </a></td>
						<td colspan="3">
						<input type="text" id="txtBoatname" class="txt c1"/>
						</td>
						
						<td> </td>
						<td> </td>
					</tr>
					<tr class="trX" >
						<td></td>
						<td><span> </span><a id="lblDo1" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtDo1" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblSo" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtSo" class="txt c1"/>
						</td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr class="trX" id="xxx">
						<td>
						<input type="text" id="txtCasetype" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblCasepackaddr" class="lbl btn"> </a></td>
						<td colspan="2">
						<input type="text" id="txtCasepackaddr" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblPort" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtPort" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCldate" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCldate" class="txt c1"/>
						</td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="trY">
						<td><span> </span><a id="lblImcon" class="lbl" style="color: #ff0033;font-weight:bolder;"> </a></td>
						<td><span> </span><a id="lblTakeno" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtTakeno" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCasepresent" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCasepresent" class="txt c1"/></td>
						<td><span> </span><a id="lblProduct2" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtProduct2" class="txt c1"/> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="trY">
						<td> </td>
						<td><span> </span><a id="lblContainertype" class="lbl"> </a></td>
						<td><select id="cmbContainertype" class="txt c1"> </select></td>
						<td><span> </span><a id="lblDocketno2" class="lbl"> </a></td>
						<td><input type="text" id="txtDocketno2" class="txt c1"/> </td>
						<td> </td>
						<td><input type="text" id="txtOption01" class="txt c1"/> </td>
						<td><span style="float: left;"> </span><a id="lblOption01" class="lbl" style="float: left;"> </a></td>
						<td> </td>
					</tr>
					<tr class="trY">
						<td></td>
						<td><span> </span><a id="lblPort2" class="lbl"> </a></td><td>
						<input type="text" id="txtPort2" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblEmpdock2" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtEmpdock2" class="txt c1"/>
						</td>
						<td> </td>
						<td><input type="text" id="txtOption02" class="txt c1"/> </td>
						<td><span style="float: left;"> </span><a id="lblOption02" class="lbl" style="float: left;"> </a></td>
						<td> </td>
					</tr>
					<tr class="trY">
						<td></td>
						<td><span> </span><a id="lblTrackno" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtTrackno" class="txt c1"/>
						</td>
						</td><td><span> </span><a id="lblCaseassign" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCaseassign" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDo2" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtDo2" class="txt c1"/>
						</td>
						<td></td>
					</tr>
					<tr class="trY">
						<td></td>
						<td><span> </span><a id="lblCheckself" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCheckself" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCheckinstru" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCheckinstru" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCasedo" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCasedo" class="txt c1"/>
						</td>
						<td></td>
						<td></td>
					</tr>
					<tr class="trY" id="yyy">
						<td>
						<input type="text" id="txtCasetype2" style="display:none;"/>
						</td>
						</td>
						<td><span> </span><a id="lblCaseopenaddr" class="lbl btn"> </a></td>
						<td colspan="2">
						<input type="text" id="txtCaseopenaddr" class="txt c1"/>
						</td>
						<td> </td>
						<td><span> </span><a id="lblMadate" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtMadate" class="txt c1"/>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td>
							<input id="txtWorker" type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td>
							<input id="txtWorker2" type="text"  class="txt c1"/>
							<input id="txtTranordeta" type="hidden">
						</td>
					</tr>
					<tr class="schema_tr" style="display:none;"></tr>
					<tr style="display:none;">
						<td class="schema_td"></td>
						<td><span class="schema_span"> </span><a class="schema_lbl"> </a></td>
						<td>
						<input type="checkbox" class="schema_chk" style="float:left;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:150px"><a id='lblCaseno_s'> </a></td>
					<td align="center" style="width:150px"><a id='lblMemo_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
					<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td >
					<input type="text" id="txtCaseno.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtMemo.*" style="width:95%;" />
					</td>
				</tr>

			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="position: absolute;top:250px; left:450px; display:none;width:400px;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:100px; text-align: center;">日期</td>
						<td style="width:100px; text-align: center;">碼頭重</td>
						<td style="width:100px; text-align: center;">車次</td>
					</tr>
					<tr class="detail">
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display:none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input class="txt" id="txtDatea..*" type="text" style="width:95%;"/></td>
						<td><input class="txt" id="txtWeight2..*" type="text" style="width:95%;text-align: right;"/></td>
						<td><input class="txt" id="txtTrannumber..*" type="text" style="width:95%;text-align: right;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
