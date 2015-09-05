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
            aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx'], ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx']);
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            function z_tran() {
            }

            z_tran.prototype = {
                data : {
                    carteam : null,
                    calctypes : null,
                    calctype : null,
                    carkind : null,
                    acomp : null
                }
            };
            t_data = new z_tran();

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gt('carkind', '', 0, 0, 0, "");
                
            });
            function q_gfPost() {
            	loadFinish();
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'carkind':
                        t_data.data['carkind'] = '';
                        var as = _q_appendData("carkind", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['carkind'] += (t_data.data['carkind'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
                        }
                        q_gt('carteam', '', 0, 0, 0, "");
                        break;
                    case 'carteam':
                        t_data.data['carteam'] = '';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['carteam'] += (t_data.data['carteam'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_gt('calctype', '', 0, 0, 0);
                        break;
                    case 'calctype':
                        t_data.data['calctype'] = '';
                        var as = _q_appendData("calctype", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['calctype'] += (t_data.data['calctype'].length > 0 ? ',' : '') + 'calctype_' + as[i].noa + '@' + as[i].namea;
                        }
                         q_gt('calctype2', '', 0, 0, 0, "calctypes");
                        break;
                    case 'calctypes':
                        t_data.data['calctypes'] = '';
                        var as = _q_appendData("calctypes", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['calctypes'] += (t_data.data['calctypes'].length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                        }
                        q_gt('acomp', '', 0, 0, 0);
                        break;
                    case 'acomp':
                        t_data.data['acomp'] = '';
                        var as = _q_appendData("acomp", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_data.data['acomp'] += ',' + as[i].acomp;
                        }
                        q_gf('', 'z_tran');
                        
                        break;
                }

            }

            function q_boxClose(t_name) {
            }

            function loadFinish() {
                $('#q_report').q_report({
                    fileName : 'z_tran',
                    options : [{/*[1]*/
                        type : '0',
                        name : 'accy',
                        value : q_getId()[4]
                    }, {/*1-[2][3]登錄日期*///*1-1
                        type : '1',
                        name : 'date'
                    }, {/*2-[4][5]交運日期*///*1-2
                        type : '1',
                        name : 'trandate'
                    }, {/*3-[6][7]客戶*///*1-4
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*4-[8][9]司機*///*1-8
                        type : '2',
                        name : 'driver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {/*5-[10]車牌*///*2-1
                        type : '6',
                        name : 'xcarno'
                    }, {/*6-[11]PO*///*2-2
                        type : '6',
                        name : 'xpo'
                    }, {/*7-[12][13]起迄地點*///*2-4
                        type : '2',
                        name : 'addr',
                        dbf : 'addr',
                        index : 'noa,addr',
                        src : 'addr_b.aspx'
                    }, {/*8-[14]公司*///*2-8
                        type : '5',
                        name : 'xacomp',
                        value : t_data.data['acomp'].split(',')
                    }, {/*9-[15]其他選項-(收金額、發金額)*///*3-1
                        type : '5',
                        name : 'xoption1',
                        value : q_getMsg('toption1').split('&')
                    }, {/*10-[16]其他選項-(含折扣)*///*3-2
                        type : '8',
                        name : 'xoption2',
                        value : q_getMsg('toption2').split('&')
                    }, {/*11-[17]選項-(公司車折扣、外車折扣)*///*3-4
                        type : '8',
                        name : 'xoption3',
                        value : q_getMsg('toption3').split('&')
                    }, {/*12-[18]車隊*///*3-8
                        type : '8',
                        name : 'xcarteam',
                        value : t_data.data['carteam'].split(',')
                    }, {/*13-[19]車種*///*4-1
                        type : '8',
                        name : 'xcarkind',
                        value : t_data.data['carkind'].split(',')
                    }, {/*14-[20]計算類別*///*4-2
                        type : '8',
                        name : 'xcalctypes',
                        value : t_data.data['calctypes'].split(',')
                    }, {/*15-[21]品名*///*4-4
                        type : '6',
                        name : 'zproduct'
                    }, {/*16-[22]起迄地點*///*4-8
                        type : '6',
                        name : 'zaddr'
                    }, {/*17-[23]船名*///*5-1
                        type : '6',
                        name : 'zboatname'
                    }, {/*18-[24]提單編號*///*5-2
                        type : '6',
                        name : 'zdelivery'
                    }, {/*19-[25]加項金額*///*5-4
                        type : '6',
                        name : 'zplusmoney'
                    }, {/*20-[26]減項金額*///*5-8
                        type : '6',
                        name : 'zminusmoney'
                    }, {/*21-[27]排序(登錄日期、憑單號碼、交運日期、車號)*///*6-1
                        type : '5',
                        name : 'xsort8',
                        value : q_getMsg('tsort08').split('&')
                    }, {/*22-[28]欄位顯示*///*6-2
                        type : '8',
                        name : 'xfield05',
                        value : q_getMsg('tfield05').split('&')
                    }, {/*23-[29]排序(電腦編號、登錄日期、交運日期、車牌、客戶編號、司機編號、起迄地點)*///*6-4
                        type : '5',
                        name : 'xsort03',
                        value : q_getMsg('tsort03').split('&')
                    }, {/*24-[30]排序(客戶、PO)*///*6-8
                        type : '5',
                        name : 'xsort14',
                        value : q_getMsg('tsort14').split('&')
                    }, {/*25-[31][32]  外務   trans.sales*///*7-1
                        type : '2',
                        name : 'sales',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {/*26-[33]排序(貨櫃、平板、散裝、中鋼、唐榮)*///*7-2
                        type : '5',
                        name : 'xsort6',
                        value : t_data.data['carteam'].split(',')
                    }, {/*27-[34][35]  業務  cust.sales*///*7-4
                        type : '2',
                        name : 'sales2',
                        dbf : 'sss',
                        index : 'noa,namea',
                        src : 'sss_b.aspx'
                    }, {/*28-[36]排序(客戶編號、收金額)*///*7-8
                        type : '5',
                        name : 'xsort18',
                        value : q_getMsg('tsort18').split('&')
                    }, {/*29-[37]耗油比(%)*///*8-1
                        type : '6',
                        name : 'ycheckrate'
                    }, {/*30-[38]排序(耗油比、交運日期、司機、年份、收入、淨利)*///*8-2
                        type : '5',
                        name : 'ysort01',
                        value : q_getMsg('tsort01').split('&')
                    }, {/*31-[39]其他設定(出車明細、加油明細)*///*8-4
                        type : '8',
                        name : 'yfilter',
                        value : q_getMsg('tfilter').split('&')
                    }, {/*32-[40]其他設定(指定車牌)*///*8-8
                        type : '8',
                        name : 'yoption01',
                        value : q_getMsg('toption').split('&')
                    }, {/*33-[41]欄位(櫃號、車牌)*///*9-1
                        type : '5',
                        name : 'yoption27',
                        value : q_getMsg('toption27').split('&')
                    }, {/*34-[42]排序(司機、車牌、淨利)*///*9-2
                        type : '5',
                        name : 'ysort22',
                        value : q_getMsg('tsort22').split('&')
                    }, {/*35-[43] 其他設定*/
                        type : '8',
                        name : 'yoption28',
                        value : q_getMsg('toption28').split('&')
                    },{/*36-[44][45]交運月份*/
                        type : '1',
                        name : 'wmon'
                    }, {/*37-[46][47]司機*/
                        type : '2',
                        name : 'wdriver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {/*38-[48]車牌*/
                        type : '6',
                        name : 'wcarno'
                    }, {/*39-[49]車種*/
                        type : '8',
                        name : 'wcarkind',
                        value : t_data.data['carkind'].split(',')
                    }, {/*40-[50]明細*/
                        type : '8',
                        name : 'wdetail',
                        value : ['detail@明細']
                    }, {/*41-[51][52]出車單號*///*11-1
                        type : '1',
                        name : 'xnoa'
                    }, {/*42-[53]貨櫃號碼*///*11-2
                        type : '6',
                        name : 'xcaseno'
                    }, {/*43-[54]*///*11-3
                        type : '8',
                        name : 'xoption30',
                        value : q_getMsg('toption30').split('&')
                    }, {/*44-[55]品名(20、40)*///*11-4
                        type : '5',
                        name : 'xproduct',
                        value : q_getMsg('xproduct').split('&')
                    }]
                });
                q_popAssign();
                q_langShow();
                $('#btnOk').hide();
                $('#btnOk2').click(function(e) {
                    var msg_datea = '', msg_trandate = '';
                    var patt = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    var t_date1 = $.trim($('#txtDate1').val());
                    var t_date2 = $.trim($('#txtDate2').val());
                    var t_trandate1 = $.trim($('#txtTrandate1').val());
                    var t_trandate2 = $.trim($('#txtTrandate2').val());
                    var t_po = $.trim($('#txtXpo').val());
                    //check datea
                    if (t_date1.length == 0) {
                        msg_datea = '請輸入起始登錄日期。';
                    } else if (t_date2.length == 0) {
                        msg_datea = '請輸入終止登錄日期。';
                    } else if (!patt.test((parseInt(t_date1.substring(0, 3)) + 1911) + t_date1.substring(3))) {
                        msg_datea = t_date1 + ' 起始登錄日期異常。';
                    } else if (!patt.test((parseInt(t_date2.substring(0, 3)) + 1911) + t_date2.substring(3))) {
                        msg_datea = t_date2 + ' 終止登錄日期異常。';
                    }
                    if (msg_datea.length == 0) {
                        var d1 = new Date(parseInt(t_date1.substr(0, 3)) + 1911, parseInt(t_date1.substring(4, 6)) - 1, parseInt(t_date1.substring(7, 9)));
                        var d2 = new Date(parseInt(t_date2.substr(0, 3)) + 1911, parseInt(t_date2.substring(4, 6)) - 1, parseInt(t_date2.substring(7, 9)));
                        if (d2 < d1) {
                            msg_datea = '日期異常：終止日期<起始日期。';
                        } else if ((Math.abs(d2 - d1) / (1000 * 60 * 60 * 24) + 1) > 366) {
                            msg_datea = '查詢日數不得大於３６６天。';
                        }
                    }

                    //check trandate
                    if (t_trandate1.length == 0) {
                        msg_trandate = '請輸入起始交運日期。';
                    } else if (t_trandate2.length == 0) {
                        msg_trandate = '請輸入終止交運日期。';
                    } else if (!patt.test((parseInt(t_trandate1.substring(0, 3)) + 1911) + t_trandate1.substring(3))) {
                        msg_trandate = t_trandate1 + ' 起始交運日期異常。';
                    } else if (!patt.test((parseInt(t_trandate2.substring(0, 3)) + 1911) + t_trandate2.substring(3))) {
                        msg_trandate = t_trandate2 + ' 終止交運日期異常。';
                    }
                    if (msg_trandate.length == 0) {
                        var d1 = new Date(parseInt(t_trandate1.substr(0, 3)) + 1911, parseInt(t_trandate1.substring(4, 6)) - 1, parseInt(t_trandate1.substring(7, 9)));
                        var d2 = new Date(parseInt(t_trandate2.substr(0, 3)) + 1911, parseInt(t_trandate2.substring(4, 6)) - 1, parseInt(t_trandate2.substring(7, 9)));
                        if (d2 < d1) {
                            msg_trandate = '日期異常：終止日期<起始日期。';
                        } else if ((Math.abs(d2 - d1) / (1000 * 60 * 60 * 24) + 1) > 366) {
                            msg_trandate = '查詢日數不得大於３６６天。';
                        }
                    }
                    //---------------------
                    switch($('#q_report').data('info').radioIndex) {
                        case 0:
                            //營運日報表
                            if (msg_trandate.length > 0) {
                                alert(msg_trandate);
                                return false;
                            }
                            break;
                        case 1:
                            //客戶差額統計表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 2:
                            /*//營運月報表-車號司機
                            if (msg_datea.length > 0) {
                                alert(msg_datea);
                                return false;
                            }*/
                            if($.trim($('#txtWmon1').val()).length==0 || $.trim($('#txtWmon1').val()).length==0){
                                alert('請輸入'+q_getMsg('lblWmon'));
                                return false;
                            }
                            break;
                        case 3:
                            //司機差額統計表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 4:
                            //請款明細表-散裝
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 5:
                            //營業額統計表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 6:
                            //請款明細表-貨櫃
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 7:
                            //請款明細表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 8:
                            //公里數統計表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 9:
                            //業績油費耗用表
                            if (msg_datea.length > 0) {
                                alert(msg_datea);
                                return false;
                            }
                            break;
                        case 10:
                            //公司車未出勤明細表
                            if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 11:
                            //現場人員業績表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 12:
                            //出車明細表(收、發)
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 13:
                            //客戶月報明細表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 14:
                            //出車明細表-A5
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 15:
                            //客戶月報統計表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 16:
                            //出車明細表*
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 17:
                            //營業額統計表(數量)
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 18:
                            //業務業績表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 19:
                            //碼頭重量差異表
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 20:
                            //請款明細表(中鋼散裝)
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                        case 21:
                            //營運月報表-車號
                            /*if (msg_datea.length > 0) {
                                alert(msg_datea);
                                return false;
                            }*/
                            if($.trim($('#txtWmon1').val()).length==0 || $.trim($('#txtWmon1').val()).length==0){
                                alert('請輸入'+q_getMsg('lblWmon'));
                                return false;
                            }
                            break;
                        case 22:
                            //營運月報表-司機
                            /*if (msg_datea.length > 0) {
                                alert(msg_datea);
                                return false;
                            }*/
                            if($.trim($('#txtWmon1').val()).length==0 || $.trim($('#txtWmon1').val()).length==0){
                                alert('請輸入'+q_getMsg('lblWmon'));
                                return false;
                            }
                            break;
                        case 23:
                            //營運月報統計表
                            if (msg_datea.length > 0) {
                                alert(msg_datea);
                                return false;
                            }
                            break;
                        case 24:
                            //請款明細表(威致)
                            if (t_po.length > 0) {

                            } else if (msg_datea.length == 0 || msg_trandate.length == 0) {

                            } else {
                                alert(msg_datea + '\n' + msg_trandate);
                                return false;
                            }
                            break;
                         case 25:
                            //請款明細(港務局)
                            if (msg_trandate.length > 0) {
                                alert(msg_trandate);
                                return false;
                            }
                            break;
                          case 26:
                            //港務局報表
                            if (msg_trandate.length > 0) {
                                alert(msg_trandate);
                                return false;
                            }
                            break;        
                        default:
                            alert('Undefined,radio');
                            break;
                    }
                    $('#btnOk').click();
                });
                $('#txtDate1').mask('999/99/99');
                $('#txtDate1').datepicker();
                $('#txtDate2').mask('999/99/99');
                $('#txtDate2').datepicker();
                $('#txtTrandate1').mask('999/99/99');
                $('#txtTrandate2').mask('999/99/99');
                $('#txtTrandate1').datepicker();
                $('#txtTrandate2').datepicker();
                
                $('#txtWmon1').mask('999/99');
                $('#txtWmon2').mask('999/99');

                $('#chkXoption2').children('input').attr('checked', 'checked');
                $('#chkXcarteam').children('input').attr('checked', 'checked');
                $('#chkXcarkind').children('input').attr('checked', 'checked');
                $('#chkXcalctypes').children('input').attr('checked', 'checked');
                $('#chkXfield05').children('input').attr('checked', 'checked');
                $('#chkYoption28').children('input').attr('checked', 'checked');
                
                $('#chkWcarkind').children('input').attr('checked', 'checked');
                
                $('#txtBBmon').mask('999/99');
                $('#txtEEmon').mask('999/99');
                $('#textMon').mask('999/99');
                $('#btnTrans_sum').click(function(e) {
                    $('#divExport').toggle();
                });
                $('#btnDivexport').click(function(e) {
                    $('#divExport').hide();
                });
                $('#btnExport').click(function(e) {
                    var t_mon = $('#textMon').val();
                    if (t_mon.length > 0) {
                        Lock(1, {
                            opacity : 0
                        });
                        q_func('qtxt.query.trans', 'trans.txt,tran_sum,' + encodeURI(t_mon));
                    } else
                        alert('請輸入交運月份。');
                });
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.trans':
                        alert('結轉完成。');
                        Unlock(1);
                        break;
                    default:
                        break;
                }
            }

		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
		    <input type="button" id="btnTrans_sum" value="分析表資料結轉"/>
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<input type="button" id="btnOk2" style="float:left;font-size:16px;font-weight: bold;color: blue;cursor: pointer;width:50px;height:30px;" value="查詢"/>
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
		<div id="divExport" style="display:none;position:absolute;top:100px;left:600px;width:400px;height:120px;background:RGB(237,237,237);">
            <table style="border:4px solid gray; width:100%; height: 100%;">
                <tr style="height:1px;background-color: pink;">
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                </tr>
                <tr>
                    <td style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;color: blue;"><a>交運月份</a></td>
                    <td colspan="3" style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;">
                    <input type="text" id="textMon" style="float:left;width:40%;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" style="background-color: pink;">
                    <input type="button" id="btnExport" value="結轉"/>
                    </td>
                    <td colspan="2" align="center" style=" background-color: pink;">
                    <input type="button" id="btnDivexport" value="關閉"/>
                    </td>
                </tr>
            </table>
        </div>
	</body>
</html>