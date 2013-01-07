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

		    q_tables = 's';
		    var q_name = "fixa";
		    var q_readonly = ['txtNoa', 'txtWmoney', 'txtCmoney','txtMoney', 'txtTotal','txtWorker'];
		    var q_readonlys = ['txtMemo2'];
		    var bbmNum = new Array(['txtMiles', 10, 0],['txtDiscount', 10, 0], ['txtWmoney', 10, 0], ['txtCmoney', 10, 0], ['txtMoney', 10, 0], ['txtTax', 10, 0], ['txtTotal', 10, 0]);
		    var bbsNum = new Array(['txtPrice', 10, 1], ['txtMount', 10, 1], ['txtMoney', 10, 0]);
		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'Datea';
		    //ajaxPath = "";
		    aPop = new Array(
		    	['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'],
		    	['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], 
		    	['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtNick', 'tgg_b.aspx'], 
		    	['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
		    	['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2',  "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
		    	['txtCarplateno', 'lblCarplateno', 'carplate', 'noa,carplate,driver', 'txtCarplateno', 'carplate_b.aspx'], 
		    	['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea,unit,inprice', 'txtProductno_,txtProduct_,txtUnit_,txtPrice_', 'fixucc_b.aspx']);
		    q_desc = 1;
		    
		    function currentData() {}
			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				include : ['txtDatea','txtFixadate','txtTggno','txtTgg','txtNick'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in curData.include) {
							if (fbbm[i] == curData.include[j]) {
								isInclude = true;
								break;
							}
						}
						if (isInclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();
			
		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();
		        q_gt(q_name, q_content, q_sqlCount, 1);
		    });
		    //////////////////   end Ready
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(1);

		    } ///  end Main()

		    function pop(form) {
		        b_pop = form;
		    }

		    function mainPost() {
		        q_getFormat();
		        bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtFixadate', r_picd]];
		        q_mask(bbmMask);
		        q_cmbParse("cmbWtype", q_getPara('fixa.wtype'),'s');
		        $('#txtTax').change(function () {
		            sum();
		        });
		        $('#txtDiscount').change(function () {
		            sum();
		        });
		    }

		    function q_boxClose(s2) {
		        var ret;
		        switch (b_pop) {
		            case q_name + '_s':
		                q_boxClose2(s2);
		                ///   q_boxClose 3/4
		                break;
		        }   /// end Switch
		    }

		    function q_gtPost(t_name) {
		        switch (t_name) {
		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();

		                if (q_cur == 1 || q_cur == 2)
		                    q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);
		                break;
		        }  /// end switch
		    }

		    function btnOk() {
	            $('#txtDatea').val($.trim($('#txtDatea').val()));
	                if (checkId($('#txtDatea').val())==0){
	                	alert(q_getMsg('lblDatea')+'錯誤。');
	                	return;
	            }
				$('#txtMon').val($.trim($('#txtMon').val()));
					if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
						alert(q_getMsg('lblMon')+'錯誤。');   
						return;
				}
	            $('#txtFixadate').val($.trim($('#txtFixadate').val()));
	                if (checkId($('#txtFixadate').val())==0){
	                	alert(q_getMsg('lblFixadate')+'錯誤。');
	                	return;
	            }
 		        
		        $('#txtWorker').val(r_name);
		        t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
		        if (t_err.length > 0) {
		            alert(t_err);
		            return;
		        }
		        sum();
		        if($('#txtMon').val().length==0)
		        	$('#txtMon').val($('#txtDatea').val().substring(0,6));
		        var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_fixa') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;

		        q_box('fixa_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
		    }

		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		            	$('#lblNo_'+i).text(i+1);
		                $('#cmbWtype_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtMount_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtPrice_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtMoney_' + i).change(function (e) {
		                    sum();
		                });
		                //$('#txtMemo_' + i).data('info', { index: i });
		                $('#txtMemo_' + i).change(function (e) {
		                    if ($.trim($(this).val()).substring(0, 1) == '.')
		                        $('#txtMoney_' + i).removeAttr('readonly');
		                    else
		                        $('#txtMoney_' + i).attr('readonly', 'readonly');
		                    sum();
		                });
		                $('#txtMemo_' + i).change();
		            }
		        }
		        _bbsAssign();
		    }

		    function btnIns() {
		        curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                if($('#txtDatea').val().length==0)
               		$('#txtDatea').val(q_date());
		        $('#txtFixadate').focus();
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
		            return;
		        _btnModi();
		        $('#txtFixadate').focus();
		        sum();
		    }

		    function btnPrint() {

		    }

		    function wrServer(key_value) {
		        var i;
		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
		    }

		    function bbsSave(as) {
		        if (!as['productno'] && !as['product']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        as['date'] = abbm2['date'];
		        return true;
		    }
		    function q_popPost(t_id) {
		    	if((q_cur==1  ||  q_cur==2) && t_id.substring(0,13).toUpperCase()=='TXTPRODUCTNO_'){
		    		sum();
		    		
		    	}
            }

		    function sum() {
		    	if(!(q_cur==1 || q_cur==2))
		    		return;
		        var t_mount, t_price, t_money = 0, t_wmoney = 0, t_cmoney = 0, t_tax,t_discount;
		        for (var j = 0; j < q_bbsCount; j++) {
		            if ($.trim($('#txtMemo_' + j).val()).substring(0, 1) != '.') {
						t_mount = q_float('txtMount_' + j);
						t_price = q_float('txtPrice_' + j);
						t_money = Math.round(t_mount * t_price, 0);
		                $('#txtMoney_' + j).val(t_money);
		            } else {
		                t_money = q_float('txtMoney_' + j);
		            }
		            t_wmoney = t_wmoney + ($('#cmbWtype_' + j).val() == 'A' ? t_money : 0);
		            t_cmoney = t_cmoney + ($('#cmbWtype_' + j).val() == 'B' ? t_money : 0);
		        }
		        t_tax = q_float('txtTax');
		        t_discount = q_float('txtDiscount');
		        $('#txtWmoney').val(t_wmoney);
		        $('#txtCmoney').val(t_cmoney);
		        $('#txtMoney').val(t_wmoney + t_cmoney);
		        $('#txtTax').val(t_tax);
		        $('#txtTotal').val(Math.round(t_wmoney + t_cmoney + t_tax - t_discount, 0));
		    }

		    function refresh(recno) {
		        _refresh(recno);

		    }

		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		        for (var i = 0; i < q_bbsCount; i++) {
		            if ($.trim($('#txtMemo_' + i).val()).substring(0, 1) == '.')
		                $('#txtMoney_' + i).removeAttr('readonly');
		            else
		                $('#txtMoney_' + i).attr('readonly', 'readonly');
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
                width: 35%;
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
                width: 60%;
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
                width: 10%;
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
            .tbbs input[type="text"] {
                width: 95%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }

		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:15%"><a id='vewFixadate'> </a></td>
						<td align="center" style="width:15%"><a id='vewCarno'> </a></td>
						<td align="center" style="width:15%"><a id='vewDriver'> </a></td>
						<td align="center" style="width:15%"><a id='vewCarplateno'> </a></td>
						<td align="center" style="width:15%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='fixadate'>~fixadate</td>
						<td align="center" id='carno'>~carno</td>
						<td align="center" id='driver'>~driver</td>
						<td align="center" id='carplateno'>~carplateno</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm" >
					<tr class="tr1">
						
						<td class="td5"><span> </span><a id="lblFixadate" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtFixadate" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtMon" type="text" class="txt c1"/>
						</td>
						<td class="tdZ"> </td>  
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtCarno" type="text" class="txt c1"/>
						</td>
						<td class="td1"><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td class="td2">
						<input id="txtDriverno" type="text" class="txt c2"/>
						<input id="txtDriver" type="text" class="txt c3"/>
						</td> 
						
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td3"><span> </span><a id="lblCarplateno" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtCarplateno" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblMiles" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtMiles" type="text" class="txt c1 num"/>
						</td>
						
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblAcc1" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtAcc1" type="text" class="txt"  style="width:25%;"/>
						<input id="txtAcc2" type="text" class="txt" style="width:75%;"/></td>
						<td class="td3"><span> </span><a id="lblInvono" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtInvono" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr3">
						<td class="td3"><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td4" colspan="3">
						<input id="txtTggno" type="text" class="txt"  style="width:25%;"/>
						<input id="txtTgg" type="text" class="txt" style="width:75%;"/>
						<input id="txtNick" type="text" class="txt" style="display: none;"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtCno" type="text" class="txt" style="width:25%;"/>
						<input id="txtAcomp" type="text" class="txt" style="width:75%;"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblWmoney" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtWmoney" type="text" class="txt num c1" />
						</td>
						<td class="td3"><span> </span><a id="lblCmoney" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtCmoney" type="text" class="txt num c1" />
						</td>
						<td class="td5"><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtMoney" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr class="tr5">
						
						<td class="td1"><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td class="td2">
						<input id="txtTax" type="text" class="txt num c1" />
						</td>
						<td class="td3"><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td class="td4">
						<input id="txtDiscount" type="text" class="txt num c1" />
						</td>
						<td class="td5"><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td class="td6">
						<input id="txtTotal" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtMemo" type="text" class="txt c1" /></td>
						<td class="td3"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:3%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:50px;"><a id='lblWtype_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMemo2_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><select id="cmbWtype.*" class="txt c1"> </select></td>
					<td>
					<input class="txt" id="txtProductno.*" type="text" style="width:25%;"/>
					<input class="txt" id="txtProduct.*"type="text" style="width:55%;"/>
					<input id="btnProductno.*" type="button" value="..." style="width: 10%;" />
					</td>
					<td>
					<input class="txt c1" id="txtUnit.*" type="text" style="text-align: center;"/>
					</td>
					<td>
					<input class="txt num c1" id="txtMount.*" type="text" />
					</td>
					<td>
					<input class="txt num c1" id="txtPrice.*" type="text" />
					</td>
					<td>
					<input class="txt num c1" id="txtMoney.*" type="text" />
					</td>
					<td>
					<input class="txt c1" id="txtMemo.*" type="text" />
					<input id="txtNoq.*" type="hidden" />
					</td>
					<td>
					<input class="txt c1" id="txtMemo2.*" type="text" />
					</td>
				</tr>
				
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
