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
        var q_name = "uca";
        var decbbs = ['weight', 'uweight', 'price'];
        var decbbm = ['weight', 'days', 'mount', 'wages', 'makes', 'mechs', 'trans', 'molds', 'packs', 'uweight', 'price'];
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];  // 允許 key 小數
        var bbsNum = [['txtMount', 12, 3], ['txtWeight', 11, 2], ['txtHours', 9, 2]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'odate';
        //ajaxPath = ""; // 只在根目錄執行，才需設定

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];

            q_brwCount();  // 計算 合適  brwCount 

             $('#txtProduct')[0].style['width'] = $('#txtEngpro')[0].style['width'];
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

            mainForm(0); // 1=最後一筆  0=第一筆

            $('#txtNoa').focus();
            
        }  ///  end Main()

        function pop(form) {
            b_pop = form;
            switch (form) {
                case 'tgg': q_pop('txtTggno', 'tgg_b.aspx', 'tgg', 'noa', 'comp', "60%", "650px", q_getMsg('popTgg')); break;
                case 'store': q_pop('txtStoreno', 'store_b.aspx', 'store', 'noa', 'store', "60%", "650px", q_getMsg('popStore')); break;
                case 'ucc': q_pop('txtProductno_' + b_seq, 'ucc_b.aspx', 'ucc', 'noa', 'product', "70%", "650px", q_getMsg('popUcc')); break;
            }
        }

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtKdate', r_picd],['txtWdate', r_picd], ['txtOdate', r_picd]];  

			q_cmbParse("cmbTypea", q_getPara('uca.typea')); // 需在 main_form() 後執行，才會載入 系統參數  

            $('#btnTgg').click(function () { pop('tgg'); });   /// 接 q_browFill()
            $('#btnTgg').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtTggno").change(function () { q_change($(this), 'tgg', 'noa', 'noa,comp'); }); /// 接 q_gtPost()

        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case 'tgg':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtTggno,txtComp', ret, 'noa,comp');
                    break;

                case 'ucc':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtProductno_' + b_seq + ',txtProduct_' + b_seq, ret, 'noa,product');
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
                    q_changeFill(t_name, 'txtTggno,txtComp', 'noa,comp');
                    break;

                case 'ucc':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtProductno_' + b_seq + ',txtProduct_' + b_seq + ',txtUnit_' + b_seq, 'noa,product,unit');
                    break;

                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtProduct', q_getMsg('MsgProductEmp')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('Q' + $('#txtOdate').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('uca_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
                $('#txtMount_' + j).focusout(function () { sum(); });

            } //j
        }

        function btnIns() {
            _btnIns();
            
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
            as['odate'] = abbm2['odate'];

            if (!emp(abbm2['datea']))  /// 預交日
                as['datea'] = abbm2['datea'];

            as['custno'] = abbm2['custno'];

            if (!as['enda'])
                as['enda'] = 'N';
            t_err ='';
            if (as['price'] != null && ( dec( as['price']) > 99999999 || dec( as['price']) < -99999999)) 
                t_err = '單價異常='+as['price']+'\n' ;

            if (as['total'] != null && ( dec( as['total']) > 999999999 || dec( as['total']) < -99999999))
                t_err = '金額異常=' + as['total'] + '\n';

            
            if (t_err) {
                alert(t_err)
                return false;
            }
            
            return true;
        }

        function sum() {

        }
		/*
        function format() {  ////  主要為數字 comma
            var i;

            q_format(bbmNum_comma, bbmNum);   /// 顯示 , keyin 只為了小數點顯示

            q_format(bbsNum_comma, bbsNum);   /// 顯示 , keyin 只為了小數點顯示
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
            width: 12%;
        }
        .column2
        {
            width: 18%;
        }      
        .column3
        {
            width: 18%;
        }   
        .column4
        {
            width: 8%;
        }           
         .label1
        {
            width: 13%; text-align:right;
        }       
        .label2
        {
            width: 13%; text-align:right;
        }
        .label3
        {
            width:10%; text-align:right;
        }
      
      
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%">
        <!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewProduct'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='product spec'>~product ~spec</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
        	<td class="label1"><a id='lblNoa'></a></td>
        	<td class='column1'><input  type="text" style="width:100%" id="txtNoa" /></td>
        	<td class="label2"><a id='lblKdate'></a></td>
        	<td class='column2'><input  type="text" id="txtKdate" style="width:100%"/></td>
        	<td class='label3'><a id='lblWdate'></a></td>
        	<td class='column3'><input  type="text" id="txtWdate" style="width:100%"/></td>
        </tr>
        <tr><td class="label1"><a id='lblType'></a></td><td><select id="cmbTypea" style='width:100%;'/></td><td  class="label2"><a id='lblProduct'></a></td><td colspan='3'><input  type="text" id="txtProduct" style="width:100%" /></td></tr>
        <tr><td class="label1"><a id='lblEngprono'></a></td><td><input  type="text" id="txtEngprono"  style="width:100%"/></td><td class="label2"><a id='lblEngpro'></a></td><td class='column2'  colspan='3'><input  type="text" id="txtEngpro" style="width:100%"/></td></tr>
        <tr><td class="label1"><a id='lblProcess'></a></td><td><input  type="text" id="txtProcessNo"  style="width:45%"/><input  type="text" id="txtProcess"  style="width:45%"/></td><td class="label2"><a id='lblSpec'></a></td><td colspan='3'><input  type="text" id="txtSpec"  style="width:100%"/></td></tr>
        <tr><td class="label1"><a id='lblMold'></a></td><td><input  type="text" id="txtMoldno" style="width:45%" /><input  type="text" id="txtMold" style="width:45%" /></td> <td class="label2"><a id='lblTgg'></a></td><td><input  type="text" id="txtTggno"  style="width:100%"/></td><td colspan='2'><input  class="label3" type="text" id="txtComp"   style="width:100%"/></td></tr>
        <tr><td class="label1"><a id='lblStation'></a></td><td><input  type="text" id="txtStationno"  style="width:45%"/><input  type="text" id="txtStation"  style="width:45%"/></td><td class="label2"><a id='lblDays'></a></td><td><input  type="text" id="txtDays"  style="width:100%"/></td><td class="label3"><a id='lblBadperc'></a></td><td class="column3"><input  type="text" id="txtBadperc"  style="width:100%"/></td></tr>
        <tr><td class="label1"><a id='lblMemo'></a></td><td colspan='5'><input  type="text" id="txtMemo"  style="width:100%"/></td></tr>
        <tr><td class="label1"><a id='lblMechs'></a></td><td><input  type="text" id="txtMechs"  style="width:100%"/></td><td class="label2"><a id='lblMakes'></a></td><td><input  type="text" id="txtMakes"  style="width:100%"/></td><td class="label3"><a id='lblPacks'></a></td><td><input  type="text" id="txtPacks" style="width:100%" /></td></tr>        
        <tr><td class="label1"><a id='lblMolds'></a></td><td><input  type="text" id="txtMolds" style="width:100%" /></td><td class="label2"><a id='lblWages'></a></td><td><input  type="text" id="txtWages" style="width:100%" /></td><td class="label3"><a id='lblTrans'></a></td><td><input  type="text" id="txtTrans"  style="width:100%"/></td></tr>
        </table>
        </div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
           <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblProductno'></a></td>
                <td align="center"><a id='lblProducts'></a></td>
                <td align="center"><a id='lblUnit'></a></td>
                <td align="center"><a id='lblMount'></a></td>
                <td align="center"><a id='lblWeights'></a></td>
                <td align="center"><a id='lblHours'></a></td>
                <td align="center"><a id='lblTd'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;">
                	<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
                </td>
                <td style="width:10%; text-align:center">
                	<input class="txt"  id="txtProductno.*" maxlength='30' type="text" style="width:95%;" />
                    <input class="btn"  id="btnProductno.*" type="button" value='...' style=" font-weight: bold;" />
                </td>
                <td style="width:20%;">
                	<input class="txt" id="txtProduct.*" type="text" maxlength='90' style="width:98%;" />
                	<input class="txt" id="txtSpec.*" type="text" maxlength='90' style="width:98%;" />
                </td>
                <td style="width:4%;">
                	<input class="txt" id="txtUnit.*" type="text" maxlength='10' style="width:94%;"/>
                </td>
                <td style="width:5%;">
                	<input class="txt" id="txtMount.*" type="text" maxlength='20' style="width:94%; text-align:right;"/>
                </td>
                <td style="width:8%;">
                	<input class="txt" id="txtWeight.*" type="text" maxlength='20' style="width:96%; text-align:right;"/>
                </td>
                <td style="width:6%;">
                	<input class="txt" id="txtHours.*" type="text"  maxlength='20' style="width:96%; text-align:right;"/>
                </td>
                <td style="width:8%;">
                	<input class="txt" id="txtTd.*" type="text" maxlength='20' style="width:96%;"/>
                </td>
                <td style="width:12%;">
                	<input class="txt" id="txtMemo.*" type="text" maxlength='90' style="width:98%;"/>
                	<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
                </td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
    
    </form>
</body>
</html>
