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
        q_tables = 's';
        var q_name = "vcca";
        var decbbs = ['mount', 'price', 'total', 'tax'];
        var decbbm = ['money', 'tax', 'total'];
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [['txtPrice', 10, 3]];  // 允許 key 小數
        var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  // 計算 合適  brwCount 
            q_gt(q_name, q_content, q_sqlCount, 1)  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  /// 載入資料錯誤
            {
                dataErr = false;
                return;
            }

            mainForm(1); // 1=最後一筆  0=第一筆
        }  

        aPop = [['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtStoreno2', 'btnStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx', "60%", "650px", q_getMsg('popStore')],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];

        function mainPost() { // 載入資料完，未 refresh 前
            fbbm[fbbm.length] = 'txtMemo'; 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
             // 需在 main_form() 後執行，才會載入 系統參數
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret;
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('cng_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
        }

        function bbsAssign() {  /// 表身運算式
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product']) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];

            //            t_err ='';
            //            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
            //                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

            //            
            //            if (t_err) {
            //                alert(t_err)
            //                return false;
            //            }
            //            
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j

        }
        function refresh(recno) {
            _refresh(recno);

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
                bbsAssign();  /// 表身運算式 
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
            width:98%; border-collapse: collapse; background:#cad3ff;
        } 
        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:98% ; height:98% ;  
        } 
        
       
        .column1
        {
            width: 12%;
        }
        .column2
        {
            width: 15%;
        }      
        .column3
        {
            width: 15%;
        }   
        .column4
        {
            width: 12%;
        }           
         .label1
        {
            width: 12%; text-align:right;
        }       
        .label2
        {
            width: 10%; text-align:right;
        }
        .label3
        {
            width: 10%; text-align:right;
        }
       .label4
        {
            width: 10%; text-align:right;
        }
        .txt.c1
        {
            width: 95%;
        }
        .txt.c2
        {
            width: 30%;
        }
        .txt.c3
        {
            width: 65%;
        }
        .td1
        {
            width: 8%;
        }
       
      
    </style>
    </head>
<body>
<!--#include file="../inc/toolbar.inc"-->
 <div id='dmain'>
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/>.</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='datea'>~datea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
               <td class="label1"  ><a id='lblDatea'></a></td>
               <td class="column1"><input id="txtDatea"  type="text"  class="txt c1"/></td>
               <td class="label2" ><input id="btnCust" type="button" style="width: auto;font-size: medium;"></a></td>
               <td class="column2" colspan="3"><input id="txtCustno"  type="text"  class="txt c2"/>             
             <input id="txtComp" type="text"  class="txt c3"/></td>
        </tr>
        <tr>
            <td class="label1"  ><a id='lblNoa'></a></td>
            <td class="column1"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class="label2" ><a id='lblAddress'> </a></td>
            <td class="column2" colspan="3"><input id="txtAddress"  type="text"  style="width: 98%;"/></td>  
        </tr>
        <tr>
            <td class="label1" ><a id='lblSeria'></a></td>
            <td class="column1"><input id="txtSeria" type="text" class="txt c1"/></td>
            <td class="label2" ><a id='lblMon'> </a></td>
            <td class="column2"><input id="txtMon"  type="text" class="txt c1"/></td>                                
        </tr>
        <tr>
            <td class="label1" ><input id="btnAcomp" type="button" style="width: auto;font-size: medium;"/></td>
            <td class="column1" colspan="3"><input id="txtCno" class="txt c2"/>
            <input id="txtComp2" type="text"  class="txt c3"/></td> 
        </tr>
        <tr>
            <td class="label1" ><a id='lblChkno'></a></td>
            <td class="column1"><input id="txtChkno"  type="text" class="txt c1" /></td>
            <td class="label2" ><a id='lblMoney'> </a></td>
            <td class="column2"><input id="txtMoney"  type="text"  class="txt c1"/></td>            
            <td class="label3" ><a id='lblTax'></a></td>
            <td class="column3"><input id="txtTax"  type="text"  class="txt c1"/></td>                                   
        </tr>
        <tr>
            <td class="label1" ><a id='lblTaxtype'> </a></td>
            <td class="column1"><input id="txtTaxtype"  type="text"  class="txt c1"/></td>
             <td class="label2" ><a id='lblTotal'> </a></td>
            <td class="column2"><input id="txtTotal"  type="text"  class="txt c1"/></td>      
        </tr>
        <tr>
            <td class="label1"><a id="lblMemo" ></a></td>
            <td class="column1" colspan='5'><textarea id="txtMemo" rows="5" cols="10" style="width: 98%;height: 127px;"></textarea></td>
        </tr>
         <tr>
            <td class="label1" ><a id='lblAccno'></a></td>
            <td class="column1"><input id="txtAccno"  type="text" class="txt c1"/></td>
            <td class="label2" ><a id='lblBuyer'> </a></td>
            <td class="column2"><input id="txtBuyer"  type="text"  class="txt c1"/></td>
        </tr>
        <tr>
            <td class="label1"></td>
            <td class="column1"></td>
            <td class="label2"></td>
            <td class="column2"></td>
            <td class="label3" ><a id='lblWorker'> </a></td>
            <td class="column3"><input id="txtWorker"  type="text"  class="txt c1"/></td>
        </tr>
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td1"><a id='lblProductno'></a></td>
                <td align="center"><a id='lblProduct'></a></td>
                <td align="center" class="td1"><a id='lblUnit'></a></td>
                <td align="center" class="td1"><a id='lblMount'></a></td>
                <td align="center" class="td1"><a id='lblPrice'></a></td>
                <td align="center" class="td1"><a id='lblTotals'></a></td>
                <td align="center" class="td1"><a id='lblTaxs'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtProductno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtProduct.*" type="text" /></td>
                <td ><input class="txt c1" id="txtUnit.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMount.*" type="text" /></td>
                <td ><input class="txt c1" id="txtPrice.*" type="text" /></td>
                <td ><input class="txt c1" id="txtTotal.*"type="text" /></td>
                <td ><input class="txt c1" id="txtTax.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
