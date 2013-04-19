<%@ Page Language="C#" AutoEventWireup="true" %>
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
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "workb";
        var decbbs = ['weight', 'mount', 'gmount', 'emount', 'errmount', 'born'];
        var decbbm = ['mount', 'inmount', 'errmount', 'rmount', 'price', 'hours'];
        var q_readonly = ['txtWorker','txtNoa'];
        var q_readonlys = ['txtOrdeno', 'txtNo2', 'txtNoq'];
        var bbmNum = [];  // 允許 key 小數
        //var bbmNum_comma = [];
        var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
        //var bbsNum_comma = []; 
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = '';
        //ajaxPath = ""; // 只在根目錄執行，才需設定

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];

            q_brwCount();  // 計算 合適  brwCount 

            if (!q_gt(q_name, q_content, q_sqlCount, 1))  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
                return;

        });

        //////////////////   end Ready
       function main() {
           if (dataErr)  /// 載入資料錯誤
           {
               dataErr = false;
               return;
           }
            q_mask(bbmMask);

            mainForm(1); // 1=最後一筆  0=第一筆

            $('#txtDatea').focus();
            
        }  ///  end Main()

        function pop(form) {
            b_pop = form;
            switch (form) {
                case 'cust': q_pop('txtCustno', 'cust_b.aspx', 'cust', 'noa', 'comp', "60%", "650px", q_getMsg('popCust')); break;
                case 'ucc': q_pop('txtProductno_' + b_seq, 'ucc_b.aspx', 'ucc', 'noa', 'product', "70%", "650px", q_getMsg('popUcc')); break;
                case 'store': q_pop('txtStoreno', 'store_b.aspx', 'store', 'noa', 'store', "60%", "650px", q_getMsg('popStore')); break;
                case 'station': q_pop('txtStationno', 'station_b.aspx', 'station', 'noa', 'station', "60%", "650px", q_getMsg('popStation')); break;
            }
        }

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd], ['txtDatea', r_picd]];
            q_mask(bbmMask);
            $('#btnQuat').click(function () { btnquat(); });
            $('#btnStore').click(function () { pop('store'); }); /// 接 q_browFill()
            $('#btnStore').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtStoreno").change(function () { q_change($(this), 'store', 'noa', 'noa,store'); }); /// 接 q_gtPost()

            $('#btnStation').click(function () { pop('station'); }); /// 接 q_browFill()
            $('#btnStation').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtStationno").change(function () { q_change($(this), 'station', 'noa', 'noa,station'); }); /// 接 q_gtPost()
        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case 'tgg':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtTggno,txtComp,txtTel,txtPost,txtAddr,txtPay,cmbTrantype', 'noa,comp,tel,post_fact,addr_fact,pay,trantype');
                    break;

                case 'ucc':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtProductno_' + b_seq + ',txtProduct_' + b_seq, ret, 'noa,product');
                    break;


                case 'store':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtStoreno,txtStore', ret, 'noa,store');
                    break;

                case 'station':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtStationno,txtStation', ret, 'noa,station');
                    break;


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
                case 'ucc':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtProductno_' + b_seq + ',txtProduct_' + b_seq + ',txtUnit_' + b_seq, 'noa,product,unit');
                    break;

                case 'store':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtStoreno,txtStore', 'noa,store');
                    break;
                case 'station':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtStationno,txtStation', 'noa,station');
                    break;

                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
//        function btnquat() {
//            var t_custno = trim($('#txtCustno').val());
//            var t_where='';
//            if (t_custno.length > 0) {
//                t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");  ////  sql AND 語法，請用 &&  
//                t_where =  t_where ;
//            }
//            else {
//                alert(q_getMsg('msgCustEmp'));
//                return;
//            }

