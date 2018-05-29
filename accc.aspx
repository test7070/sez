﻿<%@ Page Language="C#" AutoEventWireup="true" %>
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
		    var q_name = "accc", t_accbal, ssspart;
		    var q_readonly = ['txtAccc3', 'txtChecker', 'txtZno', 'txtWorker', 'txtDmoney', 'txtCmoney'];
		    var q_readonlys = ['txtAccc6', 'txtNoq'];
		    var t_prec, bbmNum, bbsNum, t_proj;

		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 5;
		    brwList = [];
		    brwNowPage = 0;
		    q_bbsLen = 15;
		    brwKey = 'Accc2';
		    //ajaxPath = ""; // 只在根目錄執行，才需設定

		    $(document).ready(function () {
		        q_desc = 1;
		        q_copy = 1;
		        bbmKey = ['accc3'];
		        bbsKey = ['accc3', 'noq'];

		        brwCount2 = 5;
		        q_brwCount();
		        q_xchg = (q_content.length > 0 ? 2 : 0);   /// q_xchg 0=all  1=view   2=form

		        //q_gt  一次執行一個
		        q_gt('ssspart', "where=^^noa='" + r_userno + "'^^", 0, 0, 0, "", r_accy + '_' + r_cno);
		       
		        if (!$('#div_row').is(':hidden')) {
		            if (mouse_div) {
		                $('#div_row').hide();
		            }
		            mouse_div = true;
		        }
		    });
		    function main() {
		        mainForm(1);
		        // 1=最後一筆  0=第一筆

		    } /// end Main()


		    aPop = [['txtPart_', 'btnPart_', 'acpart', 'noa,part', 'txtPart_,,txtAccc5_', "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtAccc5_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAccc5_,txtAccc6_,txtAccc7_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtAccc7_', 'btnQphr_', 'qphrs', 'code,phr', 'txtAccc7_,txtAccc7_', "qPhrs.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno, 0, 0, 'txtAccc5_', 'noa']
            , ['txtBal_', '     ', 'acbal', 'acc1,bal,money', ' ,txtBal_,txtDmoney_', '', 0, 0, 'txtAccc5_', 'noa']
            , ['txtProj_', 'btnProj_', 'proj', 'noa,proj', 'txtProj_,,txtPart_', "proj_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtCno_', '', 'acomp', 'noa,acomp', 'txtCno_', "acomp_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtCno', '', 'acomp', 'noa,acomp', 'txtCno', "acomp_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtProj', '', 'proj', 'noa,proj', 'txtProj,,', "proj_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]];


		    var dcType, t_lockPart, sys_proj = "";
		    function mainPost() {// 載入資料完，未 refresh 前
		        try {
		            t_lockPart = q_getPara('acc.lockPart');

		            bbmMask = [['txtAccc2', '99/99']];
		            sys_proj = q_getPara('sys.project');
   
		            var s1 = sys_proj;
		            t_znoModi = (s1.length > 1 && (s1.substr(0, 2) == 'sa' || s1.substr(0, 2) == 'rb' || s1.substr(0, 2) == 'yc' || s1.substr(0, 2) == 'bd' || s1.substr(0, 2) == 'rk' || s1.substr(0, 2) == 'vu'));
		            $('#txtCno').hide();
		            if (s1.length > 1 && s1 == 'sa') {
		                $('#txtCno').show();
		            }

		            q_modiDay = dec(q_getPara('sys.modiday'));
		            q_modiDay = (sys_proj.substr(0, 2) == "dc", 3, q_modiDay);

		            $('#tYear').text((r_len == 4 ? parseFloat(r_accy) + 1911 : r_accy) + ' ' + (r_cno == '1' ? '' : r_cno));

		            q_mask(bbmMask);
		            q_cmbParse("combAccc1", q_getPara('acc.typea'));
		            // 需在 main_form() 後執行，才會載入 系統參數

		            t_proj = q_getPara('accc.proj');
		            t_prec = q_getPara('accc.prec');
		            t_prec = q_trv(t_prec);

		            bbmNum = [['txtDmoney', 16, t_prec, 1], ['txtCmoney', 16, t_prec, 1]];
		            // 允許 key 小數
		            bbsNum = [['txtDmoney', 10, t_prec, 1], ['txtCmoney', 10, t_prec, 1]];

		            $('#combAccc1').attr('disabled', 'disabled');
		            $('#combAccc1').css('background', t_background2);

		            dcType = q_getPara2('acc.dc');
		            t_accbal = q_getPara2('acc.bal');

		            $('#txtAccc1').change(function () {
		                var i = $('#txtAccc1').val();
		                $('#combAccc1').val(i);
		                //$('#combAccc1')[0][i].innerText);
		                if (i < '0' || i > '3') {
		                    $('#txtAccc1').val('3');
		                    $('#combAccc1').val('3');
		                }

		                for (var j = 0; j < q_bbsCount; j++) {
		                    var objD = $('#txtDmoney_' + j);
		                    var objC = $('#txtCmoney_' + j);
		                    if (i == 1) {
		                        objD.attr('disabled', 'disabled');
		                        objC.removeAttr('disabled');
		                    }
		                    if (i == 2) {
		                        objD.removeAttr('disabled');
		                        objC.attr('disabled', 'disabled');
		                    }
		                    if (i == 3) {
		                        objD.removeAttr('disabled');
		                        objC.removeAttr('disabled');
		                    }
		                }
		                chg_accc1();
		            });

		            if (r_rank < 8)
		                $('#chkLok').attr('disabled', 'disabled');

		            $('#txtAccc2').focusout(function () {
		                //		                if (!q_validDate(1))  // 關帳
		                //		                {
		                //		                    $(this).focus;
		                //		                    return;
		                //		                }

		                var s1 = $(this).val();
		                if (s1.indexOf('_') > -1) {
		                    $('#lblAccc2').text(q_getMsg('lblAccc2') + m_error);
		                    $('#txtAccc2').focus();
		                }
		                //                        else {
		                //q_cd(r_accy + '/' + s1, $(this));

		                //$('#lblAccc2').text(q_getMsg('lblAccc2'));
		                //		                }
		            });

		            $('#btnAcuser').click(function () {
		                q_box('acUser.aspx', 'acuser', "99%", "99%", q_getMsg("popAcuser"));
		            });

		            $('#combAccc1').change(function () {
		                var i = parseInt($('#combAccc1').val(), 0);
		                $('#txtAccc1').val(i);
		                chg_accc1();
		            });


		            $('#txtProj').change(function () {
		                var j = q_bbsCount;
		                for (var i = 0; i < j; i++)
		                    $('#txtProj_' + i).val($(this).val());
		            });

		            $('#combAcuser').change(function () {
		                if (q_cur > 0 && q_cur < 4) {
		                    var t_noa = $('#combAcuser').val();
		                    $('#combAcuser').val(' ');
		                    q_gt('acuser', "_wnoa='" + t_noa + "'", 3);
		                }
		            });

		            if (r_rank < 8)
		                $('#chkLok').attr('disabled', 'disabled');

		            //   q_gt('acomp', "_wnoa='" + r_cno + "'", 3);
		        } // try
		        catch (e) {
		            errout(e, 'accc.refresh()');
		        }

		        //上方插入空白行
		        $('#lblTop_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
		            }
		        });
		        //下方插入空白行
		        $('#lblDown_row').mousedown(function (e) {
		            if (e.button == 0) {
		                mouse_div = false;
		                q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
		            }
		        });
		    }

		    function q_gtPost(t_name) {/// 資料下載後 ...
		        switch (t_name) {
		            case 'accc':
		                if (q_cur == 4)// 查詢
		                    q_Seek_gtPost();
		                else {
		                    var as = _q_appendData('acuser', '', true), str = ''; //, aTmp = [];
		                    //aTmp[0] = ['', '']
		                    str = ' @ ,';
		                    for (var i = 0; i < as.length; i++)
		                        str = str + as[i].noa + '@' + as[i].noa + as[i].namea + (i != as.length - 1 ? ',' : '');

		                    q_cmbParse('combAcuser', str);
		                }

		                if (q_getPara('sys.project') == 'dc')
		                    q_bbsLen = 15;
		                break;
		            case 'acuser':
		                var as = _q_appendData('acusers', '', true);

		                ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtAccc4,txtAccc5,txtPart,txtAccc6,txtAccc7,txtDmoney,txtCmoney,txtProj', as.length, as, 'accc4,accc5,part,accc6,accc7,dmoney,cmoney,proj', 'txtAccc5');
		                /// 最後 aEmpField 不可以有【數字欄位】

		                break;
		            case 'ssspart':
		                ssspart = _q_appendData("ssspart", "", true);
		                //避免refresh 先執行 這裡取到權限部門資料後再執行一次
		               	q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy + "_" + r_cno);  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
		                break;
		            case 'acomp':
		                var as = _q_appendData('acomp');
		                if (as && as.length > 0)
		                    $('#tYear').html(r_accy + as[0]['acomp']);
		                break;
		            //                case 'qphr': var as = _q_appendData('qphr', '', true);                    
		            //                    if (as && as.length > 0)                    
		            //                        $('#txtAccc7_' + b_seq).val(as[0]['phr']);                    
		            //                    break;                    

		        }  /// end switch
		    }

		    function sum() {
		        var td = 0, tc = 0, t_accc8;
		        var s1 = '';
		        for (var j = 0; j < q_bbsCount; j++) {
		            //s1 = $('#txtAccc4_' + j).val();
		            //t_accc8 = dec($('#txtAccc8_' + j).val());
		            td = q_add(td, dec($('#txtDmoney_' + j).val()));
		            tc = q_add(tc, dec($('#txtCmoney_' + j).val()));
		        } // j

		        var t_type = $('#txtAccc1').val();

		        if (t_type == '1')
		            td = tc;

		        if (t_type == '2')
		            tc = td;

		        q_tr('txtDmoney', td, t_prec);
		        q_tr('txtCmoney', tc, t_prec);
		    }

		    function btnOk() {
		        if (q_getPara('sys.project').toUpperCase() == 'RB') {
		            if (!confirm('確定要儲存?')) {
		                return;
		            }
		        }
		        t_err = q_chkEmpField([['txtAccc3', q_getMsg('lblAccc3')], ['txtAccc2', q_getMsg('lblAccc2')]]);
		        // 檢查空白
		        if (t_err.length > 0) {
		            $('#btnOk').removeAttr('disabled');
		            alert(t_err);
		            return;
		        }
		        sum();
		        t_err = "";
		        var td = q_tr('txtDmoney'), s1;
		        var tc = q_tr('txtCmoney');
		        var t_type = $('#txtAccc1').val();
		        if (td != tc && t_type == '3')
		            t_err = t_err + q_getMsg("msgMoneyDC") + dcType[0] + '=' + td + '   ' + dcType[1] + '=' + tc + "\r";
		        if (t_proj == 'rb')
		            for (var j = 0; j < q_bbsCount; j++) {
		                if ($.trim($('#txtPart_' + j).val()).length == 0) {
		                    t_err += '部門空白=' + $('#txtAccc5_' + j).val() + $('#txtAccc6_' + j).val() + ' ' + $('#txtAccc7_' + j).val() + ' ' + $('#txtDmoney_' + j).val() + ' ' + $('#txtCmoney_' + j).val();
		                }
		            }
		        //var i = parseInt($('#combAccc1').val(), 0);
		        //var s1 = $('#combAccc1')[0][i - 1].innerText.substr(0, 1);
		        //            if (s1 < '1' || s1 > '3') {
		        //                alert('Error = '+$('#combAccc1')[0][0].innerText);
		        //                return;
		        //            }
		        //$('#txtAccc1').val( s1);

		        $('#txtWorker').val(r_name)
				
		        //重新設定noq
		        for (var i = 0; i < q_bbsCount; i++) {
		            if (!emp($('#txtAccc5_' + i).val()))
		                $('#txtNoq_' + i).val(('000' + (i + 1)).substr(-3));
		            s1 = $.trim($('#txtAccc5_' + i).val());
		            if (s1.length == 4)
		                $('#txtAccc5_' + i).val(s1 + '.');
		            else if (s1.length > 4 && s1.substr(4, 1) != '.')
		                $('#txtAccc5_' + i).val(s1.substr(0, 4) + '.' + s1.substr(5, 20));
		            else if (t_type != '3' && replaceAll(replaceAll($('#txtAccc6_' + i).val(), ' ', ''), '　', '') == '現金')
		                t_err += $('#txtAccc5_' + i).val() + '不可有現金科目';
		        }

		        if (t_err) {
		            $('#btnOk').removeAttr('disabled');
		            alert(t_err);
		            return;
		        }

		        s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
		        if (s1.length == 0 || s1 == "AUTO")/// 自動產生編號
		            q_gtnoa(q_name, replaceAll('' + $('#txtAccc2').val(), '/', ''), r_accy);
		        else
		            wrServer(s1);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;

		        q_box('accc_s.aspx', q_name + '_s', "500px", "380px", q_getMsg("popSeek"));
		    }

		    function changeDC() {
		        //var s1 = ($('#txtAccc4_' + b_seq).val() == dcType[0] ? '' : '　　') + $.trim($('#txtAccc6_' + b_seq).val());
		        //$('#txtAccc6_' + b_seq).val(s1);
		    }

		    function q_popPost(s2) {
		        if (s2 == 'txtAccc5_')/// for body
		            changeDC();
		        if (s2 == 'txtBal_'){/// for body
		            var s1 = $('#txtAccc5_' + b_seq).val(), s3;
		            var t_money = $('#txtDmoney_' + b_seq).val();
		            if (s1.length > 0) {
		                s3 = s1.substr(0, 1);
		                if (s3 == "2" || s3 == "3" || s3 == "4" || s3 == "7") {
		                    $('#txtCmoney_' + b_seq).val('');
		                }
		                else {
		                    $('#txtDmoney_' + b_seq).val('');
		                    $('#txtCmoney_' + b_seq).val(t_money);
		                }
		            }
		        }
		    }

		    function bbsAssign() {/// 表身運算式

		        aPop[0][5] = "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno;
		        aPop[1][5] = "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno;

		        for (var j = 0; j < q_bbsCount; j++) {
		            if (!$('#btnMinus_' + j).hasClass('isAssign')) {
		                $('#txtAccc5_' + j).change(function () {

		                    t_IdSeq = -1;
		                    /// 要先給  才能使用 q_bodyId()
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;

		                    var s1 = trim($(this).val());
		                    if (s1.length > 4 && s1.indexOf('.') < 0 && (/^[0-9,A-Z,a-z]{5,99}$/g).test(s1))
		                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
		                    if (s1.length == 4)
		                        $(this).val(s1 + '.');
		                });
		                $('#txtAccc7_' + j).attr('title', $('#txtAccc7_' + j).val());

		                //                $('#txtAccc8_' + j).focusout(function () { sum(); });

		                //                $('#txtAccc4_' + j).focus(function () {
		                //                    var s1 = $.trim($(this).val());
		                //                    if (s1.length == 0) {
		                //                        $(this).val(dcType[0]);
		                //                        $(this).select(); // ionStart = 0;
		                //                    }
		                //                });
		                //                $('#txtAccc4_' + j).change(function () {
		                //                    var s1 = $(this).val();

		                //                    if (s1.toLowerCase() == 'd')
		                //                        $(this).val(dcType[0]);

		                //                    if (s1.toLowerCase() == 'c')
		                //                        $(this).val(dcType[1]);

		                //                    s1 = $(this).val();

		                //                    if (s1 != dcType[0] && s1 != dcType[1])
		                //                        $(this).val(dcType[0]);

		                //                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                //                    q_bodyId($(this).attr('id'));
		                //                    b_seq = t_IdSeq;
		                //                    changeDC();

		                //                    sum();
		                //                });

		                $('#txtDmoney_' + j).focusout(function () {
		                    sum();
		                    var t_type = $('#txtAccc1').val();
		                    if (t_type == '3')
		                        diff($(this));
		                });
		                $('#txtCmoney_' + j).focusout(function () {
		                    sum();
		                    var t_type = $('#txtAccc1').val();
		                    if (t_type == '3')
		                        diff($(this));

		                });
		                $('#txtAccc7_' + j).bind('keyup', function (event) {

		                    if (event.keyCode == 13) {
		                        t_IdSeq = -1;
		                        /// 要先給  才能使用 q_bodyId()
		                        q_bodyId($(this).attr('id'));
		                        b_seq = t_IdSeq;

		                        var s1 = $('#txtAccc5_' + b_seq).val();
		                        for (i = 0; i < t_accbal.length; i++)
		                            if (s1.substr(0, t_accbal[i].length) == t_accbal[i]) {
		                                $('#txtBal_' + b_seq).css('display', 'inline-block');
		                                break;
		                            }
		                    }
		                });

		                $('#txtAccc7_' + j).focusout(function () {  // 複製上一筆
		                    var s1 = $(this).val();
		                    if (s1.length == 1 && s1 == "=") {
		                        t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                        q_bodyId($(this).attr('id'));
		                        b_seq = t_IdSeq;
		                        if (b_seq > 0) {
		                            var i = b_seq - 1;
		                            var s1 = $('#txtAccc7_' + i).val();
		                            $('#txtAccc7_' + b_seq).val(s1);
		                        }
		                    }

		                    if (s1.length < 6 && s1.substr(0, 1) == "-") {
		                        t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                        q_bodyId($(this).attr('id'));
		                        b_seq = t_IdSeq;

		                        q_gt('qphr', " where=^^noa='" + $.trim(s1.substr(1)) + "'^^", 0, 1, 0, '', '');
		                    }
		                });

		                $('#txtAccc7_' + j).focus(function () {
		                    if (!$(this).val())
		                        q_msg($(this), '=號複製上一筆摘要');
		                });


		                $('#btnQphr_' + j).click(function (e) {
		                    t_IdSeq = -1;
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
		                    $('#text_Noq').val(b_seq);
		                    q_box('qPhr.aspx' + "?;;;;" + r_accy, 'qphr', "90%", "90%", m_qphr);
		                });

		                $('#btnMinus_' + j).bind('contextmenu', function (e) {
		                    e.preventDefault();

		                    mouse_div = false;
		                    ////////////控制顯示位置
		                    $('#div_row').css('top', e.pageY);
		                    $('#div_row').css('left', e.pageX);
		                    ////////////
		                    t_IdSeq = -1;
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
		                    $('#div_row').show();
		                    row_b_seq = b_seq;
		                    row_bbsbbt = 'bbs';
		                });
		            }
		        } //j

		        _bbsAssign();

		        chg_accc1();
		        if (t_proj != 1)
		            $('.tdProj').hide();

		    }

		    function diff(obj) {
		        if (q_cur > 0) {
		            var t1 = q_float('txtCmoney') - q_float('txtDmoney');
		            if (t1 != 0)
		                q_msg(obj, '差額=' + Math.abs(t1));
		            else
		                q_msg();
		        }
		    }

		    function q_gridvPost() {
		        var t_bno, t_eno, i, j;
		        t_eno = $('#vtaccc3_0').text();
                t_bno = $('#vtaccc3_' + (brwCount - 1)).text();
                
                q_func('accc_post.getprt', r_accy + ',' + t_bno + "," + t_eno, r_accy, 1);
                var as = _q_appendData("tmp0", "", true);
                
                
		        for (i = 0; i < brwCount; i++) {
		            t_no = $('#vtaccc3_' + i).text();
		            for (j = 0; j < as.length; j++)
		                if (as[j]['accc3'] == t_no) {
		                    $('#vtisprt_' + i).text(as[j]['isprt'] == "true" ? 'v' : '');
		                    break;
		                }
		        }
		    }
		    function q_boxClose(s2) {///   q_boxClose 2/4 /// 查詢視窗、廠商視窗、採購視窗  關閉時執行
		        var ret;
		        switch (b_pop) {/// 重要：不可以直接 return ，最後需執行 originalClose();
		            case 'z_accc1':
		                q_gridvPost();
		                break;
		            case 'qphr':
		                if (q_cur > 0 && q_cur < 4) {
		                    b_ret = getb_ret();
		                    if (!b_ret || b_ret.length == 0)
		                        return;
		                    if (b_seq < 0 || b_seq >= q_bbsCount)
		                        //;
		                    $('#txtAccc7_' + b_seq).val(b_ret[0].phr);
		                }
		                break;
		            case q_name + '_s':
		                q_boxClose2(s2);
		                ///   q_boxClose 3/4
		                break;
		        } /// end Switch
		        b_pop = '';
		    }

		    function btnIns() {
		        _btnIns();
		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
		        $('#txtAccc2').val(q_date().substr(r_len + 1));

		        $('#txtAccc1').removeAttr('disabled');
		        $('#combAccc1').val(3);
		        $('#combAccc1').removeAttr('disabled');
		        $('#combAccc1').css('background', t_background);
		        $('#dbbs').show();
		        $('#txtAccc1').focus();
		        $('#txtAccc1').val(3);

		        $('#combAccc1').removeAttr('disabled');
		        if (t_proj != 1)
		            $('.tdProj').hide();
		    }

		    var t_znoModi = 0;
		    function btnModi() {
		        if (t_znoModi == 0 && $('#txtZno').val().length > 0) {
		            alert('轉來傳票，禁止異動');
		            return;
		        }
		        if (emp($('#txtAccc3').val()))
		            return;

		        if (r_rank < 8 && $('#chkLok')[0].checked) {
		            alert(mess_auth1[r_lang]);
		            return;
		        }

		        q_modiDate = r_accy + '/' + abbm[q_recno]['accc2'];
		        if (q_chkClose())
		            return;
		        _btnModi();
		        chg_accc1();
		        $('#txtAccc1').attr('disabled', 'disabled');
		        $('#txtAccc2').focus();
		    }

		    function btnPrint() {
		        q_box("z_acccp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtAccc3').val() + ";" + r_accy + "_" + r_cno, 'z_accc1', "95%", "90%", q_getMsg('popZ_accc1'));
		    }

		    function wrServer(key_value) {
		        var i;
		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
		    }

		    function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
		        var t_dmoney = dec(as['dmoney']), t_cmoney = dec(as['cmoney']);
		        if (!as['accc5'] && !as['accc6'] && t_dmoney == 0 && t_cmoney == 0) {//不存檔條件
		            as[bbsKey[1]] = '';
		            /// no2 為空，不存檔
		            return;
		        }
		        q_nowf();

		        as['accc1'] = abbm2['accc1'];
		        as['accc2'] = abbm2['accc2'];
		        as['accc3'] = abbm2['accc3'];
		        as['accc4'] = t_dmoney > 0 ? dcType[0] : dcType[1];
		        as['dc'] = t_dmoney > 0 ? '1' : '2';
		        as['accc8'] = t_dmoney > 0 ? t_dmoney : t_cmoney;

		        if (sys_proj == 'rk')
		            return true;
		        t_err = '';

		        var s1 = as['accc5'] + as['accc6'] + as['accc7'] + as['accc8'] + '\n';

		        if (dec(as['accc8']) == 0)
		            t_err = t_err + q_getMsg('msgAccc8') + s1;

		        if (dec(as['dmoney']) + dec(as['cmoney']) == 0 || (t_dmoney > 0 && t_cmoney > 0))
		            t_err = t_err + q_getMsg('msgAccc8') + t_dmoney + ' ' + t_cmoney;

		        if (!as['accc4'])
		            t_err = t_err + q_getMsg('msgAccc4') + s1;
		        if (!as['accc5'])
		            t_err = t_err + q_getMsg('msgAccc5') + s1;
		        if (!as['accc6'])
		            t_err = t_err + q_getMsg('msgAccc5') + s1;
		        if (as['accc8'] != null && (dec(as['accc8']) > 99999999999 || dec(as['accc8']) < -99999999999))
		            t_err = t_err + q_getMsg('msgMoneyErr') + s1;

		        q_bbsErr = q_bbsErr + t_err;

		        return (t_err.length > 0 ? false : true);
		    }

		    ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
		    function refresh(recno) {
		        if (t_lockPart == 1 && r_rank < 8) {
		            $('#dbbs').hide();  // 有相關部門，再開啟
		            $('#btnModi').attr('disabled', 'disabled');
		            $('#btnDele').attr('disabled', 'disabled');
		        }
		        _refresh(recno);
				for (var i = 0; i < q_bbsCount; i++) {
                	s2 = $('#txtBal_' + i).val();
		            if (s2 && s2.length > 0)
		                $('#txtBal_' + i).css('display', 'inline-block');
                }
                var showPart = false;
                for (var i = 0; i < q_bbsCount; i++) {     
                    var s1 = $('#txtPart_' + i).val();
                    if (s1 == r_partno) {
                        showPart = true;
                        break;
                    }
                    if (ssspart != null && ssspart.length > 0)
                        for (j = 0; j < ssspart.length; j++) {
                            if (ssspart[j].partno == s1) {
                                showPart = true;
                                break;
                            }
                        }
                    if (showPart)
                        break;
                }
                for (var i = 0; showPart && i < q_bbsCount; i++) {
		            s1 = $('#txtAccc6_' + i).val();
		            if($.trim($('#txtAccc5_' + i).val())!='5850.07' && $.trim($('#txtAccc5_' + i).val())!='2123.51')
		                if (s1.indexOf('薪資') > -1 || s1.indexOf('獎金') > -1 || s1.indexOf('福利金') > -1){  
		                	showPart = false;
		                	break;
	                	}
                }
                if (t_lockPart == 1 && r_rank < 8 && showPart) {
                    $('#dbbs').show();  // 有相關部門，再開啟
                    $('#btnModi').removeAttr('disabled');
                    $('#btnDele').removeAttr('disabled');
                }
		            
		        $('#combAccc1').val($('#txtAccc1').val());
		        $('#combAccc1').attr('disabled', 'disabled');
		        $('#combAccc1').css('background', t_background2);

		        if (q_xchg != 1)
		            $('#tbbs').show();

		        if (t_proj != 1)
		            $('.tdProj').hide();

		        if (r_rank < 8 && $('#chkLok')[0].checked)
		            $('#tbbs').hide();
		    }


		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		        if (t_para) {
		            $('#div_row').hide();
		            $('#div_assm').hide();
		        }

		        if (q_cur == 1 && r_rank > 7 && sys_proj!='dc') {
		            $('#txtAccc3').attr('readonly', false);
		            $('#txtAccc3').css('background', t_background);
		        }
		    }

		    function chg_accc1() {
		        var t_accc1 = $('#txtAccc1').val();
		        if (t_accc1 == '1') {
		            $('.tdMoney input').val('').attr('disabled', 'disabled');
		            $('.tcMoney input').removeAttr('disabled');
		        }
		        if (t_accc1 == '2') {
		            $('.tcMoney input').val('').attr('disabled', 'disabled');
		            $('.tdMoney input').removeAttr('disabled');
		        }
		        if (t_accc1 == '3') {
		            $('.tdMoney input').removeAttr('disabled');
		            $('.tcMoney input').removeAttr('disabled');
		        }
		        sum();
		    }

		    function btnMinus(id) {
		        _btnMinus(id);
		        sum();
		    }

		    function btnPlus(org_htm, dest_tag, afield) {
		        _btnPlus(org_htm, dest_tag, afield);
		    }

		    function q_appendData(t_Table) {
		        dataErr = !_q_appendData(t_Table);
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
		        if (t_znoModi == 0 && $('#txtZno').val().length > 0) {
		            alert('轉來傳票，禁止異動');
		            return;
		        }

		        if (r_rank < 8 && $('#chkLok')[0].checked) {
		            alert(mess_auth1[r_lang]);
		            return;
		        }

		        q_modiDate = r_accy + '/' + abbm[q_recno]['accc2'];
		        if (q_chkClose())
		            return;

		        _btnDele();
		    }

		    function btnCancel() {
		        _btnCancel();
		    }

		    var mouse_div = true; //控制滑鼠消失div
		    var row_bbsbbt = ''; //判斷是bbs或bbt增加欄位
		    var row_b_seq = ''; //判斷第幾個row
		    //插入欄位
		    function q_bbs_addrow(bbsbbt, row, topdown) {
		        //取得目前行
		        var rows_b_seq = dec(row) + dec(topdown);
		        if (bbsbbt == 'bbs') {
		            q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
		            //目前行的資料往下移動
		            for (var i = q_bbsCount - 1; i >= rows_b_seq; i--) {
		                for (var j = 0; j < fbbs.length; j++) {
		                    if (i != rows_b_seq)
		                        $('#' + fbbs[j] + '_' + i).val($('#' + fbbs[j] + '_' + (i - 1)).val());
		                    else
		                        $('#' + fbbs[j] + '_' + i).val('');
		                }
		            }
		        }
		        if (bbsbbt == 'bbt') {
		            q_gridAddRow(bbtHtm, 'tbbt', fbbt, 1, '', '', '', '__');
		            //目前行的資料往下移動
		            for (var i = q_bbtCount - 1; i >= rows_b_seq; i--) {
		                for (var j = 0; j < fbbt.length; j++) {
		                    if (i != rows_b_seq)
		                        $('#' + fbbt[j] + '__' + i).val($('#' + fbbt[j] + '__' + (i - 1)).val());
		                    else
		                        $('#' + fbbt[j] + '__' + i).val('');
		                }
		            }
		        }
		        $('#div_row').hide();
		        row_bbsbbt = '';
		        row_b_seq = '';
		    }
		</script>
		<style type="text/css">
            .tview {
                FONT-SIZE: 12pt;
                COLOR: Blue;
                background: #FFCC00;
                padding: 3px;
                TEXT-ALIGN: center
            }
            .tbbm {
                FONT-SIZE: 12pt;
                COLOR: blue;
                TEXT-ALIGN: left;
                border-color: white;
                width: 100%;
                border-collapse: collapse;
                background: #cad3ff;
            }

            .tbbs {
                FONT-SIZE: 12pt;
                COLOR: blue;
                TEXT-ALIGN: left;
                BORDER: 1PX LIGHTGREY SOLID;
                width: 100%;
                height: 100%;
            }

            .column1 {
                width: 8%;
            }
            .column2 {
                width: 10%;
            }
            .column3 {
                width: 8%;
            }
            .column4 {
                width: 10%;
            }
            .label1 {
                width: 8%;
                text-align: right;
            }
            .label2 {
                width: 8%;
                text-align: right;
            }
            .label3 {
                width: 8%;
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            #div_row{
			display:none;
			width:750px;
			background-color: #ffffff;
			position: absolute;
			left: 20px;
			z-index: 50;
			}
			.table_row tr td .lbl.btn {
                color: #000000;
                font-weight: bolder;
                font-size: medium;
                cursor: pointer;
            }
            .table_row tr td .lbl.btn:hover {
                color: #FF8F19;
            }
		    .style1
            {
                width: 8%;
                text-align: right;
                height: 35px;
            }
            .style2
            {
                width: 8%;
                height: 35px;
            }
            .style3
            {
                width: 9%;
                height: 35px;
            }
		    .style4
            {
                width: 18%;
            }
            .style5
            {
                width: 30%;
            }
		</style>
	</head>
	<body>
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row"  class="table_row" style="width:100%;" border="1" cellpadding='1'  cellspacing='0'>
				<tr>
					<td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
				</tr>
				<tr>
					<td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
				</tr>
			</table>
		</div>
		<form id="form1" runat="server" style="height: 100%">
			<!--#include file="../inc/toolbar.inc"-->
			<div id='dmain' style="overflow:hidden;">
				<div class="dview" id="dview" style="float: left;  width:380px;"  >
					<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
						<tr>
							<td align="center" style="width:5%"><a id='vewChk'></a></td>
							<td align="center" style="width:18%"><a id='vewAccc2'></a></td>
							<td align="center" style="width:20%"><a id='vewAccc3'></a></td>
							<td align="center" style="width:25%"><a id='vewDmoney'></a></td>
                            <td align="center" style="width:20%"><a id='vewWorker'></a></td>
                            <td align="center" style="width:20%"><a id='vewIsprt'></a></td>
						</tr>
						<tr>
							<td >
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td align="center" id='accc2' class="style4">~accc2</td>
							<td align="center" id='accc3'>~accc3</td>
							<td align="center" id='dmoney,0' class="style5">~dmoney,0</td>
                            <td align="center" id='worker' class="style5">~worker</td>
                             <td align="center" id='isprt'  >~isprt</td>
						</tr>
					</table>
				</div>
				<div class='dbbm' style="width: 900px;float: left;">
					<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
						<tr>
							<td class="style1"  align="right"><a id='lblAccc1'> </a></td>
							<td class="style3" >
								<input id="txtAccc1" maxlength='20' type="text"  style='width:7%;'/>
								<select id="combAccc1" style='width:85%;font-size: medium;'/>
							</td>
							<td class="style1" align="right" ><a id='lblYear'> </a></td>
							<td class="style2" align='left' ><a id='tYear'> </a></td>
							<td class="style1" align="right"><a id='lblAcuser'> </a></td>
							<td class="style2" ><select id="combAcuser" style='width:100%; font-size:medium'> </select></td>
                            <td class="tdProj" style='width:15%;'> </td>
						</tr>
						<tr>
							<td class="style1" align="right" ><a id='lblAccc2'> </a></td>
							<td class="style3">
							<input id="txtAccc2" maxlength='10' type="text"  style='width:97%;'/>
							</td>
							<td class="style1" align="right"><a id='lblAccc3'> </a></td>
							<td class="style2" >
							<input id="txtAccc3"   type="text"  maxlength='30'   style='width:97%;'/>
							</td>
							<td class="style1" align="right"><a id='lblDmoney'> </a></td>
							<td class="style2" >
							<input id="txtDmoney" type="text"  maxlength='30'   style='width:97%;text-align:right;'/>
							</td>
                            <td class="tdProj" ></td>
						</tr>

						<tr>
							<td class="style1"><a id='lblWorker'> </a></td>
							<td class="style3" >
							<input id="txtWorker"  type="text"  maxlength='20'style='width:97%; text-align:center;'/>
							</td>
							<td class="style1"><a id='lblChecker'> </a></td>
							<td class="style2"><input id="txtChecker" type="text" maxlength='20' style="width:97%;text-align:center;"/></td>
							<td class="style1"><a id='lblCmoney'> </a></td>
							<td class="style2"><input id="txtCmoney" type="text" maxlength='30' style='width:97%;text-align:right;'/></td>
                            <td class="tdProj"> </td>
						</tr>

						<tr>
							<td class="style1"><a id='lblZno'> </a></td>
							<td class="style3"><input id="txtZno" type="text" maxlength='20' style='width:97%; text-align:center;'/></td>
							<td class="style1"><a id='lblCno'> </a></td>
							<td class="style2"><input id="txtCno" type="text" maxlength='20' style='width:97%; text-align:center;'/></td>
							<td class="style1"><a id='lblLok'> </a></td>
							<td >
								<input id="chkLok" type="checkbox"  style='width:10%;float:left'/>
                            	&nbsp;&nbsp;&nbsp;&nbsp;<input id="txtPart"  type="hidden" />
							</td>
                           <td class="tdProj"><a id='lblProj'> </a><input id="txtProj" type="text" style='width:50%;'/></td>
						</tr>
					</table>
					<input id="text_Noq"  type="hidden" class="txt c1"/>	
				</div>
			</div>

			<div class='dbbs' id='dbbs'>
				<%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:White; background:#003366;' >
						<td align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
						</td>
                        <td align="center" style="width:3%;"><a id='lblNoq'> </a></td>
						<td align="center"  class="tdProj" style="width:10%;"><a id='lblProjs'> </a></td>
                        <td align="center" style="width:6%;"><a id='lblPart'> </a></td>
						<td align="center" style="width:11%;"><a id='lblAccc5'> </a></td>
						<td align="center" style="width:16%;"><a id='lblAccc6'> </a></td>
						<td align="center" style="width:30%;"><a id='lblAccc7'> </a></td>
						<td align="center" style="width:10%;"><a id='lblDmoney_s'> </a></td>
						<td align="center" style="width:10%;"><a id='lblCmoney_s'> </a></td>
                   <%--     <td align="center" style="width:4%;"><a id='lblCnos'> </a></td>
						 <td align="center" style="width:4%;"><a id='lblCoin'> </a></td>
						<td align="center" style="width:4%;"><a id='lblFloata'> </a></td>--%>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;"/></td>
                        <td><input class="txt" id="txtNoq.*" type="text"  style=" width:75%;"/></td>
                        <td class="tdProj" style="">
							<input class="btn"  id="btnProj" type="button" value='.' style=" width:5%;font-weight: bold; " />
							<input class="txt" id="txtProj.*" type="text" maxlength='90' style="width:80%; " />
						</td>
						<td>
							<input class="btn"  id="btnPart.*" type="button" value='.' style="width:5%; font-weight: bold; " />
							<input class="txt" id="txtPart.*" type="text" maxlength='90' style="width:55%; " />
						</td>
						<td >
							<input class="btn"  id="btnAcc.*" type="button" value='.' style="width:5%; font-weight: bold;" />
							<input class="txt" id="txtAccc5.*" type="text" maxlength='90' style="width:78%;" />
						</td>
						<td><input class="txt" id="txtAccc6.*" type="text" style="width:97%;"/></td>
						<td style="text-align:center;" >
							<input class="txt" id="txtAccc7.*" type="text" style="width:90%;"/>
							<input class="btn"  id="btnQphr.*" type="button" value='.'  />
							<input class="txt" id="txtBal.*" type="text" style="width:80%; text-align:center; display:none"/>
						</td>
						<td class='tdMoney'><input class="txt" id="txtDmoney.*" type="text" maxlength='20' style="width:97%; text-align:right;"/></td>
						<td class='tcMoney'><input class="txt" id="txtCmoney.*" type="text" maxlength='20' style="width:97%; text-align:right;"/></td>
          <%--          <td><input class="txt" id="txtCno.*" type="text" maxlength='90' style="width:97%;"/></td>
						 <td><input class="txt" id="txtCoin.*" type="text" maxlength='90' style="width:97%;"/></td>
						<td><input class="txt" id="txtFloata.*" type="text" maxlength='90' style="width:97%;text-align:right;"/></td>--%>
					</tr>
				</table>
			</div>
			<input id="q_sys" type="hidden" />
		</form>
	</body>
</html>






