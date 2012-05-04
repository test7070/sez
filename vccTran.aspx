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
        var q_name = "vcc";
        var decbbs = [ 'money','total', 'weight', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'gweight'];
        var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney'];
        var q_readonly = ['txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtOrdeno'];//, 'txtAccno','txtMon','txtSales']; 
        var q_readonlys= ['txtTotal','txtOrdeno','txtNo2'];
        var bbmNum = [['txtPrice', 10, 3], ['txtTranmoney', 11, 2], ['txtMoney', , , 1], ['txtTax', , , 1], ['txtTotal', , , 1]];  // 允許 key 小數
        var bbsNum = [['txtPrice', 12, 3], ['txtWeight', 11, 2,1], ['txtMount', 9, 2,1]];
        var bbmMask = []; // post 後給值
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],['txtCustno', 'btnCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],['txtPartno2', 'btnPart2', 'part', 'noa,part', 'txtPartno2,txtPart2', 'part_b.aspx'],['txtSalesno2', 'btnSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx'],['txtPartno', 'btnPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],['txtSalesno', 'btnSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],['txtProductno_', 'btnProductno_', 'ucc', 'noa,productno', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];

            q_brwCount();  // 計算 合適  brwCount 
            q_gt(q_name, q_content, q_sqlCount, 1)  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
        });

        //////////////////   end Ready
       function main() {
           if (dataErr) {  /// 載入資料錯誤
               dataErr = false;
               return;
           }

            mainForm(1); // 1=最後一筆  0=第一筆
        }  ///  end Main()

    /*    aPop = [['txtCustno' , 'btnCust' , 'cust' , 'noa,comp,tel,zip_fact,addr_fact,pay,trantype', 'txtCustno,txtComp,txtTel,txtZipcode,txtAddr,txtPay,cmbTrantype','cust_b.aspx'],
                ['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtCarno'  , 'btnCar'  , 'car'  , 'noa,car'  , 'txtCarno,txtCar' , 'car_b.aspx'],
                ['txtAcomp', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
                ['txtSalesno', 'btnSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];*/

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('vcc.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
            q_cmbParse("cmbStype", q_getPara('vcc.stype'));
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));   
            q_cmbParse("combPay", q_getPara('vcc.pay'));  // comb 未連結資料庫
            q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));
			$('#btnAccc').parent().click(function(e) {
                    q_box("accc.aspx?" + $('#txtAccno').val() + "'", 'accc', "850px", "600px", q_getMsg("popAccc"));
                });
           
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
            }  /// end switch
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
 
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase()+bbmKey[0].substr( 1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product']) {  //不存檔條件
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

            //format();

        }
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);

            //format();
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
        #dmain{overflow:hidden;}
		 .dview{float:left;width:25%;}
		 .tview{margin:0;padding:2px;border:1px black double;border-spacing:0;font-size:16px;background-color:#FFFF66;color:blue;}
		 .tview td{padding:2px;text-align:center;border:1px black solid;}
		 .dbbm{float:left;width:73%;margin:-1px;border:1px black solid;border-radius:5px;}
		 .tbbm{padding:0px;border:1px white double;border-spacing:0;border-collapse:collapse;font-size:16px;color:blue;background:#cad3ff;width:100%;}
		 .tbbm tr{height:35px;}
		 
		 .td1, .td3, .td5, .td7{width: 11%; text-align: right;}
		 .td2, .td4, .td6, .td8{width: 14%;}
		 .tbbm tr td span{float:right;display:block;width:8px;height:10px;}
		 .tbbm tr td .lbl{float:right;color:blue;font-size:16px;}
		 .tbbm tr td .lbl.btn{color:#4297D7;font-weight:bolder;}
		 .tbbm tr td .lbl.btn:hover{color:#FF8F19;}
		 .tbbm tr td .txt.c1{width:100%;float:left;}
		 .tbbm tr td .txt.c2{width:50%;float:left;}
		 .tbbm tr td .txt.c3{width:47%;float:left;}
		 .tbbm tr td .txt.c4{width:53%;float:left;}
		 .tbbm tr td .txt.c5{width:35%;float:left;}
		 .tbbm tr td .txt.c6{width:64%;float:left;}
		 .tbbm tr td .txt.num{text-align:right;}
		 .txt.c7{width:96%;text-align: right;}
		 .txt.c8{width:98%;}
		
		 .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:16px;color:blue;background:#cad3ff;width:100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
		
		 .dbbm input[type="button"]{float:right;width:auto;font-size: medium;}
		 .tbbm tr td{margin:0px -1px;padding:0;}
		 .tbbm tr td input[type="text"]{border-width:1px;padding:0px;margin:-1px;}
		 .tbbm tr td select{border-width:1px;padding:0px;margin:-1px;width: 98%;}
      
    </style>
</head>
<body>
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain'>
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:5%"><a id='vewType'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='type'>~type</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='custno comp,4'>~custno ~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr class="tr1">
               <td class="td1" ><span> </span><a id='lblType'></a></td>
               <td class="td2" >
               <%--<input id="txtType" type="text"  style='width:0%; visibility:collapse;'/>--%>
               <select id="cmbTypea" class="txt c1"></select></td>
               <td class="td3"><span> </span><a id='lblStype'></a></td>
               <td class="td4"><select id="cmbStype" class="txt c1"></select></td>
               <td class="td5"><span> </span><a id='lblDatea'></a></td>
               <td class="td6"><input id="txtDatea" type="text"  class="txt c1"/></td>
               <td class="td7"><span> </span><a id='lblNoa'></a></td>
               <td class="td8"><input id="txtNoa"   type="text" class="txt c1"/></td> 
            </tr> 
            <tr class="tr2">
               <td class="td1"><span> </span><input id="btnAcomp" type="button" value='.' /></td>
               <td class="td2"><input id="txtCno"  type="text" class="txt c5" />
               <input id="txtAcomp"    type="text" class="txt c6"/></td>
               <td class="td3"><span> </span><a id='lblMon' style="font-size: 14px;"></a></td>
               <td class="td4"><input id="txtMon"    type="text" class="txt c1"/></td>                 
               <td class="td5"><span> </span><a id='lblInvono'></a></td>
               <td class="td6"><input id="txtInvo" type="text" class="txt c1"/></td> 
            </tr>
           <tr class="tr3">
                <td class="td1"><span> </span><input id="btnCust" type="button" value='.' /></td>
                <td class="td2"><input id="txtCustno" type="text" class="txt c5"/>
               <input id="txtComp"  type="text" class="txt c6"/></td>
                <td class="td3"><span> </span><a id='lblPay'></a></td>
                <td class="td4"><input id="txtPay" type="text" class="txt c2"/> 
                <select id="combPay" class="txt c2" ></select></td>
                <td class="td5"><span> </span><input id="btnAccc" type="button" value='.' /></td>
                <td class="td6"><input id="txtAccno"  type="text" class="txt c1"/></td>  
            </tr>
            <tr class="tr4">
                <td class="td1"><span> </span><a id='lblTel'></a></td>
                <td class="td2"><input id="txtTel" type="text" class="txt c1"/></td>
                <td class="td3"><span> </span><a id='lblTrantype'></a></td>
                <td class="td4"><select id="cmbTrantype" class="txt c1"></select></td> 
                <td class="td5"><span> </span><a id='lblWorker'></a></td>
                <td class="td6"><input id="txtWorker"  type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr5">
                <td class="td1"><span> </span><a id='lblAddr'></a></td>
                <td class="td2"><input id="txtZipcode"  type="text" class="txt c1"/> </td>
                <td class="td3" colspan='4' ><input id="txtAddr"  type="text" class="txt c1"/> </td>
            </tr>
            <tr class="tr6">
                <td class="td1"><span> </span><input id="btnPart" type="button" value='.' /></td>
                <td class="td2"><input id="txtPartno"    type="text" class="txt c5"/>
               <input id="txtPart"    type="text" class="txt c6"/></td>
                <td class="td3"><span> </span><input id="btnSales" type="button" value='.' /></td>
                <td class="td4"><input id="txtSalesno" type="text" class="txt c5"/>
                <input id="txtSales"  type="text" class="txt c6"/></td>
                <td class="td5"><span> </span><a id='lblTranmoney'></a></td>
                <td class="td6"><input id="txtTranmoney"  type="text" class="txt num c1" /></td> 
            </tr>
            <tr class="tr7">
                <td class="td1"><span> </span><input id="btnPart2" type="button" value='.' /></td>
                <td class="td2"><input id="txtPartno2"    type="text" class="txt c5"/> 
                <input id="txtPart2"    type="text" class="txt c6"/></td> 
                <td class="td3"><span> </span><input id="btnSales2" type="button" value='.' /></td>
                <td class="td4"><input id="txtSalesno2" type="text" class="txt c5"/>
                <input id="txtSales2"    type="text" class="txt c6"/></td>
                <td class="td5"><span> </span><a id='lblOutsource'></a></td>
                <td class="td6" ><input id="txtOutsource"    type="text" class="txt num c1" />
                </td> 
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblMoney'></a></td>
                <td class="td2"><input id="txtMoney"    type="text" class="txt num c1"/></td> 
                <td class="td3"><span> </span><a id='lblTax'></a></td>
                <td class="td4"><input id="txtTax" type="text" class="txt num c3" />
                <select id="cmbTaxtype" class="txt c4"></select></td>
                <td class="td5"><span> </span><a id='lblTotal'></a></td>
                <td class="td6"><input id="txtTotal" type="text" class="txt num c1"/></td> 
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblMemo'></a></td>
                <td  class="td2" colspan='7' ><input id="txtMemo"  type="text" class="txt c1"/></td> 
            </tr>
        </table>
        </div>
        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
                <td align="center"><a id='lblProductno'></a></td>
                <td align="center"><a id='lblProduct'></a></td>
                <td align="center"><a id='lblUnit'></a></td>
                <td align="center"><a id='lblMount'></a></td>
                <td align="center"><a id='lblPrices'></a></td>
                <td align="center"><a id='lblTotals'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td style="width:10%;"><input  id="txtProductno.*"type="text" style="width: 80%;"/><input id="btnProductno.*" type="button" value=".." style="width: 15%;" /></td>
                <td style="width:20%;"><input id="txtProduct.*" type="text" class="txt c8"/></td>
                <td style="width:4%;"><input id="txtUnit.*" type="text" class="txt c8"/></td>
                <td style="width:5%;"><input id="txtMount.*" type="text" class="txt c7"/></td>
                <td style="width:6%;"><input  id="txtPrice.*" type="text" class="txt c7"/></td>
                <td style="width:8%;"><input  id="txtTotal.*" type="text" class="txt c7"/></td>
                <td style="width:12%;"><input id="txtMemo.*" type="text" class="txt c8"/><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
