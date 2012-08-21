<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src="../script/qbox.js" type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        var q_name="cust";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        aPop = new Array(['txtInvestdate', 'lblInvest', 'invest', 'datea,investmemo', 'txtInvestdate,txtInvestmemo', 'invest_b.aspx'],
        ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales','sss_b.aspx'],['txtGrpno', 'lblCust', 'cust', 'noa,comp', 'txtGrpno,txtGrpname','cust_b.aspx'])
        $(document).ready(function () {
            bbmKey = ['noa'];
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

            q_mask(bbmMask);

            mainForm(0); // 1=Last  0=Top

            $('#txtNoa').focus();
            
        }  ///  end Main()
   

        function mainPost() { 
            fbbm[fbbm.length] = 'txtMemo'; 
            q_cmbParse("cmbTypea", q_getPara('cust.typea'));
            q_cmbParse("cmbBillday", q_getPara('cust.billday'));
            q_cmbParse("combPay", q_getPara('vcc.pay'));   
            q_cmbParse("cmbTrantype", q_getPara('sys.tran')); 
            
            $('#lblConn').click(function(){
				t_where = "noa='"+  $('#txtNoa').val() +"'";
				q_box("conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'conn', "95%", "650px", q_getMsg('lblConn'));
				}
			);
			  
        

            txtCopy('txtZip_comp,txtAddr_comp', 'txtZip_fact,txtAddr_fact');
            txtCopy('txtZip_invo,txtAddr_invo', 'txtZip_comp,txtAddr_comp');
            txtCopy('txtZip_home,txtAddr_home', 'txtZip_invo,txtAddr_invo');
        }

    /*    function pop(form, seq) {
            b_seq = (seq ? seq : '');
            b_pop = form;
            switch (form) {
                case 'sss': q_pop('txtSalesno', 'sss_b.aspx', 'sss', 'noa', 'namea', "60%", "650px", q_getMsg('popSss')); break;
                case 'sss': q_pop('txtGrpno', 'sss_b.aspx', 'sss', 'noa', 'comp', "60%", "650px", q_getMsg('popsss')); break;
                case 'conn': q_pop('txtNoa', "conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';;" + q_cur, 'conn', 'noa', 'namea', "60%", "650px", q_getMsg('popConn')); break;
            }
        }*/

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
            if (q_cur == 2)   
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
         #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 98%;
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
                width: 97%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 19%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 99%;
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .ch2, .ch3, .ch4, .ch5, .ch6
            {
            width: 8%;text-align: left;
        	}
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
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
            <tr class="tr1">
               <td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td2"><input id="txtNoa"  type="text" class="txt c1" /></td>
               <td class="td3"><span> </span><a id='lblSerial' class="lbl"></a></td>
               <td class="td4"><input id="txtSerial"  type="text"  class="txt c1"/></td>
               <td class="td5"><span> </span><a id='lblWorker' class="lbl"></a></td>
               <td class="td6"><input id="txtKeyin"  type="text"  class="txt c2"/><input id="txtWorker" type="text"  class="txt c3"/></td>
            </tr>
            <tr class="tr2">
               <td class="td1" ><span> </span><a id='lblComp' class="lbl"></a></td>
               <td class="td2"  colspan='3' ><input id="txtComp" type="text" class="txt c1"/></td>
               <td class="td3" ><span> </span><a id='lblNick' class="lbl"></a></td>
               <td class="td4"><input id="txtNick" type="text"  class="txt c1"/></td>
            </tr>
            <tr class="tr3">
               <td class="td1"><span> </span><a id='lblBoss' class="lbl"></a></td>
               <td class="td2"><input id="txtboss" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblHead' class="lbl"></a></td>
               <td class="td4"><input id="txthead" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id='lblStatus' class="lbl"></a></td>
               <td class="td6"><input id="txtStatus" type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr4">
               <td class="td1"><span> </span><a id="lblConn" class="lbl btn" ></a></td>
               <td class="td2"><input id="txtConn" type="text"  class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblType' class="lbl"></a></td>
               <td class="td4"><select id="cmbTypea"  class="txt c1"></select></td> 
               <td class="td5"><span> </span><a id='lblTeam' class="lbl"></a></td>
               <td class="td6"><input id="txtTeam"   type="text"  class="txt c1"/></td> 
            </tr>
            <tr class="tr5">
               <td class="td1"><span> </span><a id='lblTel' class="lbl"></a></td>
               <td class="td2" colspan='5' ><input id="txtTel" type="text" class="txt c6"/></td>
            </tr>
            <tr class="tr6">
               <td class="td1"><span> </span><a id='lblFax' class="lbl"></a></td>
               <td class="td2" colspan='3' ><input id="txtFax" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblMobile' class="lbl"></a></td>
               <td class="td4"><input id="txtMobile"   type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr7">
                <td class="td1"><span> </span><a id='lblAddr_fact' class="lbl"></a></td>
                <td class="td2"><input id="txtZip_fact" type="text" class="txt c1"/></td>
                <td  class="td3" colspan='4'><input id="txtAddr_fact"  type="text" class="txt c6"/></td> 
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblAddr_comp' class="lbl"></a></td>
                <td class="td2"><input id="txtZip_comp" type="text" class="txt c1"/></td>
                <td  class="td3" colspan='4' ><input id="txtAddr_comp"  type="text" class="txt c6"/></td> 
            </tr>
            <tr class="tr9">
                <td class="td1"><span> </span><a id='lblAddr_invo' class="lbl"></a></td>
                <td class="td2" ><input id="txtZip_invo" type="text" class="txt c1"/></td>
                <td  class="td3" colspan='4' ><input id="txtAddr_invo"  type="text" class="txt c6" /></td> 
            </tr>
            <tr class="tr10">
                <td class="td1"><span> </span><a id='lblAddr_home' class="lbl"></a></td>
                <td class="td2"><input id="txtZip_home" type="text" class="txt c1"/></td>
                <td  class="td3" colspan='4' ><input id="txtAddr_home"  type="text" class="txt c6"/></td> 
            </tr>
            <tr class="tr11">
                <td class="td1" ><a class="lbl">E-mail</a></td>
                <td class="td2" colspan='5' ><input id="txtEmail" class="txt c6"/></td> 
            </tr>
            <tr class="tr12">
               <td class="td1"><span> </span><a id="lblCredit" class="lbl btn"></a></td>
               <td class="td2"><input id="txtCredit" type="text" class="txt num c1" /></td>
               <td class="td3"><span> </span><a id="lblSales" class="lbl btn" ></a></td>
                <td class="td4"><input id="txtSalesno" type="text" class="txt c2"/>
                <input id="txtSales"    type="text" class="txt c3"/></td>
                <td class="td5"><span> </span><a id="lblCust"  class="lbl btn"></a></td>
                <td class="td6"><input id="txtGrpno" type="text" class="txt c2"/>
                <input id="txtGrpname"    type="text" class="txt c3"/></td>
            </tr>
            <tr class="tr13">
                <td class="td1"><span> </span><a id="lblInvest" class="lbl btn"></a></td>
                <td class="td2" colspan='5' ><input id="txtInvestdate"  type="text" class="txt c4"/><input id="txtInvestmemo"  type="text" class="txt c5"/></td> 
            </tr>
            <tr class="tr14">
                <td class="td1"><span> </span><a id='lblChkstatus' class="lbl"></a></td>
                <td class="td2" colspan='5' ><input id="txtChkstatus"  type="text" class="txt c6"/></td> 
            </tr>
            <tr class="tr15">
               <td class="td1"><span> </span><a id='lblChkdate' class="lbl"></a></td>
               <td class="td2"><input id="txtChkdate" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblStartn' class="lbl"></a></td>
               <td class="td4"><input id="txtStartn" type="text" class="txt num c1" /></td>
               <td class="td5"><span> </span><a id='lblUacc1' class="lbl"></a></td>
               <td class="td6"><input id="txtUacc1"    type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr16">
               <td class="td1"><span> </span><a id='lblDuedate' class="lbl"></a></td>
               <td class="td2"><input id="txtDuedate" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblGetdate' class="lbl"></a></td>
               <td class="td4"><input id="txtGetdate" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id='lblUacc2' class="lbl"></a></td>
               <td class="td6"><input id="txtUacc2" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr17">
               <td class="td1"><span> </span><a id='lblTrantype' class="lbl"></a></td>
               <td class="td2"><select id="cmbTrantype" class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblPay' class="lbl"></a></td>
               <td class="td4"><input id="txtPay" type="text" class="txt c3"/>
               <select id="combPay" class="txt c2" onchange='combPay_chg()' /> </td>
               <td class="td5"><span> </span><a id='lblUacc3' class="lbl"></a></td>
               <td class="td6"><input id="txtUacc3"  type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr18">
               <td class="td1"><span> </span><a id='lblBillmemo' class="lbl"></a></td>
               <td class="td2" colspan="5"><input id="txtBillmemo" type="text" class="txt c6"/></td>               
            </tr>
            <tr class="tr19">
               <td class="td1"><span> </span><a id='lblInvomemo' class="lbl"></a></td>
               <td class="td2" colspan="5"><input id="txtInvomemo" type="text" class="txt c6"/></td>               
            </tr>
            <tr class="tr20">
               <td class="td1"><span> </span><a id='lblIntroducer' class="lbl"></a></td>
               <td class="td2"><input id="txtIntroducer" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblBillday' class="lbl"></a></td>
               <td class="td4" colspan="3"><input id="txtBillday" type="text" class="txt c1"></td>               
            </tr>
            <tr class="tr21">
                <td class="td1"><span> </span><a id="lblBilltype" class="lbl"></a></td>
                <td class="ch2"><input id="chkIsboat" type="checkbox"/><a id="lblIsboat"></a></td>
                <td class="ch3"><input id="chkIsboatname" type="checkbox"/><a id="lblIsboatname"></a></td>
                <td class="ch4"><input id="chkIsship" type="checkbox"/><a id="lblIsship"></a></td>
                <td class="ch5"><input id="chkIsadd1" type="checkbox"/><a id="lblIsadd1"></a></td>
                <td class="ch6"><input id="chkIsadd2" type="checkbox"/><a id="lblIsadd2"></a></td>
            </tr>
            <tr class="tr22">
                <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
                <td class="td2" colspan='5' ><textarea id="txtMemo"  rows='5' cols='10' style="width:99%; height: 50px;"></textarea></td> 
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
