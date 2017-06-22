<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            var isInit = false;
            var t_carkind = null;
            var t_carno = null;
            q_name = 'z_anatran';
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_anatran');
            });
            function q_gfPost() {
                q_gt('carteam', '', 0, 0, 0, "");
                q_gt('calctype2', '', 0, 0, 0, "calctypes");
                q_gt('carkind', '', 0, 0, 0, "");
                q_gt('acomp', '', 0, 0, 0);
                q_gt('calctype', '', 0, 0, 0);

                $('#btnXXX').click(function(e) {
                    btnAuthority(q_name);
                });
                $("#btnRun").click(function(e) {
                    $('#txtXcarno').val($.trim($('#txtXcarno').val()));
                    var t_val = '';
                    var t_elements = $("#chkXcarkind").children('input:checked');
                    for (var x = 0; x < t_elements.length; x++) {
                        t_val += (t_val.length > 0 ? '@' : '') + t_elements.eq(x).val();
                    }
                    var t_index = $('#q_report').data('info').radioIndex;
                    var t_report = $('#q_report').data('info').reportData[t_index].report;

                    $(".z_anatran.chart").html('').height(0);
                    $("#txtCurPage").val(0);
                    $("#txtTotPage").val(0);
                    switch(t_report) {
                        case 'chart01':
                            $('#Loading').Loading();
                            Lock();
                            q_func('qtxt.query.chart01', 'z_anatran.txt,' + t_report + ',' + encodeURI(r_accy) + ';' + encodeURI($('#txtTrandate1').val()) + ';' + encodeURI($('#txtTrandate2').val()) + ';' + encodeURI(t_val) + ';' + encodeURI($.trim($('#txtXcarno').val())));
                            break;
                        case 'chart02':
                            $('#Loading').Loading();
                            Lock();
                            q_func('qtxt.query.chart02', 'z_anatran.txt,' + t_report + ',' + encodeURI(r_accy) + ';' + encodeURI($('#txtTrandate1').val()) + ';' + encodeURI($('#txtTrandate2').val()) + ';' + encodeURI(t_val) + ';' + encodeURI($('#txtXcarno').val()));
                            break;
                        case 'chart03':
                            $('#Loading').Loading();
                            Lock();
                            t_btrandate = encodeURI($('#txtTrandate1').val());
                            t_etrandate = encodeURI($.trim($('#txtTrandate2').val()).length == 0 ? '#non' : $('#txtTrandate2').val());
                            t_bcustno = encodeURI($('#txtCust1a').val());
                            t_ecustno = encodeURI($.trim($('#txtCust2a').val()).length == 0 ? '#non' : $('#txtCust2a').val());
                            t_po = encodeURI($('#txtXpo').val());
                            q_func('qtxt.query.chart03', 'z_anatran.txt,' + t_report + ',' + encodeURI(r_accy) + ';' + t_btrandate + ';' + t_etrandate + ';' + t_bcustno + ';' + t_ecustno + ';' + t_po);
                            break;
                        default:
                            alert('錯誤：未定義報表');
                    }

                });
                $("#btnNext").click(function(e) {
                    $('#' + $(this).data('chart')).data('info').next($('#' + $(this).data('chart')));
                });
                $("#btnPrevious").click(function(e) {
                    $('#' + $(this).data('chart')).data('info').previous($('#' + $(this).data('chart')));
                });
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.chart01':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] == undefined){
                        	$('#Loading').hide();
                            Unlock();
                        }
                        else {
                            var n = -1;
                            var t_maxMoney = 0, t_minMoney = 0, t_outmoney = 0;
                            t_carno = new Array();
                            for (var i in as) {
                                if (as[i].carno != undefined) {
                                	n=-1;
                                	for (var z = 0; z < this.length; z++)
					                    if (this[z]["carno"] === as[i].carno)
					                        n=z;
                                    t_outmoney = parseFloat(as[i].outmoney.length == 0 ? '0' : as[i].outmoney) + parseFloat(as[i].oilmoney.length == 0 ? '0' : as[i].oilmoney) + parseFloat(as[i].tolls.length == 0 ? '0' : as[i].tolls) + parseFloat(as[i].ticket.length == 0 ? '0' : as[i].ticket) + parseFloat(as[i].reserve.length == 0 ? '0' : as[i].reserve);
                                    if (t_maxMoney < parseFloat(as[i].inmoney.length == 0 ? '0' : as[i].inmoney))
                                        t_maxMoney = parseFloat(as[i].inmoney.length == 0 ? '0' : as[i].inmoney);
                                    if (t_maxMoney < t_outmoney)
                                        t_maxMoney = t_outmoney;
                                    if (t_maxMoney < parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit))
                                        t_maxMoney = parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit);

                                    if (t_minMoney > parseFloat(as[i].inmoney.length == 0 ? '0' : as[i].inmoney))
                                        t_minMoney = parseFloat(as[i].inmoney.length == 0 ? '0' : as[i].inmoney);
                                    if (t_minMoney > t_outmoney)
                                        t_minMoney = t_outmoney;
                                    if (t_minMoney > parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit))
                                        t_minMoney = parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit);

                                    t_detail = {
                                        datea : as[i].datea,
                                        inmoney : parseFloat(as[i].inmoney.length == 0 ? '0' : as[i].inmoney),
                                        outmoney : parseFloat(as[i].outmoney.length == 0 ? '0' : as[i].outmoney),
                                        tranmiles : parseFloat(as[i].tranmiles.length == 0 ? '0' : as[i].tranmiles),
                                        oilmoney : parseFloat(as[i].oilmoney.length == 0 ? '0' : as[i].oilmoney),
                                        oilmount : parseFloat(as[i].oilmount.length == 0 ? '0' : as[i].oilmount),
                                        oilmiles : parseFloat(as[i].oilmiles.length == 0 ? '0' : as[i].oilmiles),
                                        tolls : parseFloat(as[i].tolls.length == 0 ? '0' : as[i].tolls),
                                        ticket : parseFloat(as[i].ticket.length == 0 ? '0' : as[i].ticket),
                                        reserve : parseFloat(as[i].reserve.length == 0 ? '0' : as[i].reserve),
                                        profit : parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit)
                                    };

                                    if (n == -1) {
                                        t_carno.push({
                                            carkindno : as[i].carkindno,
                                            carkind : as[i].carkind,
                                            carno : as[i].carno,
                                            caryear : as[i].caryear,
                                            inmoney : parseFloat(as[i].inmoney.length == 0 ? '0' : as[i].inmoney),
                                            outmoney : t_outmoney,
                                            profit : parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit),
                                            detail : [t_detail]
                                        });
                                    } else {
                                        t_carno[n].inmoney += parseFloat(as[i].inmoney.length == 0 ? '0' : as[i].inmoney);
                                        t_carno[n].outmoney += t_outmoney;
                                        t_carno[n].profit += parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit);
                                        t_carno[n].detail.push(t_detail);
                                    }
                                }
                            }
                            $('#Loading').hide();
                            Unlock();
                            $('#chart01').barChart01({
                                data : t_carno,
                                maxMoney : t_maxMoney,
                                minMoney : t_minMoney
                            });
                            $('#txtTotPage').val(t_carno.length);
                            $('#txtCurPage').data('chart', 'chart01').val(1).change(function(e) {
                                $(this).val(parseInt($(this).val()));
                                $('#' + $(this).data('chart')).data('info').page($('#' + $(this).data('chart')), $(this).val());
                            });
                            $("#btnNext").data('chart', 'chart01');
                            $("#btnPrevious").data('chart', 'chart01');
                            $(".control").show();
                        }
                        break;
                    case 'qtxt.query.chart02':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] == undefined){
                        	$('#Loading').hide();
                        	Unlock();
                        }
                        else {
                            var n = -1;
                            var t_maxMoney = 0, t_minMoney = 0, t_inmoney = 0, t_outmoney = 0;
                            var tot_inmoney = 0, tot_outmoney = 0, tot_profit = 0;
                            t_carno = new Array();
                            for (var i in as) {
                                if (as[i].carno != undefined) {
                                    n=-1;
                                	for (var z = 0; z < this.length; z++)
					                    if (this[z]["carno"] === as[i].carno)
					                        n=z;
                                    t_inmoney = parseFloat(as[i].inmoney.length == 0 ? '0' : as[i].inmoney);
                                    t_outmoney = parseFloat(as[i].oilmoney.length == 0 ? '0' : as[i].oilmoney) + parseFloat(as[i].fixa1.length == 0 ? '0' : as[i].fixa1) + parseFloat(as[i].fixa2.length == 0 ? '0' : as[i].fixa2) + parseFloat(as[i].tire1.length == 0 ? '0' : as[i].tire1) + parseFloat(as[i].tire2.length == 0 ? '0' : as[i].tire2) + parseFloat(as[i].tolls.length == 0 ? '0' : as[i].tolls) + parseFloat(as[i].ticket.length == 0 ? '0' : as[i].ticket) + parseFloat(as[i].reserve.length == 0 ? '0' : as[i].reserve) + parseFloat(as[i].carsal.length == 0 ? '0' : as[i].carsal) + parseFloat(as[i].tax.length == 0 ? '0' : as[i].tax) + parseFloat(as[i].depreciation.length == 0 ? '0' : as[i].depreciation) - parseFloat(as[i].driverpay.length == 0 ? '0' : as[i].driverpay);
                                    if (n == -1) {
                                        t_maxMoney = 0;
                                        t_minMoney = 0;
                                    }
                                    if (t_maxMoney < t_inmoney)
                                        t_maxMoney = t_inmoney;
                                    if (t_maxMoney < t_outmoney)
                                        t_maxMoney = t_outmoney;
                                    if (t_maxMoney < parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit))
                                        t_maxMoney = parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit);

                                    if (t_minMoney > t_inmoney)
                                        t_minMoney = t_inmoney;
                                    if (t_minMoney > t_outmoney)
                                        t_minMoney = t_outmoney;
                                    if (t_minMoney > parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit))
                                        t_minMoney = parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit);
                                    t_detail = {
                                        mon : as[i].mon,
                                        inmoney : t_inmoney,
                                        tranmiles : parseFloat(as[i].tranmiles.length == 0 ? '0' : as[i].tranmiles),
                                        oilmoney : parseFloat(as[i].oilmoney.length == 0 ? '0' : as[i].oilmoney),
                                        oilmount : parseFloat(as[i].oilmount.length == 0 ? '0' : as[i].oilmount),
                                        oilmiles : parseFloat(as[i].oilmiles.length == 0 ? '0' : as[i].oilmiles),
                                        fixa1 : parseFloat(as[i].fixa1.length == 0 ? '0' : as[i].fixa1),
                                        fixa2 : parseFloat(as[i].fixa2.length == 0 ? '0' : as[i].fixa2),
                                        tire1 : parseFloat(as[i].tire1.length == 0 ? '0' : as[i].tire1),
                                        tire2 : parseFloat(as[i].tire2.length == 0 ? '0' : as[i].tire2),
                                        driverpay : parseFloat(as[i].driverpay.length == 0 ? '0' : as[i].driverpay),
                                        tolls : parseFloat(as[i].tolls.length == 0 ? '0' : as[i].tolls),
                                        ticket : parseFloat(as[i].ticket.length == 0 ? '0' : as[i].ticket),
                                        reserve : parseFloat(as[i].reserve.length == 0 ? '0' : as[i].reserve),
                                        carsal : parseFloat(as[i].carsal.length == 0 ? '0' : as[i].carsal),
                                        tax : parseFloat(as[i].tax.length == 0 ? '0' : as[i].tax),
                                        depreciation : parseFloat(as[i].depreciation.length == 0 ? '0' : as[i].depreciation),
                                        profit : parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit),
                                        outmoney : t_outmoney
                                    };

                                    if (n == -1) {
                                        t_carno.push({
                                            carkindno : as[i].carkindno,
                                            carkind : as[i].carkind,
                                            carno : as[i].carno,
                                            caryear : as[i].caryear,
                                            inmoney : t_inmoney,
                                            outmoney : t_outmoney,
                                            profit : parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit),
                                            maxMoney : t_maxMoney,
                                            minMoney : t_minMoney,
                                            detail : [t_detail]
                                        });
                                    } else {
                                        t_carno[n].maxMoney = t_maxMoney;
                                        t_carno[n].minMoney = t_minMoney;
                                        t_carno[n].inmoney += t_inmoney;
                                        t_carno[n].outmoney += t_outmoney;
                                        t_carno[n].profit += parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit);
                                        t_carno[n].detail.push(t_detail);
                                    }
                                    tot_inmoney += t_inmoney;
                                    tot_outmoney += t_outmoney;
                                    tot_profit += parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit);
                                }
                            }
                            t_maxMoney = 0;
                            t_minMoney = 0;
                            for (var i in t_carno) {
                                if (t_maxMoney < t_carno[i].inmoney)
                                    t_maxMoney = t_carno[i].inmoney;
                                if (t_maxMoney < t_carno[i].outmoney)
                                    t_maxMoney = t_carno[i].outmoney;
                                if (t_maxMoney < t_carno[i].profit)
                                    t_maxMoney = t_carno[i].profit;

                                if (t_minMoney > t_carno[i].inmoney)
                                    t_minMoney = t_carno[i].inmoney;
                                if (t_minMoney > t_carno[i].outmoney)
                                    t_minMoney = t_carno[i].outmoney;
                                if (t_minMoney > t_carno[i].profit)
                                    t_minMoney = t_carno[i].profit;
                            }
                            $('#Loading').hide();
                            Unlock();
                            $('#chart02').barChart02({
                                data : t_carno,
                                maxMoney : t_maxMoney,
                                minMoney : t_minMoney,
                                inmoney : tot_inmoney,
                                outmoney : tot_outmoney,
                                profit : tot_profit
                            });
                            $('#txtTotPage').val(1);
                            $('#txtCurPage').data('chart', 'chart02').val(1).change(function(e) {
                                $(this).val(parseInt($(this).val()));
                                $('#' + $(this).data('chart')).data('info').page($('#' + $(this).data('chart')), $(this).val());
                            });
                            $("#btnNext").data('chart', 'chart02');
                            $("#btnPrevious").data('chart', 'chart02');
                            $(".control").show();
                        }
                        break;
                    case 'qtxt.query.chart03':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] == undefined) {
                            $('#Loading').hide();
                            Unlock();
                        } else {
                            var n = -1;
                            var t_maxMoney = 0, t_minMoney = 0, t_inmoney = 0, t_profit = 0;
                            var t_cust = new Array();
                            for (var i in as) {
                            	if(as[i].custno!=undefined){
                            		t_inmoney = parseFloat(as[i].inmoney.length == 0 ? '0' : as[i].inmoney);
	                                t_profit = parseFloat(as[i].profit.length == 0 ? '0' : as[i].profit);
	                                t_maxMoney = (t_maxMoney > t_inmoney) ? t_maxMoney : t_inmoney;
	                                t_maxMoney = (t_maxMoney > t_profit) ? t_maxMoney : t_profit;
	                                t_minMoney = (t_minMoney < t_inmoney) ? t_minMoney : t_inmoney;
	                                t_minMoney = (t_minMoney < t_profit) ? t_minMoney : t_profit;
	                                t_cust.push({
	                                    custno : as[i].custno,
	                                    comp : as[i].comp,
	                                    nick : as[i].nick,
	                                    inmoney : t_inmoney,
	                                    profit : t_profit
	                                });
                            	}
                            }
                            $('#Loading').hide();
                            Unlock();
                            $('#chart03').barChart03({
                                data : t_cust,
                                maxMoney : t_maxMoney,
                                minMoney : t_minMoney
                            });
                             $('#txtTotPage').val(1);
                             $('#txtCurPage').data('chart', 'chart03').val(1).change(function(e) {
                             $(this).val(parseInt($(this).val()));
                             $('#' + $(this).data('chart')).data('info').page($('#' + $(this).data('chart')), $(this).val());
                             });
                             $("#btnNext").data('chart', 'chart03');
                             $("#btnPrevious").data('chart', 'chart03');
                             $(".control").show();
                        }
                        break;
                    default:
                        alert('q_funcPost undefined');
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'carkind':
                        t_carkind = '';
                        var as = _q_appendData("carkind", "", true);
                        if (as[0] != undefined) {
                            for ( i = 0; i < as.length; i++) {
                                t_carkind += (t_carkind.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
                            }
                        }
                        break;
                    default:
                        break;
                }

                if (t_carkind != null && !isInit) {
                    isInit = true;
                    $('#q_report').q_report({
                        fileName : 'z_anatran',
                        options : [{
                            type : '0',
                            name : 'accy',
                            value : q_getId()[4]
                        }, {/*1*/
                            type : '1',
                            name : 'date'
                        }, {/*2*/
                            type : '1',
                            name : 'trandate'
                        }, {/*3*/
                            type : '6',
                            name : 'xcarno'
                        }, {/*4*/
                            type : '8',
                            name : 'xcarkind',
                            value : t_carkind.split(',')
                        }, {/*5*/
                            type : '2',
                            name : 'cust',
                            dbf : 'cust',
                            index : 'noa,comp',
                            src : 'cust_b.aspx'
                        }, {/*6*/
                            type : '6',
                            name : 'xpo'
                        }]
                    });
                    q_popAssign();
                    q_langShow();

                    $('#txtDate1').mask('999/99/99');
                    $('#txtDate1').datepicker();
                    $('#txtDate2').mask('999/99/99');
                    $('#txtDate2').datepicker();
                    $('#txtTrandate1').mask('999/99/99');
                    $('#txtTrandate1').datepicker();
                    $('#txtTrandate2').mask('999/99/99');
                    $('#txtTrandate2').datepicker();

                    $('#chkXcarkind').children('input').attr('checked', 'checked');

                    var t_date, t_year, t_month, t_day;
                    t_date = new Date();
                    t_date.setDate(1);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtDate1').val(t_year + '/' + t_month + '/' + t_day);
                    $('#txtTrandate1').val(t_year + '/' + t_month + '/' + t_day);
                    t_date = new Date();
                    t_date.setDate(35);
                    t_date.setDate(0);
                    t_year = t_date.getUTCFullYear() - 1911;
                    t_year = t_year > 99 ? t_year + '' : '0' + t_year;
                    t_month = t_date.getUTCMonth() + 1;
                    t_month = t_month > 9 ? t_month + '' : '0' + t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day > 9 ? t_day + '' : '0' + t_day;
                    $('#txtDate2').val(t_year + '/' + t_month + '/' + t_day);
                    $('#txtTrandate2').val(t_year + '/' + t_month + '/' + t_day);
                }
            }

            function q_boxClose(t_name) {
            }

            function FormatNumber(n) {
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }

            ;(function($, undefined) {
                $.fn.Loading = function() {
                    $(this).data('info', {
                        init : function(obj) {
                            obj.html('').width(250).height(100).show();
                            var tmpPath = '<defs>' + '<filter id="f1" x="0" y="0">' + '<feGaussianBlur in="SourceGraphic" stdDeviation="5" />' + '</filter>' + '<filter id="f2" x="0" y="0">' + '<feGaussianBlur in="SourceGraphic" stdDeviation="5" />' + '</filter>' + '</defs>' + '<rect width="200" height="10" fill="yellow" filter="url(#f1)"/>' + '<rect x="0" y="0" width="20" height="10" fill="RGB(223,116,1)" stroke="yellow" stroke-width="2" filter="url(#f2)">' + '<animate attributeName="x" attributeType="XML" begin="0s" dur="6s" fill="freeze" from="0" to="200" repeatCount="indefinite"/>' + '</rect>';
                            tmpPath += '<text x="40" y="35" fill="black">資料讀取中...</text>';
                            obj.append('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                        }
                    });
                    $(this).data('info').init($(this));
                }
                $.fn.barChart01 = function(value) {
                    $(this).data('info', {
                        curIndex : -1,
                        carData : value.data,
                        maxMoney : value.maxMoney,
                        minMoney : value.minMoney,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            obj.data('info').curIndex = 0;
                            obj.data('info').refresh(obj);
                        },
                        page : function(obj, n) {
                            if (n > 0 && n <= obj.data('info').carData.length) {
                                obj.data('info').curIndex = n - 1;
                                obj.data('info').refresh(obj);
                            } else
                                alert('頁數錯誤。');
                        },
                        next : function(obj) {
                            if (obj.data('info').curIndex == obj.data('info').carData.length - 1)
                                alert('已到最後頁。');
                            else {
                                obj.data('info').curIndex++;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj);
                            }
                        },
                        previous : function(obj) {
                            if (obj.data('info').curIndex == 0)
                                alert('已到最前頁。');
                            else {
                                obj.data('info').curIndex--;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj);
                            }
                        },
                        refresh : function(obj) {
                            obj.width(950).height(500);
                            var t_color1 = ['rgb(210,233,255)', 'rgb(255,238,221)'];
                            var t_n = 10;
                            //分幾個區塊
                            var t_height = 350, t_width = 600;
                            var tmpPath = '<rect x="0" y="0" width="950" height="500" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
                            for (var i = 0; i < t_n; i++)
                                tmpPath += '<rect x="100" y="' + (50 + (t_height / t_n) * i) + '" width="' + t_width + '" height="' + (t_height / t_n) + '" style="fill:' + t_color1[i % t_color1.length] + ';"/>';
                            //Y軸
                            tmpPath += '<line x1="100" y1="50" x2="100" y2="' + (50 + t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';

                            var t_detail = obj.data('info').carData[obj.data('info').curIndex].detail;
                            var t_maxMoney = obj.data('info').maxMoney;
                            var t_minMoney = obj.data('info').minMoney;
                            var t_n = round((t_width - 20) / t_detail.length, 0);
                            var x, y, w, h, bx, by, t_output, t_money;
                            tmpPath += '<text x="' + (500) + '" y="' + (20) + '" fill="black" style="font-family: \'Times New Roman\';">【' + obj.data('info').carData[obj.data('info').curIndex].carkind + '】' + obj.data('info').carData[obj.data('info').curIndex].carno + '&nbsp;' + obj.data('info').carData[obj.data('info').curIndex].caryear + '</text>';
                            tmpPath += '<text x="' + (70) + '" y="' + (20) + '" fill="black">金額</text>';
                            tmpPath += '<text x="' + (50 + t_width + 50) + '" y="' + (50 + t_height + 30) + '" fill="black">日期</text>';

                            x = 50;
                            var t_Y = 50 + t_height - round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_height, 0);
                            tmpPath += '<line x1="95" y1="' + t_Y + '" x2="100" y2="' + t_Y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text text-anchor="end" x="90" y="' + t_Y + '" fill="black">0</text>';
                            //X軸
                            tmpPath += '<line x1="100" y1="' + (t_Y) + '" x2="' + (100 + t_width) + '" y2="' + (t_Y) + '" style="stroke:rgb(0,0,0);stroke-width:1"/>';

                            //Y
                            tmpPath += '<text text-anchor="end" x="90" y="' + (50) + '" fill="black">' + FormatNumber(t_maxMoney) + '</text>';
                            tmpPath += '<line x1="95" y1="50" x2="100" y2="50" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text text-anchor="end" x="90" y="' + (50 + t_height) + '" fill="black">' + FormatNumber(t_minMoney) + '</text>';
                            tmpPath += '<line x1="95" y1="' + (50 + t_height) + '" x2="100" y2="' + (50 + t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';

                            var t_range = round((t_maxMoney - t_minMoney) / 5, 0);
                            var i = Math.pow(10, (t_range + '').length - 1);
                            var t_range = Math.floor(t_range / i) * i;
                            t_money = t_range;
                            while (t_money < t_maxMoney) {
                                if ((t_maxMoney - t_money) / (t_maxMoney - t_minMoney) > 0.05) {
                                    y = t_Y - round(t_money / (t_maxMoney - t_minMoney) * t_height, 0);
                                    tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                                    tmpPath += '<text text-anchor="end" x="90" y="' + y + '" fill="black">' + FormatNumber(t_money) + '</text>';
                                }
                                t_money += t_range;
                            }
                            t_money = -t_range;
                            while (t_money > t_minMoney) {
                                if (Math.abs(t_minMoney - t_money) / (t_maxMoney - t_minMoney) > 0.05) {
                                    x = 90;
                                    y = t_Y - round(t_money / (t_maxMoney - t_minMoney) * t_height, 0);
                                    tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                                    tmpPath += '<text text-anchor="end" x="90" y="' + y + '" fill="black">' + FormatNumber(t_money) + '</text>';
                                }
                                t_money -= t_range;
                            }

                            //支出的顏色
                            tmpPath += '<defs>' + '<linearGradient id="chart01_outColor1" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart01_outColor2" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';

                            //支出
                            for (var i = 0; i < t_detail.length; i++) {
                                t_output = t_detail[i].outmoney + t_detail[i].oilmoney + t_detail[i].tolls + t_detail[i].ticket + t_detail[i].reserve;
                                h = Math.abs(round(t_output / (t_maxMoney - t_minMoney) * t_height, 0));
                                x = 100 + 10 + t_n * i - (i == 0 ? 9 : 10);
                                if (t_output >= 0) {
                                    y = t_Y - h;
                                } else {
                                    y = t_Y;
                                }
                                tmpPath += '<rect id="chart01_out' + i + '" class="chart01_out" x="' + x + '" y="' + y + '" width="' + t_n + '" height="' + h + '" fill="url(#chart01_outColor1)"/>';
                            }
                            //毛利
                            for (var i = 0; i < t_detail.length; i++) {//連接線
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_detail[i].profit / (t_maxMoney - t_minMoney) * t_height, 0);
                                if (i > 0)
                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(0,255,0);stroke-width:1"/>';
                                bx = x;
                                by = y;
                            }
                            for (var i = 0; i < t_detail.length; i++) {
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_detail[i].profit / (t_maxMoney - t_minMoney) * t_height, 0);
                                tmpPath += '<circle id="chart01_profit' + i + '" class="chart01_profit" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
                            }
                            //收入
                            for (var i = 0; i < t_detail.length; i++) {//連接線
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_detail[i].inmoney / (t_maxMoney - t_minMoney) * t_height, 0);
                                if (i > 0)
                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(255,0,0);stroke-width:1"/>';
                                bx = x;
                                by = y;
                            }
                            for (var i = 0; i < t_detail.length; i++) {
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_detail[i].inmoney / (t_maxMoney - t_minMoney) * t_height, 0);
                                tmpPath += '<circle id="chart01_in' + i + '" class="chart01_in" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
                                tmpPath += '<text text-anchor="middle" id="chart01_datea' + i + '" class="chart01_datea" x="' + x + '" y="' + (50 + t_height + 30) + '" fill="black">' + t_detail[i].datea.substring(7, 9) + '</text>';
                            }
                            //符號說明
                            tmpPath += '<line x1="760" y1="50" x2="780" y2="50" style="stroke:rgb(255,0,0);stroke-width:1"/>';
                            tmpPath += '<circle class="" cx="770" cy="50" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
                            tmpPath += '<text x="790" y="55" fill="black">收入：</text>';
                            tmpPath += '<text text-anchor="end" x="910" y="55" fill="black">' + FormatNumber(obj.data('info').carData[obj.data('info').curIndex].inmoney) + '</text>';

                            tmpPath += '<rect x="760" y="65" width="20" height="20" fill="url(#chart01_outColor1)"/>';
                            tmpPath += '<text x="790" y="80" fill="black">支出：</text>';
                            tmpPath += '<text text-anchor="end" x="910" y="80" fill="black">' + FormatNumber(obj.data('info').carData[obj.data('info').curIndex].outmoney) + '</text>';

                            tmpPath += '<line x1="760" y1="100" x2="780" y2="100" style="stroke:rgb(0,180,125);stroke-width:1"/>';
                            tmpPath += '<circle class="" cx="770" cy="100" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
                            tmpPath += '<text x="790" y="105" fill="black">毛利：</text>';
                            tmpPath += '<text text-anchor="end" x="910" y="105" fill="black">' + FormatNumber(obj.data('info').carData[obj.data('info').curIndex].profit) + '</text>';

                            obj.html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                            //事件
                            obj.children('svg').find('.chart01_profit').hover(function(e) {
                                $(this).attr('fill', 'rgb(151,255,151)');
                                var n = $(this).attr('id').replace('chart01_profit', '');
                                $('#chart01_datea' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'rgb(0,255,0)');
                                var n = $(this).attr('id').replace('chart01_profit', '');
                                $('#chart01_datea' + n).attr('fill', 'black');
                            });
                            obj.children('svg').find('.chart01_in').hover(function(e) {
                                $(this).attr('fill', 'rgb(255,151,151)');
                                var n = $(this).attr('id').replace('chart01_in', '');
                                $('#chart01_datea' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'rgb(255,0,0)');
                                var n = $(this).attr('id').replace('chart01_in', '');
                                $('#chart01_datea' + n).attr('fill', 'black');
                            });
                            obj.children('svg').find('.chart01_out').hover(function(e) {
                                $(this).attr('fill', 'url(#chart01_outColor2)');
                                var n = $(this).attr('id').replace('chart01_out', '');
                                $('#chart01_datea' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'url(#chart01_outColor1)');
                                var n = $(this).attr('id').replace('chart01_out', '');
                                $('#chart01_datea' + n).attr('fill', 'black');
                            }).click(function(e) {
                                var obj = $(this).parent().parent();
                                var n = $(this).attr('id').replace('chart01_out', '');
                                var t_index = obj.data('info').curIndex;

                                $('#chart01_1').chart01_1({
                                    carkind : obj.data('info').carData[t_index].carkind,
                                    carno : obj.data('info').carData[t_index].carno,
                                    datea : obj.data('info').carData[t_index].detail[n].datea,
                                    data : [{
                                        text : '業績獎金：',
                                        value : obj.data('info').carData[t_index].detail[n].outmoney
                                    }, {
                                        text : '油　　費：',
                                        value : obj.data('info').carData[t_index].detail[n].oilmoney
                                    }, {
                                        text : '通行費　：',
                                        value : obj.data('info').carData[t_index].detail[n].tolls
                                    }, {
                                        text : '罰　　單：',
                                        value : obj.data('info').carData[t_index].detail[n].ticket
                                    }, {
                                        text : '寄櫃費　：',
                                        value : obj.data('info').carData[t_index].detail[n].reserve
                                    }],
                                    x : 150,
                                    y : 150,
                                    radius : 100
                                });
                            });

                        }
                    });
                    $(this).data('info').init($(this));
                }

                $.fn.chart01_1 = function(value) {
                    $(this).data('info', {
                        value : value,
                        fillColor : ["#E76E6D", "#E7AB6D", "#E6E76D", "#A9E76D", "#6DA9E7", "#AB6DE7", "#E76DE6"],
                        strokeColor : ["#000000"],
                        focusfillColor : "#FFEEFE",
                        focusIndex : -1,
                        init : function(obj) {
                            obj.addClass('pieChart');
                            var tmp = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                tmp += obj.data('info').value.data[i].value;
                            }
                            var tmpDegree = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                obj.data('info').value.data[i].rate = obj.data('info').value.data[i].value / tmp;
                                obj.data('info').value.data[i].degree = 2 * Math.PI * obj.data('info').value.data[i].rate;
                                obj.data('info').value.data[i].bDegree = tmpDegree;
                                tmpDegree += obj.data('info').value.data[i].degree;
                                obj.data('info').value.data[i].eDegree = tmpDegree;
                                obj.data('info').value.data[i].fillColor = obj.data('info').fillColor[i % obj.data('info').fillColor.length];
                                obj.data('info').value.data[i].strokeColor = obj.data('info').strokeColor[i % obj.data('info').strokeColor.length];
                            }
                            obj.data('info').refresh(obj);
                        },
                        refresh : function(obj) {
                            obj.width(450).height(450);
                            obj.html('');
                            var tmpPath = '', degree, fillColor, strokeColor, t_text;
                            var x = obj.data('info').value.x;
                            var y = obj.data('info').value.y;
                            var radius = obj.data('info').value.radius;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                fillColor = '"' + obj.data('info').value.data[i].fillColor + '"';
                                strokeColor = '"' + obj.data('info').value.data[i].strokeColor + '"';
                                degree = Math.round(obj.data('info').value.data[i].degree * 360 / (2 * Math.PI), 0);
                                obj.data('info').value.data[i].currentFillColor = fillColor;
                                obj.data('info').value.data[i].currentStrokeColor = strokeColor;
                                obj.data('info').value.data[i].point1 = [x, y];
                                obj.data('info').value.data[i].point2 = [x + Math.round(radius * Math.cos(obj.data('info').value.data[i].bDegree), 0), y + Math.round(radius * Math.sin(obj.data('info').value.data[i].bDegree), 0)];
                                obj.data('info').value.data[i].point3 = [x + Math.round(radius * Math.cos(obj.data('info').value.data[i].eDegree), 0), y + Math.round(radius * Math.sin(obj.data('info').value.data[i].eDegree), 0)];
                                var pointLogo = [x + radius + 20, i * 20 + 30];
                                var pointText = [x + radius + 35, i * 20 + 40];
                                tmpPath += '<rect class="blockLogo" id="blockLogo_' + i + '" width="10" height="10" x="' + pointLogo[0] + '" y="' + pointLogo[1] + '" fill=' + fillColor + ' stroke=' + strokeColor + '/>';
                                tmpPath += '<text class="blockText" id="blockText_' + i + '" x="' + pointText[0] + '" y="' + pointText[1] + '" fill="#000000" >' + obj.data('info').value.data[i].text + '</text>';
                                var t_text = FormatNumber(obj.data('info').value.data[i].value);
                                tmpPath += '<text class="blockText" id="blockText_' + i + '" text-anchor="end"  x="' + (pointText[0] + 150) + '" y="' + pointText[1] + '" fill="#000000" >' + t_text + '</text>';
                                if (degree != 360)
                                    tmpPath += '<path class="block" id="block_' + i + '" d="M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + (degree > 180 ? ' 1 1 ' : ' 0 1 ') + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
                                else
                                    tmpPath += '<circle class="block" id="block_' + i + '" cx="' + x + '" cy="' + y + '" r="' + radius + '" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
                            }
                            tmpPath += '<text x="20" y="40" fill="black">【' + obj.data('info').value.carkind + '】' + obj.data('info').value.carno + '</text>';
                            tmpPath += '<text x="200" y="40" fill="black">' + obj.data('info').value.datea + '</text>';
                            obj.append('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                obj.children('svg').find('.block').eq(i).data('info', {
                                    index : i
                                });
                                obj.children('svg').find('.blockLogo').eq(i).data('info', {
                                    index : i
                                });
                                obj.children('svg').find('.blockText').eq(i).data('info', {
                                    index : i
                                });
                            }
                            obj.children('svg').find('.block,.blockLogo,.blockText').hover(function(e) {
                                var obj = $(this).parent().parent();
                                $('#block_' + $(this).data('info').index).attr('fill', obj.data('info').focusfillColor);
                                $('#blockLogo_' + $(this).data('info').index).attr('fill', obj.data('info').focusfillColor);

                                var i = $(this).data('info').index;
                                var x = obj.data('info').value.x;
                                var y = obj.data('info').value.y;
                                var radius = obj.data('info').value.radius;
                                degree = Math.round(obj.data('info').value.data[i].degree * 360 / (2 * Math.PI), 0);
                                shiftX = Math.round(10 * Math.cos(obj.data('info').value.data[i].bDegree + obj.data('info').value.data[i].degree / 2), 0);
                                shiftY = Math.round(10 * Math.sin(obj.data('info').value.data[i].bDegree + obj.data('info').value.data[i].degree / 2), 0);
                                obj.data('info').value.data[i].point1 = [x + shiftX, y + shiftY];
                                obj.data('info').value.data[i].point2 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].bDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].bDegree), 0)];
                                obj.data('info').value.data[i].point3 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].eDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].eDegree), 0)];
                                if (degree != 360) {
                                    $('#block_' + i).attr('d', 'M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + (degree > 180 ? ' 1 1 ' : ' 0 1 ') + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z');
                                }
                            }, function(e) {
                                var obj = $(this).parent().parent();
                                $('#block_' + $(this).data('info').index).attr('fill', obj.data('info').fillColor[$(this).data('info').index]);
                                $('#blockLogo_' + $(this).data('info').index).attr('fill', obj.data('info').fillColor[$(this).data('info').index]);

                                var i = $(this).data('info').index;
                                var x = obj.data('info').value.x;
                                var y = obj.data('info').value.y;
                                var radius = obj.data('info').value.radius;
                                degree = Math.round(obj.data('info').value.data[i].degree * 360 / (2 * Math.PI), 0);
                                shiftX = 0;
                                shiftY = 0;
                                obj.data('info').value.data[i].point1 = [x + shiftX, y + shiftY];
                                obj.data('info').value.data[i].point2 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].bDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].bDegree), 0)];
                                obj.data('info').value.data[i].point3 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].eDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].eDegree), 0)];
                                if (degree != 360) {
                                    $('#block_' + i).attr('d', 'M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + (degree > 180 ? ' 1 1 ' : ' 0 1 ') + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z');
                                }
                            }).click(function(e) {
                                var obj = $(this).parent().parent();
                                //alert(obj.data('info').value.data[$(this).data('info').index].text);
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }

                $.fn.barChart02 = function(value) {
                    $(this).data('info', {
                        curIndex : -1,
                        carData : value.data,
                        maxMoney : value.maxMoney,
                        minMoney : value.minMoney,
                        inmoney : value.inmoney,
                        outmoney : value.outmoney,
                        profit : value.profit,
                        maxPage : 1,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            obj.data('info').curIndex = 0;
                            obj.data('info').refresh(obj);
                        },
                        page : function(obj, n) {
                            if (n > 0 && n <= obj.data('info').maxPage) {
                                obj.data('info').curIndex = n - 1;
                                obj.data('info').refresh(obj);
                            } else
                                alert('頁數錯誤。');
                        },
                        next : function(obj) {
                            if (obj.data('info').curIndex == obj.data('info').maxPage - 1)
                                alert('已到最後頁。');
                            else {
                                obj.data('info').curIndex++;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj);
                            }
                        },
                        previous : function(obj) {
                            if (obj.data('info').curIndex == 0)
                                alert('已到最前頁。');
                            else {
                                obj.data('info').curIndex--;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj);
                            }
                        },
                        refresh : function(obj) {
                            obj.width(950).height(500);
                            var t_color1 = ['rgb(210,233,255)', 'rgb(255,238,221)'];
                            var t_n = 10;
                            //分幾個區塊
                            var t_height = 350, t_width = 600;
                            var tmpPath = '<rect x="0" y="0" width="950" height="500" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
                            for (var i = 0; i < t_n; i++)
                                tmpPath += '<rect x="100" y="' + (50 + (t_height / t_n) * i) + '" width="' + t_width + '" height="' + (t_height / t_n) + '" style="fill:' + t_color1[i % t_color1.length] + ';"/>';
                            //Y軸
                            tmpPath += '<line x1="100" y1="50" x2="100" y2="' + (50 + t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';

                            var t_carno = obj.data('info').carData;
                            var t_maxMoney = obj.data('info').maxMoney;
                            var t_minMoney = obj.data('info').minMoney;
                            var t_n = round((t_width - 20) / t_carno.length, 0);
                            var x, y, w, h, bx, by, t_output, t_money;
                            tmpPath += '<text x="' + (70) + '" y="' + (20) + '" fill="black">金額</text>';

                            x = 50;
                            var t_Y = 50 + t_height - round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_height, 0);
                            tmpPath += '<line x1="95" y1="' + t_Y + '" x2="100" y2="' + t_Y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text text-anchor="end" x="90" y="' + t_Y + '" fill="black">0</text>';
                            //X軸
                            tmpPath += '<line x1="100" y1="' + (t_Y) + '" x2="' + (100 + t_width) + '" y2="' + (t_Y) + '" style="stroke:rgb(0,0,0);stroke-width:1"/>';
                            tmpPath += '<text x="' + (50 + t_width + 50) + '" y="' + (50 + t_height + 30) + '" fill="black">車牌</text>';

                            //Y
                            tmpPath += '<text text-anchor="end" x="90" y="' + (50) + '" fill="black">' + FormatNumber(t_maxMoney) + '</text>';
                            tmpPath += '<line x1="95" y1="50" x2="100" y2="50" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text text-anchor="end" x="90" y="' + (50 + t_height) + '" fill="black">' + FormatNumber(t_minMoney) + '</text>';
                            tmpPath += '<line x1="95" y1="' + (50 + t_height) + '" x2="100" y2="' + (50 + t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';

                            var t_range = round((t_maxMoney - t_minMoney) / 5, 0);
                            var i = Math.pow(10, (t_range + '').length - 1);
                            var t_range = Math.floor(t_range / i) * i;
                            t_money = t_range;
                            while (t_money < t_maxMoney) {
                                if ((t_maxMoney - t_money) / (t_maxMoney - t_minMoney) > 0.05) {
                                    y = t_Y - round(t_money / (t_maxMoney - t_minMoney) * t_height, 0);
                                    tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                                    tmpPath += '<text text-anchor="end" x="90" y="' + y + '" fill="black">' + FormatNumber(t_money) + '</text>';
                                }
                                t_money += t_range;
                            }
                            t_money = -t_range;
                            while (t_money > t_minMoney) {
                                if (Math.abs(t_minMoney - t_money) / (t_maxMoney - t_minMoney) > 0.05) {
                                    x = 90;
                                    y = t_Y - round(t_money / (t_maxMoney - t_minMoney) * t_height, 0);
                                    tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                                    tmpPath += '<text text-anchor="end" x="90" y="' + y + '" fill="black">' + FormatNumber(t_money) + '</text>';
                                }
                                t_money -= t_range;
                            }

                            //支出的顏色
                            tmpPath += '<defs>' + '<linearGradient id="chart02_outColor1" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart02_outColor2" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';

                            //支出
                            for (var i = 0; i < t_carno.length; i++) {
                                t_output = t_carno[i].outmoney;
                                h = Math.abs(round(t_output / (t_maxMoney - t_minMoney) * t_height, 0));
                                x = 100 + 10 + t_n * i - (i == 0 ? 9 : 10);
                                if (t_output >= 0) {
                                    y = t_Y - h;
                                } else {
                                    y = t_Y;
                                }
                                tmpPath += '<rect id="chart02_out' + i + '" class="chart02_out" x="' + x + '" y="' + y + '" width="' + t_n + '" height="' + h + '" fill="url(#chart02_outColor1)"/>';
                            }

                            //毛利
                            for (var i = 0; i < t_carno.length; i++) {//連接線
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_carno[i].profit / (t_maxMoney - t_minMoney) * t_height, 0);
                                if (i > 0)
                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(0,255,0);stroke-width:1"/>';
                                bx = x;
                                by = y;
                            }
                            for (var i = 0; i < t_carno.length; i++) {
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_carno[i].profit / (t_maxMoney - t_minMoney) * t_height, 0);
                                tmpPath += '<circle id="chart02_profit' + i + '" class="chart02_profit" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
                            }
                            //收入
                            for (var i = 0; i < t_carno.length; i++) {//連接線
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_carno[i].inmoney / (t_maxMoney - t_minMoney) * t_height, 0);
                                if (i > 0)
                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(255,0,0);stroke-width:1"/>';
                                bx = x;
                                by = y;
                            }
                            for (var i = 0; i < t_carno.length; i++) {
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_carno[i].inmoney / (t_maxMoney - t_minMoney) * t_height, 0);
                                tmpPath += '<circle id="chart02_in' + i + '" class="chart02_in" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
                            }
                            //X 文字
                            for (var i = 0; i < t_carno.length; i++) {
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = 50 + t_height + 40;
                                tmpPath += '<text text-anchor="middle" id="chart02_carno' + i + '" class="chart02_carno" x="' + x + '" y="' + y + '" transform="rotate(90 ' + x + ',' + y + ')" fill="black" >' + t_carno[i].carno + '</text>';
                            }
                            //符號說明
                            tmpPath += '<line x1="760" y1="50" x2="780" y2="50" style="stroke:rgb(255,0,0);stroke-width:1"/>';
                            tmpPath += '<circle class="" cx="770" cy="50" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
                            tmpPath += '<text x="790" y="55" fill="black">收入：</text>';
                            tmpPath += '<text text-anchor="end" x="910" y="55" fill="black">' + FormatNumber(obj.data('info').inmoney) + '</text>';

                            tmpPath += '<rect x="760" y="65" width="20" height="20" fill="url(#chart02_outColor1)"/>';
                            tmpPath += '<text x="790" y="80" fill="black">支出：</text>';
                            tmpPath += '<text text-anchor="end" x="910" y="80" fill="black">' + FormatNumber(obj.data('info').outmoney) + '</text>';

                            tmpPath += '<line x1="760" y1="100" x2="780" y2="100" style="stroke:rgb(0,180,125);stroke-width:1"/>';
                            tmpPath += '<circle class="" cx="770" cy="100" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
                            tmpPath += '<text x="790" y="105" fill="black">毛利：</text>';
                            tmpPath += '<text text-anchor="end" x="910" y="105" fill="black">' + FormatNumber(obj.data('info').profit) + '</text>';

                            obj.html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                            //事件
                            obj.children('svg').find('.chart02_profit').hover(function(e) {
                                $(this).attr('fill', 'rgb(151,255,151)');
                                var n = $(this).attr('id').replace('chart02_profit', '');
                                $('#chart02_carno' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'rgb(0,255,0)');
                                var n = $(this).attr('id').replace('chart02_profit', '');
                                $('#chart02_carno' + n).attr('fill', 'black');
                            });
                            obj.children('svg').find('.chart02_in').hover(function(e) {
                                $(this).attr('fill', 'rgb(255,151,151)');
                                var n = $(this).attr('id').replace('chart02_in', '');
                                $('#chart02_carno' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'rgb(255,0,0)');
                                var n = $(this).attr('id').replace('chart02_in', '');
                                $('#chart02_carno' + n).attr('fill', 'black');
                            });
                            obj.children('svg').find('.chart02_out').hover(function(e) {
                                $(this).attr('fill', 'url(#chart02_outColor2)');
                                var n = $(this).attr('id').replace('chart02_out', '');
                                $('#chart02_carno' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'url(#chart02_outColor1)');
                                var n = $(this).attr('id').replace('chart02_out', '');
                                $('#chart02_carno' + n).attr('fill', 'black');
                            }).click(function(e) {
                                var obj = $(this).parent().parent();
                                var n = $(this).attr('id').replace('chart02_out', '');

                                $('#chart02_1').chart02_1({
                                    data : obj.data('info').carData[n]
                                });
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
                $.fn.chart02_1 = function(value) {
                    $(this).data('info', {
                        curIndex : -1,
                        carData : value.data,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            obj.data('info').curIndex = 0;
                            obj.data('info').refresh(obj);
                        },
                        refresh : function(obj) {
                            obj.width(950).height(500);
                            var t_color1 = ['rgb(210,233,255)', 'rgb(255,238,221)'];
                            var t_n = 10;
                            //分幾個區塊
                            var t_height = 350, t_width = 600;
                            var tmpPath = '<rect x="0" y="0" width="950" height="500" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
                            for (var i = 0; i < t_n; i++)
                                tmpPath += '<rect x="100" y="' + (50 + (t_height / t_n) * i) + '" width="' + t_width + '" height="' + (t_height / t_n) + '" style="fill:' + t_color1[i % t_color1.length] + ';"/>';
                            //Y軸
                            tmpPath += '<line x1="100" y1="50" x2="100" y2="' + (50 + t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';

                            var t_detail = obj.data('info').carData.detail;
                            var t_maxMoney = obj.data('info').carData.maxMoney;
                            var t_minMoney = obj.data('info').carData.minMoney;
                            var t_n = round((t_width - 20) / t_detail.length, 0);
                            var x, y, w, h, bx, by, t_output, t_money;
                            tmpPath += '<text x="' + (500) + '" y="' + (20) + '" fill="black" style="font-family: \'Times New Roman\';">【' + obj.data('info').carData.carkind + '】' + obj.data('info').carData.carno + '&nbsp;' + obj.data('info').carData.caryear + '</text>';
                            tmpPath += '<text x="' + (70) + '" y="' + (20) + '" fill="black">金額</text>';

                            x = 50;
                            var t_Y = 50 + t_height - round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_height, 0);
                            tmpPath += '<line x1="95" y1="' + t_Y + '" x2="100" y2="' + t_Y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text text-anchor="end" x="90" y="' + t_Y + '" fill="black">0</text>';
                            //X軸
                            tmpPath += '<line x1="100" y1="' + (t_Y) + '" x2="' + (100 + t_width) + '" y2="' + (t_Y) + '" style="stroke:rgb(0,0,0);stroke-width:1"/>';
                            tmpPath += '<text x="' + (50 + t_width + 50) + '" y="' + (50 + t_height + 30) + '" fill="black">車牌</text>';

                            //Y
                            tmpPath += '<text text-anchor="end" x="90" y="' + (50) + '" fill="black">' + FormatNumber(t_maxMoney) + '</text>';
                            tmpPath += '<line x1="95" y1="50" x2="100" y2="50" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            tmpPath += '<text text-anchor="end" x="90" y="' + (50 + t_height) + '" fill="black">' + FormatNumber(t_minMoney) + '</text>';
                            tmpPath += '<line x1="95" y1="' + (50 + t_height) + '" x2="100" y2="' + (50 + t_height) + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';

                            var t_range = round((t_maxMoney - t_minMoney) / 5, 0);
                            var i = Math.pow(10, (t_range + '').length - 1);
                            var t_range = Math.floor(t_range / i) * i;
                            t_money = t_range;
                            while (t_money < t_maxMoney) {
                                if ((t_maxMoney - t_money) / (t_maxMoney - t_minMoney) > 0.05) {
                                    y = t_Y - round(t_money / (t_maxMoney - t_minMoney) * t_height, 0);
                                    tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                                    tmpPath += '<text text-anchor="end" x="90" y="' + y + '" fill="black">' + FormatNumber(t_money) + '</text>';
                                }
                                t_money += t_range;
                            }
                            t_money = -t_range;
                            while (t_money > t_minMoney) {
                                if (Math.abs(t_minMoney - t_money) / (t_maxMoney - t_minMoney) > 0.05) {
                                    x = 90;
                                    y = t_Y - round(t_money / (t_maxMoney - t_minMoney) * t_height, 0);
                                    tmpPath += '<line x1="95" y1="' + y + '" x2="100" y2="' + y + '" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                                    tmpPath += '<text text-anchor="end" x="90" y="' + y + '" fill="black">' + FormatNumber(t_money) + '</text>';
                                }
                                t_money -= t_range;
                            }

                            //支出的顏色
                            tmpPath += '<defs>' + '<linearGradient id="chart02_1_outColor1" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart02_1_outColor2" x1="0%" y1="0%" x2="100%" y2="0%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';

                            //支出
                            for (var i = 0; i < t_detail.length; i++) {
                                t_output = t_detail[i].outmoney;
                                h = Math.abs(round(t_output / (t_maxMoney - t_minMoney) * t_height, 0));
                                x = 100 + 10 + t_n * i - (i == 0 ? 9 : 10);
                                if (t_output >= 0) {
                                    y = t_Y - h;
                                } else {
                                    y = t_Y;
                                }
                                tmpPath += '<rect id="chart02_1_out' + i + '" class="chart02_1_out" x="' + x + '" y="' + y + '" width="' + t_n + '" height="' + h + '" fill="url(#chart02_outColor1)"/>';
                            }

                            //毛利
                            for (var i = 0; i < t_detail.length; i++) {//連接線
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_detail[i].profit / (t_maxMoney - t_minMoney) * t_height, 0);
                                if (i > 0)
                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(0,255,0);stroke-width:1"/>';
                                bx = x;
                                by = y;
                            }
                            for (var i = 0; i < t_detail.length; i++) {
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_detail[i].profit / (t_maxMoney - t_minMoney) * t_height, 0);
                                tmpPath += '<circle id="chart02_1_profit' + i + '" class="chart02_1_profit" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
                            }
                            //收入
                            for (var i = 0; i < t_detail.length; i++) {//連接線
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_detail[i].inmoney / (t_maxMoney - t_minMoney) * t_height, 0);
                                if (i > 0)
                                    tmpPath += '<line x1="' + bx + '" y1="' + by + '" x2="' + x + '" y2="' + y + '" style="stroke:rgb(255,0,0);stroke-width:1"/>';
                                bx = x;
                                by = y;
                            }
                            for (var i = 0; i < t_detail.length; i++) {
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = t_Y - round(t_detail[i].inmoney / (t_maxMoney - t_minMoney) * t_height, 0);
                                tmpPath += '<circle id="chart02_1_in' + i + '" class="chart02_1_in" cx="' + x + '" cy="' + y + '" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
                            }
                            //X 文字
                            for (var i = 0; i < t_detail.length; i++) {
                                x = round(100 + t_n * (i + 1) - t_n / 2, 0);
                                y = 50 + t_height + 40;
                                tmpPath += '<text text-anchor="middle" id="chart02_1_mon' + i + '" class="chart02_1_mon" x="' + x + '" y="' + y + '" transform="rotate(45 ' + x + ',' + y + ')" fill="black">' + t_detail[i].mon + '</text>';
                            }
                            //符號說明
                            tmpPath += '<line x1="760" y1="50" x2="780" y2="50" style="stroke:rgb(255,0,0);stroke-width:1"/>';
                            tmpPath += '<circle class="" cx="770" cy="50" r="5" stroke="black" stroke-width="2" fill="rgb(255,0,0)"/>';
                            tmpPath += '<text x="790" y="55" fill="black">收入：</text>';
                            tmpPath += '<text text-anchor="end" x="910" y="55" fill="black">' + FormatNumber(obj.data('info').carData.inmoney) + '</text>';

                            tmpPath += '<rect x="760" y="65" width="20" height="20" fill="url(#chart02_outColor1)"/>';
                            tmpPath += '<text x="790" y="80" fill="black">支出：</text>';
                            tmpPath += '<text text-anchor="end" x="910" y="80" fill="black">' + FormatNumber(obj.data('info').carData.outmoney) + '</text>';

                            tmpPath += '<line x1="760" y1="100" x2="780" y2="100" style="stroke:rgb(0,180,125);stroke-width:1"/>';
                            tmpPath += '<circle class="" cx="770" cy="100" r="5" stroke="black" stroke-width="2" fill="rgb(0,255,0)"/>';
                            tmpPath += '<text x="790" y="105" fill="black">毛利：</text>';
                            tmpPath += '<text text-anchor="end" x="910" y="105" fill="black">' + FormatNumber(obj.data('info').carData.profit) + '</text>';

                            obj.html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                            //事件
                            obj.children('svg').find('.chart02_1_profit').hover(function(e) {
                                $(this).attr('fill', 'rgb(151,255,151)');
                                var n = $(this).attr('id').replace('chart02_1_profit', '');
                                $('#chart02_1_mon' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'rgb(0,255,0)');
                                var n = $(this).attr('id').replace('chart02_1_profit', '');
                                $('#chart02_1_mon' + n).attr('fill', 'black');
                            });
                            obj.children('svg').find('.chart02_1_in').hover(function(e) {
                                $(this).attr('fill', 'rgb(255,151,151)');
                                var n = $(this).attr('id').replace('chart02_1_in', '');
                                $('#chart02_1_mon' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'rgb(255,0,0)');
                                var n = $(this).attr('id').replace('chart02_1_in', '');
                                $('#chart02_1_mon' + n).attr('fill', 'black');
                            });
                            obj.children('svg').find('.chart02_1_out').hover(function(e) {
                                $(this).attr('fill', 'url(#chart02_1_outColor2)');
                                var n = $(this).attr('id').replace('chart02_1_out', '');
                                $('#chart02_1_mon' + n).attr('fill', 'rgb(187,94,0)');
                            }, function(e) {
                                $(this).attr('fill', 'url(#chart02_1_outColor1)');
                                var n = $(this).attr('id').replace('chart02_1_out', '');
                                $('#chart02_1_mon' + n).attr('fill', 'black');
                            }).click(function(e) {
                                var obj = $(this).parent().parent();
                                var n = $(this).attr('id').replace('chart02_1_out', '');

                                $('#chart02_2').chart02_2({
                                    carkind : obj.data('info').carData.carkind,
                                    carno : obj.data('info').carData.carno,
                                    mon : obj.data('info').carData.detail[n].mon,
                                    driverpay : obj.data('info').carData.detail[n].driverpay,
                                    data : [{
                                        text : '業績獎金：',
                                        value : obj.data('info').carData.detail[n].carsal
                                    }, {
                                        text : '油　　費：',
                                        value : obj.data('info').carData.detail[n].oilmoney
                                    }, {
                                        text : '通行費　：',
                                        value : obj.data('info').carData.detail[n].tolls
                                    }, {
                                        text : '罰　　單：',
                                        value : obj.data('info').carData.detail[n].ticket
                                    }, {
                                        text : '寄櫃費　：',
                                        value : obj.data('info').carData.detail[n].reserve
                                    }, {
                                        text : '車輛維修：',
                                        value : obj.data('info').carData.detail[n].fixa1
                                    }, {
                                        text : '板台維修：',
                                        value : obj.data('info').carData.detail[n].fixa2
                                    }, {
                                        text : '車輛輪胎：',
                                        value : obj.data('info').carData.detail[n].tire1
                                    }, {
                                        text : '板台輪胎：',
                                        value : obj.data('info').carData.detail[n].tire2
                                    }, {
                                        text : '保牌燃費：',
                                        value : obj.data('info').carData.detail[n].tax
                                    }, {
                                        text : '折　　舊：',
                                        value : obj.data('info').carData.detail[n].depreciation
                                    }],
                                    x : 200,
                                    y : 200,
                                    radius : 150
                                });
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
                $.fn.chart02_2 = function(value) {
                    $(this).data('info', {
                        value : value,
                        fillColor : ["#E76E6D", "#E7AB6D", "#E6E76D", "#A9E76D", "#6DA9E7", "#AB6DE7", "#E76DE6", "#1FBBBD", "#6D924A", "#19FCFF", "#FF19FC"],
                        strokeColor : ["#000000"],
                        focusfillColor : "#FFEEFE",
                        focusIndex : -1,
                        init : function(obj) {
                            obj.addClass('pieChart');
                            var tmp = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                tmp += obj.data('info').value.data[i].value;
                            }
                            var tmpDegree = 0;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                obj.data('info').value.data[i].rate = obj.data('info').value.data[i].value / tmp;
                                obj.data('info').value.data[i].degree = 2 * Math.PI * obj.data('info').value.data[i].rate;
                                obj.data('info').value.data[i].bDegree = tmpDegree;
                                tmpDegree += obj.data('info').value.data[i].degree;
                                obj.data('info').value.data[i].eDegree = tmpDegree;
                                obj.data('info').value.data[i].fillColor = obj.data('info').fillColor[i % obj.data('info').fillColor.length];
                                obj.data('info').value.data[i].strokeColor = obj.data('info').strokeColor[i % obj.data('info').strokeColor.length];
                            }
                            obj.data('info').refresh(obj);
                        },
                        refresh : function(obj) {
                            obj.width(600).height(450);
                            obj.html('');
                            var tmpPath = '', degree, fillColor, strokeColor, t_text;
                            var x = obj.data('info').value.x;
                            var y = obj.data('info').value.y;
                            var radius = obj.data('info').value.radius;
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                fillColor = '"' + obj.data('info').value.data[i].fillColor + '"';
                                strokeColor = '"' + obj.data('info').value.data[i].strokeColor + '"';

                                degree = Math.round(obj.data('info').value.data[i].degree * 360 / (2 * Math.PI), 0);
                                obj.data('info').value.data[i].currentFillColor = fillColor;
                                obj.data('info').value.data[i].currentStrokeColor = strokeColor;
                                obj.data('info').value.data[i].point1 = [x, y];
                                obj.data('info').value.data[i].point2 = [x + Math.round(radius * Math.cos(obj.data('info').value.data[i].bDegree), 0), y + Math.round(radius * Math.sin(obj.data('info').value.data[i].bDegree), 0)];
                                obj.data('info').value.data[i].point3 = [x + Math.round(radius * Math.cos(obj.data('info').value.data[i].eDegree), 0), y + Math.round(radius * Math.sin(obj.data('info').value.data[i].eDegree), 0)];
                                var pointLogo = [x + radius + 20, i * 20 + 30];
                                var pointText = [x + radius + 35, i * 20 + 40];
                                tmpPath += '<rect class="blockLogo" id="blockLogo_' + i + '" width="10" height="10" x="' + pointLogo[0] + '" y="' + pointLogo[1] + '" fill=' + fillColor + ' stroke=' + strokeColor + '/>';
                                tmpPath += '<text class="blockText" id="blockText_' + i + '" x="' + pointText[0] + '" y="' + pointText[1] + '" fill="#000000" >' + obj.data('info').value.data[i].text + '</text>';
                                var t_text = FormatNumber(obj.data('info').value.data[i].value);
                                tmpPath += '<text class="blockText" id="blockText_' + i + '" text-anchor="end"  x="' + (pointText[0] + 150) + '" y="' + pointText[1] + '" fill="#000000" >' + t_text + '</text>';
                                if (degree != 360)
                                    tmpPath += '<path class="block" id="block_' + i + '" d="M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + (degree > 180 ? ' 1 1 ' : ' 0 1 ') + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
                                else
                                    tmpPath += '<circle class="block" id="block_' + i + '" cx="' + x + '" cy="' + y + '" r="' + radius + '" fill=' + obj.data('info').value.data[i].currentFillColor + ' stroke=' + obj.data('info').value.data[i].currentStrokeColor + '/>';
                            }
                            //司機維修自付
                            pointText = [x + radius + 35, obj.data('info').value.data.length * 20 + 40];
                            tmpPath += '<text class="blockText" id="blockText_' + i + '" x="' + pointText[0] + '" y="' + pointText[1] + '" fill="#000000" >司機自付：</text>';
                            t_text = FormatNumber(obj.data('info').value.driverpay);
                            tmpPath += '<text class="blockText" id="blockText_' + i + '" text-anchor="end"  x="' + (pointText[0] + 150) + '" y="' + pointText[1] + '" fill="#000000" >' + t_text + '</text>';

                            tmpPath += '<text x="20" y="40" fill="black">【' + obj.data('info').value.carkind + '】' + obj.data('info').value.carno + '</text>';
                            tmpPath += '<text x="200" y="40" fill="black">' + obj.data('info').value.mon + '</text>';
                            obj.append('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                            for ( i = 0; i < obj.data('info').value.data.length; i++) {
                                obj.children('svg').find('.block').eq(i).data('info', {
                                    index : i
                                });
                                obj.children('svg').find('.blockLogo').eq(i).data('info', {
                                    index : i
                                });
                                obj.children('svg').find('.blockText').eq(i).data('info', {
                                    index : i
                                });
                            }
                            obj.children('svg').find('.block,.blockLogo,.blockText').hover(function(e) {
                                var obj = $(this).parent().parent();
                                $('#block_' + $(this).data('info').index).attr('fill', obj.data('info').focusfillColor);
                                $('#blockLogo_' + $(this).data('info').index).attr('fill', obj.data('info').focusfillColor);

                                var i = $(this).data('info').index;
                                var x = obj.data('info').value.x;
                                var y = obj.data('info').value.y;
                                var radius = obj.data('info').value.radius;
                                degree = Math.round(obj.data('info').value.data[i].degree * 360 / (2 * Math.PI), 0);
                                shiftX = Math.round(10 * Math.cos(obj.data('info').value.data[i].bDegree + obj.data('info').value.data[i].degree / 2), 0);
                                shiftY = Math.round(10 * Math.sin(obj.data('info').value.data[i].bDegree + obj.data('info').value.data[i].degree / 2), 0);
                                obj.data('info').value.data[i].point1 = [x + shiftX, y + shiftY];
                                obj.data('info').value.data[i].point2 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].bDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].bDegree), 0)];
                                obj.data('info').value.data[i].point3 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].eDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].eDegree), 0)];
                                if (degree != 360) {
                                    $('#block_' + i).attr('d', 'M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + (degree > 180 ? ' 1 1 ' : ' 0 1 ') + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z');
                                }
                            }, function(e) {
                                var obj = $(this).parent().parent();
                                $('#block_' + $(this).data('info').index).attr('fill', obj.data('info').fillColor[$(this).data('info').index]);
                                $('#blockLogo_' + $(this).data('info').index).attr('fill', obj.data('info').fillColor[$(this).data('info').index]);

                                var i = $(this).data('info').index;
                                var x = obj.data('info').value.x;
                                var y = obj.data('info').value.y;
                                var radius = obj.data('info').value.radius;
                                degree = Math.round(obj.data('info').value.data[i].degree * 360 / (2 * Math.PI), 0);
                                shiftX = 0;
                                shiftY = 0;
                                obj.data('info').value.data[i].point1 = [x + shiftX, y + shiftY];
                                obj.data('info').value.data[i].point2 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].bDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].bDegree), 0)];
                                obj.data('info').value.data[i].point3 = [x + shiftX + Math.round(radius * Math.cos(obj.data('info').value.data[i].eDegree), 0), y + shiftY + Math.round(radius * Math.sin(obj.data('info').value.data[i].eDegree), 0)];
                                if (degree != 360) {
                                    $('#block_' + i).attr('d', 'M' + obj.data('info').value.data[i].point1[0] + ' ' + obj.data('info').value.data[i].point1[1] + ' L' + obj.data('info').value.data[i].point2[0] + ' ' + obj.data('info').value.data[i].point2[1] + ' A' + radius + ' ' + radius + ' ' + degree + (degree > 180 ? ' 1 1 ' : ' 0 1 ') + obj.data('info').value.data[i].point3[0] + ' ' + obj.data('info').value.data[i].point3[1] + ' Z');
                                }
                            }).click(function(e) {
                                var obj = $(this).parent().parent();
                                //alert(obj.data('info').value.data[$(this).data('info').index].text);
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
                $.fn.barChart03 = function(value) {
                    $(this).data('info', {
                        curIndex : -1,
                        custData : value.data,
                        maxMoney : value.maxMoney,
                        minMoney : value.minMoney,
                        maxPage : 1,
                        init : function(obj) {
                            if (value.length == 0) {
                                alert('無資料。');
                                return;
                            }
                            obj.data('info').curIndex = 0;
                            obj.data('info').refresh(obj);
                        },
                        page : function(obj, n) {
                            if (n > 0 && n <= obj.data('info').maxPage) {
                                obj.data('info').curIndex = n - 1;
                                obj.data('info').refresh(obj);
                            } else
                                alert('頁數錯誤。');
                        },
                        next : function(obj) {
                            if (obj.data('info').curIndex == obj.data('info').maxPage - 1)
                                alert('已到最後頁。');
                            else {
                                obj.data('info').curIndex++;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj);
                            }
                        },
                        previous : function(obj) {
                            if (obj.data('info').curIndex == 0)
                                alert('已到最前頁。');
                            else {
                                obj.data('info').curIndex--;
                                $('#txtCurPage').val(obj.data('info').curIndex + 1);
                                obj.data('info').refresh(obj);
                            }
                        },
                        refresh : function(obj) {
                            var objWidth = 950;
                            var objHeight = obj.data('info').custData.length * 40 + 200;
                            //背景
                            var tmpPath = '<rect x="0" y="0" width="' + objWidth + '" height="' + objHeight + '" style="fill:rgb(220,220,220);stroke-width:1;stroke:rgb(0,0,0)"/>';
                            //圖表背景顏色
                            var bkColor1 = ['rgb(210,233,255)', 'rgb(255,238,221)'];
                            //圖表分幾個區塊
                            var bkN = 10;
                            var strX = 100, strY = 50;                      
                            var t_width = 700;
                            var t_height = obj.data('info').custData.length * 40;

                            for (var i = 0; i < bkN; i++) {
                                x = Math.round(t_width / bkN, 0) * i;
                                y = 0;
                                tmpPath += '<rect x="' + (strX + x) + '" y="' + (strY + y) + '" width="' + Math.round(t_width / bkN, 0) + '" height="' + (t_height) + '" style="fill:' + bkColor1[i % bkColor1.length] + ';"/>';
                            }
							
							var t_maxMoney = obj.data('info').maxMoney;
                            var t_minMoney = obj.data('info').minMoney;
                            var t_X = strX + round((0 - t_minMoney) / (t_maxMoney - t_minMoney) * t_width, 0);                                
							
							var t_detail = obj.data('info').custData;
							t_detail.sort(function(a,b){
								return b.inmoney-a.inmoney;
							});
							tmpPath += '<defs>' + '<linearGradient id="chart03_color3" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(206,206,255);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,147,255);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart03_color2" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(255,220,185);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,175,96);stop-opacity:1" />' + '</linearGradient>' + '</defs>';					
                            tmpPath += '<defs>' + '<linearGradient id="chart03_color4" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(206,255,206);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(147,255,147);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
                            tmpPath += '<defs>' + '<linearGradient id="chart03_color1" x1="0%" y1="0%" x2="0%" y2="100%">' + '<stop offset="0%" style="stop-color:rgb(255,185,220);stop-opacity:1" />' + '<stop offset="100%" style="stop-color:rgb(225,96,175);stop-opacity:1" />' + '</linearGradient>' + '</defs>';
							for (var i = 0; i < t_detail.length; i++) {    
								tmpPath +='<g id="chart03_item'+i+'">';
								//客戶名稱      
                                x = strX - 5;
 								y = strY + i*40 + 24;
                                tmpPath += '<text class="chart03_item" id="chart03_nick'+i+'" text-anchor="end"  x="'+x+'" y="'+y+'" fill="#000000" >'+t_detail[i].nick+'</text>';	
                            	//收入
                            	t_output = t_detail[i].inmoney;
                                W = Math.abs(round(t_output / (t_maxMoney - t_minMoney) * t_width, 0));
                                if(t_output>0){
                                	x = t_X;
                                }else{
                                	x = t_X - W;
                                } 
 								y = strY + i*40 + 5;
                                tmpPath += '<rect class="chart03_item" id="chart03_inmoney' + i + '" x="' + x + '" y="' + y + '" width="' + W + '" height="' + 15 + '" fill="url(#chart03_color1)"/>';
                            	tmpPath += '<text class="chart03_item" id="chart03_cinmoney'+i+'" x="'+(x+W+5)+'" y="'+(y+15)+'" fill="#000000" >'+FormatNumber(t_output)+'</text>';	
                            	//毛利
                            	t_output = t_detail[i].profit;
                                W = Math.abs(round(t_output / (t_maxMoney - t_minMoney) * t_width, 0));
                                if(t_output>0){
                                	x = t_X;
                                }else{
                                	x = t_X - W;
                                }                          
 								y = strY + i*40 + 20;
                                tmpPath += '<rect class="chart03_item" id="chart03_profit' + i + '" x="' + x + '" y="' + y + '" width="' + W + '" height="' + 15 + '" fill="url(#chart03_color3)"/>';
                           		tmpPath += '<text class="chart03_item" id="chart03_cprofit'+i+'" x="'+(x+W + 5)+'" y="'+(y+15)+'" fill="#000000" >'+FormatNumber(t_output)+'</text>';	
                            	
                            	tmpPath +='</g>';
                            }
                            //X軸
                            tmpPath += '<line x1="'+strX+'" y1="'+strY+'" x2="'+(strX+t_width)+'" y2="'+strY+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
							//tmpPath += '<text text-anchor="end"  x="'+t_X+'" y="'+(strY-5)+'" fill="#000000" >0</text>';
							tmpPath += '<text x="'+strX+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_minMoney)+'</text>';
							tmpPath += '<text text-anchor="end"  x="'+(strX+t_width)+'" y="'+(strY-5)+'" fill="#000000" >'+FormatNumber(t_maxMoney)+'</text>';						
							//Y軸
                            tmpPath += '<line x1="'+t_X+'" y1="'+strY+'" x2="'+t_X+'" y2="'+(strY+obj.data('info').custData.length * 40)+'" style="stroke:rgb(0,0,0);stroke-width:2"/>';
                            
                            //符號說明
                            tmpPath += '<rect x="'+(strX+t_width+50)+'" y="5" width="20" height="20" fill="url(#chart03_color1)"/>';
                            tmpPath += '<text x="'+(strX+t_width+70)+'" y="20" fill="black">運費收入</text>';
							tmpPath += '<rect x="'+(strX+t_width+50)+'" y="30" width="20" height="20" fill="url(#chart03_color3)"/>';
                            tmpPath += '<text x="'+(strX+t_width+70)+'" y="45" fill="black">毛利</text>';
							
                            obj.width(objWidth).height(objHeight).html('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" class="graph">' + tmpPath + '</svg> ');
                        	
                        	//事件
                        	obj.children('svg').find('.chart03_item').hover(function(e) {
                        		var n = $(this).parent().attr('id').replace('chart03_item','');
                        		
                                $('#chart03_nick'+n).attr('fill', 'rgb(255,0,0)');
                                $('#chart03_inmoney'+n).attr('fill', 'url(#chart03_color2)');
                                $('#chart03_cinmoney'+n).attr('fill', 'rgb(255,0,0)');
                                $('#chart03_profit'+n).attr('fill', 'url(#chart03_color4)');
                                $('#chart03_cprofit'+n).attr('fill', 'rgb(255,0,0)');
                               
                            }, function(e) {
                                var n = $(this).parent().attr('id').replace('chart03_item','');
                        		
                                $('#chart03_nick'+n).attr('fill', 'rgb(0,0,0)');
                                $('#chart03_inmoney'+n).attr('fill', 'url(#chart03_color1)');
                                $('#chart03_cinmoney'+n).attr('fill', 'rgb(0,0,0)');
                                $('#chart03_profit'+n).attr('fill', 'url(#chart03_color3)');
                                $('#chart03_cprofit'+n).attr('fill', 'rgb(0,0,0)');
                            });
                        }
                    });
                    $(this).data('info').init($(this));
                }
            })($);
            
		</script>
		<style type="text/css">
            .pieChart .graph {
                position: relative;
            }
            .control {
                display: none;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container" style="width:2000px;">
				<div id="q_report"></div>
				<input type="button" id="btnXXX" style="float:left; width:80px;font-size: medium;" value="權限"/>
			</div>
			<div style="display:inline-block;width:2000px;">
				<input type="button" id="btnRun" style="float:left; width:80px;font-size: medium;" value="執行"/>
				<input type="button" id="btnPrevious" class="control" style="float:left; width:80px;font-size: medium;" value="上一頁"/>
				<input type="button" id="btnNext" class="control" style="float:left; width:80px;font-size: medium;" value="下一頁"/>
				<input type="text" id="txtCurPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;"/>
				<span style="display:block; float:left; width:20px;"><label class="control" style="vertical-align: middle;font-size: medium;">／</label></span>
				<input type="text" id="txtTotPage" class="control" style="float:left;text-align: right;width:60px; font-size: medium;" readonly="readonly"/>
			</div>
			<div id="chart">
				<div id='Loading' class="z_anatran chart"></div>
				<div id='chart01' class="z_anatran chart"></div>
				<div id='chart01_1' class="z_anatran chart"></div>

				<div id='chart02' class="z_anatran chart"></div>
				<div id='chart02_1' class="z_anatran chart"></div>
				<div id='chart02_2' class="z_anatran chart"></div>

				<div id='chart03' class="z_anatran chart"></div>
			</div>
		</div>
		<div class="prt" style="display:none;">
			<!--#include file="../inc/print_ctrl.inc"-->
		</div>
	</body>
</html>