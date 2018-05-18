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
            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;"+((new Date()).getUTCFullYear()-1911);
            }
            $(document).ready(function() {
                q_getId();
                q_gf('', 'z_banks');   
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_banks',
                    options : [{
                        type : '1',
                        name : 'date'
                    }, {
                        type : '2',
                        name : 'acc',
                        dbf : 'acc',
                        index : 'acc1,acc2',
                        src :  "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno
                    }, {
                        type : '8',
                        name : 'xoption01',
                        value : q_getMsg('toption01').split('&')
                    },{/*  [6]*/
                        type : '0',
                        name : 'accy',
                        value : r_accy + "_" + r_cno
                    }, {/*  [7]*/
                        type : '0',
                        name : 'xlen',
                        value : r_len
                    }]
                });
                
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                var r_1911=1911;
				if(r_len==4){//西元年
					r_1911=0;
				}
                
                $('#txtAcc1a').change(function(e) {
                    var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
                });
                $('#txtAcc2a').change(function(e) {
                    var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
                });

                $('#txtDate1').mask(r_picd);
                $('#txtDate2').mask(r_picd);
                 var t_date,t_year,t_month,t_day;
                    t_date = new Date();
                    t_date.setDate(1);
                    t_year = t_date.getUTCFullYear()-r_1911;
                    t_year = t_year>99?t_year+'':'0'+t_year;
                    t_month = t_date.getUTCMonth()+1;
                    t_month = t_month>9?t_month+'':'0'+t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day>9?t_day+'':'0'+t_day;
                    $('#txtDate1').val(t_year+'/'+t_month+'/'+t_day);
                    
                    t_date = new Date();
                    t_date.setDate(35);
                    t_date.setDate(0);
                    t_year = t_date.getUTCFullYear()-r_1911;
                    t_year = t_year>99?t_year+'':'0'+t_year;
                    t_month = t_date.getUTCMonth()+1;
                    t_month = t_month>9?t_month+'':'0'+t_month;
                    t_day = t_date.getUTCDate();
                    t_day = t_day>9?t_day+'':'0'+t_day;
                    $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
            }
        </script>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
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