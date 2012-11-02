<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src="../script/qbox.js" type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        this.errorHandler = null;

        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "vcc";
        var decbbs = [ 'money','total', 'weight', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'gweight'];
        var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney'];
        var q_readonly = ['txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtWeight', 'txtOrdeno'];//, 'txtAccno','txtMon','txtSales']; 
        var q_readonlys= ['txtTotal','txtOrdeno','txtNo2'];
        var bbmNum = [['txtPrice', 10, 3], ['txtTranmoney', 11, 2], ['txtMoney', , , 1], ['txtTax', , , 1], ['txtTotal', , , 1], ['txtTotalus', , , 1], ['txtWeight', , , 1]];  // 允許 key 小數
        var bbsNum = [['txtPrice', 12, 3], ['txtWeight', 11, 2, 1], ['txtMount', 9, 2, 1], ['txtTotal', , , 1]];
        var bbmMask = []; // post 後給值
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定

        $(document).ready(function () {
            q_desc = 1;
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];

            q_brwCount();  // 計算 合適  brwCount 
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
        });

        //////////////////   end Ready
       function main() {
           if (dataErr) {  /// 載入資料錯誤
               dataErr = false;
               return;
           }

            mainForm(1); // 1=最後一筆  0=第一筆
        }  ///  end Main()

        aPop = [['txtCustno' , 'lblCust' , 'cust' , 'noa,comp,tel,zip_fact,addr_fact,pay,trantype', 'txtCustno,txtComp,txtTel,txtZipcode,txtAddr,txtPay,cmbTrantype','cust_b.aspx'],
                ['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtCarno'  , 'lblCar'  , 'car'  , 'noa,car'  , 'txtCarno,txtCar' , 'car_b.aspx'],
                ['txtAcomp', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
                ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('vcc.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
            q_cmbParse("cmbStype", q_getPara('vcc.stype'));
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));   
            q_cmbParse("cmbCoin", q_getPara('sys.coin'));      /// q_cmbParse 會加入 fbbm
            q_cmbParse("combPay", q_getPara('vcc.pay'));  // comb 未連結資料庫
            q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));

            $('#btnOrdes').click(function () { btnOrdes(); });

            $('#btnOrde').click(function () { q_pop('txtOrdeno', "orde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtOrdeno').val() + "';" + r_accy + '_' + r_cno, 'orde', 'noa', '', "92%", "1024px", q_getMsg('popOrde'), true); });

            $('#btnAccc').click(function () {
                q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true); 
                //q_gt('sss',  " field=noa,namea,rank where=^^LEFT(noa,1)='A'^^"); 
            });
            $('#btnFunc').click(function () { 
                q_func( 't3.func1',"3,4,5")
             });
        }

        function q_funcPost(t_func, result) {
            if (result.substr(0, 5) == '<Data') {
                var Asss = _q_appendData('sss', '', true);
                var Acar = _q_appendData('car', '', true);
                var Acust = _q_appendData('cust', '', true);
                alert(Asss[0]['namea'] + '^' + Acar[0]['car'] + '^' + Acust[0]['comp']);
            }
            else
                alert(t_func + '\r' + result);
        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、訂單視窗  關閉時執行
            var ret;

            switch (b_pop) {   
                case 'ordes':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2,txtPrice', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2,price'
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
                case 'sss': 
                 var as = _q_appendData('sss', '', true);
            }  /// end switch
        }
         function q_stPost() {
		        if (!(q_cur == 1 || q_cur == 2))
		            return false;
		        abbm[q_recno]['accno'] = xmlString;
		        $('#txtAccno').val(xmlString);
		    }
        
        function btnOrdes() {
            var t_custno = trim($('#txtCustno').val());
            var t_where='';
            if (t_custno.length > 0) {
                t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");  ////  sql AND 語法，請用 &&  
                t_where = t_where;
            }
            else {
                alert( q_getMsg('msgCustEmp'));
                return;
            }
            q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+t_where , 'ordes' , "95%", "650px", q_getMsg( 'popOrde'));
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            $('#txtWorker' ).val(  r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase()+bbmKey[0].substr( 1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('D' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
            
            q_box('vcc_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
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
 			q_box("z_vccp.aspx?" , '', "95%", "650px", m_print);
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase()+bbmKey[0].substr( 1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product'] && !as['spec'] && !dec( as['total'])) {  //不存檔條件
                as[bbsKey[1]] = '';   /// noq 為空，不存檔
                return;
            }

            q_nowf();
            as['type'] = abbm2['type'];
            as['mon'] = abbm2['mon'];
            as['noa'] = abbm2['noa'];
            as['datea'] = abbm2['datea'];
            as['custno'] = abbm2['custno'];
            if (abbm2['storeno'])
                as['storeno'] = abbm2['storeno'];

            t_err ='';
            if (as['price'] != null && ( dec( as['price']) > 99999999 || dec( as['price']) < -99999999)) 
                t_err = q_getMsg( 'msgPriceErr')+as['price']+'\n' ;

            if (as['total'] != null && ( dec( as['total']) > 999999999 || dec( as['total']) < -99999999))
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
         #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 32%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 68%;
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
                width: 94%;
                float: left;
            }
            .txt.c7 {
                width: 100%;
                float: left;
            }
            .txt.c8 {
                width: 25%;
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
                font-size: medium;
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

<body ondragstart="return false" draggable="false"
        ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
        ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
    <form id="form1" runat="server" style="height: 100%">
        <!--#include file="../inc/toolbar.inc"-->

        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:5%"><a id='vewType'> </a></td>
                <td align="center" style="width:25%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:25%"><a id='vewNoa'> </a></td>
                <td align="center" style="width:40%"><a id='vewComp'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='typea=vcc.typea'>~typea=vcc.typea</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='custno comp,4'>~custno ~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr class="tr1">
               <td class="td1"><span> </span><a id='lblType' class="lbl"> </a></td>
               <td class="td2" colspan="2"><select id="cmbTypea" style="width: 25%;" > </select>
               <a id='lblStype' style="width: 30%;"> </a><select id="cmbStype" style='width:45%;'> </select></td>
               <td class="td4"><span> </span><a id='lblDatea' class="lbl"> </a></td>
               <td class="td5"><input id="txtDatea" type="text"  class="txt c1"/></td>
               <td class="td6"><input id="btnOrde" type="button" value='.' /></td>
               <td class="td7"><span> </span><a id='lblNoa' class="lbl"> </a></td>
               <td class="td8"><input id="txtNoa" type="text" class='txt c6'  /></td> 
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
               <td class="td2" ><input id="txtCno"  type="text" class="txt c7"/></td>
               <td class="td3" ><input id="txtAcomp" type="text" class="txt c7"/></td>
               <td class="td4"><span> </span><a id='lblFloata' class="lbl"> </a></td>
               <td class="td5"><select id="cmbCoin" class="txt c7"> </select></td>                 
               <td class="td6" ><input id="txtFloata"    type="text" class="txt c7" /></td>                 
               <td class="td7"><span> </span><a id='lblInvono' class="lbl" > </a></td>
               <td class="td8"><input id="txtInvo"  type="text" class="txt c6"/></td> 
           </tr>
           <tr class="tr3">
                <td class="td1"><span> </span><a id="lblCust" class="lbl btn" ></a></td>
                <td class="td2"><input id="txtCustno" type="text" class="txt c7"/></td>
                <td class="td3"><input id="txtComp"  type="text" class="txt c7"/></td>
                <td class="td4"><span> </span><a id='lblPay' class="lbl"> </a></td>
                <td class="td5"><input id="txtPay" type="text" class="txt c1" /></td> 
                <td class="td6"><select id="combPay" class="txt c7" onchange='combPay_chg()'> </select></td> 
                <td class="td7" align="right"><span> </span><input id="btnOrdes" type="button" value='.' /></td>
                <td class="td8"><input id="txtOrdeno"  type="text" class="txt c6"/></td> 
            </tr>
            <tr class="tr4">
                <td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
                <td class="td2" colspan='2'><input id="txtTel" type="text" class="txt c7"/></td>
                <td class="td4"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
                <td class="td5" colspan='2'><select id="cmbTrantype" class="txt c7"> </select></td> 
                <td class="td7"><span> </span><a id='lblMon' class="lbl"> </a></td>
                <td class="td8"><input id="txtMon" type="text" class="txt c6"/></td> 
            </tr>
            <tr class="tr5">
                <td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
                <td class="td2"><input id="txtZipcode"  type="text" class="txt c7"/> </td>
                <td class="td3" colspan='4' ><input id="txtAddr"  type="text" class="txt c7"/> </td>
                <td class="td7"><span> </span><a id='lblPrice' class="lbl"> </a></td>
                <td class="td8"><input id="txtPrice"  type="text" class="txt num c6"/></td> 
            </tr>
            <tr class="tr6">
                <td  class="td1"><span> </span><a id="lblCar" class="lbl btn"></a></td>
                <td  class="td2"><input id="txtCarno"    type="text" class="txt c7"/></td>
                <td  class="td3"><input id="txtCar"    type="text" class="txt c7"/></td>
                <td  class="td4"><span> </span><a id='lblCarno2' class="lbl"> </a></td>
                <td  class="td5" colspan='2'><input id="txtCarno2"  type="text" class="txt c7"/></td> 
                <td class="td6"><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
                <td class="td7"><input id="txtTranmoney" type="text" class="txt num c6"/></td> 
            </tr>
            <tr class="tr7">
                <td class="td1"><span> </span><a id="lblStore" class="lbl btn" > </a></td>
                <td class="td2"><input id="txtStoreno"  type="text" class="txt c7" /></td> 
                <td class="td3"><input id="txtStore"    type="text" class="txt c7"/></td> 
                <td class="td4"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
                <td class="td5"><input id="txtSalesno" type="text" class="txt c7"/></td>
                <td class="td6"><input id="txtSales"   type="text" class="txt c7"/></td>
                <td class="td7"><input id="btnAccc" type="button" value='.' /><input id="btnFunc" type="button" value='Func' /></td>
                <td class="td8"><input id="txtAccno"    type="text" class="txt c6"/></td> 
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
                <td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c7"/></td> 
                <td class="td3"><span> </span><a id='lblTax' class="lbl"> </a></td>
                <td class="td4"><input id="txtTax"  type="text" class="txt num c7"/></td>
                <td class="td5"><select id="cmbTaxtype"  onchange='calTax()' class="txt c7" > </select></td>
                <td class="td6"><span> </span><a id='lblTotal' class="lbl"> </a></td>
                <td class="td7"><input id="txtTotal" type="text" class="txt num c6"/></td> 
            </tr>
            <tr class="tr9">
                <td class="td1"><span> </span><a id='lblTotalus' class="lbl"> </a></td>
                <td class="td2" colspan='2'><input id="txtTotalus" type="text" class="txt num c7"/></td> 
                <td class="td4"><span> </span><a id='lblWeight' class="lbl"> </a></td>
                <td class="td5" colspan='2' ><input id="txtWeight"  type="text" class="txt num c7"/></td>
                <td class="td7"><span> </span><a id='lblWorker' class="lbl"> </a></td>
                <td class="td8"><input id="txtWorker"  type="text" class="txt num c6"/></td> 
            </tr>
            <tr class="tr10">
                <td class="td1"><span> </span><a id='lblMemo'class="lbl"> </a></td>
                <td class="td2" colspan='7' ><input id="txtMemo"  type="text" class="txt c7"/></td> 
            </tr>
        </table>
        </div>
        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:10%;"><a id='lblProductno'> </a></td>
                <td align="center" style="width:20%;"><a id='lblUno'> </a></td>
                <td align="center" style="width:18%;"><a id='lblSize'> </a></td>
                <td align="center" style="width:4%;"><a id='lblUnit_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblMount'> </a></td>
                <td align="center" style="width:8%;"><a id='lblWeights'> </a></td>
                <td align="center" style="width:6%;"><a id='lblPrices'> </a></td>
                <td align="center" style="width:8%;"><a id='lblNetweight'> </a></td>
                <td align="center" style="width:12%;"><a id='lblOrdenos'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td ><input  id="txtProductno.*"type="text" class="txt c1" />
                                       <input id="btnProductno.*" type="button" value='...' style=" font-weight: bold;" /></td>
                <td ><input  id="txtProduct.*" type="text"  class="txt c1" />
                <input id="txtUno.*" type="text" class="txt c1" /></td>
                <td ><input  id="txtDime.*" type="text" class="txt num c8"/>x
                                    <input  id="txtWidth.*" type="text" class="txt num c8"/>x
                                    <input  id="txtLengthb.*" type="text" class="txt num c8"/>
                                    <input  id="txtSpec.*" type="text" class="txt c1" /> </td>
                <td ><input id="txtUnit.*" type="text" class="txt c6"/></td>
                <td><input id="txtMount.*" type="text"  class="txt num c6"/></td>
                <td ><input id="txtWeight.*" type="text" class="txt num c6"/></td>
                <td ><input id="txtPrice.*" type="text" class="txt num c6"/></td>
                <td ><input id="txtTotal.*" type="text" class="txt num c6"/>
                     <input  id="txtGweight.*" type="text" class="txt num c6"/></td>
                <td ><input id="txtMemo.*" type="text" class="txt c1"/>
                <input id="txtOrdeno.*" type="text" style="width:65%;" />
                <input id="txtNo2.*" type="text" style="width:20%;" />
                <input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
  
    </form>
</body>
</html>
