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
            var q_name = "accashf";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = ['txtMoney2'];
            var bbmNum = [];
            var bbsNum = [['txtMoney1',10,0,1],['txtMoney2',10,0,1]];
            var bbtNum = [['txtMoney1',10,0,1],['txtMoney2',10,0,1]];
            var bbmMask = [['txtAccy','999'],['txtDatea','999/99/99']];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'accy';
            q_desc = 1;
            brwCount2 = 4;
            aPop = new Array(['txtAcc1__', '', 'acc', 'acc1,acc2', 'txtAcc1__,txtGtitle__', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            
            t_curMoney = 0;
            t_curMon='';
            t_curDriverno='';
            t_money2=0;
            
            //gindex: 00(只有文字顯示),01(資料明細),02(小計),97、98、99固定
            //gno  對應XLS
            var list = new Array(); 
            list.push({gindex:"00",groupno:"A",gtitle:"營業活動之現金流量：",gno:"1"});
            list.push({gindex:"01",groupno:"A",gtitle:"本期淨利",gno:"3"});
            list.push({gindex:"00",groupno:"A",gtitle:"調整項目：",gno:"2"});
            list.push({gindex:"01",groupno:"A",gtitle:"折舊費用",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"出售設備損失",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"應收帳款",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"應收利息",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"存貨",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"預付費用",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"應付帳款",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"應付薪資",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"應付費用",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"應付利息",gno:"3"});
            list.push({gindex:"01",groupno:"A",gtitle:"應付所得稅",gno:"3"});
            list.push({gindex:"02",groupno:"A",gtitle:"營業活動之淨現金流入",gno:"4"});
            
            list.push({gindex:"00",groupno:"B",gtitle:"投資活動之現金流量：",gno:"1"});
            list.push({gindex:"01",groupno:"B",gtitle:"出售設備",gno:"3"});
            list.push({gindex:"02",groupno:"B",gtitle:"投資活動之淨現金流入",gno:"4"});
            
            list.push({gindex:"00",groupno:"C",gtitle:"融資活動之現金流量：",gno:"1"});
            list.push({gindex:"01",groupno:"C",gtitle:"發行公司債",gno:"3"});
            list.push({gindex:"01",groupno:"C",gtitle:"購買庫藏股",gno:"3"});
            list.push({gindex:"02",groupno:"C",gtitle:"融資活動之淨現金流入",gno:"4"});
            
            list.push({gindex:"97",groupno:"",gtitle:"本期現金增加數",gno:"5"});
            list.push({gindex:"98",groupno:"",gtitle:"期初現金餘額",gno:"6"});
            list.push({gindex:"99",groupno:"",gtitle:"期末現金餘額",gno:"7"});
            
            var list2 = new Array();
            list2.push({gindex:"00",groupno:"A",gtitle:"營業活動之現金流量：",gno:"1"});
            list2.push({gindex:"02",groupno:"A",gtitle:"營業活動之淨現金流入",gno:"4"});
            
            list2.push({gindex:"00",groupno:"B",gtitle:"投資活動之現金流量：",gno:"1"});
            list2.push({gindex:"02",groupno:"B",gtitle:"投資活動之淨現金流入",gno:"4"});
            
            list2.push({gindex:"00",groupno:"C",gtitle:"融資活動之現金流量：",gno:"1"});
            list2.push({gindex:"02",groupno:"C",gtitle:"融資活動之淨現金流入",gno:"4"});
            
            list2.push({gindex:"97",groupno:"",gtitle:"本期現金增加數",gno:"5"});
            list2.push({gindex:"98",groupno:"",gtitle:"期初現金餘額",gno:"6"});
            list2.push({gindex:"99",groupno:"",gtitle:"期末現金餘額",gno:"7"});
            
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_getFormat();
                q_mask(bbmMask);
                //q_cmbParse("cmbDc",q_getMsg('dc').split('&').join(),'t');
            }
			function loadAccc(){
            	var t_acc1 = new Array();
            	var t_acc1x = new Array();//需包含子科目的
            	var t_where = "";
            	for (var i = 0; i < q_bbtCount; i++) {
            		if($('#txtGindex__'+i).val()=='01' && $.trim($('#txtAcc1__'+i).val()).length>0){
            			t_acc1.push($.trim($('#txtAcc1__'+i).val()));
            			if($.trim($('#txtAcc1__'+i).val()).length==5)
            				t_acc1x.push($.trim($('#txtAcc1__'+i).val()));
            		}
            	}
            	for(var i=0;i<t_acc1x.length;i++){
            		for(var j=0;j<t_acc1.length;j++){
            			if(t_acc1[j].length>5 && t_acc1[j].substring(0,5)==t_acc1x[i]){
            				t_acc1x.splice(i,1);
            				i--;
            				break;
            			}
            		}
            	}
            	for(var i=0;i<t_acc1.length;i++){
            		if(t_acc1x.indexOf(t_acc1[i])>=0){
            			//包含子科目
            			t_where += (t_where.length>0?"or":"") + " left(accc5,5)='"+t_acc1[i]+"'";
            		}else{
            			t_where += (t_where.length>0?"or":"") + " accc5='"+t_acc1[i]+"'";
            		}
            	}
            	if(t_where.length>0)
            		t_where = "where=^^"+t_where+"^^";
            	q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOkbbs2_"+t_sel, r_accy);
			}
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'acccs':
                	
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
            	Lock();
            	for (var i = 0; i < q_bbsCount; i++) {
            		$('#txtSel_'+i).val(i);
            	}
            	sum();
            	if(q_cur ==1){
	            	$('#txtWorker').val(r_name);
	            }else if(q_cur ==2){
	            	$('#txtWorker2').val(r_name);
	            }else{
	            	alert("error: btnok!")
	            }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('accashf_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtGtitle_'+i).change(function(e){
                    		sum();	
                    	});
                    	$('#txtMoney1_'+i).change(function(e){
                    		sum();	
                    	});
                		$('#btnPlusX_'+i).click(function(){
                			if(q_cur!=1 && q_cur!=2)
                				return;
                			var n = parseInt($(this).attr('id').replace('btnPlusX_',''));         			
                			var t_qindex = $('#txtQindex_'+i).val();
                			var m = -1;//計算最後一筆表身資料在哪
                			for(var i = q_bbsCount;i>=0;i--){
                				if($.trim($('#txtGtitle_'+i).val()).length==0 && q_float('txtMoney1_'+i)==0 && q_float('txtMoney2_'+i)==0){
                					
                				}else{
                					m = i;
                					break;
                				}
                			}
                			if(m+1==q_bbsCount){
                				$('#btnPlus').click();
                			}
                			for(var i=m+1;i>n+1;i--){
                				$('#txtGno_'+i).val($('#txtGno_'+(i-1)).val());
                				$('#txtGindex_'+i).val($('#txtGindex_'+(i-1)).val());
                				$('#txtGroupno_'+i).val($('#txtGroupno_'+(i-1)).val());
                				$('#txtGtitle_'+i).val($('#txtGtitle_'+(i-1)).val());
                				$('#txtMoney1_'+i).val($('#txtMoney1_'+(i-1)).val());
                				$('#txtMoney2_'+i).val($('#txtMoney2_'+(i-1)).val());
                			}
                			$('#txtGno_'+(n+1)).val('3');
                			$('#txtGindex_'+(n+1)).val('01');
                			$('#txtGroupno_'+(n+1)).val($('#txtGroupno_'+n).val());
            				$('#txtGtitle_'+(n+1)).val('');
            				$('#txtMoney1_'+(n+1)).val('');
            				$('#txtMoney2_'+(n+1)).val('');
            				refreshBbs();
                		});
                		
                    }
                }
                _bbsAssign();
            }
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtAcc1__'+i).change(function(e){
                    		var patt = /^(\d{4})([^\.,.]*)$/g;
		                    $(this).val($(this).val().replace(patt,"$1.$2"));
                    	});
                    	$('#txtGtitle__'+i).change(function(e){
                    		sum();	
                    	});
                    	$('#txtMoney1__'+i).change(function(e){
                    		sum();	
                    	});
                		$('#btnPlutX__'+i).click(function(){
                			if(q_cur!=1 && q_cur!=2)
                				return;
                			var n = parseInt($(this).attr('id').replace('btnPlutX__',''));         			
                			var t_qindex = $('#txtQindex__'+i).val();
                			var m = -1;//計算最後一筆表身資料在哪
                			for(var i = q_bbtCount;i>=0;i--){
                				if($.trim($('#txtGtitle__'+i).val()).length==0 && q_float('txtMoney1__'+i)==0 && q_float('txtMoney2__'+i)==0){
                					
                				}else{
                					m = i;
                					break;
                				}
                			}
                			if(m+1==q_bbtCount){
                				$('#btnPlut').click();
                			}
                			for(var i=m+1;i>n+1;i--){
                				$('#txtGno__'+i).val($('#txtGno__'+(i-1)).val());
                				$('#txtGindex__'+i).val($('#txtGindex__'+(i-1)).val());
                				$('#txtAcc1__'+i).val($('#txtAcc1__'+(i-1)).val());
                				$('#txtGroupno__'+i).val($('#txtGroupno__'+(i-1)).val());
                				$('#txtGtitle__'+i).val($('#txtGtitle__'+(i-1)).val());
                				$('#cmbDc__'+i).val($('#cmbDc__'+(i-1)).val());
                				$('#txtMoney1__'+i).val($('#txtMoney1__'+(i-1)).val());
                				$('#txtMoney2__'+i).val($('#txtMoney2__'+(i-1)).val());
                			}
                			$('#txtGno__'+(n+1)).val('3');
                			$('#txtGindex__'+(n+1)).val('01');
                			$('#txtAcc1__'+(n+1)).val('');
                			$('#txtGroupno__'+(n+1)).val($('#txtGroupno__'+n).val());
            				$('#txtGtitle__'+(n+1)).val('');
            				$('#cmbDc__'+(n+1)).val('');
            				$('#txtMoney1__'+(n+1)).val('');
            				$('#txtMoney2__'+(n+1)).val('');
            				refreshBbt();
                		});
                		
                    }
                }
                _bbtAssign();
            }
            function refreshBbs(){
            	//gindex: 00(只有文字顯示),01(資料明細),02(小計),97、98、99固定
            	for (var i = 0; i < q_bbsCount; i++) {
            		if(q_cur==1 || q_cur==2)
            			$('#btnPlusX_'+i).removeAttr('disabled');
            		else
            			$('#btnPlusX_'+i).attr('disabled','disabled');
            		$('#btnPlusX_'+i).css("display","none");
            		$('#txtGtitle_'+i).css("display","").attr("readonly","readonly").css("color","green").css("background","rgb(237, 237, 238)");
        			$('#txtMoney1_'+i).css("display","none").attr("readonly","readonly").css("color","green").css("background","rgb(237, 237, 238)");
            		$('#txtMoney2_'+i).css("display","none").attr("readonly","readonly").css("color","green").css("background","rgb(237, 237, 238)");
            		switch($('#txtGindex_'+i).val()){
            			case '00':
            				$('#btnPlusX_'+i).css("display","");
            				break;
            			case '01':
            				$('#btnPlusX_'+i).css("display","");
            				$('#txtGtitle_'+i).removeAttr('readonly').css("color","black").css("background","white");
            				$('#txtMoney1_'+i).css("display","").removeAttr('readonly').css("color","black").css("background","white");
            				break;
            			case '02':
            				$('#txtGtitle_'+i).attr("readonly","readonly").css("color","green").css("color","green").css("background","rgb(237, 237, 238)");
            				$('#txtMoney2_'+i).css("display","");
            				break;
            			case '97':
            				$('#txtMoney2_'+i).css("display","");
            				break;
            			case '98':
            				$('#txtMoney1_'+i).css("display","").removeAttr('readonly').css("color","black").css("background","white");
            				break;
            			case '99':
            				$('#txtMoney2_'+i).css("display","");
            				break;
            			default:
            				$('#txtGtitle_'+i).css("display","none").val('');
            				break;
            		}
            	}
            }
            function refreshBbt(){
            	//gindex: 00(只有文字顯示),01(資料明細),02(小計),97、98、99固定
            	for (var i = 0; i < q_bbtCount; i++) {
            		if(q_cur==1 || q_cur==2)
            			$('#btnPlutX__'+i).removeAttr('disabled');
            		else
            			$('#btnPlutX__'+i).attr('disabled','disabled');
            		$('#btnPlutX__'+i).css("display","none");
            		$('#txtAcc1__'+i).css("display","none");
            		$('#cmbDc__'+i).css("display","none");
            		$('#txtGtitle__'+i).css("display","").attr("readonly","readonly").css("color","green").css("background","rgb(237, 237, 238)");
        			$('#txtMoney1__'+i).css("display","none").attr("readonly","readonly").css("color","green").css("background","rgb(237, 237, 238)");
            		$('#txtMoney2__'+i).css("display","none").attr("readonly","readonly").css("color","green").css("background","rgb(237, 237, 238)");
            		switch($('#txtGindex__'+i).val()){
            			case '00':
            				$('#btnPlutX__'+i).css("display","");
            				break;
            			case '01':
            				$('#btnPlutX__'+i).css("display","");
            				$('#txtAcc1__'+i).css("display","");
            				$('#cmbDc__'+i).css("display","");
            				$('#txtGtitle__'+i).removeAttr('readonly').css("color","black").css("background","white");
            				$('#txtMoney1__'+i).css("display","").removeAttr('readonly').css("color","black").css("background","white");
            				break;
            			case '02':
            				$('#txtGtitle__'+i).attr("readonly","readonly").css("color","green").css("color","green").css("background","rgb(237, 237, 238)");
            				$('#txtMoney2__'+i).css("display","");
            				break;
            			case '97':
            				$('#txtMoney2__'+i).css("display","");
            				break;
            			case '98':
            				$('#txtMoney1__'+i).css("display","").removeAttr('readonly').css("color","black").css("background","white");
            				break;
            			case '99':
            				$('#txtMoney2__'+i).css("display","");
            				break;
            			default:
            				$('#txtGtitle__'+i).css("display","none").val('');
            				break;
            		}
            	}
            }
            
            function sum(){
            	//---------------------------------bbs------------------------------
            	var t_group = new Array();
            	var t_data = new Array();
            	var t_97 = 0;
            	var t_98 = 0;
            	for (var i = 0; i < q_bbsCount; i++) {
            		if($('#txtGindex_'+i).val()=='01' && $.trim($('#txtGtitle_'+i).val()).length>0){
            			n = t_group.indexOf($('#txtGroupno_'+i).val())
            			t_97 += q_float('txtMoney1_'+i);
            			if(n>=0){
            				t_data[n] += q_float('txtMoney1_'+i);
            			}else{
            				t_group.push($('#txtGroupno_'+i).val());
            				t_data.push(q_float('txtMoney1_'+i));
            			}
            		}
            		if($('#txtGindex_'+i).val()=='98'){
            			t_98 = q_float('txtMoney1_'+i);
            		}
            	}
            	//小計
            	for (var i = 0; i < q_bbsCount; i++) {
            		if($('#txtGindex_'+i).val()=='02'){
            			n = t_group.indexOf($('#txtGroupno_'+i).val());
            			if(n>=0)
            				$('#txtMoney2_'+i).val(FormatNumber(t_data[n]));
            		}else if($('#txtGindex_'+i).val()=='97'){
            			$('#txtMoney2_'+i).val(FormatNumber(t_97));
            		}else if($('#txtGindex_'+i).val()=='99'){
            			$('#txtMoney2_'+i).val(FormatNumber(t_97+t_98));
            		}else{
            			$('#txtMoney2_'+i).val('');
            		}
            	}
            	//---------------------------------bbt------------------------------
            	t_group = new Array();
            	t_data = new Array();
            	t_97 = 0;
            	t_98 = 0;
            	for (var i = 0; i < q_bbtCount; i++) {
            		if($('#txtGindex__'+i).val()=='01' && $.trim($('#txtGtitle__'+i).val()).length>0){
            			n = t_group.indexOf($('#txtGroupno__'+i).val())
            			t_97 += q_float('txtMoney1__'+i);
            			if(n>=0){
            				t_data[n] += q_float('txtMoney1__'+i);
            			}else{
            				t_group.push($('#txtGroupno__'+i).val());
            				t_data.push(q_float('txtMoney1__'+i));
            			}
            		}
            		if($('#txtGindex__'+i).val()=='98'){
            			t_98 = q_float('txtMoney1__'+i);
            		}
            	}
            	//小計
            	for (var i = 0; i < q_bbtCount; i++) {
            		if($('#txtGindex__'+i).val()=='02'){
            			n = t_group.indexOf($('#txtGroupno__'+i).val());
            			if(n>=0)
            				$('#txtMoney2__'+i).val(FormatNumber(t_data[n]));
            		}else if($('#txtGindex__'+i).val()=='97'){
            			$('#txtMoney2_'+i).val(FormatNumber(t_97));
            		}else if($('#txtGindex__'+i).val()=='99'){
            			$('#txtMoney2__'+i).val(FormatNumber(t_97+t_98));
            		}else{
            			$('#txtMoney2__'+i).val('');
            		}
            	}
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
            function q_popPost(id) {
				switch(id) {
					default:
						break;
				}
			}
            function btnIns() {
                _btnIns();
                while(q_bbsCount<list.length)
                	$('#btnPlus').click();
                for(var i=0;i<list.length;i++){
                	$('#txtGno_'+i).val(list[i].gno);
                	$('#txtGindex_'+i).val(list[i].gindex);
                	$('#txtGroupno_'+i).val(list[i].groupno);
                	$('#txtGtitle_'+i).val(list[i].gtitle);
                }
                refreshBbs();
                while(q_bbtCount<list2.length)
                	$('#btnPlut').click();
                for(var i=0;i<list2.length;i++){
                	$('#txtGno__'+i).val(list2[i].gno);
                	$('#txtGindex__'+i).val(list2[i].gindex);
                	$('#txtGroupno__'+i).val(list2[i].groupno);
                	$('#txtGtitle__'+i).val(list2[i].gtitle);
                }
                refreshBbt();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                refreshBbs();
                refreshBbt();
                sum();
            }

            function btnPrint() {
                q_box("z_accashf.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy, 'accashf', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['gtitle']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function bbtSave(as) {
                if (!as['gtitle']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbs();
                refreshBbt();
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
                float: left;
                width: 150px;
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
                width: 650px;
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
            	float:left;
                width: 550px;
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
            #dbbt {
            	float:left;
                width: 850px;
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewAccy'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='accy' style="text-align: center;">~accy</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccy" class="lbl"> </a></td>
						<td><input id="txtAccy" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;display: none;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:200px;"><a id='lblGtitle_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMoney1_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMoney2_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;display: none;" />
					<input class="btn"  id="btnPlusX.*" type="button" value='+' style="font-weight: bold;"  />
					<input id="txtNoq.*" type="text" style="display: none;" />
					<input id="txtSel.*" type="text" style="display: none;" />
					<input id="txtGno.*" type="text" style="display: none;" />
					<input id="txtGindex.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input type="text" id="txtGroupno.*" style="display: none;" />
						<input type="text" id="txtGtitle.*" style="width:95%;" />
					</td>
					<td><input type="text" id="txtMoney1.*" style="width:95%; text-align: right;" /></td>
					<td><input type="text" id="txtMoney2.*" style="width:95%; text-align: right;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td align="center" style="width:30px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;display: none;" value="＋"/>
						<input id="buttonLoad" onclick="loadAccc()" value="匯入" type="button" style="font-size: medium; font-weight: bold;"/>
						</td>
						<td style="width:20px;"></td>
						
						<td style="width:120px; text-align: center;">會計科目</td>
						<td style="width:200px; text-align: center;">項目</td>
						<td style="width:80px; text-align: center;">借貸設定</td>
						<td style="width:80px; text-align: center;">含子科目</td>
						<td style="width:150px; text-align: center;">金額</td>
						<td style="width:150px; text-align: center;">小計</td>
					</tr>
					<tr>
						<td align="center">
						<input class="btn"  id="btnMinut..*" type="button" value='-' style=" font-weight: bold;display: none;" />
						<input class="btn"  id="btnPlutX..*" type="button" value='+' style="font-weight: bold;"  />
						<input id="txtNoq..*" type="text" style="display: none;" />
						<input id="txtSel..*" type="text" style="display: none;" />
						<input id="txtGno..*" type="text" style="display: none;" />
						<input id="txtGindex..*" type="text" style="display: none;" />
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtAcc1..*" type="text" style="width:95%;"/></td>
						<td><input id="txtGtitle..*"  type="text" style="width:95%;"/></td>
						<td><select id="cmbDc..*" style="width:95%;"> </select></td>
						<td align="center"><input id="chkIsall..*" type="checkbox"/></td>
						<td><input id="txtMoney1..*" type="text" style="width:95%;"/></td>
						<td><input id="txtMoney2..*" type="text" style="width:95%;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
