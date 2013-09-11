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

            var q_name = "tranvcce";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtCommandid','txtOrdeno'];
            var bbmNum = [];
            var bbmMask = [['txtDatea', '999/99/99'],['txtTrandate', '999/99/99'],['txtTrantime', '99:99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 10;

            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            , ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtAddrno', 'lblAddr', 'addr', 'noa,addr', 'txtAddrno,txtAddr', 'addr_b.aspx']
            , ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'] 
            , ['txtProductno', 'lblProduct', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'] 
            , ['txtCaseno', 'lblCaseno', 'view_tranordes', 'caseno,memo,zcaseno', 'txtCaseno', 'tranordes_b.aspx'
                ,"where=^^ a.noa='txtOrdeno' and not exists(select * from tranvcce"+r_accy+" where noa!='txtNoa' and caseno=a.caseno) ^^" ]
            );
  
            function tranorde() {
            }


            tranorde.prototype = {
                data : null,
                tbCount : 10,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                init : function(obj) {
                    //------------------------
                    $('.tranorde_chk').click(function(e) {
                        $(".tranorde_chk").not(this).prop('checked', false);
                        $(".tranorde_chk").not(this).parent().parent().find('td').css('background', 'pink');
                        $(this).prop('checked', true);
                        $(this).parent().parent().find('td').css('background', '#FF8800');
                    });
                    //------------------------
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                        if (obj[i]['noa'] != undefined)
                            this.data.push(obj[i]);
                    }
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textTotPage').val(this.totPage);
                    this.sort('noa', false);
                },
                sort : function(index, isFloat) {
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[tranorde.curIndex] == undefined ? "0" : a[tranorde.curIndex]);
                            var n = parseFloat(b[tranorde.curIndex] == undefined ? "0" : b[tranorde.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[tranorde.curIndex] == undefined ? "" : a[tranorde.curIndex];
                            var n = b[tranorde.curIndex] == undefined ? "" : b[tranorde.curIndex];
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else {
                                if (m < n)
                                    return 1;
                                if (m > n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage == this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                            $('#tranorde_chk' + i).removeAttr('disabled');
                            $('#tranorde_noa' + i).html(this.data[n+i]['noa']);
                            $('#tranorde_ctype' + i).html(this.data[n+i]['ctype']);
                            $('#tranorde_strdate' + i).html(this.data[n+i]['strdate']);
                            $('#tranorde_nick' + i).html(this.data[n+i]['nick']);
                            $('#tranorde_addr' + i).html(this.data[n+i]['addr']);
                            $('#tranorde_product' + i).html(this.data[n+i]['product']);
                            $('#tranorde_mount' + i).html(this.data[n+i]['mount']);
                            $('#tranorde_vccecount' + i).html(this.data[n+i]['vccecount']);
                            $('#tranorde_empdock' + i).html('<a style="float:left;display:block;width:40px;">'+ this.data[n+i]['empdock']+'</a>'+'<a style="float:left;display:block;width:80px;">'+ this.data[n+i]['so']+'</a>');
                            $('#tranorde_port2' + i).html('<a style="float:left;display:block;width:40px;">'+ this.data[n+i]['port2']+'</a>'+'<a style="float:left;display:block;width:80px;">'+ this.data[n+i]['checkself']+ this.data[n+i]['trackno']+'</a>');
                        } else {
                            $('#tranorde_chk' + i).attr('disabled', 'disabled');
                            $('#tranorde_noa' + i).html('');
                            $('#tranorde_ctype' + i).html('');
                            $('#tranorde_strdate' + i).html('');
                            $('#tranorde_nick' + i).html('');
                            $('#tranorde_addr' + i).html('');
                            $('#tranorde_product' + i).html('');
                            $('#tranorde_mount' + i).html('');
                            $('#tranorde_vccecount' + i).html('');
                            $('#tranorde_empdock' + i).html('');
                            $('#tranorde_port2' + i).html('');
                        }
                    }
                    $('#tranorde_chk0').click();
                    $('#tranorde_chk0').prop('checked', 'true');
                },
                browNoa : function(obj){
                	var noa = $.trim($(obj).html());
                	if(noa.length>0)
                		q_box("tranorde.aspx?;;;noa='" + noa + "';"+r_accy, 'tranorde', "95%", "95%", q_getMsg("popTranorde"));
                },
                paste : function() {
                    if (this.totPage <= 0)
                        return;
                    var n = (this.curPage - 1) * this.tbCount;
                    var t_msg = '';
                    for (var i = 0; i < this.tbCount; i++) {
                        //alert($('#tranorde_chk'+i).attr('id')+'_'+$('#tranorde_chk'+i).prop('checked'));
                        if ($('#tranorde_chk' + i).prop('checked')) {
                            $('#txtOrdeno').val(this.data[n+i]['noa']);
                            $('#txtCustno').val(this.data[n+i]['custno']);
                            $('#txtComp').val(this.data[n+i]['comp']);
                            $('#txtNick').val(this.data[n+i]['nick']);
                            $('#txtAddrno').val(this.data[n+i]['addrno']);
                            $('#txtAddr').val(this.data[n+i]['addr']);
                            $('#txtMemo').val(this.data[n+i]['memo']);
                            $('#txtMount').val(1);
                            t_msg = this.data[n+i]['addr'];
                            //出口
                            t_msg += (this.data[n+i]['docketno1'].length>0?(t_msg.length>0?', ':'')+'案號'+this.data[n+i]['docketno1']:'');
                            t_msg += (this.data[n+i]['empdock'].length>0?(t_msg.length>0?',':'')+this.data[n+i]['empdock']+'領':'');
                        	t_msg += (this.data[n+i]['dock'].length>0?(t_msg.length>0?',':'')+'交'+this.data[n+i]['dock']:'');
                        	t_msg += (this.data[n+i]['boat'].length>0?(t_msg.length>0?',':'')+'船公司'+this.data[n+i]['boat']:'');
                        	t_msg += (this.data[n+i]['boatname'].length>0?(t_msg.length>0?',':'')+'船次'+this.data[n+i]['boatname']:'');
                        	t_msg += (this.data[n+i]['do1'].length>0?(t_msg.length>0?',':'')+'領編'+this.data[n+i]['do1']:'');
                        	t_msg += (this.data[n+i]['so'].length>0?(t_msg.length>0?',':'')+'SO:'+this.data[n+i]['so']:'');
                        	t_msg += (this.data[n+i]['casepackaddr'].length>0?(t_msg.length>0?', ':'')+'裝櫃地點'+this.data[n+i]['casepackaddr']:'');
                        	t_msg += (this.data[n+i]['port'].length>0?(t_msg.length>0?',':'')+'港口'+this.data[n+i]['port']:'');
                        	t_msg += (this.data[n+i]['casetype'].length>0?(t_msg.length>0?',':'')+'櫃型'+this.data[n+i]['casetype']:'');
                        	//進口
                        	t_msg += (this.data[n+i]['port2'].length>0?(t_msg.length>0?',':'')+this.data[n+i]['port2']+'領':'');
                        	t_msg += (this.data[n+i]['empdock2'].length>0?(t_msg.length>0?',':'')+'交'+this.data[n+i]['empdock2']:'');
                        	t_msg += (this.data[n+i]['takeno'].length>0?(t_msg.length>0?',':'')+'領編'+this.data[n+i]['takeno']:'');
                        	t_msg += (this.data[n+i]['casepresent'].length>0?(t_msg.length>0?',':'')+'代表櫃號'+this.data[n+i]['casepresent']:'');
                        	t_msg += (this.data[n+i]['product2'].length>0?(t_msg.length>0?',':'')+'品名:'+this.data[n+i]['product2']:'');
                        	t_msg += (this.data[n+i]['option01'].length>0?(t_msg.length>0?',':'')+'過磅'+this.data[n+i]['option01']:'');
                        	t_msg += (this.data[n+i]['option02'].length>0?(t_msg.length>0?',':'')+'加工'+this.data[n+i]['option02']:'');
                        	t_msg += (this.data[n+i]['containertype'].length>0?(t_msg.length>0?',':'')+'櫃別'+this.data[n+i]['containertype']:'');
                        	t_msg += (this.data[n+i]['docketno2'].length>0?(t_msg.length>0?',':'')+'案號'+this.data[n+i]['docketno2']:'');
                        	t_msg += (this.data[n+i]['trackno'].length>0?(t_msg.length>0?',':'')+'追蹤'+this.data[n+i]['trackno']:'');
                            t_msg += (this.data[n+i]['caseassign'].length>0?(t_msg.length>0?',':'')+'指定櫃號'+this.data[n+i]['caseassign']:'');
                        	t_msg += (this.data[n+i]['do2'].length>0?(t_msg.length>0?',':'')+'提單'+this.data[n+i]['do2']:'');
                        	t_msg += (this.data[n+i]['checkself'].length>0?(t_msg.length>0?',':'')+'自檢'+this.data[n+i]['checkself']:'');
                        	t_msg += (this.data[n+i]['checkinstru'].length>0?(t_msg.length>0?',':'')+'儀檢'+this.data[n+i]['checkinstru']:'');
                        	t_msg += (this.data[n+i]['casedo'].length>0?(t_msg.length>0?',':'')+'押運'+this.data[n+i]['casedo']:'');
                        	t_msg += (this.data[n+i]['caseopenaddr'].length>0?(t_msg.length>0?',':'')+'拆櫃地點'+this.data[n+i]['caseopenaddr']:'');
                        	t_msg += (this.data[n+i]['casetype2'].length>0?(t_msg.length>0?',':'')+'櫃型'+this.data[n+i]['casetype2']:'');
                        	
                        	$('#txtMsg').val(t_msg);
                        }
                    }
                }
            }
            tranorde = new tranorde();

            function currentData() {
            }


            currentData.prototype = {
                data : [],
                /*新增時複製的欄位*/
                include : ['txtDatea'],
                /*記錄當前的資料*/
                copy : function() {
                    this.data = new Array();
                    for (var i in fbbm) {
                        var isInclude = false;
                        for (var j in this.include) {
                            if (fbbm[i] == this.include[j]) {
                                isInclude = true;
                                break;
                            }
                        }
                        if (isInclude) {
                            this.data.push({
                                field : fbbm[i],
                                value : $('#' + fbbm[i]).val()
                            });
                        }
                    }
                },
                /*貼上資料*/
                paste : function() {
                    for (var i in this.data) {
                        $('#' + this.data[i].field).val(this.data[i].value);
                    }
                }
            };
            var curData = new currentData();

            $(document).ready(function() {
                bbmKey = ['noa'];
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

            function mainPost() {
            	$('#btnIns').attr('value',$('#btnIns').attr('value')+"(F8)");
            	$('#btnOk').attr('value',$('#btnOk').attr('value')+"(F9)");
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
                $('#txtTrandate').datepicker();
                q_cmbParse("combCtype", ('').concat(new Array( '全部','貨櫃','平板','散裝')));
                q_cmbParse("combDtype", ('').concat(new Array( '全部','出口','進口')));
                q_cmbParse("combMemo", ('').concat(q_getMsg('combmemo').split('&')));
                $('#combMemo').click(function(e){
					if(q_cur==1 || q_cur==2){
						$('#txtMemo').val($('#combMemo>option:selected').text()+$('#txtMemo').val());
					}                	
                });
				//--------------------------------------------------
                $('#btnTranorde_refresh').click(function(e) {
                    t_where = " (isnull(mount,0)>isnull(vccecount,0)) and enda!=1 ";
                    var t_ctype = $('#combCtype>option:selected').text();
                    var t_dtype = $('#combDtype>option:selected').text();
                    if(t_ctype!='全部')
                    	t_where += (t_where.length>0?' and ':'') + "isnull(ctype,'')='"+t_ctype+"'";
                    if(t_dtype=='出口')
                    	t_where += (t_where.length>0?' and ':'') + "len(isnull(empdock,''))>0";
                    if(t_dtype=='進口')
                    	t_where += (t_where.length>0?' and ':'') + "len(isnull(port2,''))>0";	
                    t_where="where=^^"+t_where+"^^";
                    q_gt('view_tranorde', t_where, 0, 0, 0,'aaa', r_accy);
                });
                //自動載入訂單
                $('#btnTranorde_refresh').click();

                $('#btnTranorde_previous').click(function(e) {
                    tranorde.previous();
                });
                $('#btnTranorde_next').click(function(e) {
                    tranorde.next();
                });
                $('#textCurPage').change(function(e) {
                    tranorde.page(parseInt($(this).val()));
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'aaa':
                        var as = _q_appendData("view_tranorde", "", true);
                        if (as[0] != undefined)
                            tranorde.init(as);
                        else
                        	alert('無資料。');
                        break;
                    case 'bbb':
                    	
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,3)=='bbb'){ 
                    		var t_noa = t_name.split('_')[1];
                    		var t_ordeno = t_name.split('_')[2];
                    		var t_mount = parseFloat(t_name.split('_')[3]);
                    		var as = _q_appendData("view_tranorde", "", true);
	                        if (as[0] != undefined){
	                        	t_vccecount = (as[0]['vccecount']==undefined?"0":as[0]['vccecount']);
	                        	t_vccecount = (t_vccecount.length==0?"0":t_vccecount);
	                        	t_where=" noa='"+t_noa+"'";
	                        	t_where="where=^^"+t_where+"^^";
                   				q_gt('tranvcce', t_where, 0, 0, 0, "ccc_"+t_noa+"_"+t_ordeno+"_"+t_mount+"_"+t_vccecount, r_accy);         	
	                        }else{
	                        	var t_noa = trim($('#txtNoa').val());
				                var t_date = trim($('#txtDatea').val());
				                if (t_noa.length == 0 || t_noa == "AUTO")
				                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				                else
				                    wrServer(t_noa);
	                        }	                    	
                    	}else if(t_name.substring(0,3)=='ccc'){
                    		//回寫已收數量
                    		var t_noa = t_name.split('_')[1];
                    		var t_ordeno = t_name.split('_')[2];
                    		var t_mount = parseFloat(t_name.split('_')[3]);
                    		var t_vccecount = parseFloat(t_name.split('_')[4]);
                    		var t_curVccecount = t_vccecount + t_mount;
                    		var as = _q_appendData("tranvcce", "", true);
                    		if (as[0] != undefined){            
                    			t_curVccecount -= parseFloat(as[0]['mount']==undefined?"0":as[0]['mount']);
                    		}
                    		for(var i in tranorde.data){
                				if(tranorde.data[i]['noa']==t_ordeno){
                					tranorde.data[i]['vccecount'] = ''+t_curVccecount;
                					break;
                				}
                			}
                    		tranorde.refresh();
                			var t_noa = trim($('#txtNoa').val());
			                var t_date = trim($('#txtDatea').val());
			                if (t_noa.length == 0 || t_noa == "AUTO")
			                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
			                else
			                    wrServer(t_noa);
                    	}
                        break;
                }
            }

            function q_popPost(id) {
                switch(id) {
                    default:
                        break;
                }
            }

            function q_popFunc(id, key_value) {
                switch(id) {
                    default:
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('tranvcce_s.aspx', q_name + '_s', "600px", "500px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                tranorde.paste();
                $('#chkSendcommandresult').prop('checked',false);
                $('#txtCommandid').val('');               
                $('#txtNoa').val('AUTO');
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
                q_box('z_tranvcce.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
                $('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val()) == 0) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                $('#txtTrandate').val($.trim($('#txtTrandate').val()));
                if ($('#txtTrandate').val().length!=0 && checkId($('#txtTrandate').val()) == 0) {
                    alert(q_getMsg('lblTrandate') + '錯誤。');
                    return;
                }
                if($('#txtTrantime').val().length!=0 && !(/^(?:[0-1][0-9]|2[0-3])\:([0-5][0-9])$/g).test($('#txtTrantime').val())){
                	alert(q_getMsg('lblTrantime') + '錯誤。');
                    return;
                }
                $('#txtOrdeno').val($.trim($('#txtOrdeno').val()));
                if ($('#txtDatea').val().length == 0) {
                    alert('無'+q_getMsg('lblOrdeno') + '。');
                    return;
                }
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!")
                }
				var t_carno = $.trim($('#txtCarno').val());
				var t_msg = $.trim($('#txtMemo').val())
					+(($('#txtTrandate').val()+$('#txtTrantime').val()).length > 0?',出車時間'+$('#txtTrandate').val()+'-'+$('#txtTrantime').val():'')
					+$.trim($('#txtMsg').val());
				
            	if(t_carno.length>0 && t_msg.length>0 && $('#chkSendcommandresult').prop('checked') && $('#txtCommandid').val().length==0){
            		//GPS訊息
            		var t_data = {
	            		GroupName : encodeURI("CHITC195"),
	            		CarId : encodeURI(t_carno),
	            		Message : encodeURI(t_msg),
	            		StatusCode : 1
	            	};
					var json = JSON.stringify(t_data);
	            	$.ajax({
					    url: 'SendCommand.aspx',
					    type: 'POST',
					    data: json,
					    dataType: 'json',
					    success: function(data){
							$('#txtCommandid').val(data['CommandId']);
					    },
				        complete: function(){
				        	t_noa = $.trim($('#txtNoa').val());
		            		t_ordeno = $.trim($('#txtOrdeno').val());
		            		t_mount = $.trim($('#txtMount').val()).length ==0 ? '0':$.trim($('#txtMount').val());
		            		t_where = "noa='"+t_ordeno+"'"
		            		t_where="where=^^"+t_where+"^^";
		                    q_gt('view_tranorde', t_where, 0, 0, 0, "bbb_"+t_noa+"_"+t_ordeno+"_"+t_mount, r_accy); 			         
				        },
					    error: function(jqXHR, exception) {
				            if (jqXHR.status === 0) {
				                alert('Not connect.\n Verify Network.');
				            } else if (jqXHR.status == 404) {
				                alert('Requested page not found. [404]');
				            } else if (jqXHR.status == 500) {
				                alert('Internal Server Error [500].');
				            } else if (exception === 'parsererror') {
				                alert('Requested JSON parse failed.');
				            } else if (exception === 'timeout') {
				                alert('Time out error.');
				            } else if (exception === 'abort') {
				                alert('Ajax request aborted.');
				            } else {
				                alert('Uncaught Error.\n' + jqXHR.responseText);
				            }
				        }
					});
            	}else{
            		t_noa = $.trim($('#txtNoa').val());
            		t_ordeno = $.trim($('#txtOrdeno').val());
            		t_mount = $.trim($('#txtMount').val()).length ==0 ? '0':$.trim($('#txtMount').val());
            		t_where = "noa='"+t_ordeno+"'"
            		t_where="where=^^"+t_where+"^^";
                    q_gt('view_tranorde', t_where, 0, 0, 0, "bbb_"+t_noa+"_"+t_ordeno+"_"+t_mount, r_accy);         		
            	}
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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

            function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
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
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 950px;
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
                width: 950px;
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
                width: 10%;
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
                width: 100%;
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
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            #tranorde_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #tranorde_table tr {
                height: 30px;
            }
            #tranorde_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: pink;
                color: blue;
            }
            #tranorde_header td:hover{
            	background : yellow;
            	cursor : pointer;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNick'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewAddr'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewWeight'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMount'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='carno' style="text-align: center;">~carno</td>
						<td id='driver' style="text-align: center;">~driver</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='addr' style="text-align: center;">~addr</td>
						<td id='weight' style="text-align: right;">~weight</td>
						<td id='mount' style="text-align: right;">~mount</td>
					</tr>
				</table>
			</div>
			<div id="tranorde" style="float:left;width:1500px;">
				<table id="tranorde_table">
					<tr id="tranorde_header">
						<td id="tranorde_chk" align="center" style="width:20px; color:black;"></td>
						<td id="tranorde_sel" align="center" style="width:20px; color:black;"></td>
						<td id="tranorde_noa" onclick="tranorde.sort('noa',false)" title="訂單編號" align="center" style="width:120px; color:black;">訂單編號</td>
						<td id="tranorde_ctype" onclick="tranorde.sort('ctype',false)" title="類型" align="center" style="width:50px; color:black;">類型</td>
						<td id="tranorde_strdate" onclick="tranorde.sort('strdate',false)" title="開工日期" align="center" style="width:100px; color:black;">開工日</td>
						<td id="tranorde_nick" onclick="tranorde.sort('custno',false)" title="客戶" align="center" style="width:100px; color:black;">客戶</td>
						<td id="tranorde_addr" onclick="tranorde.sort('addrno',false)" title="起迄地點" align="center" style="width:200px; color:black;">起迄地點</td>
						<td id="tranorde_product" onclick="tranorde.sort('productno',false)" title="品名" align="center" style="width:100px; color:black;">品名</td>
						<td id="tranorde_mount" onclick="tranorde.sort('mount',true)" align="center" style="width:80px; color:black;">收數量</td>
						<td id="tranorde_vccecount" onclick="tranorde.sort('vccecount',true)" align="center" style="width:80px; color:black;">已派數量</td>
						<td id="tranorde_empdock" onclick="tranorde.sort('empdock',false)" title="領,S/O" align="center" style="width:120px; color:black;">出口櫃</td>
						<td id="tranorde_port2" onclick="tranorde.sort('port2',false)" title="領櫃碼頭,自檢/追蹤" align="center" style="width:120px; color:black;">進口櫃</td>
					</tr>
					<tr id="tranorde_tr0">
						<td style="text-align: center;">
						<input id="tranorde_chk0" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">1</td>
						<td id="tranorde_noa0" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype0" style="text-align: center;"></td>
						<td id="tranorde_strdate0" style="text-align: center;"></td>
						<td id="tranorde_nick0" style="text-align: center;"></td>
						<td id="tranorde_addr0" style="text-align: left;"></td>
						<td id="tranorde_product0" style="text-align: left;"></td>
						<td id="tranorde_mount0" style="text-align: right;"></td>
						<td id="tranorde_vccecount0" style="text-align: right;"></td>
						<td id="tranorde_empdock0" style="text-align: left;"></td>
						<td id="tranorde_port20" style="text-align: left;"></td>
					</tr>
					<tr id="tranorde_tr1">
						<td style="text-align: center;">
						<input id="tranorde_chk1" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">2</td>
						<td id="tranorde_noa1" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype1" style="text-align: center;"></td>
						<td id="tranorde_strdate1" style="text-align: center;"></td>
						<td id="tranorde_nick1" style="text-align: center;"></td>
						<td id="tranorde_addr1" style="text-align: left;"></td>
						<td id="tranorde_product1" style="text-align: left;"></td>
						<td id="tranorde_mount1" style="text-align: right;"></td>
						<td id="tranorde_vccecount1" style="text-align: right;"></td>
						<td id="tranorde_empdock1" style="text-align: left;"></td>
						<td id="tranorde_port21" style="text-align: left;"></td>
					</tr>
					<tr id="tranorde_tr2">
						<td style="text-align: center;">
						<input id="tranorde_chk2" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">3</td>
						<td id="tranorde_noa2" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype2" style="text-align: center;"></td>
						<td id="tranorde_strdate2" style="text-align: center;"></td>
						<td id="tranorde_nick2" style="text-align: center;"></td>
						<td id="tranorde_addr2" style="text-align: left;"></td>
						<td id="tranorde_product2" style="text-align: left;"></td>
						<td id="tranorde_mount2" style="text-align: right;"></td>
						<td id="tranorde_vccecount2" style="text-align: right;"></td>
						<td id="tranorde_empdock2" style="text-align: left;"></td>
						<td id="tranorde_port22" style="text-align: left;"></td>
					</tr>
					<tr id="tranorde_tr3">
						<td style="text-align: center;">
						<input id="tranorde_chk3" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">4</td>
						<td id="tranorde_noa3" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype3" style="text-align: center;"></td>
						<td id="tranorde_strdate3" style="text-align: center;"></td>
						<td id="tranorde_nick3" style="text-align: center;"></td>
						<td id="tranorde_addr3" style="text-align: left;"></td>
						<td id="tranorde_product3" style="text-align: left;"></td>
						<td id="tranorde_mount3" style="text-align: right;"></td>
						<td id="tranorde_vccecount3" style="text-align: right;"></td>
						<td id="tranorde_empdock3" style="text-align: left;"></td>
						<td id="tranorde_port23" style="text-align: left;"></td>
					</tr>
					<tr id="tranorde_tr4">
						<td style="text-align: center;">
						<input id="tranorde_chk4" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">5</td>
						<td id="tranorde_noa4" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype4" style="text-align: center;"></td>
						<td id="tranorde_strdate4" style="text-align: center;"></td>
						<td id="tranorde_nick4" style="text-align: center;"></td>
						<td id="tranorde_addr4" style="text-align: left;"></td>
						<td id="tranorde_product4" style="text-align: left;"></td>
						<td id="tranorde_mount4" style="text-align: right;"></td>
						<td id="tranorde_vccecount4" style="text-align: right;"></td>
						<td id="tranorde_empdock4" style="text-align: left;"></td>
						<td id="tranorde_port24" style="text-align: left;"></td>
					</tr>
					<tr id="tranorde_tr5">
						<td style="text-align: center;">
						<input id="tranorde_chk5" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">6</td>
						<td id="tranorde_noa5" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype5" style="text-align: center;"></td>
						<td id="tranorde_strdate5" style="text-align: center;"></td>
						<td id="tranorde_nick5" style="text-align: center;"></td>
						<td id="tranorde_addr5" style="text-align: left;"></td>
						<td id="tranorde_product5" style="text-align: left;"></td>
						<td id="tranorde_mount5" style="text-align: right;"></td>
						<td id="tranorde_vccecount5" style="text-align: right;"></td>
						<td id="tranorde_empdock5" style="text-align: left;"></td>
						<td id="tranorde_port25" style="text-align: left;"></td>
					</tr>
					<tr id="tranorde_tr6">
						<td style="text-align: center;">
						<input id="tranorde_chk6" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">7</td>
						<td id="tranorde_noa6" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype6" style="text-align: center;"></td>
						<td id="tranorde_strdate6" style="text-align: center;"></td>
						<td id="tranorde_nick6" style="text-align: center;"></td>
						<td id="tranorde_addr6" style="text-align: left;"></td>
						<td id="tranorde_product6" style="text-align: left;"></td>
						<td id="tranorde_mount6" style="text-align: right;"></td>
						<td id="tranorde_vccecount6" style="text-align: right;"></td>
						<td id="tranorde_empdock6" style="text-align: left;"></td>
						<td id="tranorde_port26" style="text-align: left;"></td>
					</tr>
					<tr id="tranorde_tr7">
						<td style="text-align: center;">
						<input id="tranorde_chk7" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">8</td>
						<td id="tranorde_noa7" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype7" style="text-align: center;"></td>
						<td id="tranorde_strdate7" style="text-align: center;"></td>
						<td id="tranorde_nick7" style="text-align: center;"></td>
						<td id="tranorde_addr7" style="text-align: left;"></td>
						<td id="tranorde_product7" style="text-align: left;"></td>
						<td id="tranorde_mount7" style="text-align: right;"></td>
						<td id="tranorde_vccecount7" style="text-align: right;"></td>
						<td id="tranorde_empdock7" style="text-align: left;"></td>
						<td id="tranorde_port27" style="text-align: left;"></td>
					</tr>
					<tr id="tranorde_tr8">
						<td style="text-align: center;">
						<input id="tranorde_chk8" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">9</td>
						<td id="tranorde_noa8" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype8" style="text-align: center;"></td>
						<td id="tranorde_strdate8" style="text-align: center;"></td>
						<td id="tranorde_nick8" style="text-align: center;"></td>
						<td id="tranorde_addr8" style="text-align: left;"></td>
						<td id="tranorde_product8" style="text-align: left;"></td>
						<td id="tranorde_mount8" style="text-align: right;"></td>
						<td id="tranorde_vccecount8" style="text-align: right;"></td>
						<td id="tranorde_empdock8" style="text-align: left;"></td>
						<td id="tranorde_port28" style="text-align: left;"></td>
					</tr>
					<tr id="tranorde_tr9">
						<td style="text-align: center;">
						<input id="tranorde_chk9" class="tranorde_chk" type="checkbox">
						</input></td>
						<td style="text-align: center; font-weight: bolder; color:black;">10</td>
						<td id="tranorde_noa9" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>
						<td id="tranorde_ctype9" style="text-align: center;"></td>
						<td id="tranorde_strdate9" style="text-align: center;"></td>
						<td id="tranorde_nick9" style="text-align: center;"></td>
						<td id="tranorde_addr9" style="text-align: left;"></td>
						<td id="tranorde_product9" style="text-align: left;"></td>
						<td id="tranorde_mount9" style="text-align: right;"></td>
						<td id="tranorde_vccecount9" style="text-align: right;"></td>
						<td id="tranorde_empdock9" style="text-align: left;"></td>
						<td id="tranorde_port29" style="text-align: left;"></td>
					</tr>
				</table>
			</div>
			<div id="tranorde_control" style="width:950px;">
				<input id="btnTranorde_refresh"  type="button" style="float:left;width:100px;" value="訂單刷新"/>
				<input id="btnTranorde_previous"  type="button" style="float:left;width:100px;" value="上一頁"/>
				<input id="btnTranorde_next"  type="button" style="float:left;width:100px;" value="下一頁"/>
				<input id="textCurPage"  type="text" style="float:left;width:100px;text-align: right;"/>
				<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>
				<input id="textTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>
				<select id="combCtype" style="float:left;width:100px;"> </select>
				<select id="combDtype" style="float:left;width:100px;"> </select>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height: 1px;">
						<td></td>
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
						<td><span> </span><a id='lblCust' class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtCustno"  type="text"  style="float:left; width:30%;"/>
						<input id="txtComp"  type="text"  style="float:left; width:70%;"/>
						<input id="txtNick"  type="text"  style="display:none;"/>
						</td>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtAddrno"  type="text"  style="float:left; width:50%;"/>
						<input id="txtAddr"  type="text"  style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
						<td>
						<input id="txtOrdeno"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td>
						<input id="txtCarno"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblDriver' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtDriverno"  type="text"  style="float:left; width:40%;"/>
						<input id="txtDriver"  type="text"  style="float:left; width:40%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td>
						<input id="txtWeight"  type="text"  class="txt c1 num"/>
						</td>
						<td><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td>
						<input id="txtMount"  type="text"  class="txt c1 num"/>
						</td>
						<td><span> </span><a id='lblCaseno' class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtCaseno"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="6">
						<input id="txtMemo"  type="text"  class="txt c1"/>
						</td>
						<td><select id="combMemo" style="width:20px;"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTrandate' class="lbl"> </a></td>
						<td><input id="txtTrandate"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblTrantime' class="lbl"> </a></td>
						<td><input id="txtTrantime"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMsg' class="lbl"> </a></td>
						<td colspan="6">
							<input id="txtMsg"  type="text"  class="txt c1"/>
						</td>
						<td><input id="chkSendcommandresult"  type="checkbox"><a title="有勾才會發送" style="color:red;">訊息發送</a></input></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td>
						<input id="txtWorker2"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
						<input id="txtNoa"  type="text"  class="txt c1"/>
						</td>
						<td><input id="txtCommandid"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>

		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
