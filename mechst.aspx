<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
    
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        var q_name="mech";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        aPop = new Array(['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']);
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
           q_mask(bbmMask);
           q_cmbParse("cmbTypea", q_getPara('mech.typea'));
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

            q_box('mech_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
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
    	<div id='dmain'>
            <!--#include file="../inc/toolbar.inc"-->
            <div class="dview" id="dview" style="float: left;  width:32%;"  >
                    <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
                        <tr>
                            <td align="center" style="width:5%"><a id='vewChk'></a></td>
                            <td align="center" style="width:5%"><a id='vewNoa'></a></td>
                            <td align="center" style="width:25%"><a id='vewMech'></a></td>
                            <td align="center" style="width:25%"><a id='vewTypea'></a></td>
                        </tr>
                        <tr>
                            <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                            <td align="center" id='noa'>~noa</td>
                            <td align="center" id='mech'>~mech</td>
                            <td align="center" id='typea=mech.typea'>~typea=mech.typea</td>
                        </tr>
                    </table>
                </div>
                <div class='dbbm' style="width: 68%;float:left">
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
                            <td class="td1"><span> </span><a id="lblMech" class="lbl"></a></td>
                            <td class="td2"><input id="txtMech"  type="text"  class="txt c1"/></td>
                            <td class="td3"></td>
                            <td class="td4"></td>
                            <td class="td5"></td>
                            <td class="td6"></td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblTypea" class="lbl"></a></td>
                            <td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
                            <td class="td3"></td>
                            <td class="td4"></td>
                            <td class="td5"></td>
                            <td class="td6"></td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblStore" class="lbl btn"></a></td>
                            <td class="td2"><input id="txtStoreno"  type="text"  class="txt c1"/></td>
                            <td class="td3" colspan="2" ><input id="txtStore"  type="text"  class="txt c1"/></td>
                            <td class="td5"></td>
                            <td class="td6"></td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblGen" class="lbl"></a></td>
                            <td class="td2"><input id="txtGen"  type="text"  class="txt c1 num"/></td>
                            <td align="left">M/Hr</td>
                            <td class="td4"></td>
                            <td class="td5"></td>
                            <td class="td6"></td>
                        </tr>
                        <tr>
                            <td class="td1"><span> </span><a id="lblDime" class="lbl"></a></td>
                            <td class="td2"><input id="txtDime1"  type="text"  class="txt num c1" /></td>
                            <td align="center"><a id="lblSymbol" style="font-weight: bolder;font-size: 20px;"></a></td>
                            <td class="td4"><input id="txtDime2"  type="text"  class="txt num c1" /></td>
                            <td class="td5" ></td>
                            <td class="td6"></td>
                        </tr>
                </table>
            </div>
            </div>
            <input id="q_sys" type="hidden" />
    </body>
</html>
