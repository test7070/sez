<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title></title>
    <script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
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
        var q_name = "umm";
        var decbbs = ['money', 'total', 'weight', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'theory', 'c1', 'notv', 'c2', 'notv2'];
        var decbbm = ['money', 'tax', 'total', 'weight', 'floata', 'mount', 'price'];
        var q_readonly = ['txtComp', 'txtAcomp', 'txtTotal', 'txtTotalus', 'txtWeight','txtSales'];
        var q_readonlys = ['txtTotal', 'txtNo3', 'txtTheory']; 
        var bbmNum = [['txtPrice', 10, 3], ['txtTranmoney', 11, 2]];  // 允許 key 小數
        var bbmNum_comma = [ 'txtTotal', 'txtTotalus'];  ///  ,,,,,, 純粹 顯示 comma
        var bbsNum = [['txtPrice', 12, 3], ['txtWeight', 11, 2], ['txtMount', 9, 2]];
        var bbsNum_comma = ['txtTotal'];  // 該欄 不許再有運算式  ,,,,,, 純粹 顯示 comma
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
                        
            q_brwCount();  // 計算 合適  brwCount 

            if (!q_gt(q_name, q_content, q_sqlCount, 1))  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
                return;

            $('#txtDatea').focus
        });

        //////////////////   end Ready
       function main() {
           if (dataErr)  /// 載入資料錯誤
           {
               dataErr = false;
               return;
           }

            mainForm(1); // 1=最後一筆  0=第一筆

            $('#txtDatea').focus();
            
        }  ///  end Main()


        aPop = [['txtCustno', 'btnCust', 'cust', 'noa,comp,tel,zip_fact,addr_fact,pay,trantype', 'txtCustno,txtComp,txtTel,txtZipcode,txtAddr,txtPay,cmbTrantype', 'cust_b.aspx'],
                ['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtCarno', 'btnCar', 'car', 'noa,car', 'txtCarno,txtCar', 'car_b.aspx'],
                ['txtAcomp', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
                ['txtSalesno', 'btnSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];


        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd], ['txtDatea', r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbCoin", q_getPara('coin'));      /// q_cmbParse 會加入 fbbm

            $('#btnumm').click(function () { btnumm(); });

        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case 'ordes':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2'
                                                           , 'txtProductno,txtProduct,txtSpec');   /// 最後 aEmpField 不可以有【數字欄位】
                        bbsAssign();

                        for (i = 0; i < ret.length; i++) {
                            k = ret[i];  ///ret[i]  儲存 tbbs 指標
                            if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
                                $('#txtMount_' + k).val(b_ret[i]['notv']);
                                $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
                            }
                            else {
                                $('#txtWeight_' + k).val(b_ret[i]['notv']);
                                $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv'], b_ret[i]['weight']));
                            }

                        }  /// for i
                    }
                    break;
                
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
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('Q' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('umm_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
            var cmb = document.getElementById("combPay")
            if (!q_cur) 
                cmb.value = '';
            else
                $('#txtPay').val(cmb.value);
            cmb.value = '';
        }

        function bbsAssign() {  /// 表身運算式
            _bbsAssign();
            for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
                $('#btnProductno_' + j).click(function () {
                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    pop('ucc');
                 });
                 $('#txtProductno_' + j).change(function () {
                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
                     q_change($(this), 'ucc', 'noa', 'noa,product,unit');  /// 接 q_gtPost()
                 });
                
                $('#txtUnit_' + j).focusout(function () { sum(); });
                $('#txtWeight_' + j).focusout(function () { sum(); });
                $('#txtPrice_' + j).focusout(function () { sum(); });
                $('#txtMount_' + j).focusout(function () { sum(); });

            } //j
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtCno').val('1');
            $('#txtAcomp').val(r_comp.substr(0, 2));
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
 
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['type'] = abbm2['type'];
            as['mon'] = abbm2['mon'];
            as['noa'] = abbm2['noa'];
            as['Datea'] = abbm2['Datea'];

            if (!emp(abbm2['datea']))  /// 預交日
                as['datea'] = abbm2['datea'];

            as['custno'] = abbm2['custno'];

            if (!as['enda'])
                as['enda'] = 'N';
            t_err ='';
            if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
                t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';

            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

            
            if (t_err) {
                alert(t_err)
                return false;
            }
            
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            var t_float = dec($('#txtFloata').val());
            t_float = (emp(t_float) ? 1 : t_float);
            for (var j = 0; j < q_bbsCount; j++) {
                t_unit = $('#txtUnit_' + j).val();
                t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() == 'kg' ?  $('#txtWeight_' + j).val() : $('#txtMount_' + j).val());  // 計價量
                t_weight = t_weight + dec($('#txtWeight_' + j).val()); // 重量合計
                $('#txtTotal_' + j).val(round( $('#txtPrice_' + j).val() * dec( t_mount)* t_float, 0));
                t1 = t1 + dec($('#txtTotal_' + j).val());
            }  // j

            $('#txtMoney').val(round(t1, 0));
            if( !emp( $('#txtPrice' ).val()))
                $('#txtTranmoney').val(round(t_weight * dec($('#txtPrice').val()), 0));

            $('#txtWeight').val(round(t_weight, 0));
            //$('#txtTotal').val(t1 + dec($('#txtTax').val()));
            calTax();

            format();
        }

        function format() {  ////  主要為數字 comma
            var i;

            q_format(bbmNum_comma, bbmNum);   /// 顯示 , keyin 只為了小數點顯示

            q_formats(bbsNum_comma, bbsNum);   /// 顯示 , keyin 只為了小數點顯示
            q_init = 0;
        }
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);

            format();
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
            dataErr = !_q_appendData(t_Table);
        }

        function btnSeek(){
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
            TEXT-ALIGN:  center
        }    
        .tbbm
        {
            FONT-SIZE: 12pt;
            COLOR: blue;
            TEXT-ALIGN: left;
            border-color: white; 
            width:100%; border-collapse: collapse; background:#cad3ff;
        } 
        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:100% ;  
        } 
        
       
        .column1
        {
            width: 8%;
        }
        .column2
        {
            width: 10%;
        }      
        .column3
        {
            width: 8%;
        }   
        .column4
        {
            width: 8%;
        }           
         .label1
        {
            width: 10%;text-align:right;
        }       
        .label2
        {
            width: 8%;text-align:right;
        }
        .label3
        {
            width: 8%;text-align:right;
        }
       
      
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%">
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='custno comp,4'>~custno ~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
               <td class="label1" align="right"><a id='lblNoa'></a></td>
               <td class="column1" ><input id="txtNoa"   type="text"  maxlength='30'   style='width:94%;'/></td> 
               <td></td>
               <td class="label2" align="right" ><a id='lblDatea'></a></td>
               <td class="column3"><input id="txtDatea" maxlength='10' type="text"  style='width:100%;'/></td>
               <td class="column4" ></td>
               <td class="label3"  align="right"><a id='lblMon'></a></td>
               <td class="column2"><input id="txtMon"  type="text"  maxlength='20' style='width:94%'/></td> 
            </tr>
     
            <tr>
               <td align="right" class="style2" ><input id="btnAcomp" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
               <td class="column1" ><input id="txtCno"  type="text" maxlength='10' style='width:100%;' /></td>
               <td class="column2" ><input id="txtAcomp"    type="text" maxlength='90'  style='width:100%;'/></td>
                <td align="right" class="style2" ><a id='lblFloata'></a></td>
                <td class="column3" ><select id="cmbCoin" style='width:100%'  /> </td>                 
                <td class="column4" ><input id="txtFloata"    type="text"  maxlength='20' style='width:100%' /></td>                 
                <td align="right"><a id='lblWorker'></a></td>
                <td ><input id="txtWorker"  type="text"  maxlength='20'style='width:94%; text-align:center;'/></td> 
            </tr>

           <tr>
                <td align="right"><input id="btnCust" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtCustno" type="text" maxlength='10' style='width:100%;'  /></td>
                <td ><input id="txtComp"  type="text" maxlength='90'  style='width:100%;'/></td>
                <td align="right"><a id='lblPayc'></a></td>
                <td  colspan='2'><input id="txtPayc" type="text" maxlength='10' style='width:100%' /></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblVdate'></a></td>
                <td><input id="txtVbdate" type="text"  maxlength='20' style='width:100%' /></td> 
                <td><input id="txtVedate" type="text"  maxlength='20' style='width:100%' /></td> 

                <td align="right"><a id='lblCno2'></a></td>
                <td class="column4" ><input id="txtCno2"    type="text"  maxlength='20' style='width:100%' /></td>
                <td><input id="txtAccno2"    type="text"  maxlength='20' style='width:100%' /></td>
                <td align="right"><a id='lblAccno'></a></td>
                <td ><input id="txtAccno"    type="text"  maxlength='20' style='width:94%;'/></td> 
             </tr>
             <tr>
                <td align="right"><a id='lblTotalus'></a></td>
                <td colspan='2' ><input id="txtTotalus"    type="text"  maxlength='20'style='width:100%; text-align:center;'/></td> 
                <td align="right"><a id='lblPaysaleus'></a></td>
                <td  colspan='2'><input id="txtPaysaleus"    type="text"  maxlength='20'style='width:100%; text-align:center;'/></td> 
                <td align="right"><a id='lblNextsaleus'></a></td>
                <td ><input id="txtNextsaleus"    type="text"  maxlength='20'style='width:100%; text-align:center;'/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblTotal'></a></td>
                <td  colspan='2'><input id="txtTotal"    type="text"  maxlength='20'style='width:100%; text-align:center;'/></td> 
                <td align="right"><a id='lblPaysale'></a></td>
                <td  colspan='2'><input id="txtPaysale"    type="text"  maxlength='20'style='width:100%; text-align:center;'/></td> 
                <td align="right"><a id='lblNextsale'></a></td>
                <td><input id="txtNextsale"    type="text"  maxlength='20'style='width:100%; text-align:center;'/></td> 
            </tr>
            <tr><td align="right"><a id='lblMemo'></a></td>
                <td  colspan='7' ><input id="txtMemo"  type="text" maxlength='20' style="width:100%;"/></td></tr>
        </table>
        </div>
        </div>

        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
              <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblType'></a></td>
                <td align="center"><a id='lblMoney'></a></td>
                <td align="center"><a id='lblChgs'></a></td>
                <td align="center"><a id='lblPaysales'></a></td>
                <td align="center"><a id='lblMons'></a></td>
                <td align="center"><a id='lblCheckno'></a></td>
                <td align="center"><a id='lblAccount'></a></td>
                <td align="center"><a id='lblBankno'></a></td>
                <td align="center"><a id='lblBank'></a></td>
                <td align="center"><a id='lblIndate'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td style="width:8%; text-align:center"><input class="txt"  id="txtType.*" maxlength='30'type="text" style="width:98%;" /></td>
                
                <td style="width:6%;"><input class="txt" id="txtMoney.*" type="text"  maxlength='20' style="width:96%; text-align:right;"/>
                    <input class="txt" id="txtMoneyus.*" type="text"  maxlength='20' style="width:96%; text-align:right;"/></td>
                <td style="width:5%;"><input class="txt" id="txtChgs" type="text"  maxlength='20' style="width:96%; text-align:right;"/>
                    <input class="txt" id="txtChgsus" type="text"  maxlength='20' style="width:96%; text-align:right;"/></td>
                <td style="width:6%;"><input class="txt" id="txtPaysale.*" type="text" maxlength='20' style="width:96%; text-align:right;"/>
                    <input class="txt" id="txtPaysaleus.*" type="text" maxlength='20' style="width:96%; text-align:right;"/></td>

                <td style="width:5%;"><input class="txt" id="txtMon.*" type="text" maxlength='20' style="width:96%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtCheckno.*" type="text" maxlength='90' style="width:98%;" /></td>
                <td style="width:8%;"><input class="txt" id="txtAccount.*" type="text"  maxlength='20' style="width:98%;text-align:right;" /></td>
                <td style="width:6%;"><input class="txt" id="txtBankno.*" type="text" maxlength='20' style="width:98%;"/></td>
                <td style="width:18%;"><input class="txt" id="txtBank.*" type="text" maxlength='60' style="width:96%; text-align:right;"/></td>
                <td style="width:7%;"><input class="txt" id="txtIndate.*" type="text" maxlength='20' style="width:98%; text-align:right;"/></td>
                <td style="width:12%;"><input class="txt" id="txtMemo.*" type="text" maxlength='90' style="width:98%;"/>
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
    
    </form>
</body>
</html>
