<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
            var q_name = "transef";
            var q_readonly = ['txtNoa', 'txtOrdeno', 'txtWorker', 'txtWorker2', 'txtUnpack'];
            var bbmNum = [['txtPrice', 10, 0, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //q_xchg = 1;
            brwCount = 6;
            brwCount2 = 10;
            var string = decodeURIComponent(location.href);
            if (string.indexOf('\'all\'=\'all\'') >= 0) {
                //z_tran_ef10 用
                string = string.replace(/.*\'all\'=\'all\' and (\d*)=\d*.*/g, '$1');
                brwCount2 = parseInt(string);
            }
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'], ['txtComp', 'lblCust', 'cust', 'comp,noa,nick', '0txtComp,txtCustno,txtNick', 'cust_b.aspx']);
            /*aPop = new Array(['txtUccno','lblUcc','ucc','noa,product','txtUccno,txtProduct','ucc_b.aspx']
             ,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
             ,['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
             ,['txtCarno', 'lblCarno', 'car2', 'a.noa,driver,driverno', 'txtCarno,txtDriver,txtDriverno', 'car2_b.aspx']
             ,['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']
             ,['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
             ,['txtSaddr', '', 'view_road', 'memo', '0txtSaddr', 'road_b.aspx']
             ,['txtAaddr', '', 'view_road', 'memo', '0txtAaddr', 'road_b.aspx']);*/

            function sum() {
                if (q_cur != 1 && q_cur != 2)
                    return;
                var t_price = q_float('txtPrice');
                var t_price2 = q_float('txtPrice2');
                var t_price3 = q_float('txtPrice3');
                var t_total = round(t_price, 0);
                var t_total2 = round(q_add(t_price2, t_price3), 0);
                var t_unpack = q_float('txtTolls') + q_float('txtReserve') + q_float('txtOverh') + q_float('txtOverw') + q_float('txtCommission') + q_float('txtCommission2');
                $('#txtTotal').val(q_trv(t_total));
                $('#txtTotal2').val(q_trv(t_total2));
                $('#txtUnpack').val(q_trv(t_unpack));
            }

            function currentData() {
            }


            currentData.prototype = {
                data : [],
                /*新增時複製的欄位*/
                include : [],
                /*記錄當前的資料*/
                copy : function() {
                    this.data = new Array();
                    for (var i in fbbm) {
                        var isInclude = false;
                        for (var j in this.include) {
                            if (fbbm[i] == this.include[j]) {
                                isInclude = true;
                                break;
                            }
                        }
                        if (isInclude) {
                            this.data.push({
                                field : fbbm[i],
                                value : $('#' + fbbm[i]).val()
                            });
                        }
                    }
                },
                /*貼上資料*/
                paste : function() {
                    for (var i in this.data) {
                        $('#' + this.data[i].field).val(this.data[i].value);
                    }
                }
            };
            var curData = new currentData();

            function transData() {
            }


            transData.prototype = {
                calctype : new Array(),
                isTrd : null,
                isTre : null,
                isoutside : null,
                refresh : function() {
                    $('#lblPrice2').hide();
                    $('#txtPrice2').hide();
                    $('#lblPrice3').hide();
                    $('#txtPrice3').hide();
                },
                priceChange : function() {
                    var t_straddrno = $.trim($('#txtStraddrno').val());
                    var t_endaddrno = $.trim($('#txtEndaddrno').val());
                    var t_date = $.trim($('#txtTrandate').val());

                    t_where = " b.straddrno='" + t_straddrno + "' and b.endaddrno='" + t_endaddrno + "' and a.datea<='" + t_date + "'";
                    q_gt('addr_tb', "where=^^" + t_where + "^^", 0, 0, 0, 'getPrice_cust');
                },
                checkData : function() {
                    this.isTrd = false;
                    this.isTre = false;
                    this.isoutside = false;
                    $('#txtDatea').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtTrandate').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');

                    $('#txtCustno').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtComp').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtStraddrno').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtStraddr').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtInmount').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPton').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPrice').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');

                    $('#txtCarno').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtDriverno').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtDriver').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtOutmount').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPton2').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPrice2').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtPrice3').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                    $('#txtDiscount').attr('readonly', 'readonly').css('color', 'green').css('background', 'rgb(237,237,237)');
                }
            };
            trans = new transData();

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt('calctype2', '', 0, 0, 0, 'transInit1');
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                document.title = '託運單作業';
                $("#lblCust").text('公司名稱');
                q_cmbParse("cmbCalctype", "手寫託運單,edi託運單");
                q_modiDay = q_getPara('sys.modiday2');
                /// 若未指定， d4=  q_getPara('sys.modiday');
                $('#btnIns').val($('#btnIns').val() + "(F8)");
                $('#btnOk').val($('#btnOk').val() + "(F9)");
                $('#textBdate').datepicker();
                $('#textEdate').datepicker();
                bbmMask = [['txtDatea', r_picd], ['txtTrandate', r_picd], ['textBdate', r_picd], ['textEdate', r_picd]];
                q_mask(bbmMask);

                $('#txtPrice').change(function() {
                    sum();
                });
                $('#txtPrice2').change(function() {
                    sum();
                });
                $('#txtPrice3').change(function() {
                    sum();
                });
                $('#txtDiscount').change(function() {
                    sum();
                });
                $('#txtInmount').change(function() {
                    sum();
                });
                $('#txtPton').change(function() {
                    sum();
                });
                $('#txtOutmount').change(function() {
                    sum();
                });
                $('#txtPton2').change(function() {
                    sum();
                });
                $('#txtBmiles').change(function() {
                    sum();
                });
                $('#txtEmiles').change(function() {
                    sum();
                });
                $('#txtTolls').change(function() {
                    sum();
                });
                $('#txtReserve').change(function() {
                    sum();
                });
                $('#txtOverh').change(function() {
                    sum();
                });
                $('#txtOverw').change(function() {
                    sum();
                });
                $('#txtCommission').change(function() {
                    sum();
                });
                $('#txtCommission2').change(function() {
                    sum();
                });
                $('#txtUnpack').change(function() {
                    sum();
                });
                $('#txtTrandate').change(function(e) {
                    trans.priceChange();
                });
                $('#txtFill').change(function(e) {
                    $(this).val($(this).val().toUpperCase());
                });
                $('#txtIo').change(function(e) {
                    $(this).val($(this).val().toUpperCase());
                });
                $('#btnCopy').click(function(e) {
                    $('#divCopy').toggle();
                });
                // q_xchgForm();
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.transef_copy':
                        location.reload();
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'addr2':
                        var as = _q_appendData("addr2", "", true);
                        if (as[0] != undefined) {
                            //不產生96條碼
                        } else {
                            //產生96條碼
                            var t_where = "where=^^ po=(select Max(po) from view_transef) ^^";
                            q_gt('view_transef', t_where, 0, 0, 0, "transef96");
                        }
                        break;
                    case 'transef96':
                        var as = _q_appendData("view_transef", "", true);
                        if (as[0] != undefined) {
                            $('#txtPo').val('96' + ('0000000' + (dec(as[0].po.substr(2, 7)) + 1)).substr(-7) + (dec(as[0].po.substr(2, 7)) + 1 % 7))
                        } else
                            $('#txtPo').val('9600000011');

                        btnOk();
                        break;
                    case 'getPrice_driver':
                        var t_price = 0;
                        var as = _q_appendData("addrs", "", true);
                        if (as[0] != undefined) {
                            t_price = as[0].driverprice;
                        }
                        $('#txtPrice2').val(t_price);
                        $('#txtPrice3').val(0);

                        sum();
                        break;
                    case 'getPrice_driver2':
                        var t_price = 0;
                        var as = _q_appendData("addrs", "", true);
                        if (as[0] != undefined) {
                            t_price = as[0].driverprice2;
                        }
                        $('#txtPrice2').val(0);
                        $('#txtPrice3').val(t_price);

                        sum();
                        break;
                    case 'getPrice_cust':
                        var t_price = 0;
                        var as = _q_appendData("addrs", "", true);
                        if (as[0] != undefined) {
                            t_price = as[0].custprice;
                        }
                        $('#txtPrice').val(t_price);

                        var t_straddrno = $.trim($('#txtStraddrno').val());
                        var t_endaddrno = $.trim($('#txtEndaddrno').val());
                        var t_date = $.trim($('#txtTrandate').val());
                        if (trans.isoutside) {
                            t_where = "b.straddrno='" + t_straddrno + "' and b.endaddrno='" + t_endaddrno + "' and a.datea<='" + t_date + "'";
                            q_gt('addr_tb', "where=^^" + t_where + "^^", 0, 0, 0, 'getPrice_driver2');
                        } else {
                            t_where = "b.straddrno='" + t_straddrno + "' and b.endaddrno='" + t_endaddrno + "' and a.datea<='" + t_date + "'";
                            q_gt('addr_tb', "where=^^" + t_where + "^^", 0, 0, 0, 'getPrice_driver');
                        }
                        break;
                    case 'transInit1':
                        var as = _q_appendData("calctypes", "", true);
                        var t_item = "";
                        if (as[0] != undefined) {
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                                trans.calctype.push({
                                    noa : as[i].noa + as[i].noq,
                                    typea : as[i].typea,
                                    discount : as[i].discount,
                                    discount2 : as[i].discount2,
                                    isoutside : as[i].isoutside.length == 0 ? false : (as[i].isoutside == "false" || as[i].isoutside == "0" || as[i].isoutside == "undefined" ? false : true)
                                });
                            }
                        }
                        q_gt('carteam', '', 0, 0, 0, 'transInit2');
                        break;
                    case 'transInit2':
                        var as = _q_appendData("carteam", "", true);
                        var t_item = "";
                        if (as[0] != undefined) {
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                            }
                        }
                        q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:

                        break;
                }
            }

            function q_popPost(id) {
                switch(id) {
                    case 'txtStraddrno':
                        trans.priceChange();
                        break;
                    case 'txtEndaddrno':
                        trans.priceChange();
                        break;
                    case 'txtUccno':
                        trans.priceChange();
                        break;
                    default:
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('trans_ef_s.aspx', q_name + '_s', "550px", "95%", q_getMsg("popSeek"));
            }

            function btnIns() {
                curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                $('#txtNoq').val('001');
                trans.refresh();
                $('#txtDatea').focus();

            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                //1030630取消限制修改日期
                /*if(!isEdit())
                 return;*/
                _btnModi();
                sum();
            }

            function btnPrint() {
                q_box('z_tran_ef.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                //日期檢查
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert('發送日期錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())) {
                    alert('配送日期錯誤。');
                    Unlock(1);
                    return;
                }
                var t_days = 0;
                var t_date1 = $('#txtDatea').val();
                var t_date2 = $('#txtTrandate').val();
                t_date1 = new Date(dec(t_date1.substr(0, 3)) + 1911, dec(t_date1.substring(4, 6)) - 1, dec(t_date1.substring(7, 9)));
                t_date2 = new Date(dec(t_date2.substr(0, 3)) + 1911, dec(t_date2.substring(4, 6)) - 1, dec(t_date2.substring(7, 9)));
                t_days = Math.abs(t_date2 - t_date1) / (1000 * 60 * 60 * 24) + 1;
                if (t_days > 60) {
                    alert('發送日期、配送日期相隔天數不可多於60天。');
                    Unlock(1);
                    return;
                }
                sum();
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else if (q_cur == 2) {
                    $('#txtWorker2').val(r_name);
                } else {
                    alert("error: btnok!");
                }

                if (emp($('#txtPo').val())) {
                    var t_where = "where=^^ noa='" + $('#txtCaseend').val() + "' and isnull(siteno,'') !='' ^^";
                    q_gt('addr2', t_where, 0, 0, 0, "");
                    return;
                }

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (q_cur == 1)
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txtNoa').val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                trans.refresh();
                $('#barcodeImg').attr('src', 'barcode_bv.aspx?noa=' +$('#txtNoa').val());
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#btnCode97').attr('disabled', 'disabled');
                } else {
                    $('#btnCode97').removeAttr('disabled');
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
                if (q_chkClose())
                    return;
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

            function checkCaseno(string) {
                var key = {
                    0 : 0,
                    1 : 1,
                    2 : 2,
                    3 : 3,
                    4 : 4,
                    5 : 5,
                    6 : 6,
                    7 : 7,
                    8 : 8,
                    9 : 9,
                    A : 10,
                    B : 12,
                    C : 13,
                    D : 14,
                    E : 15,
                    F : 16,
                    G : 17,
                    H : 18,
                    I : 19,
                    J : 20,
                    K : 21,
                    L : 23,
                    M : 24,
                    N : 25,
                    O : 26,
                    P : 27,
                    Q : 28,
                    R : 29,
                    S : 30,
                    T : 31,
                    U : 32,
                    V : 34,
                    W : 35,
                    X : 36,
                    Y : 37,
                    Z : 38
                };
                if ((/^[A-Z]{4}[0-9]{7}$/).test(string)) {
                    var value = 0;
                    for (var i = 0; i < string.length - 1; i++) {
                        value += key[string.substring(i, i + 1)] * Math.pow(2, i);
                    }
                    return Math.floor(q_add(q_div(value, 11), 0.09) * 10 % 10) == parseInt(string.substring(10, 11));
                } else {
                    return false;
                }
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 100%;
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
                width: 98%;
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
            select {
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
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:100px; color:black;">來源表單編號</td>
						<td align="center" style="width:100px; color:black;">姓名</td>
						<td align="center" style="width:120px; color:black;">電話</td>
						<td align="center" style="width:200px; color:black;">地址</td>
						<td align="center" style="width:80px; color:black;">審件等級</td>
						<td align="center" style="width:80px; color:black;">郵遞區號</td>
						<td align="center" style="width:80px; color:black;">代收貨款</td>
						<td align="center" style="width:140px; color:black;">商品內容</td>
						<td align="center" style="width:180px; color:black;">備註</td>

					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td id="so" style="text-align: center;">~so</td>
						<td id="addressee" style="text-align: center;">~addressee</td>
						<td id="atel" style="text-align: center;">~atel</td>
						<td id="aaddr" style="text-align: center;">~aaddr</td>
						<td id="unit" style="text-align: center;">~unit</td>
						<td id="caseend" style="text-align: center;">~caseend</td>
						<td id="price,0" style="text-align: right;">~price,0</td>
						<td id="straddr" style="text-align: center;">~straddr</td>
						<td id="endaddr" style="text-align: center;">~endaddr</td>

					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">發送日期</a></td>
						<td>
						<input id="txtDatea"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a class="lbl">配送日期</a></td>
						<td>
						<input id="txtTrandate"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a class="lbl">代收貨款</a></td>
						<td>
						<input id="txtPrice"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a class="lbl">審件等級</a></td>
						<td>
						<input id="txtUnit"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl"> 單據編號 </a></td>
						<td colspan="2">
						<input type="text" id="txtNoa" class="txt c1"/>
						</td>
						<td><span> </span><a class="lbl">來源表單編號</a></td>
						<td colspan="2">
						<input id="txtSo"  type="text" class="txt c1"/>
						<input id="txtNoq"  type="text" style="display:none;"/>
						</td>

					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"></a></td>
						<td colspan="3">
						<input type="text" id="txtCustno" class="txt" style="width:15%;float: left; " />
						<input type="text" id="txtComp" class="txt" style="width:85%;float: left; " />
						<input type="text" id="txtNick" class="txt" style="display:none; " />
						</td>
						<td><span> </span><a class="lbl">郵遞區號</a></td>
						<td>
						<input id="txtCaseend"  type="text" class="txt c1 "/>
						</td>

					</tr>
					<tr>
						<td><span> </span><a class="lbl">姓名</a></td>
						<td>
						<input id="txtAddressee"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a class="lbl">電話</a></td>
						<td colspan="2">
						<input id="txtAtel"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a class="lbl">行動電話</a></td>
						<td colspan="2">
						<input id="txtBoat"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">地址</a></td>
						<td colspan="3">
						<input id="txtAaddr"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">商品內容</a></td>
						<td colspan="3">
						<input id="txtStraddr"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a class="lbl">備註</a></td>
						<td colspan="3">
						<input id="txtEndaddr"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl"> 97條碼 </a></td>
						<td colspan="2">
						<input type="text" id="txtBoatname" class="txt c1" style="width:70%"/>
						</td>
						<td><span> </span><a class="lbl"> 96條碼 </a></td>
						<td colspan="2" >
						<input type="text" id="txtPo" class="txt c1" style="width:70%"/>
						</td>
						<td><span> </span><a class="lbl"> 託運單形式 </a></td>
						<td><select id="cmbCalctype" class="txt c1"></select></td>
					</tr>
				</table>
			</div>
		</div>
		<img id="barcodeImg" src=""> </img>
		<input id="q_sys" type="hidden" />
	</body>
</html>
