<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"> </script>
        <script src="css/jquery/ui/jquery.ui.widget.js"> </script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
        <script type="text/javascript">
            var q_name = "banktmp_s";
            $(document).ready(function() {
                main();
            });

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
                $('#txtNoa').focus();
            }

            function q_seekStr() {
                t_noa = $.trim($('#txtNoa').val());
                t_datea = $.trim($('#txtDatea').val());
                t_memo = $.trim($('#txtMemo').val());
                t_memo2 = $.trim($('#txtMemo2').val());
                t_checkno = $.trim($('#txtCheckno').val());
                t_money1 = $.trim($('#txtMoney1').val());
                t_money2 = $.trim($('#txtMoney2').val());
                
                try{
                    t_money1 = parseFloat(t_money1);
                }catch(e){
                    $('#txtMoney1').val(0);
                    t_money1 = 0;
                }
                try{
                    t_money2 = parseFloat(t_money2);
                }catch(e){
                    $('#txtMoney2').val(0);
                    t_money2 = 0;
                }
                
                var t_where = " 1=1 " 
                + q_sqlPara2("noa", t_noa);
                if(t_datea.length>0)
                    t_where += " and exists(select noa from banktmps where banktmps.noa=banktmp.noa and banktmps.datea='"+t_datea+"')";
                if(t_memo.length>0)
                    t_where += " and exists(select noa from banktmps where banktmps.noa=banktmp.noa and charindex('"+t_memo+"',banktmps.memo)>0)";
                if(t_memo2.length>0)
                    t_where += " and exists(select noa from banktmps where banktmps.noa=banktmp.noa and charindex('"+t_memo2+"',banktmps.memo2)>0)";
                if(t_checkno.length>0)
                    t_where += " and exists(select noa from banktmps where banktmps.noa=banktmp.noa and banktmps.checkno='"+t_checkno+"')";
                if(t_money1!=0 && !isNaN(t_money1))
                    t_where += " and exists(select noa from banktmps where banktmps.noa=banktmp.noa and banktmps.money1="+t_money1+")";
                if(t_money2!=0 && !isNaN(t_money2))
                    t_where += " and exists(select noa from banktmps where banktmps.noa=banktmp.noa and banktmps.money2="+t_money2+")";
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
        </script>
        <style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <div style='width:400px; text-align:center;padding:15px;' >
            <table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                    <td>
                    <input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblDatea'></a></td>
                    <td>
                    <input class="txt" id="txtDatea" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblMemo'></a></td>
                    <td>
                    <input class="txt" id="txtMemo" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblMoney1'></a></td>
                    <td>
                    <input class="txt" id="txtMoney1" type="text" style="width:215px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblMoney2'></a></td>
                    <td>
                    <input class="txt" id="txtMoney2" type="text" style="width:215px; font-size:medium;text-align: right;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblMemo2'></a></td>
                    <td>
                    <input class="txt" id="txtMemo2" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblCheckno'></a></td>
                    <td>
                    <input class="txt" id="txtCheckno" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
            </table>
            <!--#include file="../inc/seek_ctrl.inc"-->
        </div>
    </body>
</html>