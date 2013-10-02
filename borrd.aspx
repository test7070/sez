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

            q_tables = 't';
            var q_name = "borrd";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtPaybno','txtAccno'];
            var q_readonlys = [];
            var q_readonlyt = ['txtMon','txtMoney','txtMemo','txtVccno','txtAccno'];
            var bbmNum = [['txtMoney',10,0,1],['txtMoney2',10,0,1],['txtCharge',10,0,1]];
            var bbsNum = [['txtRate',10,2],['txtMoney',10,0,1]];
            var bbtNum = [['txtMoney',10,0,1]];
            var bbmMask = [['textMon_windows','999/99'],['txtDatea','999/99/99'],['txtBegindate','999/99/99'],['txtEnddate','999/99/99'],['txtPaydate','999/99/99'],['txtVccday','99']];
            var bbsMask = [['txtDatea','999/99/99']];
            var bbtMask = [['txtDatea','999/99/99']];
            
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 20;

            aPop = new Array(
             ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtCust,txtCustnick', 'cust_b.aspx']
			,['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
            ,['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtTggnick', 'tgg_b.aspx']
            ,['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            ,['txtTacc1', 'lblTacc1', 'acc', 'acc1,acc2', 'txtTacc1,txtTacc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
                $('#txtBegindate').datepicker();
                $('#txtEnddate').datepicker();
                $('#txtPaydate').datepicker();
                
                $('#txtAcc1').change(function () {
		            var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt, "$1.$2"));
		        });
		        $('#txtTacc1').change(function () {
		            var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt, "$1.$2"));
		        });
             	$('#lblPaybno').click(function() {
		     		t_where = "noa='" + $('#txtPaybno').val() + "'";
            		q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pay', "95%", "95%", q_getMsg('popPaytran'));
             	});
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
                
                $('#btnInterest').click(function(){
                	$('#InterestWindows').toggle();
                });
                $('#btnCloseWindows').click(function(){
                	$('#InterestWindows').toggle();
                });
                $('#btnProcessInterest').click(function(){
                	var P_Mon = $('#textMon_windows').val();
                	if(P_Mon.length != 0){
                		$('#btnProcessInterest').attr('disabled','disabled');
                		Lock();
                		q_func('dayborrd.process', P_Mon);
                	}else{
                		alert('請輸入' + q_getMsg('lblMon_windows'));
                	}
                });

            }

			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'dayborrd.process':
						alert('Done!'+result);
						Unlock();
						$('#btnProcessInterest').removeAttr('disabled','disabled');
					break;
				}
			}
			
			function browVccno(obj){
				var noa = $.trim($(obj).val());
				var n = $(obj).attr('id').replace('txtVccno__','');
            	if(noa.length>0)
            		q_box("vcctran.aspx?;;;noa='" + noa + "';"+$('#txtMon__'+n).val().substring(0,3), 'vcc', "95%", "95%", q_getMsg("popVcctran"));
			}
			function browAccno(obj){
				var noa = $.trim($(obj).val());
				var n = $(obj).attr('id').replace('txtAccno__','');
            	if(noa.length>0)
            		q_box("accc.aspx?;;;accc3='" + noa + "';"+$('#txtMon__'+n).val().substring(0,3)+"_1", 'accc', "95%", "95%", q_getMsg("popAccc"));
			}
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                //abbm[q_recno]['accno'] = xmlString;
                //$('#txtAccno').val(xmlString);
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('borrd_s.aspx', q_name + '_s', "520px", "520px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
				var x_day=q_getPara('sys.modiday'),t_day=1;
				var t_date=q_date();
						
				while(r_rank<=7 && t_day<x_day){
					var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
					nextdate.setDate(nextdate.getDate() -1)
					t_date=''+(nextdate.getFullYear()-1911)+'/';
					//月份
					t_date=t_date+((nextdate.getMonth()+1)<10?('0'+(nextdate.getMonth()+1)+'/'):((nextdate.getMonth()+1)+'/'));
					//日期
					t_date=t_date+(nextdate.getDate()<10?('0'+(nextdate.getDate())):(nextdate.getDate()));
					
					//六日跳過
					if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0 //日
					||new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6 //六
					){continue;}
					               	
					//假日跳過
					if(holiday){
						var isholiday=false;
						for(var i=0;i<holiday.length;i++){
							if(holiday[i].noa==t_date){
								isholiday=true;
								break;
							}
						}
						if(isholiday) continue;
					}
					t_day++;
				}
				for(var j = 0; j < q_bbsCount; j++) {
					if(r_rank<=7&&t_date>$('#txtDatea_'+j).val()){
						$('#btnPlus').attr('disabled', 'disabled');
						$('#btnMinus_'+j).attr('disabled', 'disabled');
						$('#txtDatea_'+j).attr('disabled', 'disabled');
						$('#txtRate_'+j).attr('disabled', 'disabled');
						$('#txtRatemon_'+j).attr('disabled', 'disabled');
						$('#txtFixmoney_'+j).attr('disabled', 'disabled');
						$('#txtMemo_'+j).attr('disabled', 'disabled');
					}
				}
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box('z_borr.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
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
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_borrd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                if (q_cur > 0 && q_cur < 4)
                    sum();
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

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
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
                    }
                }
                _bbtAssign();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;             
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

            function q_popPost(id) {
                switch (id) {
                    default:
                        break;
                }
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
                width: 9%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 600px;
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
                width: 800px;
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
            #InterestWindows{
            	display:none;
            	width:20%;
            	background-color: #cad3ff;
            	border: 5px solid gray;
            	position: absolute;
            	z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:100px; color:black;"><a id='vewTgg'> </a></td>
						<td style="width:100px; color:black;"><a id='vewPaydate'> </a></td>
						<td style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td style="width:80px; color:black;"><a id='vewCharge'> </a></td>
						<td style="width:100px; color:black;"><a id='vewCust'> </a></td>
						<td style="width:60px; color:black;"><a id='vewVccday'> </a></td>
						<td style="width:100px; color:black;"><a id='vewBegindate'> </a></td>
						<td style="width:100px; color:black;"><a id='vewEnddate'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='tggnick' style="text-align: center;">~tggnick</td>
						<td id='paydate' style="text-align: center;">~paydate</td>
						<td id='money,0,1' style="text-align: right;">~money,0,1</td>
						<td id='charge,0,1' style="text-align: right;">~charge,0,1</td>
						<td id='custnick' style="text-align: center;">~custnick</td>
						<td id='vccday' style="text-align: center;">~vccday</td>
						<td id='begindate' style="text-align: center;">~begindate</td>
						<td id='enddate' style="text-align: center;">~enddate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
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
						<td colspan="2"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblBegindate" class="lbl"> </a></td>
						<td><input id="txtBegindate"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblEnddate" class="lbl"> </a></td>
						<td><input id="txtEnddate"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtTggno"  type="text" style="width:25%; float:left;"/>
						<input id="txtTgg"  type="text" style="width:75%; float:left;"/>
						<input id="txtTggnick"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblPaydate" class="lbl"> </a></td>
						<td><input id="txtPaydate"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSalesno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtSalesno"  type="text" style="width:25%; float:left;"/>
							<input id="txtSales"  type="text" style="width:75%; float:left;"/>
						</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblAcc1" class="lbl btn"> </a></td>
						<td><input id="txtAcc1" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtAcc2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMoney2" class="lbl"> </a></td>
						<td><input id="txtMoney2" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCharge" class="lbl"> </a></td>
						<td><input id="txtCharge" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTacc1" class="lbl btn"> </a></td>
						<td><input id="txtTacc1" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtTacc2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtCustno"  type="text" style="width:25%; float:left;"/>
						<input id="txtCust"  type="text" style="width:75%; float:left;"/>
						<input id="txtCustnick"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblVccday" class="lbl"> </a></td>
						<td><input id="txtVccday"  type="text"  class="txt c1 num"/></td>
					</tr>				
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1"/></td>
						<td colspan="2"><span> </span><a id="lblPaybno" class="lbl btn"> </a></td>
						<td><input id="txtPaybno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td colspan="2"><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td colspan="2" align="center">
							<div id="InterestWindows">
								<table>
									<tr>
										<td style="width:30%;"><span> </span><a id="lblMon_windows" class="lbl"> </a></td>
										<td style="width:70%;"><input id="textMon_windows" type="text" class="txt c1"/></td>
									</tr>
									<tr>
										<td colspan="2" align="center">
											<input id="btnProcessInterest" type="button">
											<input id="btnCloseWindows" type="button" value="關閉視窗">
										</td>
									</tr>
								</table>
							</div>
							<input id="btnInterest" type="button">
						</td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:120px;"><a id='lbl_datea'> </a></td>
						<td style="width:100px;"><a id='lbl_rate'> </a></td>		
						<td style="width:100px;"><a id='lbl_ratemon'> </a></td>		
						<td style="width:100px;"><a id='lbl_fixmoney'> </a></td>
						<td style="width:200px;"><a id='lbl_memo'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input class="txt" id="txtDatea.*" type="text" style="width:95%; text-align: center;"/></td>
						<td><input class="txt" id="txtRate.*" type="text" style="width:95%; text-align: right;"/></td>
						<td><input class="txt" id="txtRatemon.*" type="text" style="width:95%; text-align: right;"/></td>
						<td><input class="txt" id="txtFixmoney.*" type="text" style="width:95%; text-align: right;"/></td>
						<td><input class="txt" id="txtMemo.*" type="text" style="width:95%; text-align: left;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:90px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:200px; text-align: center;">請款日期	</td>
						<td style="width:100px; text-align: center;">金額</td>
						<td style="width:350px; text-align: center;">備註</td>
						<td style="width:200px; text-align: center;">請款單號</td>
						<td style="width:200px; text-align: center;">傳票號碼</td>
					</tr>
					<tr>
						<td>
							<!--<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>-->
							<span> </span><a id="lblCancel_t" class="lbl"> </a>
							<input id="chkCancel..*" type="checkbox"/>
							<input id="txtNoq..*" type="text" style="display:none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtMon..*" type="text" style="width:95%;"/></td>
						<td><input id="txtMoney..*"  type="text" style="width:95%; text-align: right;"/></td>
						<td><input id="txtMemo..*"  type="text" style="width:95%; text-align: left;"/></td>
						<td><input id="txtVccno..*" onclick="browVccno(this)" type="text" style="width:95%;"/></td>
						<td><input id="txtAccno..*" onclick="browAccno(this)" type="text" style="width:95%;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>