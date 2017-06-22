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
        var q_name="car4";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root

        $(document).ready(function () {
            bbmKey = ['noa'];

            xmlTable = 'conn';
            xmlKey = [['noa', 'noq']];
            xmlDec = [];
            q_popSave( xmlTable);  // for conn_b.aspx
            q_brwCount();
            q_gt(q_name, q_content, q_sqlCount, 1)
            $('#txtNoa').focus
        });

        //////////////////   end Ready
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }
            mainForm(0); // 1=Last  0=Top
        }  ///  end Main()


        function mainPost() { 
          q_mask(bbmMask);
            $('#btnSales').click(function () { pop('sss'); });
            $('#btnSalesno').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtSalesno").change(function () { q_change($(this), 'sss', 'noa', 'noa,namea'); });

            $('#btnsss').click(function () { pop('sss'); });
            $('#btnsss').mouseenter(function () { $(this).css('cursor', 'pointer') });
            $("#txtGrpno").change(function () { 
            q_change($(this), 'sss', 'noa', 'noa,comp'); });

            $('#btnConn').click(function () { pop('conn') });  
            $('#btnConn').mouseenter(function () { $(this).css('cursor', 'pointer') });

            $("#txtComp").change(function () { $("#txtNick").val($("#txtComp").val().substr(0, 2)); });

            txtCopy('txtPost_comp,txtAddr_comp', 'txtPost_fact,txtAddr_fact');
            txtCopy('txtPost_invo,txtAddr_invo', 'txtPost_comp,txtAddr_comp');
            txtCopy('txtPost_home,txtAddr_home', 'txtPost_invo,txtAddr_invo');
           }

        function pop(form, seq) {
            b_seq = (seq ? seq : '');
            b_pop = form;
            switch (form) {
                case 'sss': q_pop('txtSalesno', 'sss_b.aspx', 'sss', 'noa', 'namea', "60%", "650px", q_getMsg('popSss')); break;
                case 'sss': q_pop('txtGrpno', 'sss_b.aspx', 'sss', 'noa', 'comp', "60%", "650px", q_getMsg('popsss')); break;
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

            q_box('car4_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
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
            var t_noa = trim($('#txtNoa').val());
            if (emp($('#txtUacc1').val()))
                $('#txtUacc1').val('1123.' + t_noa);
            if (emp($('#txtUacc2').val()))
                $('#txtUacc2').val('1121.' + t_noa);
            if (emp($('#txtUacc3').val()))
                $('#txtUacc3').val( '2131.'+t_noa);


            if ( t_noa.length==0 )   
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
            width: 10%;text-align:right;
        }       
        .label2
        {
            width: 10%;text-align:right;
        }
        .label3
        {
            width: 10%;text-align:right;
        }
         .label4
        {
            width: 10%;text-align:right;
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
                <td align="center" style="width:25%"><a id='vewCarno'></a></td>
                <td align="center" style="width:40%"><a id='vewBoss'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='carno'>~carno</td>
                   <td align="center" id='boss'>~boss</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>               
               <td class="label1" ></td>
               <td class="column1"></td> 
               <td class="label2" ><a id='lblCarno'></a></td>
               <td class="column2"><input id="txtCarno"  type="text"  style='width:98%; '/></td>              
               <td class="column3"><input id="txtBoss" type="text"  style='width:98%; '/></td>
               <td class="label3" ></td>
               <td class="label4" ></td>
               <td class="column4"></td>
            </tr>
            <tr>
               <td class="label1" ><a id='lblItype'></a></td>
               <td class="column1"><input id="tetItype"  type="text"  style='width:98%; '/></td> 
               <td class="column1a"><a id='lblAuto'></a></td> 
               <td class="label2"  ><a id='lblIrange'></a></td>
               <td class="column2"><input id="txtIrange" type="text"  style='width:98%; '/></td>
               <td class="column2a"></td>
               <td class="label3" ></td>
               <td class="column3"></td>
            </tr>
            <tr>
               <td class="label1"  ><a id='lblManage'></a></td>
               <td class="column1"><input id="txtManage" type="text"  style='width:98%; '/></td>
               <td class="label2" ></td>               
               <td class="label3" ><a id='lblGuile'></a></td>
               <td class="column3"><input id="txtGuile" type="text"  style='width:98%; '/></td>
           </tr>
           <tr>
               <td class="label1" ><a id='lblLabor'></a></td>
               <td class="column1"><input id="txtLabor"  type="text"  style='width:98%; '/></td>
               <td class="label2" ></td
               <td class="column2"></td>
               <td class="label3" ><a id='lblHealth'></a></td>
               <td class="colum3"><input id="txtHealth" type="text"  style='width:98%; '/></td>
               
           </tr>
           <tr>
               <td class="label1" ><a id='lblPrepare'></a></td>
               <td class="column1"><input id="txtPrepare"  type="text"  style='width:98%; '/></td>
               <td class="label2" ></td
               <td class="column2"></td>
               <td class="label3" ><a id='lblHelp'></a></td>
               <td class="column3"><input id="txtHelp"  type="text"  style='width:98%; '/></td>
               <td class="column3a" ><input id="txtHelpmon" type="text"  style='width:45%; '/><a id='lblHelpmon' style='width:45%; '></td>
                    
           </tr>
           <tr>
               <td class="label1" ><a id='lblVrate'></a></td>
               <td class="column1"><input id="txtVrate"  type="text"  style='width:98%; '/></td>
               <td class="label2" ></td
               <td class="column2"></td>
               <td class="label3" ><a id='lblRrate'></a></td>
               <td class="column3"><input id="txtRrate"  type="text"  style='width:98%; '/></td>      
                <td class="label4" ><a id='lblOrate'></a></td>    
               <td class="column4"><input id="txtOrate" type="text"  style='width:98%; '/></td>
           </tr>        
           <tr>
               <td class="label1" ><a id='lblIrate'></a></td>
               <td class="column1"><input id="txtIrate"  type="text"  style='width:98%; '/></td>
               <td class="label2" ></td
               <td class="column2"></td>
               <td class="label3"><a id='lblPrate'></a></td>
               <td class="column3"><input id="txtPrate"  type="text"  style='width:98%; '/></td>
           </tr>
           <tr>
               <td class="label1" ><a id='lblUlicense'></a></td>
               <td class="column1"><input id="txtUlicense" type="text"  style='width:98%; '/></td>
               <td class="column1a"><input id="txtUlicensemon"  type="text"  style='width:45%; '/><a id='lblUlicensemon' style='width:45%; '></a></td>
               <td class="label2"  ><a id='lblDlicense'></a></td>
               <td class="column2"><input id="txtDlicense"  type="text"  style='width:98%; '/></td>
               <td class="column2a"><input id="txtDlicenseMon"  type="text"  style='width:45%; '/><a id='lblDlicensemon' style='width:45%; '></a></td>
           </tr>
           <tr>
               <td class="label1" ><a id='lblSpring'></a></td>
               <td class="column1"><input id="txtSpring" type="text"  style='width:98%; '/></td>              
               <td class="column1a"><input id="txtSpringMon"  type="text"  style='width:45%; '/><a id='lblSpringmon' style='width:45%; '></a></td>
               <td class="label2" ><a id='lblSummer'></a></td>
               <td class="column2"><input id="txtSummer"  type="text"  style='width:98%; '/></td>
               <td class="column2a"><input id="txtSummermon"  type="text"  style='width:45%; '/><a id='lblSummermon' style='width:45%; '></a></td>
           </tr>
           <tr>
               <td class="label1"  ><a id='lblFalla'></a></td>
               <td class="column1"><input id="txtFalla"  type="text"  style='width:98%; '/></td>               
               <td class="column1a"><input id="txtFallamon"  type="text"  style='width:45%; '/><a id='Fallamon' style='width:45%; '></a></td>
               <td class="label2"  ><a id='lblWinter'></a></td>
               <td class="column2"><input id="txtWinter" type="text"  style='width:98%; '/></td>             
               <td class="column2a"><input id="txtWintermon"  type="text"  style='width:45%; '/><a id='Wintermon' style='width:45%; '></a></td>
           </tr>
          
        </table>
        </div>
        </div>        
        <input id="q_sys" type="hidden" />
    
    </form>
</body>
</html>
