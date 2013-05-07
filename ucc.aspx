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
        var decbbm = ['inprice', 'saleprice', 'reserve', 'beginmount','uweight','beginmoney','drcr','price2','days','stkmount','safemount','stkmoney'];
        var q_name = "ucc";
        var q_readonly = [];
        var bbmNum = [];  
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        aPop = new Array(['txtTggno', 'btnTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);
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
            q_cmbParse("cmbTypea", q_getPara('ucc.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
            q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
            q_cmbParse("cmbCoin", q_getPara('sys.coin'));  
          fbbm[fbbm.length] = 'txtMemo'; 
        }


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

            q_box('ucc_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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


            if (t_noa.length == 0)  
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
            width:98%; border-collapse: collapse; background:#cad3ff;
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
            width: 15%;
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
            width: 10%; text-align:right;
        }
        .txt.c1
        {
            width: 98%;
        }
        .txt.c2
        {
            width: 95%;
        }
      
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height: 98%">
        <!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:2%"><a id='vewChk'></a></td>
                <td align="center" style="width:15%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewProduct'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/>.</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='product spec'>~product ~spec</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr><td class="label1"><a id='lblNoa'></a></td> <td class='column1'><input  type="text" id="txtNoa" class="txt c1"/></td>
            <td class="label2"><a id='lblDatea'></a></td><td class='column2'><input  type="text" id="txtDatea" class="txt c2"/></td>
            <td class="label3"></td></tr>

        <tr><td class="label1"><a id='lblProduct'></a></td><td colspan='3'><input  type="text" id="txtProduct" class="txt c1"/></td></tr>
        <tr><td class="label1"><a id='lblEngpro'></a></td><td colspan='3' ><input  type="text" id="txtEngpro" class="txt c1"/></td></tr>
        <tr><td class="label1"><a id='lblSpec'></a></td><td colspan='3'><input  type="text" id="txtSpec"  class="txt c1"/></td></tr>
        <tr><td class="label1"><a id='lblUnit'></a></td><td><input  type="text" id="txtUnit"  class="txt c1"/></td>
            <td class="label2"><a id='lblInprice'></a></td><td><input  type="text" id="txtInprice" class="txt c2"/></td>            
        </tr>
        <tr><td class="label1"><a id='lblSafemount'></a></td><td><input  type="text" id="txtSafemount"  class="txt c1"/></td>
            <td class="label2"><a id='lblSaleprice'></a></td><td><input  type="text" id="txtSaleprice"  class="txt c2"/></td></tr>
            
        <tr><td class="label1"><a id='lblUweight'></a></td><td><input  type="text" id="txtUweight"  class="txt c1"/></td>
            <td class="label2"><a id='lblCoin'></a></td><td><select id="cmbCoin" class="txt c2"/></td></tr>
            
        <tr><td class="label1"><input id="btnTgg" type="button" value='.' style='width: auto; font-size: medium;'  /></td>
            <td><input id="txtTggno" type="text" class="txt c1"/></td>
            <td colspan='2'><input id="txtTgg"  type="text" style="width: 97%;"/></td>
        </tr>                
        <tr><td class="label1"><a id='lblType'></a></td><td><select id="cmbTypea" class="txt c1"/></td>
            <td class="label2"><a id='lblDays'></a></td><td><input  type="text" id="txtDays" class="txt c2"/></td> 
        </tr>
        <tr>
            <td class="label1"><a id='lblArea'></a></td><td><input  type="text" id="txtArea"  class="txt c1"/></td>
            <td class="label2"><a id='lblTrantype'></a></td><td><select id="cmbTrantype" class="txt c2" /></td> 
        </tr>
        <tr>
            <td class="label1"><a id='lblRc2acc'></a></td><td><input  type="text" id="txtRc2acc" class="txt c1"/></td>
            <td class="label2"><a id='lblVccacc'></a></td><td><input  type="text" id="txtVccacc"  class="txt c2"/></td>
        </tr>
        <tr>
            <td class='label1'><a id='lblDate2'></a></td><td class='column3'><input  type="text" id="txtDate2" class="txt c1"/></td>
            <td class="label2"><a id='lblWorker'></a></td><td ><input id="txtWorker"  type="text" class="txt c2" style='text-align:center;'/></td> 
        </tr>
        <tr><td class="label1"><a id='lblMemo'></a></td><td colspan='3'><textarea id="txtMemo" cols="10" rows="5" style="width: 98%;height: 127px;"></textarea></td></tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
    
    </form>
</body>
</html>
