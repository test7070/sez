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
			var q_name = 'tranvccewj';
			var _pageCount = 16; //一頁幾筆資料
            var _curData = new Array();
			var isModi = false;
			
			function Screenshot(){
				html2canvas(document.body, {
					onrendered: function(canvas) {
						document.body.appendChild(canvas);
					}
				});
            }
            
			jQuery.fn.selectText = function(){
	            var doc = document;
	            var element = this[0];
	            //console.log(this, element);
	            if (doc.body.createTextRange) {
	                var range = document.body.createTextRange();
	                range.moveToElementText(element);
	                range.select();
	            } else if (window.getSelection) {
	                var selection = window.getSelection();
	                var range = document.createRange();
	                range.selectNodeContents(element);
	                selection.removeAllRanges();
	                selection.addRange(range);
	            }
            };
            
            $(document).ready(function() {
            	_q_boxClose();
                q_getId();
                q_gf('', 'tranvcce');
				
				$('#btnAuthority').click(function () {
                    btnAuthority(q_name);
                });
                
                $('#txtBdate-input').datepicker({
				    onClose: function(dateText, inst) {
				        // When the date is selected, copy the value in the content editable div.
				        // If you don't need to do anything on the blur or focus event of the content editable div, you don't need to trigger them as I do in the line below.
				        $('#txtBdate').focus().html(dateText).blur();
				    }
				});
				// Shows the datepicker when clicking on the content editable div
				$('#txtBdate').click(function() {
				    // Triggering the focus event of the hidden input, the datepicker will come up.
				    $('#txtBdate-input').focus();
				});
				$('#txtEdate-input').datepicker({
				    onClose: function(dateText, inst) {
				        // When the date is selected, copy the value in the content editable div.
				        // If you don't need to do anything on the blur or focus event of the content editable div, you don't need to trigger them as I do in the line below.
				        $('#txtEdate').focus().html(dateText).blur();
				    }
				});
				// Shows the datepicker when clicking on the content editable div
				$('#txtEdate').click(function() {
				    // Triggering the focus event of the hidden input, the datepicker will come up.
				    $('#txtEdate-input').focus();
				});
            });
            function q_gfPost() {
            	q_gt('authority', "where=^^a.noa='tranvcce' and a.sssno='" + r_userno + "'^^", 0, 0, 0, "checkAuthority", 1);
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'checkAuthority':
                        var as = _q_appendData('authority', '', true);
                        if (r_rank>8)
                        	isModi = true;
                        else if (as.length > 0 && as[0]["pr_modi"] == "true")
                            isModi = true;
                        else
                            isModi = false;
                        
                        q_langShow();
			            init(_pageCount);
						$('#btnRefresh').click();
                        break;
                    default:
                        break;
                } 
            }

			function init(tCount){
				$('#btnPrint').click(function(e){
					q_box('z_tranvcce_at.aspx?'+ r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'transvcce', "95%", "95%", m_print);
				});
				for(var i=0;i<tCount;i++){
					$('.tData').append($('.tSchema').find('tr').eq(0).clone().data('key',i).data('data',''));	
					for(var j=0;j<$('.tData').find('tr').eq(i).find('td').length;j++){
						var obj = $('.tData').find('tr').eq(i).find('td').eq(j).find('.date-input').eq(0);
						obj.attr('id',obj.attr('id')+'_'+i).attr('value',i+1);
						
						/*$('#txtOrdeno_'+i).bind('contextmenu', function(e) {
                            //滑鼠右鍵
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            q_box('z_tranvcce_at.aspx?'+ r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($(this).text())}) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
                        }).css('color','blue');*/
                        
						$('#txtDate1_'+i).click(function() {
							if(!$(this).hasClass('edit'))
								return;
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							var position = $(this).offset();
							$('#txtDate1-input_'+n).show().width(1).height(1);
							$('#txtDate1-input_'+n).datepicker({n:n
							    ,onClose: function(dateText, inst) {
							        $('#txtDate1_'+n).html(dateText);
							        $('#txtDate1-input_'+n).hide();
							    }
							});
						    $('#txtDate1-input_'+n).datepicker('show');
						});
						$('#txtDate2_'+i).click(function() {
							if(!$(this).hasClass('edit'))
								return;
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							var position = $(this).offset();
							$('#txtDate2-input_'+n).show().width(1).height(1);
							$('#txtDate2-input_'+n).datepicker({n:n
							    ,onClose: function(dateText, inst) {
							        $('#txtDate2_'+n).html(dateText);
							        $('#txtDate2-input_'+n).hide();
							    }
							});
						    $('#txtDate2-input_'+n).datepicker('show');
						});
						$('#txtDate3_'+i).click(function() {
							if(!$(this).hasClass('edit'))
								return;
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							var position = $(this).offset();
							$('#txtDate3-input_'+n).show().width(1).height(1);
							$('#txtDate3-input_'+n).datepicker({n:n
							    ,onClose: function(dateText, inst) {
							        $('#txtDate3_'+n).html(dateText);
							        $('#txtDate3-input_'+n).hide();
							    }
							});
						    $('#txtDate3-input_'+n).datepicker('show');
						});
						$('#txtDate4_'+i).click(function() {
							if(!$(this).hasClass('edit'))
								return;
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							var position = $(this).offset();
							$('#txtDate4-input_'+n).show().width(1).height(1);
							$('#txtDate4-input_'+n).datepicker({n:n
							    ,onClose: function(dateText, inst) {
							        $('#txtDate4_'+n).html(dateText);
							        $('#txtDate4-input_'+n).hide();
							    }
							});
						    $('#txtDate4-input_'+n).datepicker('show');
						});
						$('#txtDate5_'+i).click(function() {
							if(!$(this).hasClass('edit'))
								return;
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							var position = $(this).offset();
							$('#txtDate5-input_'+n).show().width(1).height(1);
							$('#txtDate5-input_'+n).datepicker({n:n
							    ,onClose: function(dateText, inst) {
							        $('#txtDate5_'+n).html(dateText);
							        $('#txtDate5-input_'+n).hide();
							    }
							});
						    $('#txtDate5-input_'+n).datepicker('show');
						});
						$('#txtDate6_'+i).click(function() {
							if(!$(this).hasClass('edit'))
								return;
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							var position = $(this).offset();
							$('#txtDate6-input_'+n).show().width(1).height(1);
							$('#txtDate6-input_'+n).datepicker({n:n
							    ,onClose: function(dateText, inst) {
							        $('#txtDate6_'+n).html(dateText);
							        $('#txtDate6-input_'+n).hide();
							    }
							});
						    $('#txtDate6-input_'+n).datepicker('show');
						});
						$('#txtDate7_'+i).click(function() {
							if(!$(this).hasClass('edit'))
								return;
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							var position = $(this).offset();
							$('#txtDate7-input_'+n).show().width(1).height(1);
							$('#txtDate7-input_'+n).datepicker({n:n
							    ,onClose: function(dateText, inst) {
							        $('#txtDate7_'+n).html(dateText);
							        $('#txtDate7-input_'+n).hide();
							    }
							});
						    $('#txtDate7-input_'+n).datepicker('show');
						});
						$('#txtDate8_'+i).click(function() {
							if(!$(this).hasClass('edit'))
								return;
							var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
							var position = $(this).offset();
							$('#txtDate8-input_'+n).show().width(1).height(1);
							$('#txtDate8-input_'+n).datepicker({n:n
							    ,onClose: function(dateText, inst) {
							        $('#txtDate8_'+n).html(dateText);
							        $('#txtDate8-input_'+n).hide();
							    }
							});
						    $('#txtDate8-input_'+n).datepicker('show');
						});
						obj = $('.tData').find('tr').eq(i).find('td').eq(j).find('input[type="button"].btnDelete').eq(0);
						obj.attr('id',obj.attr('id')+'_'+i);
						obj.click(function(e){	
							var n = parseInt($(this).attr('id').replace(/^.*_(\d+)$/,'$1'));
							deleteData(n);	
						});
						
						obj = $('.tData').find('tr').eq(i).find('td').eq(j).find('input[type="button"].btnSel').eq(0);
						obj.attr('id',obj.attr('id')+'_'+i).attr('value',i+1);
						obj.click(function(e){
							if(!isModi){
								alert('無修改權限!');
								return;
							}
							var n = parseInt($(this).attr('id').replace(/^.*_(\d+)$/,'$1'));
							if($(this).parent().parent().data('data').length == 0)
								return;
							if(_curData[n].isdel){
								alert('資料已被刪除，請重新整理頁面。');
								return;
							}
							//檢查日期格式
							if(!($('#txtDate1_'+n).text().length==0 || $('#txtDate1_'+n).text().length==9)){
								alert('領(日期)異常');
								return;
							}
							if(!($('#txtDate5_'+n).text().length==0 || $('#txtDate5_'+n).text().length==9)){
								alert('轉(日期)#1異常');
								return;
							}
							if(!($('#txtDate2_'+n).text().length==0 || $('#txtDate2_'+n).text().length==9)){
								alert('送(日期)異常');
								return;
							}
							if(!($('#txtDate6_'+n).text().length==0 || $('#txtDate6_'+n).text().length==9)){
								alert('移(日期)異常');
								return;
							}
							if(!($('#txtDate3_'+n).text().length==0 || $('#txtDate3_'+n).text().length==9)){
								alert('收(日期)異常');
								return;
							}
							if(!($('#txtDate8_'+n).text().length==0 || $('#txtDate8_'+n).text().length==9)){
								alert('轉(日期)#2異常');
								return;
							}
							if(!($('#txtDate4_'+n).text().length==0 || $('#txtDate4_'+n).text().length==9)){
								alert('交(日期)異常');
								return;
							}
							
							if($(this).hasClass('edit')){
								$('#btnRefresh').removeClass('edit');
								
								$(this).removeClass('edit');
								$(this).parent().prevAll().removeClass('edit');
								$(this).parent().nextAll().removeClass('edit');
								$('.btnSel').removeClass('edit');
								$(this).css('color','');
								$(this).parent().parent().find('a,input[type="checkbox"]').each(function(e){
									if($(this).attr('id').substring(0,3)=='txt'){
										$(this).text($(this).text());
									}
									$(this).css('background-color','');
									$(this).removeClass('edit').attr("contenteditable","false").css('color','black').attr('disabled','disabled');
								});
								$('.btnDelete').attr('disabled','disabled').css('color','black');
								$('.btnSel').attr('disabled','disabled');
								for(var i=0;i<_curData.length;i++){
									$('#btnSel_'+i).removeAttr('disabled');
								}
								if($(this).data('isDelete')){
									$(this).data('isDelete',false);
								}
								else{updateData(n);}
							}else{
								$('#btnRefresh').addClass('edit');
								$('#chkIssend1_'+n).removeAttr('disabled');
								$('#chkIssend2_'+n).removeAttr('disabled');
								$('#chkIssend3_'+n).removeAttr('disabled');
								$('#chkIssend4_'+n).removeAttr('disabled');
								//跳下一格
					            var doc = document;
					            var element = $('#txtDatea_'+n)[0];
					            if (window.getSelection) {
					                var selection = window.getSelection();
					                var range = document.createRange();
					                range.selectNodeContents(element);
					                selection.removeAllRanges();
					                selection.addRange(range);
					            }
					            $(this).blur();
					            $('#txtDatea_'+n).focus();
					            //----------------------------------------------
								$(this).addClass('edit');
								$(this).parent().prevAll().addClass('edit');
								$(this).parent().nextAll().addClass('edit');
								$('.btnSel').attr('disabled','disabled');
								$(this).removeAttr('disabled');
								$('.btnDelete').attr('disabled','disabled').css('color','black');
								$('#btnDelete_'+n).removeAttr('disabled').css('color','red');
								$(this).css('color','red');
								$(this).parent().parent().find('a,input[type="checkbox"]').each(function(e){
									if($(this).attr('id').substring(0,3)=='chk'){
										$(this).removeAttr('disabled');
									}else{
										if(!$(this).hasClass('readonly')){
											$(this).addClass('edit').attr("contenteditable","true");
											if($(this).hasClass('field2')){
												$(this).css('background-color','#F5D0A9');
											}else{
												$(this).css('background-color','#D8D8D8');
											}
										}else{
											$(this).css('color','darkgreen');
										}
									}
								});
							}
						});
						
						var obj = $('.tData').find('tr').eq(i).find('td').eq(j).find('a,input[type="checkbox"]');
						for(var k=0;k<obj.length;k++){
							t_id = obj.eq(k).attr('id');
							obj.eq(k).addClass(t_id).attr('id',t_id+'_'+i);
							if(t_id.substring(0,3)=='txt'){
								if(!obj.hasClass('readonly')){
									obj.focus(function(e) {
										if($(this).hasClass('edit'))
					                    	$(this).selectText();
					                });
								}
							}else if(t_id.substring(0,3)=='chk'){
								
							}
						}
					}
				}
				$('.txtDatea').focus(function() {
					$(this).text($(this).text());
				}).keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//格式判斷
					var patt = /(^\d{0,3}$)|(^\d{3}\/$)|(^\d{3}\/\d{0,2}$)|(^\d{3}\/\d{2}\\$)|(^\d{3}\/\d{2}\/\d{0,2}$)/;
					if(/^\d{3}\d$/.test(curVal)){
						$(this).text(curVal.replace(/^(\d{3})(\d)$/,'$1/$2'));
					}else if(/^\d{3}\/\d{3}$/.test(curVal)){
						$(this).text(curVal.replace(/^(\d{3}\/\d{2})(\d)$/,'$1/$2'));
					}else if(!patt.test(curVal)){
						$(this).text(prevVal);
					}
					//跳到字尾
					var doc = document;
		            var element = $(this)[0];
					if (window.getSelection) {
		                var selection = window.getSelection();
		                var range = document.createRange();
		                range.selectNodeContents(element);
		                selection.removeAllRanges();
		                selection.addRange(range);
		                selection.collapseToEnd();
		            }
		            //跳下一格
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtStraddrno_'+n).focus();
		            }
		            //console.log(n);
				});
				goNextItem('txtStraddrno','txtStraddr');
				goNextItem('txtStraddr','txtCasetype');
				goNextItem('txtCasetype','txtContainerno1');
				goNextItem('txtContainerno1','txtContainerno2');
				//goNextItem('txtContainerno2','txtSeal1');
				//goNextItem('txtSeal1','txtSeal2');
				//goNextItem('txtSeal2','txtMount');
				goNextItem('txtContainerno2','txtMount');
				goNextItem('txtMount','txtCarno1');
				goNextItem('txtCarno1','txtCardno1');
				goNextItem('txtCardno1','txtYard1');
				goNextItem('txtYard1','txtDate1');
				goNextItem('txtDate1','txtCarno5');
				
				goNextItem('txtCarno5','txtCardno5');
				
				goNextItem('txtCardno5','txtDate5');
				goNextItem('txtDate5','txtYard5');
				goNextItem('txtYard5','txtCarno2');
				
				goNextItem('txtCarno2','txtCardno2');
				goNextItem('txtCardno2','txtYard2');
				goNextItem('txtYard2','txtDate2');
				goNextItem('txtDate2','txtCarno6');
				
				goNextItem('txtCarno6','txtCardno6');
				goNextItem('txtCardno6','txtDate6');
				goNextItem('txtDate6','txtCarno7');
				goNextItem('txtCarno7','txtCardno7');
				goNextItem('txtCardno7','txtDate7');
				goNextItem('txtDate7','txtCarno3');

				goNextItem('txtCarno3','txtCardno3');
				goNextItem('txtCardno3','txtYard3');
				goNextItem('txtYard3','txtDate3');
				goNextItem('txtDate3','txtCarno8');
				
				goNextItem('txtCarno8','txtCardno8');
				goNextItem('txtCardno8','txtDate8');
				goNextItem('txtDate8','txtCarno4');
				
				goNextItem('txtCarno4','txtCardno4');
				goNextItem('txtCardno4','txtYard4');
				goNextItem('txtYard4','txtDate4');
				goNextItem('txtDate4','txtMsg1');
				goNextItem('txtMsg1','txtMsg2');
				goNextItem('txtMsg2','txtMsg3');
				goNextItem('txtMsg3','txtMsg4');
				goNextItem('txtMsg4','txtMemo');
				goNextItem('txtMemo','txtDatea');
				//-------REFRESH
				$('#btnRefresh').click(function(e){
					if($(this).hasClass('edit')){
						alert('修改中，資料無法刷新');
						return;
					}
					var stype = $.trim($('#cmbStype').val());
					var cust = $.trim($('#textCust').text());
					var so = $.trim($('#textSo').text());//追蹤 OR S/O
					var containerno = $.trim($('#textContainerno').text());
					var ordeno = $.trim($('#textOrdeno').text());
					var bdate = $.trim($('#txtBdate').text());
					var edate = $.trim($('#txtEdate').text());
					var relay = $.trim($('#cmbRelay').val());
					var finish = $.trim($('#cmbFinish').val());
					Lock(1,{opacity:0});
					loadCount(stype,cust,so,containerno,ordeno,bdate,edate,relay,finish);
				});
				$('#txtCurpage').change(function(e){
					$('#btnRefresh').click();
				});
				$('#btnNext').click(function(e){
					var curPage = 0;
					try{
						curPage = parseInt($('#txtCurpage').val());
					}catch(e){}
					curPage = isNaN(curPage)?0:curPage;
					var totPage = 0;
					try{
						totPage = parseInt($('#txtTotpage').val());
					}catch(e){}
					curPage++;
					if(curPage<0 || curPage>totPage)
						curPage = 1;
					$('#txtCurpage').val(curPage);
					$('#btnRefresh').click();
				});
				$('#btnPrev').click(function(e){
					var curPage = 0;
					try{
						curPage = parseInt($('#txtCurpage').val());
					}catch(e){}
					curPage = isNaN(curPage)?1:curPage;
					var totPage = 0;
					try{
						totPage = parseInt($('#txtTotpage').val());
					}catch(e){}
					curPage--;
					if(curPage<=0 || curPage>totPage)
						curPage = totPage;
					$('#txtCurpage').val(curPage);
					$('#btnRefresh').click();
				});
				//---------------------------------------------
				$('#txtBdate').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//格式判斷
					var patt = /(^\d{0,3}$)|(^\d{3}\/$)|(^\d{3}\/\d{0,2}$)|(^\d{3}\/\d{2}\\$)|(^\d{3}\/\d{2}\/\d{0,2}$)/;
					if(/^\d{3}\d$/.test(curVal)){
						$(this).text(curVal.replace(/^(\d{3})(\d)$/,'$1/$2'));
					}else if(/^\d{3}\/\d{3}$/.test(curVal)){
						$(this).text(curVal.replace(/^(\d{3}\/\d{2})(\d)$/,'$1/$2'));
					}else if(!patt.test(curVal)){
						$(this).text(prevVal);
					}
					//跳到字尾
					var doc = document;
		            var element = $(this)[0];
					if (window.getSelection) {
		                var selection = window.getSelection();
		                var range = document.createRange();
		                range.selectNodeContents(element);
		                selection.removeAllRanges();
		                selection.addRange(range);
		                selection.collapseToEnd();
		            }
		            //跳下一格
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtEdate').focus();
		            }
				});
				$('#txtEdate').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//格式判斷
					var patt = /(^\d{0,3}$)|(^\d{3}\/$)|(^\d{3}\/\d{0,2}$)|(^\d{3}\/\d{2}\\$)|(^\d{3}\/\d{2}\/\d{0,2}$)/;
					if(/^\d{3}\d$/.test(curVal)){
						$(this).text(curVal.replace(/^(\d{3})(\d)$/,'$1/$2'));
					}else if(/^\d{3}\/\d{3}$/.test(curVal)){
						$(this).text(curVal.replace(/^(\d{3}\/\d{2})(\d)$/,'$1/$2'));
					}else if(!patt.test(curVal)){
						$(this).text(prevVal);
					}
					//跳到字尾
					var doc = document;
		            var element = $(this)[0];
					if (window.getSelection) {
		                var selection = window.getSelection();
		                var range = document.createRange();
		                range.selectNodeContents(element);
		                selection.removeAllRanges();
		                selection.addRange(range);
		                selection.collapseToEnd();
		            }
		            //跳下一格
		            if(e.which==13){
		            	$(this).text(prevVal);
		            }
				});
			}
			function goNextItem(str,end){
				$('.'+str).keydown(function(e){
					$(this).data('pervData',this.text);
					if(e.which==13){
						e.preventDefault();
						//跳下一格
						var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
			            if(e.which==13){
							if(end.length>0){
								var y = window.scrollY;
								$('#'+end+'_'+n).focus();
								window.scrollTo($('#'+end+'_'+n).offset().left - 200, y);
							}
			            }
					}
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					/*var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	if(end.length>0)
		            		$('#'+end+'_'+n).focus();
		            }*/
				});
			}
			function refresh(){
				var obj = $('.tData').find('tr');
				for(var i=0;i<obj.length;i++){
					obj.eq(i).data('data',_curData.length>i?JSON.stringify(_curData[i]):"");
					objs = obj.eq(i).find('td');
					for(var j=0;j<objs.length;j++){
						objt = objs.eq(j).find('a,input[type="checkbox"]');
						for(var k=0;k<objt.length;k++){
							t_id = objt.eq(k).attr('id');
							if(t_id.substring(0,3)=='txt'){
								t_field = t_id!=undefined?t_id.replace(/txt(.*)(_\d+)/g,"$1").toLowerCase():'';
								if(t_field.length>0)
									objt.eq(k).text(i < _curData.length?_curData[i][t_field]:'');
							}else if(t_id.substring(0,3)=='chk'){
								objt.eq(k).attr('disabled','disabled');
								t_field = t_id!=undefined?t_id.replace(/chk(.*)(_\d+)/g,"$1").toLowerCase():'';
								if(t_field.length>0){
									objt.eq(k).prop('checked',i < _curData.length?_curData[i][t_field]:false);
								}
							}
						}
					}
				}
				$('.btnSel').attr('disabled','disabled');
				$('.btnDelete').attr('disabled','disabled').css('color','black');
				for(var i=0;i<_curData.length;i++){
					$('#btnSel_'+i).removeAttr('disabled');
				}
			}
			function loadCount(stype,cust,so,containerno,ordeno,bdate,edate,relay,finish){
				console.log("loadCount");
				console.log(stype+" "+cust+" "+so+" "+containerno+" "+ordeno
					+" "+bdate+" "+edate+" "+relay+" "+finish);
				$.ajax({
					stype:stype,
					cust:cust,
					so:so,
					containerno:containerno,
					ordeno:ordeno,
					bdate:bdate,
					edate:edate,
					relay:relay,
					finish:finish,
					totCount : 0,
                    url: 'tranvcce_at_getcount.aspx',
                    headers: { 'database': q_db },
                    type: 'POST',
                    data: JSON.stringify({stype:stype,cust:cust,so:so,containerno:containerno,ordeno:ordeno,bdate:bdate,edate:edate,relay:relay,finish:finish}),
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                    	try{
                    		tmp = JSON.parse(data);
                    		this.totCount = tmp.count;
                    		console.log('tranvcce_at_getcount');
                        	console.log(tmp.version);
                    	}catch(e){
                    	}
                    },
                    complete: function(){
                    	var totPage = _pageCount>0?Math.floor((this.totCount-1)/_pageCount)+1:0;
                    	$('#txtTotpage').val(totPage);
                    	curPage = parseInt($('#txtCurpage').val());
						curPage = isNaN(curPage)?1:curPage;
						curPage = curPage<=0 || curPage>totPage ?1:curPage;
						$('#txtCurpage').val(curPage);
						var nstr = (curPage-1) * _pageCount + 1;
						var nend = curPage * _pageCount;
                    	loadData(nstr,nend,this.stype,this.cust,this.so,this.containerno,this.ordeno,this.bdate,this.edate,this.relay,this.finish);                  
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = this.url+'資料讀取異常。\n';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });	
			}
			function loadData(nstr,nend,stype,cust,so,containerno,ordeno,bdate,edate,relay,finish){
				console.log("loadData");
				console.log(nstr+" "+nend+" "+stype+" "+cust+" "+so+" "+containerno
					+" "+ordeno+" "+bdate+" "+edate+" "+relay+" "+finish);
				$.ajax({
                    url: 'tranvcce_at_getdata.aspx',
                    headers: { 'database': q_db },
                    type: 'POST',
                    data: JSON.stringify({nstr:nstr,nend:nend,stype:stype,cust:cust,so:so,containerno:containerno,ordeno:ordeno,bdate:bdate,edate:edate,relay:relay,finish:finish}),
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                        _curData = JSON.parse(data);
                    },
                    complete: function(){ 
                    	refresh();   
                    	Unlock(1);                
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = this.url+'資料讀取異常。\n';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });	
			}
			function updateData(n){
				if(n<0 || n>=_curData.length){
					alert('資料異常:'+n);
					return;
				}
				Lock(1,{opacity:0});
				//更新 _curData的資料
				var obj = $('.tData').find('tr').eq(n).find('a,input[type="checkbox"]');
				for(var i=0;i<obj.length;i++){
					t_id = obj.eq(i).attr('id');
					if(t_id.substring(0,3)=='txt'){
						t_field = t_id!=undefined?t_id.replace(/txt(.*)(_\d+)/g,"$1").toLowerCase():'';
						_curData[n][t_field] = obj.eq(i).text();
					}else if(t_id.substring(0,3)=='chk'){
						t_field = t_id!=undefined?t_id.replace(/chk(.*)(_\d+)/g,"$1").toLowerCase():'';
						_curData[n][t_field] = obj.eq(i).prop('checked');
					}
				}
				console.log("updateData");
				console.log(JSON.stringify(_curData[n]));
				$.ajax({
					n:n,
					seq: _curData[n].seq,
                    url: 'tranvcce_at_update.aspx',
                    headers: { 'database': q_db },
                    type: 'POST',
                    data: JSON.stringify(_curData[n]),
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                        if(data.length>0){
                        	alert(data);
                        }
                    },
                    complete: function(){ 
                    	_curData[this.n]['issend1'] = false;
						_curData[this.n]['issend2'] = false;
						_curData[this.n]['issend3'] = false;
						_curData[this.n]['issend4'] = false;
						$('#chkIssend1_'+this.n).attr('disabled','disabled').prop('checked',false);
						$('#chkIssend2_'+this.n).attr('disabled','disabled').prop('checked',false);
						$('#chkIssend3_'+this.n).attr('disabled','disabled').prop('checked',false);
						$('#chkIssend4_'+this.n).attr('disabled','disabled').prop('checked',false);
                    	Unlock(1);                
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = this.url+'資料寫入異常 SEQ:'+this.seq+'。\n';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });	
			}
			function deleteData(n){
				if(n<0 || n>=_curData.length){
					alert('資料異常:'+n);
					return;
				}
				if ( confirm ("刪除資料?") ){
					//YES
				}else{
					return;
				}
				Lock(1,{opacity:0});
				var data = {seq:_curData[n].seq,user:r_name};
				console.log("deleteData");
				console.log(JSON.stringify(data));
				$.ajax({
					n:n,
					seq: _curData[n].seq,
                    url: 'tranvcce_at_delete.aspx',
                    headers: { 'database': q_db },
                    type: 'POST',
                    data: JSON.stringify(data),
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                        if(data.length>0){
                        	alert(data);
                        }
                        $('#btnSel_'+n).data('isDelete',true);
                        $('#btnSel_'+n).click();
                        $('#btnRefresh').click();
                    },
                    complete: function(){ 
                    	Unlock(1);                
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = this.url+'資料寫入異常 SEQ:'+this.seq+'。\n';
                        if (jqXHR.status === 0) {
                            alert(errmsg+'Not connect.\n Verify Network.');
                        } else if (jqXHR.status == 404) {
                            alert(errmsg+'Requested page not found. [404]');
                        } else if (jqXHR.status == 500) {
                            alert(errmsg+'Internal Server Error [500].');
                        } else if (exception === 'parsererror') {
                            alert(errmsg+'Requested JSON parse failed.');
                        } else if (exception === 'timeout') {
                            alert(errmsg+'Time out error.');
                        } else if (exception === 'abort') {
                            alert(errmsg+'Ajax request aborted.');
                        } else {
                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                        }
                    }
                });	
			}
		</script>
		<style type="text/css">
            .tHeader {
                border: 1px solid gray;
                font-size: medium;
                background-color: gray;
            }
            .tHeader td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: darkblue;
            }
            .tHeader a {
                color: white;
            }
            .tData {
                border: 1px solid gray;
                font-size: medium;
                background-color: white;
            }
            .tData tr {
                height:35px;
            }
            .tData td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #cad3ff;
            }
            .tData td.edit {
            	background-color: pink;
                /*background-color: #FF8800;*/
            }
            .tData a {
                color: black;
            }
		</style>
	</head>
	<body>
		<!-- 控制列   -->
		<div style="min-width:2400px;width: 2400px;height:40px;float:none;">
			<div id='q_menu'></div>
			<span style="display:block;width:50px;float:left;text-align: center;">&nbsp;</span>
			<div style="display:block;width:160px;float:left;">
				<span style="display:block;width:80px;float:left;text-align: center;">訂單類別：</span>
				<select id="cmbStype" style="float:left;width:80px;text-align: center;">
					<option value="">全部</option>
					<option value="進口">進口</option>
					<option value="出口">出口</option>
				</select>
			</div>
			<div style="display:block;width:100px;float:left;">
				<select id="cmbFinish" style="float:left;width:80px;text-align: center;">
					<option value="0">未完成</option>
					<option value="1">已完成</option>
				</select>
			</div>
			<div style="display:block;width:160px;float:left;">
				<span style="display:block;width:80px;float:left;text-align: center;">中繼站：</span>
				<select id="cmbRelay" style="float:left;width:80px;text-align: center;">
					<option value="">全部</option>
					<option value="0">無</option>
					<option value="1">有</option>
				</select>
			</div>
			<span style="display:block;width:10px;float:left;text-align: center;">&nbsp;</span>
			<span style="display:block;width:50px;float:left;text-align: center;">貨主：</span>
			<a id="textCust" style="float:left;width:100px;text-align: center;background-color: #EEFFEE;" contenteditable="true"></a>
			<span style="display:block;width:10px;float:left;text-align: center;">&nbsp;</span>
			<span style="display:block;width:100px;float:left;text-align: center;">追蹤、S/O</span>
			<a id="textSo" style="float:left;width:150px;text-align: center;background-color: #EEFFEE;" contenteditable="true"></a>
			<span style="display:block;width:10px;float:left;text-align: center;">&nbsp;</span>
			<span style="display:block;width:100px;float:left;text-align: center;">櫃號</span>
			<a id="textContainerno" style="float:left;width:150px;text-align: center;background-color: #EEFFEE;" contenteditable="true"></a>
			<span style="display:block;width:10px;float:left;text-align: center;">&nbsp;</span>
			<span style="display:block;width:100px;float:left;text-align: center;">訂單號碼</span>
			<a id="textOrdeno" style="float:left;width:150px;text-align: center;background-color: #EEFFEE;" contenteditable="true"></a>
			<span style="display:block;width:10px;float:left;text-align: center;">&nbsp;</span>
			<span style="display:block;width:50px;float:left;text-align: center;">日期：</span>
			<!--<a id="txtBdate" style="float:left;width:80px;text-align: center;background-color: #99FF99;" contenteditable="true"></a>
			<input id="txtBdate-input" style="display:none;" />
			<span style="display:block;width:30px;float:left;text-align: center;">~</span>
			<a id="txtEdate" style="float:left;width:80px;text-align: center;background-color: #99FF99;" contenteditable="true"></a>
			<input id="txtEdate-input" style="display:none;" />
			-->
			<span style="display:block;width:30px;float:left;text-align: center;">&nbsp;</span>
			<input type="button" id="btnRefresh" value="資料刷新" style="float:left;width:100px;"/>
			<input type="button" id="btnPrev" value="上一頁" style="float:left;width:100px;"/>
			<input type="button" id="btnNext" value="下一頁" style="float:left;width:100px;"/>
			<span style="display:block;width:30px;float:left;text-align: center;">&nbsp;</span>
			<input type="text" id="txtCurpage" style="float:left;width:50px;text-align: center;"/>
			<span style="display:block;width:30px;float:left;text-align: center;">/</span>
			<input type="text" id="txtTotpage" style="float:left;width:50px;text-align: center;color:green;" readonly="readonly"/>
			<span style="display:block;width:50px;float:left;text-align: center;">&nbsp;</span>
			<input type='button' id='btnPrint' name='btnPrint' style='font-size:16px;float:left;' value='列印'/>
			<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;float:left;' value='權限'/>
		</div>
		<!-- 欄位名稱  -->
		<div style="min-width:4100px;width: 4100px;overflow-y:scroll;">
			<table class="tHeader">
				<tr>
					<td align="center" style="width:50px; max-width:50px; color:black; font-weight: bolder;"><a>序</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>派車單號</a></td>
					<td align="center" style="width:40px; max-width:40px; color:black;"><a>類別</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>運輸單號</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>客戶</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>提貨地點</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>中繼站</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>收貨人/地點</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>計價區域</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>計價車種</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>裝貨日期</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>卸貨日期</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>危險等級</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>品名</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>承載單位</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>數量</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>計價單位</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>品重(KG)</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>毛重(KG)</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>車牌</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>司機</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>車趟</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>注意事項</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>裝貨</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>卸貨</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>拉貨</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>完工</a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a style="color:red;">資料刪除</a></td>
				</tr>
			</table>
		</div>
		<!-- 資料   -->
		<div style="display:none;min-width:4100px;width: 4100px;overflow-y:scroll;">
			<table class="tSchema">
				<tr>
					<td align="center" style="width:50px; max-width:50px; color:black;"><input id="btnSel" type="button" class="btnSel"/></td>
					
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--派車單號--><a id="txtVccno"style="display:block;width:100%;"> </a></td>
					<td align="center" style="width:40px; max-width:40px; color:black;"><!--類別--><a id="txtCalctype"style="display:block;width:100%;"> </a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--運輸單號--><a id="txtConn"style="display:block;width:100%;"> </a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;">
						<!--客戶-->
						<a id="txtCustno"style="display:block;width:100%;"> </a>
						<a id="txtCust"style="display:block;width:100%;"> </a>
					</td>
					<td align="center" style="width:100px; max-width:100px;color:black;">
						<!--提貨地點-->
						<a id="txtAddrno"style="display:block;width:100%;"> </a>
						<a id="txtAddr"style="display:block;width:100%;"> </a>	
						<a id="txtAddress"style="display:block;width:100%;"> </a>	
					</td>
					<td align="center" style="width:100px; max-width:100px;color:black;">
						<!--中繼站-->
						<a id="txtAddrno3"style="display:block;width:100%;"> </a>
						<a id="txtAddr3"style="display:block;width:100%;"> </a>	
					</td>
					<td align="center" style="width:100px; max-width:100px;color:black;">
						<!--收貨人/地點-->
						<a id="txtAddrno2"style="display:block;width:100%;"> </a>
						<a id="txtAddr2"style="display:block;width:100%;"> </a>	
						<a id="txtAddress2"style="display:block;width:100%;"> </a>	
					</td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--計價區域--><a id="txtLat"style="display:block;width:100%;"> </a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--計價車種--><a id="txtTime3"style="display:block;width:100%;"> </a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;">
						<!--裝貨日期-->
						<a id="txtBdate"style="display:block;width:100%;"> </a>
						<a id="txtTime1"style="display:block;width:100%;"> </a>
					</td>
					<td align="center" style="width:100px; max-width:100px;color:black;">
						<!--卸貨日期-->
						<a id="txtEdate"style="display:block;width:100%;"> </a>
						<a id="txtTime2"style="display:block;width:100%;"> </a>
					</td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--危險等級--><a id="txtTypea"style="display:block;width:100%;"> </a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;">
						<!--品名-->
						<a id="txtProductno"style="display:block;width:100%;"> </a>
						<a id="txtProduct"style="display:block;width:100%;"> </a>
					</td>
					<td align="center" style="width:100px; max-width:100px;color:black;">
						<!--承載單位-->
						
					</td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--數量--></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--計價單位--></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--品重(KG)--><a></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--毛重(KG)--><a></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--車牌--><a></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--司機--><a></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--車趟--><a></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--注意事項--><a></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--裝貨--><a></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--卸貨--><a></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--拉貨--><a></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><!--完工--><a></a></td>
					
					<td align="center" style="width:40px; max-width:40px;color:black;"><input type="checkbox" id="chkIsfinish" style="width:20px;height:20px;"/></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a id="txtStype" class="readonly"></a><BR><a id="txtOrdeno" class="readonly"></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtDatea" style="display:block;width:100%;height:20px;"></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtCust" class="readonly"></a></td>
					<td align="center" style="width:190px; max-width:190px;color:black;"><a id="txtStraddrno" style="display:block;width:100%;height:20px;"></a><a id="txtStraddr" style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:40px; max-width:40px;color:black;"><input type="checkbox" id="chkIsrelay" style="width:20px;height:20px;"/></td>
					<td align="center" style="width:130px; max-width:130px;color:black;"><a id="txtPor" class="readonly" style="display:block;width:100%;height:20px;"></a><a id="txtPod" class="readonly"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtUcr" class="readonly" style="display:block;width:100%;height:20px;"></a><a id="txtVr" class="readonly" style="display:block;width:100%;height:20px;"></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtVocc" class="readonly" style="display:block;width:100%;height:20px;"></a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtProduct" class="readonly"style="display:block;width:100%;height:20px;"></a><a id="txtCasetype"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a id="txtContainerno1"style="display:block;width:100%;height:20px;"></a><a id="txtContainerno2"style="display:block;width:100%;height:20px;" class="field2"></a></td>
					<!--<td align="center" style="width:120px; max-width:120px;color:black;"><a id="txtSeal1"style="display:block;width:100%;height:20px;"></a><a id="txtSeal2"style="display:block;width:100%;height:20px;" class="field2"></a></td>-->
					<td align="center" style="width:60px; max-width:60px;color:black;"><a id="txtMount"style="display:block;width:100%;"></a></td>
					<td align="center" style="width:40px; max-width:40px;color:black;"><input type="checkbox" id="chkIsassign" style="width:20px;height:20px;"/></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtCarno1"style="display:block;width:100%;height:20px;"></a><a id="txtCardno1"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtYard1"style="display:block;width:100%;"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtDate1"style="display:block;width:90%;float:left;"></a><input id="txtDate1-input" style="float:left;display:none;width:1%;" class="date-input"/></td>
					
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtCarno5"style="display:block;width:100%;height:20px;"></a><a id="txtCardno5"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtYard5"style="display:block;width:100%;"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtDate5"style="display:block;width:90%;float:left;"></a><input id="txtDate5-input" style="float:left;display:none;width:1%;" class="date-input"/></td>
					
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtCarno2"style="display:block;width:100%;height:20px;"></a><a id="txtCardno2"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtYard2"style="display:block;width:100%;"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtDate2"style="display:block;width:90%;float:left;"></a><input id="txtDate2-input" style="float:left;display:none;width:1%;" class="date-input"/></td>
					
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtCarno6"style="display:block;width:100%;height:20px;"></a><a id="txtCardno6"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtDate6"style="display:block;width:90%;float:left;"></a><input id="txtDate6-input" style="float:left;display:none;width:1%;" class="date-input"/></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtCarno7"style="display:block;width:100%;height:20px;"></a><a id="txtCardno7"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtYard6"style="display:block;width:100%;"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtDate7"style="display:block;width:90%;float:left;"></a><input id="txtDate7-input" style="float:left;display:none;width:1%;" class="date-input"/></td>		
					
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtCarno3"style="display:block;width:100%;height:20px;"></a><a id="txtCardno3"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtYard3"style="display:block;width:100%;"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtDate3"style="display:block;width:90%;float:left;"></a><input id="txtDate3-input" style="float:left;display:none;width:1%;" class="date-input"/></td>
					
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtCarno8"style="display:block;width:100%;height:20px;"></a><a id="txtCardno8"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtDate8"style="display:block;width:90%;float:left;"></a><input id="txtDate8-input" style="float:left;display:none;width:1%;" class="date-input"/></td>
					
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtCarno4"style="display:block;width:100%;height:20px;"></a><a id="txtCardno4"style="display:block;width:100%;height:20px;"class="field2"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtYard4"style="display:block;width:100%;"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtDate4"style="display:block;width:90%;float:left;"></a><input id="txtDate4-input" style="float:left;display:none;width:1%;" class="date-input"/></td>
					<td align="center" style="width:50px; max-width:50px;color:black;"><input type="checkbox" id="chkIssend1" style="width:20px;height:20px;"/></td>
					<td align="center" style="width:90px; max-width:90px;color:black;"><a id="txtMsg1"style="display:block;width:100%;height:20px;"></a></td>
					<td align="center" style="width:50px; max-width:50px;color:black;"><input type="checkbox" id="chkIssend2" style="width:20px;height:20px;"/></td>
					<td align="center" style="width:90px; max-width:90px;color:black;"><a id="txtMsg2"style="display:block;width:100%;height:20px;"></a></td>
					<td align="center" style="width:50px; max-width:50px;color:black;"><input type="checkbox" id="chkIssend3" style="width:20px;height:20px;"/></td>
					<td align="center" style="width:90px; max-width:90px;color:black;"><a id="txtMsg3"style="display:block;width:100%;height:20px;"></a></td>
					<td align="center" style="width:50px; max-width:50px;color:black;"><input type="checkbox" id="chkIssend4" style="width:20px;height:20px;"/></td>
					<td align="center" style="width:90px; max-width:90px;color:black;"><a id="txtMsg4"style="display:block;width:100%;height:20px;"></a></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a id="txtMemo"style="display:block;width:100%;height:20px;"></a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><input id="btnDelete" type="button" class="btnDelete" value="X"/></td>
				</tr>
			</table>
		</div>
		<div style="min-width:4100px;width: 4100px;height:800px;overflow-y:scroll;">
			<table class="tData">
			</table>
		</div>
	</body>
</html>
