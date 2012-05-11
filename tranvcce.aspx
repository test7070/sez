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

            var decbbm = ['mount', 'weight'];
            var q_name = "tranvcce";
            var q_readonly = ['txtNoa'];
            var bbmNum = new Array(['txtWeight,10,2']);
            var bbmMask = new Array();
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'],['txtStraddno_type1', 'lblStradd_type1', 'addr', 'noa,addr', 'txtStraddno_type1,txtStradd_type1', 'addr_b.aspx'], ['txtEndaddno_type1', 'lblEndadd_type1', 'addr', 'noa,addr', 'txtEndaddno_type1,txtEndadd_type1', 'addr_b.aspx'], ['txtStraddno_type2', 'lblStradd_type2', 'addr', 'noa,addr', 'txtStraddno_type2,txtStradd_type2', 'addr_b.aspx'], ['txtEndaddno_type2', 'lblEndadd_type2', 'addr', 'noa,addr', 'txtEndaddno_type2,txtEndadd_type2', 'addr_b.aspx'], ['txtStraddno_type3', 'lblStradd_type3', 'addr', 'noa,addr', 'txtStraddno_type3,txtStradd_type3', 'addr_b.aspx'], ['txtEndaddno_type3', 'lblEndadd_type3', 'addr', 'noa,addr', 'txtEndaddno_type3,txtEndadd_type3', 'addr_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function q_funcPost(t_func, result) {
                if(result.substr(0, 5) == '<Data') {
                    switch(t_func) {
                        case 'tranvcce.check':
                            var tmp = _q_appendData('msg', '', true);
                            if(tmp[0].value == '1') {
                                var t_noa = trim($('#txtNoa').val());
                                if(t_noa.length == 0 || t_noa == "AUTO")
                                    q_gtnoa(q_name, replaceAll('T' + (trim($('#txtDatea').val()).length == 0 ? q_date() : trim($('#txtDatea').val())), '/', ''));
                                else
                                    wrServer(t_noa);
                            } else {
                                alert(tmp[0].memo);
                            }
                            $('#btnNo').removeAttr('disabled');
                            isEnabled();
                            break;
                        case 'tranvcce.getCust':
                            var tmp = _q_appendData('tranvcce_cust', '', true);
                            tmpStr = '<option value="">'+q_getPara('tranvcce.string_all')+'<';
                            tmpStr += '/option>';
                            $('#cmbCust_type1').append(tmpStr);
                            $('#cmbCust_type2').append(tmpStr);
                            $('#cmbCust_type3').append(tmpStr);
                            for( i = 0; i < tmp.length; i++) {
                                tmpStr = '<option value="' + tmp[i].custno + '">'+tmp[i].nick+'<';
                                tmpStr += '/option>';
                                if(tmp[i].typea == '1')
                                    $('#cmbCust_type1').append(tmpStr);
                                else if(tmp[i].typea == '2')
                                    $('#cmbCust_type2').append(tmpStr);
                                else
                                    $('#cmbCust_type3').append(tmpStr);
                            }
                            break;
                        case 'tranvcce.getItem1':
                            var tmp = _q_appendData('tranvcce_t1', '', true);
                            $("#t1").refresh(tmp);
                            break;
                        case 'tranvcce.getItem2':
                            var tmp = _q_appendData('tranvcce_t2', '', true);
                            $("#t2").refresh(tmp);
                            break;
                        case 'tranvcce.getItem3':
                            var tmp = _q_appendData('tranvcce_t3', '', true);
                            $("#t3").refresh(tmp);
                            break;
                    }
                } else
                    alert('Error!' + '\r' + t_func + '\r' + result);
            }

            function mainPost() {
                q_func('tranvcce.getCust', 'empty');
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                $('#txtOdate_type1').mask(r_picd);
                q_cmbParse("cmbTypea", q_getPara('tranvcce.typea'));
                var tmp = q_getPara('tranvcce.ispal').split(',');
                for( i = 0; i < tmp.length; i++) {
                    tmpStr = '<option><';
                    tmpStr += '/option>';
                    $("#cmbIspal_type2").append(tmpStr);
                    $("#cmbIspal_type2").children().last().val(tmp[i].split('@')[0]).text(tmp[i].split('@')[1]);
                }
                $("#cmbIspal_type2").val('0');
                for( i = 0; i < tmp.length; i++) {
                    tmpStr = '<option><';
                    tmpStr += '/option>';
                    $("#cmbIspal_type3").append(tmpStr);
                    $("#cmbIspal_type3").children().last().val(tmp[i].split('@')[0]).text(tmp[i].split('@')[1]);
                }
                $("#cmbIspal_type3").val('0');
                tmp = q_getPara('tranvcce.ef').split(',');
                for( i = 0; i < tmp.length; i++) {
                    tmpStr = '<option><';
                    tmpStr += '/option>';
                    $("#cmbEf_type2").append(tmpStr);
                    $("#cmbEf_type2").children().last().val(tmp[i].split('@')[0]).text(tmp[i].split('@')[1]);
                }
                $("#cmbEf_type2").val('0');
                for( i = 0; i < tmp.length; i++) {
                    tmpStr = '<option><';
                    tmpStr += '/option>';
                    $("#cmbEf_type3").append(tmpStr);
                    $("#cmbEf_type3").children().last().val(tmp[i].split('@')[0]).text(tmp[i].split('@')[1]);
                }
                $("#cmbEf_type3").val('0');
                tmp = q_getPara('tranvcce.typea').split(',');
                for( i = 0; i < tmp.length; i++) {
                    tmpStr = '<option><';
                    tmpStr += '/option>';
                    $("#cmbTypea_condition").append(tmpStr);
                    $("#cmbTypea_condition").children().last().val(tmp[i].split('@')[0]).text(tmp[i].split('@')[1]);
                }
                $("#cmbTypea_condition").change(function() {
                    var obj = $('#condition')
                    if($('#condition').children('tbody').length > 0)
                        obj = $('#condition').children('tbody').eq(0);
                    obj.children().hide();
                    obj.children('tr[name="schema"]').show();
                    obj.children('tr[name="action"]').show();

                    switch($(this).val()) {
                        case '1':
                            obj.children('tr.type1').show();
                            break;
                        case '2':
                            obj.children('tr.type2').show();
                            break;
                        case '3':
                            obj.children('tr.type3').show();
                            break;
                    }
                });

                $("#cmbTypea_condition").change();
                $("#btnLookup_condition").click(function(e) {
                    $("#t1").hide();
                    $("#t2").hide();
                    $("#t3").hide();
                    switch($("#cmbTypea_condition").val()) {
                        case '1':
                            var t_para = q_func('tranvcce.getItem1', $('#cmbCust_type1').val() + ',' + $('#txtStraddno_type1').val() + ',' + $('#txtStradd_type1').val() + ',' + $('#txtEndaddno_type1').val() + ',' + $('#txtEndadd_type1').val() + ',' + $('#txtProductno_type1').val() + ',' + $('#txtProduct_type1').val() + ',' + $('#txtOrdeno_type1').val() + ',' + $('#txtOdate_type1').val() + ',' + ($('#chkIsdisplay_type1').prop('checked') ? '1' : '0') + ',empty');
                            $("#t1").show();
                            break;
                        case '2':
                            //custno,cust,straddno,stradd,endaddno,endadd,caseno,caseno2,po,traceno,isdisplay,carno,datea,ispal,ef,ordeno
                            q_func('tranvcce.getItem2', $('#cmbCust_type2').val() + ',' + $('#txtStraddno_type2').val() + ',' + $('#txtStradd_type2').val() + ',' + $('#txtEndaddno_type2').val() + ',' + $('#txtEndadd_type2').val() + ',' + $('#txtCaseno_type2').val() + ',' + $('#txtCaseno2_type2').val() + ',' + $('#txtPo_type2').val() + ',' + $('#txtTraceno_type2').val() + ',' + ($('#chkIsdisplay_type2').prop('checked') ? '1' : '0') + ',' + $('#txtCarno_type2').val() + ',' + $('#txtOdate_type2').val() + ',' + $('#cmbIspal_type2').val() + ',' + $('#cmbEf_type2').val() + ',' + $('#txtOrdeno_type2').val() + ',empty');
                            $("#t2").show();
                            break;
                        case '3':
                            //custno,cust,straddno,stradd,endaddno,endadd,shipno,so,cldate,caseno,isdisplay,carno,datea,ispal,ef,ordeno
                            q_func('tranvcce.getItem3', $('#cmbCust_type3').val() + ',' + $('#txtStraddno_type3').val() + ',' + $('#txtStradd_type3').val() + ',' + $('#txtEndaddno_type3').val() + ',' + $('#txtEndadd_type3').val() + ',' + $('#txtShipno_type3').val() + ',' + $('#txtSo_type3').val() + ',' + $('#txtCldate_type3').val() + ',' + $('#txtCaseno_type3').val() + ',' + ($('#chkIsdisplay_type3').prop('checked') ? '1' : '0') + ',' + $('#txtCarno_type3').val() + ',' + $('#txtOdate_type3').val() + ',' + $('#cmbIspal_type3').val() + ',' + $('#cmbEf_type3').val() + ',' + $('#txtOrdeno_type3').val() + ',empty');
                            $("#t3").show();
                            break;
                    }
                });
            }

            function sum() {
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
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#btnLookup_condition').attr('disabled', 'disabled');
                isEnabled();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();

                $('#btnLookup_condition').attr('disabled', 'disabled');
                isEnabled();
            }

            function btnPrint() {
            }

            function btnOk() {
                if($('#txtWeight').val() <= 0) {
                    alert('Error: The Weight must more than zero!');
                    return;
                }
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                $('#btnNo').attr('disabled', 'disabled');
                q_func('tranvcce.check', $('#txtOrdeno').val() + "," + $('#txtNoa').val() + "," + $('#txtWeight').val() + ",empty");
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                if(q_cur == 1 || q_cur == 2) {
                    $('#btnLookup_condition').attr('disabled', 'disabled');
                } else {
                    $('#btnLookup_condition').removeAttr('disabled');
                }
                isEnabled();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if(q_tables == 's')
                    bbsAssign();
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

            /*Lookup*/
            function isEnabled() {
                var isEnabled = !(q_cur == 1 || q_cur == 2);
                var tableId = ['t1', 't2', 't3'];
                var obj;
                for(var i = 0; i < tableId.length; i++) {
                    if($('#' + tableId[i]).css('display') != 'none') {
                        obj = $('#' + tableId[i]);
                        if(obj.children('tbody').length > 0)
                            obj = obj.children('tbody').eq(0);
                        if(isEnabled) {
                            obj.children('tr[name="data"]').children().children('[src="option"]').removeAttr('disabled');
                            obj.children('[name="data"]').removeClass('select');
                            obj.children('[name="data"]').removeClass('focus');
                        } else {
                            obj.children('tr[name="data"]').children().children('[src="option"]').attr('disabled', 'disabled');
                            for(var j = 0; j < $('#' + tableId[i]).data('info').value.length; j++) {
                                if(q_cur == 2)
                                    $('#' + tableId[i]).data('info').value[j]._checked = false;
                                else if($('#' + tableId[i]).data('info').value[j]._checked)
                                    obj.children('tr[name="data"]').eq(j).addClass('select');
                            }
                        }
                    }
                }
            }

            function onclick_vcce() {
                var t_table = '';
                var t_typea = '';
                var t_ordeno = '';
                var t_notv = 0;
                var t_carno = '';
                var t_caseno = '';
                if($('#t1').css('display') != 'none') {
                    t_table = 't1';
                    t_typea = '1';
                } else if($('#t2').css('display') != 'none') {
                    t_table = 't2';
                    t_typea = '2';
                } else if($('#t3').css('display') != 'none') {
                    t_table = 't3';
                    t_typea = '3';
                }

                if($.type($('#' + t_table).data('info')) != "undefined") {
                    for( i = 0; i < $('#' + t_table).data('info').value.length; i++) {
                        if($('#'+t_table).data('info').value[i]._checked) {
                            t_ordeno = $('#'+t_table).data('info').value[i].ordeno;
                            t_notv = $('#'+t_table).data('info').value[i].notv;
                            t_carno = $('#'+t_table).data('info').value[i].carno;
                            t_caseno = $('#'+t_table).data('info').value[i].caseno;
                            break;
                        }
                    }
                }
                if(t_ordeno.length == 0) {
                    alert('Please Lookup first!');
                    return 0;
                }
                $('#btnIns').click();
                if(q_cur == 1) {
                    $('#txtOrdeno').val(t_ordeno);
                    $('#txtWeight').val(t_notv);
                    $('#cmbTypea').val(t_typea);
                    $('#txtCarno').val(t_carno);
                    $('#txtCaseno').val(t_caseno);
                    $('#txtDatea').val(q_date());
                    $('#txtCarno').focus();
                    window.location.hash = "#tbbm";
                    window.location.hash = "";
                }
            }

            ;(function($, undefined) {
                $.fn.refresh = function(value) {
                    if($.type($(this).data('info')) == "undefined") {
                        $(this).data('info', {
                            value : value,
                            isSort : true
                        });
                    } else {
                        if($(this).data('info').isSort)
                            $(this).data('info').value = value;
                    }
                    $(this).show();
                    var obj = $(this), obj2, obj3;
                    if($(this).children('tbody').length > 0)
                        obj = $(this).children('tbody').eq(0);
                    obj.children('tr').remove('[name="data"]');

                    for( i = 0; i < $(this).data('info').value.length; i++) {
                        obj.children('tr[name="template"]').clone().appendTo(obj);
                        obj.children('tr').last().attr('name', 'data');
                        obj.children('tr').last().show();
                        obj2 = obj.children('tr').last().children();

                        for( j = 0; j < obj2.length; j++) {
                            /*option*/
                            if(obj2.eq(j).children('[src="option"]').length > 0) {
                                obj2.eq(j).children('[src="option"]').data('info', {
                                    index : i
                                });
                                obj2.eq(j).children('[src="option"]').val(q_getPara('tranvcce.btnVcce'));
                                obj2.eq(j).children('[src="option"]').click(function(e) {
                                    var obj = $(this).parent().parent().parent().has('tbody') ? $(this).parent().parent().parent().parent() : $(this).parent().parent().parent();
                                    for(var i = 0; i < obj.data('info').value.length; i++)
                                        obj.data('info').value[i]._checked = false;
                                    obj.data('info').value[$(this).data('info').index]._checked = true;
                                    onclick_vcce();
                                });
                                obj2.eq(j).children('[src="option"]').hover(function(e) {
                                    if(!$(this).parent().parent().hasClass('select'))
                                        $(this).parent().parent().addClass('focus');
                                }, function(e) {
                                    $(this).parent().parent().removeClass('focus');
                                });
                            }
                            /*data*/
                            obj3 = obj2.eq(j).children('[type="text"]');
                            for( k = 0; k < obj3.length; k++)
                                if(obj3.eq(k).val().length > 0) {
                                    obj3.eq(k).val(eval("$(this).data('info').value[i]." + obj3.eq(k).val()));
                                    obj3.eq(k).attr('readonly', 'readonly');
                                }
                            obj3 = obj2.eq(j).children('[type="checkbox"]').not('[src="option"]');
                            for( k = 0; k < obj3.length; k++)
                                if(obj3.eq(k).val().length > 0) {
                                    obj3.eq(k).prop('checked', eval("$(this).data('info').value[i]." + obj3.eq(k).val()) == 'true');
                                    obj3.eq(k).attr('disabled', 'disabled');
                                }
                        }
                    }
                    /*Sort*/
                    if($(this).data('info').isSort) {
                        var tmp = obj.children('tr[name="header"]').eq(0).children();
                        for( i = 0; i < tmp.length; i++) {
                            index = tmp.eq(i).attr('index');
                            if( typeof (tmp.eq(i).attr('index')) != "undefined") {
                                tmp.eq(i).data('info', {
                                    parent : $(this),
                                    order : 'asc',
                                    func_sort : new Function('a', 'b', "return a." + tmp.eq(i).attr('index') + ">=b." + tmp.eq(i).attr('index') + "?1:-1;")
                                });
                                tmp.eq(i).click(function(e) {
                                    $(this).data('info').parent.data('info').value.sort($(this).data('info').func_sort);
                                    if($(this).data('info').order == 'asc') {
                                        $(this).data('info').order = 'desc';
                                    } else {
                                        $(this).data('info').parent.data('info').value.reverse();
                                        $(this).data('info').order = 'asc';
                                    }
                                    $(this).data('info').parent.data('info').isSort = false;
                                    $(this).data('info').parent.refresh($(this).data('info').parent.data('info').value);
                                });
                                tmp.eq(i).hover(function(e) {
                                    $(this).addClass('focus');
                                }, function(e) {
                                    $(this).removeClass('focus');
                                });
                            }
                        }
                    } else {
                        $(this).data('info').isSort = true;
                    }
                    isEnabled();
                }
            })($);

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 23%;
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
                width: 75%;
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
            .tbbm tr .td1, .tbbm tr .td3, .tbbm tr .td5, .tbbm tr .td7 {
                width: 10%;
            }
            .tbbm tr .td2, .tbbm tr .td4, .tbbm tr .td6, .tbbm tr .td8 {
                width: 10%;
            }
            .tbbm tr .td9 {
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
                font-size: 16px;
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
                width: 43%;
                float: left;
            }
            .txt.c3 {
                width: 52%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            td {
                margin: 0 -1px;
                padding: 0;
            }
            td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
            }
            #condition {
                width: 100%;
                background: #E0EEEE;
            }
            #condition tr[name="actioon"] {
                background-color: #EE9A00;
            }
            #condition tr[name="header"] {
                background-color: #EE9A00;
                display: none;
                font-size: 14px;
            }
            #condition tr[name="data"] {
                display: none;
            }
            #t1, #t2, #t3 {
                width: 100%;
                background: #DCDCDC;
                display: none;
            }
            #t1 tr[name="header"], #t2 tr[name="header"], #t3 tr[name="header"] {
                background-color: #5CACEE;
            }
            #t1 tr[name="header"] td, #t2 tr[name="header"] td, #t3 tr[name="header"] td {
                font-size: 14px;
            }
            #t1 tr[name="template"], #t2 tr[name="template"], #t3 tr[name="template"] {
                display: none;
            }
            #condition tr td, #t1 tr td, #t2 tr td, #t3 tr td {
                text-align: center;
            }
            #t1 tr.select, #t2 tr.select, #t3 tr.select {
                background: #F0E68C;
            }
            #t1 tr.focus, #t2 tr.focus, #t3 tr.focus {
                background: #F0E68C;
            }
            #t1 tr.focus input[type="text"], #t2 tr.focus input[type="text"], #t3 tr.focus input[type="text"] {
                color: red;
            }
            #t1 input[readonly="readonly"], #t2 input[readonly="readonly"], #t3 input[readonly="readonly"] {
                color: green;
            }
            #t1 tr.select input[type="text"], #t2 tr.select input[type="text"], #t3 tr.select input[type="text"] {
                color: red;
            }
            #t1 td.focus, #t2 td.focus, #t3 td.focus {
                cursor: pointer;
                background: #F0E68C;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%;"><a id='vewChk'></a></td>
						<td align="center" style="width:20%;"><a id='vewDatea'></a></td>
						<td align="center" style="width:15%;"><a id='vewTypea'></a></td>
						<td align="center" style="width:20%;"><a id='vewCarno'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='typea=tranvcce.typea'>~typea=tranvcce.typea</td>
						<td align="center" id='carno'>~carno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm" name="tbbm">
					<tr class="tr1">
						<td class="td1" ><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td2" >
						<input id="txtNoa" type="text"  class="txt c1"/>
						</td>
						<td class="td3" ><span> </span><a id="lblTypea" class="lbl"></a></td>
						<td class="td4" ><select id="cmbTypea" class="txt c1"></select></td>
						<td class="td5" ><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td class="td6" >
						<input id="txtDatea" type="text"  class="txt c1"/>
						</td>
						<td class="td7" ><span> </span><a id="lblOrdeno" class="lbl"></a></td>
						<td class="td8" >
						<input id="txtOrdeno" type="text"  class="txt c1"/>
						</td>
						<td class="td9" ></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblCarno" class="lbl"></a></td>
						<td class="td2">
						<input id="txtCarno" type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblDriver" class="lbl"></a></td>
						<td class="td4">
						<input id="txtDriverno" type="text"  class="txt c2"/>
						<input id="txtDriver" type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblCaseno" class="lbl"></a></td>
						<td class="td2">
						<input id="txtCaseno" type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblMount" class="lbl"></a></td>
						<td class="td4">
						<input id="txtMount" type="text"  class="txt num c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblWeight" class="lbl"></a></td>
						<td class="td6">
						<input id="txtWeight" type="text"  class="txt num c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<table id="condition">
			<tr name="schema">
				<td class="td1" style="width:7%"><span class="schema"> </span></td>
				<td class="td2" style="width:6%"><span class="schema"> </span></td>
				<td class="td3" style="width:8%"><span class="schema"> </span></td>
				<td class="td4" style="width:8%"><span class="schema"> </span></td>
				<td class="td5" style="width:7%"><span class="schema"> </span></td>
				<td class="td6" style="width:7%"><span class="schema"> </span></td>
				<td class="td7" style="width:7%"><span class="schema"> </span></td>
				<td class="td8" style="width:7%"><span class="schema"> </span></td>
				<td class="td9" style="width:7%"><span class="schema"> </span></td>
				<td class="tdA" style="width:7%"><span class="schema"> </span></td>
				<td class="tdB" style="width:7%"><span class="schema"> </span></td>
				<td class="tdC" style="width:7%"><span class="schema"> </span></td>
				<td class="tdD" style="width:7%"><span class="schema"> </span></td>
			</tr>
			<tr name="action">
				<td class="td1" colspan="14" style="text-align: left;"><span style="display: block; width:20px; height:10px; float:left;"> </span><select id="cmbTypea_condition"  style="width:100px;"></select>
				<input type="button" id="btnLookup_condition"/>
				</td>
			</tr>
			<tr name="header" class="type1">
				<td class="td1" id="lblCust_type1"></td>
				<td class="td9" id="lblOdate_type1"></td>
				<td class="td2" id='lblStradd_type1'></td>
				<td class="td3" id="lblEndadd_type1"></td>
				<td class="td4" id="lblProduct_type1"></td>
				<td class="td5" id="lblOrdeno_type1"></td>
				<td class="td6" id="lblCarno_type1"></td>
				<td class="td6" id="lblIsdisplay_type1"></td>
			</tr>
			<tr name="data" class="type1">
				<td class="td1"><select id="cmbCust_type1"  style="width:100%;"></select></td>
				<td class="td2">
				<input type="text" style="width: 95%;" id="txtOdate_type1"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 35%;" id="txtStraddno_type1"/>
				<input type="text" style="width: 60%;" id="txtStradd_type1"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 35%;" id="txtEndaddno_type1"/>
				<input type="text" style="width: 60%;" id="txtEndadd_type1"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 35%;" id="txtProductno_type1"/>
				<input type="text" style="width: 60%;" id="txtProduct_type1"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 95%;" id="txtOrdeno_type1"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 95%;" id="txtCarno_type1"/>
				</td>
				<td class="td7">
				<input type="checkbox" id="chkIsdisplay_type1"/>
				</td>
			</tr>
			<tr name="header" class="type2">
				<td class="td1" id='lblCust_type2'></td>
				<td class="td2" id="lblOdate_type2"></td>
				<td class="td3"id='lblStradd_type2'></td>
				<td class="td4" id="lblEndadd_type2"></td>
				<td class="td5" id="lblCaseno_type2"></td>
				<td class="td6" id="lblPo_type2"></td>
				<td class="td7" id="lblTraceno_type2"></td>
				<td class="td8" id="lblIsdisplay_type2"></td>
				<td class="td9" id="lblCarno_type2"></td>
				<td class="tdA" id="lblIspal_type2"></td>
				<td class="tdB" id="lblEf_type2"></td>
				<td class="tdC" id="lblOrdeno_type2"></td>
				<td class="tdD" id="lblCaseno2_type2"></td>
			</tr>
			<tr name="data" class="type2">
				<td class="td1"><select id="cmbCust_type2"  style="width:100%;"></select></td>
				<td class="td2">
				<input type="text" style="width: 95%;" id="txtOdate_type2"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 35%;" id="txtStraddno_type2"/>
				<input type="text" style="width: 60%;" id="txtStradd_type2"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 35%;" id="txtEndaddno_type2"/>
				<input type="text" style="width: 60%;" id="txtEndadd_type2"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 95%;" id="txtCaseno_type2"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 95%;" id="txtPo_type2"/>
				</td>
				<td class="td7">
				<input type="text" style="width: 95%;" id="txtTraceno_type2"/>
				</td>
				<td class="td8">
				<input type="checkbox" id="chkIsdisplay_type2"/>
				</td>
				<td class="td9">
				<input type="text" style="width: 95%;" id="txtCarno_type2"/>
				</td>
				<td class="tdA"><select id="cmbIspal_type2" style="width:100%;"></select></td>
				<td class="tdB"><select id="cmbEf_type2" style="width:100%;"></select></td>
				<td class="tdC">
				<input type="text" style="width: 95%;" id="txtOrdeno_type2"/>
				</td>
				<td class="tdD">
				<input type="text" style="width: 95%;" id="txtCaseno2_type2"/>
				</td>
			</tr>
			<tr name="header" class="type3">
				<td class="td1" id='lblCust_type3'></td>
				<td class="td2" id="lblOdate_type3"></td>
				<td class="td3" id='lblStradd_type3'></td>
				<td class="td4" id="lblEndadd_type3"></td>
				<td class="td5" id="lblShipno_type3"></td>
				<td class="td6" id="lblSo_type3"></td>
				<td class="td7" id="lblCldate_type3"></td>
				<td class="td8" id="lblCaseno_type3"></td>
				<td class="td9" id="lblIsdisplay_type3"></td>
				<td class="tdA" id="lblCarno_type3"></td>
				<td class="tdB" id="lblIspal_type3"></td>
				<td class="tdC" id="lblEf_type3"></td>
				<td class="tdD" id="lblOrdeno_type3"></td>
			</tr>
			<tr name="data" class="type3">
				<td class="td1"><select id="cmbCust_type3"  style="width:100%;"></select></td>
				<td class="td2">
				<input type="text" style="width: 95%;" id="txtOdate_type3"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 35%;" id="txtStraddno_type3"/>
				<input type="text" style="width: 60%;" id="txtStradd_type3"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 35%;" id="txtEndaddno_type3"/>
				<input type="text" style="width: 60%;" id="txtEndadd_type3"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 95%;" id="txtShipno_type3"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 95%;" id="txtSo_type3"/>
				</td>
				<td class="td7">
				<input type="text" style="width: 95%;" id="txtCldate_type3"/>
				</td>
				<td class="td8">
				<input type="text" style="width: 95%;" id="txtCaseno_type3"/>
				</td>
				<td class="td9">
				<input type="checkbox" id="chkIsdisplay_type3"/>
				</td>
				<td class="tdA">
				<input type="text" style="width: 95%;" id="txtCarno_type3"/>
				</td>
				<td class="tdB"><select id="cmbIspal_type3" style="width:100%;"></select></td>
				<td class="tdC"><select id="cmbEf_type3" style="width:100%;"></select></td>
				<td class="tdD">
				<input type="text" style="width: 95%;" id="txtOrdeno_type3"/>
				</td>
			</tr>
		</table>
		<div style="width: 100%; display: block; height:20px;">
			<p>
				&nbsp;
			</p>
		</div>
		<table id="t1" name="t1">
			<tr name="schema">
				<td class="td1" style="width:3%;"><span class="schema"> </span></td>
				<td class="td2" style="width:10%;"><span class="schema"> </span></td>
				<td class="td3" style="width:5%;"><span class="schema"> </span></td>
				<td class="td4" style="width:5%;"><span class="schema"> </span></td>
				<td class="td5" style="width:15%;"><span class="schema"> </span></td>
				<td class="td6" style="width:8%;"><span class="schema"> </span></td>
				<td class="td7" style="width:8%;"><span class="schema"> </span></td>
				<td class="td8" style="width:5%;"><span class="schema"> </span></td>
				<td class="td9" style="width:8%;"><span class="schema"> </span></td>
				<td class="tdA" style="width:5%;"><span class="schema"> </span></td>
				<td class="tdB" style="width:8%;"><span class="schema"> </span></td>
			</tr>
			<tr name="header">
				<td class="td1" id="lblChk_t1"></td>
				<td class="td2" id="lblCust_t1" index="custno"></td>
				<td class="td3" id="lblCarno_t1" index="carno"></td>
				<td class="td4" id="lblOdate_t1" index="odate"></td>
				<td class="td5" id="lblProduct_t1" index="productno"></td>
				<td class="td6" id="lblStradd_t1" index="straddno"></td>
				<td class="td7" id="lblEndadd_t1" index="endaddno"></td>
				<td class="td8" id="lblWeight_t1" index="weight"></td>
				<td class="td9" id="lblOrdeno_t1" index="ordeno"></td>
				<td class="tdA" id="lblNotv_t1" index="notv"></td>
				<td class="tdB" id="lblPal_t1" index="pal"></td>
			</tr>
			<tr name="template">
				<td class="td1">
				<input type="button" src="option"/>
				</td>
				<td class="td2">
				<input type="text" style="width: 35%;" value="custno"/>
				<input type="text" style="width: 60%;" value="cust"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 95%;" value="carno"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 95%;" value="odate"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 35%;" value="productno"/>
				<input type="text" style="width: 60%;" value="product"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 35%;" value="straddno"/>
				<input type="text" style="width: 60%;" value="stradd"/>
				</td>
				<td class="td7">
				<input type="text" style="width: 35%;" value="endaddno"/>
				<input type="text" style="width: 60%;" value="endadd"/>
				</td>
				<td class="td8">
				<input type="text" style="width: 95%; text-align: right;" value="weight"/>
				</td>
				<td class="td9">
				<input type="text" style="width: 95%;" value="ordeno"/>
				</td>
				<td class="tdA">
				<input type="text" style="width: 95%; text-align: right;" value="notv"/>
				</td>
				<td class="tdB">
				<input type="text" style="width: 95%;" value="pal"/>
				</td>
			</tr>
		</table>
		<table id="t2" name="t2">
			<tr name="schema">
				<td class="td1" style="width:3%"><span class="schema"> </span></td>
				<td class="td2" style="width:8%"><span class="schema"> </span></td>
				<td class="td3" style="width:6%"><span class="schema"> </span></td>
				<td class="td4" style="width:6%"><span class="schema"> </span></td>
				<td class="td5" style="width:6%"><span class="schema"> </span></td>
				<td class="td6" style="width:5%"><span class="schema"> </span></td>
				<td class="td7" style="width:5%"><span class="schema"> </span></td>
				<td class="td8" style="width:6%"><span class="schema"> </span></td>
				<td class="td9" style="width:3%"><span class="schema"> </span></td>
				<td class="tdA" style="width:3%"><span class="schema"> </span></td>
				<td class="tdB" style="width:5%"><span class="schema"> </span></td>
				<td class="tdC" style="width:8%"><span class="schema"> </span></td>
				<td class="tdD" style="width:8%"><span class="schema"> </span></td>
				<td class="tdE" style="width:8%"><span class="schema"> </span></td>
				<td class="tdF" style="width:8%"><span class="schema"> </span></td>
				<td class="tdG" style="width:5%"><span class="schema"> </span></td>
			</tr>
			<tr name="header">
				<td class="td1" id="lblChk_t2"></td>
				<td class="td2" id="lblCust_t2" index="custno"></td>
				<td class="td3" id="lblTraceno_t2" index="traceno"></td>
				<td class="td4" id="lblCaseno_t2" index="caseno"></td>
				<td class="td5" id="lblCaseno2_t2" index="caseno2"></td>
				<td class="td6" id="lblPo_t2" index="po"></td>
				<td class="td7" id="lblCarno_t2" index="carno"></td>
				<td class="td8" id="lblOdate_t2" index="odate"></td>
				<td class="td9" id="lblIspal_t2" index="ispal"></td>
				<td class="tdA" id="lblEf_t2" index="ef"></td>
				<td class="tdB" id="lblStatus_t2" index="status"></td>
				<td class="tdC" id="lblPal_t2" index="pal"></td>
				<td class="tdD" id="lblStradd_t2" index="straddno"></td>
				<td class="tdE" id="lblEndadd_t2" index="endadd"></td>
				<td class="tdF" id="lblOrdeno_t2" index="ordeno"></td>
				<td class="tdG" id="lblNotv_t2" index="notv"></td>
			</tr>
			<tr name="template">
				<td class="td1">
				<input type="button" src="option"/>
				</td>
				<td class="td2">
				<input type="text" style="width: 35%; float: left;" value="custno"/>
				<input type="text" style="width: 60%; float: left;" value="cust"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 95%;" value="traceno"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 95%;" value="caseno"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 95%;" value="caseno2"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 95%;" value="po"/>
				</td>
				<td class="td7">
				<input type="text" style="width: 95%;" value="carno"/>
				</td>
				<td class="td8">
				<input type="text" style="width: 95%;" value="datea"/>
				</td>
				<td class="td9">
				<input type="checkbox" value="ispal"/>
				</td>
				<td class="tdA">
				<input type="text" style="width: 95%;" value="ef"/>
				</td>
				<td class="tdB">
				<input type="text" style="width: 95%;" value="status"/>
				</td>
				<td class="tdC">
				<input type="text" style="width: 95%;" value="pal"/>
				</td>
				<td class="tdD">
				<input type="text" style="width: 35%;" value="straddno"/>
				<input type="text" style="width: 60%;" value="stradd"/>
				</td>
				<td class="tdE">
				<input type="text" style="width: 35%;" value="endaddno"/>
				<input type="text" style="width: 60%;" value="endadd"/>
				</td>
				<td class="tdF">
				<input type="text" style="width: 95%;" value="ordeno"/>
				</td>
				<td class="tdG">
				<input type="text" style="width: 95%; text-align: right;" value="notv"/>
				</td>
			</tr>
		</table>
		<table id="t3" name="t3">
			<tr name="schema">
				<td class="td1" style="width:3%"><span class="schema"> </span></td>
				<td class="td2" style="width:8%"><span class="schema"> </span></td>
				<td class="td3" style="width:6%"><span class="schema"> </span></td>
				<td class="td4" style="width:6%"><span class="schema"> </span></td>
				<td class="td5" style="width:6%"><span class="schema"> </span></td>
				<td class="td6" style="width:5%"><span class="schema"> </span></td>
				<td class="td7" style="width:5%"><span class="schema"> </span></td>
				<td class="td8" style="width:6%"><span class="schema"> </span></td>
				<td class="td9" style="width:3%"><span class="schema"> </span></td>
				<td class="tdA" style="width:3%"><span class="schema"> </span></td>
				<td class="tdB" style="width:5%"><span class="schema"> </span></td>
				<td class="tdC" style="width:8%"><span class="schema"> </span></td>
				<td class="tdD" style="width:8%"><span class="schema"> </span></td>
				<td class="tdE" style="width:8%"><span class="schema"> </span></td>
				<td class="tdF" style="width:8%"><span class="schema"> </span></td>
				<td class="tdG" style="width:5%"><span class="schema"> </span></td>
			</tr>
			<tr name="header">
				<td class="td1" id="lblChk_t3"></td>
				<td class="td2" id="lblCust_t3" index="custno"></td>
				<td class="td3" id="lblCldate_t3" index="cldate"></td>
				<td class="td4" id="lblCaseno_t3" index="caseno"></td>
				<td class="td5" id="lblCaseno2_t3" index="caseno2"></td>
				<td class="td6" id="lblSo_t3" index="so"></td>
				<td class="td7" id="lblCarno_t3" index="carno"></td>
				<td class="td8" id="lblOdate_t3" index="odate"></td>
				<td class="td9" id="lblIspal_t3" index="ispal"></td>
				<td class="tdA" id="lblEf_t3" index="ef"></td>
				<td class="tdB" id="lblStatus_t3" index="status"></td>
				<td class="tdC" id="lblPal_t3" index="pal"></td>
				<td class="tdD" id="lblStradd_t3" index="straddno"></td>
				<td class="tdE" id="lblEndadd_t3" index="endadd"></td>
				<td class="tdF" id="lblOrdeno_t3" index="ordeno"></td>
				<td class="tdG" id="lblNotv_t3" index="notv"></td>
			</tr>
			<tr name="template">
				<td class="td1">
				<input type="button" src="option"/>
				</td>
				<td class="td2">
				<input type="text" style="width: 35%; float: left;" value="custno"/>
				<input type="text" style="width: 60%; float: left;" value="cust"/>
				</td>
				<td class="td3">
				<input type="text" style="width: 95%;" value="cldate"/>
				</td>
				<td class="td4">
				<input type="text" style="width: 95%;" value="caseno"/>
				</td>
				<td class="td5">
				<input type="text" style="width: 95%;" value="caseno2"/>
				</td>
				<td class="td6">
				<input type="text" style="width: 95%;" value="so"/>
				</td>
				<td class="td7">
				<input type="text" style="width: 95%;" value="carno"/>
				</td>
				<td class="td8">
				<input type="text" style="width: 95%;" value="odate"/>
				</td>
				<td class="td9">
				<input type="checkbox" value="ispal"/>
				</td>
				<td class="tdA">
				<input type="text" style="width: 95%;" value="ef"/>
				</td>
				<td class="tdB">
				<input type="text" style="width: 95%;" value="status"/>
				</td>
				<td class="tdC">
				<input type="text" style="width: 95%;" value="pal"/>
				</td>
				<td class="tdD">
				<input type="text" style="width: 35%;" value="straddno"/>
				<input type="text" style="width: 60%;" value="stradd"/>
				</td>
				<td class="tdE">
				<input type="text" style="width: 35%;" value="endaddno"/>
				<input type="text" style="width: 60%;" value="endadd"/>
				</td>
				<td class="tdF">
				<input type="text" style="width: 95%;" value="ordeno"/>
				</td>
				<td class="tdG">
				<input type="text" style="width: 95%; text-align: right;" value="notv"/>
				</td>
			</tr>
		</table>

		<input id="q_sys" type="hidden" />
	</body>
</html>
