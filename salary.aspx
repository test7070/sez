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
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
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

            q_box('salary_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
            if (!as['namea']) {  
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
        .tview
        {
            FONT-SIZE: 12pt;
            COLOR:  Blue ;
            background:#FFCC00;
            padding: 3px;
            TEXT-ALIGN:  center;
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
            width: 10%;
        }   
        .column5
        {
            width: 10%;
        }        
         .label1
        {
            width: 8%; text-align:right;
        }       
        .label2
        {
            width: 8%; text-align:right;
        }
        .label3
        {
            width: 8%; text-align:right;
        }
         .label4
        {
            width: 8%; text-align:right;
        }
         .label5
        {
            width: 8%; text-align:right;
        }
        .label6
        {
            width: 8%; text-align:right;
        }
        .txt.c1
        {
            width: 95%;
        }
         .txt.c2
        {
            width: 70%;
        }
         .txt.c3
        {
            width: 50%;
            float: left;
        }
         .td1
        {
            width: 1%;
        }
        .td2
        {
            width: 2%;
        }
        .td3
        {
            width: 2%;
        }
        .txt.num
        {
        	text-align: right;
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
            <td class="label1"><a id="lblMon"></a></td>
            <td class="column1"><input id="txtMon"  type="text" class="txt c1"/></td>
            <td class="label2"><a id="lblType"></a></td>
            <td class="column2"><select id="cmbTypea" class="txt c1"></select></td>
            <td class="label3"><a id="lblNoa"></a></td>
            <td class="column3"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class="label4"><a id="lblHour"></a></td>
            <td class="column4"><input id="txtHour" type="text" class="txt num c1" /></td>
            <td class="label5"><a id="lblBo_born"></a></td>
            <td class="column5"><input id="txtBo_born"  type="text" class="txt num c1" /></td>
            <td class="label6"><input id="btnInput" type="button" style="width: auto;font-size: medium;"/></td>
        </tr>
        <tr>
            <td class="label1"><a id="lblMoney"></a></td>
            <td class="column1"><input id="txtMoney"  type="text" class="txt num c1" /></td>
            <td class="label2"><a id="lblBo_admin"></a></td>
            <td class="column2"><input id="txtBo_admin"  type="text" class="txt num c1" /></td>
            <td class="label3"><a id="lblBo_duty"></a></td>
            <td class="column3"><input id="txtBo_duty"  type="text" class="txt num c1"/></td>
            <td class="label4"><a id="lblBo_full"></a></td>
            <td class="column4"><input id="txtBo_full"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td class="label1"><a id="lblBo_over"></a></td>
            <td class="column1"><input id="txtBo_over"  type="text" class="txt num c1"/></td>
            <td class="label2"><a id="lblBo_oth"></a></td>
            <td class="column2"><input id="txtBo_oth"  type="text" class="txt num c1"/></td>
            <td class="label3"><a id="lblMi_person"></a></td>
            <td class="column3"><input id="txtMi_person"  type="text" class="txt num c1"/></td>
            <td class="label4"><a id="lblMi_full"></a></td>
            <td class="column4"><input id="txtMi_full"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td class="label1"><a id="lblCh_lunch"></a></td>
            <td class="column1"><input id="txtCh_lunch"  type="text" class="txt num c1"/></td>
            <td class="label2"><a id="lblCh_labor"></a></td>
            <td class="column2"><input id="txtCh_labor"  type="text" class="txt num c1"/></td>
            <td class="label3"><a id="lblCh_health"></a></td>
            <td class="column3"><input id="txtCh_health"  type="text" class="txt num c1"/></td>
            <td class="label4"><a id="lblWelfare"></a></td>
            <td class="column4"><input id="txtWelfare"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td class="label1"><a id="lblBorrow"></a></td>
            <td class="column1"><input id="txtBorrow"  type="text" class="txt num c1"/></td>
            <td class="label2"><a id="lblTax"></a></td>
            <td class="column2"><input id="txtTax"  type="text" class="txt num c1"/></td>
            <td class="label3"><a id="lblMi_oth"></a></td>
            <td class="column3"><input id="txtMi_oth" type="text" class="txt num c1"/></td>
            <td class="label4"><a id="lblTitle"></a></td>
            <td class="column4"><input id="txtTitle"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td class="label1"><a id="lblPtotal"></a></td>
            <td class="column1"><input id="txtPtotal"  type="text" class="txt num c1"/></td>
            <td class="label2"><a id="lblMi_total2"></a></td>
            <td class="column2"><input id="txtMi_total2"  type="text" class="txt num c1" /></td>
            <td class="label3"><a id="lblTotal"></a></td>
            <td class="column3"><input id="txtTotal"  type="text" class="txt num c1"/></td>
            <td class="label4"><a id="lblWorker"></a></td>
            <td class="column4"><input id="txtWorker" type="text" class="txt c1"/></td>
        </tr>
        </table>
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
                <td align="center" class="td3"><a id='lblMoneys'></a></td>
                <td align="center" class="td3"><a id='lblBo_admins'></a></td>
                <td align="center" class="td3"><a id='lblBo_dutys'></a></td>
                <td align="center"colspan="2" ><a id='lblBo_fulls'></a></td>
                <td align="center" class="td3"><a id='lblBo_overs'></a></td>
                <td align="center" class="td3"><a id='lblBo_oths'></a></td>
                <td align="center"colspan="2" ><a id='lblHr_person'></a></td>
                <td align="center"colspan="2"><a id='lblHr_sick'></a></td>
                <td align="center"colspan="2" ><a id='lblHr_nosalary'></a></td>
                <td align="center"colspan="2"><a id='lblHr_leave'></a></td>
                <td align="center" class="td3"><a id='lblMi_total'></a></td>
                <td align="center" class="td3"><a id='lblTotal2'></a></td>
                <td align="center" colspan="2" class="td3"><a id='lblCh_lunchs'></a></td>
                <td align="center" class="td1"><a id='lblCh_labors'></a></td>
                <td align="center" class="td1"><a id='lblCh_healths'></a></td>
                <td align="center" class="td1"><a id='vewIswelfare'></a></td>
                <td align="center" class="td1"><a id='lblWelfares'></a></td>
                <td align="center" class="td1"><a id='lblBorrows'></a></td>
                <td align="center" class="td1"><a id='lblTaxs'></a></td>
                <td align="center" class="td1"><a id='lblMi_oths'></a></td>
                <td align="center" class="td1"><a id='lblMi_total2s'></a></td>
                <td align="center" class="td3"><a id='lblTotals'></a></td>
                <td align="center" class="td1"><a id='lblRetire' style="font-size: 14px;"></a></td>
                <td align="center" class="td3"><a id='lblLate'></a></td>
                <td align="center" class="td3"><a id='lblMemo'></a></td>
                <td align="center" colspan="2" ><a id='lblBo_borns'></a></td>
                <td align="center" class="td3"><a id='lblBo_trans'></a></td>
                <td align="center" class="td3"><a id='lblBo_exam'></a></td>
                <td align="center" class="td3"><a id='lblPlus'></a></td>
                <td align="center" class="td3"><a id='lblDays'></a></td>
                <td align="center" class="td3"><a id='lblSaltype'></a></td>
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
                <td class="td2"><input class="txt num c3" id="txtBo_full.*" type="text" />HR</td>
                <td class="td2">&#36; <input class="txt num c2" id="txtMi_full.*" type="text"/></td>
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
                <td class="td2">&#36;<input class="txt num c2" id="txtAd_m1.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtAd_h133.*" type="text" />HR</td>
                <td class="td2">&#36;<input class="txt num c2" id="txtAd_m133.*" type="text" /></td>
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
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
