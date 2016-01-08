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
            var q_name = "acost";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtMoney1',10,0,1],['txtMoney2',10,0,1],['txtMoney3',10,0,1]];
            var bbtNum = [];
            var bbmMask = [['txtDeadline','999/99/99'],['txtDatea','999/99/99']];
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
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });        
            
            var list = new Array();
            list.push({indexs:"12",item:"01.期初商品",acc1:"1131"});
            list.push({indexs:"12",item:"02.本期進貨",acc1:"5200~5299"});    
            list.push({indexs:"12",item:"03.期末存貨",acc1:"1131"});
            list.push({indexs:"02",item:"04.加:其他",acc1:""});
            list.push({indexs:"02",item:"05.減:其他",acc1:""});
            list.push({indexs:"03",item:"進銷成本",acc1:""});                          
            list.push({indexs:"11",item:"06.期初存料",acc1:"1137"});
            list.push({indexs:"11",item:"07.本期進料",acc1:"5311,5313,5314"});    
            list.push({indexs:"11",item:"08.期末存料",acc1:"1137"});
            list.push({indexs:"01",item:"09.加:其他",acc1:""});
            list.push({indexs:"01",item:"10.減:其他",acc1:""});
            list.push({indexs:"02",item:"直接原料",acc1:""});
            list.push({indexs:"11",item:"11.期初存料",acc1:"1140"});
            list.push({indexs:"11",item:"12.本期進料",acc1:"6315,6317,6318"});    
            list.push({indexs:"11",item:"13.期末存料",acc1:"1140"});
            list.push({indexs:"01",item:"14.加:其他",acc1:""});
            list.push({indexs:"01",item:"15.減:其他",acc1:""});
            list.push({indexs:"02",item:"間接原料",acc1:""});
            list.push({indexs:"12",item:"16.直接人工",acc1:"5400~5499"});
            list.push({indexs:"12",item:"17.製造費用",acc1:"5500~5599"});
            list.push({indexs:"02",item:"製造成本",acc1:""});
            list.push({indexs:"11",item:"18.期初再製品",acc1:"1136,1139"});
            list.push({indexs:"11",item:"19.期末再製品",acc1:"1136,1139"});    
            list.push({indexs:"01",item:"20.加:其他",acc1:""});
            list.push({indexs:"01",item:"21.減:其他",acc1:""});
            list.push({indexs:"02",item:"製成品成本",acc1:""});
            list.push({indexs:"11",item:"22.期初製成品",acc1:"1133"});
            list.push({indexs:"11",item:"23.期末製成品",acc1:"1133"});    
            list.push({indexs:"01",item:"24.加:其他",acc1:""});
            list.push({indexs:"01",item:"25.減:其他",acc1:""});
            list.push({indexs:"01",item:"26.外銷估列應收退稅或已收退稅款",acc1:""});
            list.push({indexs:"01",item:"27.產銷成本減項",acc1:""});  
            list.push({indexs:"03",item:"產銷成本",acc1:""});
            list.push({indexs:"13",item:"28.勞務成本",acc1:"5700~5799"});
            list.push({indexs:"13",item:"29.修理成本",acc1:"5800~5899"});
            list.push({indexs:"13",item:"30.加工成本",acc1:"5600~5699"});
            list.push({indexs:"13",item:"31.其他營業成本",acc1:"5900~5999"});
            list.push({indexs:"03",item:"營業成本",acc1:""});
                                  
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
            }
            
            function btnImport_click(){
            	if($.trim($('#txtDeadline').val()).length>0){
            		t_accy = $.trim($('#txtDeadline').val()).substring(0,3);
            		Lock(1,{opacity:0});
            		getData();            		
            	}else{
            		alert('請輸入截止日期‧');
            	}
            }
            
            var t_data1 = new Array();
            var t_data2 = new Array();
            function q_gtPost(t_name) {
                switch (t_name) { 
                	case 'btnOk':
                		var as = _q_appendData("acost", "", true);
                		if(as[0]!=undefined){
                			alert('截止日期重覆。');
                			Unlock(1);
                		}else{
                			var t_noa = trim($('#txtNoa').val());
			                var t_date = trim($('#txtDatea').val());
			                if (t_noa.length == 0 || t_noa == "AUTO")
			                    q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
			                else
			                    wrServer(t_noa);
                		}
                		break;
                	case  'acccs':
                		var as = _q_appendData("acccs", "", true);
                		if(as[0]!=undefined){
                			t_data1 = as;
                		}
                		btnImport();
                		break;	
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;          
                }
            }
            
            function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}
			
			function getData(){
				var t_where = "where=^^ accc2<='"+$('#txtDeadline').val().substr(4,5)+"' ^^";
				q_gt('acccs', t_where, 0, 0, 0, "", $('#txtDeadline').val().substr(0,3)+'_1');					
			}

			function btnImport(){
				var accc5;
				var t_money = 0;
				
				for(var i=0; i<q_bbsCount; i++){
					if($('#txtAcc1_'+i).val().length==0){
						if(i<list.length)
							$('#txtMoney'+list[i].indexs.substr(1,1)+'_'+i).val(t_money);
						continue;
					}						
					accc5 = $('#txtAcc1_'+i).val()+',';
					t_money = 0;				
					while(accc5.length>0){						
						if(accc5.substr(0,accc5.indexOf(',')).length==4){
							if(list[i].item.indexOf('期初')>0){
								t_money=calMoney('01/01','01/01',accc5.substr(0,4),accc5.substr(0,4));
							}else if(list[i].item.indexOf('期末')>0){
								t_money=calMoney($('#txtDeadline').val().substr(4,5),$('#txtDeadline').val().substr(4,5),accc5.substr(0,4),accc5.substr(0,4));
							}else{
								t_money=calMoney('01/01',$('#txtDeadline').val().substr(4,5),accc5.substr(0,4),accc5.substr(0,4));
							}
						}else{	
							if(list[i].item.indexOf('期初')>0){
								t_money=calMoney('01/01','01/01',accc5.substr(0,4),accc5.substr(5,4));
							}else if(list[i].item.indexOf('期末')>0){
								t_money=calMoney($('#txtDeadline').val().substr(4,5),$('#txtDeadline').val().substr(4,5),accc5.substr(0,4),accc5.substr(5,4));
							}else{
								t_money=calMoney('01/01',$('#txtDeadline').val().substr(4,5),accc5.substr(0,4),accc5.substr(5,4));
							}												
						}						
						accc5 = accc5.substr(accc5.indexOf(',')+1,accc5.length);
					}//while-loop
					$('#txtMoney'+list[i].indexs.substr(1,1)+'_'+i).val(t_money);					
				}//i-loop		
				Unlock(1);
			}//btnImport	
			
			function calMoney(bdate,edate,baccc5,eaccc5){				
				var money = 0;
				for(var j=0; j<t_data1.length; j++){
					if((t_data1[j].accc2>=bdate && t_data1[j].accc2<=edate) && 
					   (t_data1[j].accc5.substr(0,4)>=baccc5 && t_data1[j].accc5.substr(0,4)<=eaccc5)){
					   	if(t_data1[j].accc5.substr(0,1)=='1' || t_data1[j].accc5.substr(0,1)=='5' || t_data1[j].accc5.substr(0,1)=='6' ||
						   t_data1[j].accc5.substr(0,1)=='8' || t_data1[j].accc5.substr(0,1)=='9'){						   	
							money = money + (parseFloat(t_data1[j].dmoney)-parseFloat(t_data1[j].cmoney));   	
						}else{
							money = money + (parseFloat(t_data1[j].cmoney)-parseFloat(t_data1[j].dmoney));	
						}						
					}
				}//j-loop
				return money;
			}//calMoney
			
			function sum(){       

            }	
			
            function btnOk() {
            	Lock(1,{opacity:0});
            	for (var i = 0; i < q_bbsCount; i++) {
            		$('#txtSel_'+i).val(i);
            	}
            	sum();
            	if(q_cur ==1){
	            	$('#txtWorker').val(r_name);
	            }else if(q_cur ==2){
	            	$('#txtWorker2').val(r_name);
	            }else{
	            	alert("error: btnok!");
	            }
	            //---------------------------------------------------
	            if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
					Unlock(1);
            		return;
				}
	            if($('#txtDeadline').val().length == 0 || !q_cd($('#txtDeadline').val())){
					alert(q_getMsg('lblDeadline')+'錯誤。');
					Unlock(1);
            		return;
				}	
	            q_gt('acost', "where=^^ deadline='"+$.trim($('#txtDeadline').val())+"' and noa!='"+$.trim($('#txtNoa').val())+"' ^^", 0, 0, 0, "btnOk");
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
                    	
                		
                    }
                }
                _bbsAssign();
            }
                   
            function refreshBbs(){
            	//indexs: 00(x),01(小計),02(合計),03(總計)
            	for (var i = 0; i < q_bbsCount; i++) {            
            		$('#txtItem_'+i).css("display","").attr("readonly","readonly").css("color","green").css("background","rgb(237, 237, 238)");
            		
            		switch($('#txtIndexs_'+i).val()){           			
            			case '01':
            				$('#txtAcc1_'+i).css("display","none")       			
            				$('#txtMoney2_'+i).css("display","none").val(0);
            				$('#txtMoney3_'+i).css("display","none").val(0);
            				break;
            			case '02':
            				$('#txtAcc1_'+i).css("display","none")
            				$('#txtMoney1_'+i).css("display","none").val(0);   
            				$('#txtMoney3_'+i).css("display","none").val(0);       				
            				break;
            			case '03':
            				$('#txtAcc1_'+i).css("display","none")          				
            				$('#txtMoney1_'+i).css("display","none").val(0);
            				$('#txtMoney2_'+i).css("display","none").val(0);           			
            				break;
            			case '11':
            				$('#txtMoney2_'+i).css("display","none").val(0);
            				$('#txtMoney3_'+i).css("display","none").val(0);
            				break;
            			case '12':
            				$('#txtMoney1_'+i).css("display","none").val(0);   
            				$('#txtMoney3_'+i).css("display","none").val(0);       				
            				break;
            			case '13':
            				$('#txtMoney1_'+i).css("display","none").val(0);
            				$('#txtMoney2_'+i).css("display","none").val(0);           			
            				break;	
            			default:            				
            				$('#txtItem_'+i).css("display","none")
            				$('#txtAcc1_'+i).css("display","none")            				     				
            				$('#txtMoney1_'+i).css("display","none").val(0);
            				$('#txtMoney2_'+i).css("display","none").val(0);
            				$('#txtMoney3_'+i).css("display","none").val(0);
            				break;	       			
            		}            		
            	}
            }                                       
            
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
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
                	$('#txtIndexs_'+i).val(list[i].indexs);
                	$('#txtItem_'+i).val(list[i].item);
                	$('#txtBacc1_'+i).val(list[i].bacc1);
                	$('#txtEacc1_'+i).val(list[i].eacc1);
                	$('#txtAcc1_'+i).val(list[i].acc1);
                }
                refreshBbs();              
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDeadline').val('104/12/31');
                $('#txtDeadline').focus();
            }
            
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                refreshBbs();               
                sum();
            }

            function btnPrint() {
                //q_box("z_accc3.aspx?;;;;"+r_accy, 'z_accc3', "95%", "95%", q_getMsg("popAccc3"));
                q_box("z_accashf.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy, 'accashf', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['item']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function bbtSave(as) {
                if (!as['item']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbs();             
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur=='1' || q_cur=='2'){
                	$('#btnImport').removeAttr('disabled');
                }else{
                	$('#btnImport').attr('disabled','disabled');
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
                height: 42px;
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
                width: 650px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px white double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: black;
                background: #FFDDAA;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px white double;
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
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='noa' style="text-align: center;">~noa</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id="lblAccy" class="lbl"> </a></td>
						<td><input id="txtAccy" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDeadline" class="lbl"> </a></td>
						<td><input id="txtDeadline" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text"  class="txt c1"/></td>
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
		<div class='dbbs' style="float:left; width:880px;">
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;display: none;"  />
						<input id="btnImport" value="匯入" type="button" onclick="btnImport_click()" style="font-size: medium; font-weight: bold; width:95%;"/>
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:400px;"><a id='lblItem_s'> </a></td>
					<td align="center" style="width:350px;"><a id='lblAcc1_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMoney1_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMoney2_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMoney3_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;display: none;" />
						<input class="btn"  id="btnPlusX.*" type="button" value='+' style="font-weight: bold;display: none;"  />
						<input id="txtNoq.*" type="text" style="display: none;" />
						<input id="txtIndexs.*" type="text" style="display: none;" />
					</td>		
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>	
					<td><input type="text" id="txtItem.*" style="width:98%;" /></td>
					<td><input type="text" id="txtAcc1.*" style="width:98%;" /></td>
					<td><input type="text" id="txtMoney1.*" style="width:96%; text-align: right;" /></td>
					<td><input type="text" id="txtMoney2.*" style="width:96%; text-align: right;" /></td>
					<td><input type="text" id="txtMoney3.*" style="width:96%; text-align: right;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="float:left; display: none;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td align="center" style="width:30px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;display: none;" value="＋"/>
						<input id="btnLoad" value="匯入" type="button" onclick="btnLoad_click()" style="font-size: medium; font-weight: bold;"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:200px; text-align: center;">項目</td>
						<td style="width:200px; text-align: center;">會計科目</td>
						<td style="width:120px; text-align: center;">金額</td>
					</tr>
					<tr>
						<td align="center">
						<input class="btn"  id="btnMinut..*" type="button" value='-' style=" font-weight: bold;display: none;" />
						<input class="btn"  id="btnPlutX..*" type="button" value='+' style="font-weight: bold;"  />
						<input id="txtNoq..*" type="text" style="display: none;" />
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtItem..*"  type="text" style="width:95%;"/></td>
						<td>
							<input id="txtAcc1..*"  type="text" style="float:left;width:97%;"/>
							<input id="txtBacc1..*"  type="text" style="float:left;width:45%;"/>
							<a style="float:left;width:5%;">~</a>
							<input id="txtEacc1..*"  type="text" style="float:left;width:45%;"/>						
						</td>
						<td><input id="txtMoney..*" type="text" style="width:95%; text-align: right;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
