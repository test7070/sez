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
        var decbbm = ['credit','conrate1','conrate2','expire','rate','unpay','unpayus','total'];
        var q_name="lcbank";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
		aPop = new Array(['txtTggno', 'btnTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
           q_gt(q_name, q_content, q_sqlCount, 1)
            $('#txtNoa').focus
        });
 
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }

            q_mask(bbmMask);

            mainForm(0); // 1=Last  0=Top
           
        }  

        function mainPost() { 
        	 q_cmbParse("cmbCoin", q_getPara('sys.coin'));
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
            switch (b_pop) {                   case 'conn':

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

            q_box('sss_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
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
         .dview{float:left;width:25%;}
		 .tview{margin:0;padding:2px;border:1px black double;border-spacing:0;font-size:16px;background-color:#FFFF66;color:blue;}
		 .tview td{padding:2px;text-align:center;border:1px black solid;}
		 .dbbm{float:left;width:73%;margin:-1px;border:1px black solid;border-radius:5px;}
		 .tbbm{padding:0px;border:1px white double;border-spacing:0;border-collapse:collapse;font-size:16px;color:blue;background:#cad3ff;width:100%;}
		 .tbbm tr{height:35px;}
		 .td1, .td3, .td5, .td7, .td9{width: 10%;text-align: right;}
		 .td2, .td4, .td6, .td8, .tdA{width: 10%;}
		 .num{text-align: right;}
		 .tbbm tr td span{float:right;display:block;width:8px;height:10px;}
		 .tbbm tr td .txt.c1{width:100%;float:left;}
		 .tbbm tr td{margin:0px -1px;padding:0;}
		 .tbbm tr td input[type="text"]{border-width:1px;padding:0px;margin:-1px;}
		 .tbbm tr td input[type="button"]{font-size: medium;width: auto;float: right;}
		 .tbbm tr td select{border-width:1px;padding:0px;margin:-1px;width: 98%;}
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
                <td align="center" style="width:40%"><a id='vewNamea'></a></td>
                <td align="center" style="width:30%"><a id='vewCredit'></a></td>
                <td align="center" style="width:30%"><a id='vewDatea'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='namea'>~namea</td>
                   <td align="center" id='credit'>~credit</td>
                   <td align="center" id='datea'>~datea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 70%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
          <tr class="tr1">
               <td class="td1"><span> </span><a id="lblNoa"></a></td>
               <td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
               <td class="td3"><input id="txtNamea" type="text" class="txt c1" /></td>
               <td class="td4"></td>
               <td class="td5"><span> </span><a id="lblCredit"></a></td>
               <td class="td6"><input id="txtCredit" type="text" class="txt c1" /></td>
               <td class="td7"><span> </span><a id="lblDatea"></a></td>
               <td class="td8"><input id="txtCredit" type="text" class="txt c1" /></td>  
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblAccno"></a></td>
               <td class="td2"><input id="txtAccno" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblAccno2"></a></td>
               <td class="td4"><input id="txtAccno2" type="text" class="txt c1" /></td>
               <td class="td5"><span> </span><a id="lblAccno4"></a></td>
               <td class="td6"><input id="txtAccno4" type="text" class="txt c1" /></td>
               <td class="td7"><span> </span><a id="lblAccno6"></a></td>
               <td class="td8"><input id="txtAccno6" type="text" class="txt c1" /></td>
               <td class="td9"><span> </span><a id="lblAccno5"></a></td>
               <td class="tdA"><input id="txtAccno5" type="text" class="txt c1" /></td> 
            </tr>  
            <tr class="tr3">
               <td class="td1"><span> </span><a id="lblConrate2"></a></td>
               <td class="td2"><input id="txtConrate2" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblConrate1"></a></td>
               <td class="td4"><input id="txtConrate1" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id="lblExpire"></a></td>
               <td class="td6"><input id="txtExpire" type="text" class="txt c1"/></td>
               <td class="td7"><span> </span><a id="lblRate"></a></td>
               <td class="td8"><input id="txtRate" type="text" class="txt c1"/></td>
               <td class="td9"><span> </span><a id="lblCoin"></a></td>
               <td class="tdA"><input id="txtCoin" type="text" class="txt c1"/></td>  
            </tr>
            <tr class="tr4">
               <td class="td1"><span> </span><a id="lblAccno3"></a></td>
               <td class="td2"><input id="txtAccno3" type="text" class="txt c1"/></td>
               <td class="td3"><input id="txtAccname3" type="text" class="txt c1"/></td>
               <td class="td4"></td>
               <td class="td5"><span> </span><a id="lblUnpay"></a></td>
               <td class="td6"><input id="txtUnpay" type="text" class="txt c1"/></td>
               <td class="td7"><input id="txtUnpayus" type="text" class="txt c1"/></td>
               <td class="td8"></td>
               <td class="td9"><span> </span><a id="lblTotal"></a></td>
               <td class="tdA"><input id="txtTotal" type="text" class="txt c1"/></td>  
            </tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />
</body>
</html>
