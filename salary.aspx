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
        var q_name = "salary";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  
            q_gt(q_name, q_content, q_sqlCount, 1)
        });

        //////////////////   end Ready
        function main() {
            if (dataErr) 
            {
                dataErr = false;
                return;
            }

            mainForm(1); 
        }  

        function mainPost() {
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
             q_cmbParse("cmbTypea", q_getPara('salary.typea'));
            
        }

        function q_boxClose(s2) { 
           var ret; 
            switch (b_pop) {                   case 'conn':

                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtGrpno,txtGrpname', ret, 'noa,comp');
                    break;
                
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
                case 'sss':  
                    q_changeFill(t_name, ['txtSalesno', 'txtSales'], ['noa', 'namea']);
                    break;

                case q_name: if (q_cur == 4)  
                        q_Seek_gtPost();

                    if (q_cur == 1 || q_cur == 2) 
                        q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salary_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPay_chg() {  
        }

        function bbsAssign() {  
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

        function bbsSave(as) {   
            if (!as['sno']) {  
                as[bbsKey[1]] = '';  
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

            }  
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 70%;
                float: right;
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
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:98% ;  
        } 
         .tbbs .td1
        {
            width: 1%;
        }
        .tbbs .td2
        {
            width: 2%;
        }
        
       
        
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:20%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewMon'></a></td>
            </tr>
             <tr>   
                  <td><input id="chkBrow.*" type="checkbox" style=' '/></td>                
                  <td align="center" id='mon'>~mon</td>                                     
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width:78%;float:left">
        <table class="tbbm"  id="tbbm"  border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class="td1"><span> </span><a id="lblMon" class="lbl"></a></td>
            <td class="td2"><input id="txtMon"  type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblType" class="lbl"></a></td>
            <td class="td4"><select id="cmbTypea" class="txt c1"></select></td>
            <td class="td5"><span> </span><a id="lblNoa" class="lbl"></a></td>
            <td class="td6"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class="td7"><span> </span><a id="lblHour" class="lbl"></a></td>
            <td class="td8"><input id="txtHour" type="text" class="txt num c1" /></td>
            <td class="td9"><span> </span><a id="lblBo_born" class="lbl"></a></td>
            <td class="td10"><input id="txtBo_born"  type="text" class="txt num c1" /></td>
            <td class="td11"><input id="btnInput" type="button" style="width: auto;font-size: medium;"/></td>
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblMoney" class="lbl"></a></td>
            <td class="td2"><input id="txtMoney"  type="text" class="txt num c1" /></td>
            <td class="td3"><span> </span><a id="lblBo_admin" class="lbl"></a></td>
            <td class="td4"><input id="txtBo_admin"  type="text" class="txt num c1" /></td>
            <td class="td5"><span> </span><a id="lblBo_duty" class="lbl"></a></td>
            <td class="td6"><input id="txtBo_duty"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblBo_full" class="lbl"></a></td>
            <td class="td8"><input id="txtBo_full"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblBo_over" class="lbl"></a></td>
            <td class="td2"><input id="txtBo_over"  type="text" class="txt num c1"/></td>
            <td class="td3"><span> </span><a id="lblBo_oth" class="lbl"></a></td>
            <td class="td4"><input id="txtBo_oth"  type="text" class="txt num c1"/></td>
            <td class="td5"><span> </span><a id="lblMi_person" class="lbl"></a></td>
            <td class="td6"><input id="txtMi_person"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblMi_full" class="lbl"></a></td>
            <td class="td8"><input id="txtMi_full"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblCh_lunch" class="lbl"></a></td>
            <td class="td2"><input id="txtCh_lunch"  type="text" class="txt num c1"/></td>
            <td class="td3"><span> </span><a id="lblCh_labor" class="lbl"></a></td>
            <td class="td4"><input id="txtCh_labor"  type="text" class="txt num c1"/></td>
            <td class="td5"><span> </span><a id="lblCh_health" class="lbl"></a></td>
            <td class="td6"><input id="txtCh_health"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblWelfare" class="lbl"></a></td>
            <td class="td8"><input id="txtWelfare"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblBorrow" class="lbl"></a></td>
            <td class="td2"><input id="txtBorrow"  type="text" class="txt num c1"/></td>
            <td class="td3"><span> </span><a id="lblTax" class="lbl"></a></td>
            <td class="td4"><input id="txtTax"  type="text" class="txt num c1"/></td>
            <td class="td5"><span> </span><a id="lblMi_oth" class="lbl"></a></td>
            <td class="td6"><input id="txtMi_oth" type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblTitle" class="lbl"></a></td>
            <td class="td8"><input id="txtTitle"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblPtotal" class="lbl"></a></td>
            <td class="td2"><input id="txtPtotal"  type="text" class="txt num c1"/></td>
            <td class="td3"><span> </span><a id="lblMi_total2" class="lbl"></a></td>
            <td class="td4"><input id="txtMi_total2"  type="text" class="txt num c1" /></td>
            <td class="td5"><span> </span><a id="lblTotal" class="lbl"></a></td>
            <td class="td6"><input id="txtTotal"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblWorker" class="lbl"></a></td>
            <td class="td8"><input id="txtWorker" type="text" class="txt c1"/></td>
        </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 5000px;">
            <tr style='color:White; background:#003366;' >
                <td align="center" class="td1"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;font-size: 16px;"  /> </td>
                <td align="center" class="td1"><a id='lblSno'></a></td>
                <td align="center" class="td2"><a id='lblNamea'></a></td>
                <td align="center" class="td1"><a id='lblCno'></a></td>
                <td align="center" class="td1"><a id='lblLevel1'></a></td>
                <td align="center" class="td1"><a id='lblLevel2'></a></td>
                <td align="center" class="td1"><a id='lblLevel3'></a></td>
                <td align="center" class="td2"><a id='lblMoneys'></a></td>
                <td align="center" class="td2"><a id='lblBo_admins'></a></td>
                <td align="center" class="td2"><a id='lblBo_dutys'></a></td>
                <td align="center"colspan="2" ><a id='lblBo_fulls'></a></td>
                <td align="center" class="td2"><a id='lblBo_overs'></a></td>
                <td align="center" class="td2"><a id='lblBo_oths'></a></td>
                <td align="center"colspan="2" ><a id='lblHr_person'></a></td>
                <td align="center"colspan="2"><a id='lblHr_sick'></a></td>
                <td align="center"colspan="2" ><a id='lblHr_nosalary'></a></td>
                <td align="center"colspan="2"><a id='lblHr_leave'></a></td>
                <td align="center" class="td2"><a id='lblMi_total'></a></td>
                <td align="center" class="td2"><a id='lblTotal2'></a></td>
                <td align="center" colspan="2" class="td3"><a id='lblCh_lunchs'></a></td>
                <td align="center" class="td1"><a id='lblCh_labors'></a></td>
                <td align="center" class="td1"><a id='lblCh_healths'></a></td>
                <td align="center" class="td1"><a id='vewIswelfare'></a></td>
                <td align="center" class="td1"><a id='lblWelfares'></a></td>
                <td align="center" class="td1"><a id='lblBorrows'></a></td>
                <td align="center" class="td1"><a id='lblTaxs'></a></td>
                <td align="center" class="td1"><a id='lblMi_oths'></a></td>
                <td align="center" class="td1"><a id='lblMi_total2s'></a></td>
                <td align="center" class="td2"><a id='lblTotals'></a></td>
                <td align="center" class="td1"><a id='lblRetire' style="font-size: 14px;"></a></td>
                <td align="center" class="td2"><a id='lblLate'></a></td>
                <td align="center" class="td2"><a id='lblMemo'></a></td>
                <td align="center" colspan="2" ><a id='lblBo_borns'></a></td>
                <td align="center" class="td2"><a id='lblBo_trans'></a></td>
                <td align="center" class="td2"><a id='lblBo_exam'></a></td>
                <td align="center" class="td2"><a id='lblPlus'></a></td>
                <td align="center" class="td2"><a id='lblDays'></a></td>
                <td align="center" class="td2"><a id='lblSaltype'></a></td>
                <td align="center"colspan="2" ><a id='lblAd_h1'></a></td>
                <td align="center"colspan="2"><a id='lblAd_h133'></a></td>
                <td align="center"colspan="2" ><a id='lblAd_h166'></a></td>
                <td align="center"colspan="2" ><a id='lblAd_h2'></a></td>
                <td align="center" class="td1"><a id='lblAd_money' style="font-size: 14px;"></a></td>
                <td align="center" class="td1"><a id='lblObonus'></a></td>
                <td align="center" class="td1"><a id='lblOtotal'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;font-size: 16px;float: center;" /></td>
                <td ><input class="txt c1" id="txtSno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtNamea.*" type="text" /></td>
                <td ><input class="txt c1" id="txtCno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtLevel1.*" type="text" /></td>
                <td ><input class="txt c1" id="txtLevel2.*" type="text" /></td>
                <td ><input class="txt c1" id="txtLevel3.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtMoney.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_admin.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_duty.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtHr_full.*" type="text" />HR</td>
                <td class="td2">&#36; <input class="txt num c2" id="txtBo_full.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtBo_over.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtBo_oth.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtHr_person.*" type="text" />HR</td>
                <td class="td2">&#36; <input class="txt num c2" id="txtMi_person.*" type="text"/></td>
                <td class="td2"><input class="txt num c3" id="txtHr_sick.*" type="text" />HR</td> 
                <td class="td2">&#36; <input class="txt num c2" id="txtMi_sick.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtHr_nosalary.*" type="text" />HR</td>
                <td class="td2">&#36;<input class="txt num c2" id="txtMi_nosalary.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtHr_leave.*" type="text" />HR</td>
                <td class="td2">&#36;<input class="txt c2" id="txtMi_leave.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtMi_total.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal2.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtDay_meal.*" type="text" />HR</td>
                <td class="td2">&#36;<input class="txt num c2" id="txtCh_lunch.*" type="text"/></td>               
                <td class="td2">&#36;<input class="txt num c2" id="txtCh_labor.*"type="text" /></td>
                <td class="td2">&#36;<input class="txt num c2" id="txtCh_health.*" type="text" /></td>
                <td ><input id="chkIswelfare.*" type="checkbox" style=' '/></td>
                <td class="td2">&#36;<input class="txt num c2" id="txtWelfare.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBorrow.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTax.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtMi_oth.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtMi_total2.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal.*" type="text" /></td>                
                <td ><input class="txt num c1" id="txtRetire.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtLate.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
                <td class="td2">&#36;<input class="txt num c2" id="txtBo_born.*" type="text" /></td>
                <td class="td2"><input class="txt num c1" id="txtBo_bornpoint.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_trans.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_exam.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtPlus.*" type="text" /></td>
                <td ><input class="txt c1" id="txtDays.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtSaltype.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtAd_h1.*" type="text" />HR</td>
                <td class="td2">&#36; <input class="txt num c2" id="txtAd_m1.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtAd_h133.*" type="text" />HR</td>
                <td class="td2">&#36; <input class="txt num c2" id="txtAd_m133.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtAd_h166.*" type="text" />HR</td>
                <td class="td2">&#36;<input class="txt num c2" id="txtAd_m166.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtAd_h2.*" type="text" />HR</td>
                <td class="td2">&#36;<input class="txt num c2" id="txtAd_m2.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtAd_money.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtObonus.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtOtotal.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
           </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
