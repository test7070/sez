<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
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

            var q_name = "oil";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtMoney', 'txtCurmount', 'txtCurmoney', 'txtBmiles', 'txtMiles', 'txtRate'];
            var bbmNum = new Array(['txtBmiles', 10, 0], ['txtEmiles', 10, 0], ['txtMiles', 10, 0], ['txtRate', 10, 2], ['txtMount', 10, 2], ['txtPrice', 10, 2], ['txtMoney', 10, 0], ['txtCurmount', 10, 2], ['txtCurmoney', 10, 2]);
            var bbmMask = [['txtDatea', '999/99/99'], ['txtOildate', '999/99/99'], ['txtTimea', '99:99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            
            q_xchg = 1;
            brwCount2 = 20;

            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            , ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtOilstationno', 'lblOilstation', 'oilstation', 'noa,station', 'txtOilstationno,txtOilstation', 'oilstation_b.aspx']);

            function currentData() {
            }
            currentData.prototype = {
                data : [],
                /*新增時複製的欄位*/
                include : ['txtDatea', 'txtOildate', 'txtPrice', 'txtOilstationno', 'txtOilstation', 'cmbProduct', 'txtPrice'],
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

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }///  end Main()

            function mainPost() {
            	q_modiDay= q_getPara('sys.modiday2');  /// 若未指定， d4=  q_getPara('sys.modiday');
                q_mask(bbmMask);
                q_cmbParse("cmbProduct", q_getPara('oil.product'));
                $('#cmbProduct').focus(function() {
                    var len = $("#cmbProduct").children().length > 0 ? $("#cmbProduct").children().length : 1;
                    $("#cmbProduct").attr('size', len + "");
                }).blur(function() {
                    $("#cmbProduct").attr('size', '1');
                });
                $('#txtMount').change(function() {
                    sum();
                });
                $('#txtPrice').change(function() {
                    sum();
                });
                $('#chkIscustom2').click(function() {
                	if($('#chkIscustom2').prop('checked')){
                		$('#txtMoney').removeAttr('readonly').css('background-color', 'white').css('color', 'black');
                	}else{
                		$('#txtMoney').attr('readonly', 'readonly').css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
                        sum();
                	}
                });
                $('#chkIscustom').change(function(e) {
                    if ($('#chkIscustom').prop('checked')) {
                        $('#txtMiles').removeAttr('readonly').css('color', 'black').css('background-color', 'white');
                    }
                });
                $('#txtEmiles').change(function() {
                    sum();
                });
                $('#txtMiles').change(function() {
                    sum();
                });
                $('#lblBmiles').click(function(e) {
                    if (q_cur == 1 || q_cur == 2)
                        q_popPost('txtCarno');
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
                    case 'oil_top':
                        var as = _q_appendData("oil", "", true);
                        if (as[0] != undefined) {
                            $('#txtBmiles').val(as[0].emiles);
                            sum();
                        }
                        break;
                    case 'oilorg':
                        var as = _q_appendData("oilorg", "", true);
                        if (as[0] != undefined) {
                            var t_mount = 0, t_money = 0;
                            for ( i = 0; i < as.length; i++) {
                                t_mount += parseFloat(as[i].mount) * 1000;
                                t_money += parseFloat(as[i].money);
                            }
                            t_mount = t_mount / 1000;
                            $("#txtCurmount").addClass('finish');
                            $("#txtCurmount").val(t_mount);
                            $("#txtCurmoney").addClass('finish');
                            $("#txtCurmoney").val(FormatNumber(t_money));
                            t_where = " where=^^ noa='" + $('#txtOilstationno').val() + "' ^^ ";
                            q_gt('oilstation', t_where, 0, 0, 0, "", r_accy);
                        }
                        break;
                    case 'oilstation':
                        var as = _q_appendData("oilstation", "", true);
                        if (as[0] != undefined) {
                            if (as[0].isl == 'false') {
                                $("#txtCurmount").val('');
                                $("#txtCurmount").data('isl', false);
                            } else
                                $("#txtCurmount").data('isl', true);

                            if (as[0].ism == 'false') {
                                $("#txtCurmoney").val('');
                                $("#txtCurmoney").data('isl', false);
                            } else
                                $("#txtCurmoney").data('ism', true);
                            sum();
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        if (q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }
            }

            function q_popPost(id) {
                switch(id) {
                    case 'txtCarno':
                        var t_carno = $.trim($('#txtCarno').val());
                        var t_datea = $.trim($('#txtOildate').val());
                        var t_noa = $.trim($('#txtNoa').val());
                        var t_timea = $.trim($('#txtTimea').val());
                        if (t_carno.length > 0 && t_datea.length > 0) {
                            t_where = " where=^^ noa!='" + t_noa + "' and carno='" + t_carno + "' and oildate<='" + t_datea + "' and not(oildate='" + t_datea + "' and timea>'" + t_timea + "')^^ ";
                            q_gt('oil_top', t_where, 0, 0, 0, "", r_accy);
                        }
                        $('#txtDriverno').focus();
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('oil_s.aspx', q_name + '_s', "600px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').focus();
                $('#chkIscustom').prop('checked', false);
                $('#chkIscustom2').prop('checked', false);
                $('#txtOrgmount').val($('#txtMount').val());
                $('#txtOrgmoney').val($('#txtMoney').val());
                if ($('#txtOilstationno').val().length > 0)
                    q_gt('oilorg', "where=^^oilstationno='" + $.trim($('#txtOilstationno').val()) + "'^^", 0, 0, 0, "");
                sum();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
          		if (q_chkClose())
             		    return;
                _btnModi();
                $('#txtDatea').focus();
                $('#txtOrgmount').val($('#txtMount').val());
                $('#txtOrgmoney').val($('#txtMoney').val());
                sum();
            }

            function btnPrint() {
                q_box(location.href.replace('oil.aspx','z_oil.aspx'), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
                $('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val()) == 0) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if (!q_cd($('#txtOildate').val())) {
                    alert(q_getMsg('lblOildate') + '錯誤。');
                    return;
                }
                if ($('#txtTimea').val().length > 0 && !(/(?:[01][0-9]|2[0-3]):[0-5][0-9]/g).test($('#txtTimea').val())) {
                    alert(q_getMsg('lblTimea') + '錯誤。');
                    return;
                }
                $('#txtWorker').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                if(!$('#chkIscustom2').prop('checked')){
                    sum();
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_oil') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                $("#txtCurmount").removeClass('finish');
                $("#txtCurmoney").removeClass('finish');
                if ($('#txtOilstationno').val().length > 0)
                    q_gt('oilorg', "where=^^oilstationno='" + $.trim($('#txtOilstationno').val()) + "'^^", 0, 0, 0, "");
                if (q_cur == 1 || q_cur == 2) {
                    if ($('#chkIscustom').prop('checked')) {
                        $('#txtMiles').removeAttr('readonly').css('color', 'black').css('background-color', 'white');
                    }
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if ((q_cur == 1 || q_cur == 2) && $('#chkIscustom2').prop('checked')) {
                    $('#txtMoney').removeAttr('readonly').css('background-color', 'white').css('color', 'black');
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
                q_modiDay= q_getPara('sys.modiday2');  /// 若未指定， d4=  q_getPara('sys.modiday'); 
			
          		if (q_chkClose())
             		    return;
			
			_btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                //alert($("#txtCurmount").data('isl')+' '+$("#txtCurmoney").data('ism'));
                var t_bmiles = q_float('txtBmiles');
                var t_emiles = q_float('txtEmiles');
                var t_miles = q_float('txtMiles');
                var t_mount = q_float('txtMount');
                var t_orgmount = q_float('txtOrgmount');
                var t_curmount = q_float('txtCurmount');
                var t_price = q_float('txtPrice');
                //---------------------------------------------------------------------------------
                if (!$('#chkIscustom').prop('checked')) {
                    t_miles = t_emiles.sub(t_bmiles).round(0);
                    $('#txtMiles').val(FormatNumber(t_miles));
                }
                t_rate = t_mount == 0 ? 0 : t_miles.div(t_mount).round(2);
                $('#txtRate').val(t_rate);

                if ($("#txtCurmount").data('isl') && $("#txtCurmount").hasClass('finish') && (q_cur == 1 || q_cur == 2)) {
                    $('#txtCurmount').val(FormatNumber(t_curmount.add(t_orgmount).sub(t_mount)));
                    $('#txtOrgmount').val(FormatNumber(t_mount));
                }
                if (!$('#chkIscustom2').prop('checked')) {
                    $("#txtMoney").val(FormatNumber((t_mount.mul(t_price)).round(0)));
                }
                var t_money = q_float('txtMoney');
                var t_orgmoney = q_float('txtOrgmoney');
                var t_curmoney = q_float('txtCurmoney');
                if ($("#txtCurmoney").data('ism') && $("#txtCurmoney").hasClass('finish') && (q_cur == 1 || q_cur == 2)) {
                    $('#txtCurmoney').val(FormatNumber(t_curmoney.add(t_orgmoney).sub(t_money)));
                    $('#txtOrgmoney').val(FormatNumber(t_money));
                }
            }
            function q_popFunc(id, key_value) {
                switch(id) {
                    case 'txtOilstationno':
                        if (key_value > 0)
                            q_gt('oilorg', "where=^^oilstationno='" + $.trim(key_value) + "'^^", 0, 0, 0, "");

                        break;
                }
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
                } else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 3;
                } else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
                    str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 4
                }
                return 0;
                //錯誤
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
			Number.prototype.round = function(arg) {
			    return Math.round(this * Math.pow(10,arg))/ Math.pow(10,arg);
			}
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			}
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""))
			        r2 = Number(arg2.toString().replace(".", ""))
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			}
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length } catch (e) { }
			    try { m += s2.split(".")[1].length } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			}
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2))
			    return (arg1 * m + arg2 * m) / m
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			}
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((arg1 * m - arg2 * m) / m).toFixed(n));
			}

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 1000px;
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
                width: 1000px;
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
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 20%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
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
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewOilstation'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewPrice'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewMount'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewBmiles'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewEmiles'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewMiles'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewRate'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='carno' style="text-align: center;">~carno</td>
						<td id='driver' style="text-align: center;">~driver</td>
						<td id='oilstation' style="text-align: center;">~oilstation</td>
						<td id='price' style="text-align: right;">~price</td>
						<td id='mount' style="text-align: right;">~mount</td>
						<td id='money,0,1' style="text-align: right;">~money,0,1</td>
						<td id='bmiles,0,1' style="text-align: right;">~bmiles,0,1</td>
						<td id='emiles,0,1' style="text-align: right;">~emiles,0,1</td>
						<td id='miles,0,1' style="text-align: right;">~miles,0,1</td>
						<td id='rate' style="text-align: right;">~rate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height: 1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtNoa"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOildate' class="lbl"> </a></td>
						<td>
						<input id="txtOildate"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTimea' class="lbl"> </a></td>
						<td>
						<input id="txtTimea"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblIscustom' class="lbl"> </a></td>
						<td>
						<input id="chkIscustom"  type="checkbox"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td>
						<input id="txtCarno"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblBmiles' class="lbl" title="按一下可重新載入。"> </a></td>
						<td>
						<input id="txtBmiles"  type="text"  class="txt c1 num" />
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDriver' class="lbl btn"> </a></td>
						<td class="td2" >
						<input id="txtDriverno"  type="text"  class="txt c2"/>
						<input id="txtDriver"  type="text"  class="txt c3"/>
						</td>
						<td><span> </span><a id='lblEmiles' class="lbl"> </a></td>
						<td>
						<input id="txtEmiles"  type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblOilstation' class="lbl btn"> </a></td>
						<td class="td2">
						<input id="txtOilstationno"  type="text"  class="txt c2"/>
						<input id="txtOilstation"  type="text"  class="txt c3"/>
						</td>
						<td><span> </span><a id='lblMiles' class="lbl"> </a></td>
						<td>
						<input id="txtMiles"  type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblProduct' class="lbl"> </a></td>
						<td class="td2"><select id="cmbProduct" class="txt c1"></select></td>
						<td><span> </span><a id='lblRate' class="lbl"> </a></td>
						<td>
						<input id="txtRate"  type="text"  class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtPrice"  type="text"  class="txt num c1"/>
						</td>
						<td class="td3"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtMount"  type="text"  class="txt num c1"/>
						<input id="txtOrgmount"  type="text"  style="display: none;"/>
						</td>
						<td class="td3"><span> </span><a id='lblCurmount' class="lbl"> </a></td>
						<td class="td4">
						<input id="txtCurmount"  type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtMoney"  type="text"  class="txt num c1"/>
						<input id="txtOrgmoney"  type="text"  style="display: none;"/>
						</td>
						<td class="td3"><span> </span><a id='lblCurmoney' class="lbl"> </a></td>
						<td class="td4">
						<input id="txtCurmoney"  type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIscustom2' class="lbl"> </a></td>
						<td><input id="chkIscustom2"  type="checkbox"/> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtMemo"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtWorker"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"></td>
					</tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>
					<tr></tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
