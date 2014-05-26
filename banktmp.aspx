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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_tables = 's';
            var q_name = "banktmp";
            var q_readonly = ['txtNoa', 'txtBank', 'txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtMoney1', 10, 0, 1], ['txtMoney2', 10, 0, 1], ['txtMoney3', 10, 0, 1], ['txtMoney4', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 5;
            q_desc = 1;
            aPop = new Array();
            $(document).ready(function() {
                //q_bbsShow = -1;
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }
            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
            }
            function mainPost() {
                bbmMask = [['txtDatea', r_picd], ['textBBdate', r_picd], ['textEEdate', r_picd]];
                bbsMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                $('#textBBdate').datepicker();
                $('#textEEdate').datepicker();
                $('#btnUf').click(function(e) {
                    $('#divExport').toggle();
                });
                $('#btnDivexport').click(function(e) {
                    $('#divExport').hide();
                });
                $('#btnExport').click(function(e) {
                    var t_bdate = $('#textBBdate').val();
                    var t_edate = $('#textEEdate').val();
                    if (t_bdate.length > 0 && t_edate.length > 0) {
                        Lock(1, {
                            opacity : 0
                        });
                        q_func('qtxt.query.banktmp', 'banktmp.txt,export,' + encodeURI(t_bdate) + ';' + encodeURI(t_edate) + ';' + encodeURI(r_userno)+ ';' + encodeURI(r_name));
                    } else
                        alert('請輸入兌現日期。');
                });
                $('#textBBdate').keydown(function(e){
                   if(e.which==13)
                        $('#textEEdate').focus();     
                });
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.banktmp':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            if (as[0].errmsg != undefined) {
                                for (var i = 0; i < as.length; i++) {
                                    alert(as[i].errmsg);
                                }
                            } else {
                                var t_array = new Array();
                                for (var i = 0; i < as.length; i++) {
                                    t_array.push({type: 'checkUf',noa:as[i].noa});
                                    q_func('uf_post.post', r_accy + ',' + as[i].noa + ',0');// post 0
                                    q_func('uf_post.post', r_accy + ',' + as[i].noa + ',1');// post 1
                                }
                                //檢查傳票是否產生
                                if(t_array.length>0){
                                    t_noa = t_array.pop().noa;
                                    q_func('qtxt.query.'+JSON.stringify(t_array), 'banktmp.txt,checkuf,' + t_noa );
                                }
                                alert('共兌現 '+as[0].mount+' 筆支票');
                            }
                        } else {
                            alert('無資料!');

                        }
                        Unlock(1);
                        break;
                    default:
                       try{
                           var t_array = JSON.parse(t_func.substring(11,t_func.length));
                           var as = _q_appendData("tmp0", "", true, true);
                           if(as[0]!=undefined && as[0].errmsg!=undefined && as[0].errmsg.length>0){
                               alert(as[0].errmsg);
                               Unlock(1);
                               return;
                           }
                           if(t_array.length>0){
                                t_noa = t_array.pop().noa;
                                q_func('qtxt.query.'+JSON.stringify(t_array), 'banktmp.txt,checkuf,' + t_noa );
                           }
                           else{
                               //check OK!
                               Unlock(1);
                               return;
                           }
                       }catch(e){

                       }
                        break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
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
                    default:
                        break;
                }
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }
            function q_stPost() {
                Unlock(1);
            }
            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else {
                    $('#txtWorker2').val(r_name);
                }
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_banktmp') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('banktmp_s.aspx', q_name + '_s', "600px", "450px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    }
                }
                _bbsAssign();
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }
            function btnPrint() {
                q_box('z_banktmp.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsSave(as) {
                if (!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function refresh(recno) {
                _refresh(recno);
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==1){
                    $('#txtAccount').removeAttr('readonly').css('color','black').css('background','white');    
                    $('#txtBankno').removeAttr('readonly').css('color','black').css('background','white');
                    $('#txtBank').removeAttr('readonly').css('color','black').css('background','white');
                }else{
                    $('#txtAccount').attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');    
                    $('#txtBankno').attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                    $('#txtBank').attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                    $('#btnPlus').attr('disabled','disabled');
                    for(var i=0;i<q_bbsCount;i++){
                        $('#btnMinus_'+i).attr('disabled','disabled');
                        $('#txtAccount_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');        
                        $('#txtDatea_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                        $('#txtMemo_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                        $('#txtMoney1_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                        $('#txtMoney2_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                        $('#txtMoney3_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                        $('#txtMoney4_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                        $('#txtTransbak_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                        $('#txtMemo2_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                        $('#txtTimea_'+i).attr('readonly','readonly').css('color','green').css('background','RGB(237,237,237)');
                    }
                }
            }
            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
                _btnDele();
            }
            function btnCancel() {
                _btnCancel();
            }
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 350px;
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
                width: 600px;
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
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
            .dbbs {
                width: 1300px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
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
        <div id="divExport" style="display:none;position:absolute;top:100px;left:600px;width:400px;height:120px;background:RGB(237,237,237);">
            <table style="border:4px solid gray; width:100%; height: 100%;">
                <tr style="height:1px;background-color: pink;">
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                </tr>
                <tr>
                    <td style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;color: blue;"><a>兌現日期</a></td>
                    <td colspan="3" style="padding: 2px;text-align: center;border-width: 0px;background-color: pink;">
                    <input type="text" id="textBBdate" style="float:left;width:40%;"/>
                    <span style="float:left;width:5%;">~</span>
                    <input type="text" id="textEEdate" style="float:left;width:40%;"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" style="background-color: pink;">
                    <input type="button" id="btnExport" value="匯出"/>
                    </td>
                    <td colspan="2" align="center" style=" background-color: pink;">
                    <input type="button" id="btnDivexport" value="關閉"/>
                    </td>
                </tr>
            </table>
        </div>
        <!--#include file="../inc/toolbar.inc"-->
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:100px; color:black;"><a id="vewDatea"> </a></td>
                        <td align="center" style="width:200px; color:black;"><a id="vewBank"> </a></td>
                    </tr>
                    <tr>
                        <td>
                        <input id="chkBrow.*" type="checkbox"/>
                        </td>
                        <td id="datea" style="text-align: center;">~datea</td>
                        <td id="bank" style="text-align: center;">~bank</td>
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
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td>
                        <input id="txtNoa" type="text" class="txt c1"/>
                        </td>
                        <td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                        <td>
                        <input id="txtDatea" type="text"  class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblBank" class="lbl"> </a></td>
                        <td colspan="3">
                        <input id="txtBankno" type="text" style="float:left;width:40%;"/>
                        <input id="txtBank" type="text" style="float:left;width:60%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAccount" class="lbl"> </a></td>
                        <td colspan="3">
                        <input id="txtAccount" type="text" class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl"> </a></td>
                        <td colspan="3">
                        <input id="txtMemo" type="text" class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker" class="lbl"> </a></td>
                        <td>
                        <input id="txtWorker" type="text" class="txt c1"/>
                        </td>
                        <td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
                        <td>
                        <input id="txtWorker2" type="text"  class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                        <input id="btnUf" type="button" value="兌現"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs' style=' text-align:center'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"></td>
                    <td align="center" style="width:200px;"><a id="lblAccounts"> </a></td>
                    <td align="center" style="width:100px;"><a id="lblDateas"> </a></td>
                    <td align="center" style="width:100px;"><a id="lblMemos"> </a></td>
                    <td align="center" style="width:120px;"><a id="lblMoney1s"> </a></td>
                    <td align="center" style="width:120px;"><a id="lblMoney2s"> </a></td>
                    <td align="center" style="width:120px;"><a id="lblMoney3s"> </a></td>
                    <td align="center" style="width:120px;"><a id="lblMoney4s"> </a></td>
                    <td align="center" style="width:90px;"><a id="lblTransbanks"> </a></td>
                    <td align="center" style="width:100px;"><a id="lblMemo2s"> </a></td>
                    <td align="center" style="width:150px;"><a id="lblChecknos"> </a></td>
                    <td align="center" style="width:100px;"><a id="lblTimeas"> </a></td>
                </tr>
                <tr  style='background:#cad3ff;'>
                    <td align="center">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>

                    <td>
                    <input type="text" id="txtAccount.*" style="width:95%;" />
                    </td>
                    <td>
                    <input type="text" id="txtDatea.*" style="width:95%;" />
                    </td>
                    <td>
                    <input type="text" id="txtMemo.*" style="width:95%;" />
                    </td>
                    <td>
                    <input type="text" id="txtMoney1.*" style="width:95%;text-align: right;" />
                    </td>
                    <td>
                    <input type="text" id="txtMoney2.*" style="width:95%;text-align: right;" />
                    </td>
                    <td>
                    <input type="text" id="txtMoney3.*" style="width:95%;text-align: right;" />
                    </td>
                    <td>
                    <input type="text" id="txtMoney4.*" style="width:95%;text-align: right;" />
                    </td>
                    <td>
                    <input type="text" id="txtTransbank.*" style="width:95%;" />
                    </td>
                    <td>
                    <input type="text" id="txtMemo2.*" style="width:95%;" />
                    </td>
                    <td>
                    <input type="text" id="txtCheckno.*" style="width:95%;" />
                    </td>
                    <td>
                    <input type="text" id="txtTimea.*" style="width:95%;" />
                    </td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>