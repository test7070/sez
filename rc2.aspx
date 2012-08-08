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
        var q_name = "rc2";
        var decbbs = [ 'money','total', 'weight', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'weight2'];
        var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney','totalus'];
        var q_readonly = []; 
        var q_readonlys= [];
        var bbmNum = [];  // 允許 key 小數
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		 aPop = new Array(['txtTggno', 'btnTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],['txtCno','btnAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],['txtCarno', 'btnCar', 'cardeal', 'noa,comp', 'txtCarno,txtCar', 'cardeal_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

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

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd ]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('rc2.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
            q_cmbParse("cmbStype", q_getPara('rc2.stype'));   
            q_cmbParse("cmbCoin", q_getPara('sys.coin'));      /// q_cmbParse 會加入 fbbm
            q_cmbParse("combPay", q_getPara('rc2.pay'));  // comb 未連結資料庫
            q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));  
             $('#btnAccc').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
		        });

        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、廠商視窗、訂單視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case 'tgg':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtTggno,txtComp,txtTel,txtPost,txtAddr,txtPay,cmbTrantype', ret, 'noa,comp,tel,post_fact,addr_fact,pay,trantype'); 
                    break;

                case 'ucc':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill( 'txtProductno_' + b_seq+',txtProduct_' + b_seq , ret, 'noa,product'); 
                    break;

                case 'acomp':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4)  q_browFill('txtCno,txtAcomp' , ret , 'noa,acomp'); 
                    break;

                case 'store':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill( 'txtStoreno_' + b_seq+',txtStore_' + b_seq , ret, 'noa,store'); 
                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                    break;

                case 'car':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4)  q_browFill('txtCarno,txtCar',ret , 'noa,car'); 
                    break;

                case 'ordcs':
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
                case 'tgg':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtTggno,txtComp,txtTel,txtPost,txtAddr,txtPay,cmbTrantype', 'noa,comp,tel,post_fact,addr_fact,pay,trantype');
                    break;

                case 'acomp':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtCno,txtAcomp', 'noa,acomp');
                    break;

                case 'store':  ////  直接 key in 編號，帶入 form
                    //q_changeFill(t_name, 'txtStoreno,txtStore', 'noa,store');
                    q_changeFill(t_name, 'txtStoreno_' + b_seq + ',txtStore_' + b_seq, 'noa,store');
                    break;

                case 'car':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtCarno,txtCar', 'noa,car');
                    break;

                case 'sss':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtSalesno,txtSales', 'noa,namea');
                    break;

                case 'ucc':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtProductno_' + b_seq+ ',txtProduct_' + b_seq+ ',txtUnit_' + b_seq, 'noa,product,unit');
                    break;

                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function btnOrdc() {
            var t_tggno = trim($('#txtTggno').val());
            var t_where='';
            if (t_tggno.length > 0) {
                t_where = "enda='N' && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "");  ////  sql AND 語法，請用 &&  
                t_where = t_where;
            }
            else {
                alert(q_getMsg('msgTggEmp'));
                return;
            }
            q_box('ordcs_b.aspx', 'ordcs;' + t_where, "95%", "650px", q_getMsg('popOrdc'));
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtTggno', q_getMsg('lblTggno')], ['txtCno', q_getMsg('btnAcomp')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            $('#txtWorker' ).val(  r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('I' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('rc2_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
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
            for (var j = 0; j < ( q_bbsCount==0 ? 1 : q_bbsCount); j++) {
                $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
                $('#btnProductno_' + j).click(function () {
                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    pop('ucc', '_'+t_IdSeq);
                 });
                 $('#txtProductno_' + j).change(function () {
                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
                     q_change($(this), 'ucc', 'noa', 'noa,product');  /// 接 q_gtPost()
                 });

                 $('#btnStore_' + j).click(function () {
                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    pop('store', '_'+t_IdSeq);
                 });
                 $('#txtStoreno_' + j).change(function () {
                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
                     q_change($(this), 'store', 'noa', 'noa,store');  /// 接 q_gtPost()
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
            $('#txtAcomp').val( r_comp.substr( 0,2));
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }

        function btnModi() {
            if( emp( $('#txtNoa').val()))
                return;

            _btnModi();
            $('#txtDatea').focus();
        }


        function btnPrint() {
 
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk( null, bbmKey[0], bbsKey[1], '', 2);  // key_value
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
            as['tggno'] = abbm2['tggno'];
            if (abbm2['storeno'])
                as['storeno'] = abbm2['storeno'];

            t_err = '';
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
                $('#txtTotal_' + j).val(round( $('#txtPrice_' + j).val() * dec( t_mount)*t_float, 0));
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
            width: 8%;text-align:right;
        }       
        .label2
        {
            width: 8%;text-align:right;
        }
        .label3
        {
            width: 8%;text-align:right;
        }
        .txt.c1
        {
        	width: 95%;
        }
        .txt.c2
        {
        	width: 100%;
        }
       td input[type="button"] {
                width: auto;
                font-size: medium;
                float: right;
            }
        .txt .num
        {
        	text-align: right;
        }
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:5%"><a id='vewTypea'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewTgg'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='typea=rc2.typea'>~typea=rc2.typea</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='tggno tgg,4'>~tggno ~tgg,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
               <td class="label1" ><a id='lblType'></a></td>
               <td class="column1" >
               <%--<input id="txtType" type="text"  style='width:0%; visibility:collapse;'/>--%>
               <select id="cmbTypea" class="txt c2"></select></td>
               <td class="column2" ><a id='lblStype' style='width:28%;'></a><select id="cmbStype" style='width:70%;'></select></td>
               <td class="label2" ><a id='lblDatea'></a></td>
               <td class="column3"><input id="txtDatea" type="text"  class="txt c2"/></td>
               <td class="column4" ></td>
               <td class="label3" ><a id='lblNoa'></a></td>
               <td class="column2" ><input id="txtNoa" type="text"class="txt c1"/></td> 
            </tr>
     
            <tr>
               <td class="label1"><input id="btnAcomp" type="button" value='.' /></td>
               <td class="column1" ><input id="txtCno"  type="text" class="txt c2"/></td>
               <td class="column2" ><input id="txtAcomp" type="text" class="txt c2"/></td>
                <td class="label2"><a id='lblFloata'></a></td>
                <td class="column3" ><select id="cmbCoin" class="txt c2" ></select></td>                 
                <td class="column4" ><input id="txtFloata"   type="text" class="txt num c2" /></td>                 
                <td class="label3"><a id='lblInvono'></a></td>
                <td class="column2"><input id="txtInvono"  type="text" class="txt c1"/></td> 
            </tr>

           <tr>
                <td class="label1"><input id="btnTgg" type="button" value='.' /></td>
                <td ><input id="txtTggno" type="text" class="txt c2" /></td>
                <td ><input id="txtTgg"  type="text" class="txt c2"/></td>
                <td class="label2"><a id='lblPay'></a></td>
                <td ><input id="txtPay" type="text" class="txt c2"/></td> 
                <td> <select id="combPay" class="txt c2"></select></td> 
                <td class="label3"><input id="btnOrdc" type="button" value='.' /></td>
                <td><input id="txtOrdeno"  type="text"  class="txt c1"/></td> 
            </tr>
            <tr>
                <td class="label1"><a id='lblTel'></a></td>
                <td colspan='2' ><input id="txtTel" type="text" class="txt c2"/></td>
                <td class="label2"><a id='lblTrantype'></a></td>
                <td  colspan='2' ><select id="cmbTrantype" class="txt c2"></select></td> 
                <td class="label3" ><a id='lblMon'></a></td>
                <td ><input id="txtMon" type="text"  class="txt c1"/></td> 
            </tr>
            <tr>
                <td class="label1"><a id='lblAddr'></a></td>
                <td ><input id="txtPost"  type="text"  class="txt c2"/> </td>
                <td colspan='4' ><input id="txtAddr"  type="text" class="txt c2"/></td>
                <td class="label2"><a id='lblPrice'></a></td>
                <td ><input id="txtPrice"  type="text" class="txt num c2" /></td> 
            </tr>
            <tr>
                <td class="label1"><input id="btnCar" type="button" value='.' /></td>
                <td  ><input id="txtCarno" type="text"  class="txt c2"/></td>
                <td  ><input id="txtCar"  type="text" class="txt c2"/></td>
                <td class="label2"><a id='lblCarno2'></a></td>
                <td  colspan='2'><input id="txtCarno2"    type="text" class="txt c2"/></td> 
                <td class="label3"><a id='lblTranmoney'></a></td>
                <td><input id="txtTranmoney" type="text" class="txt num c1" /></td> 
            </tr>
            <tr>
                <td class="label1"><a id='lblMoney'></a></td>
                <td colspan='2'><input id="txtMoney" type="text" class="txt num c2" /></td> 
                <td class="label2" ><a id='lblTax'></a></td>
                <td><input id="txtTax" type="text" class="txt num c2" /></td>
                <td><select id="cmbTaxtype" class="txt c2"></select></td>
                <td class="label3"><a id='lblTotal'></a></td>
                <td ><input id="txtTotal" type="text" class="txt num c1" />
                </td> 
            </tr>
            <tr>
                <td class="label1"><a id='lblTotalus'></a></td>
                <td colspan='2'><input id="txtTotalus" type="text" class="txt num c2" /></td> 
                <td class="label2"><a id='lblWeight'></a></td>
                <td colspan='2' ><input id="txtWeight" type="text" class="txt num c2" /></td>
                <td class="label3"><input id='btnAccc' type="button" /></td>
                <td ><input id="txtAccno" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
                <td class="label1"><a id='lblMemo'></a></td>
                <td  colspan='5' ><input id="txtMemo"  type="text" class="txt c2"/></td> 
                <td class="label2"><a id='lblWorker'></a></td>
                <td ><input id="txtWorker"  type="text" class="txt c1"/></td> 
            </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
           <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblProductno'></a></td>
                <td align="center"><a id='lblUno'></a></td>
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
                <td style="width:10%; text-align:center"><input  id="txtProductno.*" type="text" style="width: 75%;"/>
                                       <input class="btn"  id="btnProductno.*" type="button" value='...' style=" font-weight: bold; width: 16%;" /></td>
                <td style="width:20%;"><input  id="txtProduct.*" type="text" class="txt c1" />
                <input  id="txtUno.*" type="text" class="txt c1"/></td>
                <td style="width:18%;"><input id="txtDime.*" type="text" style="width:25%;text-align:right;" />x
                                    <input id="txtWidth.*" type="text" style="width:25%;text-align:right;" />x
                                    <input id="txtLengthb.*" type="text" style="width:25%;text-align:right;" />
                                    <input id="txtSpec.*" type="text"  class="txt c1"/> </td>
                <td style="width:4%;"><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td style="width:5%;"><input id="txtMount.*" type="text" class="txt num c1" /></td>
                <td style="width:8%;"><input id="txtWeight.*" type="text" class="txt num c1" /></td>
                <td style="width:6%;"><input id="txtPrice.*" type="text"  class="txt num c1" /></td>
                <td style="width:8%;"><input id="txtTotal.*" type="text" class="txt num c1" />
                                      <input id="txtGweight.*" type="text" class="txt num c1" /></td>
                <td style="width:12%;"><input id="txtMemo.*" type="text" class="txt c1"/>
                <input id="txtOrdeno.*" type="text" style="width:65%;" />
                <input id="txtNo2.*" type="text" style="width:20%;" />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
