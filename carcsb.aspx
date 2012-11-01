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
        var q_name="carcsb";
        var q_readonly = ['txtNoa'];
        var bbmNum = [['txtWeight',14, 3, 1],['txtInprice',14, 0, 1],['txtInmount',14, 3, 1],['txtInmoney',14, 0, 1],['txtOutprice',14, 0, 1],['txtOutmount',14, 3, 1],['txtOutmoney',14, 0, 1]];  // master 允許 key 小數  [物件,整數位數,小數位數, comma Display]
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
        
        aPop = new Array(['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'],
        							['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp,nick', 'txtCardealno,txtCardeal,txtCustnick', 'cardeal_b.aspx'],
        							['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver,cardealno,cardeal', 'txtCarno,txtDriverno,txtDriver,txtCardealno,txtCardeal', 'car2_b.aspx']);
        
        $(document).ready(function () {
            bbmKey = ['noa'];
            brwCount2 = 10
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
        	bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];
        	q_mask(bbmMask);
        	
        	$('#txtInprice').change(function () {
        		sum();
        	});
        	$('#txtInmount').change(function () {
        		sum();
        	});
        	$('#txtOutprice').change(function () {
        		sum();
        	});
        	$('#txtOutmount').change(function () {
        		sum();
        	});
        	$('#txtDiscount').change(function () {
        		sum();
        	});
        	
        }
		
		function sum() {
        	q_tr('txtInmoney' ,q_float('txtInprice')*q_float('txtInmount'));
        	q_tr('txtOutmoney' ,q_float('txtOutprice')*q_float('txtDiscount')*q_float('txtOutmount'));
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

            //q_box('chgcash_s.aspx', q_name + '_s', "500px", "340px", q_getMsg( "popSeek"));
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtDatea').focus();
        }

        function btnPrint() {
 		q_box('z_carcs.aspx' + "?;;;;" + r_accy, '', "800px", "600px", q_getMsg("popPrint"));
        }
        function btnOk() {
            var t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')] ]);
            if( t_err.length > 0) {
                alert(t_err);
                return;
            }

         	//$('#txtWorker').val(r_name);
            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);

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
                width: 25%;
                float: left;
            }
            .txt.c3 {
                width: 75%;
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
                            <td align="center" style="width:8%"><a id='vewCarno'></a></td>
                            <td align="center" style="width:8%"><a id='vewDriver'></a></td>
                            <td align="center" style="width:10%"><a id='vewAddr'></a></td>
                            <td align="center" style="width:8%"><a id='vewInmoney'></a></td>
                            <td align="center" style="width:15%"><a id='vewCardeal'></a></td>
                        </tr>
                        <tr>
                            <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                            <td align="center" id='datea'>~datea</td>
                            <td align="center" id='carno'>~carno</td>
                            <td align="center" id='driver'>~driver</td>
                            <td align="center" id='addr'>~addr</td>
                            <td align="center" id='inmoney,0,1'>~inmoney,0,1</td>
                            <td align="center" id='custnick'>~custnick</td>
                        </tr>
                    </table>
                </div>
                <div class='dbbm' style="float: left;">
                    <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
                        <tr class="tr1">
                            <td class="td1"><span> </span><a id="lblNoa" class="lbl"></a></td>
                            <td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
                            <td class="td3"><span> </span><a id="lblDatea" class="lbl"></a></td>
                            <td class="td4"><input id="txtDatea"  type="text"  class="txt c1"/></td>
                            <td class="td5"><span> </span><a id="lblMon" class="lbl"></a></td>
                            <td class="td6"><input id="txtMon"  type="text"  class="txt c1"/></td>
                            <td class="td7"></td>
                            <td class="td8"></td>
                        </tr>
                        <tr class="tr2">
                        	<td class="td1"><span> </span><a id="lblCarno" class="lbl btn"></a></td>
                            <td class="td2"><input id="txtCarno"  type="text"  class="txt c1"/></td>
                            <td class="td3"><span> </span><a id="lblDriver" class="lbl btn"></a></td>
                            <td class="td4" colspan='2'><input id="txtDriverno"  type="text"  class="txt c2"/><input id="txtDriver"  type="text"  class="txt c3"/></td>
                            
                        </tr>
                        <tr class="tr3">
                            <td class="td1"><span> </span><a id="lblAddr" class="lbl"></a></td>
                            <td class="td2"><input id="txtAddr"  type="text"  class="txt c1"/></td>
                            <td class="td3"><span> </span><a id="lblCardeal" class="lbl btn"></a><input id="txtCustnick"  type="hidden"  class="txt c1"/></td>
                            <td class="td4" colspan='2'><input id="txtCardealno"  type="text"  class="txt c2"/><input id="txtCardeal"  type="text"  class="txt c3"/></td>
                        </tr>
                        <tr class="tr3">
                        	<td class="td1"><span> </span><a id="lblWeight" class="lbl"></a></td>
                            <td class="td2"><input id="txtWeight"  type="text"  class="txt num c1"/></td>
                            <td class="td3"><span> </span><a id="lblInprice" class="lbl"></a></td>
                            <td class="td4"><input id="txtInprice"  type="text"  class="txt num c1"/></td>
                            <td class="td5"><span> </span><a id="lblInmount" class="lbl"></a></td>
                            <td class="td6"><input id="txtInmount"  type="text"  class="txt num c1"/></td>
                            <td class="td7"><span> </span><a id="lblInmoney" class="lbl"></a></td>
                            <td class="td8"><input id="txtInmoney"  type="text"  class="txt num c1"/></td>
                        </tr>
                        <tr class="tr4">
                        	<td class="td1"><span> </span><a id="lblDiscount" class="lbl"></a></td>
                            <td class="td2"><input id="txtDiscount"  type="text"  class="txt num c1"/></td>
                            <td class="td3"><span> </span><a id="lblOutprice" class="lbl"></a></td>
                            <td class="td4"><input id="txtOutprice"  type="text"  class="txt num c1"/></td>
                            <td class="td5"><span> </span><a id="lblOutmount" class="lbl"></a></td>
                            <td class="td6"><input id="txtOutmount"  type="text"  class="txt num c1"/></td>
                            <td class="td7"><span> </span><a id="lblOutmoney" class="lbl"></a></td>
                            <td class="td8"><input id="txtOutmoney"  type="text"  class="txt num c1"/></td> 
                        </tr>
                </table>
            </div>
         </div>  
            <input id="q_sys" type="hidden" />
    </body>
</html>
