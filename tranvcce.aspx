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
			var _pageCount = 20; //一頁幾筆資料
            var _curData = new Array();
			
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
				init(_pageCount);
				loadCount();
            });
			function init(tCount){
				for(var i=0;i<tCount;i++){
					$('.tData').append($('.tSchema').find('tr').eq(0).clone().data('key',i).data('data',''));	
					for(var j=0;j<$('.tData').find('tr').eq(i).find('td').length;j++){
						var obj = $('.tData').find('tr').eq(i).find('td').eq(j).find('input[type="button"]').eq(0);
						obj.attr('id',obj.attr('id')+'_'+i).attr('value',i+1);
						obj.click(function(e){	
							var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
							if($(this).parent().parent().data('data').length == 0)
								return;
							if($(this).hasClass('edit')){
								$(this).removeClass('edit');
								$(this).parent().prevAll().removeClass('edit');
								$(this).parent().nextAll().removeClass('edit');
								$('.btnSel').removeClass('edit');
								$(this).css('color','');
								$(this).parent().parent().find('a').each(function(e){
									$(this).removeClass('edit').attr("contenteditable","false").css('color','black');
								});
								$('.btnSel').attr('disabled','disabled');
								for(var i=0;i<_curData.length;i++){
									$('#btnSel_'+i).removeAttr('disabled');
								}
								updateData(n);
							}else{
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
					            $('#txtDatea_'+n).focus();
					            //----------------------------------------------
								$(this).addClass('edit');
								$(this).parent().prevAll().addClass('edit');
								$(this).parent().nextAll().addClass('edit');
								$('.btnSel').attr('disabled','disabled');
								$(this).removeAttr('disabled');
								$(this).css('color','red');
								$(this).parent().parent().find('a').each(function(e){
									if(!$(this).hasClass('readonly')){
										$(this).addClass('edit').attr("contenteditable","true");
									}else{
										$(this).css('color','darkgreen');
									}
								});
							}
						});
						
						var obj = $('.tData').find('tr').eq(i).find('td').eq(j).find('a').eq(0);
						obj.addClass(obj.attr('id')).attr('id',obj.attr('id')+'_'+i);
						if(!obj.hasClass('readonly')){
							obj.focus(function(e) {
								if($(this).hasClass('edit'))
			                    	$(this).selectText();
			                });
						}
					}
				}
				$('.txtDatea').keydown(function(e){
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
				$('.txtStraddrno').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtStraddr_'+n).focus();
		            }
				});
				$('.txtStraddr').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtCasetype_'+n).focus();
		            }
				});
				$('.txtCasetype').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtContainerno1_'+n).focus();
		            }
				});
				$('.txtContainerno1').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtContainerno2_'+n).focus();
		            }
				});
				$('.txtContainerno2').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtCarno1_'+n).focus();
		            }
				});
				$('.txtCarno1').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtCarno2_'+n).focus();
		            }
				});
				$('.txtCarno2').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtCarno3_'+n).focus();
		            }
				});
				$('.txtCarno3').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtCarno4_'+n).focus();
		            }
				});
				$('.txtCarno4').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            	$('#txtMemo_'+n).focus();
		            }
				});
				$('.txtMemo').keydown(function(e){
					$(this).data('pervData',this.text);
				}).keyup(function(e) {
					var prevVal = $(this).data('pervData');
					var curVal = $(this).text();
					//跳下一格
					var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
		            if(e.which==13){
		            	$(this).text(prevVal);
		            }
				});
				//-------REFRESH
				$('#btnRefresh').click(function(e){
					var curPage = 1;
					try{
						curPage = parseInt($('#txtCurpage').val());
					}catch(e){
						
					}
					$('#txtCurpage').val(curPage);
					var nstr = (curPage-1) * _pageCount + 1;
					var nend = curPage * _pageCount;
					var bdate = $('#txtBdate').text();
					var edate = $('#txtEdate').text();
					loadData(nstr,nend,bdate,edate);
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
					curPage = isNaN(curPage)?0:curPage;
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
			function refresh(){
				var obj = $('.tData').find('tr');
				for(var i=0;i<obj.length;i++){
					obj.eq(i).data('data',_curData.length>i?JSON.stringify(_curData[i]):"");
					objs = obj.eq(i).find('td');
					for(var j=0;j<objs.length;j++){
						t_id = objs.eq(j).find('a').eq(0).attr('id');
						t_field = t_id!=undefined?t_id.replace(/txt(.*)(_\d+)/g,"$1").toLowerCase():'';
						$('#txtMemo_'+i).text(t_field);						
						if(t_field.length>0){
							if(i < _curData.length){
								objs.eq(j).find('a').eq(0).text(_curData[i][t_field]);
							}else{
								objs.eq(j).find('a').eq(0).text('');
							}
						}
					}
				}
				$('.btnSel').attr('disabled','disabled');
				for(var i=0;i<_curData.length;i++){
					$('#btnSel_'+i).removeAttr('disabled');
				}
			}
			function loadCount(){
				$.ajax({
					totCount : 0,
                    url: 'tranvcce_getcount.aspx',
                    type: 'POST',
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                    	try{
                    		tmp = JSON.parse(data);
                    		this.totCount = tmp.count;
                    	}catch(e){
                    	}
                    },
                    complete: function(){
                    	var totPage = _pageCount>0?Math.floor((this.totCount-1)/_pageCount)+1:0;
                    	$('#txtCurpage').val(totPage==0?0:1);
                    	$('#txtTotpage').val(totPage);
                    	$('#btnRefresh').click();                  
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = '資料讀取異常。\n';
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
			function loadData(nstr,nend,bdate,edate){
				Lock(1,{opacity:0});
				$.ajax({
                    url: 'tranvcce_getdata.aspx',
                    type: 'POST',
                    data: JSON.stringify({nstr:nstr,nend:nend,bdate:bdate,edate:edate}),
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
                        var errmsg = '資料讀取異常。\n';
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
				var obj = $('.tData').find('tr').eq(n).find('a');
				for(var i=0;i<obj.length;i++){
					t_id = obj.eq(i).attr('id');
					if(t_id!=undefined){
						t_field = t_id.replace(/^txt(.+)_\d+/,"$1").toLowerCase();
						_curData[n][t_field] = obj.eq(i).text();
					}
				}
				$.ajax({
					seq: _curData[n].seq,
                    url: 'tranvcce_update.aspx',
                    type: 'POST',
                    data: JSON.stringify(_curData[n]),
                    dataType: 'text',
                    timeout: 10000,
                    success: function(data){
                        if(data.length>0){
                        	alert(data)
                        }
                    },
                    complete: function(){ 
                    	Unlock(1);                
                    },
                    error: function(jqXHR, exception) {
                        var errmsg = '資料寫入異常 SEQ:'+this.seq+'。\n';
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
		<div style="min-width:1000px;width: 1500px;height:40px;float:none;">
			<input type="button" id="btnRefresh" value="資料刷新" style="float:left;width:100px;"/>
			<input type="button" id="btnPrev" value="上一頁" style="float:left;width:100px;"/>
			<input type="button" id="btnNext" value="下一頁" style="float:left;width:100px;"/>
			<span style="display:block;width:30px;float:left;text-align: center;">&nbsp;</span>
			<input type="text" id="txtCurpage" style="float:left;width:50px;text-align: center;"/>
			<span style="display:block;width:30px;float:left;text-align: center;">/</span>
			<input type="text" id="txtTotpage" style="float:left;width:50px;text-align: center;color:green;" readonly="readonly"/>
			<span style="display:block;width:30px;float:left;text-align: center;">&nbsp;</span>
			<span style="display:block;width:50px;float:left;text-align: center;">日期：</span>
			<a id="txtBdate" style="float:left;width:80px;text-align: center;background-color: #99FF99;" contenteditable="true"></a>
			<span style="display:block;width:30px;float:left;text-align: center;">~</span>
			<a id="txtEdate" style="float:left;width:80px;text-align: center;background-color: #99FF99;" contenteditable="true"></a>
		</div>
		<div style="min-width:1750px;width: 1750px;overflow-y:scroll;">
			<table class="tHeader">
				<tr>
					<td align="center" style="width:50px; max-width:50px; color:black; font-weight: bolder;"><a>序</a></td>
					<td align="center" style="width:120px; max-width:120px; color:black;"><a>訂單號碼</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>日期</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>貨主</a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a>起迄編號</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>起迄地點</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>船公司</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>規格</a></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a>櫃號一</a></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a>櫃號二</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>領</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>送</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>收</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a>交</a></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a>備註</a></td>
				</tr>
			</table>
		</div>
		<div style="display:none;min-width:1750px;width: 1750px;overflow-y:scroll;">
			<table class="tSchema">
				<tr>
					<td align="center" style="width:50px; max-width:50px; color:black;"><input id="btnSel" type="button" class="btnSel"/></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a id="txtOrdeno" class="readonly">訂單號碼</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtDatea" >日期</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtCust" class="readonly">貨主</a></td>
					<td align="center" style="width:80px; max-width:80px;color:black;"><a id="txtStraddrno">起迄編號</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtStraddr">起迄地點</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtVocc" class="readonly">船公司</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtCasetype">規格</a></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a id="txtContainerno1">櫃號一</a></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a id="txtContainerno2">櫃號二</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtCarno1">領</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtCarno2">送</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtCarno3">收</a></td>
					<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtCarno4">交</a></td>
					<td align="center" style="width:120px; max-width:120px;color:black;"><a id="txtMemo">備註</a></td>
				</tr>
			</table>
		</div>
		<div style="min-width:1750px;width: 1750px;height:800px;overflow-y:scroll;">
			<table class="tData">
			</table>
		</div>
	</body>
</html>
