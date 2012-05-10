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
            var q_name = "quat";
            var decbbs = ['price', 'weight', 'mount', 'total', 'c2', 'notv2', 'dime', 'width', 'lengthb', 'c1', 'notv', 'theory'];
            var decbbm = ['money', 'tax', 'total', 'weight', 'floata', 'mount', 'price','totalus','thirdprice','oil1','oil2'];
            var q_readonly = ['txtComp', 'txtAcomp','txtSales'];
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
            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'], ['txtAddno1_', 'btnAdd1_', 'addr', 'noa,addr', 'txtAddno1_,txtAdd1_', 'addr_b.aspx'], ['txtAddno2_', 'btnAdd2_', 'addr', 'noa,addr', 'txtAddno2_,txtAdd2_', 'addr_b.aspx'],['txtCustno', 'btnCust', 'Cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],['txtSales', 'btnSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],['txtCno','btnAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx']);
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
                q_cmbParse("cmbStype", q_getPara('vcc.stype')); 
                 
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
        .label4
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
            width: 30%;
        }
        .txt.c4
        {
            width: 55%;
        }
       
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='custno comp,4'>~custno ~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
               <td class="label1" ><a id='lblStype'></a></td>
               <td class="column1"><select id="cmbStype" class="txt c1"/></td>
               <td class="label2" ><a id='lblDatea'></a></td>
               <td class="column2"><input id="txtDatea" type="text"  class="txt c1"/></td>
               <td class="label3" ><a id='lblNoa'></a></td>
               <td class="column3" ><input id="txtNoa" type="text" class="txt c1"/></td> 
               <td class="label4"><a id='lblContract'></a></td>
                <td class="column4"><input id="txtContract"  type="text"  class="txt c2"/></td>
            </tr>    
            <tr>
               <td class="label1" ><a id='lblThirdprice'></a></td>
               <td class="column1"><input id="txtThirdprice" type="text"  class="txt c1" style="text-align: right"/></td>
               <td class="label2" ><a id='lblOil1'></a></td>
               <td class="column2"><input id="txtOil1" type="text"  class="txt c1" style="text-align: right"/></td>
               <td align="center"><a id="lblOil2" style="font-weight: bolder;"></a></td>
               <td class="column3"><input id="txtOil2" type="text"  class="txt c1" style="text-align: right"/></td>
            </tr>
            <tr>
               <td class="label1"><input id="btnAcomp" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
               <td class="column1" ><input id="txtCno"  type="text"  class="txt c1"/></td>
               <td class="column4" colspan="2"><input id="txtAcomp"  type="text" class="txt c1"/></td>
               <td class="label2"><a id="lblConn_acomp"></a></td>               
               <td class="column2" ><input id="txtConn_acomp"  type="text"  class="txt c1"/></td> 
               <td class="label3"><a id="lblAssistant"></a></td>               
               <td class="column3" ><input id="txtAssistant"  type="text"  class="txt c2"/></td>
            </tr>
            <tr>
                <td class="label2"><a id='lblAddr_acomp'></a></td>
                <td ><input id="txtZip_acomp" type="text"  class="txt c1"></td>
                <td colspan='2' ><input id="txtAddr_acomp" type="text"  class="txt c1" /></td>
               <td class="label1"><a id="lblTel_acomp"></a></td>
               <td class="column1"><input id="txtTel_acomp"  type="text"  class="txt c1"/></td>
               <td class="label2"><a id='lblFax_acomp'></a></td>
               <td class="column2"><input id="txtFax_acomp"  type="text"  class="txt c2"/></td>
            </tr>
            <tr>
                <td class="label1"><input id="btnSales" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtSalesno" type="text" class="txt c1"/></td> 
                <td  colspan="2"><input id="txtSales" type="text" class="txt c1"/></td>
                <td></td>
            </tr>
           <tr>
                <td class="label1"><input id="btnCust" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtCustno" type="text" class="txt c1"/></td>
                <td colspan="2"><input id="txtComp"  type="text" class="txt c1"/></td>
                 <td class="label2"><a id='lblConn_cust'></a></td>
                <td ><input id="txtConn_cust"  type="text"  class="txt c1"/></td>
                <td class="label3"><a id='lblTel_cust'></a></td>
                <td ><input id="txtTel_cust"    type="text"  class="txt c2"/></td>
            </tr>
            <tr>
                <td class="label1"><a id='lblAddr_cust'></a></td>
                <td ><input id="txtZip_cust" type="text"  class="txt c1"></td>
                <td colspan='2' ><input id="txtAddr_cust" type="text"  class="txt c1" /></td>
                <td class="label2"><a id='lblFax_cust'></a></td>
                <td ><input id="txtFax_cust"  type="text"  class="txt c1"/></td>
            </tr>
            <tr>
                <td class="label1"><a id='lblAddr_car'></a></td>
                <td ><input id="txtZip_car" type="text"  class="txt c1"></td>
                <td colspan='2' ><input id="txtAddr_car" type="text"  class="txt c1" /></td>
                <td class="label2"><a id='lblConn_car'></a></td>
                <td ><input id="txtConn_car"  type="text"  class="txt c1"/></td>
                
            </tr>
            <tr>
                <td class="label1"><a id='lblArrange_car'></a></td>
                <td class="column1"><input id="txtArrange_car"  type="text"  class="txt c1"/></td>
                <td class="label2"><a id='lblTel_car'></a></td>
                <td class="column2"><input id="txtTel_car"  type="text"  class="txt c1"/></td>
                <td class="label3"><a id='lblWorker'></a></td>
                <td ><input id="txtWorker"  type="text" class="txt c1" /></td> 
            </tr>
            <tr><td align="right"><a id='lblMemo'></a></td>
                <td  colspan='7' ><input id="txtMemo"  type="text" style="width: 99%;"/></td></tr>
        </table>
        </div>
        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
              <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center"><a id="lblNo3"></a></td>
                <td align="center"><a id='lblProductno'></a></td>
                <td align="center"><a id='lblProduct'></a></td>
                <td align="center"><a id="lblAdd1"></a></td>
                <td align="center"><a id="lblAdd2"></a></td>
                <td align="center"><a id='lblMount'></a></td>
                <td align="center"><a id='lblUnit'></a></td>
                <td align="center"><a id='lblPrices'></a></td>        
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td style="width:4%;"><input id="txtNo3.*" type="text" class="txt c2"/></td>
                <td style="width:10%; text-align:center"><input id="txtProductno.*" type="text"style="width: 60%;" />
                                       <input class="btn"  id="btnProduct.*" type="button" value='...' style=" font-weight: bold;" /></td>
                <td style="width:20%;"><input id="txtProduct.*" type="text" class="txt c2"/></td>
                <td style="width:14%;"><input id="txtAddno1.*" type="text" style="width: 22%;"/><input id="txtAdd1.*" type="text" style="width: 53%;"/><input id="btnAdd1.*" type="button" value=".." style="width: 15%;" /></td>
                <td style="width:14%;"><input id="txtAddno2.*" type="text" style="width: 22%;"/><input id="txtAdd2.*" type="text" style="width: 53%;"/><input id="btnAdd2.*" type="button" value=".." style="width: 15%;" /></td>
                <td style="width:5%;"><input id="txtMount.*" type="text"  class="txt c2" style="text-align:right;"/></td>
                <td style="width:4%;"><input id="txtUnit.*" type="text" class="txt c2"/></td>
                <td style="width:6%;"><input id="txtPrice.*" type="text" class="txt c2" style="text-align:right;"/></td>
                <td style="width:12%;"><input id="txtMemo.*" type="text" class="txt c2"/><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
