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
			// transvcce.noa  tranorde.noa  編號不能有底線，否則gtPost須改寫
			//登錄日期: 實際派車日期,  出車日期，時間只是純粹傳給司機看的而已
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "transvcce";
            var q_readonly = ['txtNoa','txtMount','txtWorker','txtWorker2','txtOrdeno'];
            var q_readonlys = ['txtCommandid'];
            var bbmNum = [['txtMount',10,1,1]];
            var bbsNum = [['txtMount',10,1,1],['txtSel',10,0,1]];
            var bbmMask = [['txtDatea', '999/99/99'],['txtTrandate', '999/99/99'],['txtTrantime', '99:99']];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
			q_desc = 1;
            q_xchg = 1;
            brwCount2 = 10;
            
            aPop = new Array(['txtCarno_', '', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']
            , ['txtDriverno_', 'btnDriverno_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']
            , ['txtAddrno', 'lblAddr', 'addr', 'noa,addr', 'txtAddrno,txtAddr', 'addr_b.aspx']
            , ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'] 
            );
			//---------------------------------------------------------------------
			function tranorde() {
            }
            tranorde.prototype = {
                data : null,
                tbCount : 10,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                lock : function(){
                	for(var i=0;i<this.tbCount;i++){
                		if($('#tranorde_chk' + i).attr('disabled')!='disabled'){
                			$('#tranorde_chk' + i).addClass('lock').attr('disabled', 'disabled');
                		}
                	}
                },
                unlock : function(){
                	for(var i=0;i<this.tbCount;i++){
                		if($('#tranorde_chk' + i).hasClass('lock')){
                			$('#tranorde_chk' + i).removeClass('lock').removeAttr('disabled');
                		}
                	}
                },
                load : function(){
                	var string = '<table id="tranorde_table">';
                	string+='<tr id="tranorde_header">';
                	string+='<td id="tranorde_chk" align="center" style="width:20px; color:black;"></td>';
                	string+='<td id="tranorde_sel" align="center" style="width:20px; color:black;"></td>';
                	string+='<td id="tranorde_noa" onclick="tranorde.sort(\'noa\',false)" title="訂單編號" align="center" style="width:120px; color:black;">訂單編號</td>';
                	string+='<td id="tranorde_ctype" onclick="tranorde.sort(\'ctype\',false)" title="類型" align="center" style="width:50px; color:black;">類型</td>';
                	string+='<td id="tranorde_strdate" onclick="tranorde.sort(\'strdate\',false)" title="開工日期" align="center" style="width:100px; color:black;">開工日</td>';
                	string+='<td id="tranorde_nick" onclick="tranorde.sort(\'custno\',false)" title="客戶" align="center" style="width:100px; color:black;">客戶</td>'
                	string+='<td id="tranorde_addr" onclick="tranorde.sort(\'addrno\',false)" title="起迄地點" align="center" style="width:200px; color:black;">起迄地點</td>'
                	string+='<td id="tranorde_product" onclick="tranorde.sort(\'productno\',false)" title="品名" align="center" style="width:100px; color:black;">品名</td>'
                	string+='<td id="tranorde_mount" onclick="tranorde.sort(\'mount\',true)" align="center" style="width:80px; color:black;">收數量</td>';
                	string+='<td id="tranorde_vccecount" onclick="tranorde.sort(\'vccecount\',true)" align="center" style="width:80px; color:black;">已派數量</td>';
                	string+='<td id="tranorde_empdock" onclick="tranorde.sort(\'empdock\',false)" title="領,S/O" align="center" style="width:120px; color:black;">出口櫃</td>';
                	string+='<td id="tranorde_port2" onclick="tranorde.sort(\'port2\',false)" title="領櫃碼頭,自檢/追蹤" align="center" style="width:120px; color:black;">進口櫃</td>';
                	string+='</tr>';
                	
					for(var i=0;i<this.tbCount;i++){
						string+='<tr id="tranorde_tr'+i+'">';
						string+='<td style="text-align: center;">';
						string+='<input id="tranorde_chk'+i+'" class="tranorde_chk" type="checkbox"/></td>';
						string+='<td style="text-align: center; font-weight: bolder; color:black;">'+(i+1)+'</td>';
						string+='<td id="tranorde_noa'+i+'" onclick="tranorde.browNoa(this)" style="text-align: center;"></td>';
						string+='<td id="tranorde_ctype'+i+'" style="text-align: center;"></td>';
						string+='<td id="tranorde_strdate'+i+'" style="text-align: center;"></td>';
						string+='<td id="tranorde_nick'+i+'" style="text-align: center;"></td>';
						string+='<td id="tranorde_addr'+i+'" style="text-align: left;"></td>';
						string+='<td id="tranorde_product'+i+'" style="text-align: left;"></td>';
						string+='<td id="tranorde_mount'+i+'" style="text-align: right;"></td>';
						string+='<td id="tranorde_vccecount'+i+'" style="text-align: right;"></td>';
						string+='<td id="tranorde_empdock'+i+'" style="text-align: left;"></td>';
						string+='<td id="tranorde_port2'+i+'" style="text-align: left;"></td>';
						string+='</tr>';
					}
                	string+='</table>';
                	
                	$('#tranorde').append(string);
                	              
                	string='<input id="btnTranorde_refresh"  type="button" style="float:left;width:100px;" value="訂單刷新"/>';
                	string+='<input id="btnTranorde_previous" onclick="tranorde.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                	string+='<input id="btnTranorde_next" onclick="tranorde.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                	string+='<input id="textCurPage" onchange="tranorde.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
                	string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                	string+='<input id="textTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                	string+='<select id="combCtype" style="float:left;width:100px;"> </select>';
                	string+='<select id="combDtype" style="float:left;width:100px;"> </select>';
                	$('#tranorde_control').append(string);
                },
                init : function(obj) {
                    $('.tranorde_chk').click(function(e) {
                        $(".tranorde_chk").not(this).prop('checked', false);
                        $(".tranorde_chk").not(this).parent().parent().find('td').css('background', 'pink');
                        $(this).prop('checked', true);
                        $(this).parent().parent().find('td').css('background', '#FF8800');
                    });
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                        if (obj[i]['noa'] != undefined)
                            this.data.push(obj[i]);
                    }
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
                sort : function(index, isFloat) {
                	//訂單排序
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
                	//頁面更新
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
                            //只顯示到小數位第一位
                            if(this.data[n+i]['mount'].indexOf('.')<0) 
                            	$('#tranorde_mount' + i).html(this.data[n+i]['mount']+'.0');
                            else             
                            	$('#tranorde_mount' + i).html(this.data[n+i]['mount'].replace(/(\d*)\.(\d)(\d)*$/g,'$1.$2'));
                            if(this.data[n+i]['vccecount'].indexOf('.')<0)  	
                            	$('#tranorde_vccecount' + i).html(this.data[n+i]['vccecount']+'.0');
                            else
                            	$('#tranorde_vccecount' + i).html(this.data[n+i]['vccecount'].replace(/(\d*)\.(\d)(\d)*$/g,'$1.$2'));
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
                	//瀏覽訂單
                	var noa = $.trim($(obj).html());
                	if(noa.length>0)
                		q_box("tranorde.aspx?;;;noa='" + noa + "';"+r_accy, 'tranorde', "95%", "95%", q_getMsg("popTranorde"));
                },
                paste : function() {
                	//複製資料
                    if (this.totPage <= 0)
                        return;
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ($('#tranorde_chk' + i).prop('checked')) {
                            $('#txtOrdeno').val(this.data[n+i]['noa']);
                            $('#txtCustno').val(this.data[n+i]['custno']);
                            $('#txtComp').val(this.data[n+i]['comp']);
                            $('#txtNick').val(this.data[n+i]['nick']);
                            $('#txtAddrno').val(this.data[n+i]['addrno']);
                            $('#txtAddr').val(this.data[n+i]['addr']);
                            $('#txtMemo').val(this.data[n+i]['memo']);   
                        }
                    }
                },
                paste2 : function(ordeno,sel) {
                	//複製資料
                	if(ordeno.length == 0)
                		return;
                	var t_where = "where=^^ noa='"+ordeno+"'^^"
                	q_gt('view_tranorde', t_where, 0, 0, 0,'ddd_'+ordeno+'_'+sel, r_accy);
                }
            }
            tranorde = new tranorde();
            
			//---------------------------------------------------------------------
            $(document).ready(function() {
            	tranorde.load();
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
					
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
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
						$('#combMemo').val(0);
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
                    Lock();
                    q_gt('view_tranorde', t_where, 0, 0, 0,'aaa', r_accy);
                });    
                //自動載入訂單
                $('#btnTranorde_refresh').click();   
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }
            function q_popPost(id) {
                switch (id) {
                	case 'txtCarno_':
                		tranorde.paste2($('#txtOrdeno').val(),b_seq);
                		break; 
                	case 'txtDriverno_':
                		tranorde.paste2($('#txtOrdeno').val(),b_seq);
                		break; 
                    default:
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'aaa':
                        var as = _q_appendData("view_tranorde", "", true);
                        if (as[0] != undefined)
                            tranorde.init(as);
                        else{
                        	Unlock();
                        	alert('無資料。');
                        }
                        break;
                    case 'LoadCaseno':
                    	var as = _q_appendData("view_tranordes", "", true);
		               	if (as[0] != undefined){
		               		q_gridAddRow(bbsHtm, 'tbbs', 'txtCaseno,txtMsg,txtMemo', as.length, as, 'caseno,memo,memo', '', '');
		               	}
		               	Unlock();
                    	break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,3)=='bbb'){ 
                    		//計算已派數量,並更新頁面顯示資料
                    		var t_noa = t_name.split('_')[1];
                    		var t_ordeno = t_name.split('_')[2];
                    		var t_mount = parseFloat(t_name.split('_')[3]);
                    		var as = _q_appendData("view_tranorde", "", true);
	                        if (as[0] != undefined){
	                        	t_vccecount = (as[0]['vccecount']==undefined?"0":as[0]['vccecount']);
	                        	t_vccecount = (t_vccecount.length==0?"0":t_vccecount);
	                        	t_where=" noa='"+t_noa+"'";
	                        	t_where="where=^^"+t_where+"^^";
                   				q_gt('transvcce', t_where, 0, 0, 0, "ccc_"+t_noa+"_"+t_ordeno+"_"+t_mount+"_"+t_vccecount, r_accy);         	
	                        }else{
	                        	//查無訂單,直接存檔
	                        	SaveData();
	                        }	                    	
                    	}else if(t_name.substring(0,3)=='ccc'){
                    		//回寫已收數量
                    		var t_noa = t_name.split('_')[1];
                    		var t_ordeno = t_name.split('_')[2];
                    		var t_mount = parseFloat(t_name.split('_')[3]);
                    		var t_vccecount = parseFloat(t_name.split('_')[4]);
                    		var t_curVccecount = t_vccecount + t_mount;
                    		var as = _q_appendData("transvcce", "", true);
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
                			SaveData();
                    	}else if(t_name.substring(0,3)=='ddd'){
                    		//複製訂單資料
                    		var t_ordeno = t_name.split('_')[1];
                    		var sel = t_name.split('_')[2];
	                    	var as = _q_appendData("view_tranorde", "", true);
	                    	if (as[0] != undefined){
	                            $('#txtMount_'+sel).val('1.0');
	                            t_msg = as[0]['addr'];
	                            //出口
	                            t_msg += (as[0]['docketno1'].length>0?(t_msg.length>0?', ':'')+'案號'+as[0]['docketno1']:'');
	                            t_msg += (as[0]['empdock'].length>0?(t_msg.length>0?',':'')+as[0]['empdock']+'領':'');
	                        	t_msg += (as[0]['dock'].length>0?(t_msg.length>0?',':'')+'交'+as[0]['dock']:'');
	                        	t_msg += (as[0]['boat'].length>0?(t_msg.length>0?',':'')+'船公司'+as[0]['boat']:'');
	                        	t_msg += (as[0]['boatname'].length>0?(t_msg.length>0?',':'')+'船次'+as[0]['boatname']:'');
	                        	t_msg += (as[0]['do1'].length>0?(t_msg.length>0?',':'')+'領編'+as[0]['do1']:'');
	                        	t_msg += (as[0]['so'].length>0?(t_msg.length>0?',':'')+'SO:'+as[0]['so']:'');
	                        	t_msg += (as[0]['casepackaddr'].length>0?(t_msg.length>0?', ':'')+'裝櫃地點'+as[0]['casepackaddr']:'');
	                        	t_msg += (as[0]['port'].length>0?(t_msg.length>0?',':'')+'港口'+as[0]['port']:'');
	                        	t_msg += (as[0]['casetype'].length>0?(t_msg.length>0?',':'')+'櫃型'+as[0]['casetype']:'');
	                        	//進口
	                        	t_msg += (as[0]['port2'].length>0?(t_msg.length>0?',':'')+as[0]['port2']+'領':'');
	                        	t_msg += (as[0]['empdock2'].length>0?(t_msg.length>0?',':'')+'交'+as[0]['empdock2']:'');
	                        	t_msg += (as[0]['takeno'].length>0?(t_msg.length>0?',':'')+'領編'+as[0]['takeno']:'');
	                        	t_msg += (as[0]['casepresent'].length>0?(t_msg.length>0?',':'')+'代表櫃號'+as[0]['casepresent']:'');
	                        	t_msg += (as[0]['product2'].length>0?(t_msg.length>0?',':'')+'品名:'+as[0]['product2']:'');
	                        	t_msg += (as[0]['containertype'].length>0?(t_msg.length>0?',':'')+'櫃別'+as[0]['containertype']:'');
	                        	t_msg += (as[0]['docketno2'].length>0?(t_msg.length>0?',':'')+'案號'+as[0]['docketno2']:'');
	                        	t_msg += (as[0]['trackno'].length>0?(t_msg.length>0?',':'')+'追蹤'+as[0]['trackno']:'');
	                        	if($.trim($('#txtCaseno_'+sel).val()).length>0){
	                        		t_msg += (t_msg.length>0?',':'')+'指定櫃號'+$.trim($('#txtCaseno_'+sel).val());
	                        	}else{
	                        		t_msg += (as[0]['caseassign'].length>0?(t_msg.length>0?',':'')+'指定櫃號'+as[0]['caseassign']:'');
	                        	}
	                        	t_msg += (as[0]['do2'].length>0?(t_msg.length>0?',':'')+'提單'+as[0]['do2']:'');
	                        	t_msg += (as[0]['checkself'].length>0?(t_msg.length>0?',':'')+'自檢'+as[0]['checkself']:'');
	                        	t_msg += (as[0]['checkinstru'].length>0?(t_msg.length>0?',':'')+'儀檢'+as[0]['checkinstru']:'');
	                        	t_msg += (as[0]['casedo'].length>0?(t_msg.length>0?',':'')+'押運'+as[0]['casedo']:'');
	                        	t_msg += (as[0]['caseopenaddr'].length>0?(t_msg.length>0?',':'')+'拆櫃地點'+as[0]['caseopenaddr']:'');
	                        	t_msg += (as[0]['option01'].length>0?(t_msg.length>0?',':'')+as[0]['option01']+'過磅':'');
	                        	t_msg += (as[0]['option02'].length>0?(t_msg.length>0?',':'')+as[0]['option02']+'加封':'');
	                        	t_msg += (as[0]['casetype2'].length>0?(t_msg.length>0?',':'')+'櫃型'+as[0]['casetype2']:'');
	                        	
	                        	t_memo = $.trim($('#txtMemo_'+sel).val());
	                        	$('#txtMsg_'+sel).val(t_memo+(t_memo.length>0?',':'')+t_msg);
	                        	sum();
	                        }else{
	                        	alert('查無訂單。');
	                        }
                    	}
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
            function btnOk() {
                if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if (!q_cd($('#txtTrandate').val())) {
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
                sum();
                Lock();
                SendCommand(q_bbsCount-1);
            }
            function SaveData(){
            	var t_string = "";
            	for(var i = 0; i < q_bbsCount; i++) {
            		if($.trim($('#txtCarno_'+i).val()).length>0)
            			t_string += (t_string.length>0?',':'')+$.trim($('#txtCarno_'+i).val());
            	}
            	$('#txtCarno').val(t_string);
            	t_string = "";
            	for(var i = 0; i < q_bbsCount; i++) {
            		if($.trim($('#txtMemo2_'+i).val()).length>0)
            			t_string += (t_string.length>0?',':'')+$.trim($('#txtMemo2_'+i).val());
            	}
            	$('#txtMemo2').val(t_string);
            	var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_transvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
                tranorde.unlock();
            }
            
            function SendCommand(n){
            	//訊息一筆一筆發送,送完後再存檔
            	if(n<0){
            		t_noa = $.trim($('#txtNoa').val());
            		t_ordeno = $.trim($('#txtOrdeno').val());
            		t_mount = $.trim($('#txtMount').val()).length ==0 ? '0':$.trim($('#txtMount').val());
            		t_where = "noa='"+t_ordeno+"'"
            		t_where="where=^^"+t_where+"^^";
                    q_gt('view_tranorde', t_where, 0, 0, 0, "bbb_"+t_noa+"_"+t_ordeno+"_"+t_mount, r_accy);
            	}else{        		
            		var t_isSend = $('#chkIssend_'+n).prop('checked');
            		var t_carno = $.trim($('#txtCarno_'+n).val());
					var t_msg = $.trim($('#txtMemo').val())
						+(($('#txtTrandate').val()+$('#txtTrantime').val()).length > 0?',出車時間'+$('#txtTrandate').val()+'-'+$('#txtTrantime').val():'')
						+$.trim($('#txtMsg_'+n).val());
					var t_commandid = $('#txtCommandid_'+n).val();
					var t_Sendcommandresult = $('#chkSendcommandresult_'+n).prop('checked');
					if(t_isSend && t_carno.length>0 && t_msg.length>0 && !t_Sendcommandresult && t_commandid.length==0){
	            		//GPS訊息
	            		var t_data = {
		            		GroupName : encodeURI("CHITC195"),
		            		CarId : encodeURI(t_carno),
		            		Message : encodeURI(t_msg),
		            		StatusCode : 1
		            	};
						var json = JSON.stringify(t_data);
		            	//INPUT及OUTPUT參數,參照SendCommand.aspx
		            	$.ajax({
		            		carno : t_carno,
		            		sel: n,
						    url: 'SendCommand.aspx',
						    type: 'POST',
						    data: json,
						    dataType: 'json',
						    success: function(data){
						    	if(data['SendCommandResult']="true")
						    		$('#chkSendcommandresult_'+this.sel).prop('checked',true);	
								$('#txtCommandid_'+this.sel).val(data['CommandId']);
						    },
					        complete: function(){
					        	SendCommand(this.sel-1); 			         
					        },
						    error: function(jqXHR, exception) {
						    	alert('Error:'+this.carno);
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
            		    SendCommand(n-1);     		
	            	}
            	}
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('transvcce_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
            }
            function btnIns() {
            	tranorde.lock();
                _btnIns();
                tranorde.paste(); 
                        
                $('#txtNoa').val('AUTO');
                $('#txtDatea').focus();
                
                var t_ordeno = $.trim($('#txtOrdeno').val());
                if(t_ordeno.length>0){
                	Lock();
                	var t_where = "where=^^ noa='"+t_ordeno+"' and not exists(select c.* from transvcce"+r_accy+" b left join transvcces102 c on b.noa=c.noa where b.ordeno=a.noa and isnull(c.caseno,'')=a.caseno) ^^";
                	q_gt('view_tranordes', t_where, 0, 0, 0, "LoadCaseno", r_accy);
                }
                
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                tranorde.lock();
                _btnModi();           
                $('#txtDatea').focus();
            }
            function btnPrint() {
            	q_box('z_transvcce.aspx'+ "?;;;;"+r_accy+";noa="+trim($('#txtNoa').val()), '', "95%", "95%", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_'+i).text(i+1);	
                	$('#chkSendcommandresult_'+i).attr('disabled','disabled');
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtMount_'+i).change(function(){
                			sum();
                		});
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
                if (!as['carno'] && parseFloat(as['mount'].length==0?'0':as['mount'])==0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
					return;	
				var t_mount = 0;
				for(var i = 0; i < q_bbsCount; i++) {
                	t_mount += q_float('txtMount_'+i);
                }
                $('#txtMount').val(FormatNumber(t_mount));
            }
            function refresh(recno) {
                _refresh(recno);
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                for(var i = 0; i < q_bbsCount; i++) {
                	$('#chkSendcommandresult_'+i).attr('disabled','disabled');
                }
            }
            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
                tranorde.unlock();
            }      
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                /*float: left;*/
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
                /*float: left;*/
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
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
            .dbbs {
                width: 1200px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
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
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNick'> </a></td>
						<td align="center" style="width:200px; color:black;"><a id='vewAddr'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMount'> </a></td>
						<td align="center" style="width:250px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMemo2'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='addr' style="text-align: center;">~addr</td>
						<td id='mount,1,1' style="text-align: right;">~mount,1,1</td>
						<td id='carno' style="text-align: left;">~carno</td>
						<td id='memo2' style="text-align: left;">~memo2</td>
					</tr>
				</table>
			</div>
			<div id="tranorde" style="float:left;width:1500px;"> </div>	
			<div id="tranorde_control" style="width:950px;"> </div>	
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height: 1px;">
						<td><input type="text" id="txtCarno" style="display:none;"> </td>
						<td><input type="text" id="txtMemo2" style="display:none;"> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust"t class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtCustno"  type="text"  style="float:left; width:30%;"/>
						<input id="txtComp"  type="text"  style="float:left; width:70%;"/>
						<input id="txtNick"  type="text"  style="display:none;"/>
						</td>
						<td><span> </span><a id="lblAddr" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtAddrno"  type="text"  style="float:left; width:50%;"/>
						<input id="txtAddr"  type="text"  style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td><input id="txtOrdeno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" title="實際派車日期" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" title="實際派車日期" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6"><input id="txtMemo" type="text" class="txt c1"/></td>
						<td><select id="combMemo" style="width:20px;"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTrandate" title="發送訊息給司機用" class="lbl"> </a></td>
						<td><input id="txtTrandate"  type="text" title="發送訊息給司機用" class="txt c1"/></td>
						<td><span> </span><a id="lblTrantime" title="發送訊息給司機用" class="lbl"> </a></td>
						<td><input id="txtTrantime" title="發送訊息給司機用" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblMount" title="總數量" class="lbl"> </a></td>
						<td><input id="txtMount" title="總數量" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:70px;"><a id='lblCarno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblDriver_s'> </a></td>
					<td align="center" style="width:60px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblCaseno_s'> </a></td>
					<td align="center" style="width:280px;"><a id='lblMsg_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMemo2_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblIssend_s' title="若要發送訊息給司機，請打勾。"> </a></td>
					<td align="center" style="width:40px;"><a id='lblSendcommandresult_s'> </a></td>
					<td align="center" style="width:70px;"><a id='lblCommandid_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					<input id="txtSel.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtCarno.*" type="text" style="width: 95%;"/></td>
					<td>
						<input id="btnDriverno.*" type="button" style="float:left;width:15px;"/>
						<input id="txtDriverno.*"type="text" style="float:left;width: 80px;"/>	
						<input id="txtDriver.*" type="text" style="float:left;width:100px;"/>		
					</td>
					<td><input id="txtMount.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td>
						<input id="txtCaseno.*" type="text" style="width: 95%;"/>
						<input id="txtMemo.*" type="text" style="display: none;" title="暫存資料用"。/>
					</td>
					<td><input id="txtMsg.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMemo2.*" type="text" style="width: 95%;"/></td>
					<td align="center" ><input id="chkIssend.*" title="若要發送訊息給司機，請打勾。" type="checkbox" /></td>
					<td align="center" ><input id="chkSendcommandresult.*" type="checkbox" /></td>
					<td><input id="txtCommandid.*" type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
