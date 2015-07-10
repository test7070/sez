<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			isEditTotal = false;
            q_tables = 's';
            var q_name = "tre";
            var q_readonly = ['txtAccno','txtNoa', 'txtMoney', 'txtTotal','txtTolls','txtWorker2','txtWorker','txtRc2ano','txtPaydate','txtPlusmoney','txtMinusmoney','txtAccno','txtAccno2','txtYear2','txtYear1'];
            var q_readonlys = ['txtOrdeno', 'txtTranno', 'txtTrannoq'];
            var bbmNum = [['txtUnopay', 10, 0],['txtMoney', 10, 0],['txtTolls', 10, 0],['txtTotal', 10, 0],['txtPlusmoney', 10, 0],['txtMinusmoney', 10, 0]];
            var bbsNum = [['txtMount', 10, 3],['txtPrice', 10, 3],['txtDiscount', 10, 3],['txtMoney', 10, 0],['txtTolls', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            //q_bbsLen = 20;
            aPop = new Array(
            	['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver','txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'],
            	['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTggcomp', 'tgg_b.aspx'],
            	['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'],
            	['txtBdriverno', '', 'driver', 'noa,namea', 'txtBdriverno', 'driver_b.aspx'],
          	  	['txtEdriverno', '', 'driver', 'noa,namea', 'txtEdriverno', 'driver_b.aspx']);

            q_xchg = 1;
            brwCount2 = 20;

            function tre() {}
			tre.prototype = {
				isLoad: false,
				carchgno : new  Array()
			}
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                $('#txtBcarno').val('0');
				$('#txtEcarno').val('zz');
            }

            function mainPost() {
            	q_modiDay= q_getPara('sys.modiday2');  /// 若未指定， d4=  q_getPara('sys.modiday'); 
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtDate2', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtPaydate', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
				
				q_gt('carteam', '', 0, 0, 0, "");
				$('#lblAccno').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtYear1').val() + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
		        });
				$('#lblAccno2').click(function () {
		            q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + $('#txtYear2').val() + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
		        });

                $('#txtTolls').change(function(e) {
                    sum();
                });
                $('#txtPlusmoney').change(function(e) {
					sum();
				});
				$('#txtMinusmoney').change(function(e) {
					sum();
				});
				$('#txtUnopay').change(function(e) {
					sum();
				});
                $('#btnTrans').click(function(e) {
                	if(q_cur != 1 && q_cur != 2){
                		if(r_accy.substring(0,3)!=$('#txtDate2').val().substring(0,3)){
		            		alert(q_getMsg('lblDate2')+'年度異常!');
		            		return;
		            	}
						Lock(1,{opacity:0});
	                	q_func('tre.import',r_accy+','+$('#cmbCarteamno').val()+','+$('#txtBdate').val()+','+$('#txtEdate').val()+','+$('#txtDate2').val()+','+r_name+', ');
                	}
                });
                $("#btnCarchg").click(function(e) {
					var t_carchgno='';
					if(curData.isLoad){
						for(var i=0;i<curData.carchgno.length;i++)
							t_carchgno += (t_carchgno.length>0?',':'')+curData.carchgno[i];
						t_carchgno='carchgno='+t_carchgno;
					}
					t_where = "  carno='" + $('#txtCarno').val() + "' and driverno='"+ $('#txtDriverno').val() +"' and  (treno='" + $('#txtNoa').val() + "' or len(isnull(treno,''))=0) ";
					q_box("carchg_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_carchgno + ";", 'carchg', "95%", "650px", q_getMsg('popCarchg'));

				});              
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'tre.import':
						if(result.length==0){
							alert('No data!');
							Unlock(1);
						}
						else
							location.reload();
                        break;
                }

            }

           function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'carchg':
						if (b_ret != null) {
							var t_where='1!=1';
							curData.isLoad = true;
							curData.carchgno = new Array();
							for (var i = 0; i < b_ret.length; i++) {
								curData.carchgno.push(b_ret[i].noa);
								t_where +=" or noa='"+b_ret[i].noa+"'";
							}
							q_gt('carchg', "where=^^"+t_where+"^^", 0, 0, 0, "");
						}
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'carteam':
						var as = _q_appendData("carteam", "", true);
						var t_item = "@";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						q_cmbParse("cmbCarteamno", t_item);
						if (abbm[q_recno] != undefined) {
							$("#cmbCarteamno").val(abbm[q_recno].carteamno);
						}
						q_gridv('tview', browHtm, fbrow, abbm, aindex, brwNowPage, brwCount);
						break;
                	case 'carchg':
						var as = _q_appendData("carchg", "", true);
						var t_plusmoney=0,t_minusmoney=0;
						for ( i = 0; i < as.length; i++) {
							t_plusmoney+=parseFloat(as[i].plusmoney);
							t_minusmoney+=parseFloat(as[i].minusmoney);
						}
						$('#txtPlusmoney').val(t_plusmoney);
						$('#txtMinusmoney').val(t_minusmoney);
						sum();
						break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
            	$('#txtDatea').val($.trim($('#txtDatea').val()));
            	$('#txtUnopay').val(q_float('txtUnopay'));
            	if(q_float('txtUnopay') != 0 && $('#txtTggno').val() == ''){
                	alert('請填寫' + q_getMsg('lblTgg'));
                	return;
            	}
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
                }
                $('#txtPaydate').val($.trim($('#txtPaydate').val()));
                if ($('#txtPaydate').val().length > 0 && checkId($('#txtPaydate').val())==0)
                    alert(q_getMsg('lblPaydate')+'錯誤。');          
                $('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val()))
                    alert(q_getMsg('lblMon')+'錯誤。');
            	 if(q_cur==1)
	           	$('#txtWorker').val(r_name);
	        else
	           	$('#txtWorker2').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                //-------------------------------------------------
				//回寫CARCHG
				if(curData.isLoad){
					var t_carchgno='';
					for(var i=0;i<curData.carchgno.length;i++)
						t_carchgno+=(t_carchgno.length>0?',':'')+curData.carchgno[i];
					$('#txtCarchgno').val(t_carchgno);
				}
				//-------------------------------------------------
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tre') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)
                    return;

                q_box('tre_s.aspx', q_name + '_s', "530px", "530px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for(var ix = 0; ix < q_bbsCount; ix++) {
                	$('#lblNo_'+ix).text(ix+1);	
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                curData = new tre();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
          		if (q_chkClose())
             		return;
                _btnModi();
                $('#txtDatea').focus();
                curData = new tre();
                sum();
            }

            function btnPrint() {
            	q_box('z_tre.aspx'+ "?;;;;"+r_accy+";", '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['tranno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
            		return;
                var t_money = 0, t_total = 0, t_tolls = 0;
                for( i = 0; i < q_bbsCount; i++) {
                	t_money += q_float('txtMoney_'+i);
                	t_tolls += q_float('txtTolls_'+i);
                }
                t_plusmoney = q_float('txtPlusmoney');
				t_minusmoney = q_float('txtMinusmoney');   
				t_unopay =  q_float('txtUnopay');       
                t_total = t_money + t_tolls + t_plusmoney - t_minusmoney - t_unopay;
                $('#txtTolls').val(t_tolls);
                $('#txtMoney').val(t_money);
                $('#txtTotal').val(t_total);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                
                if(q_cur == 1 || q_cur == 2) {
                	$('#lblDate2').hide();
                	$('#txtDate2').hide();
                	$('#btnTrans').hide();
                	$('#btnCarchg').removeAttr('disabled');
                }else{
                	$('#lblDate2').show();
                	$('#txtDate2').show();
                	$('#btnTrans').show();
                	$('#btnCarchg').attr('disabled', 'disabled');
                }
                $('#txtDate2').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
            	$('#txtBdate').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
            	$('#txtEdate').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
            	$('#cmbCarteamno').removeAttr('readonly').removeAttr('disabled').css('background-color','white');
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
            	if (q_chkClose())
             	return;
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
            .tbbm .tr1{
                background-color: #FFEC8B;
            }
            .tbbm .tr_carchg {
				background-color: #DAA520;
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
                font-size:medium;
            }
            .dbbs {
                width: 2400px;
            }
            .tbbs a {
                font-size: medium;
            }
            
            .num {
                text-align: right;
            }
			input[type="text"],input[type="button"] {
                font-size:medium;
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
						<td align="center" style="width:80px; color:black;"><a id='vewCarteam'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTolls'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewPlusmoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMinusmoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTotal'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewUnopay'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="carteamno=cmbCarteamno" style="text-align: center;">~carteamno=cmbCarteamno</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
						<td id="tolls,0,1" style="text-align: right;">~tolls,0,1</td>
						<td id="plusmoney,0,1" style="text-align: right;">~plusmoney,0,1</td>
						<td id="minusmoney,0,1" style="text-align: right;">~minusmoney,0,1</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="unopay,0,1" style="text-align: right;">~unopay,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr name="schema" style="height:1px;">
						<td class="td1"><span class="schema"> </span></td>
						<td class="td2"><span class="schema"> </span></td>
						<td class="td3"><span class="schema"> </span></td>
						<td class="td4"><span class="schema"> </span></td>
						<td class="td5"><span class="schema"> </span></td>
						<td class="td6"><span class="schema"> </span></td>
						<td class="td7"><span class="schema"> </span></td>
						<td class="td8"><span class="schema"> </span></td>
						<td class="td9"><span class="schema"> </span></td>
						<td class="tdA"><span class="schema"> </span></td>
						<td class="tdZ"><span class="schema"> </span></td>
					</tr>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblDate2" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtDate2" type="text"  class="txt c1" />
						</td>

						<td><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td><select id="cmbCarteamno" class="txt c1">  </select></td>
						<td class="td3" colspan="2"><span> </span><a id="lblDate3" class="lbl"> </a></td>
						<td class="td5" colspan="3">
						<input id="txtBdate" type="text"  class="txt c2"/>
						<span id="sign_2" style="float:left;display: block;width:20px;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
						<input id="txtEdate" type="text"  class="txt c2"/>
						</td>
						<td><input type="button" id="btnTrans" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="tr_carchg">
						<td colspan="9"><input id="txtCarchgno" type="text" class="txt c1" style="display:none;"/></td>
						<td>
						<input type="button" id="btnCarchg" class="txt c1"/>
						</td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>

						<td class="td6"><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td class="td7">
						<input id="txtCarno" type="text"  class="txt c1"/>
						</td>
						<td class="td8"><span> </span><a id="lblDriver" class="lbl"> </a></td>
						<td class="td9" colspan="2">
						<input id="txtDriverno" type="text"  class="txt c2"/>
						<input id="txtDriver" type="text"  class="txt c3"/>
						</td>
					</tr>	
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text"  class="txt c1"/></td>
					</tr>		
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblRc2ano" class="lbl"> </a></td>
						<td class="td2"  colspan="2">
						<input id="txtRc2ano" type="text" class="txt c1" />
						</td>
						<td class="td4"><span> </span><a id="lblPaydate" class="lbl"> </a></td>
						<td class="td5">
						<input id="txtPaydate" type="text" class="txt c1" />
						</td>
						<td class="td6"><span> </span><a id="lblCheckno" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtCheckno" type="text" class="txt c1" />
						</td>
					</tr>
					<tr class="tr5">
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td><input id="txtPlusmoney" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td><input id="txtMinusmoney" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblTolls" class="lbl"> </a></td>
						<td><input id="txtTolls" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text"  class="txt c2"/>
							<input id="txtTggcomp" type="text"  class="txt c3"/>
						</td>
						<td><span> </span><a id="lblUnopay" class="lbl"> </a></td>
						<td><input id="txtUnopay" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num" /></td>
						<!--
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text"  class="txt c1"/></td>
						-->
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="6"><input id="txtMemo" type="text" class="txt c1" /></td>
						<td class="td8"> </td>
						<td class="td9"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="tdA"><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr8">
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text"  class="txt c1"/></td>
						<td><input id="txtYear1" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAccno2" class="lbl btn"> </a></td>
						<td><input id="txtAccno2" type="text"  class="txt c1"/> </td>
						<td><input id="txtYear2" type="text"  class="txt c1"/> </td>
						<td></td>
						<td></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>

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
					<td align="center" style="width:100px;">登錄日期</td>
					<td align="center" style="width:80px;"><a id='lblCustno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblStraddr_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDiscount_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTolls_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:170px;"><a id='lblTranno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblRs_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPaymemo_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblFill_s'> </a></td>
					<td align="center" style="width:100px"><a id='lblCasetype_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCaseno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCaseno2_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblBoat_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblBoatname_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblShip_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOverweightcost_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblOthercost_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblOrdeno_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td ><input type="text" id="txtTrandate.*" style="width:95%;" /></td>
					<td ><input type="text" id="txtComp.*" style="width:95%;" /></td >
					<td >
					<input type="text" id="txtStraddr.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtProduct.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtMount.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtPrice.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtDiscount.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtMoney.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtTolls.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtMemo.*" style="width:95%;" />
					</td>
					<td >
						<input type="text" id="txtTranno.*" style="float:left; width: 90%;"/>
						<input type="text" id="txtTrannoq.*" style="float:left;visibility: hidden; width:1%"/>
					</td>
					<td >
					<input type="text" id="txtRs.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtPaymemo.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtFill.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCasetype.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCaseno.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtCaseno2.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtBoat.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtBoatname.*" style="width:95%;"/>
					</td>
					<td >
					<input type="text" id="txtShip.*" style="width:95%;" />
					</td>
					<td >
					<input type="text" id="txtOverweightcost.*" style="width:95%;text-align: right;"/>
					</td>
					<td >
					<input type="text" id="txtOthercost.*" style="width:95%;text-align: right;" />
					</td>
					<td >
					<input type="text" id="txtOrdeno.*" style="width:95%;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>