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
        var q_name="vcct";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
		aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
		
		['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx']);
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
            mainForm(0); // 1=Last  0=Top
        }  

        function mainPost() { 
            bbmMask = [['txtDate1', r_picd],['txtDate2', r_picd],['txtLcdate', r_picd]];
        	q_mask(bbmMask);
        	 
        }        
        function q_boxClose( s2) {
            var ret; 
            switch (b_pop) {
            case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
                case q_name: if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
            q_box('vcct_s.aspx', q_name + '_s', "500px", "330px", q_getMsg( "popSeek"));
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
		function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//�����Ҧr��
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//�Τ@�s��
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//�褸�~
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//����~
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//��~
            }    </script>
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
            .txt.c6 {
                width: 50%;
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
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:38%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:40%"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 60%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
          <tr style="height:1px;">
			  <td> </td>
			  <td> </td>
			  <td> </td>
			  <td> </td>
			  <td> </td>
			  <td> </td>
			  <td class="tdZ"> </td>
		  </tr>
          <tr class="tr1">
               <td class="td1"><span> </span><a id="lblNoa" class="lbl"></a></td>
               <td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblDatea" class="lbl"></a></td>
               <td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblBilloflading" class="lbl"></a></td>
               <td class="td2"><input id="txtBilloflading" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblDeliveryorder" class="lbl"></a></td>
               <td class="td4"><input id="txtDeliveryorder" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id="lblNotify" class="lbl"></a></td>
               <td class="td6"><input id="txtNotify" type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr3">
               <td class="td1"><span> </span><a id="lblInvono" class="lbl"></a></td>
               <td class="td2"><input id="txtInvono" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblInvoiceno" class="lbl"></a></td>
               <td class="td4"><input id="txtInvoiceno" type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr4">
               <td class="td1"><span> </span><a id="lblInspection_comp" class="lbl"></a></td>
               <td class="td2" colspan="2"><input id="txtInspection_compno" type="text" class="txt c2"/>
               							   <input id="txtInspection_comp" type="text" class="txt c3"/></td>
               <td class="td4"><span> </span><a id="lblBcomp" class="lbl"></a></td>
               <td class="td5" colspan="2"><input id="txtBcompno" type="text" class="txt c2"/>
               							   <input id="txtBcomp" type="text" class="txt c3"/></td> 
            </tr>
            <tr class="tr5">
               <td class="td1"><span> </span><a id="lblForwarder" class="lbl"></a></td>
               <td class="td2"><input id="txtForwarder" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblCustoms" class="lbl"></a></td>
               <td class="td4"><input id="txtCustoms" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr6">
               <td class="td1"><span> </span><a id="lblEta" class="lbl"></a></td>
               <td class="td2"><input id="txtEta" type="text" class="txt c1"/></td>
               <td class="td4"><span> </span><a id="lblEtd" class="lbl"></a></td>
               <td class="td5"><input id="txtEtd" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr7">
               <td class="td1"><span> </span><a id="lblCaseno" class="lbl"></a></td>
               <td class="td2"><input id="txtCaseno" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblCasesize" class="lbl"></a></td>
               <td class="td4"><input id="txtCasesize" type="text" class="txt num c1"/></td>
               <td class="td5"><span> </span><a id="lblCaseyard" class="lbl"></a></td>
               <td class="td6"><input id="txtCaseyard" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr8">
               <td class="td1"><span> </span><a id="lblBillmemo" class="lbl"></a></td>
               <td class="td2" colspan="5"><input id="txtBillmemo" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr9">
               <td class="td1"><span> </span><a id="lblBdock" class="lbl"></a></td>
               <td class="td2"><input id="txtBdock" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblEdock" class="lbl"></a></td>
               <td class="td4"><input id="txtEdock" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id="lblGoal" class="lbl"></a></td>
               <td class="td6"><input id="txtGoal" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr10">
               <td class="td1"><span> </span><a id="lblBoatname" class="lbl"></a></td>
               <td class="td2"><input id="txtBoatname" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblShip" class="lbl"></a></td>
               <td class="td4" colspan="3"><input id="txtShip" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr11">
               <td class="td1"><span> </span><a id="lblSino" class="lbl"></a></td>
               <td class="td2"><input id="txtSino" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblOnboarddate" class="lbl"></a></td>
               <td class="td4"><input id="txtOnboarddate" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id="lblShippingdate" class="lbl"></a></td>
               <td class="td6"><input id="txtShippingdate" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr12">
               <td class="td1"><span> </span><a id="lblCldate" class="lbl"></a></td>
               <td class="td2"><input id="txtCldate" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblPallet" class="lbl"></a></td>
               <td class="td4"><input id="txtPallet" type="text" class="txt c1"/></td>
            </tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />
</body>
</html>
