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
        q_tables = 's';   /// 定義為 Master-detail  架構 ， master= vcc   detail = vccs  使用資料表=vcc,vccs
        var q_name = "vcc";
        var q_readonly = ['txtAccno','txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtOrdeno','txtWorker']; // master 唯讀物件
        var q_readonlys = ['txtTotal', 'txtOrdeno', 'txtNo2']; // detail 唯讀物件
        var bbmNum = [['txtPrice', 10, 3], ['txtTranmoney', 11, 2], ['txtMoney', , , 1], ['txtTax', , , 1], ['txtTotal', , , 1], ['txtTotalus', , , 1]];  // master 允許 key 小數  [物件,整數位數,小數位數, comma Display]
        var bbsNum = [['txtPrice', 12, 3], ['txtMount', 9, 2, 1], ['txtTotal', , , 1]]; // detail 允許 key 小數  [物件,整數位數,小數位數, comma Display]
        var bbmMask = []; // post 後給值  master Mask
        var bbsMask = []; // post 後給值  detail Mask
        q_sqlCount = 6; 
        brwCount = 6; 
        brwCount2 = 11; 
        brwList = []; 
        brwNowPage = 0; 
        brwKey = 'datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定

        $(document).ready(function () {
            q_desc = 1;
            bbmKey = ['noa'];  /// 定義 master  key field
            bbsKey = ['noa', 'noq']; /// 定義 detail  key field

            q_brwCount();  // 計算 合適  brwCount 
            
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);   /// server 端捉取資料  q_gt( (1)table,(2) where or field , (3)top rows , (4)need qSys,qLang , 0=load , (5)gtPost_executeName , (6)r_accy); r_accy=年度
        });

        //////////////////   end Ready
        function main() {
            mainForm(1); // 1=最後一筆  0=第一筆
        }  ///  end Main()
        /// aPop[] 定義 textBox ,button 要開啟的視窗，autoComplete 欄位
        /// aPop[]用法 [ (1)textBox , (2)button, (3)table, (4)table field , (5)form textbox , (6).aspx ]);
        aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,tel,zip_fact,addr_fact,paytype,trantype', 'txtCustno,txtComp,txtTel,txtZipcode,txtAddr,txtPay,cmbTrantype', 'cust_b.aspx'],
                ['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtCarno', 'lblCar', 'car', 'noa,car', 'txtCarno,txtCar', 'car_b.aspx'],
                ['txtAcomp', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
                ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']
              );

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();  /// 載入系統參數  qSys , qLang
            bbmMask = [['txtDatea', r_picd]];   // master Mask
            q_mask(bbmMask);       /// bind mask function
            q_cmbParse("cmbTypea", q_getPara('vcc.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
            q_cmbParse("cmbStype", q_getPara('vcc.stype'));   //  q_getPara() = 捉取系統參數 vcc.stype 
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));   // q_cmbParse() = 將參數 置入 comboBox
            q_cmbParse("cmbCoin", q_getPara('sys.coin'));      /// q_cmbParse 會加入 fbbm[]，  fbbm=記錄所有 master txt???? ,cmb???? ,chk???
            q_cmbParse("combPay", q_getPara('vcc.paytype'));  // comb 未連結資料庫
            q_cmbParse("cmbTrantype", q_getPara('vcc.tran')); // q_cmbParse( object , values , 's'=detail);
            $('#btnOrdes').click(function () {
                btnOrdes();
            });

            $('#btnOrde').click(function () { q_pop('txtOrdeno', "orde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtOrdeno').val() + "';" + r_accy + '_' + r_cno, 'orde', 'noa', '', "92%", "1024px", q_getMsg('btnOrde'), true); });
            //  q_pop() == popWindow   (1)txt  (2)aspx ? FormPara  (3) field1  (4)field2 (5) width (6)  height  (7) title (8) Show_closeBtn   d4=false                (1)  (2)  (3)  (4) (5) (6)  (7)  (8)
            $('#btnAccc').click(function () {
                q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
            });
            $('#btnFunc').click(function () {
                //q_func('t3.func1', "3,4,5")
                //q_func('t4.func1', "3,4,5")
                q_gt('trans', "where=^^datea='100/01/03'^^", 0, 0, 0, "", r_accy);
            });
            $('#btnVcct').click(function(e) {
					q_box("vcct.aspx?;;;vccno='" + $('#txtNoa').val() + "'", 'vcct', "90%", "95%", q_getMsg("popVcct"));
				});
			$('#btnPacking').click(function(e) {
					q_box("packing_b.aspx?;;;vccno='" + $('#txtNoa').val() + "'", 'packing', "90%", "95%", q_getMsg("popPacking"));
			});
            $('#lblInvono').click(function(){
				t_where = '';
				t_invo = $('#txtInvono').val();
                if(t_invo.length > 0){
                	t_where = "noa='" + t_invo + "'";
                	q_box("invoice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('popInvo'));
                }
            });
            $('#txtFloata').change(function () {sum();});
        }

        ///   q_funcPost( server_function name , result) 
        function q_funcPost(t_func, result) {  /// 執行 q_exec() 呼叫 server 端 function 後， client 端所要執行的程式
            if (result.substr(0, 5) == '<Data') {    /// 如果傳回  table[]
                var Asss = _q_appendData('sss', '', true);   ///  _q_appendData( table , '' , new data 不保留舊資料)
                var Acar = _q_appendData('car', '', true);
                var Acust = _q_appendData('cust', '', true);
                alert(Asss[0]['namea'] + '^' + Acar[0]['car'] + '^' + Acust[0]['comp']);
            }
            else
                alert(t_func + '\r' + result); /// 如果傳回  string
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、訂單視窗  關閉時執行
            var ret;
            switch (b_pop) {
                case 'ordes':
                    if (q_cur > 0 && q_cur < 4) {   //  q_cur： 0 = 瀏覽狀態  1=新增  2=修改 3=刪除  4=查詢
                        b_ret = getb_ret();         ///  q_box() 執行後，選取的資料
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;   ///   q_gridAddRow()  資料列數增加至 grid
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2,txtPrice', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2,price'
                                                           , 'txtProductno,txtProduct,txtSpec');   /// 最後 aEmpField 不可以有【數字欄位】
                       /* for (i = 0; i < ret.length; i++) {
                            k = ret[i];  ///ret[i]  儲存 tbbs 指標
                            if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
                                $('#txtMount_' + k).val(b_ret[i]['notv']);
                                $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
                            }else {
                                $('#txtWeight_' + k).val(b_ret[i]['notv2']);   // divide0(a,b)   return a/b;
                                $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv2'], b_ret[i]['weight']));
                            }

                        }  /// for i*/
                    }
                    break;
                case q_name + '_s':  // 查詢視窗  關閉後  vcc_s.aspx
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  /// 資料下載後 ...
            var as;
            switch (t_name) {
                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
                case 'sss':
                    as = _q_appendData('sss', '', true);
            }  /// end switch
        }

        function btnOrdes() {
            var t_custno = trim($('#txtCustno').val());
            var t_where = '';
            if (t_custno.length > 0) {
                t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");  ////  sql AND 語法，請用 &&  
                t_where = t_where;
            }
            else {
                alert(q_getMsg('msgCustEmp'));
                return;
            }
            q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
        }   /// q_box()  開 視窗

        function btnOk() {   // 存檔 btnOk 按下
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('lblAcomp')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('D' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);   /// 實 際 寫 入 server DataBase
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('vcc_s.aspx', q_name + '_s', "500px", "550px", q_getMsg("popSeek"));
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
            for (var i = 0; i < q_bbsCount ; i++) {   // q_bbsCount 表身總列數
                if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    $('#txtUnit_' + i).focusout(function () { sum(); });    //  $('#txtUnit_' + j)  每列物件 id
                    //$('#txtWeight_' + i).focusout(function () { sum(); });
                    $('#txtPrice_' + i).focusout(function () { sum(); });
                    $('#txtMount_' + i).focusout(function () { sum(); });
                }
            } //j
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtCno').val('1');
            $('#txtAcomp').val(r_comp.substr(0, 2));
            $('#txtDatea').val(q_date());
            $('#cmbTypea').val('1');
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

        function wrServer(key_value) {  // 實 際 寫 入 server DataBase
            var i;

            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);  //重要：_btnOk(key_value, key1, key2, key3, t_noqLen, t_extString)   // t_extString =額外存檔字串 <xml>格式
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位    重要
            if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {  //不存檔條件
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
            for (var j = 0; j < q_bbsCount; j++) {
                t_unit = $('#txtUnit_' + j).val();   //  q_float() 傳回 textbox 數值
                //t_mount = (!t_unit || emp(t_unit) || trim(t_unit).toLowerCase() == 'kg' ? q_float('txtWeight_' + j) : q_float('txtMount_' + j));  // 計價量
                t_mount = q_float('txtMount_' + j);
                //t_weight = t_weight + dec(q_float('txtWeight_' + j)); // 重量合計
                $('#txtTotal_' + j).val(round(q_float('txtPrice_' + j) * dec(t_mount), 0));
                t1 = t1 + dec(q_float('txtTotal_' + j));
            }  // j

            $('#txtMoney').val(round(t1, 0));
            if (!emp($('#txtPrice').val()))
                $('#txtTranmoney').val(round(t_weight * dec(q_float('txtPrice')), 0));

            //$('#txtWeight').val(round(t_weight, 0));
            calTax();
            q_tr('txtTotalus' ,q_float('txtTotal')*q_float('txtFloata'));
        }

        function q_stPost() {
            if (q_cur == 1 || q_cur == 2) {
                abbm[q_recno]['accno'] = xmlString;   /// 存檔後， server 傳回 xmlString 
                //$('#txtAccno').val(xmlString);   /// 顯示 server 端，產生之傳票號碼
            }
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
            TEXT-ALIGN:  center
        }    
        .tbbm
        {
            FONT-SIZE: 12pt;
            COLOR: blue;
            TEXT-ALIGN: left;
            border-color: white; 
            font-size: medium;
            width:100%; border-collapse: collapse; background:#cad3ff;
        } 
        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
            font-size: medium;
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
       
      
        .style1
        {
            height: 26px;
        }
		.tbbm tr td .lbl.btn {
			color: #4297D7;
			font-weight: bolder;
			font-size: medium;
		}  
		.tbbm tr td .lbl.btn:hover {
			color: #FF8F19;
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
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
<body>
    <div id="dmain">
        <!--#include file="../inc/toolbar.inc"-->
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
                   <td align="center" id='typea=vcc.typea'>~typea=vcc.typea</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='custno comp,4'>~custno ~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
               <td class="label1"  align="right"><a id='lblType'></a></td>
               <td class="column1" >
               <select id="cmbTypea" style='width:100%;'> </select></td>
               <td class="column2" align='right' ><a id='lblStype'></a><select id="cmbStype" style='width:70%;'> </select></td>
               <td class="label2" align="right" ><a id='lblDatea'></a></td>
               <td class="column3"><input id="txtDatea" type="text"  style='width:97%;'/></td>
               <td class="column4" ><input id="btnOrde" type="button" value='.' style='width: auto; font-size:  medium;'  /></td>
               <td class="label3" align="right"><a id='lblNoa'></a></td>
               <td class="column2" ><input id="txtNoa"   type="text"  style='width:94%;' class='inputbox' /></td> 
            </tr>
     
            <tr>
               <td align="right" class="style2" ><a id="lblAcomp" class="lbl btn"></a></td>
               <td class="column1" ><input id="txtCno"  type="text" style='width:100%;' /></td>
               <td class="column2" ><input id="txtAcomp"    type="text"  style='width:100%;'/></td>
                <td align="right" class="style2" ><a id='lblFloata'></a></td>
                <td class="column3" ><select id="cmbCoin" style='width:100%'> </select></td>                 
                <td class="column4" ><input id="txtFloata" type="text" style='width:100%' /></td>                 
                <td align="right" class="style2"><a id='lblInvono' class="lbl"></a></td>
                <td class="column2"><input id="txtInvono"    type="text"  style='width:94%;'/></td> 
            </tr>

           <tr>
                <td align="right"><a id="lblCust" class="lbl btn"></a></td>
                <td ><input id="txtCustno" type="text" style='width:100%;'  /></td>
                <td ><input id="txtComp"  type="text" style='width:100%;'/></td>
                <td align="right"><a id='lblPay'></a></td>
                <td ><input id="txtPay" type="text" style='width:97%' /></td> 
                <td> <select id="combPay" style='width:100%' onchange='combPay_chg()'> </select></td> 
                <td align="right"><input id="btnOrdes" type="button" value='.' style='width: auto; font-size:  medium;'  /></td>
                <td><input id="txtOrdeno"  type="text"  style='width:94%' /></td> 
            </tr>

            <tr>
                <td align="right" class="style1" ><a id='lblTel'></a></td>
                <td colspan='2' class="style1"><input id="txtTel"    type="text"  style='width:100%;'/></td>
                <td align="right" class="style1"><a id='lblTrantype'></a></td>
                <td class="style1"><select id="cmbTrantype" style='width:100%'> </select></td>
                <td class="column4" ><input id="btnVcct" type="button" style='width: auto; font-size:  medium;'  /></td> 
                <td align="right" class="style1" ><a id='lblMon'></a></td>
                <td class="style1"><input id="txtMon" type="text" style='width:94%;'/></td> 
            </tr>

            <tr>
                <td align="right" ><a id='lblAddr'></a></td>
                <td ><input id="txtZipcode"  type="text"   style='width:100%;'/> </td>
                <td colspan='4' ><input id="txtAddr"  type="text"  style='width:100%;'/> </td>
                <td align="right" ><a id='lblPrice'></a></td>
                <td ><input id="txtPrice"    type="text" style="width:94% ;text-align:center;"/></td> 
            </tr>

            <tr>
                 <td align="right"><a id="lblCar" class="lbl btn"></a></td>
                <td  ><input id="txtCarno"    type="text"  style="width:100%"/></td>
                <td  ><input id="txtCar"    type="text" style="width:100%"/></td>
                <td align="right"><a id='lblCarno2'></a></td>
                <td  colspan='2'><input id="txtCarno2"  type="text" style="width:100%"/></td> 
                <td align="right"><a id='lblTranmoney'></a></td>
                <td><input id="txtTranmoney"    type="text"  style="width:94%;text-align:center;"/></td> 
            </tr>

            <tr>
                <td align="right"><a id="lblStore" class="lbl btn"></a></td>
                <td><input id="txtStoreno"    type="text"  style="width:100%" /></td> 
                <td><input id="txtStore"    type="text"  style="width:100%"/></td> 
                <td align="right"  ><a id="lblSales" class="lbl btn"></a></td>
                <td ><input id="txtSalesno" type="text"  style="width:100%"/></td>
                <td><input id="txtSales"    type="text"  style="width:100%"/></td>
                <td align="right"><input id="btnAccc" type="button" value='.' style='width: auto; font-size: medium;'  /><input id="btnFunc" type="button" value='Func' /></td>
                <td ><input id="txtAccno"    type="text"  style='width:94%;'/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblMoney'></a></td>
                <td colspan='2'><input id="txtMoney"    type="text" style='width:100%; text-align:center;'/></td> 
                <td align="right" ><a id='lblTax'></a></td>
                <td><input id="txtTax"    type="text"  style='width:100%; text-align:center;'/></td>
                <td><select id="cmbTaxtype" style="width:100%;" onchange="calTax();"> </select></td>
                <td align="right"><a id='lblTotal'></a></td>
                <td ><input id="txtTotal" type="text" style='width:94%; text-align:center;'/>
                </td> 
            </tr>
            <tr>
                <td align="right"><a id='lblTotalus'></a></td>
                <td colspan='2'><input id="txtTotalus"  type="text" style='width:100%; text-align:center;'/></td> 
                <!--<td align="right" ><a id='lblWeight'></a></td>
                <td ><input id="txtWeight"  type="text" style='width:100%; text-align:center;'/></td>-->
                <td class="column4" ><input id="btnPacking" type="button" style='width: auto; font-size:  medium;'  /></td>
                <td align="right"><a id='lblWorker'></a></td>
                <td ><input id="txtWorker"  type="text" style='width:94%; text-align:center;'/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblMemo'></a></td>
                <td  colspan='7' ><input id="txtMemo"  type="text" style="width:100%;"/></td> 
            </tr>
        </table>
        </div>


        <div class='dbbs'>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblProductno_s'></a></td>
                <td align="center"><a id='lblProduct_s'></a></td>
                <td align="center"><a id='lblUnit_s'></a></td>
                <td align="center"><a id='lblMount_s'></a></td>
                <!--<td align="center"><a id='lblWeight_s'></a></td>-->
                <td align="center"><a id='lblPrice_s'></a></td>
                <td align="center"><a id='lblTotal_s'></a></td>
                <td align="center"><a id='lblMemo_s'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td style="width:10%; text-align:center"><input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
                	<input class="txt"  id="txtProductno.*" type="text" style="width:75%;" /></td>
                <td style="width:20%;"><input class="txt" id="txtProduct.*" type="text"  style="width:98%;" />
                </td>
                <td style="width:4%;"><input class="txt" id="txtUnit.*" type="text" style="width:94%;"/></td>
                <td style="width:5%;"><input class="txt" id="txtMount.*" type="text" style="width:94%; text-align:right;"/></td>
                <!--<td style="width:8%;"><input class="txt" id="txtWeight.*" type="text" style="width:96%; text-align:right;"/></td>-->
                <td style="width:6%;"><input class="txt" id="txtPrice.*" type="text"  style="width:96%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtTotal.*" type="text" style="width:96%; text-align:right;"/></td>
                <td style="width:12%;"><input class="txt" id="txtMemo.*" type="text" style="width:98%;"/>
                <input class="txt" id="txtOrdeno.*" type="text" style="width:65%;" />
                <input class="txt" id="txtNo2.*" type="text" style="width:20%;" />
                <input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
      </div>
</body>
</html>

