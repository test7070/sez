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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
            this.errorHandler = null;

            q_tables = 't';
            var q_name = "orda";
            var q_readonly = ['txtNoa','txtDatea','txtWorker', 'txtWorker2', 'txtWorkgno','txtOrdbno'];
            var q_readonlys = ['txtNoq','txtProductno','txtProduct','txtSpec','txtUnit','txtGmount','txtWmount','txtStkmount','txtSchmount','txtSafemount','txtNetmount','txtFdate','txtFmount','txtMemo'];
            var q_readonlyt = ['txtNo2','txtNoq','txtNamea','txtMemo','chkIsapv','txtDatea'];
            var bbmNum = [];
            var bbsNum = [['txtApvmount', 15, 2, 1],['txtGmount', 15, 2, 1],['txtStkmount', 15, 2, 1],['txtSchmount', 15, 2, 1],['txtSafemount', 15, 2, 1],
                                    ['txtNetmount', 15, 2, 1],['txtFmount', 15, 2, 1],['txtMount', 15, 2, 1],['txtWmount', 15, 2, 1]];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //q_xchg = 1;
            brwCount2 = 5;

            aPop = new Array(['txtProductno_', '', 'ucaucc', 'noa,product,unit,spec', 'txtProductno_,txtProduct_,txtUnit_,txtSpec_', 'ucaucc_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'no2'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                bbsMask = [['txtFdate', r_picd]];
                
                $('#lblWorkgno').click(function() {
                    if(!emp($('#txtWorkgno').val()))
                    q_box("workg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'" + $('#txtWorkgno').val() + "')>0;" + r_accy + ";" + q_cur, 'workg', "95%", "95%", q_getMsg('popWorkg'));
                });
                
                $('#lblOrdbno').click(function() {
                    if(!emp($('#txtOrdbno').val()))
                    q_box("ordb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'" + $('#txtOrdbno').val() + "')>0;" + r_accy + ";" + q_cur, 'ordb', "95%", "95%", q_getMsg('popOrdb'));
                });
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                    break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                refresh(q_recno);    
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('orda_s.aspx', q_name + '_s', "520px", "520px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }
            function btnPrint() {
                q_box('z_ordap.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }
            function btnOk() {
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }               
                //BBS不存在,刪除BBT
                for(var j=0;j<q_bbtCount;j++){
                    t_noq = $('#txtNoq__'+j).val();
                    t_namea = $('#txtNamea__'+j).val();
                    t_isexist = false;
                    for(var i=0;i<q_bbsCount;i++){
                        if(t_noq==$('#txtNoq_'+i).val()){
                            t_isexist = true;
                            break;
                        }
                    }
                    if(!t_isexist){
                        $('#txtNo2__'+j).val('');
                        $('#txtNoq__'+j).val('');
                        $('#txtNamea__'+j).val('');
                        $('#chkIsapv__'+j).prop('checked',false);
                        $('#txtMemo__'+j).val('');
                        $('#txtDatea__'+j).val('');
                       // $('#btnMinut__'+j).click();
                    }
                }
                
                //BBS補上noq
                t_noq = '000';
                for(var i=0;i<q_bbsCount;i++){
                    if(t_noq<$('#txtNoq_'+i).val())
                        t_noq = $('#txtNoq_'+i).val();
                }
                for(var i=0;i<q_bbsCount;i++){
                    if($('#txtNoq_'+i).val().length==0 && $('#txtProductno_'+i).val().length>0){
                        t_noq = parseInt(t_noq)+1;
                        t_noq = '000'+t_noq;
                        t_noq = t_noq.substring(t_noq.length-3,t_noq.length);
                        $('#txtNoq_'+i).val(t_noq);
                    }
                }
                //BBS寫入BBT
                t_hour = '00'+(new Date()).getHours();
                t_hour = t_hour.substring(t_hour.length-2,t_hour.length);
                t_minute = '00'+(new Date()).getMinutes();
                t_minute = t_minute.substring(t_minute.length-2,t_minute.length);
                t_second = '00'+(new Date()).getSeconds();
                t_second = t_second.substring(t_second.length-2,t_second.length);
                t_date = q_date()+' '+t_hour+':'+t_minute+':'+t_second;
                for(var i=0;i<q_bbsCount;i++){
                    t_noq = $('#txtNoq_'+i).val();
                    //t_isapv = $('#chekIsapv_'+i).prop('checked');
                    //t_memo = $('#textMemo_'+i).val();
                    t_isapv = $('#chkApv_'+i).prop('checked');
                    t_memo = $('#txtApvmemo_'+i).val();
                    t_isexist = false;
                    
                    t_lastapv = false;
                    t_lastmemo = '';
                    t_lastdate = '';                
                    for(var j=0;j<q_bbtCount;j++){
                        if(t_noq == $('#txtNoq__'+j).val() && r_name==$('#txtNamea__'+j).val() && t_lastdate<$('#txtDatea__'+j).val()){
                            t_lastapv = $('#chkIsapv__'+j).prop('checked');
                            t_lastmemo = $('#txtMemo__'+j).val();
                        }
                    }
                    if(!t_isexist && t_noq.length>0 && (t_isapv!=t_lastapv || t_memo!=t_lastmemo)){
                        for(var j=0;j<q_bbtCount;j++){
                            if($('#txtNoq__'+j).val().length==0){
                                $('#txtNo2__'+j).val(t_noq+t_date+r_name);
                                $('#txtNoq__'+j).val(t_noq);
                                $('#txtNamea__'+j).val(r_name);
                                $('#chkIsapv__'+j).prop('checked',t_isapv);
                                $('#txtMemo__'+j).val(t_memo);
                                $('#txtDatea__'+j).val(t_date);
                                t_isexist = true;
                                break;
                            }
                        }
                    }
                    //BBT不夠
                    if(!t_isexist && t_noq.length>0 && (t_isapv!=t_lastapv || t_memo!=t_lastmemo)){                    
                        $('#btnPlut').click();
                        for(var j=0;j<q_bbtCount;j++){
                            if($('#txtNoq__'+j).val().length==0){
                                $('#txtNo2__'+j).val(t_noq+t_date+r_name);
                                $('#txtNoq__'+j).val(t_noq);
                                $('#txtNamea__'+j).val(r_name);
                                $('#chkIsapv__'+j).prop('checked',t_isapv);
                                $('#txtMemo__'+j).val(t_memo);
                                $('#txtDatea__'+j).val(t_date);
                                t_isexist = true;
                                break;
                            }
                        }
                    }              
                }
                sum();
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }   
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orda') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function bbtSave(as) {
                /*if (!as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }*/
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                if (q_cur > 0 && q_cur < 4)
                    sum();
                $('#dbbt').hide();
                //BBT 寫入BBS
                for(var i=0;i<q_bbsCount;i++){
                    t_noq = $('#txtNoq_'+i).val();
                    t_isapv = false;
                    t_memo = '';
                    for(var j=0;j<q_bbtCount;j++){
                        if(t_noq==$('#txtNoq__'+j).val() && r_name == $('#txtNamea__'+j).val()){
                            t_isapv = $('#chkIsapv__'+j).prop('checked');
                            t_memo = $('#txtMemo__'+j).val();
                            break;
                        }
                    }    
                    $('#chekIsapv_'+i).prop('checked',t_isapv);
                    $('#textMemo_'+i).val(t_memo);
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                for(var i=0;i<q_bbsCount;i++){
                    if(q_cur==1 || q_cur==2)
                        $('#chekIsapv_'+i).removeAttr('disabled');
                    else
                        $('#chekIsapv_'+i).attr('disabled','disabled');
                }
                for(var i=0;i<q_bbtCount;i++){
                        $('#chkIsapv__'+i).attr('disabled','disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $('#btnHistory_'+i).bind("click",function(e){
                            var top = $(this).offset().top + $(this).height();
                            var left = $(this).offset().left;
                            var n = $(this).attr('id').replace('btnHistory_','');
                            t_noq = $('#txtNoq_'+n).val();
                            $('#tbbt').find('tr').css('display','none');
                            var m = 0;
                            for(var i=0;i<q_bbtCount;i++){
                                if($('#txtNoq__'+i).val()==t_noq){
                                    $('#txtNoq__'+i).parent().parent().css('display','');
                                    $('#lblNo__' + i).text(++m);
                                }
                            }
                            if(m>0){
                                $('#tbbt').find('tr').eq(0).css('display','');
                                $('#dbbt').show().offset({top:top+5,left:left});
                            }
                        });
                    }
                }
                _bbsAssign();
            }

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    //$('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    }
                }
                _bbtAssign();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;             
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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            function q_popPost(id) {
                switch (id) {
                    default:
                        break;
                }
            }
            
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 300px;
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
                width: 650px;
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
                width: 9%;
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
                font-size: medium;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 70%;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows{
                display:none;
                width:20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain'>
            <div class="dview" id="dview" >
                <table class="tview" id="tview" >
                    <tr>
                        <td style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:35%"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:60%"><a id='vewNoa'> </a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" style=''/></td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='noa'>~noa</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm"  id="tbbm">
                    <tr style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblNoa' class="lbl"> </a></td>
                        <td><input id="txtNoa" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblDatea' class="lbl"> </a></td>
                        <td><input id="txtDatea" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorkgno' class="lbl btn"> </a></td>
                        <td><input id="txtWorkgno" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblOrdbno' class="lbl btn"> </a></td>
                        <td><input id="txtOrdbno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblWorker' class="lbl"> </a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                        <td><input id="txtWorker2" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id='lblMemo' class='lbl'> </a></td>
                        <td colspan='3'><input id="txtMemo" type="text" class="txt c1"/></td>
                    </tr>
                </table>
            </div>
            <div class='dbbs'>
                <table id="tbbs" class='tbbs'>
                    <tr style='color:white; background:#003366;' >
                        <td style="width:20px;">
                        <input id="btnPlus" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="＋"/>
                        </td>
                        <td style="width:20px;"> </td>
                        <td align="center" style="width:50px;"><a id='lblIsapv_s'>核准</a></td>
                        <td align="center" style="width:100px;"><a id='lblMemo2_s'>簽核意見</a></td>
                        <td align="center" style="width:100px;"><a >異動數量</a></td>
                        <td align="center" style="width:100px;"></td>
                        <td align="center" style="width:160px;"><a id='lblProductno_s'> </a></td>
                        <td align="center" style="width:200px;"><a id='lblProduct_s'> </a>/<a id='lblSpec_s'> </a></td>
                        <td align="center" style="width:55px;"><a id='lblUnit_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblGmount_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblWmount_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblStkmount_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblSchmount_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblSafemount_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblNetmount_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblFdate_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblFmount_s'> </a></td>
                        <td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
                        
                    </tr>
                    <tr style='background:#cad3ff;'>
                        <td align="center">
                        <input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold; width:90%;" value="－"/>
                        <input id="txtNoq.*" type="text" style="display: none;"/>
                        </td>
                        <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                        <td align="center">
                            <input class="txt" id="chkApv.*" type="checkbox"/>
                            <input class="txt" id="chekIsapv.*" type="checkbox" style="display:none;"/>
                        </td>
                        <td><input class="txt c1" id="txtApvmemo.*" type="text" />
                            <input class="txt c1" id="textMemo.*" type="text" style="display:none;"/>
                        </td>
                        <td><input class="txt num c1" id="txtApvmount.*" type="text" /></td>
                        <td>
                            <input class="txt" id="btnHistory.*" type="button" value="歷史記錄" style="float:left;"/>
                        </td>
                        <td>
                            <input class="txt c1" id="txtProductno.*" type="text" />
                        </td>
                        <td>
                            <input class="txt c1" id="txtProduct.*" type="text" />
                            <input class="txt c1" id="txtSpec.*" type="text" />
                        </td>
                        <td align="center"><input class="txt c1" id="txtUnit.*" type="text"/></td>
                        <td><input class="txt num c1" id="txtGmount.*" type="text" /></td>
                        <td><input class="txt num c1" id="txtWmount.*" type="text" /></td>
                        <td><input class="txt num c1" id="txtStkmount.*" type="text" /></td>
                        <td><input class="txt num c1" id="txtSchmount.*" type="text" /></td>
                        <td><input class="txt num c1" id="txtSafemount.*" type="text" /></td>
                        <td><input class="txt num c1" id="txtNetmount.*" type="text" /></td>
                        <td><input class="txt c1" id="txtFdate.*" type="text" /></td>
                        <td><input class="txt num c1" id="txtFmount.*" type="text" /></td>
                        <td><input class="txt c1" id="txtMemo.*" type="text" /></td>
                    </tr>
                </table>
            </div>
        </div>
        <input id="q_sys" type="hidden" />
        <div id="dbbt" style="position: absolute;display:none;">
            <table id="tbbt" >
                <tbody>
                    <tr class="head" style="color:white; background:#003366;">
                        <td style="width:20px;">
                            <input id="btnBbtclose" type="button" style="color:red;" value="X" onclick="$('#dbbt').hide();"/>
                            <input id="btnPlut" type="button" style="display:none;font-size: medium; font-weight: bold;" value="＋"/>
                        </td>
                        <td style="width:100px; text-align: center;">姓名</td>
                        <td style="width:100px; text-align: center;">核准</td>
                        <td style="width:400px; text-align: center;">簽核意見</td>
                        <td style="width:200px; text-align: center;">修改日期</td>
                    </tr>
                    <tr style="display:none;">
                        <td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a>
                            <input id="btnMinut..*"  type="button" style="display:none;font-size: medium; font-weight: bold;" value="－"/>
                            <input id="txtNo2..*" type="text" style="display:none;"/>
                            <input id="txtNoq..*" type="text" style="display:none;"/>
                        </td>
                        <td><input id="txtNamea..*" type="text" style="width:95%;"/></td>
                        <td><input id="chkIsapv..*" type="checkbox" style="width:95%;"/></td>
                        <td><input id="txtMemo..*" type="text" style="width:95%;"/></td>
                        <td><input id="txtDatea..*" type="text" style="width:95%;"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>