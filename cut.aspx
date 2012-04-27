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
        var q_name = "cut";
        var decbbs = ['dime', 'width', 'lengthb', 'mount', 'divide', 'theory', 'hweight', 'weight', 'wprice', 'radius', 'mweight'];
        var decbbm = ['dime', 'width', 'lengthb', 'oweight', 'eweight', 'gweight', 'lengthb2', 'theyout', 'totalout', 'price', 'tranmoney'];
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtCustno', 'btnCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'],['txtProductno', 'btnProduct', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],
        ['txtTggno', 'btnTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],['txtCustno_', 'btnCust_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx'],['txtMechno', 'btnMech', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy )
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

     /*   aPop = [['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtStoreno2', 'btnStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx', "60%", "650px", q_getMsg('popStore')],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];*/

        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
             fbbm[fbbm.length] = 'txtMemo'; 
             q_cmbParse("cmbTypea", q_getPara('cut.typea'));
             
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
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

            q_box('cng_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
            if (!as['comp'] ) {  
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

            }  // j

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
            if (q_tables == 's')
                bbsAssign();  
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
            width: 15%;
        }
        .column2
        {
            width: 15%;
        }      
        .column3
        {
            width: 12%;
        }   
        .column4
        {
            width: 12%;
        }           
         .label1
        {
            width: 10%; text-align:right;
        }       
        .label2
        {
            width: 10%; text-align:right;
        }
        .label3
        {
            width: 12%; text-align:right;
        }
	    .label4
        {
            width: 10%; text-align:right;
        }
        .txt.c1
        {
            width: 95%;
        }
        .txt.c2
        {
            width: 90%;
        }
        .txt.c3
        {
            width: 30%;
            float: left;
        }
        .txt.c4
        {
            width: 59%;
            float: left;
        }
        .txt.c5
        {
            width: 45%;
            float: left;
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
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewOrdeno'></a></td>
                <td align="center" style="width:40%"><a id='vewCust'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='ordeno'>~ordeno</td>
                   <td align="center" id='custno cust'>~custno ~cust</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='label1'><a id="lblDatea" ></a></td>
            <td class="column1"><input id="txtDatea" type="text" class="txt c1"/></td>
            <td class='label2'><a id="lblNoa" ></a></td>
            <td class="column2"><input id="txtNoa" type="text" class="txt c1"/></td>
            <td class='label3'><a id="lblType" ></a></td>
            <td class="column3"><select id="cmbTypea" class="txt c1"></select></td> 
            <td class='label4'><a id="lblOrdeno" ></a></td>
            <td class="column4"><input id="txtOrdeno" type="text" class="txt c2"/></td>
        </tr>
        <tr>
            <td class='label1'><input id="btnMech" type="button" style="width: auto;font-size: medium;"/></td>
            <td class="column1"><input id="txtMechno" type="text" class="txt c3" />
                <input id="txtMech"  type="text"  class="txt c4"/></td>
            <td class='label2'><a id="lblType2" ></a></td>
            <td class="column2"><input id="txtType2" type="text" class="txt c1" /></td>
            <td class='label3'><input id="btnCust" type="button" style="width: auto;font-size: medium;" /></td>
            <td class="column3"><input id="txtCustno" type="text"  class="txt c1"/></td>
            <td colspan="2"><input id="txtCust" type="text"  class="txt c1"/></td>
        </tr>
        <tr>
            <td class='label1'><a id="lblUno" ></a></td>
            <td class="column1"><input id="txtUno" type="text" class="txt c1"/></td>
            <td class='label2'><input id="btnProduct" type="button" style="width: auto;font-size: medium;" /></td>
            <td class="column2"><input id="txtProductno" type="text" class="txt c3"/>
                <input id="txtProduct" type="text" class="txt c4"/></td>
            <td class='label3'><a id="lblSpec" ></a></td>
            <td class="column3"><input id="txtSpec" type="text" class="txt c1"/></td> 
            <td class='label4'><a id="lblCuano" ></a></td>
            <td class="column4"><input id="txtCuano" type="text" class="txt c2"/></td>
        </tr> 
        <tr>
            <td class='label1'><a id="lblDime" ></a></td>
            <td class="column1"><input id="txtDime" type="text" class="txt c1" style="text-align: right;"/></td>
            <td class='label2'><a id="lblWidth" ></a></td>
            <td class="column2"><input id="txtWidth" type="text" class="txt c1" style="text-align: right;" /></td>
            <td class='label3'><a id="lblLengthb" ></a></td>
            <td class="column3"><input id="txtLengthb" type="text" class="txt c1" style="text-align: right;" /></td> 
            <td class='label4'><a id="lblLengthb2"></a></td>
            <td class="column4"><input id="txtLengthb2" type="text" class="txt c2" style="text-align: right;" /></td>
        </tr>  
        <tr>
            <td class='label1'><a id="lblOweight" ></a></td>
            <td class="column1"><input id="txtOweight" type="text" class="txt c1" style="text-align: right;"/></td>
            <td class='label2'><a id="lblEweight" ></a></td>
            <td class="column2"><input id="txtEweight" type="text" class="txt c1" style="text-align: right;"/></td>           
        </tr>     
        <tr>
            <td class='label1'><a id="lblGweight" ></a></td>
            <td class="column1"><input id="txtGweight" type="text" class="txt c1" style="text-align: right;"/></td> 
            <td class='label2'><a id="lblGtime"></a></td>
            <td class="column2"><input id="txtGtime" type="text" class="txt c1"/></td>
            <td class='label3'><a id="lblMount"></a></td>
            <td class="column3"><input id="txtMount" type="text" class="txt c1" style="text-align: right;"/></td>
        </tr>
         <tr>
             <td class='label1'><a id="lblMon"></a></td>
            <td class="column1"><input id="txtMon" type="text" class="txt c1"/></td>
            <td class='label2'><input id="btnTgg" type="button" style="width: auto;font-size: medium;"/></td>
            <td class="column2" ><input id="txtTggno" type="text" class="txt c1"/></td> 
            <td colspan="4"><input id="txtTgg" type="text"  style="width: 98%;"/></td>           
        </tr> 
        <tr>
            <td class='label1'><a id="lblLoss" ></a></td>
            <td class="column1"><input id="txtLoss" type="text" class="txt c1"/></td> 
            <td class='label2'><a id="lblTheyout" style="font-size: 14px;"></a></td>
            <td class="column2"><input id="txtTheyout" type="text" class="txt c1" style="text-align: right;"/></td>
            <td class='label3'><a id="lblTotalout" style="font-size: 14px;"></a></td>
            <td class="column3"><input id="txtTotalout" type="text"class="txt c1" style="text-align: right;"/></td>
        </tr> 
        <tr>
        <td class='label1'><a id="lblMemo" ></a></td>
        <td colspan='7'><textarea id="txtMemo" rows="5" cols="10" style="width: 98%; height: 127px;"></textarea></td>
        </tr>
        <tr>
            <td class='label1'><a id="lblComp"></td>
            <td class="column1"><input id="txtComp" type="text" class="txt c1"/></td>
            <td class='label2'><a id="lblCarno" ></a></td>
            <td class="column2"><input id="txtCarno" type="text" class="txt c1"/></td>
            <td class='label3'><a id="lblPrice" ></a></td>
            <td class="column3"><input id="txtPrice" type="text" class="txt c1" style="text-align: right;"/></td> 
            <td class='label4'><a id="lblTranmoney" ></a></td>
            <td class="column4"><input id="txtTranmoney" type="text" class="txt c2" style="text-align: right;"/></td>
        </tr>
        <tr>
            <td class="label1"></td>
            <td class="column1"></td>
            <td class="label2"></td>
            <td class="column2"></td>
            <td class="label3"></td>
            <td class="column3"></td>
            <td class='label4'><a id="lblWorker" ></a></td>
            <td class="column4"><input id="txtWorker" type="text" class="txt c2"/></td>
        </tr>                   
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 2000px;"  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblCustno'></a></td>
                <td align="center"><a id='lblComps'></a></td>
                <td align="center"><a id='lblStyle'></a></td>
                <td align="center"><a id='lblDimes'></a></td>
                <td align="center"><a id='lblWidths'></a></td>
                <td align="center"><a id='lblLengthbs'></a></td>
                <td align="center"><a id='lblMounts'></a></td>
                <td align="center"><a id='lblDivide'></a></td>
                <td align="center"><a id='lblTheory'></a></td>
                <td align="center"><a id='lblHweight'></a></td>
                <td align="center"><a id='lblWeight'></a></td>
                <td align="center"><a id='lblXbutt'></a></td>
                <td align="center"><a id='lblBno'></a></td>
                <td align="center"><a id='lblStoreno'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
                <td align="center" ><a id='lbltime'></a></td>
                <td align="center" ><a id='lblProductno'></a></td>
                <td align="center" ><a id='lblSpecs'></a></td>
                <td align="center"><a id='lblWprice'></a></td>
                <td align="center"><a id='lblSize'></a></td>
                <td align="center"><a id='lblRadius'></a></td>
                <td align="center"><a id='lblMweight'></a></td>
                <td align="center"><a id='lblOrdenos'></a></td>
                <td align="center" ><a id='lblNo2'></a></td>
                <td align="center" ><a id='lblSpecial'></a></td>
                <td align="center" ><a id='lblCname'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input id="txtCustno.*" type="text" style="width: 80%;"/><input id="btnCust.*" type="button" value="..." style="width: 14%;"/></td>
                <td ><input class="txt c1" id="txtCust.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtStyle.*" type="text" /></td>
                <td ><input class="txt c1" id="txtDime.*" type="text" style="text-align: right;"/></td>
                <td ><input class="txt c1" id="txtWidth.*" type="text" style="text-align: right;"/></td>
                <td ><input class="txt c1" id="txtLengthb.*" type="text" style="text-align: right;"/></td>
                <td style="width: 2%;"><input class="txt c1" id="txtMount.*" type="text" style="text-align: right;"/></td>
                <td style="width: 2%;"><input class="txt c1" id="txtDivide.*" type="text" style="text-align: right;"/></td>
                <td style="width: 2%;"><input class="txt c1" id="txtTheory.*" type="text" style="text-align: right;"/></td>
                <td ><input class="txt c1" id="txtHweight.*" type="text" style="text-align: right;"/></td>
                <td ><input class="txt c1" id="txtWeight.*" type="text"  style="text-align: right;"/></td>
                <td ><input class="txt c1" id="txtXbutt.*" type="text" /></td>
                <td ><input class="txt c1" id="txtBno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtStoreno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtTime.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtProductno.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtSpec.*" type="text" /></td>
                <td ><input class="txt c1" id="txtWprice.*" type="text" style="text-align: right;"/></td>
                <td ><input class="txt c1" id="txtSize.*" type="text" /></td>
                <td ><input class="txt c1" id="txtRadius.*" type="text" style="text-align: right;"/></td>
                <td ><input class="txt c1" id="txtMweight.*" type="text" style="text-align: right;"/></td>
                <td ><input class="txt c1" id="txtOrdeno.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtNo2.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtSpecial.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtCname.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
