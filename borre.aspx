<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
            this.errorHandler = null;

            q_tables = 's';
            var q_name = "borre";
            var q_readonly = [ 'txtPay'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['money', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], 
            ['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno,txtCust', 'cust_b.aspx'],
            ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno])

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }///  end Main()

            function mainPost() {
            	bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('borr.typea'), 's');
				$('#txtDatea').focusout(function () {
                     	   q_cd( $(this).val() ,$(this));
	                });
                $("#txtPayc").change(function() {
                    sum();
                });
                $("#cmbTaxtype").change(function() {
                    sum();
                });
                $("#txtTaxrate").change(function() {
                    sum();
                });
            }
			var checkenda=false;
		var holiday;//存放holiday的資料
		function endacheck(x_datea,x_day) {
			//102/06/21 7月份開始資料3日後不能在處理
			var t_date=x_datea,t_day=1;
                
			while(t_day<x_day){
				var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
				nextdate.setDate(nextdate.getDate() +1)
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
                
			if (t_date<q_date()){
				checkenda=true;
			}else{
				checkenda=false;
			}
		}
            function pop(form, seq) {
            }

            function txtCopy(dest, source) {
                var adest = dest.split(',');
                var asource = source.split(',');
                $('#' + adest[0]).focus(function() {
                    if(trim($(this).val()).length == 0)
                        $(this).val(q_getMsg('msgCopy'));
                });
                $('#' + adest[0]).focusout(function() {
                    var t_copy = ($(this).val().substr(0, 1) == '=');
                    var t_clear = ($(this).val().substr(0, 2) == ' =');
                    for(var i = 0; i < adest.length; i++) { {
                            if(t_copy)
                                $('#' + adest[i]).val($('#' + asource[i]).val());

                            if(t_clear)
                                $('#' + adest[i]).val('');
                        }
                    }
                });
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'holiday':
            				holiday = _q_appendData("holiday", "", true);
            				endacheck($('#txtDatea').val(),q_getPara('sys.modiday'));//單據日期,幾天後關帳
            			break;
                    case q_name:
                        if(q_cur == 4)
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

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
               q_box('borre_s.aspx', q_name + '_s', "500px", "340px", q_getMsg( "popSeek"));
            }

            function btnIns() {
                _btnIns();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                if (checkenda){
         	       alert('超過'+q_getPara('sys.modiday')+'天'+'已關帳!!');
            	    return;
	    		}
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
						$('#cmbTypea_'+j).attr('disabled', 'disabled');
						$('#txtCarowner_'+j).attr('disabled', 'disabled');
						$('#txtCarno_'+j).attr('disabled', 'disabled');
						$('#txtMemo_'+j).attr('disabled', 'disabled');
						$('#txtSalesvolume_'+j).attr('disabled', 'disabled');
						$('#txtTax_'+j).attr('disabled', 'disabled');
						$('#txtCheckno_'+j).attr('disabled', 'disabled');
						$('#txtBankno_'+j).attr('disabled', 'disabled');
						$('#txtAccount_'+j).attr('disabled', 'disabled');
						$('#txtBank_'+j).attr('disabled', 'disabled');
						$('#txtMoney_'+j).attr('disabled', 'disabled');
						$('#txtIndate_'+j).attr('disabled', 'disabled');
						$('#txtAcc1_'+j).attr('disabled', 'disabled');
						$('#txtAcc2_'+j).attr('disabled', 'disabled');
					}
				}
            }

            function btnPrint() {
                q_box('z_borr.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
                var t_err = '';
				$('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
                }  
                //  t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);
                var t_noa = $.trim($('#txtNoa').val());
                //  alert(t_noa+'  '+t_noa.length);
                //  if(t_noa.length == 0)
                //    q_gtnoa(q_name, t_noa);
                //else

                wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['checkno']) {
                    as[bbsKey[1]] = '';
                    
                    return;
                }

                q_nowf();
                as['noa'] = abbm2['noa'];

                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                if(r_rank<=7)
            		q_gt('holiday', '' , 0, 0, 0, "", r_accy);
            	else
            		checkenda=false;
                if(q_cur > 0 && q_cur < 4)
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

            function bbsAssign() {
                _bbsAssign();

                for(var j = 0; j < q_bbsCount; j++) {
                    $("#txtMoney_" + j).change(function(e) {
                        sum();
                    });
                }
            }

            function sum() {
                switch($("#cmbTaxtype").val()) {
                    case '1':
                        //extra
                        $("#txtTax").val(Math.round($("#txtPayc").val() * $("#txtTaxrate").val() / 100, 0));
                        break;
                    case '3':
                        //include  
                        $("#txtTax").val($("#txtPayc").val() - Math.round($("#txtPayc").val() / (1 + $("#txtTaxrate").val() / 100), 0));
                        break;
                    case '5':
                        //custom
                        $("#txtTaxrate").val(0);
                        break;
                    default:
                        $("#txtTax").val(0);
                }

                var inMoney = 0;
                var outMoney = 0;
                for(var i = 0; i < q_bbsCount; i++) {
                    if($("#cmbTypea_" + i).val() == '1')
                        outMoney += $("#txtMoney_" + i).val();
                    else
                        inMoney += $("#txtMoney_" + i).val();
                }
                $("#txtBwmoney").val(outMoney);
                $("#txtPay").val(inMoney);
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
            	if (checkenda){
         	       alert('超過'+q_getPara('sys.modiday')+'天'+'已關帳!!');
            	    return;
	    		}
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
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
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }		</script>
		<style type="text/css">
           #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 29%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 69%;
                margin: -1px;
                border: 1px black solid;
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
                width: 2%;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 99%;
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
            .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
             .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td{
            	text-align: center;
                border: 2px lightgrey double;
            }
            
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewDatea'></a></td>
						<td align="center" style="width:25%"><a id='vewNoa'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1">
						<td class="td1" ><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td class="td5"> </td>
						<td class="td6"> </td>
						<td class="td9"> </td>
					</tr>
					<tr class="tr2">
						<td class="td5" ><span> </span>
						<a id="lblAcomp" class="lbl btn" > </a>
						</td>
						<td class="td6" colspan="3">
						<input id="txtCno"  type="text"  class="txt c2"/>
						<input id="txtAcomp"  type="text" class="txt c3"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblCash" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtCash"  type="text" class="txt c1 num" />
						</td>
						<td class="td3"><span> </span><a id="lblChecka" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtChecka"  type="text" class="txt c1 num" />
						</td>
						<td class="td5" ><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtMoney" type="text" class="txt c1 num" />
						</td>
					</tr>
					<tr class="tr5">
						<td class="td3"><span> </span><a id="lblSalesvolume" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtSalesvolume"  type="text" class="txt c1 num" />
						</td>
						<td class="td5"><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtTax" type="text" class="txt c1 num" />
						</td>
						<td class="td5" >
						<input id="btnUmmtran" type="button" class="btn"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblArrerage" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtArrerage" type="text" class="txt c1 num" />
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1" ><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="column1" colspan="5"><textarea id="txtMemo" style="width:100%; height: 50px;"> </textarea></td>
					</tr>

				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td align="center" style="width:3%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" style="width:4%;"><a id='lbl_typea'> </a></td>
						
						
						<td align="center" style="width:6%;"><a id='lbl_carowner'> </a></td>
						<td align="center" style="width:6%;"><a id='lbl_carno'> </a></td>
						<td align="center" style="width:5%;"><a id='lbl_memo'> </a></td>
						<td align="center" style="width:5%;"><a id='lbl_salesvolume'> </a></td>
						<td align="center" style="width:5%;"><a id='lbl_tax'> </a></td>
						<td align="center" style="width:5%;"><a id='lbl_checkno'> </a></td>
						<td align="center" style="width:6%;"><a id='lbl_bankno'> </a></td>
						<td align="center" style="width:9%;"><a id='lbl_account'> </a></td>
						<td align="center" style="width:6%;"><a id='lbl_bank'> </a></td>
						<td align="center" style="width:6%;"><a id='lbl_money'> </a></td>
						<td align="center" style="width:5%;"><a id='lbl_indate'> </a></td>
						<td align="center" style="width:5%;"><a id='lbl_acc'> </a></td>

					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input class="txt" id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><select id="cmbTypea.*" style="width:95%; text-align: center;"> </select></td>
						<td>
						<input class="txt" id="txtCarowner.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtCarno.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtSalesvolume.*" type="text" style="width:95%;text-align: right;"/>
						</td>
						<td>
						<input class="txt" id="txtTax.*" type="text" style="width:95%;text-align: right;"/>
						</td>
						<td>
						<input class="txt" id="txtCheckno.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtBankno.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtAccount.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtBank.*" type="text" style="width:95%;"/>
						</td>
						<td>
						<input class="txt" id="txtMoney.*" type="text" style="width:95%;  text-align: right;"/>
						</td>
						<td>
						<input class="txt" id="txtIndate.*" type="text" style="width:95%; text-align: center;"/>
						</td>
						<td>
						<input class="txt" id="txtAcc1.*" type="text" style="width:20%;"/><input class="txt" id="txtAcc2.*" type="text" style="width:50%;"/><input id="btnAcc.*" type="button" value="." style="width: 10%;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

