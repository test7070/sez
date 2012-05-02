<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title></title>
    <script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
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
        var decbbm = ['start', 'startn', 'credit'];   
        var q_name="cust";  
        var q_readonly = ['txtSales', 'txtGrpname', 'txtUacc1', 'txtUacc2', 'txtUacc3'];   
        var bbmNum = [['txtStartn', 2, 0], ['txtGetdate', 2, 0], ['txtPaydate', 2, 0]];  // allow precesion
        var bbmNum_comma = ['txtCredit'];  ///  ,,,,,, disp comma
        var bbmMask = []; //  [['txtUacc1', '9999.99999999'], ['txtUacc2', '9999.99999999'], ['txtUacc3', '9999.99999999']];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root

        $(document).ready(function () {
            bbmKey = ['noa'];

            xmlTable = 'conn';
            xmlKey = [['noa', 'noq']];
            xmlDec = [];
            q_popSave( xmlTable);  // for conn_b.aspx  

            q_brwCount();

            if (!q_gt(q_name, q_content, q_sqlCount, 1))
                return;

            $('#txtNoa').focus
        });

        //////////////////   end Ready
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }

            q_mask(bbmMask);

            mainForm(0); // 1=Last  0=Top

        }  ///  end Main()


        function mainPost() { 
            q_cmbParse("combPay", q_getPara('vcc.pay'));  
            q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));

            $('#btnSales').click(function () { pop('sss'); });
            $('#btnSalesno').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtSalesno").change(function () { q_change($(this), 'sss', 'noa', 'noa,namea'); });

            $('#btnCust').click(function () { pop('cust'); });
            $('#btnCust').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtGrpno").change(function () { 
            q_change($(this), 'cust', 'noa', 'noa,comp'); });

            $('#btnConn').click(function () { pop('conn') });  
            $('#btnConn').mouseenter(function () { $(this).css('cursor', 'pointer') });

            $("#txtComp").change(function () { $("#txtNick").val($("#txtComp").val().substr(0, 2)); });

            txtCopy('txtPost_comp,txtAddr_comp', 'txtPost_fact,txtAddr_fact');
            txtCopy('txtPost_invo,txtAddr_invo', 'txtPost_comp,txtAddr_comp');
            txtCopy('txtPost_home,txtAddr_home', 'txtPost_invo,txtAddr_invo');
            fbbm[fbbm.length] = 'txtMemo';  
        }

        function pop(form, seq) {
            b_seq = (seq ? seq : '');
            b_pop = form;
            switch (form) {
                case 'sss': q_pop('txtSalesno', 'sss_b.aspx', 'sss', 'noa', 'namea', "60%", "650px", q_getMsg('popSss')); break;
                case 'cust': q_pop('txtGrpno', 'cust_b.aspx', 'cust', 'noa', 'comp', "60%", "650px", q_getMsg('popCust')); break;
                case 'conn': q_pop('txtNoa', "conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';;" + q_cur, 'conn', 'noa', 'namea', "60%", "650px", q_getMsg('popConn')); break;
            }
        }

        function txtCopy(dest, source) {
            var adest = dest.split(',');
            var asource = source.split(',');
            $('#' + adest[0]).focus(function () { if (trim($(this).val()).length == 0) $(this).val( q_getMsg('msgCopy')); });
            $('#' + adest[0]).focusout(function () {
                var t_copy = ($(this).val().substr(0, 1) == '=');
                var t_clear = ($(this).val().substr(0, 2) == ' =') ;
                for (var i = 0; i < adest.length; i++) {
                    {
                        if (t_copy)
                            $('#' + adest[i]).val($('#' + asource[i]).val());

                        if( t_clear)
                            $('#' + adest[i]).val('');
                    }
                }
            });
        }
        
        function q_boxClose( s2) { 
            var ret; 
            switch (b_pop) {  
                case 'conn':

                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                    break;

                case 'cust':
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

            q_box('cust_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
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

            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')] ]);

            if ( dec( $('#txtCredit').val()) > 9999999999)
                t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

            if ( dec( $('#txtStartn').val()) > 31)
                t_err = t_err + q_getMsg( "lblStartn")+q_getMsg( "msgErr")+'\r';
            if (dec( $('#txtGetdate').val()) > 31)
                t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r'

            if( t_err.length > 0) {
                alert(t_err);
                return;
            }
            var t_noa = $('#txtNoa').val();
            if (emp($('#txtUacc1').val()))
                $('#txtUacc1').val('1123.' + t_noa);
            if (emp($('#txtUacc2').val()))
                $('#txtUacc2').val('1121.' + t_noa);
            if (emp($('#txtUacc3').val()))
                $('#txtUacc3').val( '2131.'+t_noa);


            if ( t_noa.length==1 )  
                q_gtnoa(q_name, t_noa);
            else
                wrServer(  t_noa);
        }

        function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }

        function format() { 
            var i;

            q_format(bbmNum_comma, bbmNum);   

            q_init = 0;
        }
        
        function refresh(recno) {
            _refresh(recno);

            format();
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
        
       
        .column1
        {
            width: 11%;
        }
        .column2
        {
            width: 21%;
        }      
        .column3
        {
            width: 21%;
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
            width: 14%;text-align:right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%">
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='comp,4'>~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>
               <td class="label1"  align="right"><a id='lblNoa'></a></td>
               <td class="column1" ><input id="txtNoa" maxlength='10' type="text"  style='width:100%; '/>               </td>
               <td class="label2" align="right" ><a id='lblSerial'></a></td>
               <td class="column2"><input id="txtSerial" maxlength='10' type="text"  style='width:100%;'/></td>
               <td class="label3" align="right" ><a id='lblWorker'></a></td>
               <td class="column3"><input id="txtKeyin" maxlength='20' type="text"  style='width:45%;'/><input id="txtWorker" maxlength='20' type="text"  style='width:45%;'/></td>
            </tr>
            <tr>
               <td class="label1"  align="right"><a id='lblComp'></a></td>
               <td class="column1"  colspan='3' ><input id="txtComp" maxlength='100' type="text"  style='width:100%; '/></td>
               <td class="label3" align="right" ><a id='lblNick'></a></td>
               <td class="column3"><input id="txtNick" maxlength='10' type="text"  style='width:98%;'/></td>
            </tr>
            <tr>
               <td class="label1"  align="right"><a id='lblBoss'></a></td>
               <td class="column1" ><input id="txtboss" type="text"  maxlength='20'  style='width:100%; '/>               </td>
               <td class="label2" align="right" ><a id='lblHead'></a></td>
               <td class="column2"><input id="txthead" type="text" maxlength='10' style='width:100%;'/></td>
               <td class="label3" align="right"><a id='lblStatus'></a></td>
               <td class="column3" ><input id="txtStatus"   type="text"  maxlength='10'  style='width:98%;'/></td> 
            </tr>
            <tr>
               <td class="label1"  align="right"><input id="btnConn" type="button" value='...' style='width: auto; font-size: medium;'  /></td>
               <td class="column1" ><input id="txtConn" type="text"  maxlength='20' style='width:100%; '/>               </td>
               <td class="label2" align="right"><a id='lblType'></a></td>
               <td class="column2" ><input id="txtType"  maxlength='10'  type="text"  size='10'   style='width:98%;'/></td> 
               <td class="label3" align="right"><a id='lblTeam'></a></td>
               <td class="column3" ><input id="txtTeam"   type="text"  size='10' maxlength='10'   style='width:98%;'/></td> 
            </tr>
            <tr>
               <td class="label1"  align="right"><a id='lblTel'></a></td>
               <td class="column1" colspan='5' ><input id="txtTel" type="text"  maxlength='90' style='width:99%; '/>               </td>
            </tr>
            <tr>
               <td class="label1"  align="right"><a id='lblFax'></a></td>
               <td class="column1" colspan='3' ><input id="txtFax" type="text"  maxlength='90' style='width:100%; '/>               </td>
               <td class="label3" align="right"><a id='lblMobile'></a></td>
               <td class="column3" ><input id="txtMobile"   type="text"  size='10' maxlength='30'   style='width:98%;'/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblAddr_fact'></a></td>
                <td class="column1" ><input id="txtPost_fact" type="text"  maxlength='8' style='width:100%; '/></td>
                <td  colspan='4' ><input id="txtAddr_fact"  type="text"  maxlength='90'  style="width:99%;"/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblAddr_comp'></a></td>
                <td class="column1" ><input id="txtPost_comp" type="text"  maxlength='8' style='width:100%; '/></td>
                <td  colspan='4' ><input id="txtAddr_comp"  type="text"  maxlength='90'  style="width:99%;"/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblAddr_invo'></a></td>
                <td class="column1" ><input id="txtPost_invo" type="text"  maxlength='8' style='width:100%; '/></td>
                <td  colspan='4' ><input id="txtAddr_invo"  type="text"  maxlength='90'  style="width:99%;"/></td> 
            </tr>
            <tr>
                <td align="right"><a id='lblAddr_home'></a></td>
                <td class="column1" ><input id="txtPost_home" type="text"  maxlength='8' style='width:100%; '/></td>
                <td  colspan='4' ><input id="txtAddr_home"  type="text"  maxlength='90' style="width:99%;"/></td> 
            </tr>
            <tr>
                <td align="right">E-mail</td>
                <td  colspan='5' ><input id="txtEmail"  type="text"  maxlength='90'  style="width:99%;"/></td> 
            </tr>

            <tr>
               <td class="label1"  align="right"><input id="btnCredit" type="button" value='...' style='width: auto; font-size: medium;'  /></td>
               <td class="column1" ><input id="txtCredit" type="text"  maxlength='20' style='width:100%; '/>               </td>
               <td class="label2" align="right" ><input id="btnSales" type="button" value='...' style='width: auto; font-size: medium;'  /></td>
                <td ><input id="txtSalesno" type="text" maxlength='12' style="width:45%"/>
                <input id="txtSales"    type="text"  maxlength='20' style="width:45%"/></td>
                <td  align="right"><input id="btnCust" type="button" value='...' style='width: auto; font-size: medium;'  /></td>
                <td><input id="txtGrpno" type="text" maxlength='12' style="width:45%"/>
                <input id="txtGrpname"    type="text"  maxlength='20' style="width:45%"/></td>
            </tr>

            <tr>
                <td align="right"><a id='lblChkstatus'></a></td>
                <td  colspan='5' ><input id="txtChkstatus"  type="text"   maxlength='90' style="width:99%;"/></td> 
            </tr>

            <tr>
               <td class="label1"  align="right"><a id='lblChkdate'></a></td>
               <td class="column1" ><input id="txtChkdate" type="text"  maxlength='10' style='width:100%; '/>               </td>
               <td class="label2" align="right" ><a id='lblStartn'></a></td>
                <td ><input id="txtStartn" type="text" maxlength='10' style="width:100%"/></td>
               <td class="label3" align="right" ><a id='lblUacc1'></a></td>
               <td><input id="txtUacc1"    type="text"  maxlength='20' style="width:98%"/></td>
            </tr>
            <tr>
               <td class="label1"  align="right"><a id='lblDuedate'></a></td>
               <td class="column1" > <input id="txtDuedate" type="text" maxlength='10' style="width:100%"/>             </td>
               <td class="label2" align="right" ><a id='lblGetdate'></a></td>
                <td ><input id="txtGetdate" type="text" maxlength='10' style="width:100%"/></td>
               <td class="label3" align="right" ><a id='lblUacc2'></a></td>
               <td><input id="txtUacc2"    type="text"  maxlength='20' style="width:98%"/></td>
            </tr>
            <tr>
               <td class="label1"  align="right"><a id='lblTrantype'></a></td>
               <td class="column1" ><select id="cmbTrantype" style='width:100%' />              </td>
               <td class="label2" align="right" ><a id='lblPay'></a></td>
                <td > <input id="txtPay" type="text" maxlength='20' style='width:45%' />
                                      <select id="combPay" style='width:45%' onchange='combPay_chg()' /> </td>
               <td class="label3" align="right" ><a id='lblUacc3'></a></td>
               <td><input id="txtUacc3"    type="text"  maxlength='20' style="width:98%"/></td>
            </tr>
            <tr>
                <td align="right"><a id='lblMemo'></a></td>
                <td  colspan='5' ><textarea id="txtMemo"  rows='5' cols='10' style="width:99%; height: 127px;"></textarea></td> 
            </tr>
        </table>
        </div>
        </div>
  
        <input id="q_sys" type="hidden" />
    
    </form>
</body>
</html>
