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
            var q_name = "borrc";
            var q_readonly = ['txtCheckno','txtNoa','txtMoney','txtTotal','txtPaybno','txtAccno','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney',10,0,1],['txtInterest',10,0,1],['txtTotal',10,0,1]];
            var bbsNum = [['txtMoney',10,0,1]];
            var bbtNum = [['txtMoney',10,0,1]];
            var bbmMask = [['txtDatea', '999/99/99']];
            var bbsMask = [['txtIndate', '999/99/99']];
            var bbtMask = [];
            
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
			q_desc = 1;
            //q_xchg = 1;
            brwCount2 = 5;
            
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'] 
            , ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtAcc3', 'lblAcc3', 'acc', 'acc1,acc2', 'txtAcc3,txtAcc4', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
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
                
                $('#txtInterest').change(function(){
                	$(this).val(FormatNumber($(this).val()));
                	sum();
                });
                $('#txtPaymoney1').change(function(){
                	$(this).val(FormatNumber($(this).val()));
                	sum();
                });
                $('#txtPaymoney2').change(function(){
                	$(this).val(FormatNumber($(this).val()));
                	sum();
                });
                $('#lblPaybno').click(function() {
                	if($('#txtPaybno').val().length>0){
                		t_where = "noa='" + $('#txtPaybno').val() + "'";
            		q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pay', "95%", "95%", q_getMsg('popPaytran'));
                	}
             	});
                $('#lblAccno').click(function() {
                	if($('#txtAccno').val().length>0){
                		q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                	}
                });
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
                switch (id) {//b_seq
                    default:
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,9)=='gqb_btnOk'){
                    		var t_sel = parseFloat(t_name.split('_')[2]);                    		
                    		var as = _q_appendData("gqb", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+as[0]['gqbno']+'】已存在');
                    			Unlock();
                    			return;
                    		}else{
                    			checkGqb(t_sel-1);
                    		}
                    	}else if(t_name.substring(0,13)=='gqb_bbsAssign'){
                    		var t_sel = parseFloat(t_name.split('_')[2]);                    		
                    		var as = _q_appendData("gqb", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+as[0]['gqbno']+'】已存在');
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
                Lock();
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!")
                }
                sum();
                if(q_float('txtTotal')-q_float('txtPaymoney1')-q_float('txtPaymoney2')!=0){
                	alert('應付金額，付款金額不相等。')
                	Unlock();
                	return;
                }        
                checkGqb(q_bbsCount-1);			
            }
            function checkGqb(n){
            	if(n<0){
            		var t_checkno ='';
            		for(var i=0;i<q_bbsCount;i++){
            			t_checkno += (t_checkno.length>0?',':'') + $('#txtCheckno_'+i).val();
            		}
            		$('#txtCheckno').val(t_checkno);
            		var t_noa = trim($('#txtNoa').val());
	                var t_date = trim($('#txtDatea').val());
	                if (t_noa.length == 0 || t_noa == "AUTO")
	                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_borrc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
	                else
	                    wrServer(t_noa);
	                Unlock();
            	}else{
            		if(q_cur==1 && $('#txtCheckno_'+n).val().length > 0 ){//新增時才需檢查
            			var t_where = "where=^^ gqbno = '" + $('#txtCheckno_'+n).val() + "' ^^";
	    				q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOk_"+n, r_accy);
            		}else{
            			checkGqb(n-1);
            		}
            	}
            }
            
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('borrc_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();           
                sum();
                $('#txtDatea').focus();
            }
            function btnPrint() {
            	q_box('z_borrc.aspx'+ "?;;;;"+r_accy+";noa="+trim($('#txtNoa').val()), '', "95%", "95%", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_'+i).text(i+1);	
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtIndate_'+i).datepicker();
                		$('#txtMoney_'+i).change(function(){
                			$(this).val(FormatNumber($(this).val()));
                			sum();
                		});
                		$('#txtCheckno_'+i).change(function(){
                			if(q_cur==1){//新增時才需檢查
                				var n = $(this).attr('id').replace('txtCheckno_','');
	                			var t_where = "where=^^ gqbno = '" + $('#txtCheckno_'+n).val() + "' ^^";
	                			q_gt('gqb', t_where, 0, 0, 0, "gqb_bbsAssign_"+n, r_accy);
                			}
                		});
                    }
                }
                _bbsAssign();
            }
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	 $('#txtAcc1_'+i).change(function(e) {
		                    var patt = /(\d{4})([^\.,.]*)$/g;
		                    $(this).val($(this).val().replace(patt,"$1.$2"));
		        		});
                    }
                }
                _bbtAssign();
            }

            function bbsSave(as) {
                if (!as['checkno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
					return;	
				var t_money = 0,t_interest=0;
				for(var i = 0; i < q_bbsCount; i++) {
                	t_money += q_float('txtMoney_'+i);
                }
                t_interest = q_float('txtInterest');
                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtTotal').val(FormatNumber(t_money-t_interest));
            }
            function refresh(recno) {
                _refresh(recno);
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
            function Lock() {
                if ($('#divLock').length == 0)
                    $('body').append('<div id="divLock"> </div>');
                $('#divLock').css('width', Math.max(document.body.clientWidth, document.body.scrollWidth)).css('height', Math.max(document.body.clientHeight, document.body.scrollHeight));
                $('#divLock').css('background', 'black').css('opacity', 0.2);
                $('#divLock').css('display', '').css('z-index', '999').css('position', 'absolute').css('top', 0).css('left', 0).focus();
            	addResizeEvent(function(){
            		if($('#divLock').css('display')!='none')
            			return;
            		$('#divLock').css('width', Math.max(document.body.clientWidth, document.body.scrollWidth)).css('height', Math.max(document.body.clientHeight, document.body.scrollHeight));
            	});
            }
			function Unlock() {
				$('#divLock').css('display', 'none');
			}		
            function addResizeEvent(func) {
                var oldonresize = window.onresize;
                if ( typeof window.onresize != 'function') {
                    window.onresize = func;
                } else {
                    window.onresize = function() {
                        if (oldonresize) {
                            oldonresize();
                        }
                        func();
                    }
                }
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
                width: 950px;
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
                width: 750px;
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
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNick'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewInterest'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewTotal'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='money,1' style="text-align: right;">~money,1</td>
						<td id='interest,1' style="text-align: right;">~interest,1</td>
						<td id='total,1' style="text-align: right;">~total,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height: 1px;">
						<td><input type="text" id="txtCheckno" style="display:none;"></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust"t class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtCustno"  type="text"  style="float:left; width:30%;"/>
						<input id="txtComp"  type="text"  style="float:left; width:70%;"/>
						<input id="txtNick"  type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney"  type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblInterest" class="lbl"> </a></td>
						<td><input id="txtInterest"  type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcc1" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtAcc1"  type="text"  class="txt" style="width:40%;"/>
							<input id="txtAcc2"  type="text"  class="txt" style="width:60%;"/>
						</td>
						<td><span> </span><a id="lblPaymoney1" class="lbl"> </a></td>
						<td><input id="txtPaymoney1" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcc3" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtAcc3"  type="text"  class="txt" style="width:40%;"/>
							<input id="txtAcc4"  type="text"  class="txt" style="width:60%;"/>
						</td>
						<td><span> </span><a id="lblPaymoney2" class="lbl"> </a></td>
						<td><input id="txtPaymoney2" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPaybno" class="lbl btn"> </a></td>
						<td><input id="txtPaybno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
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
					<td align="center" style="width:150px;"><a id='lblCheckno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblIndate_s'> </a></td>
					<td align="center" style="width:205px;"><a id='lblBank_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblAccount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtCheckno.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtIndate.*" type="text" style="width: 95%;"/></td>
					<td>
						<input id="btnBank.*" type="button" style="float:left;width:15px;"/>
						<input id="txtBankno.*"type="text" style="float:left;width: 80px;"/>	
						<input id="txtBank.*" type="text" style="float:left;width:100px;"/>		
					</td>
					<td><input id="txtAccount.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMoney.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtMemo.*" type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:200px; text-align: center;">lblAcc1_t</td>
						<td style="width:100px; text-align: center;">lblMoney_t</td>
						<td style="width:350px; text-align: center;">lblMemo_t</td>				
					</tr>
					<tr>
						<td>
						<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold; width:90%;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
	                        <input type="text" id="txtAcc1.*"  style="width:85%; float:left;"/>
	                        <span style="display:block; width:1%;float:left;"> </span>
							<input type="text" id="txtAcc2.*"  style="width:85%; float:left;"/>
						</td>
						<td><input id="txtMoney..*"  type="text" style="width:95%; text-align: right;"/></td>
						<td><input id="txtMemo..*"  type="text" style="width:95%; text-align: left;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
