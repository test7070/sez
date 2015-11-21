<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			//********************************************
			$.fn.q_report = function (value) {
    $(this).data('info', {
        fileName: value.fileName,
        reportData: new Array(),
        options: value.options,
        sqlCondition: new Array(),
        radioIndex: -1,
        itemIndex: 0,
        item: new Array(),
        init: function (obj) {
            var tmp;
            if (typeof (aPop) == 'undefined')
                aPop = new Array();

            obj.data('info').reportData = obj.data('info').getReportData();
            obj.addClass('q_report');
            obj.append('<div class="report "></div>');
            obj.append('<div class="option "></div>');
            tmp = obj.children('.report').eq(0);

            for (i = 0; i < obj.data('info').reportData.length; i++) {
                tmp.append('<div></div>');
                tmp.children('div').eq(i).append('<span class="radio nonfocus nonselect"></span>');
                tmp.children('div').eq(i).append('<span class="text nonfocus nonselect">' + obj.data('info').reportData[i].reportName + '</span>');
                tmp.children('div').eq(i).data('info', {
                    index: i,
                    report: obj.data('info').reportData[i].report,
                    reportName: obj.data('info').reportData[i].reportName,
                    reportOption: obj.data('info').reportData[i].reportOption
                });
            }

            obj.children('.report').children('div').hover(function (e) {
                var obj = $(this).parent().parent();
                $(this).children('.text').removeClass('nonfocus').addClass('focus');
            }, function (e) {
                $(this).children('.text').removeClass('focus').addClass('nonfocus');
            });
            obj.children('.report').children('div').click(function (e) {
                var obj = $(this).parent().parent();
                obj.children('.report').children('div').children('.radio').removeClass('select').addClass('nonselect');
                $(this).children('.radio').removeClass('nonselect').addClass('select');
                if (obj.data('info').radioIndex != $(this).data('info').index) {
                    document.getElementById("frameReport").value = "";
                    document.getElementById("frameReport").src = "";
                }
                obj.data('info').radioIndex = $(this).data('info').index;
                obj.data('info').refresh(obj);
            });
            for (i = 0; i < obj.data('info').options.length; i++) {
                obj.data('info').addOption(obj, obj.data('info').options[i])
            }
            obj.children('.option').children('div.option').children('.btnLookup').hover(function (e) {
                var obj = $(this).parent().parent().parent();
                obj.children('.option').children('div.option').children('.btnLookup').removeClass('focus').addClass('nonfocus');
                $(this).removeClass('nonfocus').addClass('focus');
            }, function (e) {
                $(this).removeClass('focus').addClass('nonfocus');
            });
            if (obj.data('info').reportData.length > 0) {
                obj.children('.report').children('div').eq(0).click();
            }
            if ($('#btnOk').length > 0) {
                $('#btnOk').data('info', {
                    qReport: obj
                });
                $('#btnOk').click(function () { Lock(); obj.data('info').execute(obj); });
            };
        },
        execute: function (obj) {
            obj = $('#btnOk').data('info').qReport;
            var n = obj.data('info').radioIndex;
            var tmp = "";
            var t_para = "r_comp=" + q_getPara('sys.comp');
            var t_where = "";
            for (i = 0; i < obj.data('info').sqlCondition.length; i++) {
                tmp = obj.data('info').sqlCondition[i].getValue();
                t_para = t_para + (t_para.length > 0 ? ',' : '') + obj.data('info').sqlCondition[i].key + '=' + tmp;
                switch (obj.data('info').sqlCondition[i].type) {
                    case '0':
                        t_where = t_where + (t_where.length > 0 ? ';' : '') + (t_where.length==0 && tmp.length == 0 ? ' ' : tmp );
                        break;
                    default:
                        t_where = t_where + (t_where.length > 0 ? ';' : '') + (!$("#" + obj.data('info').sqlCondition[i].parent).is(":hidden") && tmp.length > 0 ? "'" + tmp + "'" : "'#non'");
                }
            }

            if (n > -1 && n < obj.data('info').reportData.length && t_where.length > 0 && t_para.length > 0) {
                //alert(t_where);
                //alert(t_para);
                // alert(obj.data('info').fileName);
                // alert(obj.data('info').reportData[n].reportName);
                q_gtx(obj.data('info').reportData[n].report, t_where + ";;" + t_para + ";;" + obj.data('info').fileName + ";;" + obj.data('info').reportData[n].reportName);
            }

        },
        refresh: function (obj) {
            obj.children('.option').children('div.option').hide();
            if (obj.data('info').radioIndex >= 0 && obj.data('info').radioIndex < obj.data('info').reportData.length) {
                var value, n = obj.data('info').reportData[obj.data('info').radioIndex].reportOption;
                n = (n.substring(0, 2).toUpperCase() == '0X' ? n.substring(2) : n);
                for (i = 0; i < obj.children('.option').children('div.option').length && Math.floor(i / 4) < n.length; i++) {
                    value = n.substring(n.length - 1 - Math.floor(i / 4), n.length - Math.floor(i / 4));
                    if (parseInt('0x' + value, 16) & (Math.pow(2, i % 4))) {
                        obj.children('.option').children('div.option').eq(i).show();
                    }
                }
            }
        },
        getReportData: function () {
            var tmp = new Array();
            for (i = 1; i > 0; i++) {
                var tmp1 = q_getMsg('report' + i.toString());
                var tmp2 = q_getMsg('reportName' + i.toString());
                var tmp3 = q_getMsg('reportOption' + i.toString());
                if (tmp1.length == 0 || tmp1 == '..')
                    break;
                else {
                    if (!(tmp2.length == 0 || tmp2 == '..') && !(tmp3.length == 0 || tmp3 == '..'))
                        tmp.push({
                            report: tmp1,
                            reportName: tmp2,
                            reportOption: tmp3
                        });
                }
            }
            return tmp;
        },
        addOption: function (obj, option) {
            if ($.type(option.type) != 'string')
                return 0;
            if ($.type(option.name) != 'string')
                return 0;
            if ($.type(option.group) !== 'string')
                option.group = '';
            if ($.type(option.dbf) !== 'string')
                option.dbf = '';
            if ($.type(option.index) !== 'string')
                option.index = '';
            if ($.type(option.src) !== 'string')
                option.src = '';
            if (typeof (option.value) == 'undefined') {
                option.value = '';
            }
            if ($.type(option.size) !== 'string') {
                if (option.value.length > 0)
                    option.size = option.value.length + '';
                else
                    option.size = '1';
            }

            var t_name = option.name.substring(0, 1).toUpperCase() + option.name.substring(1);
            var tmpStr, block;
            switch (option.type) {
                case '0':
                    //accy
                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        key: option.name,
                        getValue: function () {
                            return option.value;
                        }
                    });
                    break;
                case '1':
                    tmpStr = '';
                    block = {
                        name: t_name,
                        lbl: 'lbl' + t_name,
                        txt1: 'txt' + t_name + '1',
                        txt2: 'txt' + t_name + '2'
                    };
                    tmpStr += '<div id="' + block.name + '" class="option a1 ">';
                    tmpStr += '<div class="label c6">';
                    tmpStr += '<span id="' + block.lbl + '"></span>';
                    tmpStr += '</div>';
                    tmpStr += '<input id="' + block.txt1 + '" class="c3 text" type="text"/>';
                    tmpStr += '<span class="c1 dash">~</span>';
                    tmpStr += '<input id="' + block.txt2 + '" class="c3 text" type="text"/>';
                    tmpStr += '</div>';
                    obj.children('.option').eq(0).append(tmpStr);
                    obj.data('info').itemIndex = obj.data('info').itemIndex + 1;
                    obj.data('info').item.push(block.txt1);
                    $('#' + block.txt1).data('info', {
                        itemIndex: obj.data('info').itemIndex
                    });
                    obj.data('info').itemIndex = obj.data('info').itemIndex + 1;
                    obj.data('info').item.push(block.txt2);
                    $('#' + block.txt2).data('info', {
                        itemIndex: obj.data('info').itemIndex
                    });
                    //                    $('#' + block.txt1).keydown(function (e) {
                    //                        if (e.which == 13) {
                    //                            var curIndex = $(this).data('info').itemIndex;
                    //                            var item = $(this).parent().parent().parent().data('info').item;
                    //                            if (curIndex < item.length)
                    //                                $('#' + item[curIndex]).focus();
                    //                        }
                    //                    });
                    //                    $('#' + block.txt1).focus(function () { $(this).select(); });
                    //                    $('#' + block.txt2).keydown(function (e) {
                    //                        if (e.which == 13) {
                    //                            var curIndex = $(this).data('info').itemIndex;
                    //                            var item = $(this).parent().parent().parent().data('info').item;
                    //                            if (curIndex < item.length)
                    //                                $('#' + item[curIndex]).focus();
                    //                        }
                    //                    });
                    //                    $('#' + block.txt2).focus(function () { $(this).select(); });
                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: 'b' + option.name,
                        getValue: function () {
                            return $.trim($('#' + block.txt1).val());
                        }
                    });
                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: 'e' + option.name,
                        getValue: function () {
                            return $.trim($('#' + block.txt2).val());
                        }
                    });
                    break;
                case '2':
                    tmpStr = '';
                    block = {
                        name: t_name,
                        lbl: 'lbl' + t_name,
                        txt1a: 'txt' + t_name + '1a',
                        txt1b: 'txt' + t_name + '1b',
                        btn1: 'btn' + t_name + '1',
                        txt2a: 'txt' + t_name + '2a',
                        txt2b: 'txt' + t_name + '2b',
                        btn2: 'btn' + t_name + '2'
                    };
                    tmpStr += '<div id="' + block.name + '" class="option a1 ">';
                    tmpStr += '<div class="label c6">';
                    tmpStr += '<span id="' + block.lbl + '"></span>';
                    tmpStr += '</div>';
                    tmpStr += '<input id="' + block.txt1a + '" class="c2 text" type="text"/>';
                    tmpStr += '<input id="' + block.txt1b + '" class="c3 text" type="text"/>';
                    tmpStr += '<span id="' + block.btn1 + '" class="btnLookup nonselect nonfocus"></span>';
                    tmpStr += '<span class="c1 dash">~</span>';
                    tmpStr += '<input id="' + block.txt2a + '" class="c2 text" type="text"/>';
                    tmpStr += '<input id="' + block.txt2b + '" class="c3 text" type="text"/>';
                    tmpStr += '<span id="' + block.btn2 + '" class="btnLookup nonselect nonfocus"></span>';
                    tmpStr += '</div>';
                    obj.children('.option').eq(0).append(tmpStr);
                    //alert(block.txt1a+','+ block.btn1+','+option.dbf+',"'+ option.index+'","'+block.txt1a + ',' + block.txt1b+'",'+option.src);
                    aPop = aPop.concat([[block.txt1a, block.btn1, option.dbf, option.index, block.txt1a + ',' + block.txt1b, option.src]]);
                    aPop = aPop.concat([[block.txt2a, block.btn2, option.dbf, option.index, block.txt2a + ',' + block.txt2b, option.src]]);
					
					//txt1 值帶入 txt2 -- 2015/11/21
					$('#'+block.txt1a).data('nextTextbox',{'1b':block.txt1b,'2a':block.txt2a,'2b':block.txt2b});

					$('#'+block.txt1a).focusout(function(e){
						if($(this).val().length>0){
							$('#'+$(this).data('nextTextbox')['2a']).val($(this).val());
							$('#'+$(this).data('nextTextbox')['2b']).val($('#'+$(this).data('nextTextbox')['1b']).val());								
						}
					});
					
                    $('#' + block.txt1b).attr('disabled', 'disabled');
                    $('#' + block.txt2b).attr('disabled', 'disabled');
                    obj.data('info').itemIndex = obj.data('info').itemIndex + 1;
                    obj.data('info').item.push(block.txt1a);
                    $('#' + block.txt1a).data('info', {
                        itemIndex: obj.data('info').itemIndex
                    });
                    obj.data('info').itemIndex = obj.data('info').itemIndex + 1;
                    obj.data('info').item.push(block.txt2a);
                    $('#' + block.txt2a).data('info', {
                        itemIndex: obj.data('info').itemIndex
                    });
                    //                    $('#' + block.txt1a).keydown(function (e) {
                    //                        if (e.which == 13) {
                    //                            var curIndex = $(this).data('info').itemIndex;
                    //                            var item = $(this).parent().parent().parent().data('info').item;
                    //                            if (curIndex < item.length)
                    //                                $('#' + item[curIndex]).focus();
                    //                        }
                    //                    });
                    //                    $('#' + block.txt1a).focus(function () { $(this).select(); });
                    //                    $('#' + block.txt2a).keydown(function (e) {
                    //                        if (e.which == 13) {
                    //                            var curIndex = $(this).data('info').itemIndex;
                    //                            var item = $(this).parent().parent().parent().data('info').item;
                    //                            if (curIndex < item.length)
                    //                                $('#' + item[curIndex]).focus();
                    //                        }
                    //                    });
                    //                    $('#' + block.txt2a).focus(function () { $(this).select(); });

                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: 'b' + option.name,
                        getValue: function () {
                            return $.trim($('#' + block.txt1a).val());
                        }
                    });
                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: 'e' + option.name,
                        getValue: function () {
                            return $.trim($('#' + block.txt2a).val());
                        }
                    });
                    break;
                case '3':
                    tmpStr = '';
                    block = {
                        name: t_name,
                        lbl: 'lbl' + t_name,
                        txt1: 'txt' + t_name + '1',
                        btn1: 'btn' + t_name + '1',
                        txt2: 'txt' + t_name + '2',
                        btn2: 'btn' + t_name + '2'
                    };
                    tmpStr += '<div id="' + block.name + '" class="option a1 ">';
                    tmpStr += '<div class="label c6">';
                    tmpStr += '<span id="' + block.lbl + '"></span>';
                    tmpStr += '</div>';
                    tmpStr += '<input id="' + block.txt1 + '" class="c3 text" type="text"/>';
                    tmpStr += '<span id="' + block.btn1 + '" class="btnLookup nonselect nonfocus"></span>';
                    tmpStr += '<span class="c1 dash">~</span>';
                    tmpStr += '<input id="' + block.txt2 + '" class="c3 text" type="text"/>';
                    tmpStr += '<span id="' + block.btn2 + '" class="btnLookup nonselect nonfocus"></span>';
                    tmpStr += '</div>';
                    obj.children('.option').eq(0).append(tmpStr);
                    aPop = aPop.concat([[block.txt1, block.btn1, option.dbf, option.index, block.txt1, option.src]]);
                    aPop = aPop.concat([[block.txt2, block.btn2, option.dbf, option.index, block.txt2, option.src]]);

                    obj.data('info').itemIndex = obj.data('info').itemIndex + 1;
                    obj.data('info').item.push(block.txt1);
                    $('#' + block.txt1).data('info', {
                        itemIndex: obj.data('info').itemIndex
                    });
                    obj.data('info').itemIndex = obj.data('info').itemIndex + 1;
                    obj.data('info').item.push(block.txt2);
                    $('#' + block.txt2).data('info', {
                        itemIndex: obj.data('info').itemIndex
                    });
                    //                    $('#' + block.txt1).keydown(function (e) {
                    //                        if (e.which == 13) {
                    //                            var curIndex = $(this).data('info').itemIndex;
                    //                            var item = $(this).parent().parent().parent().data('info').item;
                    //                            if (curIndex < item.length)
                    //                                $('#' + item[curIndex]).focus();
                    //                        }
                    //                    });
                    //                    $('#' + block.txt1).focus(function () { $(this).select(); });
                    //                    $('#' + block.txt2).keydown(function (e) {
                    //                        if (e.which == 13) {
                    //                            var curIndex = $(this).data('info').itemIndex;
                    //                            var item = $(this).parent().parent().parent().data('info').item;
                    //                            if (curIndex < item.length)
                    //                                $('#' + item[curIndex]).focus();
                    //                        }
                    //                    });
                    //                    $('#' + block.txt2).focus(function () { $(this).select(); });

                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: 'b' + option.name,
                        getValue: function () {
                            return $.trim($('#' + block.txt1).val());
                        }
                    });
                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: 'e' + option.name,
                        getValue: function () {
                            return $.trim($('#' + block.txt2).val());
                        }
                    });
                    break;

                case '4':
                    //radio
                    tmpStr = '';
                    block = {
                        name: t_name,
                        lbl: 'lbl' + t_name
                    };
                    tmpStr += '<div id="' + block.name + '" class="option a3 ">';
                    tmpStr += '<input type="radio" class="c1 rad"';
                    tmpStr += (option.group.length > 0) ? ' name="' + option.group + '"' : '';
                    tmpStr += ' />';
                    tmpStr += '<div class="label c6">';
                    tmpStr += '<span id="' + block.lbl + '"></span>';
                    tmpStr += '</div>';
                    tmpStr += '</div>';
                    obj.children('.option').eq(0).append(tmpStr);
                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: option.name,
                        getValue: function () {
                            return $("#" + block.name).find('input:radio').eq(0).is(":checked");
                        }
                    });
                    break;
                case '5':
                    //select
                    tmpStr = '';
                    block = {
                        name: t_name,
                        lbl: 'lbl' + t_name
                    };
                    tmpStr += '<div id="' + block.name + '" class="option a2 ">';
                    tmpStr += '<div class="label c6">';
                    tmpStr += '<span id="' + block.lbl + '"></span>';
                    tmpStr += '</div>';
                    tmpStr += '<select class="c4 cmb">';
                    if ($.type(option.value) != 'undefined') {
                        for (j = 0; j < option.value.length; j++) {
                            if (option.value[j].indexOf('@') > 0) {
                                tmpStr += '<option value="' + option.value[j].split('@')[0] + '">' + option.value[j].split('@')[1] + '</option>';
                            } else {
                                tmpStr += '<option value="' + option.value[j] + '">' + option.value[j] + '</option>';
                            }
                        }
                    }
                    tmpStr += '</select></div>';
                    obj.children('.option').eq(0).append(tmpStr);
                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: option.name,
                        getValue: function () {
                            return $("#" + block.name).find('select :selected').val();
                        }
                    });
                    break;

                case '6':
                    tmpStr = '';
                    block = {
                        name: t_name,
                        lbl: 'lbl' + t_name,
                        txt: 'txt' + t_name
                    };
                    tmpStr += '<div id="' + block.name + '" class="option a2 ">';
                    tmpStr += '<div class="label c6">';
                    tmpStr += '<span id="' + block.lbl + '"></span>';
                    tmpStr += '</div>';
                    tmpStr += '<input id="' + block.txt + '" class="c5 text" type="text"/>';
                    tmpStr += '</div>';
                    obj.children('.option').eq(0).append(tmpStr);

                    obj.data('info').itemIndex = obj.data('info').itemIndex + 1;
                    obj.data('info').item.push(block.txt);
                    $('#' + block.txt).data('info', {
                        itemIndex: obj.data('info').itemIndex
                    });
                    //                    $('#' + block.txt).keydown(function (e) {
                    //                        if (e.which == 13) {
                    //                            var curIndex = $(this).data('info').itemIndex;
                    //                            var item = $(this).parent().parent().parent().data('info').item;
                    //                            if (curIndex < item.length)
                    //                                $('#' + item[curIndex]).focus();
                    //                        }
                    //                    });
                    //                    $('#' + block.txt).focus(function () { $(this).select(); });

                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: option.name,
                        getValue: function () {
                            return $.trim($('#' + block.txt).val());
                        }
                    });
                    break; case '7':
                    //multiple select
                    tmpStr = '';
                    block = {
                        name: t_name,
                        lbl: 'lbl' + t_name
                    };
                    tmpStr += '<div id="' + block.name + '" class="option a1 ">';
                    tmpStr += '<div class="label c6">';
                    tmpStr += '<span id="' + block.lbl + '"></span>';
                    tmpStr += '</div>';
                    tmpStr += '<select multiple="multiple" size="' + option.size + '" class="c4 cmb">';
                    if ($.type(option.value) != 'undefined') {
                        for (j = 0; j < option.value.length; j++) {
                            if (option.value[j].indexOf('@') > 0) {
                                tmpStr += '<option value="' + option.value[j].split('@')[0] + '">' + option.value[j].split('@')[1] + '</option>';
                            } else {
                                tmpStr += '<option value="' + option.value[j] + '">' + option.value[j] + '</option>';
                            }
                        }
                    }
                    tmpStr += '</select></div>';
                    obj.children('.option').eq(0).append(tmpStr);
                    $('#' + block.name).css('height', (10 + 20 * option.size) + 'px');
                    $('#' + block.name).children('select').eq(0).css('height', 20 * option.size + 'px');
                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: option.name,
                        getValue: function () {
                            var t_val = $("#" + block.name).children('select').eq(0).val();
                            return $.type(t_val) == "array" ? t_val : "";
                        }
                    });
                    break;
                case '8':
                    //multiple checkbox
                    tmpStr = '';
                    block = {
                        name: t_name,
                        lbl: 'lbl' + t_name,
                        groupname: 'chk' + t_name
                    };
                    tmpStr += '<div id="' + block.name + '" class="option a1">';
                    tmpStr += '<div class="label c6" style="display:block;float:left;">';
                    tmpStr += '<span id="' + block.lbl + '"></span>';
                    tmpStr += '</div>';
                    tmpStr += '<div id="' + block.groupname + '" style="width:500px;display:block;float:left;">';

                    if ($.type(option.value) != 'undefined') {
                        for (j = 0; j < option.value.length; j++) {
                            if (option.value[j].indexOf('@') > 0) {
                                tmpStr += '<input type="checkbox" value="' + option.value[j].split('@')[0] + '" style="width:25px;height:15px;float:left;"><span style="width:215px;height:25px;display:block;float:left;">' + option.value[j].split('@')[1] + '</span>';
                            } else {
                                tmpStr += '<input type="checkbox" value="' + option.value[j] + '" style="width:25px;height:15px;float:left;"/><span style="width:215px;height:25px;display:block;float:left;">' + option.value[j] + '</span>';
                            }
                        }
                    }
                    tmpStr += '</div></div>';
                    obj.children('.option').eq(0).append(tmpStr);
                    $('#' + block.name).css('height', (25 * Math.ceil(option.size / 2)) + 'px');
                    $('#' + block.groupname).css('height', (25 * Math.ceil(option.size / 2)) + 'px');
                    obj.data('info').sqlCondition.push({
                        type: option.type,
                        parent: block.name,
                        key: option.name,
                        getValue: function () {
                            var t_val = '';
                            var t_elements = $("#" + block.groupname).children('input:checked');
                            for (var x = 0; x < t_elements.length; x++) {
                                t_val += (t_val.length > 0 ? ',' : '') + t_elements.eq(x).val();
                            }
                            return t_val;
                        }
                    });
                    break;
            }
        }
    });
    $(this).data('info').init($(this));
}



            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
            }
            var isInit = false;
            var t_carkind = null;
            aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx']
            , ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx'],
            ['txtYcarno', 'lblYcarno', 'car2', 'a.noa,driverno,driver', 'txtYcarno', 'car2_b.aspx']);
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_anadcsales');
            });
            function q_gfPost() {
                q_gt('carkind', '', 0, 0, 0, "");
            }
			var sssno='';
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
                        q_gt('carteam', '', 0, 0, 0, "");
                        break;
                    case 'carteam':
                        t_carteam = '';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_carteam += (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_gt('calctype2', '', 0, 0, 0, "calctypes");
                        break;
                    case 'calctypes':
                        t_calctypes = '';
                        var as = _q_appendData("calctypes", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_calctypes += (t_calctypes.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                        }
                        init();
                        break;
                }
            }
            function init(){
                $('#q_report').q_report({
                    fileName : 'z_anadcsales',
                    options : [{/*[1]-會計年度*/
                        type : '0',
                        name : 'accy',
                        value : r_accy
                    }, {/*1-[2],[3]-交運日期*///1-1
                        type : '1',
                        name : 'trandate'
                    }, {/*2-[4]-車牌*///1-2
                        type : '6',
                        name : 'xcarno'
                    }, {/*3-[5]-車種*///1-4
                     	type : '8',
                        name : 'xcarkind',
                        value : t_carkind.split(',')
                    }, {/*4-[6]-耗油比(%)*///1-8
                        type : '6',
                        name : 'xcheckrate'
                    }, {/*5-[7]-排序依耗油比、交運日期、收入、年份、司機、淨利*///2-1
                        type : '5',
                        name : 'xsort01',
                        value : q_getMsg('tsort01').split('&')
                    }, {/*6-[8]-其他設定(出車明細、加油明細)*///2-2
                     	type : '8',
                        name : 'xfilter01',
                        value : q_getMsg('tfilter01').split('&')
                    }, {/*7-[9]-其他設定2(指定車牌)*///2-4
                     	type : '8',
                        name : 'xoption01',
                        value : q_getMsg('toption01').split('&')
                    }, {/*8-[10]-排序依車種、年份、耗油比、淨利*///2-8
                        type : '5',
                        name : 'xsort02',
                        value : q_getMsg('tsort02').split('&')
                    }, {/*9-[11][12]登錄日期*///*3-1
                        type : '1',
                        name : 'ydate'
                    }, {/*10-[13][14]交運日期*///*3-2
                        type : '1',
                        name : 'ytrandate'
                    }, {/*11-[15][16]客戶*///*3-4
                        type : '2',
                        name : 'ycust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*12-[17][18]司機*///*3-8
                        type : '2',
                        name : 'ydriver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {/*13-[19]車牌*///*4-1
                        type : '6',
                        name : 'ycarno'
                    }, {/*14-[20]PO*///*4-2
                        type : '6',
                        name : 'ypo'
                    }, {/*15-[21][22]起迄地點*///*4-4
                        type : '2',
                        name : 'yaddr',
                        dbf : 'addr',
                        index : 'noa,addr',
                        src : 'addr_b.aspx'
                    }, {/*16-[23]其他選項-(含折扣)*///4-8
                        type : '8',
                        name : 'yoption2',
                        value : q_getMsg('toption2').split('&')
                    }, {/*17-[24]車隊*///5-1
                        type : '8',
                        name : 'ycarteam',
                        value : t_carteam.split(',')
                    }, {/*18-[25]計算類別*///5-2
                        type : '8',
                        name : 'ycalctypes',
                        value : t_calctypes.split(',')
                    }, {/*19-[26]排序(電腦編號、登錄日期、交運日期、車牌、客戶編號、司機編號、起迄地點)*///*5-4
                        type : '5',
                        name : 'ysort03',
                        value : q_getMsg('tsort03').split('&')
                    }, {/*20-[27]-櫃號*///5-8
                        type : '6',
                        name : 'xcaseno'
                    }, {/*21-[28]-排序方式*//*08*/
						type : '8',
						name : 'xoption08',
						value : q_getMsg('toption08').split('&')
					}, {/*22-[29][30]-月份*/
                        type : '1',
                        name : 'xxmon'
                    }]
                });
                q_popAssign();
                q_langShow();

                $('#txtTrandate1').mask('999/99/99');
                $('#txtTrandate1').datepicker();
                $('#txtTrandate2').mask('999/99/99');
                $('#txtTrandate2').datepicker();
                $('#txtXcheckrate').val(q_getMsg('trate1'));
                $('#chkXcarkind').children('input').attr('checked', 'checked');
                $('#txtYdate1').mask('999/99/99');
                $('#txtYdate1').datepicker();
                $('#txtYdate2').mask('999/99/99');
                $('#txtYdate2').datepicker();
                $('#txtYtrandate1').mask('999/99/99');
                $('#txtYtrandate1').datepicker();
                $('#txtYtrandate2').mask('999/99/99');
                $('#txtYtrandate2').datepicker();

                $('#chkYoption2').children('input').attr('checked', 'checked');
                $('#chkYcarteam').children('input').attr('checked', 'checked');
                $('#chkYcalctypes').children('input').attr('checked', 'checked');
				$('#txtXxmon1').mask('999/99');
            	$('#txtXxmon2').mask('999/99');
            }
            function q_boxClose(t_name) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>