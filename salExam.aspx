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
        var q_name = "salexam";
        var q_readonly = ['txtNoa','txtDatea'];
        var q_readonlys = [];
        var bbmNum = [];  // 允許 key 小數
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(['txtSssno_', 'lblSssno', 'sss', 'noa,namea', 'txtSssno_,txtNamea_', 'sss_b.aspx']
				,['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']);
		
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  // 計算 合適  brwCount 
            q_gt(q_name, q_content, q_sqlCount, 1)
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
        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtYear', '999']];
            q_mask(bbmMask);

            $('#txtYear').val(q_date().substr(0,3));
            q_cmbParse("cmbPerson", ('').concat(new Array( '本國','日薪')));
            $('#btnIndata').click(function() {
            	var t_where = "where=^^ person='"+$('#cmbPerson').find("option:selected").text()+"' and partno ='"+$('#txtPartno').val()+"' and noa!='Z001' and noa!='010132'^^";
            	q_gt('sss', t_where , 0, 0, 0, "", r_accy);
            });
                  
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
            	case 'sss':
            		var as = _q_appendData("sss", "", true);
            			q_gridAddRow(bbsHtm, 'tbbs', 'txtSssno,txtNamea,txtPart', as.length, as, 'noa,namea,part', '');
            		break;
                case q_name: 
                	if (q_cur == 4)   // 查詢
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

            q_box('salexam_s.aspx', q_name + '_s', "500px", "250px", q_getMsg("popSeek"));
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
            if (!as['namea']) {  //不存檔條件
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
                width: 90%;
                float: left;
            }
            .txt.c2 {
                width: 25%;
                float: right;
            }
            .txt.c3 {
                width: 73%;
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
                width: auto;
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
        .tbbs
        {
            font-size: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
           width: 350%;
        }  
        
        
        .st1
        {
            width: 2%; 
        }
        .st2
        {
            width: 1.5%;
        }      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewYear'></a></td>
                <td align="center" style="width:25%"><a id='vewPart'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='year'>~year</td>
                  	<td align="center" id='part'>~part</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblYear" class="lbl"> </a></td>
            <td class="td4"><input id="txtYear" type="text" class="txt c1"/></td> 
            <td class='td5'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class="td6"><input id="txtDatea" type="text" class="txt c1"/></td> 
        </tr>
        <tr>
        	<td class="td1"><span> </span><a id="lblPerson" class="lbl"></a></td>
            <td class="td2"><select id="cmbPerson" class="txt c1"></select></td>
            <td class="td3"><span> </span><a id="lblPart" class="lbl btn"></a></td>
            <td class="td4">
            	<input id="txtPartno" type="text" class="txt c2"/>
            	<input id="txtPart" type="text" class="txt c3"/>
            </td>
            <td class='td5'><input id="btnIndata" type="button" style="width: auto;font-size: medium;"/></td>
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
            <td class="td2" colspan="6"><textarea id="txtMemo" cols="10" rows="5" style="width: 95%;height: 50px;"> </textarea></td>
        </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td class="st2" align="center"><a id='lblSssno'> </a></td>
                <td class="st1" align="center"><a id='lblNamea'> </a></td>
                <td class="st1" align="center"><a id='lblMon'> </a></td>
                <td class="st1" align="center"><a id='lblBase'> </a></td>
                <td class="st2" align="center"><a id='lblQpoint1'> </a></td>
                <td class="st2" align="center"><a id='lblQpoint2'> </a></td>
                <td class="st2" align="center"><a id='lblQpoint'> </a></td>
                <td class="st2" align="center"><a id='lblPoint1'> </a></td>
                <td class="st1" align="center"><a id='lblTot_person'> </a></td>
                <td class="st1" align="center"><a id='lblTot_sick'> </a></td>
                <td class="st1" align="center"><a id='lblTot_leave'> </a></td>
                <td class="st1" align="center"><a id='lblTot_late'> </a></td>
                <td class="st1" align="center"><a id='lblTot_forget'> </a></td>
                <td class="st2" align="center"><a id='lblXcountx'> </a></td>
                <td class="st2" align="center"><a id='lblMi_person'> </a></td>
                <td class="st2" align="center"><a id='lblMi_sick'> </a></td>
                <td class="st2" align="center"><a id='lblMi_leave'> </a></td>
                <td class="st2" align="center"><a id='lblMi_late'> </a></td>
                <td class="st2" align="center"><a id='lblMi_forget'> </a></td>
                <td class="st1" align="center"><a id='lblXpoint'> </a></td>
                <td class="st2" align="center"><a id='lblPoint2'> </a></td>
                <td class="st2" align="center"><a id='lblVcount1'> </a></td>
                <td class="st2" align="center"><a id='lblVcount2'> </a></td>
                <td class="st2" align="center"><a id='lblVcount3'> </a></td>
                <td class="st2" align="center"><a id='lblVcount4'> </a></td>
                <td class="st2" align="center"><a id='lblVcount5'> </a></td>
                <td class="st2" align="center"><a id='lblVcount6'> </a></td>
                <td class="st2" align="center"><a id='lblVcount7'> </a></td>
                <td class="st2" align="center"><a id='lblVpoint'> </a></td>
                <td class="st2" align="center"><a id='lblPoint'> </a></td>
                <td class="st2" align="center"><a id='lblClass'> </a></td>
                <td class="st1" align="center"><a id='lblQclass'> </a></td>
                <td class="st1" align="center"><a id='lblDay1'> </a></td>
                <td class="st1" align="center"><a id='lblDay2'> </a></td>
                <td class="st1" align="center"><a id='lblMoney1'> </a></td>
                <td class="st1" align="center"><a id='lblDay3'> </a></td>
                <td class="st1" align="center"><a id='lblMoney2'> </a></td>
                <td class="st1" align="center"><a id='lblMoney3'> </a></td>
                <td class="st2" align="center"><a id='lblTax'> </a></td>
                <td class="st1" align="center"><a id='lblTotal'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input  id="txtSssno.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtNamea.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtMon.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtBase.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtQpoint1.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtQpoint2.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtQpoint.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtPoint1.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTot_person.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTot_sick.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTot_leave.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTot_late.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTot_forget.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtXcountx.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtMi_person.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtMi_sick.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMi_leave.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMi_late.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMi_forget.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtXpoint.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtPoint2.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtVcount1.*"type="text" class="txt num c1" /></td>
                <td ><input  id="txtVcount2.*"type="text" class="txt num c1" /></td>
                <td ><input  id="txtVcount3.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtVcount4.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtVcount5.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtVcount6.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtVcount7.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtVpoint.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtPoint.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtClass.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtQclass.*"type="text" class="txt c1"/></td>
                <td ><input  id="txtDay1.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtDay2.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMoney1.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtDay3.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMoney2.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMoney3.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTax.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal.*" type="text" class="txt num c1" /><input id="txtNoq.*" type="hidden" /></td>               
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
