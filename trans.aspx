<%@ Page Language="C#" AutoEventWireup="true" %>
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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            var q_name = "trans";
            var q_readonly = ['txtNoa','txtTotal','txtTotal2','txtTrdno','txtWorkerno','txtWorker'];
            var bbmNum = new Array(['txtUnpack', 10, 0], ['txtMount', 10, 3], ['txtPrice', 10, 3], ['txtPrice2', 10, 3], ['txtTolls', 10, 0], ['txtPrice3', 10, 3], ['txtDiscount', 10, 3], ['txtMiles', 10, 2], ['txtReserve', 10, 0], ['txtWeight', 10, 2], ['txtPlus', 10, 0], ['txtMinus', 10, 0], ['txtMount2', 10, 3], ['txtTotal', 10, 0], ['txtOverw', 10, 0], ['txtTotal2', 10, 0], ['txtCommission', 10, 0], ['txtGps', 10, 0], ['txtPton', 10, 2], ['txtPton2', 10, 2], ['txtOverh', 10, 0], ['txtOverw', 10, 0]);
            var bbmMask = new Array(['txtTrandate', '999/99/99'], ['txtDatea', '999/99/99'], ['txtBilldate', '999/99/99'],['txtCldate', '999/99/99']);
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
          //  q_alias = 'a';
            q_desc = 1;
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver,cardealno,cardeal','txtCarno,txtDriverno,txtDriver,txtCardealno,txtCardeal', 'car2_b.aspx'], 
            ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
            ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'],
            ['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx'],
            ['txtStraddrno', 'lblStraddr', 'addr', 'noa,addr,productno,product,custprice,driverprice,driverprice2,discount,commission', 'txtStraddrno,txtStraddr,txtUccno,txtProduct,txtPrice,txtPrice2,txtPrice3,txtDiscount,txtCommission', 'addr_b2.aspx'],
            ['txtAddno3', 'lblAdd3', 'addr', 'noa,addr', 'txtAddno3,txtAdd3', 'addr_b2.aspx'],
            ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
            ['txtSales', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
				
				$("#cmbCalctype").data('info',{item:new Array()});
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            
            function currentData(){
            	var exclude = new Array('txtNoa','txtNoq','txtWorker','txtTrdno','txtTreno');
            	var data = new Array();
            }
            currentData.prototype = {
            	copy : function(){
            		curData.data = new Array();
            		for( var i in fbbm){
            			var isExclude = false;
            			for(var j in curData.exclude){
            				if(fbbm[i]==curData.exclude[j]){
            					isExclude = true;
            					break;	
            				}
            			}
            			if(!isExclude){
            				curData.data.push({
            					field : fbbm[i],
            					value : $('#'+fbbm[i]).val()
            				});
            			}
            		}
        		},
            	paste : function(){
            		for(var i in curData.data){
            			$('#'+curData.data[i].field).val(curData.data[i].value);
            		}
            	},
            	isOutside : function(){
            		var t_noa = $("#cmbCalctype").val();
					var t_isOutside = 0;
					for(var i in $("#cmbCalctype").data('info').item){				
						if($("#cmbCalctype").data('info').item[i].noa == t_noa){		
							t_isOutside = $("#cmbCalctype").data('info').item[i].isOutside;
							break;	
						}
					}
					return t_isOutside;
            	}
        	};
            var curData = new currentData();

            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                
                mainForm(0);

            }
		
            function mainPost() {
            	q_mask(bbmMask);
                q_gt('calctype', '', 0, 0, 0, "");
                q_gt('carteam', '', 0, 0, 0, "");
                q_cmbParse("cmbCasetype", "20'',40''");
				$("#cmbCalctype").change(function() {
                    if(curData.isOutside()) {
                        $("#lblPrice2").hide();
                        $("#txtPrice2").hide();
                        $("#lblPrice3").show();
                        $("#txtPrice3").show();
                    } else {
                        $("#lblPrice3").hide();
                        $("#txtPrice3").hide();
                        $("#lblPrice2").show();
                        $("#txtPrice2").show();
                    }
                    sum();
                }).click(function() {
                    if(curData.isOutside()) {
                        $("#lblPrice2").hide();
                        $("#txtPrice2").hide();
                        $("#lblPrice3").show();
                        $("#txtPrice3").show();
                    } else {
                        $("#lblPrice3").hide();
                        $("#txtPrice3").hide();
                        $("#lblPrice2").show();
                        $("#txtPrice2").show();
                    }
                    sum();
                }); 
                $("#cmbCalctype").focus(function(){
                	var len = $("#cmbCalctype").children().length>0?$("#cmbCalctype").children().length:1;
                	$("#cmbCalctype").attr('size',len+"");
                }).blur(function(){
                	$("#cmbCalctype").attr('size','1');
                });              
                $("#cmbCarteamno").focus(function(){
                	var len = $("#cmbCarteamno").children().length>0?$("#cmbCarteamno").children().length:1;
                	$("#cmbCarteamno").attr('size',len+"");
                }).blur(function(){
                	$("#cmbCarteamno").attr('size','1');
                });
                $("#cmbCasetype").focus(function(){
                	var len = $("#cmbCasetype").children().length>0?$("#cmbCasetype").children().length:1;
                	$("#cmbCasetype").attr('size',len+"");
                }).blur(function(){
                	$("#cmbCasetype").attr('size','1');
                }); 
                
                $('#txtBmiles').change(function(){
                	var bmiles = $.trim($('#txtBmiles').val()).length==0?0:parseInt($.trim($('#txtBmiles').val()),10);
					var emiles = $.trim($('#txtEmiles').val()).length==0?0:parseInt($.trim($('#txtEmiles').val()),10);
					if( bmiles==0 && emiles==0){
						$('#txtMiles').removeAttr('readonly');
					}else{
						$('#txtMiles').attr('readonly', 'readonly');
					}
					sum();
                });
                $('#txtEmiles').change(function(){
                	var bmiles = $.trim($('#txtBmiles').val()).length==0?0:parseInt($.trim($('#txtBmiles').val()),10);
					var emiles = $.trim($('#txtEmiles').val()).length==0?0:parseInt($.trim($('#txtEmiles').val()),10);
					if( bmiles==0 && emiles==0){
						$('#txtMiles').removeAttr('readonly');
					}else{
						$('#txtMiles').attr('readonly', 'readonly');
					}
					sum();
                }); 
                $("#txtMount").change(function() {
                    sum();
                });
                $("#txtPrice").change(function() {
                    sum();
                });
                $("#txtMount2").change(function() {
                    sum();
                });
                $("#txtPrice2").change(function() {
                    sum();
                });
                $("#txtPrice3").change(function() {
                    sum();
                });
                $("#txtDiscount").change(function() {
                    sum();
                });              
            }

            function sum() {
            	if($('#txtDiscount').val().length==0){
            		$('#txtDiscount').val('1');
            	}
            	var t_mount = $.trim($('#txtMount').val()).length==0?0:parseFloat($.trim($('#txtMount').val().replace(/,/g,'')),10);
            	var t_price = $.trim($('#txtPrice').val()).length==0?0:parseFloat($.trim($('#txtPrice').val().replace(/,/g,'')),10);
            	$("#txtTotal").val(Math.round(t_mount * t_price,0));
                
                var t_discount = $.trim($('#txtDiscount').val()).length==0?0:parseFloat($.trim($('#txtDiscount').val().replace(/,/g,'')),10);
				t_mount = $.trim($('#txtMount2').val()).length==0?0:parseFloat($.trim($('#txtMount2').val().replace(/,/g,'')),10);
				if(curData.isOutside())
					t_price = $.trim($('#txtPrice3').val()).length==0?0:parseFloat($.trim($('#txtPrice3').val().replace(/,/g,'')),10);      
				else
            		t_price = $.trim($('#txtPrice2').val()).length==0?0:parseFloat($.trim($('#txtPrice2').val().replace(/,/g,'')),10);            
                $("#txtTotal2").val(Math.round(t_mount * t_price * t_discount,0));
                
            	var bmiles = $.trim($('#txtBmiles').val()).length==0?0:parseInt($.trim($('#txtBmiles').val().replace(/,/g,'')),10);
				var emiles = $.trim($('#txtEmiles').val()).length==0?0:parseInt($.trim($('#txtEmiles').val().replace(/,/g,'')),10);
				if(bmiles!=0 && emiles!=0)
					$('#txtMiles').val(emiles-bmiles);
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
                	case 'calctype':
                        var as = _q_appendData("calctype", "", true);
						var t_item = "";
                        var item = new Array();
                        for( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length>0?',':'') + as[i].noa +'@' + as[i].typea;
                        	item.push({
                        		noa : as[i].noa,
                        		typea : as[i].typea,
                        		isOutside : as[i].isoutside.length==0?false:(as[i].isoutside=="false" || as[i].isoutside=="0" || as[i].isoutside=="undefined"?false:true)
                        	});
                        }
                        q_cmbParse("cmbCalctype", t_item);                   

                        $("#cmbCalctype").data("info").item = item;
                        break;
                    case 'carteam':
                        var as = _q_appendData("carteam", "", true);
						var t_item = "";
                        for( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length>0?',':'') + as[i].noa +'@' + as[i].team;
                        }
                        q_cmbParse("cmbCarteamno", t_item);                   
                        break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();

                        if(q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)
                    return;

                q_box('trans_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
            }

            function btnIns() {
                curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                $('#txtNoq').val('001');
                $('#txtDatea').val(q_date());
                sum();
               
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;

                _btnModi();
                sum();
                $('#txtDatea').focus();
            }

            function btnPrint() { 

            }

            function btnOk() {
				$('#txtWorker').val(r_name);			
                if(curData.isOutside())
                    $("#txtPrice2").val(0);
                else
                    $("#txtPrice3").val(0);
				sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);

                if(curData.isOutside()) {
                    $("#lblPrice2").hide();
                    $("#txtPrice2").hide();
                    $("#lblPrice3").show();
                    $("#txtPrice3").show();
                } else {
                    $("#lblPrice3").hide();
                    $("#txtPrice3").hide();
                    $("#lblPrice2").show();
                    $("#txtPrice2").show();
                }       
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                var bmiles = $.trim($('#txtBmiles').val()).length==0?0:parseInt($.trim($('#txtBmiles').val()),10);
				var emiles = $.trim($('#txtEmiles').val()).length==0?0:parseInt($.trim($('#txtEmiles').val()),10);
				if( bmiles==0 && emiles==0){
					$('#txtMiles').removeAttr('readonly');
				}else{
					$('#txtMiles').attr('readonly', 'readonly');
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
            
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 20%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: 16px;
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
                width: 78%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                /*border: 1px white double;
                 border-spacing: 0;
                 border-collapse: collapse;*/
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm td {
                width: 5%;
            }
            .tbbm .tdZ {
                width: 2%;
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
                font-size: 16px;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .tbbm tr td .txt.c1 {
                width: 100%;
                float: left;
            }
            .tbbm tr td .txt.c2 {
                width: 45%;
                float: left;
            }
            .tbbm tr td .txt.c3 {
                width: 55%;
                float: left;
            }
            .tbbm tr td .txt.c4 {
                width: 60%;
                float: left;
            }
            .tbbm tr td .txt.c5 {
                width: 40%;
                float: left;
            }
            .tbbm tr td .txt.num {
                text-align: right;
            }
          	
            .txt.num {
                text-align: right;
            }
            td {
                margin: 0px -1px;
                padding: 0;
            }
            td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
            }
            input[type="text"],input[type="button"] {
                font-size:medium;
            }
            input[readonly="readonly"]#txtMiles{
            	color:green;
            }
            
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%;"><a id='vewChk'> </a></td>
						<td align="center" style="width:17%;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:10%;"><a id='vewComp'> </a></td>
						<td align="center" style="width:15%;"><a id='vewCarno'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='comp,2'>~comp,2</td>
						<td align="center" id='carno'>~carno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm" >
					<tr name="schema" style="height:0px;">
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
						<td class="tdB"><span class="schema"> </span></td>
						<td class="tdC"><span class="schema"> </span></td>
						<td class="tdD"><span class="schema"> </span></td>
						<td class="tdE"><span class="schema"> </span></td>
						<td class="tdF"><span class="schema"> </span></td>
						<td class="tdG"><span class="schema"> </span></td>
						<td class="tdZ"><span class="schema"> </span></td>
					</tr>
					<tr class="tr1">
						<td class="td1" colspan="2"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtTrandate" type="text"  class="txt c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtCarno" type="text"  class="txt c1"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtDriverno" type="text"  class="txt c2"/>
						<input id="txtDriver" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1" colspan="2"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td class="td3" colspan="6">
						<input id="txtCustno" type="text"  style='width:25%; float:left;'/>
						<input id="txtComp" type="text"  style='width:75%; float:left;'/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblCalctype" class="lbl"> </a></td>
						<td class="tdB" colspan="2"><select id="cmbCalctype" class="txt c1"> </select></td>
						<td class="tdD" colspan="2"><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td class="tdF" colspan="2"><select id="cmbCarteamno" class="txt c1"> </select></td>
					</tr>
					<tr class="tr3">
						<td class="td1" colspan="2"><span> </span><a id="lblStraddr" class="lbl btn"> </a></td>
						<td class="td3" colspan="6">
						<input id="txtStraddrno" type="text"  class="txt c2"/>
						<input id="txtStraddr" type="text"  class="txt c3"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblUcc" class="lbl btn"> </a></td>
						<td class="tdB" colspan="4">
						<input id="txtUccno" type="text"  class="txt c2"/>
						<input id="txtProduct" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1" colspan="2"><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtMount" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtPrice" type="text"  class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtTotal" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1" colspan="2"><span> </span><a id="lblMount2" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtMount2" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" colspan="2">
							<span> </span><a id="lblPrice2" class="lbl"> </a>
							<a id="lblPrice3" class="lbl"> </a>
						</td>
						<td class="td7" colspan="2">
						<input id="txtPrice2" type="text"  class="txt num c1"/>
						<input id="txtPrice3" type="text"  class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtDiscount" type="text" class="txt num c1"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblTotal2" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtTotal2" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1" colspan="2"><span> </span><a id="lblPton" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtPton" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblPton2" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtPton2" type="text"  class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblGross" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtGross" type="text"  class="txt num c1"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtWeight" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="tr7">
						<td class="td1" colspan="2"><span> </span><a id="lblCaseno" class="lbl"> </a></td>
						<td class="td3" colspan="6">
						<input id="txtCaseno" type="text"  style='width:50%; float:left;'/>
						<input id="txtCaseno2" type="text"  style='width:50%; float:left;'/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblCaseuse" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtCaseuse" type="text" class="txt c1"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblCasetype" class="lbl"> </a></td>
						<td class="tdF" colspan="2"><select id="cmbCasetype" class="txt c1"> </select></td>
					</tr>
					<tr class="tr8">
						<td class="td1" colspan="2"><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td class="td3" colspan="4">
						<input id="txtPo" type="text"  class="txt c1"/>
						</td>
						<td class="td7" colspan="2"><span> </span><a id="lblCustorde" class="lbl"> </a></td>
						<td class="td9" colspan="3">
						<input id="txtCustorde" type="text"  class="txt c1"/>
						</td>	
						<td class="tdC" colspan="2"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="tdE" colspan="3">
						<input id="txtNoa" type="text"  class="txt c1"/>
						<input id="txtNoq" type="text"  style="display: none;"/>
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1" colspan="2"><span> </span><a id="lblTolls" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtTolls" type="text" class="txt num c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblReserve" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtReserve" type="text" class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblPlus" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtPlus" type="text"  class="txt c1 num"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblMinus" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtMinus" type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr class="tr9">
						<td class="td1" colspan="2"><span> </span><a id="lblBmiles" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtBmiles" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblEmiles" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtEmiles" type="text"  class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblMiles" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtMiles" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="trA">
						<td class="td1" colspan="2"><span> </span><a id="lblLtime" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtLtime" type="text"  class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblStime" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtStime" type="text"  class="txt c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblDtime" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtDtime" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="trB">
						<td class="td1" colspan="2"><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
						<td class="td3" colspan="5">
						<input id="txtCardealno" type="text"  style='width:25%; float:left;'/>
						<input id="txtCardeal" type="text"  style='width:75%; float:left;'/>
						</td>
						<td class="td8" colspan="2"><span> </span><a id="lblAdd3" class="lbl btn"> </a></td>
						<td class="tdA" colspan="3">
						<input id="txtAddno3" type="text" class="txt c2"/>
						<input id="txtAdd3" type="text"  class="txt c3"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblGps" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtGps" type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr class="trC">
						<td class="td1" colspan="2"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtSalesno" type="text"  class="txt c2"/>
						<input id="txtSales" type="text"  class="txt c3"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblThird" class="lbl"> </a> </td>
						<td class="td7" colspan="2">
						<input id="txtThird" type="text" class="txt num c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblThirdprice" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtThirdprice" type="text" class="txt num c1" />
						</td>
					</tr>	
					<tr class="trD">
						<td class="td1" colspan="2"><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtOrdeno" type="text"  class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblSo" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtSo" type="text"  class="txt c1"/>
						</td> 
						<td class="td9" colspan="2"><span> </span><a id="lblTraceno" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtTraceno" type="text"  class="txt c1"/>
						</td>
						<td class="tdD" colspan="2"><span> </span><a id="lblUnpack" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtUnpack" type="text"  class="txt num c1"/>
						</td>
					</tr>		
					<tr class="trE">
						<td class="td1" colspan="2"><span> </span><a id="lblCldate" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtCldate" type="text" class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblBilldate" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtBilldate" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="trF">
						<td class="td1" colspan="2"><span> </span><a id="lblFill" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtFill" type="text"  class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblCaseend" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtCaseend" type="text" class="txt c1"/>
						</td>
						<td class="td9" colspan="2"><span> </span><a id="lblStatus" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtStatus" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="trG">
						<td class="td1" colspan="2"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="14">						
							<input id="txtMemo" type="text" class="txt c1"/> 
						</td>
					</tr>
					<tr class="trH">
						<td class="td1" colspan="2"><span> </span><a id="lblOverw" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtOverw" type="text"  class="txt num c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblOverh" class="lbl"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtOverh" type="text"  class="txt num c1"/>
						</td>	
						<td class="td9" colspan="2"><span> </span><a id="lblCommission" class="lbl"> </a></td>
						<td class="tdB" colspan="2">
						<input id="txtCommission" type="text" class="txt num c1"/>
						</td>
					</tr>
					<tr class="trI">
						<td class="td1" colspan="2"><span> </span><a id="lblTrdno" class="lbl"> </a></td>
						<td class="td3" colspan="2">
						<input id="txtTrdno" type="text" class="txt c1"/>
						</td>
						<td class="td5" colspan="2"><span> </span><a id="lblTreno" class="lbl" style="font-size: 12px;"> </a></td>
						<td class="td7" colspan="2">
						<input id="txtTreno" type="text"  class="txt c1"/>
						</td>
						<td class="td9" colspan="4"> </td>
						<td class="tdD" colspan="2"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="tdF" colspan="2">
						<input id="txtWorker" type="text"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
