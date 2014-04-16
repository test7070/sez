<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            var t_carkind = null;
            var t_carteam = null;
            var t_calctypes = null;
            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'z_cart');
            });
            function q_gfPost() {
                $('#q_report').q_report({
                    fileName : 'z_cart',
                    options : [{/*1-[1],[2]-登錄日期*/
                        type : '1',
                        name : 'xmon'
                    }, {/*2-[3]-車牌*/
                        type : '6',
                        name : 'xcarno'
                    }]
                });
                q_popAssign();
                q_langShow();

                $('#txtXdate1').mask('999/99');
                $('#txtXdate2').mask('999/99');
            }

            function q_boxClose(t_name) {
            }

            function LoadFinish() {
                

                $('#txtXcheckrate').val(q_getMsg('trate1'));
                $('#chkXcarkind').children('input').attr('checked', 'checked');
                $('#chkXcarteam').children('input').attr('checked', 'checked');
                $('#chkXcalctype').children('input').attr('checked', 'checked');
                
                $('#txtXmon1').mask('999/99');
                $('#txtXmon2').mask('999/99');
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
                $('#btnOk').hide();
                $('#btnOk2').click(function(e) {
                    switch($('#q_report').data('info').radioIndex) {
                        case 0:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 1:
                            $('#cmbPaperSize').val('A3');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 2:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 3:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',true);
                            break;
                        case 4:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 5:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 6:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                        case 7:
                            $('#cmbPaperSize').val('A4');
                            $('#chkLandScape').prop('checked',false);
                            break;
                    }
                    $('#btnOk').click();
                });
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
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
            <div id="container">
                <div id="q_report"></div>
            </div>
            <div class="prt" style="margin-left: -40px;">
                <!--#include file="../inc/print_ctrl.inc"-->
            </div>
        </div>
    </body>
</html>