//            q_box('ordes_b.aspx', 'ordes;' + t_where , "95%", "650px", "報價視窗");
//        }

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
                q_gtnoa(q_name, replaceAll('B' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('workb_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
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

            } //j
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

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product'] ) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];
            as['custno'] = abbm2['custno'];
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

            //format();
        }
		/*
        function format() {  ////  主要為數字 comma
            var i;

            q_format(bbmNum_comma, bbmNum);   /// 顯示 , keyin 只為了小數點顯示

            q_formats(bbsNum_comma, bbsNum);   /// 顯示 , keyin 只為了小數點顯示
            q_init = 0;
        }
        */
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
            width: 10%;
        }
        .column2
        {
            width: 10%;
        }      
        .column3
        {
            width: 10%;
        }   
        .column4
        {
            width: 8%;
        }           
         .label1
        {
            width: 8%; text-align:right;
        }       
        .label2
        {
            width: 10%; text-align:right;
        }
        .label3
        {
            width: 10%; text-align:right;
        }
       
      
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height: 98%">
<!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewStation'></a></td>
                <td align="center" style="width:40%"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='station'>~station</td>
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr><td class='label1'><a id="lblDatea" ></a></td><td><input id="txtDatea" maxlength='30' type="text" style='width:45%;'/></td>
            <td class='label2'><a id="lblNoa" ></a></td><td> <input id="txtNoa"   type="text"  maxlength='20'   style='width:98%;'/></td> </tr>
        <tr>
        <td class='label1'>
        	<input id="btnStation" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
        	<td>
        		<input id="txtStationno" maxlength='30' type="text"  style='width:45%;'/>
        		<input id="txtStation" maxlength='90' type="text"  style='width:48%;'/>
        	</td>
            <td class='label2'><a id="lblWorkno" ></a></td>
            <td><input id="txtWorkno" maxlength='30' type="text"  style='width:98%;'/></td></tr>

        <tr>        
            <td align="right"><input id="btnStore" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
            <td><input id="txtStoreno"    type="text"  maxlength='10' style="width:45%" /><input id="txtStore"    type="text" maxlength='30' style="width:48%"/></td> 
            <td class='label3'><a id="lblWorker" ></a></td><td><input id="txtWorker" maxlength='20' type="text"  style='width:98%;'/></td></tr>

        <tr>
        <td class='label1'><a id="lblMemo" ></a></td><td colspan='3'><input id="txtMemo" maxlength='90' type="text"  style='width:99%;'/></td></tr>
        </table>
        </div>

        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblProductnos'></a></td>
                <td align="center"><a id='lblProducts'></a></td>
                <td align="center"><a id='lblUnit'></a></td>
                <td align="center"><a id='lblBorn'></a></td>
                <td align="center"><a id='lblMounts'></a></td>
                <td align="center"><a id='lblErrmount'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td style="width:15%;"><input class="txt"  id="txtProductno.*" maxlength='30'type="text" style="width:80%;" /><input class="btn"  id="btnProductno.*" type="button" value='...' style="width:16%;"  /></td>
                <td style="width:25%;"><input class="txt" id="txtProduct.*" type="text" maxlength='90' style="width:98%;" /></td>
                <td style="width:4%;"><input class="txt" id="txtUnit.*" type="text" maxlength='10' style="width:94%;"/></td>
                <td style="width:10%;"><input class="txt" id="txtBorn.*" type="text" maxlength='10' style="width:94%; text-align:right"/></td>
                <td style="width:12%;"><input class="txt" id="txtMount.*" type="text" maxlength='10' style="width:94%; text-align:right"/></td>
                <td style="width:10%;"><input class="txt" id="txtErrmount.*" type="text" maxlength='10' style="width:94%; text-align:right"/></td>
                <td style="width:12%;"><input class="txt" id="txtMemo.*" type="text" maxlength='90' style="width:98%;"/>
                <input class="txt" id="txtOrdeno.*" type="text" maxlength='30' style="width:65%;" />
                <input class="txt" id="txtNo2.*" type="text" maxlength='5' style="width:20%;" />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
    
    </form>
</body>
</html>
