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
            function Calendar() {
            }
            Calendar.prototype = {
                id : "calendar"
                ,lunarcalendar:new Array()
                , year : 2014
                , month : 4
                , days : 0
                , dayName : ["日", "一", "二", "三", "四", "五", "六"]
                , cdate : ['初一','初二','初三','初四','初五','初六','初七','初八','初九','初十','十一','十二','十三','十四','十五','十六','十七','十八','十九','廿十','廿一','廿二','廿三','廿四','廿五','廿六','廿七','廿八','廿九','卅十']
                , init : function() {
                    $("#btnNext").click(function(e) {
                        calendar.next();
                    }).hover(function(e){
                        $(this).css("background-color","#F6D8CE");
                    },function(e){
                        $(this).css("background-color","#A9E2F3");
                    });
                    $("#btnPrevious").click(function(e) {
                        calendar.previous();
                    }).hover(function(e){
                        $(this).css("background-color","#F6D8CE");
                    },function(e){
                        $(this).css("background-color","#A9E2F3");
                    });
                    //-------------------------------------------------------------
                    $('#lblYear').focusout(function(e){
                       try{
                           t_year = parseInt($('#lblYear').html().replace(/[\s|\t|\n|\v|\f|\r]/g,""));
                           t_month = parseInt($('#lblMonth').html().replace(/[\s|\t|\n|\v|\f|\r]/g,""));
                           if(!(t_year==calendar.year && t_month==calendar.month)){
                               var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                               if(regex.test(t_year+'/'+t_month+'/01')){
                                   $('#lblYear').html(t_year);
                                   $('#lblMonth').html(t_month);
                                   calendar.year = t_year;
                                   calendar.month = t_month;
                                   calendar.getDays();
                                   calendar.getData();
                               }else{
                                   alert('日期異常');   
                               }
                           }
                       }catch(e){
                            alert('日期異常');   
                       } 
                    });
                    $('#lblMonth').focusout(function(e){
                       try{
                           t_year = parseInt($('#lblYear').html().replace(/[\s|\t|\n|\v|\f|\r]/g,""));
                           t_month = parseInt($('#lblMonth').html().replace(/[\s|\t|\n|\v|\f|\r]/g,""));
                           if(!(t_year==calendar.year && t_month==calendar.month)){
                               var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                               if(regex.test(t_year+'/'+t_month+'/01')){
                                   $('#lblYear').html(t_year);
                                   $('#lblMonth').html(t_month);
                                   calendar.year = t_year;
                                   calendar.month = t_month;
                                   calendar.getDays();
                                   calendar.getData();
                               }else{
                                   alert('日期異常');   
                               }
                           }
                       }catch(e){
                            alert('日期異常');   
                       } 
                    });
                    $('#btnSave_msg').click(function(e){
                        var t_data = {
                            date : $.trim($('#txtDate_msg').html()),
                            holiday : $.trim($('#txtHoliday_msg').val()),
                            memo : $.trim($('#txtMemo_msg').val()).replace(/\n/g,"char(10)"),
                            color : $('#txtColor_msg').val()
                        };
                        var t_noa = $.trim($('#txtDate_msg').html());
                        var t_memo = $.trim($('#txtHoliday_msg').val());
                        var t_memo2 = JSON.stringify(t_data);//.replace(/\"/g,'char(34)');
                        var json = JSON.stringify({
                            userno : r_userno,
                            namea : r_name,
                            noa : t_noa,
                            memo : t_memo,
                            memo2 : t_memo2
                        });
                        if(t_noa.length>0){
                            $("#msg").hide();
                            Lock(1, {
                                opacity : 0
                            });
                            $.ajax({
                                url: 'calendar_holiday.aspx',
                                type: 'POST',
                                data: json,
                                dataType: 'text',
                                timeout: 30000,
                                success: function(data){ 
                                    if(data.length>0)
                                        alert('Error message:\n'+data);
                                },
                                complete: function(){                    
                                },
                                error: function(jqXHR, exception) {
                                    var errmsg = '資料傳送異常。\n'+this.data;
                                    if (jqXHR.status === 0) {
                                        alert(errmsg+'Not connect.\n Verify Network.');
                                    } else if (jqXHR.status == 404) {
                                        alert(errmsg+'Requested page not found. [404]');
                                    } else if (jqXHR.status == 500) {
                                        alert(errmsg+'Internal Server Error [500].');
                                    } else if (exception === 'parsererror') {
                                        alert(errmsg+'Requested JSON parse failed.');
                                    } else if (exception === 'timeout') {
                                        alert(errmsg+'Time out error.');
                                    } else if (exception === 'abort') {
                                        alert(errmsg+'Ajax request aborted.');
                                    } else {
                                        alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
                                    }
                                }
                            });
                            calendar.getData();
                        }else{
                            alert('error: save!');
                            Unlock(1);
                        }
                    });
                    $('#btnClose_msg').click(function(e){
                        $("#msg").hide();
                    });
                    //-------------------------------------------------------------
                    //Header 星期幾
                    $('#' + this.id).find("table").append("<tr class=\"header\" style=\"height:35px;\"></tr>");
                    for (var i = 0; i < this.dayName.length; i++) {
                        $('#' + this.id).find("table").find("tr").append("<td style=\"width:14%;\">" + this.dayName[i] + "</td>");
                    }
                    //week 周
                    for (var i = 0; i < 6; i++) {
                        $('#' + this.id).find("table").append("<tr class=\"data\" style=\"height:100px;\"></tr>");
                    }
                    //day 日
                    for (var i = 0; i < 6; i++) {
                        for (var j = 0; j < 7; j++)
                            $('#' + this.id).find("table").find("tr.data").eq(i).append("<td id=\"D" + i + "_" + j + "\"></td>");
                    }
                    $('#' + this.id).find("table").find("tr.data").find('td').append('<div class="date" style="float:left;text-align:left;font-weight:bolder;font-size:18px;width:30%;height:20px;"></div>');
                    $('#' + this.id).find("table").find("tr.data").find('td').append('<div class="lunarcalendar" style="float:right;text-align:right;font-size:14px;width:65%;height:20px;"></div>');
                    $('#' + this.id).find("table").find("tr.data").find('td').append('<div class="holiday" style="float:left;width:95%;height:20px;text-align:left;"></div>');
                    $('#' + this.id).find("table").find("tr.data").find('td').append('<div class="memo" style="float:left;width:95%;height:60px;text-align:left;"></div>');
                    $('#' + this.id).find("table").find("tr.data").find("td").bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        if($(this).find('.date').html().length>0){
                            var t_top = $(this).offset().top;
                            var t_left = $(this).offset().left;
                            $("#msg").show().offset({top:t_top,left:t_left});
                            $("#txtDate_msg").html($(this).data("info").date);
                            $("#txtHoliday_msg").val($(this).data("info").holiday);
                            $("#txtMemo_msg").val($(this).data("info").memo);
                            $("#txtColor_msg").attr('value',$(this).data("info").color).change(function(){
                               $(this).addClass('changed');
                            });
                        }
                    });
                    //-------------------------------------------------------------
                    var t_date = new Date();
                    this.year = t_date.getFullYear();
                    this.month = t_date.getMonth() + 1;
                    this.getDays();
                    this.getData();
                }, getDays : function() {
                    var t_date = new Date();
                    t_date.setFullYear(this.year);
                    t_date.setMonth(this.month - 1);
                    t_date.setDate(32);
                    t_date.setDate(0);
                    this.days = t_date.getDate();
                }, next : function() {
                    var t_date = new Date();
                    t_date.setFullYear(this.year, this.month - 1, 32);
                    this.year = t_date.getFullYear();
                    this.month = t_date.getMonth() + 1;
                    t_date.setDate(32);
                    t_date.setDate(0);
                    this.days = t_date.getDate();
                    this.getData();
                }, previous : function() {
                    var t_date = new Date();
                    t_date.setFullYear(this.year, this.month - 1, 0);
                    this.year = t_date.getFullYear();
                    this.month = t_date.getMonth() + 1;
                    this.days = t_date.getDate();
                    this.getData();
                }, getData : function() {
                    var t_year = '000' + (this.year - 1911);
                    t_year = t_year.substring(t_year.length - 3, t_year.length);
                    var t_month = '00' + (this.month);
                    t_month = t_month.substring(t_month.length - 2, t_month.length);
                    t_where = "where=^^ left(noa,6)='" + t_year + "/" + t_month + "'^^";
                    Lock(1, {
                        opacity : 0
                    });
                    q_gt('holiday', t_where, 0, 0, 0, "init");
                }, refresh : function() {
                    $('#lblYear').html(this.year);
                    $('#lblMonth').html(this.month);
                    for (var i = 0; i < 6; i++) {
                        $('#' + this.id).find("table").find("tr.data").eq(i).find("td").unbind("mouseenter").unbind("mouseleave").data('info','');
                        $('#' + this.id).find("table").find("tr.data").eq(i).find("td").find(".date").html("").css('color','black');
                        $('#' + this.id).find("table").find("tr.data").eq(i).find("td").find(".lunarcalendar").html("").css('color','black');
                        $('#' + this.id).find("table").find("tr.data").eq(i).find("td").find(".holiday").html("").css('color','black');
                        $('#' + this.id).find("table").find("tr.data").eq(i).find("td").find(".memo").html("").css('color','black');
                    }
                    var t_date = new Date();
                    
                    t_date.setFullYear(this.year);
                    t_date.setMonth(this.month - 1);
                    t_date.setDate(1);
                    var t_day = t_date.getDay();
                    var t_weekNum = 0;
                    x_year = '000' + (this.year - 1911);
                    x_year = x_year.substring(x_year.length - 3, x_year.length);
                    y_year = '0000' + (this.year);
                    y_year = y_year.substring(y_year.length - 4, y_year.length);
                    x_month = '00' + (this.month);
                    x_month = x_month.substring(x_month.length - 2, x_month.length);

                    for (var i = 0; i < this.days; i++) {
                        x_day = '00' + (i + 1);
                        x_day = x_day.substring(x_day.length - 2, x_day.length);
                        x_date = x_year+'/'+x_month+'/'+x_day;
                        y_date = y_year+'/'+x_month+'/'+x_day;
                        t_color = '#000000';
                        t_holiday = '';
                        t_memo = '';
                        for(var j=0;j<this.data.length;j++){
                            if(this.data[j].date!=undefined && this.data[j].date==x_date){
                                if(this.data[j].holiday!=undefined)
                                    t_holiday = this.data[j].holiday;
                                if(this.data[j].memo!=undefined)
                                    t_memo = this.data[j].memo.replace(/char\(10\)/g,'\n');
                                if(this.data[j].color!=undefined)
                                    t_color = this.data[j].color;
                                break;
                            }
                        }
                        t_lunarmonth = '';
                        t_lunardate = '';
                        for(var j=0;j<this.lunarcalendar.length;j++){
                            //西元年     
                            if(this.lunarcalendar[j].datea!=undefined && this.lunarcalendar[j].datea==y_date){
                                t_lunarmonth = this.lunarcalendar[j].lunarmonth;
                                t_lunardate = this.lunarcalendar[j].lunardate;
                                break;
                            }
                        }
                        if(t_color.length>0){
                            $('#' + this.id).find("table").find("tr.data").eq(t_weekNum).find("td").eq(t_day).find('.date').css('color',t_color);
                            $('#' + this.id).find("table").find("tr.data").eq(t_weekNum).find("td").eq(t_day).find('.holiday').css('color',t_color);
                        }
                        if(t_lunardate==1 || t_lunardate==15)
                            $('#' + this.id).find("table").find("tr.data").eq(t_weekNum).find("td").eq(t_day).find('.lunarcalendar').css('color','red');
                        $('#' + this.id).find("table").find("tr.data").eq(t_weekNum).find("td").eq(t_day).find('.date').html(i+1);
                        if(t_lunardate>0)
                            $('#' + this.id).find("table").find("tr.data").eq(t_weekNum).find("td").eq(t_day).find('.lunarcalendar').html(t_lunarmonth+calendar.cdate[t_lunardate-1]);
                        $('#' + this.id).find("table").find("tr.data").eq(t_weekNum).find("td").eq(t_day).find('.holiday').html(t_holiday);
                        $('#' + this.id).find("table").find("tr.data").eq(t_weekNum).find("td").eq(t_day).find('.memo').html(t_memo.replace(/\n/g,"<br>"));
                        $('#' + this.id).find("table").find("tr.data").eq(t_weekNum).find("td").eq(t_day).bind({
                            mouseenter : function(e) {
                                $(this).css('background-color','#F6D8CE');
                            }, mouseleave : function(e) {
                                $(this).css('background-color','#CED8F6');
                            }
                        }).data('info',{
                            year:this.year,
                            month:this.month,
                            day:i+1,
                            date:x_date,
                            holiday:t_holiday,
                            color:t_color,
                            lunarmonth:t_lunarmonth,
                            lunardate:t_lunardate,
                            memo:t_memo
                        });
                        t_day++;
                        if (t_day >= 7) {
                            t_day = t_day % 7;
                            t_weekNum++;
                        }
                    }
                    
                }
            };
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'init':
                        calendar.data = new Array();
                        var as = _q_appendData("holiday", "", true);
                        if (as[0] != undefined) {
                            for (var i = 0; i < as.length; i++) {
                                if(as[i].memo2!=undefined && as[i].memo2.length>0)
                                    calendar.data.push(JSON.parse(as[i].memo2));
                            }
                        }
                        //西元年
                        x_year = '0000' + (calendar.year);
                        x_year = x_year.substring(x_year.length - 4, x_year.length);
                        x_month = '00' + (calendar.month);
                        x_month = x_month.substring(x_month.length - 2, x_month.length);
                        q_func('qtxt.query.calendar', 'calendar.txt,getlunarcalendar,' + x_year+'/'+x_month);
                        break;
                }
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.calendar':
                        calendar.lunarcalendar = new Array();
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            calendar.lunarcalendar = as.slice(0);
                        }
                        calendar.refresh();
                        Unlock(1);
                        break;
                }
            }
            var calendar = new Calendar();
            $(document).ready(function() {
                calendar.init();
            });
        </script>
        <style type="text/css">
            #calendar{
                font-family: "Times New Roman","標楷體";
            }
            #calendar table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #calendar table tr {
                height: 30px;
            }
            #calendar table tr.header {
                background-color: #E3CEF6;
                color: darkblue;
                font-size:24px;
            }
            #calendar table tr.data {
                background-color: #CED8F6;
                color: black;
            }
            #calendar table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
            } 
            
            #msg{
                width:400px;
                height:250px;
                display:none;
                font-family: "Times New Roman","標楷體";
            }
            #msg table{
                width:100%;
                height:100%;
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #msg tr{
                height: 30px;
                background-color: pink;
                color: black;
            }
            #msg td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
            }           
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <div id="calendar" align="center" style="min-width: 800px;">
            <div style="width:100%;height:50px;">
                <div id="btnPrevious" style="padding-top:10px; font-size: 35px;width:10%;height:100%;background-color:#A9E2F3;float:left;">◄</div>
                <div style="padding-top:10px; font-size: 35px; width:80%;height:100%;color:black;background-color:pink;float:left;"> 
                    <div style="display: block;width:25%;height:100%;float:left;"> </div> 
                    <div align="center" id="lblYear" contenteditable="true" style="display: block;width:20%;height:100%;float:left;"> </div>
                    <div align="center" style="width:5%;height:100%;float:left;">年</div> 
                    <div align="center" id="lblMonth" contenteditable="true" style="width:20%;height:100%;float:left;"> </div>
                    <div align="center" style="width:5%;height:100%;float:left;">月</div> 
                    <div style="width:25%;height:100%;float:left;"> </div> 
                </div>
                <div id="btnNext" style="padding-top:10px; font-size: 35px;width:10%;height:100%;background-color:#A9E2F3;float:right;">►</div>
            </div>
            <div style="width:100%;">
                <table style="width:100%;">

                </table>
            </div>
        </div>
        <div id="msg">
            <table>
                <tr>
                    <td style="width:35%;"><a id="lblDate">日　　期</a></td>
                    <td style="width:65%;"><a id="txtDate_msg"></a></td>
                </tr>
                <tr> 
                    <td><a id="lblHoliday">名　　稱</a></td>
                    <td><input id="txtHoliday_msg" type="text" style="width:98%;"/></td>
                </tr>
                <tr> 
                    <td><a id="lblColor">顏　　色</a></td>
                    <td><input type="color" id="txtColor_msg" style="width:98%;"></td>
                </tr>
                <tr style="height:60px;">
                    <td><a id="lblMemo">備　　註</a></td>
                    <td><textarea id="txtMemo_msg" style="width:98%;" rows=3> </textarea></td>
                </tr>
                <tr>
                    <td align="center"><input type="button" id="btnSave_msg" value="儲存"></td>
                    <td align="center"><input type="button" id="btnClose_msg" value="關閉"></td>
                </tr>
            </table>
        </div>
    </body>
</html>