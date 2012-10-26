<%@ Page Language="C#" AutoEventWireup="true" %>
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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "carborr";
            var q_readonly = ['txtNoa','txtWorker','txtMoney2','txtTotal'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney',10,0],['txtComppay',10,0],['txtMount',10,0]];
            var bbsNum = [['txtMoney',10,0]];
            var bbmMask = [['txtMon','999/99'],['txtDatea','999/99/99'],['txtTicketdate','999/99/99']];
            var bbsMask = [['txtMon','999/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            
            t_curMoney = 0;
            t_curMon='';
            t_curDriverno='';
            t_money2=0;
            
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
				
				var tmp = q_getMsg('carborr.typea').split('&');
				var t_string = '';
				for(var x in tmp){
					t_string += (t_string.length>0?',':'')+tmp[x];
				}
				q_cmbParse("cmbTypea", t_string);
				
                $('#txtMon').change(function() {
                    money2();
                });
                $('#txtComppay').change(function() {
                    sum();
                });
				$('#txtMoney').change(function() {
                    sum();
                });
				$('#btnAction').click(function(){
					var t_y,t_m,t_money,t_mon=$.trim($('#txtMon').val());
					if(t_mon.length==0)
						return;
					var n = q_int('txtMount');
					if(n==0){
						$('#txtMount').val('1');
						n=1;
					}
					var as  =  new  Array();
					t_money  =  Math.floor(q_int('txtMoney')/n);
					as.push({mon:t_mon,money:t_money});
					t_y=parseFloat(t_mon.substring(0,3));
					t_m= parseFloat(t_mon.substring(4));
					for(var  i=0;i<n-1;i++){
						t_m+=1;
						if(t_m>12){
							t_m=1;
							t_y+=1;	
						}
						if(i==n-2){
							t_money  =  q_int('txtMoney')-t_money*(n-1);
						}
						as.push({mon:(t_y+'/'+(t_m<10?'0':'')+t_m),money:t_money});
					}
					
					q_gridAddRow(bbsHtm, 'tbbs', 'txtMon,txtMoney', as.length, as, 'mon,money', '', '');
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

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'driver':
                		var as = _q_appendData("driver", "", true);
						var t_rate = 0;
						for ( i = 0; i < as.length; i++) {
							t_rate = parseFloat(as[i].rate);
						}
						$('#txtMoney2').val(Math.round(t_money2*t_rate/10));
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
            	var  t_money  =  0;
            	for (var i = 0; i< q_bbsCount; i++) {
                   	t_money  +=  q_float('txtMoney_'+i);
                }
                if(q_float('txtMoney')!=t_money){
                	alert('分期金額異常');
                	return;
                }
            	if($('#cmbTypea').val()=='借支'){
            		if(q_float('txtMoney')>q_float('txtMoney2')){
            			alert('超支!');
            			return;
            		}	
            	}
                $('#txtWorker').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_carborr') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
                    
                t_curMoney=0;
                t_curMon='';
                t_curDriverno='';
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('carborr_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                _bbsAssign();
                for (var ix = 0; ix < q_bbsCount; ix++) {
                    $('#lblNo_' + ix).text(ix + 1);
                }
            }
            
            function sum(){
            	var t_total=0;
            	
            	$('#txtTotal').val(q_float('txtComppay')+q_float('txtMoney'));
            }
			function money2(){
				
            	if($('#txtMon').val().length>0 && $('#txtDriverno').val().length>0 )
                	q_func('carsal2.import',r_accy+','+$('#txtMon').val()+','+$('#txtDriverno').val()+','+$('#txtDriverno').val());
            }
            function q_funcPost(t_func, result) {/// 執行 q_exec() 呼叫 server 端 function 後， client 端所要執行的程式
                if (result.substr(0, 5) == '<Data') {/// 如果傳回  table[]
                    var as = _q_appendData('carsal2', '', true);
                    if(as.length>0){
                    	/*if(t_curMon==$('#txtMon').val() &&  t_curDriverno==$('#txtDriverno').val())
                    		$('#txtMoney2').val(parseFloat(as[0].total)+t_curMoney);
                    	else
                    		$('#txtMoney2').val(parseFloat(as[0].total));*/
                    	if(t_curMon==$('#txtMon').val() &&  t_curDriverno==$('#txtDriverno').val())
                    		t_money2=parseFloat(as[0].total)+t_curMoney;
                    	else
                    		t_money2=parseFloat(as[0].total);
                    	q_gt('driver', "where=^^noa='"+$("#txtDriverno").val()+"'", 0, 0, 0, "", r_accy);	
                    	
                    }
                    else
                    	$('#txtMoney2').val('');              
                } else
                    alert(t_func + '\r' + result);
            }
            function q_popPost(id) {
				switch(id) {
					case 'txtCarno':
						money2();
						break;
					case 'txtDriverno':
						money2();
						break;
				}
			}
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('#txtMon').val($('#txtDatea').val().substring(0,6));
                t_curMoney = 0;
                t_curMon=$('#txtMon').val();
                t_curDriverno=$('#txtDriverno').val();
                for (var iy = 0; iy < q_bbsCount; iy++) {
                	if(t_curMon==$('#txtMon_'+iy).val())
                    	t_curMoney+=q_float('txtMoney_'+iy);
                }
                money2();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                t_curMoney = 0;
                t_curMon=$('#txtMon').val();
                t_curDriverno=$('#txtDriverno').val();
                for (var iy = 0; iy < q_bbsCount; iy++) {
                	if(t_curMon==$('#txtMon_'+iy).val())
                    	t_curMoney+=q_float('txtMoney_'+iy);
                }
                money2();
            }

            function btnPrint() {
                q_box('z_carborr.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "90%", "600px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['mon'] && !as['money']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
				money2();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (q_cur == 1 || q_cur == 2) {
                    $('#btnAction').removeAttr('disabled');
                } else {
                    $('#btnAction').attr('disabled', 'disabled');
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
                t_curMoney=0;
                t_curMon='';
                t_curDriverno='';
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 30%;
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
                width: 65%;
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
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
            }
            .tbbm  .tr_import {
                background-color: #DAA520;
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
                width: 2000px;
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

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:15%"><a id='vewDatea'></a></td>
						<td align="center" style="width:20%"><a id='vewCarno'></a></td>
						<td align="center" style="width:20%"><a id='vewDriver'></a></td>
						<td align="center" style="width:20%"><a id='vewTypea'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='carno' style="text-align: center;">~carno</td>
						<td id='driver' style="text-align: center;">~driver</td>
						<td id='typea' style="text-align: center;">~typea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
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
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td>
						<input id="txtCarno" type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDriver" class="lbl"> </a></td>
						<td colspan="2">
						<input id="txtDriverno" type="text"  class="txt c2"/>
						<input id="txtDriver" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
						<td><span> </span><a id="lblTicketno" class="lbl"> </a></td>
						<td><input id="txtTicketno" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblTicketdate" class="lbl"> </a></td>
						<td><input id="txtTicketdate" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblComppay" class="lbl"> </a></td>
						<td>
						<input id="txtComppay" type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td>
						<input id="txtMoney" type="text"  class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblMoney2" class="lbl"> </a></td>
						<td>
						<input id="txtMoney2" type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount" type="text"  class="txt c1 num"/></td>
						<td>
						<input id="btnAction" type="button"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td>
						<input id="txtTotal" type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="4">
						<input id="txtMemo" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td>
						<input id="txtWorker" type="text"  class="txt c1"/>
						</td>
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
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:120px;"><a id='lblMon_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMoney_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input type="text" id="txtMon.*" style="width:95%;" />
					</td>
					<td>
					<input type="text" id="txtMoney.*" style="width:95%; text-align: right;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
