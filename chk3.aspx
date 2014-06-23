<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_desc=1;
            q_tables = 's';
            var q_name = "chk3";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney','txtTotal','txtAccno'];
            var q_readonlys = ['txtCheckno'];
            var bbmNum = [['txtMoney', 10, 0, 1]];
            var bbsNum = [['txtMoney', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [['txtDatea', '999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            brwCount2 = 6;

            aPop = new Array(['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx']
            , ['txtTcompno_', 'btnTcomp_', 'tgg', 'noa,comp', 'txtTcompno_,txtTcomp_', 'Tgg_b.aspx']
            , ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtTdate', r_picd]];
                q_mask(bbmMask);

                $('#btnGqb').click(function() {
                    t_where = "where=^^(len(isnull(a.usage,''))=0 and isnull(a.enda,'')!='Y' and a.typea='1' and isnull(b.sel,0)=0) or (c.noa is not null and c.noa='"+$.trim($('#txtNoa').val())+"') ^^";
                    Lock();
                    q_gt('chk3_gqb', t_where, 0, 0, 0, "", r_accy);
                });
                $('#lblAccno').click(function() {
                    var t_accy = $('#txtNoa').val().replace(/^[A-Z]*([0-9]{3})[0-9]*$/, '$1');
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtTdate').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
                $('#txtInte').change(function(e){
                   sum(); 
                });
            }
            function browGqb(obj){
                var noa = $.trim($(obj).val());
                if(noa.length>0)
                    q_box("gqb.aspx?;;;gqbno='" + noa + "';"+r_accy, 'gqb', "95%", "95%", q_getMsg("popGqb"));
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

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'chk3_gqb':
                        var as = _q_appendData("gqb", "", true);
                        q_gridAddRow(bbsHtm, 'tbbs', 'chkSel,txtCheckno,txtBank,txtBankno,txtAccount,txtDatea,txtMoney,txtComp', as.length, as, 'sel,gqbno,bank,bankno,account,indate,money,comp', '');
                        Unlock();
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
                sum();
                if ($('#txtDatea').val().length = 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if (emp($('#txtBankno').val())) {
                    alert(q_getMsg('lblBank') + '未輸入。');
                    return;
                }
                if(q_cur==1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_chk3') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('chk3_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $('#chkSel_' + i).click(function() {
                            sum();
                        }).hover(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            $('#trSel_' + b_seq).addClass('sel');
                        }, function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            $('#trSel_' + b_seq).removeClass('sel');
 
                            if ($('#chkSel_' +b_seq).prop('checked')) {//判斷是否被選取
                                $('#trSel_' + b_seq).addClass('chksel');
                                //變色
                            } else {
                                $('#trSel_' + b_seq).removeClass('chksel');
                                //取消變色
                            }
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('#txtMoney').val(0);

                //取消變色
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#trSel_' + i).removeClass('chksel');
                }

            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
               if (q_chkClose())
                        return;
                _btnModi();
                $('#txtProduct').focus();

            }

            function btnPrint() {
                q_box('z_chk3.aspx'+ "?;;;;" + r_accy+ ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (as['sel']!='true') {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
                var t_money = 0, t_inte = 0;
                var t_date = $('#txtDatea').val(),x_date='';
                var t_rate = $('#txtRate').val();
                if(t_date.length>0)
                    t_date = new Date((parseInt(t_date.substring(0,3))+1911)+t_date.substring(3,9));
                for (var i = 0; i < q_bbsCount; i++) {
                    if ($('#chkSel_' + i).prop('checked')) {
                        t_money += q_float('txtMoney_' + i);
                        x_date = $.trim($('#txtDatea_'+ i).val());
                        if( (x_date+'').length>0 && q_cd(x_date) && (t_date+'').length>0){
                            x_date = new Date((parseInt(x_date.substring(0,3))+1911)+x_date.substring(3,9)); 
                            t_days = (x_date.getTime()-t_date.getTime())/1000/60/60/24;  
                            t_inte += round(q_mul(q_div(q_div(q_mul(t_days,t_rate),100),365),q_float('txtMoney_'+i)),0);
                            alert(t_days);
                        }
                    }
                }
                $('#txtMoney').val(t_money);
                $('#txtInte').val(t_inte);
                $('#txtTotal').val(t_money-t_inte);
            }
            function q_stPost() {
                if (q_cur == 1 || q_cur == 2) {
                    abbm[q_recno]['accno'] = xmlString;
                    /// 存檔後， server 傳回 xmlString
                    $('#txtAccno').val(xmlString);
                    /// 顯示 server 端，產生之傳票號碼
                }
                Unlock();
            }
            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
                
                for (var j = 0; j < q_bbsCount; j++) {
                    if ($('#chkSel_' + j ).prop('checked')) {//判斷是否被選取
                        $('#trSel_' + j).addClass('chksel');
                        //變色
                    } else {
                        $('#trSel_' + j).removeClass('chksel');
                        //取消變色
                    }
                }

            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
                /// 表身運算式
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
                 if (q_chkClose())
                        return;
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
                width: 200px;
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
                width: 750px;
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
                width: 15%;
            }
            .tbbm .tdZ {
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
                width: 950px;
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
            tr.sel td {
                background-color: yellow;
            }
            tr.chksel td {
                background-color: bisque;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id='vewTotal'> </a></td>
                    </tr>
                    <tr>
                        <td>
                        <input id="chkBrow.*" type="checkbox" style=''/>
                        </td>
                        <td align="center" id='datea'>~datea</td>
                        <td id='total,0,1' style="text-align: right;" >~total,0,1</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm"  id="tbbm">
                    <tr class="tr0" style="height:1px;">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl" > </a></td>
                        <td><input id="txtNoa"type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                        <td><input id="txtDatea"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblRate" class="lbl">貼現率％</a></td>
                        <td><input id="txtRate"  type="text" class="txt num c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblBank" class="lbl btn" > </a></td>
                        <td colspan="2">
                        <input id="txtBankno" type="text" style="float:left; width:40%;"/>
                        <input id="txtBank"  type="text" style="float:left; width:60%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMoney" class="lbl"> </a></td>
                        <td><input id="txtMoney"  type="text" class="txt num c1" /></td>
                        <td><span> </span><a id="lblInte" class="lbl"> </a></td>
                        <td><input id="txtInte"  type="text" class="txt num c1" /></td>
                        <td><span> </span><a id="lblTotal" class="lbl"> </a></td>
                        <td><input id="txtTotal"  type="text" class="txt num c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAcc1"  class="lbl btn"> </a></td>
                        <td><input id="txtAcc1"  type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblTdate"  class="lbl"> </a></td>
                        <td><input id="txtTdate"  type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblAccno"  class="lbl btn"> </a></td>
                        <td><input id="txtAccno"  type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker" class="lbl" > </a></td>
                        <td><input id="txtWorker"  type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
                        <td><input id="txtWorker2"  type="text" class="txt c1" /></td>
                        <td></td>
                        <td><input type="button" id="btnGqb" class="txt c1" value="票據匯入"></td>
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
                    <td align="center" style="width:20px;"><a id='vewChks'> </a></td>
                    <td align="center" style="width:100px;">票據號碼</td>
                    <td align="center" style="width:100px;">銀行名稱</td>
                    <td align="center" style="width:80px;">金融代號</td>
                    <td align="center" style="width:80px;">抬頭</td>
                    <td align="center" style="width:80px;">帳號</td>
                    <td align="center" style="width:80px;">到期日</td>
                    <td align="center" style="width:80px;">金額</td>
                    <td align="center" style="width:80px;">客戶</td>
                </tr>
                <tr id="trSel.*" style='background:#cad3ff;'>
                    <td style="width:1%;">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td><input id="chkSel.*" type="checkbox"/></td>
                    <td><input id="txtCheckno.*" type="text"  style="width: 95%"/></td>
                    <td><input id="txtBank.*" type="text" style="width: 95%;"/></td>
                    <td><input id="txtBankno.*" type="text"  style="width: 95%"/></td>
                    <td><input id="txtTcomp.*" type="text"  style="width: 95%"/></td>
                    <td><input id="txtAccount.*" type="text"  style="width: 95%"/></td>
                    <td><input id="txtDatea.*" type="text"  style="width: 95%"/></td>
                    <td><input id="txtMoney.*" type="text" class="txt num" style="width: 95%"/></td>
                    <td><input id="txtComp.*" type="text"  style="width: 95%"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
