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
        var decbbm = ['price','pricepay'];
        var q_name="chgitem";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        aPop = new Array(['txtAcc1', 'lblAcc', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2',"acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno ]);
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
           q_cmbParse("cmbTypea", q_getPara('chgitem.typea'));
            fbbm[fbbm.length] = 'txtMemo'; 
        }

     /*   function pop(form, seq) {
            b_seq = (seq ? seq : '');
            b_pop = form;
            switch (form) {
                case 'sss': q_pop('txtSalesno', 'sss_b.aspx', 'sss', 'noa', 'namea', "60%", "650px", q_getMsg('popSss')); break;
                case 'sss': q_pop('txtGrpno', 'sss_b.aspx', 'sss', 'noa', 'comp', "60%", "650px", q_getMsg('popsss')); break;
                case 'conn': q_pop('txtNoa', "conn_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';;" + q_cur, 'conn', 'noa', 'namea', "60%", "650px", q_getMsg('popConn')); break;
            }
        }
*/
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

            q_box('chgitem_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
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
                bbsAssign();  /// ???B?? 
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
	#dmain{overflow:hidden;}
		 .dview{float:left;width:25%;}
		 .tview{margin:0;padding:2px;border:1px black double;border-spacing:0;font-size:medium;background-color:#FFFF66;color:blue;}
		 .tview td{padding:2px;text-align:center;border:1px black solid;}
		 .dbbm{float:left;width:73%;margin:-1px;border:1px black solid;border-radius:5px;}
		 .tbbm{padding:0px;border:1px white double;border-spacing:0;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
		 .tbbm tr{height:35px;}
		 
		 .td1, .td3, .td5, .td7{width: 11%; text-align: right;}
		 .td2, .td4, .td6, .td8{width: 14%;}
		 .tbbm tr td span{float:right;display:block;width:8px;height:10px;}
		 .tbbm tr td .lbl{float:right;color:blue;font-size:medium;}
		 .tbbm tr td .lbl.btn{color:#4297D7;font-weight:bolder;}
		 .tbbm tr td .lbl.btn:hover{color:#FF8F19;}
		 .tbbm tr td .txt.c1{width:100%;float:left;}
		 .tbbm tr td .txt.c2{width:94%;float:left;}
		 .tbbm tr td .txt.c3{width:47%;float:left;}
		 .tbbm tr td .txt.c4{width:53%;float:left;}
		 .tbbm tr td .txt.c5{width:35%;float:left;}
		 .tbbm tr td .txt.c6{width:64%;float:left;}
		 .tbbm tr td .txt.num{text-align:right;}
		 .tbbm tr td{margin:0px -1px;padding:0;}
		 .tbbm tr td input[type="text"]{border-width:1px;padding:0px;margin:-1px;}
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
                <td align="center" style="width:15%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewItem'></a></td>
                <td align="center" style="width:25%"><a id='vewPrice'></a></td>
                <td align="center" style="width:25%"><a id='vewPricepay'></a></td>                
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='item'>~item</td>
                   <td align="center" id='price'>~price</td>
                   <td align="center" id='pricepay'>~pricepay</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
           <tr>
               <td class="td1"><span> </span><a id='lblTypea' class="lbl"></a></td>
               <td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
               <td class="td3"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td4"><input id="txtNoa"  type="text"  class="txt c1"/></td>
               <td class="td5"></td>
               <td class="td6"></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblItem' class="lbl"></a></td>
               <td class="td2"><input id="txtItem" type="text"  class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblAcc" class="lbl btn" ></a></td>
               <td class="td4"><input id="txtAcc1" type="text"  class="txt c5"/>
               <input id="txtAcc2"  type="text"  class="txt c6"/></td>
               <td class="td5"></td>
               <td class="td6"></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblPrice' class="lbl"></a></td>
               <td class="td2"><input id="txtPrice" type="text"  class="txt num c1"/></td>
               <td class="td3"><span> </span><a id="lblPricepay" class="lbl"></a></td>
               <td class="td4"><input id="txtPricepay" type="text"  class="txt num c1"/></td>
               <td class="td5"><input id="chkIsfix" type="checkbox" style=" "/></td>
               <td class="td6"><span> </span><a id="vewIsfix"></a></td>
            </tr>
            <tr>
                <td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
                <td class="td2" colspan='6'><textarea id="txtMemo"  cols="10" rows="5"  style='width:98%; height: 127px;'></textarea></td>
            </tr>
            <tr>
               <td class="td1"></td>
               <td class="td2"></td>
               <td class="td3"></td>
               <td class="td4"></td>
               <td class="td5"><span> </span><a id="lblWorker" class="lbl"></a></td>
               <td class="td6"><input id="txtWorker" type="text" class="txt c2" /></td>
            </tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />
</body>
</html>
