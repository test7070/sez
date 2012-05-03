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
        var decbbm = ['money'];
        var q_name = "gqb";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        aPop = new Array(['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],['txtTcompno', 'btnTcomp', 'tgg', 'noa,comp', 'txtTcompno,txtTcomp', 'Tgg_b.aspx'],
        ['txtCompno', 'btnComp', 'tgg', 'noa,comp', 'txtCompno,txtComp', 'tgg_b.aspx'],['txtBankno', 'btnBank', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx'],['txtTbankno', 'btnTbank', 'bank', 'noa,bank', 'txtTbankno,txtTbank', 'bank_b.aspx']);
       $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1)
            $('#txtNoa').focus
        });


        //////////////////   end Ready
        function main() {
            if (dataErr) {
                dataErr = false;
                return;
            }

            q_mask(bbmMask);

            mainForm(0); // 1=Last  0=Top

            $('#txtNoa').focus();

        }  ///  end Main()


        function mainPost() { 
             fbbm[fbbm.length] = 'txtMemo';  
             q_cmbParse("cmbTypea", q_getPara('gqb.typea'));
            /*$('#btnSales').click(function () { pop('sss'); });
            $('#btnSalesno').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtSalesno").change(function () { q_change($(this), 'sss', 'noa', 'noa,namea'); });

            $('#btnsss').click(function () { pop('sss'); });
            $('#btnsss').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtGrpno").change(function () {
                q_change($(this), 'sss', 'noa', 'noa,comp');
            });

            $('#btnConn').click(function () { pop('conn') });
            $('#btnConn').mouseenter(function () { $(this).css('cursor', 'pointer') });

            $("#txtComp").change(function () { $("#txtNick").val($("#txtComp").val().substr(0, 2)); });

            txtCopy('txtPost_comp,txtAddr_comp', 'txtPost_fact,txtAddr_fact');
            txtCopy('txtPost_invo,txtAddr_invo', 'txtPost_comp,txtAddr_comp');
            txtCopy('txtPost_home,txtAddr_home', 'txtPost_invo,txtAddr_invo');*/
           
        }

