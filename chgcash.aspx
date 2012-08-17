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
        var q_name="chgcash";
        var q_readonly = ['txtAcc2','txtChgitem','txtPart','txtOrg','txtNamea'];
        var bbmNum = [['txtMoney',12 , , 1],['txtOrg',12 , , 1]];  // master 允許 key 小數  [物件,整數位數,小數位數, comma Display]
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        
        aPop = new Array(['txtAcc1', 'lblAcc', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],['txtPartno', 'lblPart', 'Part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx'],['txtChgitemno', 'lblChgitem', 'chgitem', 'noa,item', 'txtChgitemno,txtChgitem', 'chgitem_b.aspx']);
        
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
            mainForm(0); // 1=Last  0=Top
        }  ///  end Main()


        function mainPost() {  
        	bbmMask = [['txtTime', '99:99']];
        	q_mask(bbmMask);
        	//------------------------------------------------
        	//零用金下拉式與TXT輸入
        	q_cmbParse("combDc", q_getPara('chgcash.typea'));
        	$('#combDc').attr('disabled', 'disabled');
        	$('#combDc').css('background', t_background2);
        	
        	$('#txtDc').change(function () {
                    var i = $('#txtDc').val();
                    $('#combDc').val(i);
                    if (i < '0' || i > '3') {
                        $('#txtDc').val('3');
                        $('#combDc').val('3');
                    }
            });
            $('#combDc').change(function () {
                    var i = parseInt($('#combDc').val(), 0);
                    $('#txtDc').val(i);
             });
        	//-------------------------------------------------
        	
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
				case 'chgcashorg':
                	var as = _q_appendData("chgcash", "", true);
                	$('#txtOrg').val(as[0].total);
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

            q_box('chgcash_s.aspx', q_name + '_s', "500px", "340px", q_getMsg( "popSeek"));
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
            $('#txtNoa').val(dec($('#pageAll').val())+1);
            
            //申請日期與時間
            var now =new Date();
			$('#txtDatea').val(q_date());
            $('#txtTime').val( now.getHours()+':'+now.getMinutes());
            
            //申請金額初始
             $('#txtMoney').val(0);
            
            //申請零用金類別初始
            $('#combDc').val(1);
            $('#combDc').removeAttr('disabled');
            $('#combDc').css('background', t_background);
            
            $('#txtDc').focus();
            $('#txtDc').val(1);
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
			
			$('#combDc').removeAttr('disabled');
            $('#combDc').css('background', t_background);

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
                 
			var i = parseInt($('#combDc').val(), 0);
         	var s1 = $('#combDc')[0][i - 1].innerText.substr(0, 1);
         
            if ( t_noa.length==0 )   /// ??????s??
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
            	
           	$('#combDc').val($('#txtDc').val());
            $('#combDc').attr('disabled', 'disabled');
            $('#combDc').css('background', t_background2);
            
            cashorg();
			
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
        
        //...........................................零用金餘額查詢
        function cashorg() {
			var t_where ="where=^^ partno='"+$('#txtPartno').val()+"'^^"; 
			q_gt('chgcashorg', t_where  , 0, 0, 0, "", r_accy);	
        }
        //..........................................................
        
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
                width: 10%;
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
                width: 98%;
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
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
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
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }

        </style>
    </head>
    <body>
            <!--#include file="../inc/toolbar.inc"-->
            <div id='dmain' >
                <div class="dview" id="dview">
                    <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66; width: 100%;">
                        <tr>
                            <td align="center" style="width:5%"><a id='vewChk'></a></td>
                            <td align="center" style="width:5%"><a id='vewDatea'></a></td>
                            <td align="center" style="width:25%"><a id='vewChgitem'></a></td>
                            <td align="center" style="width:15%"><a id='vewMoney'></a></td>
                            <td align="center" style="width:10%"><a id='vewNamea'></a></td>
                            <td align="center" style="width:15%"><a id='vewChecker'></a></td>
                            <td align="center" style="width:15%"><a id='vewApprv'></a></td>
                            <td align="center" style="width:15%"><a id='vewApprove'></a></td>
                        </tr>
                        <tr>
                            <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                            <td align="center" id='datea'>~datea</td>
                            <td align="center" id='chgitem'>~chgitem</td>
                            <td align="center" id='money'>~money</td>
                            <td align="center" id='namea'>~namea</td>
                            <td align="center" id='checker'>~checker</td>
                            <td align="center" id='apprv'>~apprv</td>
                            <td align="center" id='approve'>~approve</td>
                        </tr>
                    </table>
                </div>
                <div class='dbbm' style="float: left;">
                    <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
                        <tr>
                            <td class="td1"><span> </span><a id="lblNoa" class="lbl"></a></td>
                            <td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
                            <td class="td3"></td>
                            <td class="td4"></td>
                            <td class="td5"></td>
                            <td class="td6"></td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblDatea" class="lbl"></a></td>
                            <td class="td2"><input id="txtDatea"  type="text"  class="txt c1"/></td>
                            <td class="td3"><span> </span><a id="lblTime" class="lbl"></a></td>
                            <td class="td4"><input id="txtTime"  type="text"  class="txt c1"/></td>
                            <td class="td5"></td>
                            <td class="td6"></td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblChgitem" class="lbl btn"></a></td>
                            <td class="td2"><input id="txtChgitemno"  type="text"  class="txt c2"/>
                            <input id="txtChgitem"  type="text"  class="txt c3"/></td>
                            <td class="td3"><span> </span><a id="lblAcc" class="lbl btn" ></a></td>
                            <td class="td4"><input id="txtAcc1"  type="text"  class="txt c2"/>
                            <input id="txtAcc2"  type="text"  class="txt c3"/></td>                           
                            <td class="td5"></td>
                            <td class="td6"></td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblMoney" class="lbl"></a></td>
                            <td class="td2"><input id="txtMoney"  type="text" class="txt num c1" /></td>
                            <td class="td3"><span ></span><a id="lblDc" class="lbl"></a></td>
                            <td class="td4"><input id="txtDc"  type="text" maxlength="20" style="width:10%;">
                            	<select id="combDc" style="width:88%;font-size: medium;"></select>
                            </td>
                            <td class="td5"></td>
                            <td class="td6"></td>
                        </tr>
                        <tr>            
                            <td class="td1"><span> </span><a id="lblPart" class="lbl btn"></a></td>
                            <td class="td2"><input id="txtPartno"  type="text"  class="txt c2"/>
                            <input id="txtPart"  type="text"  class="txt c3"/></td>
                            <td class="td3"><span> </span><a id="lblOrg" class="lbl"></a></td>
                            <td class="td4"><input id="txtOrg"  type="text" class="txt num c1" /></td>
                            <td class="td5"></td>
                            <td class="td6"></td>                                                        
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblSss" class="lbl btn"></a></td>
                            <td class="td2"><input id="txtSssno"  type="text"  class="txt c2"/>
                            <input id="txtNamea" type="text"  class="txt c3"/></td>    
                            <td class="td3"><span> </span><a id="lblWorker" class="lbl"></a></td>
                            <td class="td4"><input id="txtWorker"  type="text" class="txt c1"/></td>
                            <td class="td5"></td>
                            <td class="td6"></td>  
                        </tr>
                        <tr>                          
                            <td class="td1"><span> </span><a id="lblChecker" class="lbl"></a></td>
                            <td class="td2"><input id="txtChecker"  type="text" class="txt c1" /></td>
                            <td class="td3"colspan="2"><input id="txtCheckmemo"  type="text" class="txt c1"/></td>
                            <td class="td5"></td>
                            <td class="td6"></td>       
                        </tr> 
                        <tr>
                            <td class="td1"><span> </span><a id="lblApprv" class="lbl"></a></td>
                            <td class="td2"><input id="txtApprv"  type="text" class="txt c1"/></td>  
                            <td class="td3" colspan="2"><input id="txtApprvmemo"  type="text" class="txt c1" /></td>
                            <td class="td5"></td>
                            <td class="td6"></td>            
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblApprove" class="lbl"></a></td>
                            <td class="td2"><input id="txtApprove"  type="text" class="txt c1" /></td>  
                            <td class="td3" colspan="2"><input id="txtApprovememo"  type="text" class="txt c1" /></td>
                            <td class="td5"></td>
                            <td class="td6"></td>            
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
                            <td class="td2" colspan="3"><textarea id="txtMemo" cols="10" rows="5" style='width:98%;height: 50px; '></textarea></td>
                        </tr>
                </table>
            </div>
         </div>  
            <input id="q_sys" type="hidden" />
    </body>
</html>
