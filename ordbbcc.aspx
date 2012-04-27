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
            var q_name = "ordb";
            var decbbm = ['money', 'tax', 'total', 'weight', 'floata', 'mount', 'price','totalus'];
            var decbbs = ['price', 'weight', 'mount', 'total', 'c2', 'notv2', 'dime', 'width', 'lengthb', 'c1', 'notv','theory'];
            var q_readonly = ['txtTgg', 'txtAcomp','txtSales'];
            var q_readonlys = [];
            var bbmNum = [['txtPrice', 11, 3]];
            var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],['txtSales', 'btnSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtWorker', 'lblWorker', 'sss', 'namea', 'txtWorker', 'sss_b.aspx'],['txtCno','btnAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],['txtTggno','btnTgg','tgg','noa,comp','txtTggno,txtTgg','tgg_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no3'];
                q_brwCount();
               q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbStype", q_getPara('rc2.stype')); 
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));      
                q_cmbParse("cmbPaytype", q_getPara('rc2.pay'));  
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype')); 
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
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
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['productno']) {
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
                for(var j = 0; j < q_bbsCount; j++) {

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
                if(q_tables == 's')
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
            width: 10%;
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
           width: 100%;
       }
       .txt.c2
       {
           width: 94%;
       }
      .txt.c3
      {
          width: 98%;
      }
      .txt.c4
      {
          width: 25%;
      }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"--> 
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:30%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewTgg'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='tggno tgg,4'>~tggno ~tgg,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 70%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
               <td class="label1" ><a id='lblStype'></a></td>
               <td class="column1" ><select id="cmbStype" class="txt c1"/></td>
               <td class="column2" ></td>
               <td class="label2" ><a id='lblDatea'></a></td>
               <td class="column3"><input id="txtDatea" type="text" class="txt c1"/></td>
               <td class="column4" ></td>
               <td class="label3"><a id='lblNoa'></a></td>
               <td class="column2"><input id="txtNoa"   type="text"  class="txt c2"/></td> 
            </tr>
     
            <tr>
               <td class="label1"><input id="btnAcomp" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
               <td class="column1" ><input id="txtCno"  type="text" class="txt c1"/></td>
               <td class="column2" ><input id="txtAcomp"    type="text" class="txt c1"/></td>
               <td class="label2"><a id='lblFloata'></a></td>
                <td class="column3" ><select id="cmbCoin" class="txt c1"/></td>                 
                <td class="column4" ><input id="txtFloata"    type="text"  class="txt c1" style="text-align: right;"/></td>                 
                <td class="label3"><a id='lblContract'></a></td>
                <td class="column2"><input id="txtContract"  type="text" class="txt c2"/></td> 
            </tr>

           <tr>
                <td class="label1"><input id="btnTgg" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtTggno" type="text" class="txt c1"/></td>
                <td ><input id="txtTgg"  type="text" class="txt c1"/></td>
                <td class="label2"><a id='lblPay'></a></td>
                <td ><input id="txtPay" type="text" class="txt c1"/></td> 
                <td><select id="cmbPaytype" class="txt c1" /></td> 
                <td class="label3"><a id='lblTrantype'></a></td>
                <td><select id="cmbTrantype" class="txt c1" name="D1" /></td> 
            </tr>
            <tr>
                <td class="label1"><input id="btnSales" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtSalesno" type="text" class="txt c1"/></td> 
                <td ><input id="txtSales" type="text" class="txt c1"/></td> 
                <td class="label2"><a id='lblTel'></a></td>
                <td colspan='2'><input id="txtTel"  type="text"  class="txt c1"/></td>
                <td class="label3"><a id='lblFax'></a></td>
                <td ><input id="txtFax" type="text" class="txt c2"/></td>
            </tr>
            <tr>
                <td class="label1"><a id='lblAddr'></a></td>
                <td ><input id="txtPost"  type="text"  class="txt c1"/> </td>
                <td colspan='4' ><input id="txtAddr"  type="text" class="txt c1"/> </td>
                <td align="right" >&nbsp;</td>
                <td >&nbsp;</td> 
            </tr>
            <tr>
                <td class="label1"><a id='lblMoney'></a></td>
                <td colspan='2'><input id="txtMoney" type="text" class="txt c1" style='text-align:right;'/></td> 
                <td class="label2"><a id='lblTax'></a></td>
                <td><input id="txtTax"  type="text" class="txt c1" style='text-align:right;'/></td>
                <td><select id="cmbTaxtype" class="txt c1" /></td>
                <td class="label3"><a id='lblTotal'></a></td>
                <td ><input id="txtTotal" type="text" class="txt c2" style='text-align:right;'/>
                </td> 
            </tr>
            <tr>
                <td class="label1"><a id='lblTotalus'></a></td>
                <td colspan='2'><input id="txtTotalus"  type="text" class="txt c1" style='text-align:right;'/></td> 
                <td class="label2"><a id='lblWeight'></a></td>
                <td colspan='2' ><input id="txtWeight"  type="text" class="txt c1" style='text-align:right;'/></td>
                <td class="label3"><a id='lblWorker'></a></td>
                <td ><input id="txtWorker"  type="text" class="txt c2" /></td> 
            </tr>
            <tr>
                <td class="label1"><a id='lblMemo'></a></td>
                <td  colspan='7' ><input id="txtMemo"  type="text" class="txt c1"/></td> 
            </tr>
        </table>
        </div>


        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
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
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
              <td style="width:10%; text-align:center"><input class="txt c3"  id="txtProductno.*" type="text" />
                                       <input class="btn"  id="btnProduct.*" type="button" value='...' style=" font-weight: bold;" />
                                       <input class="txt c4" id="txtNo2.*" type="text" /></td>
                <td style="width:20%;"><input class="txt c3" id="txtProduct.*" type="text" />
                <input class="txt" id="txtUno.*" type="text c3" /></td>
                <td style="width:18%;"><input class="txt c4" id="txtDime.*" type="text"   style="text-align:right;" />x
                                    <input class="txt c4" id="txtWidth.*" type="text"   style="text-align:right;" />x
                                    <input class="txt c4" id="txtLengthb.*" type="text"  style="text-align:right;" />
                                    <input class="txt c3" id="txtSpec.*" type="text"  /></td>
                <td style="width:4%;"><input class="txt c2" id="txtUnit.*" type="text" /></td>
                <td style="width:5%;"><input class="txt c2" id="txtMount.*" type="text" style="text-align: right;"/></td>
                <td style="width:6%;"><input class="txt c2" id="txtWeight.*" type="text" style="text-align: right;"/></td>
                <td style="width:6%;"><input class="txt" id="txtPrice.*" type="text"  style="width:96%; text-align:right;"/></td>
                <td style="width:8%;"><input class="txt" id="txtTotal.*" type="text" style="width:96%; text-align:right;"/>
                                      <input class="txt" id="txtTheory.*" type="text"  style="width:96%; text-align:right;"/></td>
                <td style="width:15%;"><input class="txt C3" id="txtMemo.*" type="text" />
                <input class="txt" id="txtOrdbno.*" type="text" style="width:65%;" />
                <input class="txt" id="txtNo3.*" type="text" style="width:20%;" />
                <input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
