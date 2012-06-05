<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>    
    <script src='../script/qj.js' type="text/javascript"></script>
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
        var q_name = "orde";
        var q_readonly = ['txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtWeight','txtSales'];
        var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3', 'txtTheory']; 
        var bbmNum = [['txtPrice', 10, 3], ['txtTranmoney', 11, 2]];  // 允許 key 小數
        var bbsNum = [['txtPrice', 12, 3], ['txtWeight', 11, 2], ['txtMount', 9, 2]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'odate';
        //ajaxPath = ""; // 只在根目錄執行，才需設定

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'no2'];

            xmlTable = 'ordem,ordems,ordemt';
            xmlKey = [['noa'],['noa', 'noq'], ['noa', 'noq']];
            xmlDec = [ [],['price'],['price']];
            q_popSave(xmlTable);

            q_brwCount();  // 計算 合適  brwCount 

            q_gt(q_name, q_content, q_sqlCount, 1)  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
                

            $('#txtOdate').focus
        });

        //////////////////   end Ready
       function main() {
           if (dataErr)  /// 載入資料錯誤
           {
               dataErr = false;
               return;
           }
            mainForm(1); // 1=最後一筆  0=第一筆
        }  ///  end Main()

        function pop(form) {
            b_pop = form;
            switch (form) {
                case 'cust': q_pop('txtCustno', 'cust_b.aspx', 'cust', 'noa', 'comp', "60%", "650px", q_getMsg('popCust')); break;
                case 'store': q_pop('txtStoreno', 'store_b.aspx', 'store', 'noa', 'store', "60%", "650px", q_getMsg('popStore')); break;
                case 'car': q_pop('txtCarno', 'car_b.aspx', 'car', 'noa', 'car', "60%", "650px", q_getMsg('popCar')); break;
                case 'acomp': q_pop('txtCno', 'acomp_b.aspx', 'acomp', 'noa', 'acomp', "60%", "650px", q_getMsg('popAcomp')); break;
                case 'sss': q_pop('txtSalesno', 'sss_b.aspx', 'sss', 'noa', 'namea', "60%", "650px", q_getMsg('popSss')); break;
                case 'ucc': q_pop('txtProductno_' + b_seq, 'ucc_b.aspx', 'ucc', 'noa', 'product', "70%", "650px", q_getMsg('popUcc')); break;

            }
        }

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd ]];  
            q_mask(bbmMask);            
            q_cmbParse("cmbStype", q_getPara('orde.stype')); // 需在 main_form() 後執行，才會載入 系統參數  
            q_cmbParse("cmbCoin", q_getPara('sys.coin'));      /// q_cmbParse 會加入 fbbm
            q_cmbParse("combPay", q_getPara('vcc.pay'));  // comb 未連結資料庫
            q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));  

            $('#btnQuat').click(function () { btnQuat(); });

            $('#btnCust').click(function () { pop('cust'); });   /// 接 q_browFill()
            $('#btnCust').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtCustno").change(function () { q_change($(this), 'cust', 'noa', 'noa,comp,tel,post_fact,addr_fact,pay,trantype'); }); /// 接 q_gtPost()

            $('#btnStore').click(function () { pop('store'); }); /// 接 q_browFill()
            $('#btnStore').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtStoreno").change(function () { q_change($(this), 'store', 'noa', 'noa,store'); }); /// 接 q_gtPost()

            $('#btnCar').click(function () { pop('car'); }); /// 接 q_browFill()
            $('#btnCar').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtCarno").change(function () { q_change($(this), 'car', 'noa', 'noa,car'); }); /// 接 q_gtPost()

            $('#btnAcomp').click(function () { pop('acomp'); }); /// 接 q_browFill()
            $('#btnAcomp').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtCno").change(function () { q_change($(this), 'acomp', 'noa', 'noa,acomp'); }); /// 接 q_gtPost()

            $('#btnSales').click(function () { pop('sss'); }); /// 接 q_browFill()
            $('#btnSalesno').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtSalesno").change(function () { q_change($(this), 'sss', 'noa', 'noa,namea'); }); /// 接 q_gtPost()

            $('#btnOrdem').click(function () { q_pop('txtNoa', "ordem_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';;" + q_cur, 'ordem', 'noa', 'comp', "90%", "800px", q_getMsg('popOrdem')); });

        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、訂單視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case 'cust':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtCustno,txtComp,txtTel,txtPost,txtAddr,txtPay,cmbTrantype', ret, 'noa,comp,tel,post_fact,addr_fact,pay,trantype');
                    break;

                case 'ucc':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtProductno_' + b_seq + ',txtProduct_' + b_seq, ret, 'noa,product');
                    break;

                case 'acomp':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtCno,txtAcomp', ret, 'noa,acomp');
                    break;

                case 'store':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtStoreno,txtStore', ret, 'noa,store');
                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                    break;

                case 'car':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtCarno,txtCar', ret, 'noa,car');
                    break;

                case 'quats':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtQuatno,txtNo3,txtPrice', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no3,price'
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
                case 'cust':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtCustno,txtComp,txtTel,txtPost,txtAddr,txtPay,cmbTrantype', 'noa,comp,tel,post_fact,addr_fact,pay,trantype');
                    break;

                case 'acomp':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtCno,txtAcomp', 'noa,acomp');
                    break;

                case 'store':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtStoreno,txtStore', 'noa,store');
                    break;

                case 'car':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtCarno,txtCar', 'noa,car');
                    break;

                case 'sss':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtSalesno,txtSales', 'noa,namea');
                    break;

                case 'ucc':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtProductno_' + b_seq + ',txtProduct_' + b_seq + ',txtUnit_' + b_seq, 'noa,product,unit');
                    break;

                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function btnQuat() {
            var t_custno = trim($('#txtCustno').val());
            var t_where='';
            if (t_custno.length > 0) {
                t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");  ////  sql AND 語法，請用 &&  
                t_where =  t_where ;
            }
            else {
                alert(q_getMsg('msgCustEmp'));
                return;
            }

            q_box('quats_b.aspx', 'quats;' + t_where, "95%", "650px", q_getMsg('popQuat'));
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
                q_gtnoa(q_name, replaceAll('E' + $('#txtOdate').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('orde_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
            $('#txtOdate').val(q_date());
            $('#txtOdate').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtOdate').focus();
        }
        function btnPrint() {

        }
        
        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

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
            as['odate'] = abbm2['odate'];
            
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
                t_weight = t_weight + dec( $('#txtWeight_' + j).val()) ; // 重量合計
                $('#txtTotal_' + j).val(round( $('#txtPrice_' + j).val() * dec( t_mount) * t_float, 0));
                t1 = t1 + dec($('#txtTotal_' + j).val());
            }  // j

            $('#txtMoney').val(round(t1, 0));
            if( !emp( $('#txtPrice' ).val()))
                $('#txtTranmoney').val(round(t_weight * dec($('#txtPrice').val()), 0));

            $('#txtWeight').val(round(t_weight, 0));
            //$('#txtTotal').val(t1 + dec($('#txtTax').val()));

            calTax();
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
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            
        }

        function q_appendData(t_Table) {
            return _q_appendData(t_Table);
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
         #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
                margin: -1px;
                border: 1px black solid;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 48%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
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
            .tbbm td input[type="button"] {
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='odate'>~odate</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='custno comp,4'>~custno ~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr class="tr1">
               <td class="td1"><span> </span><a id='lblStype' class="lbl"></a></td>
               <td class="td2"><select id="cmbStype" class="txt c1"></select></td>
               <td class="td3"></td>
               <td class="td4"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td5"><input id="txtDatea"  type="text"  class="txt c1"/></td>
               <td class="td6"></td>
               <td class="td7"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td8"><input id="txtNoa"   type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"></a></td>
               <td class="column1" ><input id="txtCno"  type="text" maxlength='10' style='width:100%;' /></td>
               <td class="column2" ><input id="txtAcomp"    type="text" maxlength='90'  style='width:100%;'/></td>
               <td align="right" class="style2" ><a id='lblFloata'></a></td>
               <td class="column3" ><select id="cmbCoin" style='width:100%'  /> </td>                 
               <td class="column4" ><input id="txtFloata"    type="text"  maxlength='10' style='width:100%' /></td>                 
               <td align="right" class="style2"><input id="btnQuat" type="button" value='.' style='width: auto; font-size:  medium;'  /></td>
               <td class="column2"><input id="txtInvo"    type="text"  maxlength='10' style='width:94%;'/></td> 
            </tr>
           <tr class="tr3">
                <td align="right"><input id="btnCust" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtCustno" type="text" maxlength='10' style='width:100%;'  /></td>
                <td ><input id="txtComp"  type="text" maxlength='90'  style='width:100%;'/></td>
                <td align="right"><a id='lblPay'></a></td>
                <td ><input id="txtPay" type="text" maxlength='10' style='width:100%' /></td> 
                <td> <select id="combPay" style='width:100%' onchange='combPay_chg()' /></td> 
                <td align="right"><a id='lblContract'></a></td>
                <td><input id="txtContract"  type="text"  maxlength='20' style='width:94%' /></td> 
            </tr>
            <tr class="tr4">
                <td align="right"><input id="btnSales" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtSalesno" type="text" maxlength='12' style="width:100%"/></td> 
                <td ><input id="txtSales" type="text" maxlength='12' style="width:100%"/></td> 
                <td align="right" ><a id='lblTel'></a></td>
                <td colspan='2'><input id="txtTel"    type="text"  maxlength='90' style='width:100%;'/></td>
                <td align="right" ><a id='lblFax'></a></td>
                <td ><input id="txtFax"    type="text"  maxlength='90' style='width:98%;'/></td>
            </tr>
            <tr class="tr5">
                <td align="right" ><a id='lblAddr'></a></td>
                <td ><input id="txtPost"  type="text"   maxlength='10'  style='width:100%;'/> </td>
                <td colspan='4' ><input id="txtAddr"  type="text"  maxlength='90'  style='width:100%;'/> </td>
                <td align="right" ><a id='lblTrantype'></a></td>
                <td ><select id="cmbTrantype" style='width:100%' name="D1" /></td> 
            </tr>
            <tr class="tr6">
                <td align="right" ><a id='lblAddr2'></a></td>
                <td ><input id="txtPost2"  type="text"   maxlength='10'  style='width:100%;'/> </td>
                <td colspan='4' ><input id="txtAddr2"  type="text"  maxlength='90'  style='width:100%;'/> </td>
                <td align="right" >&nbsp;</td>
                <td ><input id="btnOrdem" type="button" value='' style='width: auto; font-size: medium;'  /></td> 
            </tr>
            <tr class="tr7">
                <td align="right"><a id='lblMoney'></a></td>
                <td colspan='2'><input id="txtMoney"    type="text"  maxlength='20'style='width:100%; text-align:center;'/></td> 
                <td align="right" ><a id='lblTax'></a></td>
                <td><input id="txtTax"    type="text" maxlength='20' style='width:100%; text-align:center;'/></td>
                <td><select id="cmbTaxtype" style='width:100%'  onchange='calTax()' /></td>
                <td align="right"><a id='lblTotal'></a></td>
                <td ><input id="txtTotal"    type="text" maxlength='20' style='width:94%; text-align:center;'/>
                </td> 
            </tr>
            <tr class="tr7">
                <td align="right"><a id='lblTotalus'></a></td>
                <td colspan='2'><input id="txtTotalus"    type="text"  maxlength='20'style='width:100%; text-align:center;'/></td> 
                <td align="right" ><a id='lblWeight'></a></td>
                <td colspan='2' ><input id="txtWeight"  type="text"  maxlength='20' style='width:100%; text-align:center;'/></td>
                <td align="right"><a id='lblWorker'></a></td>
                <td ><input id="txtWorker"  type="text"  maxlength='20'style='width:94%; text-align:center;'/></td> 
            </tr>
            <tr class="tr8">
                <td align="right"><a id='lblMemo'></a></td>
                <td  colspan='7' ><input id="txtMemo"  type="text" maxlength='20' style="width:100%;"/></td> 
            </tr>
        </table>
        </div>
        </div>

        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblProductno'></a></td>
                <td align="center"><a id='lblProduct'></a></td>
                <td align="center"><a id='lblSize'></a></td>
                <td align="center"><a id='lblUnit'></a></td>
                <td align="center"><a id='lblMount'></a></td>
                <td align="center"><a id='lblWeights'></a></td>
                <td align="center"><a id='lblPrices'></a></td>
                <td align="center"><a id='lblTotals'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td style="width:10%; text-align:center"><input class="txt"  id="txtProductno.*" maxlength='30'type="text" style="width:98%;" />
                                       <input class="btn"  id="btnProductno.*" type="button" value='...' style=" font-weight: bold;" />
                                       <input class="txt"  id="txtNo2.*" maxlength='10'type="text" style="width:20%;" /></td>
                <td style="width:20%;"><input class="txt" id="txtProduct.*" type="text" maxlength='90' style="width:98%;" />
                <input class="txt" id="txtUno.*" type="text"  maxlength='40' style="width:98%;" /></td>
                <td style="width:18%;"><input class="txt" id="txtDime.*" type="text"  maxlength='10' style="width:25%;text-align:right;" />x
                                    <input class="txt" id="txtWidth.*" type="text"  maxlength='10' style="width:25%;text-align:right;" />x
                                    <input class="txt" id="txtLengthb.*" type="text"  maxlength='10' style="width:25%;text-align:right;" />
                                    <input class="txt" id="txtSpec.*" type="text"  style="width:98%;" /> </td>
                <td style="width:4%;"><input class="txt" id="txtUnit.*" type="text" maxlength='10' style="width:94%;"/></td>
                <td style="width:5%;"><input class="txt" id="txtMount.*" type="text" maxlength='20' style="width:94%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtWeight.*" type="text" maxlength='20' style="width:96%; text-align:right;"/></td>
                <td style="width:6%;"><input class="txt" id="txtPrice.*" type="text"  maxlength='20' style="width:96%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtTotal.*" type="text" maxlength='20' style="width:96%; text-align:right;"/>
                                      <input class="txt" id="txtGweight.*" type="text" maxlength='20' style="width:96%; text-align:right;"/></td>
                <td style="width:12%;"><input class="txt" id="txtMemo.*" type="text" maxlength='90' style="width:98%;"/>
                <input class="txt" id="txtQuatno.*" type="text" maxlength='30' style="width:65%;" />
                <input class="txt" id="txtNo3.*" type="text" maxlength='5' style="width:20%;" />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>

        </table>
        </div>
        <input id="q_sys" type="hidden" />
    
    </form>
</body>
</html>
