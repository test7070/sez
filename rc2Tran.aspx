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
        var decbbs = ['price','mount','total', 'weight', 'sprice', 'dime', 'width', 'lengthb', 'weight2'];
        var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed','ustotal','discount', 'money', 'tax', 'total', 'weight', 'floata', 'price', 'tranmoney', 'outsource'];
        var q_readonly = []; 
        var q_readonlys= [];
        var bbmNum = [['txtPrice', 10, 3], ['txtTranmoney', 11, 2], ['txtMoney', , , 1], ['txtTax', , , 1], ['txtTotal', , , 1]];  
        var bbsNum = [['txtPrice', 12, 3], ['txtWeight', 11, 2,1], ['txtMount', 9, 2,1]];
        var bbmMask = []; 
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'datea';
        //ajaxPath = ""; 
        aPop = new Array(['txtTggno', 'btnTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],['txtCno','btnAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],['txtPartno', 'btnPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
        ['txtPartno2', 'btnPart2', 'part', 'noa,part', 'txtPartno2,txtPart2', 'part_b.aspx'],['txtSalesno', 'btnSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],['txtSalesno2', 'btnSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx'],['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount(); 
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
        });

        //////////////////   end Ready
       function main() {
           if (dataErr) {  
               dataErr = false;
               return;
           }

            mainForm(1); 
        }  

        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('rc2.typea'));   
            q_cmbParse("cmbStype", q_getPara('rc2.stype'));
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));   
            q_cmbParse("cmbPaytype", q_getPara('rc2.pay'));  
            q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
            fbbm[fbbm.length] = 'txtMemo'; 
            $('#btnOrdes').click(function () { btnOrdes(); });

            $('#btnOrde').click(function () { q_pop('txtOrdeno', "orde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtOrdeno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1024px", q_getMsg('popOrde'), true); }); 

            $('#btnAccc').click(function () { q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true); }); 
        }

        function q_boxClose( s2) { 
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
                                                           , 'txtProductno,txtProduct,txtSpec');   
                        bbsAssign();

                        for (i = 0; i < ret.length; i++) {
                            k = ret[i];  
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


        function q_gtPost(t_name) {  
            switch (t_name) {
                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function btnOrdes() {
            var t_custno = trim($('#txtCustno').val());
            var t_where='';
            if (t_custno.length > 0) {
                t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");  
                t_where = t_where;
            }
            else {
                alert( q_getMsg('msgCustEmp'));
                return;
            }
            q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+t_where , 'ordes' , "95%", "650px", q_getMsg( 'popOrde'));
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]); 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            $('#txtWorker' ).val(  r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase()+bbmKey[0].substr( 1)).val();
            if (s1.length == 0 || s1 == "AUTO")  
                q_gtnoa(q_name, replaceAll('D' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
            
            q_box('vcc_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
        }

        function combPay_chg() {   
            var cmb = document.getElementById("combPay")
            if (!q_cur) 
                cmb.value = '';
            else
                $('#txtPay').val(cmb.value);
            cmb.value = '';
        }



        function bbsAssign() {  
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

        function bbsSave(as) {  
            if (!as['productno'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['typea'] = abbm2['typea'];
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
                t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() == 'kg' ?  $('#txtWeight_' + j).val() : $('#txtMount_' + j).val());  // �p��q
                t_weight = t_weight + dec($('#txtWeight_' + j).val()); 
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
            TEXT-ALIGN:  center;
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
       
      
        .style1
        {
            height: 26px;
        }
        .txt.c1
        {
            width: 100%;
        }
        .txt.c2
        {
            width: 94%;
        }
       
      
    </style>
</head>
<body>
        <!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:5%"><a id='vewTypea'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='typea=rc2.typea'>~typea=rc2.typea</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='cno acomp,4'>~cno ~acomp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
               <td class="label1"  align="right"><a id='lblType'></a></td>
               <td class="column1" >
               <%--<input id="txtType" type="text"  style='width:0%; visibility:collapse;'/>--%>
               <select id="cmbTypea" style='width:100%;'/></td>
               <td class="column2" align='right' ><a id='lblStype'></a><select id="cmbStype" style='width:70%;'/></td>
               <td class="label2" ><a id='lblDatea'></a></td>
               <td class="column3"><input id="txtDatea" type="text"  style='width:97%;'/></td>
               <td></td>
               <td class="label3" ><a id='lblNoa'></a></td>
               <td class="column2" ><input id="txtNoa"   type="text" class="txt c2"/></td> 
            </tr> 
            <tr>
               <td align="right" class="style2" ><input id="btnAcomp" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
               <td class="column1" ><input id="txtCno"  type="text" class="txt c1" /></td>
               <td class="column2" ><input id="txtAcomp"    type="text" class="txt c1"/></td>
                <td align="right" class="style2" ><a id='lblMon' ></a></td>
                <td class="column3" ><input id="txtMon"    type="text" class="txt c1"/></td>                 
                <td class="column4" ></td>                 
                <td align="right" class="style2"><a id='lblInvono'></a></td>
                <td class="column2"><input id="txtInvono" type="text" class="txt c2"/></td> 
            </tr>
           <tr>
                <td align="right"><input id="btnTgg" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtTggno" type="text" class="txt c1"/></td>
                <td ><input id="txtTgg"  type="text" class="txt c1"/></td>
                <td align="right"><a id='lblPay'></a></td>
                <td ><input id="txtPay" type="text" style='width:97%' /></td> 
                <td> <select id="cmbPaytype" class="txt c1" /></td>
                <td align="right"><input id="btnAccc" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtAccno"  type="text" class="txt c2"/></td>  
            </tr>
            <tr>
                <td align="right" class="style1" ><a id='lblTel'></a></td>
                <td colspan='2' class="style1"><input id="txtTel" type="text" class="txt c1"/></td>
                <td align="right" class="style1"><a id='lblTrantype'></a></td>
                <td  colspan='2' class="style1"><select id="cmbTrantype" class="txt c1"/></td> 
                  <td align="right"><a id='lblWorker'></a></td>
                <td ><input id="txtWorker"  type="text" class="txt c2" style='text-align:center;'/></td> 
            </tr>
            <tr>
                <td align="right" ><a id='lblAddr'></a></td>
                <td ><input id="txtZipcode"  type="text" class="txt c1"/> </td>
                <td colspan='4' ><input id="txtAddr"  type="text" class="txt c1"/> </td>
            </tr>
            <tr>
                <td align="right"  ><input id="btnPart" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td  ><input id="txtPartno"    type="text" class="txt c1"/></td>
                <td  ><input id="txtPart"    type="text" class="txt c1"/></td>
                <td align="right"  ><input id="btnSales" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td  ><input id="txtSalesno" type="text" class="txt c1"/></td>
                <td  ><input id="txtSales"  type="text" class="txt c1"/></td>
                <td align="right"><a id='lblTranmoney'></a></td>
                <td><input id="txtTranmoney"  type="text" class="txt c2" style="text-align:right;"/></td> 
            </tr>

            <tr>
                <td align="right"><input id="btnPart2" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td><input id="txtPartno2"    type="text" class="txt c1"/></td> 
                <td><input id="txtPart2"    type="text" class="txt c1"/></td> 
                <td align="right"  ><input id="btnSales2" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtSalesno2" type="text" class="txt c1"/></td>
                <td><input id="txtSales2"    type="text" class="txt c1"/></td>
                <td align="right"><a id='lblOutsource'></a></td>
                <td ><input id="txtOutsource"  type="text" class="txt c2" style='text-align:right;'/>
                </td> 
            </tr>
            <tr>
                <td align="right"><a id='lblMoney'></a></td>
                <td colspan='2'><input id="txtMoney"    type="text" class="txt c1"style='text-align:right;'/></td> 
                <td align="right" ><a id='lblTax'></a></td>
                <td><input id="txtTax" type="text" class="txt c1" style=' text-align:right;'/></td>
                <td><select id="cmbTaxtype" class="txt c1"/></td>
                <td align="right"><a id='lblTotal'></a></td>
                <td ><input id="txtTotal" type="text" class="txt c2" style='text-align:right;'/>
                </td> 
            </tr>
            <tr>
                <td align="right"><a id='lblMemo'></a></td>
                <td  colspan='7' ><input id="txtMemo"  type="text" class="txt c1"/></td> 
            </tr>
        </table>
        </div>
         <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblProductno'></a></td>
                <td align="center"><a id='lblProduct'></a></td>
                <td align="center"><a id='lblUnit'></a></td>
                <td align="center"><a id='lblMount'></a></td>
                <td align="center"><a id='lblPrices'></a></td>
                <td align="center"><a id='lblTotals'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td style="width:10%;"><input id="txtProductno.*" type="text" style="width: 65%;"/><input id="btnProductno.*" type="button" value="..." style="width: auto;font-size: medium;" /></td>
                <td style="width:20%;"><input  id="txtProduct.*" type="text" class="txt c2"/></td>
                <td style="width:4%;"><input  id="txtUnit.*" type="text" class="txt c2"/></td>
                <td style="width:5%;"><input  id="txtMount.*" type="text" class="txt c2" style="text-align: right;"/></td>
                <td style="width:6%;"><input  id="txtPrice.*" type="text" class="txt c2" style="text-align: right;"/></td>
                <td style="width:8%;"><input  id="txtTotal.*" type="text" class="txt c2" style="text-align: right;"/></td>
                <td style="width:12%;"><input  id="txtMemo.*" type="text" class="txt c2"/><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