//        function pop(form, seq) {
  //          b_seq = (seq ? seq : '');
    //        b_pop = form;
      //      switch (form) {
        //        case 'sss': q_pop('txtSalesno', 'sss_b.aspx', 'sss', 'noa', 'namea', "60%", "650px", q_getMsg('popSss')); break;
          //      case 'sss': q_pop('txtGrpno', 'sss_b.aspx', 'sss', 'noa', 'comp', "60%", "650px", q_getMsg('popsss')); break;
            //    case 'conn': q_pop('txtNoa', "conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';;" + q_cur, 'conn', 'noa', 'namea', "60%", "650px", q_getMsg('popConn')); break;
            //}
     //   }

        function txtCopy(dest, source) {
            var adest = dest.split(',');
            var asource = source.split(',');
            $('#' + adest[0]).focus(function () { if (trim($(this).val()).length == 0) $(this).val(q_getMsg('msgCopy')); });
            $('#' + adest[0]).focusout(function () {
                var t_copy = ($(this).val().substr(0, 1) == '=');
                var t_clear = ($(this).val().substr(0, 2) == ' =');
                for (var i = 0; i < adest.length; i++) {
                    {
                        if (t_copy)
                            $('#' + adest[i]).val($('#' + asource[i]).val());

                        if (t_clear)
                            $('#' + adest[i]).val('');
                    }
                }
            });
        }

        function q_boxClose(s2) { 
            var ret;
            switch (b_pop) {  
                case 'conn':

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

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('sss_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }

        function combPay_chg() {  
            var cmb = document.getElementById("combPay")
            if (!q_cur)
                cmb.value = '';
            else
                $('#txtPay').val(cmb.value);
            cmb.value = '';
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;

            _btnModi();
            $('#txtComp').focus();
        }

        function btnPrint() {

        }
        function btnOk() {
            var t_err = '';

            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);

            if (dec($('#txtCredit').val()) > 9999999999)
                t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

            if (dec($('#txtStartn').val()) > 31)
                t_err = t_err + q_getMsg("lblStartn") + q_getMsg("msgErr") + '\r';
            if (dec($('#txtGetdate').val()) > 31)
                t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r'

            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            var t_noa = trim($('#txtNoa').val());
            if (emp($('#txtUacc1').val()))
                $('#txtUacc1').val('1123.' + t_noa);
            if (emp($('#txtUacc2').val()))
                $('#txtUacc2').val('1121.' + t_noa);
            if (emp($('#txtUacc3').val()))
                $('#txtUacc3').val('2131.' + t_noa);


            if (t_noa.length ==0)  
                q_gtnoa(q_name, t_noa);
            else
                wrServer(t_noa);
        }

        function wrServer(key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '', '', 2);
        }
        
        function refresh(recno) {
            _refresh(recno);

        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
        }

        function btnMinus(id) {
            _btnMinus(id);
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
            width:100%; border-collapse: collapse; background:#cad3ff;
        } 
        
       
        .column1
        {
            width: 5%;
        }.column1a
        {
            width: 10%;
        }
        .column2
        {
            width: 15%;
        }       
         .label1
        {
            width: 12%;text-align:right;
        }       
        .label2
        {
            width: 12%;text-align:right;
        }
        .label3
        {
            width: 12%;text-align:right;
        }
        .txt.c1
        {
            width: 95%;
        }
        .txt.c2
        {
            width: 93%;
        }
        td input[type="button"] {
                width: auto;
                font-size: medium;
                float: right;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>   
                <td align="center" style="width:5%"><a id='vewChk'></a></td>             
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewIndate'></a></td>
                <td align="center" style="width:25%"><a id='vewType'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='indate'>~indate</td>
                   <td align="center" id='typea=gqb.typea'>~typea=gqb.typea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>
                <td><a id="lblGqb"  style="color: #104E8B ;font-weight:bolder;font-size: 18px; text-align: left;"></a></td>
            </tr>
            <tr>
               <td class="label1" ><a id='lblNoa'></a></td>
               <td class="column1" colspan="2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
               <td class="label2" ><a id='lblType'></a></td>
               <td class="column2" ><select id="cmbTypea" class="txt c1"></select></td>                           
            </tr>
            <tr>
               <td class="label1" ><a id='lblAccount'></a></td>
               <td class="column1" colspan="2"><input id="txtAccount" type="text" class="txt c1" /></td>
               <td class="label2" ><input id="btnAcomp" type="button" /></td>
               <td class="column2"><input id="txtCno" type="text"  style="width: 20%;"/>              
               <input id="txtAcomp" type="text" style="width: 70%;"  /></td>                          
            </tr>
            <tr>
               <td class="label1" ><input id="btnBank" type="button" /></td>
               <td class="column1"><input id="txtBankno" type="text" class="txt c1"/></td>
               <td class="column1a"><input id="txtBank" type="text" class="txt c2"/></td>
               <td class="label2"></td>                                         
            </tr>            
            <tr>
                <td class="label1" ><a id='lblDatea'></a></td>
               <td class="column1" colspan="2"><input id="txtDatea"  type="text"  class="txt c1"/></td>
               <td class="label2"  ><a id='lblIndate'></a></td>
               <td class="column2" ><input id="txtIndate"  type="text"  class="txt c1"/></td>
                          
            </tr>
            <tr>
               <td class="label1" ><a id='lblMoney'></a></td>
               <td class="column1" colspan="2"><input id="txtMoney"  type="text" class="txt c1" style="text-align: right;"/></td>
               <td class="label2" ><a id='lblAccno'></a></td>
               <td class="column2" ><input id="txtAccno"  type="text" class="txt c1" /></td>
                          
            </tr>
            <tr>
               <td class="label1"  ><input id="btnTcomp" type="button" /></td>
               <td class="column1" ><input id="txtTcompno"  type="text" class="txt c1" /></td>
               <td class="column1a" ><input id="txtTcomp"  type="text" class="txt c2" /></td>
               <td class="label2"></td>            
            </tr>
            <tr>
               <td class="label1"  ><input id="btnComp" type="button" /></td>
               <td class="column1" ><input id="txtCompno"  type="text" class="txt c1" /></td>
               <td class="column1a" ><input id="txtComp"  type="text" class="txt c2" /></td>
                <td class="label2"></td>             
            </tr>
            <tr>
                <td><a id="lblGqbs" style="color: #104E8B ;font-weight:bolder;font-size: 18px; text-align: left;"></a></td>
            </tr>
            
            <tr>
               <td class="label1"  ><a id='lblTdate'></a></td>
               <td class="column1"  colspan="2"><input id="txtTdate" type="text" class="txt c1" /></td>
               <td class="label2"  ><a id='lblEnda'></a></td>
               <td class="column2" ><input id="txtEnda"  type="text" class="txt c1"/></td>                                          
            </tr>
            <tr>
               <td class="label1"  ><input id="btnTbank" type="button" /></td>
               <td class="column1"><input id="txtTbankno"  type="text" class="txt c1" /></td>               
               <td class="column1a"><input id="txtTbank"  type="text" class="txt c2" /></td>
               <td class="label2"></td>
               <td class="column2"></td>                           
            </tr>
            <tr>
                <td class="label1" ><a id="lblUsage"></a></td>
                <td colspan="4"  class="column1"><input id="txtUsage"  type="text" style="width: 98%;"/></td>
            </tr>
            <tr>
                <td class="label1"><a id='lblMemo'></a></td>
                <td colspan="4"><textarea id="txtMemo"   rows='5' cols='10' style="width:98%; height: 127px;"></textarea></td>
            </tr>
            <tr>
               <td class="label1"  ><a id='lblTacc1'></a></td>
               <td class="column1" colspan="2" ><input id="txtTacc1"  type="text" class="txt c1" /></td>
               <td class="label2"  ><a id='lblEndaccno'></a></td>
               <td class="column2" ><input id="txtEndaccno"  type="text" class="txt c1" /></td>                              
            </tr>
            <tr>
               <td class="label1"  ><a id='lblAcc1'></a></td>
               <td class="column1" colspan="2"><input id="txtAcc1"  type="text" class="txt c1" /></td>
               <td class="label2"  ><a id='lblBkaccno'></a></td>
               <td class="column2" ><input id="txtBkaccno"  type="text" class="txt c1" /></td>                             
            </tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />    
</body>
</html>
