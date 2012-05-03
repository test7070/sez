<%@ Page Language="C#" AutoEventWireup="true" %>
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
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        var decbbm = ['taxrate','start','startn','credit'];
        var q_name = "tgg";
        var q_readonly = [];
        var bbmNum = [];  // 允許 key 小數
        var bbmMask = []; //  [['txtUacc1', '9999.99999999'], ['txtUacc2', '9999.99999999'], ['txtUacc3', '9999.99999999']];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		 aPop = new Array(['txtConn', 'btnConn', 'conn', 'namea', 'txtConn', 'conn_b.aspx'],['txtSalesno', 'btnSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],['txtGrpno', 'btnTgg', 'tgg', 'noa,comp', 'txtGrpno,txtGrpname', 'tgg_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();  // 計算 合適  brwCount 
            //alert( $('#a1').text());
           q_gt(q_name, q_content, q_sqlCount, 1) /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
            $('#txtNoa').focus
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  /// 載入資料錯誤
            {
                dataErr = false;
                return;
            }

            q_mask(bbmMask);

            mainForm(0); // 1=最後一筆  0=第一筆

            $('#txtNoa').focus();

        }  ///  end Main()


        function mainPost() { // 載入資料完，未 refresh 前
           q_cmbParse("combPay", q_getPara('tgg.pay'));  // comb 未連結資料庫
           q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
		   q_cmbParse("cmbTypea", q_getPara('tgg.typea'));
           /* $('#btnSales').click(function () { pop('sss'); });
            $('#btnSalesno').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtSalesno").change(function () { q_change($(this), 'sss', 'noa', 'noa,namea'); });

            $('#btnTgg').click(function () { pop('tgg'); });
            $('#btnTgg').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtGrpno").change(function () {
                q_change($(this), 'tgg', 'noa', 'noa,comp');
            });

            $('#btnConn').click(function () { pop('conn') });
            $('#btnConn').mouseenter(function () { $(this).css('cursor', 'pointer') });

            $("#txtComp").change(function () { $("#txtNick").val($("#txtComp").val().substr(0, 2)); });*/

            txtCopy('txtZip_comp,txtAddr_comp', 'txtZip_fact,txtAddr_fact');
            txtCopy('txtZip_invo,txtAddr_invo', 'txtZip_comp,txtAddr_comp');
            txtCopy('txtZip_home,txtAddr_home', 'txtZip_invo,txtAddr_invo');
            fbbm[fbbm.length] = 'txtMemo';  ///  textArea 需手動加入 fbbm
        }

       /* function pop(form, seq) {
            b_seq = (seq ? seq : '');
            b_pop = form;
            switch (form) {
                case 'sss': q_pop('txtSalesno', 'sss_b.aspx', 'sss', 'noa', 'namea', "60%", "650px", q_getMsg('popSss')); break;
                case 'tgg': q_pop('txtGrpno', 'tgg_b.aspx', 'tgg', 'noa', 'comp', "60%", "650px", q_getMsg('popTgg')); break;
                case 'conn': q_pop('txtNoa', "conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';;" + q_cur, 'conn', 'noa', 'namea', "60%", "650px", q_getMsg('popConn')); break;
            }
        }*/

        function txtCopy(dest, source) {
            var adest = dest.split(',');
            var asource = source.split(',');
            $('#' + adest[0]).focus(function () { if (trim($(this).val()).length == 0) $(this).val(q_getMsg('msgCopy')); });
            $('#' + adest[0]).focusout(function () {
                var t_copy = ($(this).val().substr(0, 1) == '=');
                var t_clear = ($(this).val().substr(0, 2) == ' =');
                for (var i = 0; i < adest.length; i++) {
                    {
                        if (t_copy)
                            $('#' + adest[i]).val($('#' + asource[i]).val());

                        if (t_clear)
                            $('#' + adest[i]).val('');
                    }
                }
            });
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 /// 查詢視窗、廠商視窗、訂單視窗  關閉時執行
            var ret;
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                    break;

                case 'tgg':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtGrpno,txtGrpname', ret, 'noa,comp');
                    break;

                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
                case 'sss':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtSalesno,txtSales', 'noa,namea');
                    break;

                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();

                    if (q_cur == 1 || q_cur == 2) // 集團
                        q_changeFill(t_name, 'txtGrpno,txtGrpname', 'noa,comp');

                    break;
            }  /// end switch
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('tgg_s.aspx', q_name + '_s', "500px", "310px",q_getMsg( "popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
            var cmb = document.getElementById("combPay")
            if (!q_cur)
                cmb.value = '';
            else
                $('#txtPay').val(cmb.value);
            cmb.value = '';
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;

            _btnModi();
            $('#txtComp').focus();
        }

        function btnPrint() {

        }
        function btnOk() {
            var t_err = '';

            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')], ['txtCredit', q_getMsg('msgCreditErr'), 1]]);


            if (dec($('#txtCredit').val()) > 9999999999)
                t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

            if (dec($('#txtStartn').val()) > 31)
                t_err = t_err + q_getMsg("lblStartn") + q_getMsg("msgErr") + '\r';
            if (dec($('#txtGetdate').val()) > 31)
                t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r'


            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            var t_noa = trim($('#txtNoa').val());
            if (emp($('#txtUacc1').val()))
                $('#txtUacc1').val('1123.' + t_noa);
            if (emp($('#txtUacc2').val()))
                $('#txtUacc2').val('1121.' + t_noa);
            if (emp($('#txtUacc3').val()))
                $('#txtUacc3').val('2131.' + t_noa);

            if (t_noa.length == 0)   /// 自動產生編號
                q_gtnoa(q_name, t_noa);
            else
                wrServer(t_noa);
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '', '', 2);
        }
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
        }

        function btnMinus(id) {
            _btnMinus(id);
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            if (q_tables == 's')
                bbsAssign();  /// 表身運算式 
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
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
    </script>
    <style type="text/css">
        .tview
        {
            FONT-SIZE: 12pt;
            COLOR:  Blue ;
            background:#FFCC00;
            padding: 3px;
            TEXT-ALIGN:  center;
        }    
        .tbbm
        {
            FONT-SIZE: 12pt;
            COLOR: blue;
            TEXT-ALIGN: left;
            border-color: white; 
            width:100%; border-collapse: collapse; background:#cad3ff;
        } 
        
       
        .column1
        {
            width: 11%;
        }
        .column2
        {
            width: 21%;
        }      
        .column3
        {
            width: 21%;
        }   
         .label1
        {
            width: 12%;text-align:right;
        }       
        .label2
        {
            width: 12%;text-align:right;
        }
        .label3
        {
            width: 14%;text-align:right;
        }
        .txt.c1
        {
            width: 96%;
        }
        .txt.c2
        {
            width: 46%;
        }
        .txt.c3
        {
            width: 100%;
        }
        .txt.c4
        {
            width: 99%;
        }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='comp,4'>~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>
               <td class="label1" ><a id='lblNoa'></a></td>
               <td class="column1" ><input id="txtNoa" type="text" class="txt c1" /></td>
               <td class="label2" ><a id='lblSerial'></a></td>
               <td class="column2"><input id="txtSerial" type="text" class="txt c1"/></td>
               <td class="label3" ><a id='lblWorker'></a></td>
               <td class="column3"><input id="txtKeyin" type="text"  class="txt c2"/><input id="txtWorker"  type="text" class="txt c2"/></td>
            </tr>
            <tr>
               <td class="label1" ><a id='lblComp'></a></td>
               <td class="column1"  colspan='3' ><input id="txtComp" type="text"  class="txt c4"/></td>
               <td class="label3" ><a id='lblNick'></a></td>
               <td class="column3"><input id="txtNick" type="text"  class="txt c1"/></td>
            </tr>
            <tr>
               <td class="label1" ><a id='lblBoss'></a></td>
               <td class="column1"><input id="txtboss" type="text" class="txt c1"/></td>
               <td class="label2" ><a id='lblHead'></a></td>
               <td class="column2"><input id="txthead" type="text" class="txt c1"/></td>
               <td class="label3" ><a id='lblStatus'></a></td>
               <td class="column3"><input id="txtStatus"   type="text" class="txt c1"/></td> 
            </tr>
            <tr>
               <td class="label1" ><input id="btnConn" type="button" value='...' style='width: auto; font-size: medium;'  /></td>
               <td class="column1"><input id="txtConn" type="text" class="txt c1"/></td>
               <td class="label2" ><a id='lblType'></a></td>
               <td class="column2"><select id="cmbTypea" class="txt c1"></select></td> 
               <td class="label3" ><a id='lblTeam'></a></td>
               <td class="column3"><input id="txtTeam"  type="text" class="txt c1"/></td> 
            </tr>
            <tr>
               <td class="label1"  align="right"><a id='lblTel'></a></td>
               <td class="column1" colspan='5' ><input id="txtTel" type="text" class="txt c4"/></td>
            </tr>
            <tr>
               <td class="label1"  ><a id='lblFax'></a></td>
               <td class="column1" colspan='3' ><input id="txtFax" type="text" class="txt c4"/></td>
               <td class="label3" ><a id='lblMobile'></a></td>
               <td class="column3" ><input id="txtMobile"   type="text" class="txt c1"/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblAddr_fact'></a></td>
                <td class="column1" ><input id="txtZip_fact" type="text" class="txt c3"/></td>
                <td  colspan='4' ><input id="txtAddr_fact"  type="text"  class="txt c4"/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblAddr_comp'></a></td>
                <td class="column1" ><input id="txtZip_comp" type="text" class="txt c3"/></td>
                <td  colspan='4' ><input id="txtAddr_comp"  type="text"  class="txt c4"/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblAddr_invo'></a></td>
                <td class="column1" ><input id="txtZip_invo" type="text" class="txt c3"/></td>
                <td  colspan='4' ><input id="txtAddr_invo"  type="text"  class="txt c4"/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblAddr_home'></a></td>
                <td class="column1" ><input id="txtZip_home" type="text" class="txt c3"/></td>
                <td  colspan='4' ><input id="txtAddr_home"  type="text"  class="txt c4"/></td> 
            </tr>
            <tr>
                <td align="right">E-mail</td>
                <td  colspan='5' ><input id="txtEmail"  type="text"  class="txt c4"/></td> 
            </tr>

            <tr>
               <td class="label1"  ><input id="btnCredit" type="button" value='...' style='width: auto; font-size: medium;'  /></td>
               <td class="column1" ><input id="txtCredit" type="text"  class="txt c3"style="text-align: right;"/></td>
               <td class="label2" ><input id="btnSales" type="button" value='...' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtSalesno" type="text" style="width: 45%;"/>
                <input id="txtSales"    type="text"  style="width: 45%;"/></td>
                <td  align="right"><input id="btnTgg" type="button" value='...' style='width: auto; font-size: medium;'  /></td>
                <td><input id="txtGrpno" type="text" style="width: 45%;"/>
                <input id="txtGrpname"    type="text" style="width: 45%;"/></td>
            </tr>

            <tr>
                <td align="right"><a id='lblChkstatus'></a></td>
                <td  colspan='5' ><input id="txtChkstatus"  type="text"  class="txt c4"/></td> 
            </tr>

            <tr>
               <td class="label1" ><a id='lblChkdate'></a></td>
               <td class="column1" ><input id="txtChkdate" type="text" class="txt c1"/></td>
               <td class="label2" ><a id='lblStartn'></a></td>
                <td ><input id="txtStartn" type="text" class="txt c1" style="text-align: right;"/></td>
               <td class="label3" ><a id='lblUacc1'></a></td>
               <td><input id="txtUacc1"    type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <td class="label1" ><a id='lblDuedate'></a></td>
               <td class="column1"><input id="txtDuedate" type="text" class="txt c1"/></td>
               <td class="label2" ><a id='lblGetdate'></a></td>
                <td ><input id="txtGetdate" type="text" class="txt c1"/></td>
               <td class="label3" ><a id='lblUacc2'></a></td>
               <td><input id="txtUacc2"    type="text"  class="txt c1"/></td>
            </tr>
            <tr>
               <td class="label1" ><a id='lblTrantype'></a></td>
               <td class="column1" ><select id="cmbTrantype" class="txt c3"></select></td>
               <td class="label2" ><a id='lblPay'></a></td>
                <td > <input id="txtPay" type="text" class="txt c2"/>
                                      <select id="combPay" class="txt c2"></select></td>
               <td class="label3" ><a id='lblUacc3'></a></td>
               <td><input id="txtUacc3" type="text" class="txt c1"/></td>
            </tr>
            <tr>
                <td align="right"><a id='lblMemo'></a></td>
                <td  colspan='5' ><textarea id="txtMemo"  rows='5' cols='10' style="width:99%; height: 127px;"></textarea></td> 
            </tr>
        </table>
        </div>
        </div>
        <div id='message'  style="display: none">
            Hello
        </div>
        <input id="q_sys" type="hidden" />   
</body>
</html>
